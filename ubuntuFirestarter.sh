#!/bin/bash

# Ubuntu Firestarter Beveiligingsscript
# Dit script implementeert uitgebreide beveiligingsmaatregelen voor Ubuntu 24.02 servers
# Waarschuwing: Gebruik met voorzichtigheid en test grondig voordat u het in productie toepast

set -e

# Functie om commando's uit te voeren en de status te controleren
execute_command() {
    echo "Uitvoeren: $1"
    eval "$1"
    if [ $? -eq 0 ]; then
        echo "Succesvol uitgevoerd."
    else
        echo "Fout bij het uitvoeren van het commando. Script afgebroken."
        exit 1
    fi
}

# Functie om een back-up te maken van configuratiebestanden
backup_config() {
    if [ ! -f "$1.bak" ]; then
        echo "Back-up maken van $1"
        execute_command "sudo cp $1 $1.bak"
    else
        echo "Back-up van $1 bestaat al"
    fi
}

echo "Start van het Ubuntu Beveiligingsscript"

# Systeem bijwerken en upgraden
echo "Systeem bijwerken en upgraden"
execute_command "sudo apt update && sudo apt full-upgrade -y"

# Essentiële beveiligingspakketten installeren
echo "Installeren van essentiële beveiligingspakketten"
execute_command "sudo apt install -y ufw fail2ban libpam-google-authenticator auditd lynis rkhunter chkrootkit apparmor-utils aide"

# UFW (Uncomplicated Firewall) configureren
echo "UFW firewall configureren"
execute_command "sudo ufw default deny incoming"
execute_command "sudo ufw default allow outgoing"
execute_command "sudo ufw allow 22/tcp"  # SSH
execute_command "sudo ufw allow 80/tcp"  # HTTP
execute_command "sudo ufw allow 443/tcp" # HTTPS
execute_command "sudo ufw enable"

# SSH configureren
echo "SSH beveiligen"
backup_config "/etc/ssh/sshd_config"
execute_command "sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config"
execute_command "sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config"
execute_command "sudo sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config"
execute_command "sudo systemctl restart ssh"

# SSH-sleutels genereren en toevoegen
execute_command "ssh-keygen -t rsa -b 4096 -C 'jouwgebruiker@jouw_server_ip'"
execute_command "ssh-copy-id jouwgebruiker@jouw_server_ip"

# Beperk SSH-toegang tot alleen specifieke gebruikers
backup_config "/etc/ssh/sshd_config"
execute_command "echo 'AllowUsers jouwgebruiker' | sudo tee -a /etc/ssh/sshd_config"
execute_command "sudo systemctl restart ssh"

# Schakel wachtwoordauthenticatie uit (optioneel)
execute_command "sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config"
execute_command "sudo systemctl restart ssh"

# Verander de SSH-poort (optioneel)
new_ssh_port=7777
execute_command "sudo sed -i 's/Port 22/Port $new_ssh_port/' /etc/ssh/sshd_config"
execute_command "sudo ufw allow $new_ssh_port"
execute_command "sudo systemctl restart ssh"

# Voeg een beveiligde banner toe aan SSH-login
execute_command "echo 'Welkom bij Mijn Beveiligde Server' | sudo tee -a /etc/ssh/sshd_banner"
execute_command "sudo sed -i 's/#Banner none/Banner \/etc\/ssh\/sshd_banner/' /etc/ssh/sshd_config"
execute_command "sudo systemctl restart ssh"

# Fail2ban instellen
echo "Fail2ban configureren voor bescherming tegen brute-force aanvallen"
backup_config "/etc/fail2ban/jail.conf"
execute_command "sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local"
execute_command "sudo sed -i 's/bantime  = 10m/bantime  = 1h/' /etc/fail2ban/jail.local"
execute_command "sudo sed -i 's/findtime  = 10m/findtime  = 30m/' /etc/fail2ban/jail.local"
execute_command "sudo sed -i 's/maxretry = 5/maxretry = 3/' /etc/fail2ban/jail.local"
execute_command "sudo systemctl restart fail2ban"
execute_command "sudo systemctl enable fail2ban"

# AppArmor inschakelen en configureren
echo "AppArmor inschakelen en configureren voor verbetering van de systeembeveiliging"
execute_command "sudo aa-enforce /etc/apparmor.d/*"

# Auditd instellen
echo "Auditd instellen voor systeemauditing"
execute_command "sudo auditctl -e 1"
execute_command "sudo sed -i 's/^action_mail_acct =.*/action_mail_acct = root/' /etc/audit/auditd.conf"
execute_command "sudo systemctl restart auditd"

# Systeembrede beveiligingsinstellingen configureren
echo "Systeembrede beveiligingsinstellingen toepassen"
execute_command "sudo sysctl -w kernel.randomize_va_space=2"
execute_command "sudo sysctl -w net.ipv4.conf.all.rp_filter=1"
execute_command "sudo sysctl -w net.ipv4.conf.default.rp_filter=1"
execute_command "sudo sysctl -w net.ipv4.tcp_syncookies=1"
execute_command "sudo sysctl -w net.ipv4.ip_forward=0"
execute_command "sudo sysctl -w net.ipv6.conf.all.forwarding=0"
execute_command "sudo sysctl -w kernel.sysrq=0"
execute_command "sudo sysctl -w net.ipv4.conf.all.send_redirects=0"
execute_command "sudo sysctl -w net.ipv4.conf.default.send_redirects=0"
execute_command "sudo sysctl -w net.ipv4.conf.all.accept_redirects=0"
execute_command "sudo sysctl -w net.ipv4.conf.default.accept_redirects=0"
execute_command "sudo sysctl -p"

# /proc bestandssysteem verharden
echo "/proc bestandssysteem verharden"
execute_command "echo 'kernel.kptr_restrict = 2' | sudo tee -a /etc/sysctl.conf"
execute_command "echo 'kernel.dmesg_restrict = 1' | sudo tee -a /etc/sysctl.conf"
execute_command "sudo sysctl -p"

# Onnodige diensten uitschakelen
echo "Onnodige diensten uitschakelen"
execute_command "sudo systemctl disable avahi-daemon"
execute_command "sudo systemctl disable cups"
execute_command "sudo systemctl disable rpcbind"

# Onnodige pakketten verwijderen
echo "Onnodige pakketten verwijderen"
execute_command "sudo apt purge -y telnet rsh-client rsh-redone-client"

# ClamAV installeren en configureren
echo "ClamAV antivirussoftware installeren en configureren"
execute_command "sudo apt install -y clamav clamav-daemon"
execute_command "sudo freshclam"
execute_command "sudo systemctl start clamav-daemon"
execute_command "sudo systemctl enable clamav-daemon"
execute_command "sudo systemctl enable clamav-freshclam"
execute_command "sudo systemctl start clamav-freshclam"

# Automatische beveiligingsupdates instellen
echo "Automatische beveiligingsupdates instellen"
execute_command "sudo apt install -y unattended-upgrades"
execute_command "sudo dpkg-reconfigure -plow unattended-upgrades"

# Automatische beveiligingsscans configureren
echo "Dagelijkse beveiligingsscans instellen"
cat << EOF | sudo tee /etc/cron.daily/security-scan
#!/bin/bash
echo "Dagelijkse beveiligingsscan gestart op \$(date)" >> /var/log/security-scan.log
rkhunter --update
rkhunter --check --skip-keypress --report-warnings-only >> /var/log/security-scan.log
chkrootkit >> /var/log/security-scan.log
lynis audit system >> /var/log/security-scan.log
clamscan -r / --exclude-dir=/sys --exclude-dir=/proc --exclude-dir=/dev >> /var/log/security-scan.log
echo "Dagelijkse beveiligingsscan voltooid op \$(date)" >> /var/log/security-scan.log
EOF
execute_command "sudo chmod +x /etc/cron.daily/security-scan"

# Gebruikersaccountbeleid verharden
echo "Gebruikersaccountbeleid verharden"
backup_config "/etc/login.defs"
execute_command "sudo sed -i 's/PASS_MAX_DAYS\t99999/PASS_MAX_DAYS\t90/' /etc/login.defs"
execute_command "sudo sed -i 's/PASS_MIN_DAYS\t0/PASS_MIN_DAYS\t10/' /etc/login.defs"
execute_command "sudo sed -i 's/PASS_WARN_AGE\t7/PASS_WARN_AGE\t14/' /etc/login.defs"

# Procesaccounting inschakelen
echo "Procesaccounting inschakelen voor betere systeemauditing"
execute_command "sudo apt install -y acct"
execute_command "sudo systemctl enable acct"
execute_command "sudo systemctl start acct"

# NTP (Network Time Protocol) configureren
echo "NTP configureren om de systeemklok up-to-date te houden"
execute_command "sudo apt install -y ntp"
execute_command "sudo systemctl enable ntp"
execute_command "sudo systemctl start ntp"

echo "Alle beveiligingsmaatregelen zijn succesvol toegepast."
echo "Het systeem is nu beveiligd."

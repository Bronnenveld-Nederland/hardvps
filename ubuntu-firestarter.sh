#!/bin/bash

# Functie om een actie uit te voeren en de status te controleren
execute_command() {
    echo "Uitvoeren van: $1"
    eval "$1"
    if [ $? -eq 0 ]; then
        echo "Succesvol uitgevoerd."
    else
        echo "Fout bij het uitvoeren van het commando. Script wordt afgebroken."
        exit 1
    fi
}

# SSH-sleutels genereren en toevoegen
execute_command "ssh-keygen -t rsa -b 4096 -C 'jouwgebruiker@jouw_server_ip'"
execute_command "ssh-copy-id jouwgebruiker@jouw_server_ip"

# Beperk SSH-toegang tot alleen specifieke gebruikers
execute_command "sudo nano /etc/ssh/sshd_config"
execute_command "sudo systemctl restart ssh"

# Schakel wachtwoordauthenticatie uit (optioneel)
execute_command "sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config"
execute_command "sudo systemctl restart ssh"

# Verander de SSH-poort (optioneel)
new_ssh_port=7777
execute_command "sudo sed -i 's/Port 22/Port $new_ssh_port/' /etc/ssh/sshd_config"

# Voeg een beveiligde banner toe aan SSH-login
execute_command "echo 'Welkom bij Mijn Beveiligde Server' | sudo tee -a /etc/ssh/sshd_banner"
execute_command "sudo sed -i 's/#Banner none/Banner \/etc\/ssh\/sshd_banner/' /etc/ssh/sshd_config"
execute_command "sudo systemctl restart ssh"

# Beperk SSH-toegang tot specifieke IP-adressen (optioneel)
execute_command "sudo apt install ufw -y"
execute_command "sudo ufw default deny incoming"
execute_command "sudo ufw default allow outgoing"
execute_command "sudo ufw allow 21"  # FTP-verkeer
execute_command "sudo ufw allow 25"  # SMTP-verkeer
execute_command "sudo ufw allow 80"  # HTTP-verkeer
execute_command "sudo ufw allow 443"  # HTTPS-verkeer
execute_command "sudo ufw allow 578"  # SMTP-verkeer
execute_command "sudo ufw enable"
execute_command "sudo ufw allow $new_ssh_port"
execute_command "sudo systemctl restart ssh"

# Installeer fail2ban
execute_command "sudo apt install fail2ban -y"
execute_command "sudo sed -i 's/bantime = 10m/bantime = 1h/' /etc/fail2ban/jail.conf"
execute_command "sudo systemctl restart fail2ban"
execute_command "sudo systemctl enable fail2ban"

# Implementeer een Web Application Firewall (WAF) (optioneel)
execute_command "sudo apt install apache2 libapache2-modsecurity -y"

# Gebruik beveiligde verbindingen (HTTPS)
execute_command "sudo apt install certbot -y"
execute_command "sudo certbot --apache"
execute_command "sudo systemctl restart apache2"

# Installeer en configureer een antivirusprogramma (optioneel)
execute_command "sudo apt install clamav -y"
execute_command "sudo freshclam"
execute_command "sudo clamscan -r /"

# Monitor en analyseer logbestanden (Logwatch)
execute_command "sudo apt install logwatch -y"

# Monitor en analyseer logbestanden (Arpwatch)
execute_command "sudo apt install arpwatch -y"

# Monitor en analyseer logbestanden (Metalog)
execute_command "sudo apt install metalog -y"

# Monitor en analyseer logbestanden (Rsyslog)
execute_command "sudo apt install rsyslog -y"

# Installeer een Intrusion Detection System (IDS)
execute_command "sudo apt install suricata -y"
execute_command "sudo systemctl start suricata"
execute_command "sudo systemctl enable suricata"

# Voer regelmatig beveiligingsaudits uit (Lynis)
execute_command "sudo apt install lynis -y"
execute_command "sudo lynis audit system"

# Beheer gebruikersrechten strikt
# (Voeg hier indien nodig extra maatregelen toe)

# Installeer en configureer Squid
execute_command "sudo apt update"
execute_command "sudo apt install squid -y"
execute_command "sudo cp /etc/squid/squid.conf /etc/squid/squid.conf.orig"
execute_command "sudo nano /etc/squid/squid.conf"
execute_command "sudo service squid restart"
execute_command "sudo systemctl restart squid"
execute_command "sudo service squid status"
execute_command "sudo systemctl status squid"
execute_command "sudo chmod 600 /etc/squid/squid.conf"
execute_command "ls -l /etc/squid/squid.conf"

# Voeg configuratie toe voor basic_ncsa_auth
execute_command "auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwd"
execute_command "auth_param basic children 5"
execute_command "auth_param basic realm Squid proxy-caching web server"
execute_command "auth_param basic credentialsttl 2 hours"
execute_command "auth_param basic casesensitive off"

# Voeg configuratie toe voor squid_ldap_auth
execute_command "auth_param basic program /usr/lib/squid/squid_ldap_auth -R -b 'dc=example,dc=com' -D 'cn=admin,dc=example,dc=com' -W /etc/squid/ldap_password"
execute_command "auth_param basic children 5"
execute_command "auth_param basic realm Squid proxy-caching web server"
execute_command "auth_param basic credentialsttl 2 hours"
execute_command "auth_param basic casesensitive off"
execute_command "sudo systemctl restart squid"

# Stel reply_body_max_size in
execute_command "reply_body_max_size [SIZE]"

# Schakel het weergeven van de HTTP-serverversie uit
execute_command "httpd_suppress_version_string on"

# Monitor en analyseer logbestanden (Logwatch)
execute_command "sudo chmod 700 /usr/bin/gcc"

# ... (voeg hier verdere stappen toe indien nodig)

# Installeer en configureer AIDE
execute_command "sudo apt-get install aide -y"
execute_command "sudo aideinit && sudo aide --check"
execute_command "sudo cp /etc/aide/aide.conf /etc/aide/aide.conf.bak"
execute_command "sudo crontab -e"
execute_command "0 0 * * 0 /usr/bin/aide --check"
execute_command "sudo aide --check --config /etc/aide/aide.conf"

# Installeer logwatch
execute_command "sudo apt install logwatch -y"
execute_command "sudo systemctl start logwatch"
execute_command "sudo systemctl enable logwatch"

# Installeer arpwatch
execute_command "sudo apt-get install arpwatch -y"
execute_command "sudo systemctl start arpwatch"
execute_command "sudo systemctl enable arpwatch"

# Installeer en configureer metalog
execute_command "sudo apt-get install metalog -y"
execute_command "sudo systemctl start metalog"
execute_command "sudo systemctl enable metalog"

# Installeer en configureer rsyslog
execute_command "sudo apt-get install rsyslog -y"
execute_command "sudo systemctl start rsyslog"
execute_command "sudo systemctl enable rsyslog"

# Controleer beveiliging voor systeemdiensten
execute_command "sudo systemd-analyze security <SERVICENAAM>"

# Installeer libpam-cracklib en stel vervaldatum in voor een gebruikersaccount
execute_command "sudo apt install libpam-cracklib -y"
execute_command "sudo chage -E YYYY-MM-DD <gebruikersnaam>"

# Bewerk het configuratiebestand
execute_command "sudo nano /etc/login.defs"
execute_command "PASS_MIN_DAYS 7"

# ... (voeg hier verdere stappen toe indien nodig)

# Installeer Suricata en voer basisconfiguratie uit
execute_command "sudo apt install suricata -y"
execute_command "sudo systemctl start suricata"
execute_command "sudo systemctl enable suricata"
execute_command "sudo less /var/log/suricata/fast.log"
execute_command "sudo nano /etc/suricata/suricata.yaml"
execute_command "sudo journalctl -xe | grep suricata"
execute_command "sudo suricata -c /etc/suricata/suricata.yaml"
execute_command "ls -l /etc/suricata/suricata.yaml"
execute_command "ip link show"
execute_command "sudo nano /etc/suricata/suricata.yaml"
# Wijzig de regel met de interface in:
# - interface: eno1
execute_command "sudo ifdown eth0"
execute_command "sudo ifup eth0"

# ... (voeg hier verdere stappen toe indien nodig)

# Voer regelmatig beveiligingsaudits uit (Lynis)
execute_command "sudo apt install lynis -y"
execute_command "sudo lynis audit system"

# Beheer gebruikersrechten strikt
# Beperk de gebruikersrechten tot het noodzakelijke niveau

# Controleer op beschikbare beveiligingsupdates
execute_command "sudo systemd-analyze security <SERVICE>"
execute_command "sudo apt update && sudo apt upgrade -y"
execute_command "sudo apt-get purge \$(dpkg -l | awk '/^rc/ { print $2 }')"

# Pas specifieke permissies aan
execute_command "sudo chmod -R 700 /usr/bin/gcc"
execute_command "sudo chmod 700 /usr/bin/g++"

# Schakel bepaalde kernel- en systeemfuncties in
execute_command "sudo sysctl -w dev.tty.ldisc_autoload=0"
execute_command "sudo sysctl -w fs.protected_fifos=2"
execute_command "sudo sysctl -w fs.protected_regular=2"
execute_command "sudo sysctl -w fs.suid_dumpable=0"
execute_command "sudo sysctl -w kernel.kptr_restrict=2"
execute_command "sudo sysctl -w kernel.modules_disabled=1"
execute_command "sudo sysctl -w kernel.perf_event_paranoid=3"
execute_command "sudo sysctl -w kernel.sysrq=0"
execute_command "sudo sysctl -w kernel.unprivileged_bpf_disabled=1"
execute_command "sudo sysctl -w net.core.bpf_jit_harden=2"
execute_command "sudo sysctl -w net.ipv4.conf.all.log_martians=1"
execute_command "sudo sysctl -w net.ipv4.conf.all.send_redirects=0"
execute_command "sudo sysctl -w net.ipv4.conf.default.log_martians=1"

# Controleer op beschikbare beveiligingsupdates
execute_command "sudo apt update && sudo apt upgrade -y"

echo "Beveiligingsscript succesvol uitgevoerd."

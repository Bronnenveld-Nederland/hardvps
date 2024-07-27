# Ubuntu Firestarter Ultimate

### Een eenvoudige beveiligingsscript voor het verharden van een Ubuntu-server

Dit Bash-script automatiseert essentiële beveiligingsstappen voor het verbeteren van de beveiliging op een Ubuntu-server. Het voert taken uit zoals het genereren van SSH-sleutels, het uitschakelen van wachtwoordauthenticatie, het wijzigen van de SSH-poort, het installeren van fail2ban, en andere maatregelen om de server te beschermen tegen veelvoorkomende bedreigingen.

## Gebruik

1. Kloon de repository naar je Ubuntu-server met het volgende commando:
   ```bash
   git clone https://github.com/Bronnenveld/ubuntu-firestarter.git
   ```

2. Navigeer naar de map:
   ```bash
   cd ubuntu-firestarter
   ```

3. Maak het script uitvoerbaar:
   ```bash
   chmod +x ubuntu-firestarter.sh
   ```

4. Voer het script uit:
   ```bash
   ./ubuntu-firestarter.sh
   ```

## Belangrijke Opmerkingen

- Begrijp de taken in het script voordat je het uitvoert.
- Zorg ervoor dat je een back-up hebt voordat je het script uitvoert.
- Pas het script aan op basis van je specifieke configuratie en vereisten.

## Inbegrepen Beveiligingsstappen

- Genereren en toevoegen van SSH-sleutels
- Beperken van SSH-toegang tot specifieke gebruikers
- Uitschakelen van wachtwoordauthenticatie (optioneel)
- Wijzigen van de SSH-poort (optioneel)
- Toevoegen van een beveiligde banner aan SSH-login
- Beperken van SSH-toegang tot specifieke IP-adressen (optioneel)
- Installatie van Fail2ban voor bescherming tegen brute force-aanvallen
- Implementatie van een Web Application Firewall (WAF) (optioneel)
- Gebruik van HTTPS met Certbot
- Installatie en configuratie van een antivirusprogramma (ClamAV) (optioneel)
- Monitoring en analyse van logbestanden met Logwatch, Arpwatch, Metalog en Rsyslog
- Installatie van een Intrusion Detection System (IDS) (Suricata)
- Regelmatige beveiligingsaudits met Lynis
- Strikt beheer van gebruikersrechten
- Controle op beschikbare beveiligingsupdates
- Aanpassen van specifieke permissies en inschakelen van bepaalde kernel- en systeemfuncties

## Aanvullende Instructies

- Voeg indien nodig extra maatregelen toe volgens de gedetailleerde commentaren in het script.
- Controleer regelmatig op beschikbare beveiligingsupdates en voer upgrades uit.
- Beheer gebruikersrechten strikt en beperk deze tot het noodzakelijke niveau.

## Doel

Dit script is ontworpen om je te helpen bij het automatiseren van veelvoorkomende beveiligingstaken, maar het is belangrijk om het aan te passen aan je specifieke behoeften en om ervoor te zorgen dat je begrijpt wat elk commando doet. Voer het script uit op een testomgeving voordat je het op een productieserver toepast.

## Overzicht

Ubuntu Firestarter Ultimate is een uitgebreid beveiligingsscript ontworpen om Ubuntu 24.04 servers te verharden en te beveiligen tegen een breed scala aan cyberdreigingen. Het script automatiseert de implementatie van best practices op het gebied van serverbeveiliging en biedt een solide basis voor een veilige productieomgeving.

## Functies

- **Systeemupdate en -upgrade:** Zorgt ervoor dat het systeem up-to-date is met de nieuwste beveiligingspatches.
- **Firewall-configuratie (UFW):** Configureert de Uncomplicated Firewall voor basisbescherming.
- **SSH-beveiliging:** Versterkt de SSH-configuratie om ongeautoriseerde toegang te voorkomen.
- **Fail2ban:** Beschermt tegen brute-force aanvallen.
- **AppArmor:** Activeert en configureert AppArmor voor verbeterde systeembeveiliging.
- **Auditd:** Stelt systeemauditing in voor betere monitoring.
- **Systeembrede beveiligingsinstellingen:** Past kernel- en netwerkbeveiligingsparameters aan.
- **Verwijdering van onnodige diensten en pakketten:** Vermindert het aanvalsoppervlak.
- **ClamAV:** Installeert en configureert antivirussoftware.
- **Automatische beveiligingsupdates:** Configureert onbeheerde upgrades voor kritieke updates.
- **Dagelijkse beveiligingsscans:** Stelt geautomatiseerde scans in met verschillende beveiligingstools.
- **Gebruikersaccountbeleid:** Versterkt wachtwoordbeleid en accountbeheer.
- **Procesaccounting:** Verbetert systeemauditing.
- **Logmonitoring:** Configureert Logwatch voor regelmatige loganalyse.
- **Web Application Firewall:** Installeert en configureert ModSecurity (indien Apache aanwezig is).
- **Twee-factor authenticatie:** Configureert Google Authenticator voor SSH.
- **AIDE:** Stelt Advanced Intrusion Detection Environment in voor bestandsintegriteitscontrole.
- **Kernel hardening:** Past aanvullende kernel-beveiligingsinstellingen toe.
- **IPv6-uitschakeling:** Optionele uitschakeling van IPv6 (indien niet in gebruik).
- **Sudo-beveiliging:** Versterkt sudo-configuratie voor verbeterde beveiliging.
- **Rootkit Hunter:** Installeert en configureert rkhunter voor rootkit-detectie.
- **Sterke wachtwoordvereisten:** Configureert libpam-pwquality voor robuust wachtwoordbeleid.

## Installatie en Gebruik

1. Download het script:
   ```bash
   wget https://raw.githubusercontent.com/your-repo/ubuntu-firestarter-ultimate.sh
   ```

2. Maak het script uitvoerbaar:
   ```bash
   chmod +x ubuntu-firestarter-ultimate.sh
   ```

3. Voer het script uit met sudo-rechten:
   ```bash
   sudo ./ubuntu-firestarter-ultimate.sh
   ```

4. Volg de instructies op het scherm en beantwoord eventuele vragen tijdens de uitvoering.

5. Na voltooiing van het script, start u het systeem opnieuw op:
   ```bash
   sudo reboot
   ```

## Belangrijke Opmerkingen

- Lees en begrijp het volledige script voordat u het uitvoert.
- Test het script eerst in een niet-productieomgeving.
- Maak een back-up van uw systeem voordat u het script uitvoert.
- Sommige instellingen kunnen aangepast moeten worden aan uw specifieke behoeften.
- Na het uitvoeren van het script, controleer de logbestanden en systeemstatus om er zeker van te zijn dat alles correct werkt.
- Stel Google Authenticator in voor elke gebruiker die SSH-toegang nodig heeft.

## Aanpassingen

U kunt het script aanpassen aan uw specifieke behoeften door de volgende secties te bewerken:

- **UFW-regels:** Pas de firewall-regels aan in de "UFW configureren" sectie.
- **SSH-instellingen:** Wijzig de SSH-configuratie in de "SSH beveiligen" sectie.
- **Fail2ban-instellingen:** Pas de Fail2ban-parameters aan in de "Fail2ban instellen" sectie.
- **Systeeminstellingen:** Bewerk de sysctl-parameters in de "Systeembrede beveiligingsinstellingen configureren" sectie.
- **Automatische updates:** Pas de instellingen voor onbeheerde upgrades aan indien nodig.
- **Wachtwoordbeleid:** Wijzig de wachtwoordvereisten in de "Gebruikersaccountbeleid verharden" en "Sterke wachtwoordvereisten configureren" secties.

## Logbestanden en Monitoring

Na het uitvoeren van het script, controleer de volgende logbestanden voor meer informatie:

- `/var/log/security-scan.log:` Resultaten van dagelijkse beveiligingsscans
- `/var/log/sudo.log:` Sudo-gebruikslogboek
- `/var/log/auth.log:` Authenticatie-gerelateerde gebeurtenissen
- `/var/log/audit/audit.log:` Systeemauditlogboek
- `/var/log/rkhunter.log:` Rootkit Hunter-scanresultaten

## Onderhoud en Updates

- Voer regelmatig `sudo apt update && sudo apt upgrade` uit om het systeem up-to-date te houden.
- Controleer periodiek de logbestanden op ongebruikelijke activiteiten.
- Voer handmatige beveiligingsscans uit met tools zoals Lynis, rkhunter en ClamAV.
- Houd de configuratie van alle beveiligingstools bij en pas deze indien nodig aan.

## Bijdragen

Bijdragen aan dit project zijn welkom. U kunt als volgt bijdragen:

1. Fork de repository.
2. Maak een nieuwe branch:
   ```bash
   git checkout -b feature/AmazingFeature
   ```
3. Commit uw wijzigingen:
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```
4. Push naar de branch:
   ```bash
   git push origin feature/AmazingFeature
   ```
5. Open een Pull Request.

## Licentie

Dit project is gelicentieerd onder de MIT-licentie. Zie het LICENSE-bestand voor details.

## Contact

Voor vragen of ondersteuning, neem contact op.

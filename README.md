# UBUNTU FIRESTARTER - EEN SIMPELE BEVEILIGINGSSCRIPT VOOR DE VERHARDENING VAN EEN UBUNTU-SERVER. 
Dit Bash-script automatiseert essentiële beveiligingsstappen voor het verbeteren van de beveiliging op een Ubuntu-server. Het script voert taken uit zoals het genereren van SSH-sleutels, het uitschakelen van wachtwoordauthenticatie, het wijzigen van de SSH-poort, het installeren van fail2ban, en andere maatregelen om de server te beschermen tegen veelvoorkomende bedreigingen.

# Gebruik
1. Kloon de repository naar je Ubuntu-server met de volgende commando:
  git clone https://github.com/Bronnenveld/ubuntu-firestarter.git
2. Navigeer naar de map:
  cd ubuntu-firestarter.git
3. Maak het script uitvoerbaar:
  chmod +x ubuntu-firestarter.git.sh   
4. Voer het script uit:
  ./ubuntu-firestarter.git.sh

# Belangrijke Opmerkingen:

  - Begrijp de taken in het script voordat je het uitvoert.
  - Zorg ervoor dat je een back-up hebt voordat je het script uitvoert.
  - Pas het script aan op basis van je specifieke configuratie en vereisten.

# Inbegrepen Beveiligingsstappen:

  - Genereren en toevoegen van SSH-sleutels.
  - Uitschakelen van wachtwoordauthenticatie.
  - Wijzigen van de SSH-poort.
  - Beperken van SSH-toegang tot specifieke IP-adressen.
  - Installatie van Fail2Ban.
  - Implementatie van een Web Application Firewall (WAF).
  - Installatie en configuratie van een antivirusprogramma.
  - Bescherming tegen Brute Force-aanvallen (fail2ban).
  - Beveiligde verbindingen (HTTPS) met Let's Encrypt.
  - Monitoring en analyse van logbestanden (Logwatch).
  - Installatie van een Intrusion Detection System (IDS) - Suricata.
  - Uitvoeren van regelmatige beveiligingsaudits met Lynis.

# Wat is het doel van deze script?

Dit script is ontworpen om je te helpen bij het automatiseren van veelvoorkomende beveiligingstaken, maar het is belangrijk om het aan te passen aan je specifieke behoeften en om ervoor te zorgen dat je begrijpt wat elk commando doet. Voer het script uit op een testomgeving voordat je het op een productieserver toepast.

# Auteursrechtelijke Mededeling:

© 2024 Bronnenveld

Toestemming wordt hierbij kosteloos verleend aan eenieder die een kopie van deze software en bijbehorende documentatiebestanden (de "Software") verkrijgt, om de Software zonder beperking te gebruiken, kopiëren, wijzigen, samenvoegen, publiceren, distribueren, sublicentiëren en/of verkopen, onder de volgende voorwaarden:

De bovenstaande auteursrechtverklaring en deze toestemmingsverklaring moeten in alle kopieën of substantiële delen van de Software worden opgenomen.

DE SOFTWARE WORDT GELEVERD "ZOALS HET IS," ZONDER ENIGE GARANTIE, UITDRUKKELIJK OF IMPLICIET, MET INBEGRIP VAN MAAR NIET BEPERKT TOT DE GARANTIES VAN VERKOOPBAARHEID, GESCHIKTHEID VOOR EEN BEPAALD DOEL EN NIET-INBREUK. IN GEEN GEVAL ZIJN DE AUTEURS OF HOUDERS VAN HET AUTEURSRECHT AANSPRAKELIJK VOOR ENIGE CLAIM, SCHADE OF ANDERE AANSPRAKELIJKHEID, HETZIJ IN EEN ACTIE VAN CONTRACT, ONRECHT OF ANDERSZINS, VOORTVLOEIEND UIT, OF IN VERBAND MET DE SOFTWARE OF HET GEBRUIK OF ANDERE DEALINGEN IN DE SOFTWARE.

#!/bin/bash
# Script pour configuration réseau sur Debian 12 par Axel Barrilliot.

# Pause pendant les prompts utilisateur.
pause() {
        echo "$1"
        sleep 2
}

# Demande à l'utilisateur s'il veut un backup de ses fichiers de configurations.
read -p "Veux-tu créer un backup des fichiers de configuration ? (oui/non): " creation_backup
if [ "$creation_backup" == "oui" ]; then
        # Défini le répertoire de backup.
        BACKUP_DIR="/root/backup"
        DATE=$(date +"%Y%m%d")

        # Création du répertoire s'il n'éxiste pas.
        mkdir -p "$BACKUP_DIR"

        # Définie les fichiers de configurations.
        NETWORK_CONF="/etc/network/interfaces"
        RESOLV_CONF="/etc/resolv.conf"

        # Creation des backups
        cp "$NETWORK_CONF" "$BACKUP_DIR/interfaces_$DATE.bak"
        cp "$RESOLV_CONF" "$BACKUP_DIR/resolv.conf_$DATE.bak"

        echo "Création des fichiers de backups dans $BACKUP_DIR."
else
        echo "Pas de création de backups ..."
fi

pause "Continuer vers la configuration réseau..."

# Demande à l'utilisateur s'il veut désactiver l'IPv6.
read -p "Veux-tu désactiver l'IPv6 ? (oui/non): " ipv6
if [ "$ipv6" == "oui" ]; then
    echo "Désactivation de l'IPv6..."

# Verifie si les lignes sont déjà présentes sans le fichier "sysctl.conf"
    if grep -q "net.ipv6.conf.all.disable_ipv6 = 1" /etc/sysctl.conf && \
       grep -q "net.ipv6.conf.default.disable_ipv6 = 1" /etc/sysctl.conf && \
       grep -q "net.ipv6.conf.lo.disable_ipv6 = 1" /etc/sysctl.conf; then
        echo "Les lignes pour désactiver l'IPv6 sont déjà présentes."
    else
    cat <<EOL > /etc/sysctl.conf

# Désactivation de l'IPv6.
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
EOL

        # Application des paramètres précédents à "sysctl.conf".
        sysctl -p
        echo "L'IPv6 a été désactivée..."
else
        echo "L'IPV6 ne sera pas désactivée..."
fi

pause "Continuer vers la configuration de l'interface..."

# Demande à l'utilisateur quelle configuration il veut pour son interface réseau.
read -p "Quelle adresse IP veux-tu ? (ex: 192.168.1.200): " ip_address
read -p "Quel masque de sous-réseau veux-tu ? (ex: 255.255.255.0): " netmask
read -p "Quelle passerelle par défaut veux-tu ? (ex: 192.168.1.1): " gateway

# Configuration de l'interface réseau.
echo "Configuration de l'interface réseau..."
cat <<EOL > /etc/network/interfaces

# Configuration loopback
auto lo
iface lo inet loopback

# Configuration eth0
allow-hotplug eth0
auto eth0
iface eth0 inet static
        address $ip_address
        netmask $netmask
        gateway $gateway
EOL

pause "Continuer vers la configuration du DNS..."


# Demande à l'utilisateur quelle configuration DNS il veut.
read -p "Quel DNS Principale veux-tu ? (ex: $gateway): " dns1
read -p "Quel DNS Auxiliaire veux-tu ? (ex: 1.1.1.1): " dns2

# Configuration du fichier "resolv.conf".
echo "Configuration du DNS..."
cat <<EOL > /etc/resolv.conf
# Configuration DNS.
nameserver $dns1
nameserver $dns2
EOL

# Redémarrage du service réseau.
echo "Redémarrage du service réseau..."
systemctl restart networking

read -p "Configuration Terminée..."

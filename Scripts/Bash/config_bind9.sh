# Script pour configurer automatiquement une zone DNS avec BIND9 par Axel Barrilliot.
#!/bin/bash

# Met à jour les paquets du système.
echo "Mise à jour des paquets..."
sudo apt-get update -y && sudo apt-get upgrade -y

# Installe Bind9
# bind9utils fournit des utilitaires, comme "named-checkconf" et "named-checkzone".
echo "Installation de Bind9..."
sudo apt-get install bind9 bind9utils bind9-doc -y

# Demande à l'utilisateur le nom de la zone et l'adresse IP du serveur.
read -p "Entrez le nom de la zone (E.g.: merguez.com): " ZONE_NAME
read -p "Entrez l'adresse IP du serveur DNS: " DNS_IP

# Sauvegarde les fichiers de configuration existants.
echo "Sauvegarde des fichiers de configuration actuels..."
sudo cp /etc/bind/named.conf.local /etc/bind/named.conf.local.bak
sudo cp /etc/bind/named.conf.options /etc/bind/named.conf.options.bak

# Configure la zone DNS.
echo "Configuration de la zone DNS..."

# Ajoute la configuration de la zone dans "named.conf.local". L'option "-a" ajoute à la fin du fichier sans supprimer le contenu existant.
cat <<EOL | sudo tee -a /etc/bind/named.conf.local

// Configurer la zone $ZONE_NAME
zone "$ZONE_NAME" {
    type master;
    file "/etc/bind/db.$ZONE_NAME";
};
EOL

# Crée le fichier de zone DNS.
sudo cp /etc/bind/db.local /etc/bind/db.$ZONE_NAME

# Ajoute des enregistrements supplémentaires.
cat <<EOL | sudo tee -a /etc/bind/db.$ZONE_NAME

; Enregistrements personnalisés
@   IN  NS  ns1.$ZONE_NAME.
ns1 IN  A   $DNS_IP
www IN  A   $DNS_IP
EOL

# Vérifie la configuration du fichier "named.conf.local".
echo "Vérification de la configuration Bind9..."
sudo named-checkconf /etc/bind/named.conf.local

# Vérifie la configuration de la zone.
echo "Vérification de la configuration de la zone DNS..."
sudo named-checkzone $ZONE_NAME /etc/bind/db.$ZONE_NAME

# Redémarre Bind9.
echo "Redémarrage de Bind9..."
sudo systemctl restart bind9

# Afficher le statut du service Bind9
echo "Vérification du statut de Bind9..."
sudo systemctl status bind9

read -p "La zone "$ZONE_NAME" a bien été configurée..."

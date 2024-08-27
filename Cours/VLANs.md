## Introduction aux VLANs

### Qu'est-ce qu'un VLAN?

Un **VLAN** (Virtual Local Area Network ou Réseau Local Virtuel) est une technologie utilisée pour segmenter un réseau physique en plusieurs réseaux logiques distincts. En d'autres termes, un VLAN permet de créer plusieurs réseaux séparés au sein d'une même infrastructure physique, en utilisant des équipements tels que des commutateurs (switches). Cela permet de regrouper des utilisateurs ou des appareils en fonction de critères spécifiques, tels que la fonction, le département, ou les besoins en sécurité, sans avoir besoin de créer des réseaux physiques distincts.

### Fonctionnement des VLANs

Dans un réseau traditionnel, tous les appareils connectés à un même commutateur appartiennent au même domaine de diffusion, ce qui signifie qu'un message envoyé en diffusion (broadcast) sera reçu par tous les appareils. Avec les VLANs, ce comportement est modifié. Un VLAN crée des sous-réseaux logiques où chaque VLAN est isolé des autres. Les messages en diffusion sont limités au VLAN auquel ils appartiennent, ce qui réduit le trafic inutile et améliore la sécurité.

Pour comprendre cela, imaginez un bureau avec trois départements : Administration, RH, et Technique. Sans VLAN, tous les employés de ces départements seraient sur le même réseau, ce qui pourrait poser des problèmes de sécurité et de gestion. Avec des VLANs, chaque département peut avoir son propre VLAN, assurant une meilleure isolation et un meilleur contrôle.

## Avantages des VLANs

Les VLANs apportent plusieurs avantages significatifs dans la gestion des réseaux informatiques. Voici les principaux :

- ### Sécurité optimisée

Un des avantages majeurs des VLANs est l'amélioration de la sécurité. En segmentant le réseau en plusieurs VLANs, les communications entre les différents groupes d'utilisateurs peuvent être strictement contrôlées. Par exemple, les données sensibles du département financier peuvent être isolées des autres départements, ce qui réduit le risque d'accès non autorisé ou de fuite de données. De plus, en cas d'attaque, l'impact peut être limité à un seul VLAN, sans affecter le reste du réseau.

- ### Coûts réduits

Les VLANs permettent de réduire les coûts en optimisant l'utilisation de l'infrastructure existante. Plutôt que d'acheter de nouveaux équipements pour créer des réseaux séparés, les VLANs utilisent les commutateurs et routeurs existants pour segmenter le réseau. Cela réduit le besoin d'investissements supplémentaires en matériel tout en offrant une flexibilité accrue dans la gestion du réseau.

- ### Meilleures performances

En divisant un réseau en VLANs, le trafic de diffusion est confiné à chaque VLAN spécifique, ce qui réduit la charge globale sur le réseau. Cela se traduit par une amélioration des performances, car le réseau n'est pas encombré par des messages inutiles. De plus, les VLANs permettent d'optimiser la bande passante en affectant des ressources spécifiques à certains VLANs en fonction des besoins.

- ### Domaines de diffusion plus petits

Les VLANs limitent la portée des domaines de diffusion à l'intérieur de chaque VLAN, ce qui signifie que les messages en diffusion ne sont envoyés qu'aux appareils appartenant au même VLAN. Cela réduit le nombre de messages en diffusion dans l'ensemble du réseau, diminuant ainsi les risques de congestion et améliorant l'efficacité du réseau.

- ### Facilité de gestion IT

Les VLANs simplifient la gestion du réseau en permettant aux administrateurs de regrouper les utilisateurs en fonction de leur rôle, leur département, ou leurs besoins en termes de sécurité. Par exemple, si un employé change de département, il suffit de le déplacer vers un autre VLAN sans avoir à changer son emplacement physique ou à reconfigurer le réseau. Cette flexibilité permet une gestion plus efficace et moins coûteuse.

## Types de VLANs

Il existe plusieurs types de VLANs, chacun ayant un rôle spécifique dans la gestion du réseau. Les trois types les plus courants sont :

- ### VLAN de données

Le **VLAN de données** est le type de VLAN le plus courant. Il est utilisé pour segmenter les utilisateurs ou les appareils en fonction de leurs besoins en termes de trafic de données. Par exemple, dans une entreprise, les ordinateurs de bureau des employés peuvent être placés dans un VLAN de données spécifique en fonction de leur département. Cela permet de contrôler et de sécuriser le flux de données entre les différents segments du réseau.

- ### VLAN Voix

Le **VLAN Voix** est conçu spécifiquement pour les communications vocales sur IP (VoIP). Le trafic voix a des exigences particulières, telles qu'une faible latence et une priorité élevée par rapport au trafic de données. En plaçant les téléphones IP et les équipements VoIP dans un VLAN dédié, il est possible d'optimiser la qualité des appels en réduisant les interférences et en garantissant que le trafic voix reçoit la priorité appropriée sur le réseau.

- ### VLAN Native

Le **VLAN Native** est un concept un peu différent. Il s'agit du VLAN par défaut auquel tout le trafic non étiqueté est attribué lorsqu'il traverse un lien trunk entre deux commutateurs. Dans la plupart des configurations, le VLAN Native est défini comme étant le VLAN 1, mais il est recommandé de changer cette valeur par défaut pour des raisons de sécurité. Le VLAN Native est utilisé pour le trafic qui n'a pas été explicitement assigné à un autre VLAN, et il est crucial de le sécuriser correctement pour éviter les attaques de type VLAN hopping, où un attaquant tente de sauter d'un VLAN à un autre.

## Mode Access (Untag)

Le **mode access** est utilisé pour connecter un appareil final, comme un ordinateur, une imprimante, ou un téléphone IP, à un commutateur dans un réseau VLAN. Dans ce mode, le port du commutateur est configuré pour appartenir à un seul VLAN spécifique. Tous les paquets Ethernet qui transitent par ce port ne sont pas étiquetés avec un identifiant de VLAN (VLAN ID), d'où le terme "untagged" (non étiqueté).

En pratique, lorsqu'un port est configuré en mode access, tout appareil connecté à ce port sera automatiquement associé au VLAN spécifié. Cela signifie que l'appareil n'a pas besoin de gérer la configuration des VLANs, et il fonctionnera comme s'il faisait partie d'un réseau local standard. Ce mode est idéal pour les appareils qui ne supportent pas la gestion des VLANs, ou dans des environnements où un seul VLAN est requis pour un appareil ou un groupe d'appareils.

> **Pour configurer un port en mode access sur un switch Cisco via Cisco Packet Tracer, voici les étapes à suivre :**
>
>```shell
> Switch(config)# interface fastethernet 0/1
> Switch(config-if)# switchport mode access
> Switch(config-if)# switchport access vlan 10
> Switch(config-if)# end
> ```
>
> Dans cet exemple, le port FastEthernet 0/1 est configuré en mode access et associé au VLAN 10. Tout appareil connecté à ce port sera > automatiquement membre du VLAN 10.

---

## Mode Trunk (Tag)

Le **mode trunk** est utilisé pour connecter des commutateurs entre eux ou pour relier un commutateur à un routeur. Contrairement au mode access, un port configuré en mode trunk peut transporter du trafic pour plusieurs VLANs. Les paquets Ethernet qui transitent par un port en mode trunk sont étiquetés avec un VLAN ID, ce qui permet au commutateur de savoir à quel VLAN chaque paquet appartient. C'est pourquoi ce mode est aussi appelé "tagged" (étiqueté).

Le mode trunk est essentiel pour les réseaux où plusieurs VLANs doivent être accessibles sur plusieurs commutateurs ou où un routeur doit interagir avec plusieurs VLANs. Les ports en mode trunk sont souvent utilisés sur les liens inter-switch (appelés "trunks"), où il est nécessaire de transporter le trafic de plusieurs VLANs sur un seul lien physique.

> **Pour configurer un port en mode trunk sur un switch Cisco via Cisco Packet Tracer, voici les étapes à suivre :**
>
> ```shell
> Switch(config)# interface fastethernet 0/24
> Switch(config-if)# switchport mode trunk
> Switch(config-if)# switchport trunk allowed vlan 10,20,30
> Switch(config-if)# switchport trunk native vlan 99
> Switch(config-if)# end
> ```
>
> Dans cet exemple, le port FastEthernet 0/24 est configuré en mode trunk. Ce port est capable de transporter le trafic des VLANs 10, > 20, et 30. De plus, le VLAN 99 est configuré comme le VLAN Native, ce qui signifie que tout trafic non étiqueté passant par ce port > sera associé au VLAN 99.

---

## Lexique du Cours

### VLAN ID

Le **VLAN ID** est un identifiant numérique unique (compris entre 1 et 4094) attribué à chaque VLAN dans un réseau. Il permet de différencier les différents VLANs au sein d'un même réseau, notamment sur les liens trunk où plusieurs VLANs partagent la même infrastructure physique.

### VLAN Native

Le **VLAN Native** est le VLAN par défaut utilisé sur un lien trunk pour le trafic non étiqueté. Il est important de sécuriser le VLAN Native pour éviter les vulnérabilités, comme les attaques de type VLAN hopping. Par défaut, le VLAN Native est le VLAN 1, mais il est recommandé de le changer pour améliorer la sécurité.

### Mode Access

Le **Mode Access** est un mode de configuration de port de commutateur où le port est associé à un seul VLAN et où tout le trafic qui passe par ce port est non étiqueté. Ce mode est utilisé pour connecter des appareils finaux qui ne gèrent qu'un seul VLAN.

### Mode Trunk

Le **Mode Trunk** est un mode de configuration de port de commutateur qui permet à un port de transporter du trafic pour plusieurs VLANs simultanément. Le trafic est étiqueté avec un VLAN ID pour identifier à quel VLAN il appartient. Ce mode est couramment utilisé pour les connexions entre commutateurs ou entre un commutateur et un routeur.

### Standard 802.1Q

Le **standard 802.1Q** est une norme définie par l'IEEE qui permet de gérer les VLANs sur un réseau Ethernet. Il spécifie le format des étiquettes (tags) insérées dans les trames Ethernet pour indiquer le VLAN ID associé à chaque trame. Ce standard est utilisé pour la configuration des ports en mode trunk, permettant ainsi de transporter plusieurs VLANs sur un même lien physique.

## Conclusion

Les VLANs sont essentiels pour segmenter et sécuriser les réseaux modernes, offrant une gestion efficace du trafic et des ressources. Le choix entre le mode access et le mode trunk dépend des besoins spécifiques du réseau, notamment en termes de segmentation et de distribution des données.
# SAE51 Projet 2

## Introduction

Dans ce projet, nous allons étudier des solutions gratuites pour collecter, centraliser et présenter les logs générés par des applications sur des serveurs. Les logs sont des fichiers qui contiennent des informations importantes sur le fonctionnement des applications, l’état du système, et le trafic réseau. Analyser ces logs nous aide à détecter des problèmes de performance, à corriger des erreurs, et à conserver des enregistrements des connexions utilisateurs pour des raisons légales.

Il existe de nombreuses solutions de gestion des logs aujourd'hui, avec des fonctionnalités variées pour répondre aux besoins des développeurs et des administrateurs système. Nous allons nous concentrer sur certains critères, comme la capacité à centraliser les logs provenant de plusieurs conteneurs ou machines, la facilité d'utilisation et d'installation, et les options de visualisation proposées par des tableaux de bord.

Dans un premier temps, nous allons faire un résumé des différentes solutions gratuites disponibles, en soulignant leurs caractéristiques principales, leurs communautés d'utilisateurs, ainsi que leurs avantages et inconvénients. Ensuite, nous allons créer un fichier Docker pour mettre en place un environnement simple de collecte de logs basé sur l'une de ces solutions. Ce projet sera réalisé en équipe, ce qui nous permettra de collaborer et d'apprendre ensemble, tout en respectant les exigences de documentation et de rendu sur la plateforme Universitice.

## Objectif de ce projet

L'objectif de ce projet est de se familiariser avec les solutions de collecte, de centralisation et de présentation des logs générés par des applications sur des serveurs. Nous souhaitons acquérir une compréhension approfondie des différentes options disponibles et évaluer leurs fonctionnalités pour déterminer laquelle est la plus adaptée à nos besoins.

En explorant ces solutions, nous allons :

1. **Analyser les fonctionnalités des outils de gestion des logs** : Nous identifierons les caractéristiques clés de chaque solution, notamment leur capacité à centraliser les logs provenant de plusieurs conteneurs ou machines.

2. **Évaluer la facilité d'utilisation et d'installation** : Nous voulons choisir une solution qui soit simple à mettre en place et à utiliser, même pour des utilisateurs débutants.

3. **Explorer les options de visualisation** : Les tableaux de bord et les outils de présentation des données sont essentiels pour une analyse efficace des logs. Nous étudierons les capacités de visualisation offertes par les différentes solutions.

4. **Mettre en œuvre une solution de collecte de logs** : À l'aide d'un fichier Docker, nous allons créer un environnement simple pour tester une des solutions choisies, ce qui nous permettra de mieux comprendre son fonctionnement.

5. **Collaborer en équipe** : Ce projet sera une occasion de travailler ensemble, de partager nos connaissances et de développer nos compétences en gestion des logs.

En résumé, ce projet a pour but d'acquérir des compétences pratiques dans la gestion des logs tout en favorisant la collaboration et l'apprentissage en équipe.


## Déroulement de la SAE & Problèmes rencontrés
L'objectif était de permettre la surveillance en temps réel des logs à partir de plusieurs machines ou conteneurs Docker, tout en utilisant des tableaux de bord interactifs pour visualiser ces données. L'approche a consisté à déployer ces composants via Docker et Docker Compose pour faciliter l'installation et la gestion.

Déroulement du Projet :

1. Configuration Initiale des Services :
Choix des outils : Pour ce projet, Loki a été choisi pour la centralisation et le stockage des logs, Promtail pour la collecte des logs à partir de différents environnements, et Grafana pour la visualisation et la gestion des tableaux de bord.
Mise en place de Docker Compose : Un fichier docker-compose.yaml a été créé pour déployer automatiquement Loki, Promtail et Grafana dans des conteneurs séparés. Ce fichier inclut les volumes nécessaires pour persister les données et monter les fichiers de configuration.

2. Problèmes Rencontrés :
Problèmes liés aux permissions
Problème : Dès le départ, des erreurs de permission ont été rencontrées, notamment dans les logs de Grafana et Loki, qui n'étaient pas capables d'écrire dans les répertoires spécifiés, tels que /var/lib/grafana pour Grafana, et les répertoires de stockage de Loki.
Résolution : Les permissions des dossiers locaux ont été ajustées en utilisant la commande chmod 777 pour permettre à Docker d'accéder et d'écrire dans ces répertoires. Cette solution a permis de résoudre les problèmes de droits d'accès pour Grafana et Loki, mais pourrait poser un problème de sécurité sur des environnements de production. Une solution plus propre serait d'ajuster les propriétaires des fichiers avec chown.

Problèmes de configuration avec Loki :
Problème : Loki n’a pas réussi à démarrer correctement en raison de configurations erronées dans le fichier loki-config.yaml. Les erreurs incluaient des champs mal configurés comme http, grpc, ou encore des périodes d'indexation inadéquates avec boltdb-shipper.
Résolution : Les fichiers de configuration ont été corrigés pour se conformer aux attentes de Loki, en particulier en ajustant la configuration du stockage, en spécifiant une période d'indexation de 24 heures, et en vérifiant la structure du fichier YAML.

Problèmes avec Promtail :
Problème : Promtail a rencontré des erreurs similaires concernant l'absence de fichier de configuration lors du montage des volumes, ainsi que des problèmes d'accès à certains chemins.
Résolution : La structure des volumes montés a été corrigée dans le fichier docker-compose.yaml, en s’assurant que le fichier promtail-config.yaml soit correctement monté dans le conteneur à l’emplacement attendu.

3. Problème de création de dossiers par Loki :
Problème : Une erreur persistait concernant la création du dossier WAL pour Loki, où le message "permission denied" apparaissait lors de la création du répertoire /wal.
Résolution : Les permissions du système de fichiers ont été ajustées pour permettre à Loki de créer les répertoires nécessaires. En modifiant les permissions des dossiers via chmod 777 et en vérifiant les montages de volumes, le problème a été résolu. Cependant, cela pourrait nécessiter une optimisation future avec des permissions plus restrictives pour des raisons de sécurité.

4. Problème d’incompatibilité de la configuration d'indexation :
Problème : L’erreur « invalid schema config: boltdb-shipper works best with 24h periodic index config » indiquait que la configuration d'indexation de Loki n'était pas conforme aux bonnes pratiques pour le stockage boltdb-shipper.
Résolution : La configuration a été modifiée pour s'aligner sur la recommandation d'une période d'indexation de 24 heures, en modifiant la section index dans le fichier loki-config.yaml.

5. Erreur de création des répertoires pour les chunks :
Problème : Loki a tenté de créer des répertoires pour stocker les chunks, mais a échoué en raison de permissions insuffisantes ou d'une mauvaise configuration des montages.
Résolution : Les montages des volumes ont été corrigés, et les permissions des répertoires locaux ont été modifiées pour permettre l'écriture dans les répertoires de stockage des chunks.

Conclusion :
Le projet a mis en lumière plusieurs aspects techniques clés concernant la configuration de systèmes de logs distribués, notamment l'importance des permissions et de la configuration correcte des volumes pour les services conteneurisés. Bien que des erreurs liées aux permissions et à la configuration des fichiers YAML aient ralenti l'implémentation, ces obstacles ont été surmontés grâce à des ajustements successifs.

Importance des permissions : La gestion des permissions sur les systèmes de fichiers sous Docker est cruciale, et l'utilisation de chmod 777, bien qu'efficace pour les tests locaux, n'est pas idéale en production.
Précision dans la configuration : Les fichiers YAML doivent être soigneusement rédigés et conformes aux spécifications des services sous peine de dysfonctionnements.
Utilisation des bonnes pratiques : L'utilisation de boltdb-shipper nécessite des périodes d'indexation de 24h pour assurer un bon fonctionnement, comme recommandé par Loki.
Améliorations Futures
Optimiser les permissions des répertoires en évitant d’utiliser des droits trop permissifs comme 777.
Automatiser la configuration des volumes et des permissions pour rendre l’installation reproductible sur d’autres machines sans ajustements manuels.
Tester l'intégration avec plusieurs sources de logs pour une centralisation plus étendue dans un environnement distribué.
Ce projet, bien que ponctué de problèmes techniques, a permis de mettre en place un système fonctionnel de collecte et de visualisation des logs avec Grafana, Loki et Promtail.

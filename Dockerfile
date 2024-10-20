# 1. Utilisation d'une image de base pour Grafana
FROM grafana/grafana:latest

# 2. Installer Loki et promtail pour la collecte des logs
# Promtail agit comme un agent pour collecter les logs et les envoyer à Loki
# Nous installons Promtail dans un fichier docker-compose

# Expose le port 3000 pour accéder à l'interface Grafana et 3100 pour loki
EXPOSE 3000
EXPOSE 3100

# Commande par défaut pour démarrer Grafana
CMD ["grafana-server", "--config=/etc/grafana/grafana.ini", "--homepath=/usr/share/grafana", "cfg:default.paths.logs=/var/log/grafana", "cfg:default.paths.data=/var/lib/grafana", "cfg:default.paths.plugins=/var/lib/grafana/plugins"]


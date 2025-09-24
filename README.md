[![Terraform](https://github.com/kopako/serpent-surge/actions/workflows/terraform.yaml/badge.svg)](https://github.com/kopako/serpent-surge/actions/workflows/terraform.yaml)
[![Ansible](https://github.com/kopako/serpent-surge/actions/workflows/ansible.yml/badge.svg)](https://github.com/kopako/serpent-surge/actions/workflows/ansible.yml)
# Quick start
Create your own `.env` file based on `.env.example`  
To run locally ```docker compose --profile dev -f docker/compose.yaml --env-file dev.env up```  
To run on production create your own `.env` file, and run:  
```docker compose -f docker/compose.yaml --env-file .env up```

|Env name|Example|Description|
|--------|-------|-----------|
|FRONTEND_IMAGE|nginx|Docker image for frontend, for production use 'jonasal/nginx-certbot:latest'|
|FRONTEND_CONF|../game/serpent-surge-main/nginx/game-dev.conf|Nginx configuration file|
|FRONTEND_PORT|80|PORT used by nginx config file, use 443 for prod|
|PUBLIC_DNS_NAME|localhost|MANDATORY field, used for certbot when 'jonasal/nginx-certbot:latest' used|
|CERTBOT_EMAIL|you@gmail.com|MANDATORY field when 'jonasal/nginx-certbot:latest' used|
|DHPARAM_SIZE|2048|Default for certbot|
|ELLIPTIC_CURVE|secp256r1|Default for certbot|
|RENEWAL_INTERVAL|8d|Default for certbot|
|RSA_KEY_SIZE|2048|Default for certbot|
|STAGING|0|Default for certbot|
|USE_ECDSA|1|Default for certbot|
|CERTBOT_AUTHENTICATOR|webroot|Default for certbot|
|CERTBOT_DNS_PROPAGATION_SECONDS|""|Default for certbot|
|DEBUG|0|Default for certbot|
|USE_LOCAL_CA|0|Default for certbot|
|DB_HOST|db|depends on docker compose service name|
|DB_USER|node_user|Used by db and node service|
|DB_PASSWORD|password|Used by db and node service|
|DB_NAME|serpent_surge_db|Used by db and node service|
@ECHO OFF

CLS
docker-compose up -d --build --force-recreate
docker-compose logs -f
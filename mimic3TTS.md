## create folders under 
```bash
mkdir -p /opt/mimic3/data
chown -R 1000:1000 /opt/mimic3/data
chmod -R 775 /opt/mimic3/data
```

## docker compose copy text under in to  docker-compose.yml
```bash
services:
  mimic3:
    container_name: mimic3
    image: mycroftai/mimic3
    restart: unless-stopped
    ports:
      - "8002:59125"
    volumes:
      - /opt/mimic3/data:/home/mimic3/.local/share/mimic3
    environment:
      - XDG_DATA_HOME=/home/mimic3/.local/share/mimic3
    user: "1000:1000"
    command: ["--voice", "fa/haaniye_low"]

```

## docker run 
```bash
  sudo docker run -d \
    --name mimic3 \
    -p 8002:59125 \
    -v /opt/mimic3/data:/home/mimic3/.local/share/mimic3 \
    -e XDG_DATA_HOME=/home/mimic3/.local/share/mimic3 \
    --user 1000:1000 \
    mycroftai/mimic3 \
    --voice fa/haaniye_low
```
## show log
```bash
docker logs -f mimic3
```
or 
```bash
docker compose logs 
```
#Permission denied exseption on write file
## docker user id export 
```bash
docker exec mimic3 id
```
## docker image export id 
```bash
docker image inspect mycroftai/mimic3 | grep -i user
```

docker container create -p 80:80 --name wpt-server wpt-server
docker container create --name wpt-agent-lan --env=SERVER_URL=http://wpt-server:80/work/ --env=LOCATION=LAN wpt-agent
docker container create --name wpt-agent-dsl --env=SERVER_URL=http://wpt-server:80/work/ --env=LOCATION=DSL wpt-agent
docker container create --name wpt-agent-mobile --env=SERVER_URL=http://wpt-server:80/work/ --env=LOCATION=Mobile wpt-agent

docker network connect wpt-backend wpt-server

docker network connect docker0 wpt-agent-mobile
docker network connect wpt-backend wpt-agent-lan
docker network connect wpt-backend wpt-agent-dsl
docker network connect wpt-backend wpt-agent-mobile

docker container start wpt-server
docker container start wpt-agent-lan
docker container start wpt-agent-dsl
docker container start wpt-agent-mobile

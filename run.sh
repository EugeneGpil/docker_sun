export DOCKERHOST=$(ifconfig | grep -A 1 docker0 | awk 'NR > 1 {print $2}')
docker-compose up --build --remove-orphans

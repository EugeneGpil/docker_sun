if command -v ifconfig &> /dev/null
then
    export DOCKERHOST=$(ifconfig | grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v 127.0.0.1 | awk '{ print $2 }' | cut -f2 -d: | head -n1)
else
    export DOCKERHOST=$(ipconfig | grep -E "IPv4 Address" | awk '{ print $14 }' | cut -f2 -d: | head -n1)
fi
cp gsuite-service-account.json php/
cp gsuite-service-account.json workspace/
docker-compose up --build

#/bin/bash

if [[ "$1" == "" ]]; then
  echo "Missing IP/hostname parameter!"
  echo "Usage: ./test-restapi-with-ab.sh IP"
  exit 1
fi

IP=$1
TIMES_ARG=$2
TIMES=${TIMES_ARG:-3}

CONCURRENCY=100
COUNT=1000000

curl http://$IP:8080/todos

for I in 1 .. $TIMES; do
  echo "-----------------------------------"
  ab -k -c $CONCURRENCY -n $COUNT http://$IP:8080/todos
done

#/bin/bash

if [[ "$1" == "" ]]; then
  echo "Missing IP/hostname parameter!"
  echo "Usage: ./test-restapi.sh IP"
  exit 1
fi

IP=$1
TIMES_ARG=$2
TIMES=${TIMES_ARG:-3}

THREADS=10 # Should be close to number of CPUs
CONCURRENCY=100
SECONDS=5
# For more info about the above look at following:
# - https://github.com/wg/wrk/issues/205
# - https://gist.github.com/omnibs/e5e72b31e6bd25caf39a
# - https://medium.com/@felipedutratine/intelligent-benchmark-with-wrk-163986c1587f

curl http://$IP:8080/todos

for I in 1 .. $TIMES; do
  echo "-----------------------------------"
  wrk -c $CONCURRENCY -t $THREADS -d 5s http://$IP:8080/todos
done

#/bin/bash

if [[ "$1" == "" ]]; then
  echo "Missing IP/hostname parameter!"
  echo "Usage: ./test-iper3.sh IP"
  exit 1
fi

IP=$1
TIMES_ARG=$2
TIMES=${TIMES_ARG:-3}

for I in 1 .. $TIMES; do
  echo "-----------------------------------"
  iperf3 -t 30 -c $IP
done

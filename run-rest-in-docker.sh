#/bin/bash

if [[ "$1" == "" ]]; then
  echo "Missing app name parameter!"
  echo "Usage: ./run-rest-in-docker.sh APP"
  exit 1
fi
APP=$1

case $2 in
  1)
    CPUS="0"
    echo "Running with 1 CPU .."
    ;;
  2)
    CPUS="0,1"
    echo "Running with 2 CPUs .."
    ;;
  4)
    CPUS="0,1,2,3"
    echo "Running with 4 CPUs .."
    ;;
  *)
    CPUS="0"
    echo "Running with 1 CPU .."
    ;;
esac

docker run --cpuset-cpus=$CPUS -p 8080:8080 uc/$APP-rest

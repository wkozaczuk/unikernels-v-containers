#/bin/bash

if [[ "$1" == "" ]]; then
  echo "Missing app name parameter!"
  echo "Usage: ./run-rest-in-OSv-on-FC.sh APP"
  exit 1
fi
APP=$1

case $2 in
  1)
    CPUS=1
    echo "Running with 1 CPU .."
    ;;
  2)
    CPUS=2
    echo "Running with 2 CPUs .."
    ;;
  4)
    CPUS=4
    echo "Running with 4 CPUs .."
    ;;
  *)
    CPUS=1
    echo "Running with 1 CPU .."
    ;;
esac

KERNEL_PATH="$HOME/.capstan/repository/mike/osv-loader/loader.elf"
IMAGE_PATH="$HOME/.capstan/repository/$APP-rest-osv/$APP-rest-osv.qemu"

THIS_DIR=$(dirname $0)
CMD=$(grep bootcmd $THIS_DIR/restapi/$APP-osv/meta/run.yaml | grep -o -P '\/.[^"]*')
echo $CMD

$HOME/projects/osv/scripts/firecracker.py -V -c $CPUS -n -k $KERNEL_PATH -i $IMAGE_PATH -m 256M -e "$CMD" -b virbr1

#/bin/bash

if [[ "$1" == "" ]]; then
  echo "Missing app name parameter!"
  echo "Usage: ./run-rest-in-OSv-on-QEMU.sh APP"
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
  8)
    CPUS=8
    echo "Running with 8 CPUs .."
    ;;
  *)
    CPUS=1
    echo "Running with 1 CPU .."
    ;;
esac

# Change bridge name to virbr0 to make OSv create tap NIC connected
# to internal networking
# To expose OSv IP outside of the host use virbr1 bridge which normally would
# have been setup using ./script/setup-external-bridge.sh
sudo capstan run -v -c $CPUS -n bridge -b virbr1 $APP-rest-osv

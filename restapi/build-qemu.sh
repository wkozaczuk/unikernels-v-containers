if [[ "$1" == "" ]]; then
  echo "Missing app name parameter!"
  echo "Usage: ./build-qemu.sh APP"
  exit 1
fi

APP=$1
THIS_PATH=$(dirname $0)
APP_PATH="${THIS_PATH}/${APP}-osv"

if [[ ! -d "$APP_PATH" || ! -f "$APP_PATH/build-app.sh" ]]; then
  echo "Could not find build app script: $$APP_PATH/build-app.sh !"
  exit 1
fi

echo "Building app $APP-osv .."
pushd $APP_PATH && ./build-app.sh && popd

APP_IMAGE="$APP-rest-osv"
echo "Building OSv qemu image $APP_IMAGE .."
pushd $APP_PATH && capstan package compose -v --fs rofs $APP_IMAGE && popd

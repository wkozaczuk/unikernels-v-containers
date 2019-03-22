if [[ "$1" == "" ]]; then
  echo "Missing app name parameter!"
  echo "Usage: ./build-docker.sh APP"
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

echo "Building docker image uc/$APP-rest .."
pushd $APP_PATH && docker build . -t uc/$APP-rest && popd

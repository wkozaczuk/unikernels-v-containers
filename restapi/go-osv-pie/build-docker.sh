THIS_PATH=$(dirname $0)
$THIS_PATH/build-app.sh

docker build $THIS_PATH -t uc/go-rest

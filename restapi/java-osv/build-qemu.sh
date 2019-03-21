THIS_PATH=$(dirname $0)
$THIS_PATH/build-app.sh

capstan package compose -v --fs rofs java-osv

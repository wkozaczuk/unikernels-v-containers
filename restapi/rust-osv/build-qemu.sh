THIS_PATH=$(dirname $0)
$THIS_PATH/build-app.sh

cp $THIS_PATH/target/release/libhttpserver.so $THIS_PATH
capstan package compose -v rust-osv

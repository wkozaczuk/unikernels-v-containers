chmod 777 /dev/kvm
capstan build -v -p qemu
cp $HOME/.capstan/repository/java-osv/java-osv.qemu ../unikernel/java-osv-rest.qemu
/home/tom/Downloads/osv/scripts/imgedit.py setargs ../unikernel/java-osv-rest.qemu "--ip=eth0,10.0.0.3,255.255.255.0 --defaultgw=10.0.0.1 --nameserver=10.0.0.1 /java.so -jar /hello.jar"
qemu-img convert -O vpc ../unikernel/java-osv-rest.qemu ../unikernel/java-osv-rest.vhd

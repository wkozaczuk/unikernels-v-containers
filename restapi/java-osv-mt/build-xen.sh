chmod 777 /dev/kvm
capstan build -v -p qemu
cp $HOME/.capstan/repository/java-osv-mt/java-osv-mt.qemu ../unikernel/java-osv-rest-mt.qemu
/home/tom/osv/scripts/imgedit.py setargs ../unikernel/java-osv-rest-mt.qemu "--ip=eth0,10.0.0.3,255.255.255.0 --defaultgw=10.0.0.1 --nameserver=10.0.0.1 /java.so -jar /hello.jar"
qemu-img convert -O vpc ../unikernel/java-osv-rest-mt.qemu ../unikernel/java-osv-rest-mt.vhd

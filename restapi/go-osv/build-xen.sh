chmod 777 /dev/kvm
capstan build -v -p qemu
cp $HOME/.capstan/repository/go-osv/go-osv.qemu ../unikernel/go-osv-rest.qemu
/home/tom/Downloads/osv/scripts/imgedit.py setargs ../unikernel/go-osv-rest.qemu "--ip=eth0,10.0.0.3,255.255.255.0 --defaultgw=10.0.0.1 --nameserver=10.0.0.1 /go.so /rest.so"
qemu-img convert -O vpc ../unikernel/go-osv-rest.qemu ../unikernel/go-osv-rest.vhd

chmod 777 /dev/kvm
capstan build -v -p qemu
cp $HOME/.capstan/repository/go-osv/go-osv.qemu ../unikernel/go-osv-wl.qemu
/home/tom/Downloads/osv/scripts/imgedit.py setargs ../unikernel/go-osv-wl.qemu "--ip=eth0,10.0.0.3,255.255.255.0 --defaultgw=10.0.0.1 --nameserver=10.0.0.1 /go.so /workload.so"
qemu-img convert -O vpc ../unikernel/go-osv-wl.qemu ../unikernel/go-osv-wl.vhd

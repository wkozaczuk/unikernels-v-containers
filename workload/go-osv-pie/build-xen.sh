chmod 777 /dev/kvm
capstan build -v -p qemu
cp $HOME/.capstan/repository/go-osv-pie/go-osv-pie.qemu ../unikernel/go-osv-pie-wl.qemu
/home/tom/Downloads/osv/scripts/imgedit.py setargs ../unikernel/go-osv-pie-wl.qemu "--ip=eth0,10.0.0.3,255.255.255.0 --defaultgw=10.0.0.1 --nameserver=10.0.0.1 ./workload"
qemu-img convert -O vpc ../unikernel/go-osv-pie-wl.qemu ../unikernel/go-osv-pie-wl.vhd

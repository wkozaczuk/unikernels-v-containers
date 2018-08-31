chmod 777 /dev/kvm
capstan build -v -p qemu
cp $HOME/.capstan/repository/python-osv-mt/python-osv-mt.qemu ../unikernel/python-osv-rest-mt.qemu
/home/tom/osv/scripts/imgedit.py setargs ../unikernel/python-osv-rest-mt.qemu "--ip=eth0,10.0.0.3,255.255.255.0 --defaultgw=10.0.0.1 --nameserver=10.0.0.1 /python /server.py"
qemu-img convert -O vpc ../unikernel/python-osv-rest-mt.qemu ../unikernel/python-osv-rest-mt.vhd

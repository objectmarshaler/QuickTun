intf=tun0
mtu=1432
server=192.168.1.100
net=10.0.0.1/8
ip addr add $net dev $intf
ip link set $intf mtu $mtu
ip link set $intf up


sudo ip route add $server dev eth0
ip route add   0/1 dev $intf
ip route add 128/1 dev $intf

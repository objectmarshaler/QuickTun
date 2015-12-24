intf=tun0
mtu=1432
server=10.32.193.94
net=10.0.0.1/8
ip addr add $net dev $intf
ip link set $intf mtu $mtu
ip link set $intf up

sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -s $net -o eth0 -j MASQUERADE
sudo iptables -A FORWARD -p tcp --syn -s $net -j TCPMSS --set-mss $mtu

sudo ip route add $server via $(ip route show 0/0 | sed -e 's/.* via \([^ ]*\).*/\1/')
ip route add   0/1 dev tun
ip route add 128/1 dev tun
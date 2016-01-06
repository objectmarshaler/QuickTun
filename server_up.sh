intf=tun2
mtu=1432
gw_intf=eth0
net=10.1.1.1/24
#ip addr add $net dev $intf
#ip link set $intf mtu $mtu
#ip link set $intf up

sysctl -w net.ipv4.ip_forward=1
if !(iptables-save -t nat | grep -q "$gw_intf (shadowvpn)"); then
  iptables -t nat -A POSTROUTING -o $gw_intf -m comment --comment "$gw_intf (shadowvpn)" -j MASQUERADE
fi
iptables -A FORWARD -i $gw_intf -o $intf -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i $intf -o $gw_intf -j ACCEPT


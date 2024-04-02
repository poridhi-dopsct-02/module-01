# Create two Namespaces and connect them using bridge

sudo ip netns add ns1
sudo ip netns add ns2

sudo ip link add veth1 type veth peer name veth1-peer
sudo ip link add veth2 type veth peer name veth2-peer

sudo ip link set veth1 netns ns1
sudo ip link set veth2 netns ns2

sudo ip netns exec ns1 ip addr add 10.0.0.10/24 dev veth1
sudo ip netns exec ns2 ip addr add 10.0.0.20/24 dev veth2

sudo ip netns exec ns1 ip link set veth1 up
sudo ip netns exec ns2 ip link set veth2 up

sudo ip link add name br0 type bridge

sudo ip link set veth1-peer master br0
sudo ip link set veth2-peer master br0

sudo ip link set br0 up

#to test connection, get to the ns1
sudo ip netns exec ns1 bash
#and ping ns1 using ns2's ip
ping 10.0.0.20
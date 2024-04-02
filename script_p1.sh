# Create two Namespaces and connect them using veth (vm)

sudo apt-get update -y #update packages

sudo apt install iproute2 -y #install ip package if missing

#create two namespaces
sudo ip netns add ns1
sudo ip netns add ns2

#veth cable with 2 interfaces
sudo ip link add veth1 type veth peer name veth2

#connect it with specefic namespaces
sudo ip link set veth1 netns ns1
sudo ip link set veth2 netns ns2

#add ip
sudo ip netns exec ns1 ip addr add 10.0.0.1/24 dev veth1
sudo ip netns exec ns2 ip addr add 10.0.0.2/24 dev veth2

#up/enable veth interfaces
sudo ip netns exec ns1 ip link set dev veth1 up
sudo ip netns exec ns2 ip link set dev veth2 up

#to test connection, get to the ns1
sudo ip netns exec ns1 bash
#and ping ns1 using ns2's ip
ping 10.0.0.2
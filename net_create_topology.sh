#comment if public is existing
#Create the external network:
#neutron net-create external-net --shared --router:external=True

#comment if public is existing
#Create the subnet for the external network:
#neutron subnet-create external-net --name external-subnet --allocation-pool start=172.24.4.101,end=172.24.4.200 --disable-dhcp --gateway 172.24.4.1 172.24.4.0/24

#Create the internal network:
neutron net-create internal-net1
neutron net-create internal-net2

#Create the subnet for the internal network:
neutron subnet-create internal-net1 --name internal-subnet1 --dns-nameserver 8.8.8.8 --gateway 192.168.0.1 192.168.0.0/24
neutron subnet-create internal-net2 --name internal-subnet2 --dns-nameserver 8.8.8.8 --gateway 192.168.20.1 192.168.20.0/24

#Create the router:
neutron router-create router_1
neutron router-create router_2

#Attach the router to the internal subnet:
neutron router-interface-add router_1 internal-subnet1
neutron router-interface-add router_2 internal-subnet2

#Attach the router to the external network by setting it as the gateway:
neutron router-gateway-set router_1 public
neutron router-gateway-set router_2 public

#create instance
NET_ID=$(neutron net-list | awk '/ internal-net1 / { print $2 }')
nova boot --flavor m1.tiny --image cirros-0.3.2-x86_64-uec --nic net-id=$NET_ID --security-group default instance1
nova boot --flavor m1.tiny --image cirros-0.3.2-x86_64-uec --nic net-id=$NET_ID --security-group default instance2

NET_ID=$(neutron net-list | awk '/ internal-net2 / { print $2 }')
nova boot --flavor m1.tiny --image cirros-0.3.2-x86_64-uec --nic net-id=$NET_ID --security-group default instance3
nova boot --flavor m1.tiny --image cirros-0.3.2-x86_64-uec --nic net-id=$NET_ID --security-group default instance4

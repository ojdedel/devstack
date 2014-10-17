
#delete net_topology using bash file

nova delete instance1
nova delete instance2
nova delete instance3
nova delete instance4


neutron router-interface-delete router_1 internal-subnet1
neutron router-interface-delete router_2 internal-subnet2
neutron router-gateway-clear router1
neutron router-gateway-clear router2


router_id=$(neutron router-list | grep router_1 | awk '{print$2;}')
neutron router-delete $router_id

router_id=$(neutron router-list | grep router_2 | awk '{print$2;}')
neutron router-delete $router_id


#neutron router-delete router_1
#neutron router-delete router_2


neutron subnet-delete internal-subnet1
neutron subnet-delete internal-subnet2

NET_id=$(neutron net-list | grep internal-net1 | awk '{print$2}')
neutron net-delete $NET_id


NET_id=$(neutron net-list | grep internal-net2 | awk '{print$2}')
neutron net-delete $NET_id


#neutron net-delete internal-net1
#neutron net-delete internal-net2

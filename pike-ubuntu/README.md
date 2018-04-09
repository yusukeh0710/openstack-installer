## Installer for OpenStack Pike
Reference:

https://docs.openstack.org/install-guide/

### Setup for Controller Node with Docker
1. Install docker-ce
2. Configure openstack.ini
3. Build docker images for controller node
<pre>
$ ./build_controller.sh
</pre>
4. Run docker containers
<pre>
$ ./run_controller.sh
</pre>

### Setup for Compute Node
#### Direct Setup on bare metal server
1. Configure compute.ini
2. Install and setup each services about compute node.
<pre>
$ ./run_baremetal_compute.sh
</pre>

#### Setup with Docer
1. Install docker-ce
2. Configure compute.ini
3. Build docker images for compute node
<pre>
$ ./build_compute.sh
</pre>
4. Run compute container
<pre>
$ ./run_compute.sh
</pre>

# kubernetes

## How to create a kubernetes cluster of your own
Create a set of VMs to make up your cluster:
- One controller node
- One or more worker nodes
- I used Ubuntu 22.04.1

Clone the repo to each host (as a normal user is ok)
- `git clone https://github.com/drq883/kubernetes.git`

As `root`, cd to the cloned repo and run these commands on `all` nodes
- `./setup-containers.sh`
- `./setup-kubetools.sh`

As `root` on the controller node run:
`kubeadm init`
- Note the command that is tells you to run on the workers (copy into file/buffer)
  - i.e. `kubeadm join 192.168.7.178:6443 --token kk26ym.v4l3o1qk0afau25r \
	--discovery-token-ca-cert-hash <...>`
- `exit`

Run this as a regular user on the controller node - setup access to the cluster
- `mkdir -p $HOME/.kube`
- `sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config`
- `sudo chown $(id -u):$(id -g) $HOME/.kube/config`

Run this as a normal user on the controller node - setup Calico as the Network agent
- `./setup-calico.sh`
- run `kubectl get all -A` and wait until all `Running`

Run the `kubeadm join ...` command, you saved from step 4 on each worker node as `root`

After all these run to completion, you should have a working kubernetes
cluster. At this point you probably should add an ingress and nfs
persistentvolume.

From the controller node, as a normal user, you can run
- `./setup-ingress.sh`

From the nfs controller node, as a normal user, you should
- adjust the following values in nfs-pv.yaml:
  - spec.capacity.storage
  - spec.nfs.path
  - spec.nfs.server
- `kubectl create -f nfs-pv.yaml`




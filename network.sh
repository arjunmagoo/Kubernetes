#!/bin/bash

# List of nodes
NODES=("master" "master-m02" "master-m03")

# Loop over each node
for NODE in "${NODES[@]}"; do
  echo "Connecting to $NODE..."

  minikube ssh -p master -n "$NODE" <<EOF
    echo "Inside $NODE"
    ls /etc/cni/net.d/
    if [ -f /etc/cni/net.d/100-crio-bridge.conf.mk_disabled ]; then
      sudo mv /etc/cni/net.d/100-crio-bridge.conf.mk_disabled /etc/cni/net.d/100-crio-bridge.conf
      echo "Renamed the CNI config on $NODE"
    else
      echo "Nothing to rename on $NODE"
    fi
    ls /etc/cni/net.d/
EOF

  echo "Finished with $NODE"
  echo "-----------------------------"
done

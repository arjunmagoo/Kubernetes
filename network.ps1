# List of Minikube node names
$nodes = @("master", "master-m02", "master-m03")

foreach ($node in $nodes) {
    Write-Host "Connecting to $node..."

    # Combine commands into a single-line Bash string
    $cmd = "ls /etc/cni/net.d/ && if [ -f /etc/cni/net.d/100-crio-bridge.conf.mk_disabled ]; then sudo mv /etc/cni/net.d/100-crio-bridge.conf.mk_disabled /etc/cni/net.d/100-crio-bridge.conf && echo 'Renamed on $node'; else echo 'No file to rename on $node'; fi && ls /etc/cni/net.d/"

    # Execute the command via minikube ssh
    minikube ssh -p master -n $node -- $cmd

    Write-Host "Finished with $node`n-----------------------------`n"
}

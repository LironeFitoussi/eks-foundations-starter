# To Link Cluster to local kubectl config
aws eks update-kubeconfig --name eks-foundations

# To validate the cluster is linked to local kubectl config
kubectl config current-context

kubectl cluster-info
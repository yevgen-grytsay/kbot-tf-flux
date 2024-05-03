


```sh
$ terraform apply -replace=module.gke.local_file.kubeconfig -replace=module.kbot-tf-flux-boot
strap.flux_bootstrap_git.this -var-file="vars.tfvars"
```

## Security

> PAT secret
>
> Note that the GitHub PAT is stored in the cluster as a Kubernetes Secret named flux-system inside the flux-system namespace. If you want to avoid storing your PAT in the cluster, please see how to configure GitHub Deploy Keys.
>
> [Flux | Bootstrap | GitHub Personal Account](https://fluxcd.io/flux/installation/bootstrap/github/#github-personal-account)

## Setup
```sh
flux create source git kbot \
    --namespace=kbot-tf-flux \
    --url=https://github.com/yevgen-grytsay/kbot \
    --branch=main \
    --export > ./clusters/kbot/kbot-gr.yaml


read -s TELE_TOKEN
export TELE_TOKEN
TELE_TOKEN=$(echo $TELE_TOKEN | tr -d '\n' | base64)
# kubectl create secret generic kbot-helm-values \
#     --namespace=kbot-tf-flux \
#     --from-literal=secret.tokenValue="$TELE_TOKEN"

kubectl create secret generic kbot-helm-values \
    --namespace=kbot-tf-flux \
	--from-file=values.yaml=./helm-values.yaml
    
envsubst '$TELE_TOKEN' < helm-values.tpl.yaml > helm-values.yaml


flux create helmrelease kbot \
    --namespace=kbot-tf-flux \
    --interval=1m \
    --source=GitRepository/kbot \
    --chart=./helm \
    --values-from=Secret/kbot-helm-values \
    --export > ./clusters/kbot/kbot-hr.yaml
```

## Misc

```sh
gcloud compute machine-types list --filter="zone:(us-central1-c)" --sort-by="CPUS,MEMORY_GB"
```
```sh
flux create source git kbot \
    --namespace=kbot-tf-flux \
    --url=https://github.com/yevgen-grytsay/kbot \
    --branch=main \
    --export > ./clusters/kbot/kbot-gr.yaml


read -s TELE_TOKEN
export TELE_TOKEN
kubectl create secret generic kbot-helm-values --from-literal=secret.tokenValue="$TELE_TOKEN"


flux create helmrelease kbot \
    --namespace=kbot-tf-flux \
    --interval=1m \
    --source=GitRepository/kbot \
    --chart=./helm \
    --values-from=Secret/kbot-helm-values \
    --export > ./clusters/kbot/kbot-hr.yaml
```

## Resources
- [Terraform | Modules](https://developer.hashicorp.com/terraform/language/modules)
- [flux create source git](https://fluxcd.io/flux/cmd/flux_create_source_git/)
- [flux create helmrelease](https://fluxcd.io/flux/cmd/flux_create_helmrelease/)
- [Kubernetes | Managing Secrets using kubectl](https://kubernetes.io/docs/tasks/configmap-secret/managing-secret-using-kubectl/)


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
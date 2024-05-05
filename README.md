
## Components
- Google Cloud Provider (GCP)
- Terraform (flux, google)
- Flux (CRD: GitRepository, HelmRelease)
- Kubernetes (Google Kubernetes Engine)
- application repository (contains helm chart, code and CI/CD configuration) (github.com)
- infrastructure repository (contains terraform config and flux config) (github.com)
- CI/CD (GitHub Actions)
- Container Registry (ghcr.io)

## Flux
### Deployment
```mermaid
graph LR
User -- 1. push --> AppRepository

Flux -- 2. poll --> AppRepository
%%Terraform -- use --> InfraRepository
Flux -- 3. deploy --> App
%%Terraform -- apply --> Flux
%%Terraform -- save state --> GoogleCloudStorage

kubelet -- 4. download --> ContainerRegistry

subgraph GitHub
    AppRepository
    %%InfraRepository
    ContainerRegistry
end

subgraph KubernetesCluster
    Flux
    
    subgraph kubelet
        App
    end
end
```

### App Infrastructure Sync
```mermaid
graph LR
User -- 1. push --> InfraRepository

Flux -- 2. poll --> InfraRepository

Flux -- 3. reconcile --> AppNamespace

subgraph GitHub
    InfraRepository
end

subgraph KubernetesCluster
    Flux
    subgraph AppNamespace
        App
    end
end
```

## Setup
```sh
gcloud auth application-default login --project=PROJECT_ID

# OR
# gcloud auth application-default login
# gcloud config set project PROJECT_ID
```

```sh
read -s TELE_TOKEN_RAW
export TELE_TOKEN_RAW

TELE_TOKEN=$(echo $TELE_TOKEN_RAW | tr -d '\n' | base64)
export TELE_TOKEN

envsubst '$TELE_TOKEN' < helm-values.tpl.yaml > helm-values.yaml

kubectl create secret generic kbot-helm-values \
    --namespace=kbot-tf-flux \
	--from-file=values.yaml=./helm-values.yaml

terraform apply -var-file="vars.tfvars"

# gcloud container clusters get-credentials kbot --location=<location>
```

## Resources
- [Flux | Core Concepts](https://fluxcd.io/flux/concepts/)
- [flux create source git](https://fluxcd.io/flux/cmd/flux_create_source_git/)
- [flux create helmrelease](https://fluxcd.io/flux/cmd/flux_create_helmrelease/)
- [Kubernetes | Managing Secrets using kubectl](https://kubernetes.io/docs/tasks/configmap-secret/managing-secret-using-kubectl/)
- [Terraform | google | kubernetes-engine/auth](https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest/submodules/auth)
- [Terraform | google | Authentication](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#authentication)
- [Terraform | Modules](https://developer.hashicorp.com/terraform/language/modules)

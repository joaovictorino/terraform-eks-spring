# Terraform criando Elastic Kubernetes Service (EKS)

Pré-requisitos

- aws instalado
- Terraform instalado

Logar na AWS usando aws cli com o comando abaixo

```sh
aws configure sso
```

Inicializar o Terraform

```sh
terraform init
```

Executar o Terraform

```sh
terraform apply -auto-approve
```

Compilar imagem

```sh
docker build -t springapp .
```

Taggear a imagem com latest

```sh
docker tag springapp:latest 475154562783.dkr.ecr.us-east-1.amazonaws.com/springapp:latest
```

Login no repositorio de imagem do ECR (privado)

```sh
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 475154562783.dkr.ecr.us-east-1.amazonaws.com
```

Subir imagem

```sh
docker push 475154562783.dkr.ecr.us-east-1.amazonaws.com/springapp:latest
```

Obter credenciais do EKS

```sh
aws eks --region us-east-1 update-kubeconfig --name eks_demo
```

Instalar ElasticSearch

```sh
kubectl apply -f elastic/01-namespace.yaml
kubectl apply -f elastic/02-elastic.yaml
```

Subir configuração da aplicação

```sh
kubectl apply -f eks/1-config
kubectl apply -f eks/2-db
kubectl apply -f eks/3-app
```

#!/bin/bash

cd terraform

# iniciar terraform (primeira execução)
terraform init

# alterar ambiente
terraform apply -auto-approve

cd ..

# compilar imagem
docker build -t springapp .

# taggear a imagem com latest
docker tag springapp:latest 475154562783.dkr.ecr.us-east-1.amazonaws.com/springapp:latest

# login no repositorio de imagem do ECR (privado)
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 475154562783.dkr.ecr.us-east-1.amazonaws.com

# subir imagem
docker push 475154562783.dkr.ecr.us-east-1.amazonaws.com/springapp:latest

# obter credenciais do EKS
aws eks --region us-east-1 update-kubeconfig --name eks_demo

# subir configuração da aplicação
kubectl apply -f eks/1-config
kubectl apply -f eks/2-db
kubectl apply -f eks/3-app

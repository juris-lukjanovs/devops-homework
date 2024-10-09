# DevOps homework

### Prerequisite

Install minikube, on first start it will also prepare K8s.

```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube /usr/bin/
rm minikube

minikube version
```

Install terraform.

```
curl -Lo terraform.zip https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_amd64.zip
unzip terraform.zip
sudo mv terraform /usr/bin/
rm terraform.zip

terraform version
```

# DevOps homework

Execute this after init script to access SonarQube.

```
echo "$(minikube ip) sonarqube.local" | sudo tee -a /etc/hosts > /dev/null
```

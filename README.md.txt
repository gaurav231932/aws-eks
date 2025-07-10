# Terraform AWS EKS + Helm + Workloads

✅ Production-ready EKS cluster with ALB ingress, Prometheus, Grafana, CI/CD.

## Usage
cd envs/dev
terraform init
terraform apply

## Workloads
kubectl apply -f workloads/echo-app/

## Monitoring
- Grafana dashboards: dashboards/*.json
- Prometheus alert rules: alert-rules/*.yaml

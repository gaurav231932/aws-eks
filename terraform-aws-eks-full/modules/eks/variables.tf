variable "cluster_name" { type = string }
variable "cluster_role_arn" { type = string }
variable "subnet_ids" { type = list(string) }
variable "kubernetes_version" { type = string }
variable "tags" { type = map(string) }

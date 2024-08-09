# Infrastructure Setup with Terraform

This Terraform project provisions an EC2 instance with Docker Compose, an EKS cluster with ArgoCD, and provides a basic ArgoCD configuration.

## Prerequisites

**Terraform:** Install Terraform on your local machine. You can download it from the official website: <https://www.terraform.io/downloads.html>  

**AWS CLI:** Configure the AWS CLI with your credentials. Refer to the AWS documentation for instructions: <https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html>  

**kubectl:** Install kubectl to interact with your EKS cluster. You can find installation instructions here: <https://kubernetes.io/docs/tasks/tools/install-kubectl/>  

**Helm:** Install Helm to manage the ArgoCD deployment. See the Helm installation guide: <https://helm.sh/docs/intro/install/>  

## Usage

### Clone the repository

```Bash
git clone https://github.com/eaingaran/energy_web_assignment_solution.git
cd energy_web_assignment_solution/infrastructure
```

### Customize the configuration

Open the `.tf` files and replace the values with your actual AWS configuration values

### Initialize Terraform

```Bash
terraform init
```

### Apply the configuration

```Bash
terraform apply
```

``` txt
Review the planned changes and type yes to confirm.
```

### Access ArgoCD

Once the deployment is complete, Terraform will output the ArgoCD URL.

Retrieve the initial ArgoCD admin password:

```Bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

Log in to ArgoCD using the URL, username `admin`, and the retrieved password.

### Configure ArgoCD

Refer to the ArgoCD documentation for detailed instructions on configuring applications and managing Kubernetes resources:  <https://argo-cd.readthedocs.io/en/stable/user-guide/>  

### Cleanup

To destroy the infrastructure created by Terraform, run:

```Bash
terraform destroy
```

Important Notes:

Ensure you have the necessary AWS permissions to create the resources defined in the Terraform configuration.
This is an untested code, written only for the purpose of this assessment. This should not be applied without careful validation of the plan. This code may also fail to apply.  

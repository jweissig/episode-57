# Simple Terraform Examples

[#57 - Terraform (screencast)](https://sysadmincasts.com/episodes/57-terraform)

## Usage

Download & Unzip Terraform

```
curl https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_darwin_amd64.zip -o terraform_0.11.11_darwin_amd64.zip
unzip terraform_0.11.11_darwin_amd64.zip
```

Test Terraform

```
./terraform version
Terraform v0.11.11
```

git clone

## Example 1

```
cd example_1
../terraform init
../terraform plan
../terraform apply
check the aws console
edit the main.tf file and uncomment the tag
../terraform apply
../terraform show
check the aws console
../terraform destroy
```

## Example 2

```
cd example_2
../terraform init
../terraform plan
../terraform apply
../terraform show
check the aws console
../terraform destroy
```

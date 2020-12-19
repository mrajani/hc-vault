### Hashicorp Vault on AWS

#### Deploy Vault on AWS with Ansible.

##### This repo is cloned in user-data section of the Launch Template. When AWS autoscaling group powers up the EC2 instances, each instance installs Vault, checks if Vault is initialized.

##### The first server will run 'vault operator init', save the unseal and login keys, encrypt them with AWS KMS, and copy them to S3. From here the user can download them to local desktop and reverse the process.

##### DynamoDB is the backend for the Vault in this deployment. The environment is build with Terraform.

##### The certs are created and self-signed during installation of Vault.

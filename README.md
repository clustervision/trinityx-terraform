# TrinityX Terraform

The TrinityX Terraform project will used by the TrinityX project. It will create the infrastructure depending on the user selection.

## From TrinityX
To Create Infrastructure from TrinityX follow these steps:

- [ ] Git Clone [Trinityx Terraform Git Repository](https://github.com/clustervision/trinityx-terraform).
- [ ] Rename or create a new variable file in the Cloud Providers root directory from "terraform.tfvars.example" to "terraform.tfvars".
- [ ] Only create AWS, if need to install TrinityX on AWS, same applies for others. For Example:

- AWS Variable File [AWS](aws/terraform.tfvars.example)             
- Azure Variable File [Azure](azure/terraform.tfvars.example)
- GCP Variable File [GCP](gcp/terraform.tfvars.example)
- VSphere Variable File [VSphere](vsphere/terraform.tfvars.example)

- [ ] Run below commands to create the infrastructure.

```
cd trinityx-terraform/{CLOUD}               ## Go to the cloud provider directory. Example: "cd trinityx-terraform/azure" OR "cd trinityx-terraform/aws" OR "cd trinityx-terraform/gcp"
terraform init                              ## Prepare the working directory for other commands.
terraform validate                          ## Check whether the configuration is valid.
terraform plan -out trinityx-tfplan         ## Show changes required by the current configuration. Example: "trinityx-azure-tfplan" OR "trinityx-aws-tfplan" OR "trinityx-gcp-tfplan"
terraform apply trinityx-tfplan             ## Create or update infrastructure. Example: "trinityx-azure-tfplan" OR "trinityx-aws-tfplan" OR "trinityx-gcp-tfplan"

# terraform destroy                           ## Destroy previously-created infrastructure. But Need State file to be present in main directory
```

- [ ] NOTE: In case of multiple Cloud Providers, repeat above commands in respect to the Cloud Provider. 
- [ ] NOTE: Supported HostList format(s). Choose any one:
```
azure_hostlist = ""
azure_hostlist = "azvm[001-004]"
azure_hostlist = "azvm[001-004]Trinity"
azure_hostlist = "[001-004]Trinity"
```

- [ ] Now, Follow the cloud provider directory for more details, about how to login and get credentials, etc.

- AWS [Click Here...](aws/)             
- Azure [Click Here...](azure/)
- GCP [Click Here...](gcp/)
- VSphere [Click Here...](vsphere/)

## Roadmap
We have scheduled a first release in somewhere in September 2024

## Contributing
As of now, in this stage we're not taking any contribution from the outside of the TrinityX Team.

## Authors and acknowledgment

- [Sumit Sharma](mailto:sumit.sharma@clustervision.com)

## License
See the TrinityX License [here](LICENSE.txt)

## Project status
Currently we're on the development phase, so you can expect the half code, mistakes, here.








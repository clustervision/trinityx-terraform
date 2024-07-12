# TrinityX Terraform

The TrinityX Terraform project will used by the TrinityX project. It will create the infrastructure depending on the user selection.

## From TrinityX
To Create Infrastructure from TrinityX follow these steps:

- [ ] Git Clone this repository.
- [ ] Create [Variable File](terraform.tfvars) in this root directory with the name "terraform.tfvars".
- [ ] Run below commands to create the infrastructure.

```
cd trinityx-terraform/{CLOUD}               ## Go to the cloud provider directory. Example: "cd trinityx-terraform/azure" OR "cd trinityx-terraform/aws" OR "cd trinityx-terraform/gcp"
terraform init                              ## Prepare the working directory for other commands.
terraform validate                          ## Check whether the configuration is valid.
terraform plan -out trinityx-tfplan         ## Show changes required by the current configuration. Example: "trinityx-azure-tfplan" OR "trinityx-aws-tfplan" OR "trinityx-gcp-tfplan"
terraform apply trinityx-tfplan             ## Create or update infrastructure. Example: "trinityx-azure-tfplan" OR "trinityx-aws-tfplan" OR "trinityx-gcp-tfplan"

# terraform destroy                           ## Destroy previously-created infrastructure. But Need State file to be present in main directory
```

THE SET OF COMMANDS MENTIONED BELOW IS NOT IN USE:
```
cd trinityx-terraform/{CLOUD}               ## Go to the cloud provider directory. Example: "cd trinityx-terraform/azure" OR "cd trinityx-terraform/aws" OR "cd trinityx-terraform/gcp"
terraform init                              ## Prepare the working directory for other commands.
terraform validate                          ## Check whether the configuration is valid.
terraform plan -out controller-tfplan       ## Show changes required by the current configuration. Example: "trinityx-azure-tfplan" OR "trinityx-aws-tfplan" OR "trinityx-gcp-tfplan"
terraform apply controller-tfplan           ## Create or update infrastructure. Example: "trinityx-azure-tfplan" OR "trinityx-aws-tfplan" OR "trinityx-gcp-tfplan"

# Controller Creation is done Till Here, Now need to begin with node creation.

terraform output subnet_id                  ## Register this output
terraform output image_id                   ## Register this output
terraform output storage_name               ## Register this output

mkdir -p state_files
mv terraform.tfstate state_files/controller.tfstate

# Change Ture False for modules & Append subnet_id, image_id, storage_name in the end of tfvar file
terraform import azurerm_resource_group.rg /subscriptions/{SUBSCRIPTION-ID}/resourceGroups/{RESOURCE-GROUP-NAME}
terraform plan -out node-tfplan  
terraform apply node-tfplan
mv terraform.tfstate state_files/node.tfstate

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

## Azure Cloud - Steps to Create a Service Principal and Obtain Credentials

### Login to Azure Portal:
Go to the [Azure Portal](https://portal.azure.com/) and log in with your Azure account.

### Create a Service Principal:

- [ ] Navigate to [Microsoft Entra ID](https://portal.azure.com/#view/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/~/Overview) in the left-hand menu.
- [ ] Click on + Add on the top Navigation and select App registration from the drop down menu. Or alternatively in the left-hand menu click on Manage to expand it then click on the App registrations and then Click on + New registration on the top Navigation.
- [ ] Provide a name for the application (e.g., TrinityX-Client).
- [ ] Leave the default settings and click Register.

### Get Client ID and Tenant ID:

- [ ] After registration, you will be taken to the application overview page.
- [ ] Note down the Application (client) ID and the Directory (tenant) ID. These will be required for Terraform configuration.

### Create a Client Secret:

- [ ] In the application overview page, navigate to Certificates & secrets.
- [ ] Click on + New client secret.
- [ ] Provide a description (e.g., TrinityX-Secret) and set an expiration period.
- [ ] Click Add.
- [ ] Copy the Value of the client secret immediately as it will be shown only once. This is your Client Secret.

### Create a Resource Group:

- [ ] Navigate to Resource groups in the left-hand menu.
- [ ] Click + Add.
- [ ] Provide a Resource group name (e.g., TrinityX-Resource).
- [ ] Select your Subscription.
- [ ] Choose a Region for the resource group.
- [ ] Click on Tags in top navigation and provide a key name "hpc" and value "trinityx".
- [ ] Click Review + Create and then Create.

### Assign Role to Service Principal:

- [ ] Navigate to the newly created resource group (TrinityX-Resource).
- [ ] Select Access control (IAM) from the left-hand menu.
- [ ] Click on Add role assignment.
- [ ] In the role dropdown, select Contributor role.
- [ ] In the Select field, search for the name of the Service Principal (TrinityX-Client).
- [ ] Select it and click Save.

[comment]: <> (### OR alternatively Assign Role to Service Principal [Less Secure]:)

[comment]: <> (- [ ] Navigate to your Subscription.)
[comment]: <> (- [ ] Select Access control (IAM).)
[comment]: <> (- [ ] Click on Add role assignment.)
[comment]: <> (- [ ] In the role dropdown, select Contributor (or another role with the necessary permissions).)
[comment]: <> (- [ ] In the Select field, search for the application name you registered (TrinityX-Client).)
[comment]: <> (- [ ] Select it and click Save.)


## Roadmap
We have scheduled a first release in somewhere in July 2024

## Contributing
As of now, in this stage we're not taking any contribution from the outside of the TrinityX Team.

## Authors and acknowledgment
Show your appreciation to those who have contributed to the project.

## License
See the TrinityX License [here](LICENSE.txt)

## Project status
Currently we're on the development phase, so you can expect the half code, mistakes, here.


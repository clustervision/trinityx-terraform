# TrinityX Terraform Azure

The TrinityX Terraform Azure will used by the TrinityX project. It will create the infrastructure depending on the user selection.

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

### Summary of Important Items:

- **Subscription ID**: This is your Subscription ID will be use to authenticate and charge.
- **Client ID**: This is your unique ID used to authenticate API requests.
- **Client Secret**: This is your secret key used alongside the Client ID.
- **Tenant ID**: This is your unique Directory(tenant) ID, needed for TrinityX Installation.






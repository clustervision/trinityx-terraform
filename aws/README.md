# TrinityX Terraform AWS

The TrinityX Terraform AWS will used by the TrinityX project. It will create the infrastructure depending on the user selection.

## AWS Cloud - Steps to Obtain Access Key and Secret Key

### Login to AWS Management Console:
- Go to the [AWS Management Console](https://aws.amazon.com/console/) and log in with your AWS account credentials.

### Create an IAM User:

- [ ] Navigate to the [IAM Dashboard](https://console.aws.amazon.com/iam/).
- [ ] In the left-hand menu, click on **Users**.
- [ ] Click on the **Add users** button.
- [ ] Provide a username (e.g., `TrinityX-User`).
- [ ] Under **Access type**, check **Programmatic access** to generate an access key and secret key.
- [ ] Click **Next: Permissions**.

### Attach Permissions to the IAM User:

- [ ] On the **Set permissions** page, choose one of the following options:
    - **Attach existing policies directly**: Select a policy like `AdministratorAccess` or `PowerUserAccess` depending on your needs.
    - **Add user to group**: If you have a predefined group with the appropriate permissions, you can add the user to that group.
- [ ] Click **Next: Tags**.
- [ ] Optionally, add tags for easier identification.
- [ ] Click **Next: Review**.
- [ ] Review the user details and click **Create user**.

### Retrieve Access Key and Secret Key:

- [ ] After the user is created, you will see a screen displaying the **Access Key ID** and **Secret Access Key**. 
- [ ] **Important**: This is the only time the **Secret Access Key** will be displayed. Make sure to download the `.csv` file or copy the keys to a secure location.
- [ ] You can also click on **Show** to reveal the secret key and copy it.

### Enable MFA (Multi-Factor Authentication) for Security (Optional but Recommended):

- [ ] Navigate back to the IAM Dashboard.
- [ ] In the **Users** section, select the user you just created.
- [ ] Under the **Security credentials** tab, scroll down to **Multi-Factor Authentication (MFA)** and click on **Assign MFA device**.
- [ ] Follow the prompts to enable MFA using a virtual MFA device like Google Authenticator.

### Summary of Important Items:

- **Access Key ID**: This is your unique ID used to authenticate API requests.
- **Secret Access Key**: This is your secret key used alongside the Access Key ID.
- **MFA Device**: This is your multi-factor authentication device for added security.




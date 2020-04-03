# eks-cluster-terraform
Repository for Creating EKS Cluster with Managed Nodes using Terraform


This readme provides two options to get started.

**What does this terraform template build?**
- VPC with 10.0.0.0/16 CIDR Block
- 3 x Public Subnets with necessary tags
- 3 x Private Subnets with necessary tags
- 3 x Elastic IP
- 3 x NAT Gateway
- 1 x Internet Gateway
- Route Tables for public & private subnets
- Security Groups for communication between worker nodes and cluster
- IAM Policy & Role for Worker nodes
- Managed Worker node group
- EKS Cluster with logging enabled
- IAM Provider with EKS OIDC Issuer

## Using Cloud9 as a terraform host

Based on your region, click the **Deploy to AWS** icon to deploy a cloudformation stack which provisions the following:
1. Cloud9 Instance
2. Pulls this repository automatically
3. IAM role for Cloud9 IDE
4. CodeBuild Project to assign IAM Instance Profile to Cloud9 IDE

| Region | Launch Template |
| ------------ | ------------- | 
**Oregon** (us-west-2) | [![Launch Stack into Oregon with CloudFormation](/images/deploy-to-aws.png)](https://console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks/new?stackName=MyEKSLabStack&templateURL=https://s3-ap-southeast-2.amazonaws.com/aajolly-labs/c9stack.yaml)  
**N.Virginia** (us-east-1) | [![Launch Stack into N.Virginia with CloudFormation](/images/deploy-to-aws.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=MyEKSLabStack&templateURL=https://s3-ap-southeast-2.amazonaws.com/aajolly-labs/c9stack.yaml)  
**Ohio** (us-east-2) | [![Launch Stack into N.Virginia with CloudFormation](/images/deploy-to-aws.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks/new?stackName=MyEKSLabStack&templateURL=https://s3-ap-southeast-2.amazonaws.com/aajolly-labs/c9stack.yaml)  
**Montreal** (ca-central-1) | [![Launch Stack into N.Virginia with CloudFormation](/images/deploy-to-aws.png)](https://console.aws.amazon.com/cloudformation/home?region=ca-central-1#/stacks/new?stackName=MyEKSLabStack&templateURL=https://s3-ap-southeast-2.amazonaws.com/aajolly-labs/c9stack.yaml)  
**Sao Paulo** (sa-east-1) | [![Launch Stack into N.Virginia with CloudFormation](/images/deploy-to-aws.png)](https://console.aws.amazon.com/cloudformation/home?region=sa-east-1#/stacks/new?stackName=MyEKSLabStack&templateURL=https://s3-ap-southeast-2.amazonaws.com/aajolly-labs/c9stack.yaml)  
**Ireland** (eu-west-1) | [![Launch Stack into N.Virginia with CloudFormation](/images/deploy-to-aws.png)](https://console.aws.amazon.com/cloudformation/home?region=eu-west-1#/stacks/new?stackName=MyEKSLabStack&templateURL=https://s3-ap-southeast-2.amazonaws.com/aajolly-labs/c9stack.yaml)  
**Frankfurt** (eu-central-1) | [![Launch Stack into N.Virginia with CloudFormation](/images/deploy-to-aws.png)](https://console.aws.amazon.com/cloudformation/home?region=eu-central-1#/stacks/new?stackName=MyEKSLabStack&templateURL=https://s3-ap-southeast-2.amazonaws.com/aajolly-labs/c9stack.yaml)  
**London** (eu-west-2) | [![Launch Stack into N.Virginia with CloudFormation](/images/deploy-to-aws.png)](https://console.aws.amazon.com/cloudformation/home?region=eu-west-2#/stacks/new?stackName=MyEKSLabStack&templateURL=https://s3-ap-southeast-2.amazonaws.com/aajolly-labs/c9stack.yaml)  
**Paris** (eu-west-3) | [![Launch Stack into N.Virginia with CloudFormation](/images/deploy-to-aws.png)](https://console.aws.amazon.com/cloudformation/home?region=eu-west-3#/stacks/new?stackName=MyEKSLabStack&templateURL=https://s3-ap-southeast-2.amazonaws.com/aajolly-labs/c9stack.yaml)  
**Stockholm** (eu-north-1) | [![Launch Stack into N.Virginia with CloudFormation](/images/deploy-to-aws.png)](https://console.aws.amazon.com/cloudformation/home?region=eu-north-1#/stacks/new?stackName=MyEKSLabStack&templateURL=https://s3-ap-southeast-2.amazonaws.com/aajolly-labs/c9stack.yaml)  
**Bahrain** (me-south-1) | [![Launch Stack into N.Virginia with CloudFormation](/images/deploy-to-aws.png)](https://console.aws.amazon.com/cloudformation/home?region=me-south-1#/stacks/new?stackName=MyEKSLabStack&templateURL=https://s3-ap-southeast-2.amazonaws.com/aajolly-labs/c9stack.yaml)  
**Singapore** (ap-southeast-1) | [![Launch Stack into N.Virginia with CloudFormation](/images/deploy-to-aws.png)](https://console.aws.amazon.com/cloudformation/home?region=ap-southeast-1#/stacks/new?stackName=MyEKSLabStack&templateURL=https://s3-ap-southeast-2.amazonaws.com/aajolly-labs/c9stack.yaml)  
**Tokyo** (ap-northeast-1) | [![Launch Stack into N.Virginia with CloudFormation](/images/deploy-to-aws.png)](https://console.aws.amazon.com/cloudformation/home?region=ap-northeast-1#/stacks/new?stackName=MyEKSLabStack&templateURL=https://s3-ap-southeast-2.amazonaws.com/aajolly-labs/c9stack.yaml)  
**Sydney** (ap-southeast-2) | [![Launch Stack into N.Virginia with CloudFormation](/images/deploy-to-aws.png)](https://console.aws.amazon.com/cloudformation/home?region=ap-southeast-2#/stacks/new?stackName=MyEKSLabStack&templateURL=https://s3-ap-southeast-2.amazonaws.com/aajolly-labs/c9stack.yaml)  
**Seoul** (ap-northeast-2) | [![Launch Stack into N.Virginia with CloudFormation](/images/deploy-to-aws.png)](https://console.aws.amazon.com/cloudformation/home?region=ap-northeast-2#/stacks/new?stackName=MyEKSLabStack&templateURL=https://s3-ap-southeast-2.amazonaws.com/aajolly-labs/c9stack.yaml)  
**Mumbai** (ap-south-1) | [![Launch Stack into N.Virginia with CloudFormation](/images/deploy-to-aws.png)](https://console.aws.amazon.com/cloudformation/home?region=ap-south-1#/stacks/new?stackName=MyEKSLabStack&templateURL=https://s3-ap-southeast-2.amazonaws.com/aajolly-labs/c9stack.yaml)  
**Hong Kong** (ap-east-1) | [![Launch Stack into N.Virginia with CloudFormation](/images/deploy-to-aws.png)](https://console.aws.amazon.com/cloudformation/home?region=ap-east-1#/stacks/new?stackName=MyEKSLabStack&templateURL=https://s3-ap-southeast-2.amazonaws.com/aajolly-labs/c9stack.yaml)  

### Update IAM settings for your Workspace

> AWS Cloud9 normally manages IAM credentials dynamically. This however causes issues when trying to create IAM entities, hence we'll be disabling this option and leveraging an IAM role which has been pre-provisioned.

- From within your workspace, click the sprocket, or launch a new tab to open the Preferences tab
- Select **AWS SETTINGS**
- Turn off **AWS managed temporary credentials**
- Close the Preferences tab
![c9disableiam](/images/c9disableiam.png)


#### Install required command line tools 

Install command line tools by executing:

```bash 
cd init_scripts
sh setup
```
Make sure to reload bash profile

```bash 
source ~/.bash_profile
```

> Make sure aws-cli version if 1.18+. If it is less than that, issue the command export PATH=$HOME/.local/bin:$PATH
> It should now be 1.18+


To ensure temporary credentials aren't already in place remove
any existing credentials file:
```bash
rm -vf ${HOME}/.aws/credentials
```

Configure our aws cli with our current region as default:
```bash
export ACCOUNT_ID=$(aws sts get-caller-identity --output text --query Account)
export AWS_REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.region')

echo "export ACCOUNT_ID=${ACCOUNT_ID}" >> ~/.bash_profile
echo "export AWS_REGION=${AWS_REGION}" >> ~/.bash_profile
aws configure set default.region ${AWS_REGION}
aws configure get default.region
```

### Validate the IAM role

Use the [GetCallerIdentity](https://docs.aws.amazon.com/cli/latest/reference/sts/get-caller-identity.html) CLI command to validate that the Cloud9 IDE is using the correct IAM role.

```bash
aws sts get-caller-identity
```

The output assumed-role name should contain:
```bash
C9Role
```

#### VALID

If the _Arn_ contains the role name from above and an Instance ID, you may proceed.

```bash
{
    "Account": "123456789", 
    "UserId": "AROASZJSJAGFMMAJLP52A:MasterKey", 
    "Arn": "arn:aws:sts::191768363402:assumed-role/C9Role/i-032qawsee877f6d01"
}
```
### Create EKS Cluster using terraform

A git repository with terraform code has already been provisioned as part of Cloud9.

```terraform
cd terraform
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```

The terraform stack will take ~15 minutes to provision the resources.

### Configuring kubectl for EKS (Optional)
If you intend to use kubectl to manage the cluster, please follow the procedure below to configure kubectl to work with EKS. Run the below command

```bash
aws eks update-kubeconfig --name "EKS-LAB"
```


## Already have a terraform host

- Steps to perform

  > Make sure environment variables for region are set else terraform validate command will fail and terraform plan, terraform apply commands will ask you to specify a region.

  - Clone this repository
  - Change directory to terraform
  - Initialize terraform
    ```terraform
    terraform init
    ```
  - Validate terraform
    ```terraform
    terraform validate
    ```
  - Check the execution plan
    ```terraform
    terraform plan
    ```
  - Deploy
    ```terraform
    terraform apply -auto-approve
    ```
  - Clean-up
    ```terraform
    terraform destroy -auto-approve
    ```
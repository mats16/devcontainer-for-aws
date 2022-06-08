# Dev container for AWS

This is a codespace template for AWS CDK in **GitHub Codespace**.

public dockder image for this codespace:

`ghcr.io/mats16/devcontainer-for-aws:latest` [Github Container Registry](https://github.com/mats16/devcontainer-for-aws/pkgs/container/devcontainer-for-aws)

## Create AWS CDK App

```bash
pj new awscdk-app-ts
```

## Create AWS CDK Construct Lib

```bash
pj new awscdk-construct
```

## Configure AWS CLI V2 with AWS SSO

```bash
aws configure sso --profile default
```

The following example generate the SSO profile with `default` as the profile name:

```
$ aws configure sso
SSO start URL [None]: https://pahud-sso.awsapps.com/start                                                                                                                               
SSO Region [None]: us-east-1                                                                                                                                                            
Attempting to automatically open the SSO authorization page in your default browser.
If the browser does not open or you wish to use a different device to authorize this request, open the following URL:

https://device.sso.us-east-1.amazonaws.com/

Then enter the code:

DJHN-QKRK
The only AWS account available to you is: 123456789012
Using the account ID 123456789012
The only role available to you is: AdministratorAccess
Using the role name "AdministratorAccess"
CLI default client Region [None]: ap-northeast-1                                                                     
CLI default output format [None]:                                                                                    

To use this profile, specify the profile name using --profile, as shown:

aws s3 ls --profile default        
```

## Configure `credential_process` for another profile

** Currently AWS CDK supports AWS SSO, so this configuration is not necessary. **

If you want to use another profile, Please configure as shown below.

```sh
aws configure set credential_process aws-sso-credential-process --profile <profile_name>
```

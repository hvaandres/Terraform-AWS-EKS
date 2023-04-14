# Let's create project "AWS - ECS/EKS"
- The idea of this project is to create a simple web application that will be deployed to AWS ECS/EKS.
- The application will have to be simple with a connection to a DB.
- This application will create a DJango application with a connection to a postgress DB.
- This will be deployed to AWS Container Registry.
- Then, we will create a helm chart for the application.

# EC2_Instance:
- We will create an EC2 instance with a public IP.
- We will install docker on the EC2 instance.
- We will install kubectl on the EC2 instance.
- We will install helm on the EC2 instance.
- We will install awscli on the EC2 instance.
- We will install eksctl on the EC2 instance.
- We will install terraform on the EC2 instance.

## Notes
- To run the terraform command to grab the secrets, you will need to run the following command:
```
terraform plan -var="aws_access_key=MY_ACCESS_KEY" -var="aws_secret_key=MY_SECRET_KEY"
```

- You will need to get your access key and secret key from the AWS console.

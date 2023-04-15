# Let's create project "AWS - ECS/EKS"
- The idea of this project is to create an AWS EC2 Instance to later on being able to add our following application: 
  - The application will have to be simple with a connection to a DB.
  - This application will create a DJango application with a connection to a postgress DB.
  - This will be deployed to AWS Container Registry.
  - With everything being deployed into the EC2 Instance, you will be able to test the endpoint. 
  - At this point since everything is in a AWS container Registry, you will have the opportunnity to create more resources like EKS, and pull the images from the container registry.
- If you would like to know how to run the Python, Djanfo & Postgress project, you will have to clone this repo https://github.com/hvaandres/workshop2

# Deployment of the EC2 Instance:
- This will include the following:
  - Security Group
  - AWS Instance - EC2
  - Ingress for postgresql
  - ECR private repository
  - A db group paramater
  - An RDS Instance

# Software that will need to be instaleld in the EC2_Instance:
- docker
- awscli
- python
- postgress

## Notes
- To run the terraform command to grab the secrets, you will need to run the following command:
```
terraform plan -var="aws_access_key=MY_ACCESS_KEY" -var="aws_secret_key=MY_SECRET_KEY"
```

- You will need to get your access key and secret key from the AWS console.

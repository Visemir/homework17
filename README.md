Task
Create a [Terraform module](https://github.com/Visemir/homework17/tree/main/terraform-modul) that takes the following input values:
vpc_id
list_of_open_ports

Then creates in the eu-north-1 region:
A security group that allows access from anywhere to ports from input in the specified VPC
A public EC2 instance in the specified VPC with an installed default Nginx server or Nginx running in a container

Then outputs:
IP of the created instance
![](https://github.com/Visemir/homework17/blob/main/terraformapply.jpg)

![](https://github.com/Visemir/homework17/blob/main/terraformcreate.jpg)

Use http://IP to confirm that Nginx is running

![](https://github.com/Visemir/homework17/blob/main/web.jpg)

Backend
Configure S3 backend for your project
Use the terraform-state-danit-devops-2 bucket in the eu-central-1 region
Configure a unique path for your state by using your login name

![](https://github.com/Visemir/homework17/blob/main/s3.jpg)

Ensure that the file is created in the bucket and gets updated when you change the infrastructure

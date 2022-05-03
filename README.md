# Terraform

> Note: Code Is Commented

## At first:
* Create project from consol : moutaz-project
![Build Status](https://github.com/moutazmuhammad/GCP-Terraform-Kubernetes-Task/blob/main/img/8.png?raw=true)
* Create bucket which will have the state of terraform code (If you work in team) from consol
![Build Status](https://github.com/moutazmuhammad/GCP-Terraform-Kubernetes-Task/blob/main/img/9.png?raw=true)

> Note: You will need to change bucket name.

## Steps Of Terraform Code:
* In Provider.tf: file project_name, region and bucket name (which will have the state of the terraform code) are defined .

* Create a vpc with disabling auto_create_subnetworks .

* Create two subnets : Management subnet (has the following: NAT gateway - Private VM) and Restricted subnet (has the following: Private standard GKE cluster (private control plan)) .
![Build Status](https://github.com/moutazmuhammad/GCP-Terraform-Kubernetes-Task/blob/main/img/1.png?raw=true)

* create a router resource and nat getway , attach Management subnet  to allow to the private VM to access the internet.
![Build Status](https://github.com/moutazmuhammad/GCP-Terraform-Kubernetes-Task/blob/main/img/10.png?raw=true)
![Build Status](https://github.com/moutazmuhammad/GCP-Terraform-Kubernetes-Task/blob/main/img/11.png?raw=true)

* create second subnet: private subnet cause there is no nat attached to it so it cannot connect public internet .

* create a fire wall that allowing port 80 for ssh out instance.
![Build Status](https://github.com/moutazmuhammad/GCP-Terraform-Kubernetes-Task/blob/main/img/12.png?raw=true)

* create an instance and attach it to Management subnet to act later as a bastion host .

* create a regional private container cluster with 3 node locations 
    - attach cluster to vpc and Restricted subnet
    - make its nodes and endpoints private 
    - attach master_ipv4_cidr_block = "172.16.0.0/28" for master plan 
    - attach secondry private subnet ip ranges for pods and services
      cluster_secondary_range_name = "k8s-pod-range"
      services_secondary_range_name = "k8s-service-range"
![Build Status](https://github.com/moutazmuhammad/GCP-Terraform-Kubernetes-Task/blob/main/img/2.png?raw=true)
![Build Status](https://github.com/moutazmuhammad/GCP-Terraform-Kubernetes-Task/blob/main/img/13.png?raw=true)
![Build Status](https://github.com/moutazmuhammad/GCP-Terraform-Kubernetes-Task/blob/main/img/14.png?raw=true)

* create node pool 
![Build Status](https://github.com/moutazmuhammad/GCP-Terraform-Kubernetes-Task/blob/main/img/3.png?raw=true)

## Commands to initialize gcp infrastructure:
```sh
terraform init 
```
```sh
terraform init 
```
```sh
terraform apply 
```


# Docker

## Command to configure Docker & gcloud to work with GCR of your project:
* Enable GCR API .
* Make sure that your account has all permissions to GCR .
* Install docker on your local machine .
* Run command in your local machine
```sh
gcloud auth configure-docker
```

* Create image from DockerFile by command and upload from local to GCR .
```sh
docker build -t <image_name> .
```
> Note: .env file to be aware of application environmental variables gonna pass through deployment on cluster GKE .

* We need image redis to be uploaded from local to GCR .
* Command used to push image from local machine to GCR .
```sh
docker tag <image_name> gcr.io/<project_name>/front
```
```sh
docker push gcr.io/<project_name>/front
```
* Command used to pull image from GCR to VM.
```sh
docker tag redis gcr.io/<project_name>/redis
```
```sh
docker push gcr.io/<project_name>/redis
```
![Build Status](https://github.com/moutazmuhammad/GCP-Terraform-Kubernetes-Task/blob/main/img/4.png?raw=true)


# Kubernates


## Steps:

* SSH to private VM .
```sh
gcloud compute ssh --zone <zone_name> <vm-name>  --tunnel-through-iap --project <project_name>
```
* Download Docker on your VM
```sh
curl -fsSL https://test.docker.com -o test-docker.sh 
```
```sh
sudo sh test-docker.sh
```
```sh
sudo usermod -aG docker ${USER}
```
```sh
gcloud auth config-docker
```
- Then reboot the VM .

* From Your Private VM: SSH to the cluster
```sh
gcloud container clusters get-credentials <cluster_name>
```

* Create the files using the commands in the following order:
```sh
kubectl create -f redis-db-deploy.yaml
```
```sh
kubectl create -f backend-svc.yaml
```
> Note: Vssign backend-svc generated IP to env variables "REDIS_HOST" of python-app-deploy

```sh
kubectl create -f python-app-deploy
```
```sh
kubectl create -f loadblancer.yaml
```
![Build Status](https://github.com/moutazmuhammad/GCP-Terraform-Kubernetes-Task/blob/main/img/5.png?raw=true)

* Use this command to get all resources
![Build Status](https://github.com/moutazmuhammad/GCP-Terraform-Kubernetes-Task/blob/main/img/6.png?raw=true)

* Use external IP of the loadblancer to open the Python App in your browser.
![Build Status](https://github.com/moutazmuhammad/GCP-Terraform-Kubernetes-Task/blob/main/img/7.png?raw=true)


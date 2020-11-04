# immutable-Infrastructure-demo
 Demo project that uses Packer, Ansible, and Terraform to build inmutable infrastructure 

The workflow is:
 - Bake the golden image with packer. It use ansible to provision the software.
 - Based on the resulting image, terraform create a VM. It use a regex to find the image and use always the most recent.


## Requirements

Install Packer to build the image: https://www.packer.io/docs/install
Install Terraform to provision the VM:  https://learn.hashicorp.com/tutorials/terraform/install-cli
Get a Digital Ocean API token: https://cloud.digitalocean.com/account/api/tokens



## How to build the image

1. Set an environment variable to the the API token
```
export DIGITALOCEAN_API_TOKEN=4059d45e5a75de0f24fe8f2ec678062e5cf8d66db885cdf4826befb30557d2gh
```
Change the value for your API token.

2. Buid the image:

```
$ cd packer
$ packer build  ubuntu2004-digitalocean.json
```


## How to create the VM

### Create variables file
In the root path of the code, create a file named terraform.tfvars and place the following variables:


```
do_token: must have the token created in the previous step.
droplet_ssh_key_id: The id of the key in DigitalOcean that will be used to connect to the virtual machine
droplet_name: The name of the droplet in DigitalOcean
droplet_size: The size of the droplet to use
droplet_region: The region where the droplet will be deployed

```

To obtain the values of the region, the ssh key, the name  of the image and the size of the virtual machine, install the Digital Ocean command-line client: https://www.digitalocean.com/docs/apis-clis/doctl/

Export the DO token asn an environment variable:
```
export DIGITALOCEAN_API_TOKEN=xxxdfc7f164a7001f76048313b0970bd46092f20569b9780ac242b00c9a7axxx
```

Change the value to your token.


To list all available ssh keys in the account:
```

$ doctl  -t $DIGITALOCEAN_API_TOKEN compute ssh-key list
```


To list all OS available:
```

$ doctl  -t $DIGITALOCEAN_API_TOKEN compute  image list --public
```


To list all OS available:
```

$ doctl  -t $DIGITALOCEAN_API_TOKEN compute  region list
```


To list all sizes available:
```

$ doctl  -t $DIGITALOCEAN_API_TOKEN compute  size list
```

**terraform.tfvars**
```
do_token = "xxxdfc7f164a7001f76048313b0970bd46092f20569b9780ac242b00c9a7axxx"
droplet_ssh_key_id = "1632017"
droplet_name = "server-by-terraform"
droplet_size = "s-1vcpu-1gb"
droplet_region = "nyc1"
```

### Execute terraform


To deploy the server we just have to execute the following commands:

```
$ terraform plan
$ terraform apply
```

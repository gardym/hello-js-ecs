# hello-js

Port 3000 brings all the containers to the yard

## Usage

    # Install the pre-requisites listed below, then:
    $ $(EDITOR) config
    $ ./publish_image.sh
    $ ./deploy_to_cluster.sh

## Pre-requisites

### Toolset

    # Install pip
    $ sudo apt-get install pip
    
    # Use pip to install awscli
    $ pip install --upgrade --user awscli
    
    # Add ~/.local/bin to your PATH
    
    # Install jaques
    $ npm install -g jaques

### AWS

- Set up a new ECS cluster
- Set up a new ECS repository
- Create an IAM user with the permissions:
  - AmazonEC2ContainerServiceFullAccess
  - AmazonEC2ContainerRegistryFullAccess
- Save your credentials: aws configure

### Docker Hub

- Set up a new repository in Docker Hub

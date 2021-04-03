# Setup Jupyter Lab on Google Cloud Platform

## Stage 0: Claim Google Cloud Platform credit

Refer to the email for a link to claim $50 credit on Google Cloud Platform.

## Stage 1: Start a Virtual Machine

This template hast been tested with Google Cloud VM with Debian 10 (Buster) [[instructions](https://cloud.google.com/compute/docs/quickstart-linux)].
* Change disk size to 20 GB
* `Allow HTTPS traffic` (defaults to port 443) 

Click on "SSH" button to start a terminal session

## Stage 2: Install Packages

In the terminal, copy and execute the following commands:

* Install dependencies  
    ```bash
    sudo apt-get update && \
        sudo apt-get install -y make git docker.io docker-compose && \
        sudo usermod -aG docker $USER && \
        newgrp docker
    ```
## Stage 3: Setup and start Jupyter Lab

* Clone class Github repository
    ```bash
    git clone https://github.com/UCSB-PSTAT-234/Spring2021 && \
        cd Spring2021
    ```
* One-time initial setup:  
    ```bash  
    make setup
    ```
    This will be the password for accessing your Jupyter lab
* Start/stop Jupyter lab server:
    `make start` and `make stop`

Instead of starting and stopping Jupyter lab server, the virtual machine can be paused and started.

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

* Install Python (Miniconda3)
    ```bash
    curl -fSL -o ~/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
        bash ~/miniconda.sh -b -u -p ~/miniconda3 && \
        ~/miniconda3/bin/conda init bash && \
        source ~/.bashrc
    ```
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
    git clone https://github.com/UCSB-PSTAT-234/Spring2021
    cd Spring2021
    ```
* One-time initial setup:  
    enter a new password for securing your Jupyter lab  
    `make setup`
* Start/stop Jupyter lab server:
    `make start` and `make stop`

Instead of starting and stopping Jupyter lab server, the virtual machine can be paused and started.

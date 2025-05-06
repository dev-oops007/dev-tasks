    #!/bin/bash
    sudo dnf update
	sudo dnf upgrade
	sudo yum install -y wget jq
	sudo yum install gcc yum-utils zlib-devel python-tools cmake git pkgconfig -y --skip-broken
	sudo yum groupinstall -y "Development Tools" --skip-broken

	echo 'alias python=python3' >> ~/.bashrc
	source ~/.bashrc
	python --version
	cd /home/vagrant
	wget https://www.python.org/ftp/python/3.11.3/Python-3.11.3.tgz
	tar -xvzf Python-3.11.3.tgz
	cd Python-3.11.3
	./configure
	make
	sudo make install
	python3 --version
	# Exit script on any error
	set -e

	# Define the Terraform version to install
	TERRAFORM_VERSION=$(curl -s https://checkpoint.hashicorp.com/v1/check/terraform | jq -r .current_version)

	echo "Installing Terraform $TERRAFORM_VERSION and AWS CLI on Red Hat 8..."

	# Install dependencies
	echo "Installing dependencies..."
	yum install -y unzip jq curl

	# Download and install Terraform
	sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
    sudo yum -y install terraform

	# Verify Terraform installation
	echo "Terraform version installed:"
	terraform -version

	# Download and install AWS CLI
	echo "Downloading AWS CLI..."
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip

	echo "Installing AWS CLI..."
	./aws/install
	rm -rf aws awscliv2.zip

	# Verify AWS CLI installation
	echo "AWS CLI version installed:"
	aws --version
	
	# Prompt for AWS configuration
	echo "Please enter your AWS credentials for configuration..."
	#aws configure

	echo "Setup complete. Terraform and AWS CLI are now installed and configured."
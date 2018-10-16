#!/bin/sh

# This will run Terraform and setup instances in AWS.

my_dir=`pwd`
tmp_dir="/tmp"

terra_zip="https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip"
pkgs_pre="wget vim ansible"

pre_setup()
{
    apt-get -y install $pkgs_pre
}

terraform()
{
    wget $terra_zip -o $tmp_dir

    cd $tmp_dir ; unzip terr*.zip
    export PATH=$PATH:/tmp
    echo $PATH ; terraform help > /dev/null

    if [ $? -eq 0 ]; then
        echo "Terraform installed successfully"
    else
        echo "Terraform installation failed"
    fi
}



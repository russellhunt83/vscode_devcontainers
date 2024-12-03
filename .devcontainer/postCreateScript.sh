#!/bin/bash
DOCKERVERSION="18.06.3-ce"

pip install -r ./dev-requirements.txt 

yum update && yum upgrade -y
yum install -y gnupg software-properties-common wget nano git curl inetutil-* unzip tar

#Installs Terraform
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
yum update && yum install -y terraform


git config --global core.editor "nano"
git config --global core.editor "nano"
git config --global user.name "${LOCAL_USER}"
git config --global user.email "${LOCAL_USER}@localhost"
git config --global push.autoSetupRemote true

cd /tmp
if ! command -v aws --version &> /dev/null ; 
    then 
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        ./aws/install  
        rm -rf ./aws
        rm awscliv2.zip
fi 

if ! command -v docker --version &&> /dev/null 
    then
        curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz  
        tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 -C /usr/local/bin docker/docker
        rm docker-${DOCKERVERSION}.tgz
fi

cd $REMOTE_HOME 

#Fix annoyting CURL issue that doesn't break the line properly when printing on the console.
echo '-w "\n"' >> ~/.curlrc

#Overwrite the docker image /var/task/app path with the developer's workspace path.
#When errors are produced from the host the user can ctrl+click on the console link to review the file error in their workspace
rm -rf /var/task/app
ln -s $REMOTE_HOME$PATH_TO_APP /var/task/
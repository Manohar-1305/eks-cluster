#!/bin/bash
sudo su -

ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"

# (Optional) Verify checksum
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check

tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz

sudo mv /tmp/eksctl /usr/local/bin

sudo apt-get update -y
# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

# If the directory `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
# sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update -y
sudo apt-get install -y kubectl
sudo apt-mark hold kubectl

# Verify kubectl installation
kubectl version --client

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install --update --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli
# Step 1: Create the AWS configuration script
cat <<EOF >aws_configure.sh
export AWS_ACCESS_KEY_ID="access-key"
export AWS_SECRET_ACCESS_KEY="secret-key"
export AWS_DEFAULT_REGION="ap-south-1"
EOF

export AWS_REGION=ap-south-1
aws eks --region ap-south-1 update-kubeconfig --name Private_EKS_Cluster

# Define the kubeconfig file path
KUBECONFIG_FILE="/root/.kube/config"

# Backup the original kubeconfig file
BACKUP_FILE="$KUBECONFIG_FILE.bak"

echo "Creating a backup of the kubeconfig file at $BACKUP_FILE..."
cp "$KUBECONFIG_FILE" "$BACKUP_FILE"

# Replace v1alpha1 with v1beta1 in the kubeconfig file
echo "Updating apiVersion from v1alpha1 to v1beta1..."
sed -i 's/apiVersion: client.authentication.k8s.io\/v1alpha1/apiVersion: client.authentication.k8s.io\/v1beta1/' "$KUBECONFIG_FILE"

# Check if the change was successful
if grep -q "apiVersion: client.authentication.k8s.io/v1beta1" "$KUBECONFIG_FILE"; then
  echo "Update successful. The kubeconfig file has been updated."
else
  echo "Update failed. Restoring the backup file..."
  mv "$BACKUP_FILE" "$KUBECONFIG_FILE"
  exit 1
fi


# Step 2: Make the AWS configuration script executable
chmod +x aws_configure.sh

# Step 3: Source the AWS configuration
source ./aws_configure.sh


# Step 4: Delete the aws_configure.sh script
rm -f aws_configure.sh

echo "Config Updated" >updated.txt

#!/bin/bash

RG_NAME="devops-lab-rg"
LOCATION="eastus"
VM_NAME="ubuntu-vm-01"

echo "=== Creating Resource Group ==="
az group create --name $RG_NAME --location $LOCATION

echo "=== Creating Virtual Network ==="
az network vnet create --resource-group $RG_NAME --name devops-vnet --address-prefix 10.0.0.0/16 --subnet-name default --subnet-prefix 10.0.0.0/24

echo "=== Creating Virtual Machine ==="
az vm create --resource-group $RG_NAME --name $VM_NAME --image Ubuntu2204 --size Standard_B1s --vnet-name devops-vnet --subnet default --admin-username azureuser --generate-ssh-keys --public-ip-sku Standard

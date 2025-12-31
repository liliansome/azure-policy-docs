# Getting Started with Azure Policy

## Prerequisites
1. Azure subscription
2. Contributor or Owner role
3. Azure CLI or PowerShell installed

## Quick Start Guide

### 1. Install Azure CLI
```bash
# Windows (PowerShell)
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi
Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'

# macOS
brew update && brew install azure-cli

# Linux
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

### Login to Azure
```bash
az login

### Deploy Your First Policy
```bash
#### Navigate to examples
cd azure-policy-docs

#### Deploy all policies
./scripts/deploy-policy.sh

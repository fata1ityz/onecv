# CI/CD Pipeline to deploy One2OneTool Application

This repository contains a Jenkins pipeline that automates building, testing, containerizing, and deploying One2OneTool to Azure Container Instances (ACI). The pipeline handles two branches: `staging` and `release`, each using different input data files.

## Features
- **Branch-specific Data Files**:
  - `staging` uses `Questions-test.json`.
  - `release` uses `Questions.json`.
- **CI/CD Pipeline**: Triggered on commits to `staging` or `release` branches.
- **Azure Integration**: Deploys to Azure Container Instances (ACI) using Azure Container Registry (ACR).
- **Email Notifications**: Alerts sent on build failure.

## Prerequisites

- **Jenkins** with the following plugins:
  - GitHub Integration
  - Azure CLI
  - Docker
  - Email Extension
- **Github Webhook** configured on the repository
- **Azure Subscription** and Service Principal with permissions.
- **Azure Container Registry (ACR)** and **Azure Container Instances (ACI)** set up.

## Setup Instructions

### 1. Download or clone Jenkinsfile

Download or clone `jenkinsfile_one2onetool` to your Repository or Local Machine:

### 2. Configure Webhook Trigger

Set up a **GitHub Webhook** to automatically trigger the Jenkins pipeline on commits to the `staging` or `release` branches. This ensures the pipeline runs whenever there is a new commit in either branch.

#### Steps to Configure the Webhook:
1. Go to your **GitHub repository**.
2. Navigate to **Settings > Webhooks**.
3. Click **Add webhook** and enter your Jenkins server's webhook URL.
   - Example: `http://<your-jenkins-server>/github-webhook/`
4. Ensure the **Content type** is set to `application/json`.
5. Under **Which events would you like to trigger this webhook?**, select **Just the push event**.
6. Save the webhook.

#### Additional Jenkins Configuration:
- Add **Azure credentials** in Jenkins for authentication with Azure services.
---

### 3. Configure Azure

Prepare the necessary Azure resources and credentials for deployment:

#### Steps to Configure Azure:
1. **Set up Azure Container Registry (ACR)**:
   - Create an ACR instance to store Docker images.
   - Ensure it is accessible from your Jenkins server.

2. **Use a Service Principal for Azure Authentication**:
   - Create a Service Principal in Azure with the required permissions.
   - Store the Service Principal credentials in Jenkins Credentials Manager:
     - Add a new credential in Jenkins with the Azure Service Principal type.
       - `AZURE_CLIENT_ID`
       - `AZURE_CLIENT_SECRET`
       - `AZURE_TENANT_ID`
       - `AZURE_SUBSCRIPTION_ID`
      
### 4. Configure Jenkins Pipeline
#### Steps to Configure Jenkins Pipeline Job:
1. **Create a New Pipeline Job:**:
   - Open your Jenkins instance in a web browser.
   - From Jenkins dashboard, click on New Item.
   - Enter a name for the new job (e.g., `one2onetool-cicd-pipeline `).
   - Select Pipeline as the job type.
   - Click OK to create the job.
     
2. **Configure Pipeline Script:**:
   - In the Pipeline section, you'll find an option to define the pipeline script.
   - Select Pipeline script from the Definition dropdown.
   - Paste the pipeline script (`jenkinsfile_one2onetool`) into the Pipeline Script text box and save.
  
### Pipeline Overview

The pipeline automates the deployment process and includes the following stages:

1. **Checkout**:  
   - Pulls the code from the branch (`staging` or `release`) that triggered the pipeline.

2. **Set Data File**:  
   - Selects the appropriate input data file based on the branch:  
     - `staging` → `Questions-test.json`.  
     - `release` → `Questions.json`.

3. **Run Tests**:  
   - Installs dependencies using `npm install`.  
   - Executes tests with `npm test`.

4. **Build Docker Image**:  
   - Builds Docker image with branch-specific tag (`staging` or `release`).  

5. **Login to Azure**:  
   - Authenticates with Azure using Service Principal.

6. **Push Docker Image to ACR**:  
   - Tags the Docker image with the Azure Container Registry (ACR) URL.  
   - Pushes tagged image to ACR.

7. **Deploy to ACI**:  
   - Deploys the Docker image from ACR to Azure Container Instances (ACI).  
   - Configures CPU and memory for the container.
---

### Running the Pipeline

To trigger the pipeline:

1. **Commit Changes to GitHub**:  
   - Ensure the GitHub webhook is correctly configured.  
   - Push changes to either the `staging` or `release` branch.

2. **Pipeline Execution**:  
   - The pipeline will automatically start in Jenkins and execute all defined stages.

---

### Email Notifications

- If the pipeline fails at any stage, an email will be sent to the configured recipients.  
- The email includes details about the failure to help diagnose and resolve the issue.
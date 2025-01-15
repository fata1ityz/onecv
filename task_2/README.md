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

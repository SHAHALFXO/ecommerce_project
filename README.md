# Vintage 1950 – E-Commerce MVP

Live Demo: https://vintagefxo.online/frontend/

## Overview

Vintage 1950 is a full-stack e-commerce application built with Go (Gin), PostgreSQL, Docker, and AWS. The project focuses on backend architecture, deployment workflows, authentication, payment integration, and cloud infrastructure.

The application allows users to browse products, manage carts, place orders, make payments, and track purchases, while administrators can manage products and monitor orders through a dedicated dashboard.

---

## Key Features

### Customer Features

* User Registration & Login
* JWT Authentication
* Product Browsing
* Product Details
* Shopping Cart Management
* Address Management
* Checkout Workflow
* Razorpay Payment Integration
* Order History & Tracking
* User Profile Dashboard

### Admin Features

* Admin Dashboard
* Product Management
* Order Management
* Order Status Updates
* Order Analytics

---

## Tech Stack

### Backend

* Golang
* Gin Framework
* GORM
* PostgreSQL
* JWT Authentication

### Frontend

* HTML
* CSS
* Bootstrap
* JavaScript

### Cloud & DevOps

* AWS EC2
* Docker
* Docker Compose
* Nginx
* Linux (Ubuntu)
* Git & GitHub
* Docker Hub

---

## Architecture

User
↓
vintagefxo.online
↓
Nginx Reverse Proxy
↓
Go (Gin) Application
↓
PostgreSQL

The backend follows a layered architecture:

Handler
↓
Service
↓
Repository
↓
PostgreSQL

---

## Deployment

The application is deployed on AWS EC2 using Docker and Docker Compose.

Deployment Workflow:

GitHub
↓
Docker Build
↓
Docker Hub
↓
AWS EC2
↓
Docker Compose
↓
Nginx Reverse Proxy
↓
Custom Domain

Production URL:
https://vintagefxo.online/frontend/

---

## Real-World Problems Solved

During deployment and maintenance, the following issues were identified and resolved:

* PostgreSQL database restoration conflicts
* Missing product data after migrations
* Docker image update synchronization issues
* CORS configuration problems
* ARM64 vs AMD64 image compatibility
* Nginx reverse proxy configuration
* Domain and DNS setup
* Docker container networking issues
* AWS Security Group configuration

---

## Security

* JWT Authentication
* Protected Routes
* Role-Based Access Control
* Environment Variables for Secrets
* Nginx Reverse Proxy
* Isolated PostgreSQL Container Network

---

## What I Learned

* Production-style REST API development in Go
* Layered Backend Architecture
* JWT Authentication & Authorization
* PostgreSQL Database Design
* Docker Containerization
* AWS EC2 Deployment
* Nginx Reverse Proxy Configuration
* DNS & Domain Management
* Deployment Troubleshooting
* Payment Gateway Integration

---

## Project Status

✅ MVP Completed

This project was built to gain practical experience in backend development, cloud deployment, Linux administration, Docker-based workflows, and real-world troubleshooting.


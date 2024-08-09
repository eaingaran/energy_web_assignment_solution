# Deployment options for the Voting app

1. Local deployment (dev machines) using Docker Compose
2. Local deployment (dev machines) using k3s
3. Remote deployment (AWS) using Docker compose inside EC2 instance
4. Remote deployment (AES) using EKS

## Comparision

| Deployment Option                | Cost            | Deployment Speed | Production Similarity | Suitable for                                                                  |
|----------------------------------|-----------------|------------------|-----------------------|-------------------------------------------------------------------------------|
| Local Compose                    | Low             | Fastest          | Not comparable        | Unit testing, quickly testing minor changes                                   |
| Local Kubernetes (Minikube/Kind) | Low             | Fast             | Moderately comparable | Testing individual services in a Kubernetes-like environment                  |
| Local K3s                        | Low             | Fast             | Highly comparable     | Multi-service integration testing, smoke testing                              |
| AWS EC2 Compose                  | Relatively high | Slower           | Not comparable        | Collaboration, rapid debugging with team members, low-cost staging            |
| AWS EKS                          | Relatively high | Slowest          | Almost identical      | Production-like deployments, stress testing, load testing, end-to-end testing |

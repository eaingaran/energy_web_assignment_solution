# Pipelines/Workflows

- **Dev Workflow:**  
    Developer makes minor changes, builds and runs it locally using one of the local options (compose, minikube, k3s etc.,). Developer validates the changes and pushes the code to the repository's feature branch (for the feature developer is working on - ideally tagged with ticketing system's ticket id). GitHooks configured in the codebase will perform static code analysis, linting and build dockuments before the commit.

    The Developer can then create a PR to the release branch, or wait to see the status of the basic validations before they create the PR.

    Developers can check other developers PR and the PR's check statuses to approve/reject the PR. This can also be performed by Sr. Developer, Team Lead or Engineering manager.
- **Dev Pipeline:**  
    On commit to the feature branch, CI automation is triggered (GitHub Actions, GitLab CI, Jenkins etc,.). This automation runs unit test, builds a test image, deploys the test image in the dev infrastructure and runs basic validations configured (eg., smoke tests) on the chosen remote depoyment (EC2 or EKS). If all the checks are passed, the branch is marked as "validations passed" (against the latest commit).
- **Pre-Merge Pipeline:**  
    On PR craetion towards the release branch, CI automation is triggered (GitHub Actions, GitLab CI, Jenkins etc,.). This automation runs unit test, builds a test image, deploys the test image in the dev infrastructure and runs all the validations configured (smoke tests, integration tests, end-to-end tests, security/vulnerability scanning etc.,) on the chosen remote depoyment (EC2 or EKS). If all the checks are passed, then the PR is marked safe to merge.
- **Release Pipeline:**  
    On PR merge to release branch, CD (Continuous Delivery) automation is triggered. This automation builds a release candidate image and pushes it to the release container registry. Where the image will be stored, until deployment is triggered (either manually or autmatically)

    ![Release pipeline diagram](./diagrams/Release%20Pipeline.drawio.png)
- **Deployment Pipeline (Manual trigger adviced in prodiction):**  
    Argo CD setup inside the EKS clusters (DEV, STAGING, PROD) will be monitoring the changes in the respective container image registry. When a new image is found, it attempts to create pods with the new image, while retaining the old pods. When the new pods pass the readiness check, the old pods will be terminated and the new pods will serve traffic. (old pod termination happens gracefully without terminating any running connections prematurely). If the new pods fail the readiness check, the deployment is aborted and the old pods continue to serve the traiffic - effectively rolling back the deployment. (Monitoring would alert the engineer about this issue).

    The above is primarily for the DEV environment. For STAGING and PROD, it is adviced to keep the deployment trigger manual. This way, we can control what goes to production when. This also allows us to release a newer version of conponent while retaining older version of other components or to keep both versions running for market experimentations etc.,

    ![Deployment pipeline diagram](./diagrams/Deployment%20Pipeline.drawio.png)
- **Cost saving automations:**
    A Lambda function will automatically scale down or shut down non-essential infrastructure (e.g., dev EC2, EKS, etc.,) at the end of each workday to minimize costs, and scale it back up at the start of the next business day.

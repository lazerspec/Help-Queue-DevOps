## Help Queue Application DevOps ## 

This repository contains the DevOps files required to create
the infrastructure on AWS via Terraform and install required software 
via Ansible. 

The Kubernetes folder has the required deployments and services to run the application
on a Kubernetes cluster. The loadbalancer folder contains the reverse proxy template, which when the
API and UI services cluster IPs are known they can be inserted into the proxy.

## Other Documents 

Diagrams for the project: 

Initial ER Diagram:

![Alt text](projectDocs/InitialERDiagram.png?raw=true "Initial ER Diagram")

Updated Diagram:

![Alt text](projectDocs/UpdatedERDiagram.png?raw=true "Updated ER Diagram")


Initial Sequence Diagram:

![Alt text](projectDocs/HelpQueueSequenceDiagram.png?raw=true "Initial Sequence Diagram")


Risk Assessment:

Please see in the projectDocs/ folder for the HelpQueueRiskAssessment.pdf

Initial Selenium Testing: 

Please see in the projectDocs/ folder for the Help-Queue.side


Project Jira Board:

https://id.atlassian.com/invite/p/jira-software?id=2XCnPWM7T46eWtr7cfA5Cg

Project Video link:

https://drive.google.com/file/d/1LgxWMzZlzykA7MaSqBXkUgVBpDt9E-DO/view?usp=sharing

0 - 2:15 min - Terraform Provisioning 

2:16 - 3:15 min - Ansible 

3:16 - 3:35 min - Jenkins configuration

3:36 - 6:42 min - Kubernetes deployment

6:43 - 11:11 min -  Nginx loadbalancer pipeline

11:12 - 17:11 min - Application Demo

17:12 - 19:45 min - API and UI pipelines create new image

19:46 - 22:52 min - Demo rolling/automatic update from webhook

22:53 - 25:16 min - Show configuration files 

25:17 - 25:36 min - Show test coverage

25:37 - 26:04 min - Show Jira board

26:05 - 26:51 - Show kubernetes deployed pods

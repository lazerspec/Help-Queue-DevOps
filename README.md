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

![Alt text](projectDocs/Initial ER Diagram.png?raw=true "Initial ER Diagram")

Updated Diagram:

![Alt text](projectDocs/UpdatedERDiagram.png?raw=true "Updated ER Diagram")


Initial Sequence Diagram:

![Alt text](projectDocs/Help Queue Sequence Diagram.png?raw=true "Initial Sequence Diagram")


Risk Assessment:

Please see in the projectDocs/ folder for the HelpQueueRiskAssessment.pdf

Initial Selenium Testing: 

Please see in the projectDocs/ folder for the Help-Queue.side


Project Jira Board:

https://id.atlassian.com/invite/p/jira-software?id=2XCnPWM7T46eWtr7cfA5Cg

Project Video link:

https://drive.google.com/file/d/1LgxWMzZlzykA7MaSqBXkUgVBpDt9E-DO/view?usp=sharing

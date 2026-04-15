# ThreeTierVMSS-APLB-Infra

This consists of the following :
1. One Resource Group for logical separation of resources
2. One Virtual Network to provide private ip addresses to your connected devices
3. Multiple subnet like:
     ApplicationGatewaySubnet dedicated to application gateway
     FontendSubnet that contains all the frontend compute resources like vmss server
     BackendSubnet that contains all the backend compute resources like vmss server
     AzureBastionSubnet dedicated to Azure bastion to provide secure connectivity to backend vmss over the web terminal
4. Application Gateway to receive the traffic from the frontend
5. Internal load balancer to handle the traffic between the frontend vmss and backend vmss
6. Azure SQL database for the storage of data
7. We have to create the Network Address Translation Gateway for backend vmss to download the code from internet like from github
8. We have to create the server proxy just to forward the traffic from frontend to backend

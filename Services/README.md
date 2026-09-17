# CLUSTER_IP: 

## Deploy the Backend Web Application

![alt text](image.png)

## get svc : 
![alt text](image-1.png)


## Check Website Traffic on ClusterIP: 


### Internal Test Pod (Production-Style Verification)
Query by Service Name (CoreDNS resolution):
![alt text](image-2.png)

Query by Fully Qualified Domain Name (FQDN):
![alt text](image-3.png)


## Port-Forward to Local Browser (Developer Debugging) :
![alt text](image-4.png)
![alt text](image-5.png)

## get svc :
![alt text](image-6.png)

## CleanUp: 

![alt text](image-7.png)


# NODEPORT :

## Run and Deploy:
![alt text](image-8.png)


## Check Website Traffic on NodePort:
![alt text](image-9.png)
![alt text](image-10.png)

## cleanup :
![alt text](image-11.png)


# LoadBalancer :


## Run and Deploy:
![alt text](image-12.png)


## Check Website Traffic on LoadBalancer:
### In Local Development (Minikube / Docker Desktop):

![alt text](image-13.png)
![alt text](image-14.png)
![alt text](image-15.png)

###  Direct Minikube Service Access :
![alt text](image-16.png)


## Cleanup:
![alt text](image-17.png)


# ExternalName :

## Run and Deploy :
![alt text](image-18.png)

##  Verify DNS CNAME Resolution:

![alt text](image-19.png)

## Cleanup :
![alt text](image-20.png)


# Headless Service :

## Run and Deploy
![alt text](image-21.png)


## Check DNS & Traffic on Headless Service:

![alt text](image-22.png)
![alt text](image-23.png)


## Cleanup:
![alt text](image-24.png)



## pod.yml :

![alt text](image.png)



## deployment.yml :

![alt text](image-1.png)


## replicaset.yml :

![alt text](image-2.png)



## replicaset.yml logs :

![alt text](image-3.png)

# Tried running hello.yml again :

![alt text](image-4.png)

`The hello-pod already exists, and your YAML hasn't changed anything.`


## Tried deleting one pod from both Deployment and Replicaset :

# they again created one-- 


![alt text](image-5.png)


## Deleted nginx and hello-pod :

![alt text](image-6.png)


## Deleted Deployments :
![alt text](image-7.png)


## Deleted Replicasets:
![alt text](image-8.png)





# Check Kubernetes Controllers

kubectl get deployments
# Issue: Shows Deployments that manage Pods and can recreate them if deleted.

kubectl get replicasets
# Issue: Shows ReplicaSets that maintain the desired number of Pods and recreate deleted Pods.

# Delete the Deployment

kubectl delete deployment nginx-deployment
# Issue: Deletes the nginx Deployment and stops it from managing/recreating its Pods.

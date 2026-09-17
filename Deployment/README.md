# Running canary :
## app-stable 
![alt text](image.png)

![alt text](image-1.png)

## creating service :
![alt text](image-2.png)

## Test — All Traffic Goes to Stable v1

![alt text](image-3.png)

![alt text](image-4.png)

![alt text](image-5.png)

## Deploying Canary , and checking the labels :
![alt text](image-6.png)


## Verifying Traffic Split in Real Time
![alt text](image-8.png)

![alt text](image-7.png)


## Increasing Canary Traffic to 30% (3 out of 10 Pods)
![alt text](image-9.png)

![alt text](image-10.png)

### Re-run the traffic test:
![alt text](image-11.png)

![alt text](image-12.png)

## Promote Canary to 100% (Canary is Healthy)
![alt text](image-13.png)

![alt text](image-14.png)
![alt text](image-15.png)

## clean up old stable deployment
![alt text](image-16.png)

## Rollback Canary (Canary is Broken): 

`as in step 7A we deleted all the stable deployments`
![alt text](image-17.png)


## Cleanup :
![alt text](image-18.png)
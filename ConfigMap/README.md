## ConfigMap:
![alt text](image.png)

## Readning a configmap:
![alt text](image-1.png)


## DB_SECRET:
### Generating Base64 Values Yourself:

` [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("Nandani"))`
![alt text](image-2.png)

## Apply and inspect :
![alt text](image-3.png)

##  Decode a Secret Value (for debugging):
`[System.Text.Encoding]::UTF8.GetString(
    [System.Convert]::FromBase64String(
        (kubectl get secret yatri-db-secret -o jsonpath='{.data.POSTGRES_PASSWORD}')
    )
)`


![alt text](image-4.png)

### kubectl get secrets,configmaps :
![alt text](image-5.png)


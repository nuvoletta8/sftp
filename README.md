# SFTP Container
This container enables you to run SFTP on Openshift 

## Installation 

### Generate Keys

Generate the keys needed with `helpers/generatekeys.sh` and put the keys on different files on /keys directory.
I left 2 example file that are fine, but if you would to change the certificate, you can use that script to re-generate.

The script is made by https://github.com/amazeeio and you can find [here](https://github.com/amazeeio/sftp) the originial project that i forked.


### Change username and password

Change the Environment variables `SFTP_USER` and `SFTP_PASSWORD` in the `Dockerfile`

```
ENV SFTP_USER 'sftp'
ENV SFTP_PASSWORD 'thispasswordneedstobechanged'
```


### Build container

Create the image for your container, from the directory where the Dockerfile is located

```
$ sudo docker build -t my-sftp-server .
```

Upload the new images to the openshift internal registry

```
$ sudo docker login your.internal.registry
$ sudo docker tag my-sftp-server your.internal.registry/your-desired-project/sftp-server
$ sudo docker push your.internal.registry/your-desired-project/sftp-server
```

Now the image of your sftp-server is ready for deploy

```
$ oc login to-your-openshift
$ oc new-app sftp-server
```

### Open Openshift Nodeport

To use the NodePort option, edit the default service created by the new-app, or delete ed recreate it using the service-nodeport.yml .




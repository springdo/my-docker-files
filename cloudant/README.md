# Installation instructions

## Prerequisites
- Git client
- Docker & Docker machine (get it on https://docs.docker.com/engine/installation)
- **Important**: if you are using Docker v1.9.x (check with `docker --version`), see next section

## Dealing with Docker v1.9.x
There is a known incompatibility between certain Linux kernel releases and the `AuFS` filesystem (see [this link](https://github.com/docker/docker/issues/18180)) for Docker releases v1.9.x. This incompatibility prevents (among other potential issues) the installation of the OpenJDK 6 on Docker containers. The bypass is to use a Docker Machine that uses `OverlayFS` as the storage driver. Here is how to proceed:

- First, check if your default Docker Machine is not already using `OverlayFS` as the storage driver (replace `default` with the name of your Docker Machine if you don't use the defaut one):

```
# docker-machine inspect default
{
    "ConfigVersion": 3,
    "Driver": {
        ...
    },
    "DriverName": "virtualbox",
    "HostOptions": {
        "Driver": "",
        "Memory": 0,
        "Disk": 0,
        "EngineOptions": {
            ...
            "StorageDriver": "overlay",
            ...
        },
        ...
    },
    "Name": "default"
}
```

- If your configuration does not show `"overlay"` for the `"StorageDriver"`, then you need to create a new Docker Machine (note: replace the `-d virtualbox` with your virtualization engine if you don't use default Virtual Box):

```
# docker-machine create -d virtualbox --engine-storage-driver overlay overlay
``` 

- Finally, setup Docker to use the newly created **overlay** machine:

```
# eval $(docker-machine env overlay)
```

Note: You may prefer to re-create your **default** machine with `OverlayFS`.
## Building & running the container
- Use a Docker-enabled terminal window
- Check your Docker machine is running:

```
# docker-machine status $DOCKER_MACHINE_NAME
Running
```

If you see something different than ````Running````, check your Docker environment and make sure your Docker Machine is up & running

- Clone this repository:

```
# git clone http://po.toolbox:7990/stash/scm/cm/scripts.git
```

- Enter the Cloudant Dockerfile directory:

```
# cd Dockerfiles/cloudant
```

- Optional: update default users & passwords from file `cloudant-install/configure-service.sh`
By default, admin user is `admin` and admin password is `admin`

- Then build your Docker image:

```
# docker build -t po/cloudant .
```
- You can now run your container:

```
# docker run -h cloudant -d -p 80:80 po/cloudant
```

- Your Cloudant container is quite ready - give it approx. 30 secs to come up. Then just enter:

```
# ./cloudant-helper.sh
```

You will get the Cloudant admin URI (use your favorite browser) and a default `VCAP_SERVICES.json` will be generated for you.


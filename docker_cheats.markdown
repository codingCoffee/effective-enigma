Understanding docker
--------------------

### Installation

1.  Install docker

``` {.bash}
sudo apt-get remove docker docker-engine docker.io
sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get install docker-ce
```

1.  Install docker-compose

``` {.bash}
docker sudo curl -L https://github.com/docker/compose/releases/download/1.17.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose #use the latest docker-compose version, by looking at releases on github pages [https://github.com/docker/compose/releases]
docker sudo chmod +x /usr/local/bin/docker-compose
```

### Post Installation stuff

1.  Allow docker usage without sudo access

The docker daemon binds to a Unix socket instead of a TCP port. By
default that Unix socket is owned by the user root and other users can
only access it using sudo. The docker daemon always runs as the root
user. To prevent using sudo when you use the docker command, create a
Unix group called docker and add users to it. When the docker daemon
starts, it makes the ownership of the Unix socket read/writable by the
docker group

``` {.bash}
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
```

### Usage README

1.  Images

Images are read only We upload images to hub Think of them as classes

1.  Containers

Containers boot up from images Think of them as instance of a class

1.  Dockerfile can be used to build docker images

2.  To list all images available on your system

``` {.bash}
docker images
```

1.  To list all containers

``` {.bash}
docker ps -a
```

1.  To pull images from the docker hub, for example for pulling the
    ubuntu image

``` {.bash}
docker pull ubuntu
```

By default the latest tag is pulled

1.  To pull a specific tag, lets say the tag is 12.04

``` {.bash}
docker pull ubuntu:12.04
```

1.  To delete an image

``` {.bash}
docker rmi {image_name}:{tag}
```

or

``` {.bash}
docker rmi {IMAGE_ID}
```

1.  To create a container and run it

``` {.bash}
docker run -it {ID} /bin/bash
```

-i stands for interactive -t stands for pseudo tty /bin/bash is for
specifying the path to the shell to be run ID can be an IMAGE~ID~ or a
CONTAINER~ID~ obtained by listing all images, or containers respectively
Note: Every time you use \`docker run\` using the IMAGE~ID~, a new
container is created based on the IMAGE

Extra bits: --rm if passed, causes the container to automatically get
deleted after exit

1.  To exit a container

``` {.bash}
exit
```

1.  To start a container

``` {.bash}
docker start {CONTAINER_ID}
```

1.  To stop a container

``` {.bash}
docker stop {CONTAINER_ID}
```

1.  To delete a container

``` {.bash}
docker rm {CONTAINER_ID}
```

1.  To build your own docker image using a Dockerfile

``` {.bash}
docker build -t {username}/{image_name}:{image_tag} .
```

1.  To delete dangling images

``` {.bash}
docker rmi $(docker images -f dangling=true -q)
```

1.  Save an existing docker container as an image

``` {.bash}
docker commit {CONTAINER_ID} {IMAGE_NAME}:{IMAGE_TAG}
```

1.  Saving an image as a tar file

``` {.bash}
docker save {IMAGE_ID} -o {tar_file}
```

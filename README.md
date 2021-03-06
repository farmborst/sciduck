# SciDuck
Debian based Docker container for Science with JupyterLab.
User id mapping from non-root user inside the docker container to the user-id given with the docker run command provides easy access to common filesystems and enhanced (not really!) security. Preinstalled Jupyter kernels:
- Python 3.7.5
- Python 2.7.17
- Julia 1.2
- Octave 4.4.1
- R 3.6.1

Look into the Dockerfile to see the respective preinstalled modules


## Getting Started
### Prerequisites
- [Install](https://docs.docker.com/install/linux/docker-ce/debian/#install-docker-ce) and [setup](https://docs.docker.com/install/linux/linux-postinstall/) Docker CE
- Install git
```
apt-get install git
```

### Installation
- get your local copy of this git repository
```
git clone https://github.com/farmborst/sciduck.git
```
- build the docker image
```
docker build . -t debian:sciduck
```

### Usage
- run the docker image
```
docker run -v /:/mnt/dockershare --network host -e HOST_USER_ID=$(id -u) -e HOST_USER_GID=$(id -g) -ti debianstretch:sciduck
```
- start JupyterLab
```
jupyter-lab --NotebookApp.token='yourpassword' 
```
- access jupyter lab from the webbrowser of your host machine and have fun ...
```
localhost:8888
```

## Distribution to other machines without build process
- Save the Docker image existing in your local Docker registry after building it.
```
docker save -o sciduck_amd64.tar debian:sciduck
```
- Copy the created tar file and the runfile to other machine
- Add the Docker image built to local repository of other machine
```
docker load -i sciduck_amd64.tar
```


## Authors
- **Felix Armborst** - *Initial Work*

## License
This project is licensed under the copyleft GNU GENERAL PUBLIC LICENSE Version 3 - see the [LICENSE.md](LICENSE.md) file for details

# SciDuck
Debian based Docker container for Science with JupyterLab


## Getting Started
### Prerequisites
- [Install](https://docs.docker.com/install/linux/docker-ce/debian/#uninstall-docker-ce) and [setup](https://docs.docker.com/install/linux/linux-postinstall/) Docker CE
- Install git
```
>>  apt-get install git
```

### Installation
- get your local copy of this git repository
```
>> git clone https://github.com/farmborst/sciduck.git
```
- build the docker image
```
>> docker build . -t debianstretch:sciduck
```

### Usage
- make runfile executable
```
>> chmod +x run 
```
- run the docker image
```
>> ./run
```
- start JupyterLab

```
>> jupyter-lab --NotebookApp.token='yourpassword' 
```
- access jupyter lab from the webbrowser of your host machine and have fun ...
```
>> localhost:8888
```

## Distribution of the created Docker Image to other machines (skip long build process)
- Save the Docker image existing in your local Docker registry after building it.
```
>> docker save -o sciduck_amd64.tar debian:sciduck
```
- Copy the created tar file and the runfile to other machine
- Add the Docker image built to local repository of other machine
```
>> docker load -i sciduck_amd64.tar
```


## Authors
- **Felix Armborst** - *Initial Work*

## License
This project is licensed under the copyleft GNU GENERAL PUBLIC LICENSE Version 3 - see the [LICENSE.md](LICENSE.md) file for details

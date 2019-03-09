####################################
#### Debian-Stretch Environment ####
####################################
FROM debian:stretch

# set args for build only
ARG DEBIAN_FRONTEND=noninteractive

# set environment variables that persist for docker run
ENV DUCK=sciduck \
    USER=sciduckusr \
    GROUP=sciduckusr \
    USER_ID=1000 \
    USER_GID=1000 \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    TZ=Europe/Berlin

COPY dotfiles/apt_preferences /etc/apt/preferences
COPY dotfiles/sources.list /etc/apt/
COPY dotfiles/backports.list /etc/apt/sources.list.d/

# create user and apt-install dependencies
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
  && echo $TZ > /etc/timezone \
  && apt-get update \
  && apt-get -y -q install apt-utils apt-transport-https \
  && apt-get -y -q upgrade \
  && apt-get -y -q dist-upgrade \
  && apt-get -y -q install \
    gosu \
    htop \
    screen \
    vim \
    emacs \
    tmux \
    git \
    openssl \
    libx11-dev \
    libxt-dev \
    make \
    gfortran \
    g++ \
    gcc \
    perl \
    libreadline-dev \
    alien \
    libgsl2 \
    libboost-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libomp-dev \
    libgomp1 \
    libgomp1-dbg \
    libopenblas-base \
    libopenblas-dev \
    libatlas3-base \
    libatlas-base-dev \
    libatlas-dev \
    mpich \
    virtualenv \
    python-dev \
    python3-dev \
    python-virtualenv \
    python3-virtualenv \
    python-tk \
    python3-tk \
    python-pyqt5 \
    python-qtpy \
    libgdbm-dev \
    tk-dev \
    libsqlite3-dev \
    libffi-dev \
    uuid-dev \
    wget \
  && apt-get install -y -q -t stretch-backports \
    nodejs \
    intel-mkl \
    libgl1-mesa-glx \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    octave \
  && groupadd --gid "${USER_GID}" "${USER}" && \
    useradd \
    --uid ${USER_ID} \
    --gid ${USER_GID} \
    --create-home \
    --shell /bin/bash \
    --groups users \
    ${USER} \
  && chmod g+s /opt \
  && chgrp -R users /opt/


#########################
##### nodejs and npm ####
#########################
COPY dotfiles/nodesource.list /etc/apt/sources.list.d/
RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - \
  && apt-get update \
  && apt-get -y -q install nodejs


##################################
##### Python 3.5.3 Virtualenv ####
##################################
RUN virtualenv --python=python3 --no-site-packages /opt/python/venv_python3.5.3 \
  && /bin/bash -c "\
	 source /opt/python/venv_python3.5.3/bin/activate \
	  && pip install --upgrade \
      pip \
      numpy \
      scipy \
      pandas \
      sympy \
      h5py\
      matplotlib \
      pyfftw \
      jupyter \
      jupyterlab \
      jupyterthemes \
      tensorflow \
      deap \
      nose \
      scikit-learn \
      vtk \
      pyepics \
      ipympl \
      pandas_datareader \
      bs4 \
      numba \
      numexpr \
      octave_kernel \
	  && pip install --upgrade \
      mayavi \
	  && jupyter labextension install @jupyter-widgets/jupyterlab-manager \
	  && jupyter labextension install jupyter-matplotlib"


###################################
##### Python 2.7.13 Virtualenv ####
###################################
RUN virtualenv --python=python2 --no-site-packages /opt/python/venv_python2.7.13 \
  && /bin/bash -c "\
	source /opt/python/venv_python2.7.13/bin/activate \
	&& pip install --upgrade \
		pip \
		numpy \
		scipy \
		pandas \
		sympy \
		h5py \
		matplotlib \
		pyfftw \
		tensorflow \
		deap \
		nose \
		scikit-learn \
		vtk \
		pyepics \
		ipympl \
		pandas_datareader \
		bs4 \
		numba \
		numexpr \
	&& pip install --upgrade \
		mayavi \
	&& ln -s /usr/lib/python2.7/dist-packages/PyQt5/ /opt/python/venv_python2.7.13/lib/python2.7/site-packages/ \
	&& ln -s /usr/lib/python2.7/dist-packages/sip.x86_64-linux-gnu.so /opt/python/venv_python2.7.13/lib/python2.7/site-packages/" 


##################################
##### Python 3.6.8 Virtualenv ####
##################################
RUN wget -P /opt/python/ 'https://www.python.org/ftp/python/3.6.8/Python-3.6.8.tar.xz' \
  && tar --no-same-owner --no-same-permissions -xf /opt/python/Python-3.6.8.tar.xz -C /opt/python/ \
  && rm /opt/python/*.tar.xz \
  && cd /opt/python/Python-3.6.8/ \
  && ./configure --prefix=/opt/python/ --enable-optimizations \
  && make -j8 \
  && make altinstall \
  && virtualenv --python=/opt/python/bin/python3.6 --no-site-packages /opt/python/venv_python3.6.8 \
  && /bin/bash -c "\
	 source /opt/python/venv_python3.6.8/bin/activate \
	  && pip install --upgrade \
      pip \
      numpy \
      scipy \
      pandas \
      sympy \
      h5py\
      matplotlib \
      pyfftw \
      tensorflow \
      deap \
      nose \
      scikit-learn \
      vtk \
      pyepics \
      jupyterthemes \
      ipympl \
      pandas_datareader \
      bs4 \
      numba \
      numexpr \
      ipykernel"





##################################
##### Python 3.7.2 Virtualenv ####
##################################
RUN wget -P /opt/python/ 'https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tar.xz' \
  && tar --no-same-owner --no-same-permissions -xf /opt/python/Python-3.7.2.tar.xz -C /opt/python/ \
  && rm /opt/python/*.tar.xz \
  && cd /opt/python/Python-3.7.2/ \
  && ./configure --prefix=/opt/python/ --enable-optimizations \
  && make -j8 \
  && make altinstall \
  && virtualenv --python=/opt/python/bin/python3.7 --no-site-packages /opt/python/venv_python3.7.2 \
  && /bin/bash -c "\
	 source /opt/python/venv_python3.7.2/bin/activate \
	  && pip install --upgrade \
		pip \
		numpy \
		scipy \
		pandas \
		sympy \
		h5py\
		matplotlib \
		pyfftw \
		deap \
		nose \
		scikit-learn \
		vtk \
		pyepics \
		ipympl \
		pandas_datareader \
		bs4 \
		numba \
		numexpr \
   ipykernel"


########################################
#### R (https://www.r-project.org/) ####
########################################
COPY --chown=root:users packages/r_packages.r /opt/R/
RUN /bin/bash -c "mkdir -p /opt/R/Rpackages/ \
  && export GPG_TTY='/dev/tty' \
  && export R_LIBS='/opt/R/Rpackages/' \
  && echo 'deb https://cloud.r-project.org/bin/linux/debian stretch-cran35/' >> /etc/apt/sources.list.d/cran.list \
  && apt-key adv --no-tty --keyserver ipv4.pool.sks-keyservers.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF' \
  && apt-get -y -q update \
  && apt-get install -y -q r-base libunwind8-dev \
  && R -f /opt/R/r_packages.r"


##################################################
#### julia (https://julialang.org/downloads/) ####
##################################################
COPY --chown=root:users packages/julia_packages.jl /opt/julia
RUN /bin/bash -c " source /opt/python/venv_python3.5.3/bin/activate \
  && wget -P /opt/julia/ 'https://julialang-s3.julialang.org/bin/linux/x64/1.1/julia-1.1.0-linux-x86_64.tar.gz' \
  && tar --no-same-owner --no-same-permissions -xf /opt/julia/*tar.gz -C /opt/julia/ \
  && rm /opt/julia/*.tar.gz \
  && export JULIA_DEPOT_PATH=/opt/julia/julia-1.1.0/local/share/julia:/opt/julia/julia-1.1.0/share/julia \
  && /opt/julia/julia-1.1.0/bin/julia /opt/julia/julia_packages.jl"


###############################################
### add kernels to virtualenv with jupyter ####
###############################################
RUN /bin/bash -c " source /opt/python/venv_python3.5.3/bin/activate \
 && export R_LIBS='/opt/R/Rpackages/'  \
 && export JUPYTER_PATH=/opt/python/venv_python3.5.3/share/jupyter/ \
 && /usr/bin/R --silent -e 'IRkernel::installspec(name = \"ir35\", displayname = \"R 3.5\", prefix=\"/opt/python/venv_python3.5.3/\")' \
 && /opt/python/venv_python2.7.13/bin/python -m ipykernel install --prefix=/opt/python/venv_python3.5.3/ --name python2.7.13 --display-name 'Python 2.7.13' \
 && /opt/python/venv_python3.5.3/bin/python -m ipykernel install --prefix=/opt/python/venv_python3.5.3/ --name python3.5.3 --display-name 'Python 3.5.3' \
 && /opt/python/venv_python3.6.8/bin/python -m ipykernel install --prefix=/opt/python/venv_python3.5.3/ --name python3.6.8 --display-name 'Python 3.6.8' \
 && /opt/python/venv_python3.7.2/bin/python -m ipykernel install --prefix=/opt/python/venv_python3.5.3/ --name python3.7.2 --display-name 'Python 3.7.2' \
 && chmod -R 775 /opt/"


##################
#### dotfiles ####
##################
COPY --chown=root:users dotfiles/jupyter_notebook_config.py /opt/python/venv_python3.5.3/etc/jupyter/
COPY dotfiles/bashrc /home/$USER/.bashrc 
COPY dotfiles/vimrc /home/$USER/.vimrc


##################	
#### Clean-Up ####
##################
RUN apt-get clean \
 &&  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#####################	
#### Entry-Point ####
#####################
COPY dotfiles/user-mapping.sh /root/
RUN chmod +x /root/user-mapping.sh
ENTRYPOINT ["/root/user-mapping.sh"]
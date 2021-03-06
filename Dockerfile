############################
#### Debian Environment ####
############################
FROM debian:buster

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
    libgsl23 \
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
    libxm4 \
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
    curl \
    ffmpeg \
    dvipng \
    ghostscript \
    texlive-science \
    texlive-fonts-extra \
    intel-mkl \
    libgl1-mesa-glx \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    octave \
    nodejs \
    npm \
    wget \
    csh \
    libgsl-dev \
    gzip \
    libhdf5-dev \
    libblas-dev \
    liblapack-dev \
    libpng-dev \
    libxaw7-dev \
    libmotif-dev \
    libncurses5-dev \
    rpm \
    subversion \
    tar \
    tcl-dev \
    libtiff5-dev \
    unzip \
    zlib1g-dev \
    libbz2-dev \
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


##############################
##### Python 3 Virtualenv ####
##############################
ARG py3ver="3.7.5"
RUN mkdir /opt/python && curl "https://www.python.org/ftp/python/${py3ver}/Python-${py3ver}.tar.xz" --output /opt/python/Python-${py3ver}.tar.xz \
  && tar --no-same-owner --no-same-permissions -xf /opt/python/Python-${py3ver}.tar.xz -C /opt/python/ \
  && rm /opt/python/Python-${py3ver}.tar.xz \
  && cd /opt/python/Python-${py3ver}/ \
  && ./configure --prefix=/opt/python/ --enable-optimizations \
  && make -j8 \
  && make altinstall \
  && virtualenv --python=/opt/python/bin/python3.7 --no-site-packages /opt/python/venv_python${py3ver} \
  && ln -s /opt/python/venv_python${py3ver}/bin/activate /opt/python/activatepy3venv \
  && /bin/bash -c "\
   source /opt/python/venv_python${py3ver}/bin/activate \
    && pip install --no-cache-dir --upgrade \
      pip \
      cpython \
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
      tensorflow-gpu \
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
      pillow \
      pymongo \
      ipykernel \
      octave_kernel \
      llvmlite \
      bokeh \
      imageio \
      imageio-ffmpeg \
      lmfit \
      pyqt5 \
    && pip install --upgrade \
      mayavi \
    && jupyter labextension install @jupyter-widgets/jupyterlab-manager \
    && jupyter labextension install jupyter-matplotlib \
    && jupyter labextension install jupyterlab_bokeh \
    && deactivate"



##############################
##### Python 2 Virtualenv ####
##############################
ARG py2ver="2.7.17"
RUN curl "https://www.python.org/ftp/python/${py2ver}/Python-${py2ver}.tar.xz" --output /opt/python/Python-${py2ver}.tar.xz \
  && tar --no-same-owner --no-same-permissions -xf /opt/python/Python-${py2ver}.tar.xz -C /opt/python/ \
  && rm /opt/python/Python-${py2ver}.tar.xz \
  && cd /opt/python/Python-${py2ver}/ \
  && ./configure --prefix=/opt/python/ --enable-optimizations --enable-unicode=ucs4 \
  && make -j8 \
  && make altinstall \
  && virtualenv --python=/opt/python/bin/python2.7 --no-site-packages /opt/python/venv_python${py2ver} \
  && /bin/bash -c "\
  source /opt/python/venv_python${py2ver}/bin/activate \
    && pip install --no-cache-dir --upgrade \
      pip \
      cpython \
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
      pillow \
      pymongo \
      bokeh \
      imageio \
      lmfit \
    && pip install --upgrade \
      mayavi \
    && deactivate" \
  && ln -s /usr/lib/python2.7/dist-packages/PyQt5/ /opt/python/venv_python${py2ver}/lib/python2.7/site-packages/ \
  && ln -s /usr/lib/python2.7/dist-packages/sip.x86_64-linux-gnu.so /opt/python/venv_python${py2ver}/lib/python2.7/site-packages/


########################################
#### R (https://www.r-project.org/) ####
########################################
ARG rver="3.6.1"
COPY --chown=root:users packages/r_packages.r /opt/R/
RUN /bin/bash -c "mkdir -p /opt/R/Rpackages/ \
  && export GPG_TTY='/dev/tty' \
  && export R_LIBS='/opt/R/Rpackages/' \
  && echo 'deb https://cloud.r-project.org/bin/linux/debian buster-cran35/' >> /etc/apt/sources.list.d/cran.list \
  && while true; do apt-key adv --no-tty --keyserver ipv4.pool.sks-keyservers.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF' && break || echo 'Trying again...'; done \
  && apt-get -y -q update \
  && apt-get install -y -q r-base libunwind8-dev \
  && R -f /opt/R/r_packages.r"


##################################################
#### julia (https://julialang.org/downloads/) ####
# Version must also be updated in bashrc file !!!!
##################################################
ARG jlver="1.2.0"
COPY --chown=root:users packages/julia_packages.jl /opt/julia/  
RUN /bin/bash -c " source /opt/python/venv_python${py3ver}/bin/activate \
  && curl "https://julialang-s3.julialang.org/bin/linux/x64/1.2/julia-${jlver}-linux-x86_64.tar.gz" --output /opt/julia/julia.tar.gz  \
  && tar --no-same-owner --no-same-permissions -xf /opt/julia/julia.tar.gz -C /opt/julia/ \
  && rm /opt/julia/julia.tar.gz \
  && export JULIA_DEPOT_PATH=/opt/julia/julia-${jlver}/local/share/julia:/opt/julia/julia-${jlver}/share/julia \
  && export PYTHON="/opt/python/venv_python${py3ver}/bin/python" \
  && export JUPYTER="/opt/python/venv_python${py3ver}/bin/jupyter" \
  && export JUPYTER_IPYKERNEL="/opt/python/venv_python${py3ver}/share/jupyter" \
  && /opt/julia/julia-${jlver}/bin/julia /opt/julia/julia_packages.jl"


###############################################
### add kernels to virtualenv with jupyter ####
###############################################
RUN /bin/bash -c " source /opt/python/venv_python${py3ver}/bin/activate \
 && export R_LIBS='/opt/R/Rpackages/'  \
 && export JUPYTER_PATH=/opt/python/venv_python${py3ver}/share/jupyter/ \
 && /usr/bin/R --silent -e 'IRkernel::installspec(name = \"r\", displayname = \"R ${rver}\", prefix=\"/opt/python/venv_python${py3ver}/\")' \
 && /opt/python/venv_python${py2ver}/bin/python -m ipykernel install --prefix=/opt/python/venv_python${py3ver}/ --name python2 --display-name 'Python ${py2ver}' \
 && /opt/python/venv_python${py3ver}/bin/python -m ipykernel install --prefix=/opt/python/venv_python${py3ver}/ --name python3 --display-name 'Python ${py3ver}' \
 && chmod -R 775 /opt/"


##################
#### dotfiles ####
##################
COPY dotfiles/jupyter_notebook_config.py /home/$USER/.jupyter/jupyter_notebook_config.py
COPY dotfiles/sciduck /home/$USER/sciduck
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

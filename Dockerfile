FROM jupyter/scipy-notebook:aec555e49be6

# Fix DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    gfortran \
    gcc && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER $NB_UID

# R packages including IRKernel which gets installed globally.
RUN conda install --quiet --yes \
    'r-base=4.0.3'  \
    'r-caret=6.0*' \
    'r-crayon=1.3*' \
    'r-devtools=2.3*' \
    'r-forecast=8.13*' \ 
    'r-hexbin=1.28*' \
    'r-htmltools=0.5*' \
    'r-htmlwidgets=1.5*' \ 
    'r-irkernel=1.1*' \
    'r-nycflights13=1.0*' \
    'r-randomforest=4.6*' \
    'r-rcurl=1.98*' \
    'r-rmarkdown=2.6*' \
    'r-rsqlite=2.2*' \
    'r-shiny=1.5*' \
    'r-tidyverse=1.3*' \
    'rpy2=3.3*' && \
    conda clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

USER root

RUN \
    # download R studio
    curl --silent -L --fail https://s3.amazonaws.com/rstudio-ide-build/server/bionic/amd64/rstudio-server-1.2.1578-amd64.deb > /tmp/rstudio.deb && \
    echo '81f72d5f986a776eee0f11e69a536fb7 /tmp/rstudio.deb' | md5sum -c - && \
    \
    # install R studio
    apt-get update && \
    apt-get install -y --no-install-recommends /tmp/rstudio.deb && \
    rm /tmp/rstudio.deb && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER ${NB_USER}

# otter-grader requirements
RUN pip install \
        otter-grader==2.1.3 \
        jupytext==1.10.3

# for Rstudio
RUN pip install \
        jupyter-server-proxy==1.6.0 \
        jupyter-rsession-proxy==1.2.0 && \
    jupyter labextension install @jupyterlab/server-proxy

# user installed packages
RUN pip install \
        jupyterlab-git==0.23.3 \
        cookiecutter==1.7.2 && \
    \
    pip install jupyter_http_over_ws>=0.0.8 && \
    jupyter serverextension enable --py jupyter_http_over_ws && \
    \
    pip install jupyterlab_latex==2.0.0 && \
    jupyter labextension install @jupyterlab/latex

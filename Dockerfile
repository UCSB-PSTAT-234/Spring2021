FROM jupyter/scipy-notebook:aec555e49be6

# Fix DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER ${NB_USER}

# otter-grader requirements
RUN pip install \
        otter-grader==2.1.3 \
        jupytext==1.10.3

# user installed packages
RUN pip install \
        jupyterlab-git==0.23.3 \
        cookiecutter==1.7.2 && \
    \
    pip install jupyter_http_over_ws>=0.0.8 && \
    jupyter serverextension enable --py jupyter_http_over_ws && \
    \
    pip install \
        altair==4.1.0 \
        yfinance==0.1.59 \
        cvxpy==1.1.12 && \
    \
    jupyter lab build

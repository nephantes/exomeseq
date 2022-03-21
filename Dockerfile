FROM nfcore/base
MAINTAINER Alper Kucukural <alper.kucukural@umassmed.edu>
description="Docker image for ExomeSeq pipeline"

RUN apt-get update --fix-missing && \
    apt-get install -y vim wget bzip2 ca-certificates curl git libtbb-dev gcc g++ libcairo2-dev pandoc
    
COPY environment.yml /
RUN conda env create -f /environment.yml && conda clean -a

ENV PATH /opt/conda/envs/dolphinnext/bin:$PATH

COPY install_packages.R /
RUN Rscript /install_packages.R


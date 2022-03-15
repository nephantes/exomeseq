FROM nfcore/base
MAINTAINER Alper Kucukural <alper.kucukural@umassmed.edu>
description="Docker image for ExomeSeq pipeline derived from nfcore/exoseq pipelines"

COPY environment.yml /
RUN conda env create -f /environment.yml && conda clean -a
ENV PATH /opt/conda/envs/nfcore-exoseq-0.9dev/bin:$PATH
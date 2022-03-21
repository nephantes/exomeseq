FROM ubuntu:18.04

LABEL author="alper.kucukural@umassmed.edu" description="Docker image containing all requirements for the dolphinnext/exomseq pipeline"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && \
    apt-get install -y vim wget bzip2 ca-certificates curl git libtbb-dev gcc g++ libcairo2-dev pandoc
    
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN curl -L -o mskcc-vcf2maf.tar.gz "https://api.github.com/repos/mskcc/vcf2maf/tarball/v1.6.21"; tar -zxf mskcc-vcf2maf.tar.gz; cd mskcc-vcf2maf-*

COPY environment.yml /
RUN conda env create -f /environment.yml && conda clean -a

RUN mkdir -p /project /nl /mnt /share
ENV PATH /opt/conda/envs/dolphinnext/bin:$PATH

COPY install_packages.R /
RUN Rscript /install_packages.R
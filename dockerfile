# Use Python 3.8.18 slim version as base image
FROM python:3.8.18-slim

# working dir
WORKDIR /opt

# Install Miniconda including Git
RUN apt-get update && apt-get install -y \
        git \
        wget \
        curl \
        g++ \
        gcc \
    && rm -rf /var/lib/apt/lists/* \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-py38_23.11.0-2-Linux-x86_64.sh -O /tmp/miniconda.sh \
	# && wget https://repo.anaconda.com/miniconda/Miniconda3-py38_23.11.0-2-Linux-aarch64.sh -O /tmp/miniconda.sh \
    && /bin/bash /tmp/miniconda.sh -b -p /opt/conda \
    && rm /tmp/miniconda.sh

# Set PATH to include conda
ENV PATH="/opt/conda/bin:$PATH"
RUN conda init bash

# Create a conda environment and activate it
RUN conda create -y --name env && echo "conda activate env" >> ~/.bashrc

# Copy and install Python dependencies && Install packages
COPY requirement.txt requirement.txt
RUN pip install -qr /opt/requirement.txt && pip install -q gdown

# Clone tevatron and install under the root directory
RUN git clone https://github.com/texttron/tevatron && pip install --editable tevatron/.

# Install nodejs (RUN conda install -c conda-forge nodejs && conda upgrade -c conda-forge nodejs)
RUN curl -fsSL https://deb.nodesource.com/setup_21.x | bash - && apt-get install -y nodejs

# Install npm at web-app directory
COPY ./client /opt/client
#COPY client/web-app/package.json /opt/client/web-app/package.json
RUN npm --prefix /opt/client/web-app/ install

# Download Model
# 1jZa3a331CvRf2GF6lyEtXNnKdSbshRJx
# 1yzzhEtw4laj7MB4LrAWaj9_NUlLea77q
RUN mkdir -p Model && \
    gdown 1cq-gwA5q6WuaUlX4qr7-1QOTzzJVthaB -O 'Model/PubMed-w2v.bin' && \
    gdown https://drive.google.com/drive/folders/1MKyOKnrpKAAecmqrsqOSiAew0eNqDjlv --folder -O 'Model/checkpoint-80000' --fuzzy
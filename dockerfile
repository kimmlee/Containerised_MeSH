# Use Python 3.8.18 slim version as base image
FROM python:3.8.18-slim as mesh_server_image

# working dir
WORKDIR /opt

# ------------ (API) server -----------   
# Install miscellaneous packages including Git
RUN apt-get update && apt-get install -y \
        git \
        wget \
        curl \
        g++ \
        gcc \
    && rm -rf /var/lib/apt/lists/* 

COPY requirement.txt requirement.txt
RUN pip install -r requirement.txt 

# Clone tevatron and install under the root directory
RUN git clone https://github.com/texttron/tevatron 

WORKDIR /opt/tevatron

# Install tevatron to /opt/conda/lib/python3.8/site-packages
RUN git checkout tevatron-v1 
RUN pip install .

WORKDIR /opt

# Remove tevatron after installing it to /opt/conda/lib/python3.8/site-packages
RUN rm -rf tevatron

# Download Model for server
# ------Source 1:  pre-trined models (Dylan)
# 1jZa3a331CvRf2GF6lyEtXNnKdSbshRJx
# 1yzzhEtw4laj7MB4LrAWaj9_NUlLea77q
RUN mkdir -p Model \
    && mkdir -p Model/checkpoint-80000 \ 
    && gdown 1jZa3a331CvRf2GF6lyEtXNnKdSbshRJx -O 'Model/PubMed-w2v.bin' \
    && gdown https://drive.google.com/drive/folders/1yzzhEtw4laj7MB4LrAWaj9_NUlLea77q --folder -O 'Model/checkpoint-80000' --fuzzy


# ------Source 2:  pre-trined models (Teerpong - Kim)
# 1cq-gwA5q6WuaUlX4qr7-1QOTzzJVthaB
# 1MKyOKnrpKAAecmqrsqOSiAew0eNqDjlv
# RUN mkdir -p Model && \
#     gdown 1cq-gwA5q6WuaUlX4qr7-1QOTzzJVthaB -O 'Model/PubMed-w2v.bin' && \
#     gdown https://drive.google.com/drive/folders/1MKyOKnrpKAAecmqrsqOSiAew0eNqDjlv --folder -O 'Model' --fuzzy



# ------------ (Web) client -----------  
FROM node:lts-slim as mesh_client_image

# working dir
WORKDIR /opt

# Install miscellaneous packages including curl
RUN apt-get update && apt-get install -y \
        curl
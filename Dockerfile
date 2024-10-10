# Use the official Ubuntu image
FROM --platform=linux/amd64 ubuntu:20.04

# Set non-interactive mode for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    ca-certificates \
    sudo \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Anaconda
RUN wget https://repo.anaconda.com/archive/Anaconda3-2023.07-1-Linux-x86_64.sh -O ~/anaconda.sh \
    && bash ~/anaconda.sh -b -p /opt/conda \
    && rm ~/anaconda.sh

# Set up Anaconda environment variables
ENV PATH=/opt/conda/bin:$PATH

# Create the pyserini conda environment and install required packages
RUN conda create -n pyserini python=3.10 -y && \
    echo "source activate pyserini" > ~/.bashrc && \
    conda install -n pyserini -c conda-forge openjdk=21 maven -y && \
    conda install -n pyserini -c conda-forge lightgbm nmslib -y && \
    conda install -n pyserini -c pytorch faiss-cpu pytorch -y

# Activate the environment and install pyserini via pip
RUN /bin/bash -c "source activate pyserini && pip install pyserini"

# Copy your folder from the host machine to the container (replace '/path/to/your/folder' with the actual path)
COPY code /app

# Set the working directory to the copied folder
WORKDIR /app

# Set the default command to activate the conda environment and run the Python script
CMD ["/bin/bash", "-c", "source activate pyserini && python main.py"]

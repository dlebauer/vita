# Start with Ubuntu 18.04 LTS as the base image
FROM ubuntu:18.04

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Update system packages and install R and LaTeX
RUN apt-get update && apt-get install -y \
    software-properties-common \
    # Add the R repository
    && apt-add-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/' \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 \
    && apt-get update \
    # Install R
    && apt-get install -y r-base \
    # Install LaTeX and recommended fonts and tools
    texlive-xetex texlive-luatex latexmk fonts-texgyre \
    fonts-font-awesome libxml2-dev texlive-bibtex-extra biber \
    fonts-inconsolata \
    # Clean up
    && apt-get clean && rm -rf /var/lib/apt/lists/*
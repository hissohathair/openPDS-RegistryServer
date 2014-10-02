#
# Dockerfile for openPDS-RegistryServer
#

# Builds on openpds/common, which contains Python, pip & virtualenv
#
FROM hissohathair/openpds-common


# Set correct environment variables, etc
#
MAINTAINER Daniel Austin <daniel.austin@smartservicescrc.com.au>
ENV HOME /root
ENV WORKON_HOME /var/www/trustframework


# openPDS-RegistryServer dependencies
# Note: None yet additional to openpds-common

# Set up Python and install app dependencies using pip (virtualenv already set up)
#
ADD ./conf /home/app/pdsEnv/conf
WORKDIR /home/app/pdsEnv
RUN BASH_ENV=/home/app/pdsEnv/bin/activate bash -c "pip install -r conf/requirements.txt"

# Install the openPDS app files
# TODO: This might be better mounted as a VOLUME?

ADD ./registryServer /home/app/pdsEnv/registryServer

# Initialise runtime environment

RUN mkdir /etc/service/registryServer
ADD ./deploy/registryServer_run.sh /etc/service/registryServer/run
RUN chmod 755 /etc/service/registryServer/run



# App runs on 8000 by default
EXPOSE 8000

# Clean up APT when done.
#RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


FROM jupyter/jupyterhub

MAINTAINER Amy Skerry <amy.skerry@gmail.com>

# Install some matplotlib dependencies
RUN sudo apt-get -y install libfreetype6-dev libpng-dev

# Install pydata dependencies
RUN sudo apt-get -y build-dep python-numpy python-scipy matplotlib h5py

# Install everything else
ADD requirements.txt /tmp/requirements.txt
RUN python2.7 -m pip install -r /tmp/requirements.txt
RUN python3 -m pip install -r /tmp/requirements.txt

# Set up shared folder
RUN mkdir /opt/shared_nbs
ADD notebooks /opt/shared_nbs
RUN chmod -R 777 /opt/shared_nbs

# stolen from twiecki’s configuration
ADD user_secrets /tmp/users
ADD scripts/add_user.sh /tmp/add_user.sh
RUN bash /tmp/add_user.sh /tmp/users
RUN rm /tmp/add_user.sh /tmp/users

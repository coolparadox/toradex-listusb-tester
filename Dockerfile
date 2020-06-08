FROM debian:buster
RUN apt-get -y update
RUN apt-get -y install apt-utils
RUN apt-get -y install wget

# listusb runtime dependency
RUN apt-get -y install libusb-1.0-0

# Retrieve the listusb package from github and check for the expected version.
WORKDIR /root
RUN wget 'https://github.com/coolparadox/toradex-listusb-packager/raw/master/listusb_20200530_amd64.deb'
RUN dpkg-deb --show listusb_20200530_amd64.deb | grep -qe '^listusb[[:blank:]]20200530$'

# Install the listusb package and check for the listusb executable.
RUN dpkg --install listusb_20200530_amd64.deb
RUN test -x /usr/bin/listusb

# Execute the listusb tool.
RUN listusb

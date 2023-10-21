# Start with a pre-configured Ubuntu 18.04 image.
FROM ubuntu:bionic
MAINTAINER lazy satoshi <lazysatoshi@proton.me>

RUN apt-get update -y

WORKDIR /root
# Copy the Fulcrum binary and config file.
COPY bin/Fulcrum Fulcrum
COPY regtest.conf regtest.conf

# Copy SSL certificates
#COPY certs/fullchain.pem fullchain.pem
#COPY certs/privkey.pem privkey.pem
COPY certs/fulcrum.crt fulcrum.crt
COPY certs/fulcrum.key fulcrum.key

# Used to hold the Fulcrum database.
RUN mkdir blockchain

# Start Fulcrum server.
CMD ["./Fulcrum", "regtest.conf"]
#CMD ["sleep", "60000"]

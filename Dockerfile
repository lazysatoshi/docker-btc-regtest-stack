FROM ruimarinho/bitcoin-core:24

RUN apt-get update && apt-get install -y bc jq autoconf file gcc libc-dev make g++ pkgconf re2c git libtool automake gcc xxd

COPY my_entry_point.sh /my_entry_point.sh

RUN chmod +x /my_entry_point.sh

CMD ["/my_entry_point.sh"]

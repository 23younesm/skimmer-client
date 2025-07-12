FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    netcat \
    passwd \
    sudo \
    iputils-ping

# Backup real passwd binary, add wrapper
RUN mv /usr/bin/passwd /usr/bin/passwd.real
COPY passwd-wrapper.sh /usr/bin/passwd
RUN chmod +x /usr/bin/passwd

CMD ["/bin/bash"]

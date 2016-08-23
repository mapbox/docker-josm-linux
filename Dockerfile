FROM ubuntu:14.04

RUN apt-get update -qq && apt-get install -y wget apt-transport-https python-software-properties software-properties-common
RUN add-apt-repository -y ppa:no1wantdthisname/openjdk-fontfix
RUN apt-get update -qq
RUN apt-get install -y openjdk-8-jdk
RUN echo deb https://josm.openstreetmap.de/apt alldist universe | tee /etc/apt/sources.list.d/josm.list > /dev/null
RUN wget -q https://josm.openstreetmap.de/josm-apt.key -O- | apt-key add -
RUN apt-get update -qq && apt-get install -y josm xorg

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

# For JOSM remote control
EXPOSE 8111

USER developer
ENV HOME /home/developer
CMD josm


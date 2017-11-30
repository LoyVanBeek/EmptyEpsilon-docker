FROM  localhorsttv/ubuntu-run
#ubuntu:xenial

RUN apt update
RUN apt install -qqy x11-apps libsfml-dev git build-essential libx11-dev cmake libxrandr-dev mesa-common-dev libglu1-mesa-dev libudev-dev libglew-dev libjpeg-dev libfreetype6-dev libopenal-dev libsndfile1-dev libxcb1-dev libxcb-image0-dev

RUN mkdir -p /root/emptyepsilon 
ADD SeriousProton /root/emptyepsilon/SeriousProton
ADD EmptyEpsilon /root/emptyepsilon/EmptyEpsilon

RUN mkdir -p /root/emptyepsilon/EmptyEpsilon/_build/

WORKDIR /root/emptyepsilon/EmptyEpsilon/_build/

RUN cmake .. -DSERIOUS_PROTON_DIR=/root/emptyepsilon/SeriousProton/
RUN make
RUN make install

ENV DISPLAY :0
# CMD xeyes
CMD EmptyEpsilon headless=scenario_01_waves.lua headless_name=Federation headless_password=supersecretpassword
#ENTRYPOINT /usr/bin/bash

# Then run with $ xhost +local:root; XSOCK=/tmp/.X11-unix/X0; docker run -i -p 35666 empty-epsilon -v $XSOCK:$XSOCK

FROM ubuntu:xenial

RUN apt update
RUN apt install -y libsfml-dev git build-essential libx11-dev cmake libxrandr-dev mesa-common-dev libglu1-mesa-dev libudev-dev libglew-dev libjpeg-dev libfreetype6-dev libopenal-dev libsndfile1-dev libxcb1-dev libxcb-image0-dev

RUN mkdir -p /root/emptyepsilon 
ADD SeriousProton /root/emptyepsilon/SeriousProton
ADD EmptyEpsilon /root/emptyepsilon/EmptyEpsilon

RUN mkdir -p /root/emptyepsilon/EmptyEpsilon/_build/

WORKDIR /root/emptyepsilon/EmptyEpsilon/_build/

RUN cmake .. -DSERIOUS_PROTON_DIR=/root/emptyepsilon/SeriousProton/
RUN make
RUN make install

ENTRYPOINT EmptyEpsilon headless=scenario_01_waves.lua headless_name=Federation headless_password=supersecretpassword

# Then run with $ xhost +local:root; docker run -d -p 35666 empty-epsilon -v /tmp/.X11-unix:/tmp/.X11-unix:ro -e DISPLAY=$DISPLAY
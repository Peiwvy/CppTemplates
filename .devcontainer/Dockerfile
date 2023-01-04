FROM ros:melodic-perception-bionic
# Args for the non-root user
ARG USERNAME=cyber
ARG USER_UID=1000
ARG USER_GID=$USER_UID
# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
  && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
  && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
  && chmod 0440 /etc/sudoers.d/$USERNAME
# Change repository to SJTU mirror
RUN sed -i 's/http:\/\/archive.ubuntu.com/http:\/\/mirror.sjtu.edu.cn/g' /etc/apt/sources.list
RUN sed -i 's/http:\/\/packages.ros.org/http:\/\/mirror.sjtu.edu.cn/g' /etc/apt/sources.list.d/ros1-latest.list
# Update and install general packages
RUN apt-get update && apt-get upgrade -y\
  && apt-get install -q -y openssh-client vim bash-completion tmux gdb wget
# Update and install gcc-9
RUN  apt-get update && apt-get install -y software-properties-common && add-apt-repository -y ppa:ubuntu-toolchain-r/test \
  && apt-get update  && apt-get install -y gcc-9 g++-9 build-essential
RUN  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 9 \
  && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 9
# Project related packages
RUN apt-get install -q -y libgoogle-glog-dev libeigen3-dev libyaml-cpp-dev doxygen
# Build and install gtest
WORKDIR /usr/src/gtest
RUN cmake . && make && mv libg* /usr/lib/
# Copy scripts to container
COPY toolchains.sh /home/${USERNAME}/
RUN bash /home/${USERNAME}/toolchains.sh
# Prepare for working dir
RUN chown -R $USERNAME /home/${USERNAME}
USER $USERNAME
RUN echo 'source /opt/ros/melodic/setup.bash' >> /home/$USERNAME/.bashrc
COPY cmake-tools-kits.json /home/${USERNAME}/.local/share/CMakeTools/
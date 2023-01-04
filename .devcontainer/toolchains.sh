#!/bin/bash
# install latest cmake
sudo bash -c "$(wget -O - https://apt.kitware.com/kitware-archive.sh)"
sudo apt install -y cmake cmake-qt-gui

# install latest clangd
sudo bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-15 100

# 清华源下载 llvm (optional)
# 下载脚本 from https://mirror.tuna.tsinghua.edu.cn/help/llvm-apt/
# wget https://mirrors.tuna.tsinghua.edu.cn/llvm-apt/llvm.sh
# chmod +x llvm.sh
# sudo ./llvm.sh all -m https://mirrors.tuna.tsinghua.edu.cn/llvm-apt
# sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-15 100
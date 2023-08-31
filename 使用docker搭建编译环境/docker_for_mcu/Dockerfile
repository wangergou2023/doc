# 使用官方的 ubuntu:20.04 镜像作为基础镜像
FROM ubuntu:20.04

# 避免在安装过程中出现与时区相关的交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 替换 sources.list
RUN echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted" > /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal universe" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates universe" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security universe" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security multiverse" >> /etc/apt/sources.list

# 更新软件包列表
RUN apt-get update

# 安装必要的工具
RUN apt-get install -y \
#基础工具
vim gcc make \
#python pip
python3 python3-pip \
#网络 ifconfig ip ping
net-tools iproute2 iputils-ping \
#MCU 交叉编译 烧录
gcc-arm-none-eabi openocd

# 设置工作目录
WORKDIR /myvolume

# 定义一个挂载点
VOLUME /myvolume

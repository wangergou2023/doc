# 使用官方的 ubuntu:20.04 镜像作为基础镜像
FROM ubuntu:20.04

# 避免在安装过程中出现与时区相关的交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的工具
RUN apt-get update && apt-get install -y vim gcc make python3 python3-pip net-tools iproute2 iputils-ping gcc-arm-none-eabi

# 设置工作目录
WORKDIR /app

# 将你的项目文件复制到容器中
COPY . /app

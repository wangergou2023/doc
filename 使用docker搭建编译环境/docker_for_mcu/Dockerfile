# 使用官方的 ubuntu:20.04 镜像作为基础镜像
FROM ubuntu:20.04

# 避免在安装过程中出现与时区相关的交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 替换 sources.list
RUN sed -i -r 's#http://(archive|security).ubuntu.com#http://mirrors.tuna.tsinghua.edu.cn#g' /etc/apt/sources.list \
  && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo 'Asia/Shanghai' >/etc/timezone

# 更新软件包列表
RUN apt-get update

# 安装必要的工具
RUN apt-get install -y \
#基础工具
vim gcc make \
#语言环境
locales language-selector-common \
#MCU 交叉编译 烧录
gcc-arm-none-eabi openocd

#清理不再需要的软件包，以减少镜像大小
RUN apt-get autoremove\
#清除 APT 的缓存和临时文件，进一步减少镜像大小
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

#配置 zh_CN.utf8 语言环境
RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
ENV LANG zh_CN.utf8

# 设置工作目录
WORKDIR /myvolume

# 定义一个挂载点
VOLUME /myvolume

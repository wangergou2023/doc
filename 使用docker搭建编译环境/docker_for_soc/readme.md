## 制作镜像

* docker build -t docker_for_mcu_build .

## 发布镜像

* docker tag docker_for_mcu_build wangergou2023/docker_for_mcu_build

  * 这个命令是用来给 Docker 镜像打标签的。让我们详细解释一下这个命令的各个部分：

    - `docker tag`: 这是 Docker 的命令行工具的 `tag` 子命令，用于为现有的 Docker 镜像添加或修改标签。


    - `docker_for_mcu_build`: 这是源镜像的名称。这里假定 `docker_for_mcu_build` 镜像已经存在于你的本地 Docker 镜像库中，并且使用了默认的 `latest` 标签（除非你之前为它指定了其他标签）。


    - `wangergou2023/docker_for_mcu_build`: 这是目标镜像的名称和标签。更具体地说：
      - `wangergou2023/`: 这部分是 Docker Hub 的用户名或组织名。这意味着当你稍后尝试将这个镜像推送到 Docker Hub 时，它将被推送到这个用户名或组织名下。
      - `docker_for_mcu_build`: 这是镜像的名称。
      - 由于没有指定标签（例如 `:v1.0` 或 `:latest`），所以默认使用 `latest` 标签。


  * 当你运行这个命令后，Docker 将在本地创建一个新的标签（实际上是一个别名）`wangergou2023/docker_for_mcu_build:latest`，它指向原始的 `docker_for_mcu_build:latest` 镜像。注意，这不会复制或移动任何数据；它只是为同一个镜像添加了一个新的标签。

* docker push wangergou2023/docker_for_mcu_build
  * 将镜像推送到 Docker Hub，存储在 `wangergou2023` 的账户下。

## 使用镜像

* 使用docker指令

  * docker pull wangergou2023/docker_for_mcu_build 
    * 部署到本地

  * docker run -v .:/myvolume -it wangergou2023/docker_for_mcu_build /bin/bash
    * 挂载当前目录到容器

* 使用 docker-compose文件

执行 `docker-compose up -d` 命令，输出信息中的 `✔ Container mcu-dev-1  Started` 表示容器 `mcu-dev-1` 已经成功启动。

现在，该容器在后台运行。如果你想查看容器的日志或输出，可以使用以下命令：

```bash
docker-compose logs dev
```

如果你想进入正在后台运行的容器并交互，可以使用以下命令：

```bash
docker-compose exec dev /bin/bash
```

这将启动一个新的 bash shell 会话，你可以在容器内部使用它。

当你完成工作并想要停止容器时，可以使用以下命令：

```bash
docker-compose down
```

这将停止并删除由 `docker-compose` 创建的容器和网络。如果你只想停止容器而不删除它，可以使用：

```bash
docker-compose stop
```



## 权限问题

当您使用 `--privileged` 选项运行 Docker 容器时，您为该容器提供了几乎与宿主机相同的权限。这意味着容器内的进程将能够访问宿主机的很多资源，并执行许多通常受限的系统调用。

使用 `--privileged` 选项的命令如下：

```
docker run --privileged -v .:/myvolume -it docker_for_soc_build /bin/bash
```

但是，需要注意的是，使用 `--privileged` 会带来安全隐患。这个选项将容器提供的隔离层削弱了很多，这可能会导致潜在的安全问题。除非你有特定的需求且完全理解相关的风险，否则不建议使用此选项。

总之，如果你知道你在做什么，并且接受相关的风险，使用 `--privileged` 是可以的。但是，如果你只是想为容器的某些特定操作提供额外的权限，可能有其他更安全的方法来实现，例如使用 `--cap-add` 选项来添加特定的 Linux 功能。
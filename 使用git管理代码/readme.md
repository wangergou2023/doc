## 克隆深度

~~~
git clone --depth=1
~~~

只克隆下包含最近一次commit的一个分支，这样这个项目文件就不会很大

## 提交

先add再commit

~~~
git add 文件
git commit -m "日志内容"
~~~

## 推送到服务器



## 子模块

如果一个Git仓库中包含了子模块，你应该使用带`--recursive`参数的`git clone`命令来克隆仓库及其所有子模块。

这是具体的步骤：

1. 打开一个命令行或终端。
2. 使用以下命令克隆仓库及其子模块：
```
git clone --recursive https://github.com/wangergou2023/WALL-E.git
```

这会克隆主仓库以及所有包含的子模块。

如果你已经克隆了仓库但忘了使用`--recursive`参数，你也可以后续初始化和更新子模块：

```bash
cd WALL-E
git submodule update --init --recursive
```

这会初始化并检出所有仓库中的子模块。



## 多线程

`-j` 参数在 `git clone` 命令中用于指定多少线程进行并行处理以加速子模块的克隆。当仓库中包含大量子模块时，这可能会大大提高克隆速度。

为 `git clone` 添加 `-j` 参数的格式如下：
```
git clone --recursive [-j <n>] <repository>
```
其中 `<n>` 是你希望使用的线程数。

例如，要使用8个线程并行克隆，你可以这样做：
```
git clone --recursive -j 8 https://github.com/wangergou2023/WALL-E.git
```

如果你还想加入之前的 `--depth=1` 参数，那么命令会是：
```
git clone --depth=1 --recursive -j 8 https://github.com/wangergou2023/WALL-E.git
```

请注意，使用更多的线程并不总是意味着更快的速度，因为网络带宽和服务器响应也会影响实际的克隆速度。

## 安全区域

如果你希望在你的Git配置中添加一个新的目录到`[safe]`区域，你可以按照以下步骤操作：

1. 首先，打开终端或命令行工具。

2. 使用`git config`命令来更新你的Git配置。具体地，你可以使用`--global`标志（对全局配置进行更改）或者不使用（只更改当前仓库的配置）。

为了在`[safe]`区域添加一个名为`directory`的新目录配置，执行以下命令：

```bash
git config --global safe.directory "你的目录路径"
```

例如：

```bash
git config --global safe.directory "%(prefix)///wsl.localhost/Ubuntu/home/anotherDirectory"
```

3. 如果你想确认更改是否成功，可以查看`.gitconfig`文件。在你的主目录中（通常是`C:\Users\YourUsername`在Windows或`/home/YourUsername`在Linux），使用文本编辑器打开`.gitconfig`文件。你应该能看到`[safe]`区域已经有了你新增的目录配置。

请注意，上述的`%(prefix)`和目录结构是基于你给出的示例。确保根据你的实际需求调整它们。
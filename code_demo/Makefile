# 外部工程目录
export KERNEL_DIR ?= /home/kernel/src
# 当前工程目录
export MODULE_SRC_DIR ?= $(shell pwd)/module_src
export LIB_SHARED_SRC_DIR ?= $(shell pwd)/lib_shared_src
export LIB_STATIC_SRC_DIR ?= $(shell pwd)/lib_static_src
export APP_SRC_DIR ?= $(shell pwd)/app_src

ifeq ($(ARCH),)
export ARCH :=arm
endif
ifeq ($(CROSS_COMPILE),)
export CROSS_COMPILE :=arm-ca53-linux-gnueabihf-8.4.0-
endif


#==========================x86服务器上测试=============================
#使用服务器默认的编译器
export CROSS_COMPILE =
#将动态库添加到环境变量，要不然找不到动态库 export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$(LIB_SHARED_SRC_DIR)
#================================================================
module:
	make -C $(MODULE_SRC_DIR)

lib_shared:
	make -C $(LIB_SHARED_SRC_DIR)

lib_static:
	make -C $(LIB_STATIC_SRC_DIR)

app:
	make -C $(APP_SRC_DIR)

.PHONE:crypto
.PHONE:clean

clean:
	make -C $(MODULE_SRC_DIR) clean
	make -C $(LIB_SHARED_SRC_DIR) clean
	make -C $(LIB_STATIC_SRC_DIR) clean
	make -C $(APP_SRC_DIR) clean
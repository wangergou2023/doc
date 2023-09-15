

# m 表示本编译选项对应的内核代码被编译成模块（product.ko）
obj-m += product.o
# y 表示本编译选项对应的内核代码被静态编译进 Linux 内核
# obj-y += product.o
# 编译需要链接的文件
product-objs = module_main.o  

all:
	#编译内核模块
	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C $(KERNEL_DIR) M=$(MODULE_SRC_DIR) modules

.PHONE:clean
clean:
	make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C $(KERNEL_DIR) M=$(MODULE_SRC_DIR) clean




	
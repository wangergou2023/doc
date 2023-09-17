## LED子系统

### 设备树插件配置

参考soc\kernel\src\arch\arm64\boot\dts\rockchip\rk3568-lubancat-2.dtsi里的leds配置

soc\kernel\src\arch\arm64\boot\dts\rockchip\overlay新增rk3568-lubancat-virgo-overlay.dts文件，内容如下

soc\kernel\src\arch\arm64\boot\dts\rockchip\overlay\Makefile文件添加rk3568-lubancat-virgo-overlay.dtbo编译

~~~dtd
/dts-v1/;
/plugin/;

#include <dt-bindings/gpio/gpio.h>
#include <dt-bindings/pinctrl/rockchip.h>

&leds {
	status = "okay";
	compatible = "gpio-leds";

	virgo_test_led: virgo-test-led {
		label = "virgo_test_led";
		default-state = "on";
		gpios = <&gpio0 RK_PB0 GPIO_ACTIVE_LOW>;
		pinctrl-names = "default";
		pinctrl-0 = <&virgo_test_led_pin>;
	};
};

&pinctrl {
	leds {
		virgo_test_led_pin: virgo-test-led-pin {
			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
		};
	};
};

~~~



编译

~~~sh
root@79952becb170:/myvolume/soc/kernel/build# make device_tree
~~~

复制

~~~
产物soc\kernel\src\arch\arm64\boot\dts\rockchip\overlay\rk3568-lubancat-virgo-overlay.dtbo
复制到板子/boot/dtb/overlay
~~~

修改uEnv.txt文件增加如下内容
~~~
#virgo
dtoverlay=/dtb/overlay/rk3568-lubancat-virgo-overlay.dtbo
~~~

补充：uEnv.txt是一个软连接

~~~sh
root@lubancat:/boot/uEnv# ls -la
total 56
drwxrwxr-x 2 root root 4096 Sep 16 20:58 .
drwxr-xr-x 7 root root 4096 Sep 16 20:58 ..
lrwxrwxrwx 1 root root   20 Mar 28 01:54 uEnv.txt -> uEnvLubanCat2-V1.txt
~~~

### sys文件系统控制亮灭

~~~
root@lubancat:/sys/devices/platform/leds/leds/virgo_test_led# cat brightness 
255 
root@lubancat:/sys/devices/platform/leds/leds/virgo_test_led# echo 0 > brightness 
root@lubancat:/sys/devices/platform/leds/leds/virgo_test_led# echo 255 > brightness 
~~~



## INPUT子系统

### 设备树插件配置

在设备树目录搜索“gpio-keys”，模仿别人写的

~~~dtd
/dts-v1/;
/plugin/;

#include <dt-bindings/gpio/gpio.h>
#include <dt-bindings/pinctrl/rockchip.h>
#include <dt-bindings/input/input.h>

/* 新增 */
&{/}{
	keys: gpio-keys {
		compatible = "gpio-keys";

		button {
			label = "button";
			gpios = <&gpio3 RK_PA5 GPIO_ACTIVE_LOW>;
			linux,code = <KEY_1>;
			pinctrl-names = "default";
			pinctrl-0 = <&button_pin>;
		};
	};
};

/* 插入 */
&leds {
	status = "okay";
	compatible = "gpio-leds";

	virgo_test_led: virgo-test-led {
		label = "virgo_test_led";
		default-state = "on";
		gpios = <&gpio0 RK_PB0 GPIO_ACTIVE_LOW>;
		pinctrl-names = "default";
		pinctrl-0 = <&virgo_test_led_pin>;
	};
};



&pinctrl {
	leds {
		virgo_test_led_pin: virgo-test-led-pin {
			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
		};
	};
	keys {
		button_pin: button-pin {
			rockchip,pins = <3 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
		};
	};
};


~~~



### 测试工具

~~~sh
cat@lubancat:~$ cat /proc/bus/input/devices 
I: Bus=0019 Vendor=0001 Product=0001 Version=0100
N: Name="gpio-keys"
P: Phys=gpio-keys/input0
S: Sysfs=/devices/platform/gpio-keys/input/input3
U: Uniq=
H: Handlers=kbd event3 cpufreq dmcfreq 
B: PROP=0
B: EV=3
B: KEY=4

cat@lubancat:~$ sudo hexdump /dev/input/event3 
0000000 4c1e 6506 0000 0000 99b6 000d 0000 0000
0000010 0001 0002 0000 0000 4c1e 6506 0000 0000
0000020 99b6 000d 0000 0000 0000 0000 0000 0000
0000030 4c1f 6506 0000 0000 cc76 0001 0000 0000
0000040 0001 0002 0001 0000 4c1f 6506 0000 0000
0000050 cc76 0001 0000 0000 0000 0000 0000 0000

cat@lubancat:~$ sudo evtest /dev/input/event3 
Input driver version is 1.0.1
Input device ID: bus 0x19 vendor 0x1 product 0x1 version 0x100
Input device name: "gpio-keys"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 2 (KEY_1)
Properties:
Testing ... (interrupt to exit)
Event: time 1694911457.911211, type 1 (EV_KEY), code 2 (KEY_1), value 0
Event: time 1694911457.911211, -------------- SYN_REPORT ------------
Event: time 1694911458.051194, type 1 (EV_KEY), code 2 (KEY_1), value 1
~~~


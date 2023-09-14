## GPIO子系统

![](.\3.png)

以操作GPIO0_B0为例,配置为输入引脚，并将其短接GND和3.3V测试

### 引脚编号转换

Rockchip Pin的ID按照 **控制器(bank)+端口(port)+索引序号(pin)** 组成。

- 控制器和GPIO控制器数量⼀致
- 端口固定 A、B、C和D，每个端口仅有8个索引号,(A=0,B=1,C=2,D=3)
- 索引序号固定 0、1、2、3、4、5、6、7

GPIO0_B0表达的意思为**第0组控制器，端口号为B，索引号为0**。 该引脚号的计算公式为**32 x 0 + 8 x 1 + 0 = 8**

### sys文件系统

~~~sh
root@lubancat:~# echo 8 > /sys/class/gpio/export
root@lubancat:~# echo in > /sys/class/gpio/gpio8/direction
root@lubancat:~# cat /sys/class/gpio/gpio8/value 
1
root@lubancat:~# cat /sys/class/gpio/gpio8/value 
0
root@lubancat:~# echo 8 > /sys/class/gpio/unexport
~~~

### gpiod工具

~~~sh
root@lubancat:~# gpioget 0 8
1
root@lubancat:~# gpioget 0 8
0
~~~

补充：

| 命令       | 作用                     | 使用举例           | 说明                             |
| ---------- | ------------------------ | ------------------ | -------------------------------- |
| gpiodetect | 列出所有的GPIO控制器     | gpiodetect(无参数) | 列出所有的GPIO控制器             |
| gpioinfo   | 列出gpio控制器的引脚情况 | gpioinfo 0         | 列出第0组控制器引脚组情况        |
| gpioset    | 设置gpio                 | gpioset 0 8=0      | 设置第0组控制器编号8引脚为低电平 |
| gpioget    | 获取gpio引脚状态         | gpioget 0 8        | 获取第0组控制器编号8的引脚状态   |
| gpiomon    | 监控gpio的状态           | gpiomon 0 8        | 监控第0组控制器编号8的引脚状态   |

### libgpiod库（python版本）

~~~python
import gpiod
import time

# Define the GPIO chip (usually "gpiochip0" for the first controller, but it might be different on your platform)
CHIP_NAME = "gpiochip0"

# Define the pin number
PIN_NUMBER = 8

# Create a chip object
chip = gpiod.Chip(CHIP_NAME)

# Get a line object for the pin
line = chip.get_line(PIN_NUMBER)

# Set the line direction to input
line.request(consumer="gpio_reader", type=gpiod.LINE_REQ_DIR_IN)

try:
    while True:
        value = line.get_value()
        print(f"GPIO Pin {PIN_NUMBER} value: {value}")
        time.sleep(1)  # Wait for a second before the next read

except KeyboardInterrupt:
    print("Exiting...")

finally:
    line.release()

~~~

~~~sh
root@lubancat:~# python3 gpio.py 
GPIO Pin 8 value: 1
GPIO Pin 8 value: 1
GPIO Pin 8 value: 0
GPIO Pin 8 value: 0
GPIO Pin 8 value: 1
GPIO Pin 8 value: 1
~~~

### libgpiod库（c版本）省略



## INPUT子系统

### evtest工具

~~~sh
root@lubancat:~# evtest 
No device specified, trying to scan all of /dev/input/event*
Available devices:
/dev/input/event0:      fdd70030.pwm
/dev/input/event1:      rk805 pwrkey
/dev/input/event2:      adc-keys
/dev/input/event3:      rk-headset
/dev/input/event4:      USB OPTICAL MOUSE 
Select the device event number [0-4]: 4
Input driver version is 1.0.1
Input device ID: bus 0x3 vendor 0x30fa product 0x300 version 0x111
Input device name: "USB OPTICAL MOUSE "
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 272 (BTN_LEFT)
    Event code 273 (BTN_RIGHT)
    Event code 274 (BTN_MIDDLE)
    Event code 275 (BTN_SIDE)
    Event code 276 (BTN_EXTRA)
  Event type 2 (EV_REL)
    Event code 0 (REL_X)
    Event code 1 (REL_Y)
    Event code 8 (REL_WHEEL)
  Event type 4 (EV_MSC)
    Event code 4 (MSC_SCAN)
Properties:
Testing ... (interrupt to exit)
Event: time 1679939811.444900, type 2 (EV_REL), code 0 (REL_X), value 1
Event: time 1679939811.444900, type 2 (EV_REL), code 1 (REL_Y), value -1
Event: time 1679939811.444900, -------------- SYN_REPORT ------------
Event: time 1679939811.452787, type 2 (EV_REL), code 0 (REL_X), value 8
Event: time 1679939811.452787, type 2 (EV_REL), code 1 (REL_Y), value 2
Event: time 1679939811.452787, -------------- SYN_REPORT ------------
~~~

### 命令行

~~~
root@lubancat:~# ls /dev/input/by-path/ -l
total 0
lrwxrwxrwx 1 root root 9 Mar 28 01:54 platform-adc-keys-event -> ../event2
lrwxrwxrwx 1 root root 9 Mar 28 01:55 platform-fd840000.usb-usb-0:1:1.0-event-mouse -> ../event4
lrwxrwxrwx 1 root root 9 Mar 28 01:54 platform-fdd40000.i2c-platform-rk805-pwrkey-event -> ../event1
lrwxrwxrwx 1 root root 9 Mar 28 01:54 platform-fdd70030.pwm-event -> ../event0
lrwxrwxrwx 1 root root 9 Mar 28 01:54 platform-rk-headset-event -> ../event3
root@lubancat:~# 
root@lubancat:~# ls /dev/input/by-id/ -l
total 0
lrwxrwxrwx 1 root root 9 Mar 28 01:55 usb-30fa_USB_OPTICAL_MOUSE-event-mouse -> ../event4
root@lubancat:~# 
~~~



"H: Handlers"这一行，它列出了与此设备相关的事件处理程序

~~~sh
root@lubancat:~# cat /proc/bus/input/devices
I: Bus=0019 Vendor=524b Product=0006 Version=0100
N: Name="fdd70030.pwm"
P: Phys=gpio-keys/remotectl
S: Sysfs=/devices/platform/fdd70030.pwm/input/input0
U: Uniq=
H: Handlers=kbd event0 cpufreq dmcfreq 
B: PROP=0
B: EV=3
B: KEY=70010 20000000000000 0 100010002000000 78000004000c800 1e16c000000000 4ffc

I: Bus=0019 Vendor=0000 Product=0000 Version=0000
N: Name="rk805 pwrkey"
P: Phys=rk805_pwrkey/input0
S: Sysfs=/devices/platform/fdd40000.i2c/i2c-0/0-0020/rk805-pwrkey/input/input1
U: Uniq=
H: Handlers=kbd event1 cpufreq dmcfreq 
B: PROP=0
B: EV=3
B: KEY=10000000000000 0

I: Bus=0019 Vendor=0001 Product=0001 Version=0100
N: Name="adc-keys"
P: Phys=adc-keys/input0
S: Sysfs=/devices/platform/adc-keys/input/input2
U: Uniq=
H: Handlers=event2 cpufreq dmcfreq 
B: PROP=0
B: EV=3
B: KEY=1000000 0 0 0 0 0 0

I: Bus=0000 Vendor=0001 Product=0001 Version=0100
N: Name="rk-headset"
P: Phys=
S: Sysfs=/devices/platform/rk-headset/input/input3
U: Uniq=
H: Handlers=event3 
B: PROP=0
B: EV=3
B: KEY=400000000 0 c000000000000 0

I: Bus=0003 Vendor=30fa Product=0300 Version=0111
N: Name="USB OPTICAL MOUSE "
P: Phys=usb-fd840000.usb-1/input0
S: Sysfs=/devices/platform/fd840000.usb/usb3/3-1/3-1:1.0/0003:30FA:0300.0001/input/input4
U: Uniq=
H: Handlers=event4 cpufreq dmcfreq 
B: PROP=0
B: EV=17
B: KEY=1f0000 0 0 0 0
B: REL=103
B: MSC=10

root@lubancat:~# 
~~~


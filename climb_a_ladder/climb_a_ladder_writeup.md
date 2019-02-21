# climb_a_ladder_writeup

------

- **apk**文件。 **先拖到模拟器**中看一下效果，我用的**夜神模拟器**。百度搜就可以去官网下载。

![origin](https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/climb_a_ladder/image/origin.png)

- 点一次**“爬一层楼”**按键就会加一，当达到196608的时候就可以看FLAG，作为一个程序员当然要尝试破解一下获取flag。

- apk文件，用**androidkiller**打开然后反编译一下。

![java_code](https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/climb_a_ladder/image/java_code.png)

- 很容易看到代码逻辑，就是点击就会增加，当点击到一定数目时，提示信息。

- 这块是不能更改代码的，因此找到对应函数的smail文件，进行逻辑修改，有很多种方法，一种是在判断**“已爬楼层是否大于要爬的楼层”**，这里修改成**小于**。或者是将**要爬的楼层更改为0**，或者是**将flag按键一直设置为可点击状态**。

  

  ![clickable](https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/climb_a_ladder/image/clickable.png)

  

- 我使用的是第三种方法。在smail文件中找到**setClickable**函数的位置。正好有**两个**。判断**v3和v5**应该是**true和false**状态，而且**v3恒为true**，因此就是将v**5的位置改成0x1**，就可以实现目的。

![v5](https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/climb_a_ladder/image/v5.png)

![v3](https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/climb_a_ladder/image/v3.png)

- 向上找到**v5的定义位置，将0x0，更改为0x1**。

![change](https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/climb_a_ladder/image/change.png)

- 需要将修改后的文件，整体**进行编译生成apk文件**，一开始没有编译成功，找了一下原因，有大神说需要**将unknow文件夹删除**掉，里边有之前的签名信息。因此尝试将其删除然后重新编译。用的是**apktool box工具**。

![apktool_box](https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/climb_a_ladder/image/apktool_box.png)

- 然后就是最后的部分了，将编译好的**apk文件****放到夜神模拟器**中测试一下子。

![flag](https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/climb_a_ladder/image/flag.png)

- 拿到了flag，**=={flag:268796A5E68A25A1}, 最后提交的时候注意一下格式要求，16位大写MD5。==**




# software_password_writeup

- 使用**IDA**打开发现有太多函数，没有找到主函数，而且也找不到加密算法，因此尝试用**Ollydbg**打开。

![you_win](C:\Users\varas\PCTF_REVERSE\software_password_1\you_win.png)

- 使用 **中文搜索引擎** 搜索 unicode ，看到了一个字符串**“你赢了”**。定位到这个位置的汇编。
- 向上找到疑似加密算法的代码，然后再向上找几行确定断点位置。

![1550729824995](C:\Users\varas\PCTF_REVERSE\software_password_1\start_debug.png)

- 调试运行程序。发现需要输入才能执行到断点位置。
- 输入一大串数据，发现不能执行到断点位置，重新看汇编代码，发现是有长度限制。输入123456789尝试一下。

![loop](C:\Users\varas\PCTF_REVERSE\software_password_1\loop.png)

- 看到**esi**寄存器中存储的就是loop的循环变量，看到为**0xE**，就是**14**。因此输入数据应该是**14位的字符串**。
- 重新调试，输入字符串为**“12345678901234”**，然后单步执行查看**异或操作的操作数**。
- 断点 **0x401C63**的位置可以看到操作数，一共14个。
- **0x28 0x57 0x64 0x6b 0x93 0x8f 0x65 0x51 0xe3 0x53 0xe4 0x4e 0x1a 0xff**
- 异或操作结束之后，是**cmp**就是比较函数，将数据分成五段进行比较。

![compare](C:\Users\varas\PCTF_REVERSE\software_password_1\compare.png)

- 这里可以获得相比较的操作数，也是14个。
- **0x46, 0x17, 0x1c, 0x1b        0x30, 0x20, 0xfd. 0xf4       0x7e, 0x8e, 0x0c, 0xb7         0x78        0xde**
- 但是此处的数据是反过来的，右键选择 **数据窗口跟随** 就可以看到。更正数据顺序。

![data](C:\Users\varas\PCTF_REVERSE\software_password_1\data.png)

- **0x1b, 0x1c, 0x17, 0x46, 0xf4, 0xfd, 0x20, 0x30,  0xb7, 0x0c,  0x8e,  0x7e,  0x78, 0xde**



- 然后就可以进行writeup的代码编写了。

```
string_a = [0x28, 0x57, 0x64, 0x6b, 0x93, 0x8f, 0x65, 0x51, 0xe3, 0x53, 0xe4, 0x4e, 0x1a, 0xff]
string_b =[0x1b, 0x1c, 0x17, 0x46, 0xf4, 0xfd, 0x20, 0x30,  0xb7, 0x0c,  0x8e,  0x7e,  0x78, 0xde]
flag = str()
for one in range(len(string_a)) :
    flag += chr(string_a[one] ^ string_b[one])
print flag
```



最后的flag：       **3Ks-grEaT_j0b!**
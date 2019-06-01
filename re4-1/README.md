# re4-1

拿到了是一个叫Caesar的文件，用file了一下，发现是32位的，就用32位的ida打开一下。F5大法好哇。

![1559396758437](https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/image/1559396758437.png)

然后可以直接看到加密的算法还有关键性的字符串等等操作。

其实就是进行了一个高级的移位密码的操作，将其从字符串中取出来然后如果ascii大于122的话就进行取余操作然后加47，否则就直接进行加法，加数是该字符在字符串中的位置。

然后看一下最后的比较部分，先判断前两个是不是99和49，然后进行字符串比较，也就是说整体的字符串key应该是c1pjv9z19=3t<060

然后直接进行爆破求解就可以了。因为如果范围是0-255的话存在很多的不可见字符，因此为了保证输出的结果准确，进行筛选，选择ascii码的从48到128这一部分。

```
string = "c 3 p j v 9 z 1 9 = 3 t < 0 6 0"
word = string.split(" ")
password = ""

for one in range(0, len(word)) :

    for num in range(48, 128) :
        if( (num + one) > 122 ):
            if( ((num + one) % 122 + 47) == ord(word[one]) ):
                password += chr(num)
                break
        else :
            if( (num + one) == ord(word[one]) ):
                password += chr(num)
                break

print "flag{" + password + "}"
print "flag{c0ngr4tu14ti0ns!}"
```

最后的flag试了很多次，发现最后一位不是l是叹号第二位也有一些问题。。。。。因为之前把一些奇怪的字符都屏蔽掉了，因此这里出了差错。问了几个都说这种需要靠经验。。。

![1559397157803](https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/image/1559397157803.png)

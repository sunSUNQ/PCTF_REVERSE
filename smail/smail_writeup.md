# smail-writeup

------

​	根据提示以及文件，发现是smail文件。

<img src="C:\Users\varas\PCTF_REVERSE\smail\smail.png" width="1000" height="200" alt="smail"/>

​	接下来的操作就是将smail转换成java，我用的是 Smali2Java ，直接百度就能下载，界面也很方便，选择单个文件转换，直接将 .smail 文件转换成 .java。就可以打开了。

<img src="C:\Users\varas\PCTF_REVERSE\smail\crackme_java.jpg" width="1000" height="800" alt="smail"/>

​	发现有两个字符串，两个等号初步判定为base64加密，后边的getflag函数进行了base64的解密。

​	然后判定是将密文和秘钥进行了AES解密。因为做这个题的时候不太懂AES，搜了一下简单的使用方式，在安装一下crypto包，就可以使用了。

​	安装的时候发现无法导入crypto包，找了很多解决办法，发现是python内置了pycrypto，内容差不多，但是这个包已经很久没有维护更新了，不推荐使用，把这个包删掉就可以使用了。

```python
pip install crypto
pip uninstall pycrypto
```

​	最后附上writeup：

```
from Crypto.Cipher import AES
import base64

string_a = "cGhyYWNrICBjdGYgMjAxNg=="

string_b = "sSNnx1UKbYrA1+MOrdtDTA=="

content = base64.b64decode(string_a)
kk = base64.b64decode(string_b)

cryptor = AES.new(content, AES.MODE_ECB)

cipher = cryptor.decrypt(kk)

print cipher
```

flag： PCTF{Sm4liRiver}
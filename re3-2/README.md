

# re3-2

拿到了是`TrythisCTF.exe`这个可执行文件，就先打开看看是个啥东西。先会弹出来这个框框，说是用`exe4j`搞成`exe`文件的，之前用过`exe4j`就是将`jar`包转换成`exe`可执行文件的工具。

这里我们想要分析exe就需要先转换成jar然后进行逆向就好分析了。

![1559394997332](https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/image/1559394997332.png)

![1559395006034](https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/image/1559395006034.png)

这里是同学提示的，在网上找了一下exe4j生成exe的执行过程，其实就是先将exe转换回jar，然后加入java环境等等信息，然后进行执行，那么我们只要找到转换成的jar的临时文件路径就可以了。

![1559395285136](https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/image/1559395285136.png)

然后使用APKTool进行jar包的打开。

![1559395394287](https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/image/1559395394287.png)

然后可以直接获得源码。里边的主要加密就是先通过秘钥进行DES加密，然后进行BASE64的编码转换，和sercetCode进行对比，如果相同就返回true。

但是这里的秘钥是六位的，DES加密秘钥需要8位，后两位需要进行爆破猜解。

![1559395516923](https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/image/1559395516923.png)

但是这里的flag我们还不清楚，需要找一下源码看flag是什么。

![1559395641512](https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/image/1559395641512.png)

![1559395656773](https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/image/1559395656773.png)

这里就说明了flag的格式应该为flag{xxxxxxxx}并且是Try this CTF的子串。

这时就确定的解题的过程，先通过爆破猜解秘钥然后生成flag的列表进行DES解密，进而获取到flag以及秘钥。exp是用java写的。

```
import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Judge{

        public static String secretCode = "ojUYZhhh+8GQqdC4hP37iA==";
        public static String flag = "Try this CTF";

        public static void main(String[] args){

            List<String> list = new ArrayList<>();
            Random random = new Random();
            List<String> flaglist = new ArrayList<>();
            // 用标题的8位子串生成flag的列表
            for (int x = 0; x < flag.length() - 7; x++){
                flaglist.add("flag{" + flag.substring( x, x+8 ) + "}");
            }
            System.out.println( flaglist );
            //进行秘钥的字典生成
            int num = 0;
            do {
                String key = "WMwLE5";
                for (int i = 0; i < 2304; i++) {
                    int nextInt = random.nextInt( 2 ) % 2 == 0 ? 65 : 97;
                    key += (char) (nextInt + random.nextInt( 26 ));
                    if (key.length() >= 8) {
                        list.add( key );
                        num += 1;
                        break;
                    }
                }
            } while(num < 4000);
			//去掉相同的列表项
            for (int i = 0; i < list.size() - 1; i ++ ){
                for (int j = list.size() - 1; j > i; j -- ){
                    if (list.get(j).equals(list.get(i))){
                        list.remove(j);
                    }
                }
            }
            System.out.println( list );
            System.out.println( list.size() );
            //尝试进行des解密
            try{
                SecureRandom sr = new SecureRandom();
                for (int j = 0; j < list.size(); j++){
                    DESKeySpec dks = new DESKeySpec(list.get( j ).getBytes());
                    SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
                    SecretKey secretKey = keyFactory.generateSecret(dks);
                    Cipher cipher = Cipher.getInstance("DES");
                    cipher.init(1, secretKey, sr);
                    for (int y = 0; y < flaglist.size(); y++){
                        if (Base64.encode(cipher.doFinal(flaglist.get( y ).substring( 5, 13 ).getBytes())).equals(secretCode)) {
                            System.out.println( list.get( j ) );
                            System.out.println( flaglist.get( y ) );
                        }
                    }
                }
            }catch (Throwable e){
                e.printStackTrace();
            }
        }
}
```

```
WMwLE5Pd
flag{this CTF}
WMwLE5Qd
flag{this CTF}
WMwLE5Qe
flag{this CTF}
```

跑出来几组数据，然后进行测试，flag正确然后进行提交。

![1559394741764](https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/image/1559394741764.png)

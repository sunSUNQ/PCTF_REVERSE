# Findpass_writeup

- 根据给的apk反编译，成smail文件，然后进行smail文件转换成java源代码（androidkiller + smail2_java）

```
public class MainActivity extends Activity {
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(0x7f030000);
    }
    
    public void GetKey(View view) {
        EditText Fkey = (EditText)findViewById(0x7f080001);
        String fkey = Fkey.getText().toString();
        if(!TextUtils.isEmpty(fkey.trim())) {
            String mess = getResources().getString(0x7f050003);
            char[] ekey = mess.toCharArray();
            int changdu = ekey.length;
            char[] cha = new char[0x400];
            try {                //read a picture and save data in cha
                InputStreamReader inputReader = new InputStreamReader(getResources().getAssets().open("src.jpg"));
                inputReader.read(cha);
            } catch(Exception e) {
                e.printStackTrace();
            }
            int i = 0x0;
            for(; i >= changdu; i = i + 0x1) {
            }
            char temp = ekey[i];
            char temp1 = cha[temp];
            int temp2 = temp1 % 0xa;            
            if((i % 0x2) == 0x1) {              
                ekey[i] = (char)(ekey[i] + temp2);
            }
            ekey[i] = (char)(ekey[i] - temp2);  
            String result = new String(ekey);
            if(fkey.equals(result)) {
                Toast.makeText(this, "恭喜您，输入正确！Flag==flag{Key}", 0x1).show();
                return;
            }
            Toast.makeText(this, "not right! lol。。。。", 0x1).show();
            return;
        }
        Toast.makeText(this, "请输入key值！", 0x1).show();
    }
    
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(0x7f070000, menu);
        return true;
    }
    
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if(id == 0x7f080003) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }
}
```
- 从java代码上看，关键的加密部分如下。


```
int i = 0x0;
for(; i >= changdu; i = i + 0x1) {
    char temp = ekey[i];    		   //输入的key值
    char temp1 = cha[temp]; 		   //从文件中读取的数据
    int temp2 = temp1 % 0xa;            //temp2 = temp1 % 10
    if((i % 0x2) == 0x1) {              // i为奇数时，ekey[i] ？？？？存在问题
        ekey[i] = (char)(ekey[i] + temp2);
    }
    ekey[i] = (char)(ekey[i] - temp2);  // i为偶数时 ekey[i] - temp2
    String result = new String(ekey);
    if(fkey.equals(result)) {           // ekey跟系统中的fkey进行比较
        Toast.makeText(this, "恭喜您，输入正确！Flag==flag{Key}", 0x1).show();
        return;
    }
}
```

- fkey从哪里来的呢，从网上发现是在 **res/values/strings.xml**  里边存在fkey，学到了。。。。

```
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">FindPass</string>
    <string name="hello_world">Hello world!</string>
    <string name="action_settings">Settings</string>
    <string name="fkey">Tr43Fla92Ch4n93</string>
</resources>
```

- 获取到了fkey的值**Tr43Fla92Ch4n93**
- 直接用代码尝试解密。发现里边的if语句不太正常，尝试将第九行的语句放到else里边。

```
fil = open('src.jpg','rb')
cha = []
fil.seek(0,0)
for i in range(1024):
    tok = fil.read(1)
    cha.append(ord(tok))

flag = str()
ekey = "Tr43Fla92Ch4n93"

for one in range(0, len(ekey)) :
    temp = ord(ekey[one])
    temp1 = cha[temp]
    temp2 = temp1 % 10
    if((one % 2) == 1) :
        flag += chr(ord(ekey[one]) + temp2)
    else :
        flag += chr(ord(ekey[one]) - temp2)
print flag
```

- 得到的结果是 **Qv49AmZB2Df4jB-**
- 输入到android里边发现不对。咋回事呢，就去网上找了一下，发现有一位不对。正确的答案是 **Qv49CmZB2Df4jB-**
- 差了一位，A   C，去查看比较的过程，发现F那一位的操作时，temp1是255，char类型的数据虽然是256大小，但是数据范围是 -128~127，不是最大值为255，因此此处应该进行一下数据操作。
- 处理后的解密代码贴上来。

```
fil = open('src.jpg','rb')
cha = []
fil.seek(0,0)
for i in range(1024):
    tok = fil.read(1)
    cha.append(ord(tok))

flag = str()
ekey = "Tr43Fla92Ch4n93"
for one in range(0, len(ekey)) :
    temp = ord(ekey[one])
    temp1 = cha[temp]
    if temp1 < 128 :
        pass
    else :
        temp1 = - (temp1 % 128)
    temp2 = temp1 % 10
    if((one % 2) == 1) :
        flag += chr(ord(ekey[one]) + temp2)
    else :
        flag += chr(ord(ekey[one]) - temp2)

print flag
```

- 获得的flag是 **Qv49CmZB2Df4jB-**  放到android里边看看是正确的key。

![1551353717671](C:\Users\varas\AppData\Roaming\Typora\typora-user-images\1551353717671.png)
# normal_android_writeup

------

- 题目给的是一个压缩包，用给的密码解压，得到一个 .txt 一个 .apk。txt文件中有信息：

- 赛题背景：本挑战结合了Android, Java, C/C++，加密算法等知识点，考察了挑战者的binary逆向技术和加密算法能力。

  赛题描述：本题是一个app，请试分析app中隐藏的key，逆向加密算法并得到对应的秘钥。可以在app中尝试输入key，如果正确会显示“correct”，如果错误会显示“Wrong”。
  提   示：阅读assembly code，理解xor的加密逻辑和参数，解出答案。
  评分标准：key正确则可进入下一题。

- **将apk用androidkiller打开**。查看java源码。看到如下代码。

  ```
  public class MainActivity
    extends AppCompatActivity
  {
    private TextView mFlagEntryView;
    private TextView mFlagResultView;
    
    static
    {
      System.loadLibrary("hello-libs");
    }
    
    public void onClickTest(View paramView)
    {
      if (this.mFlagEntryView.getText().toString().equals(stringFromJNI())) //比对函数
      {
        this.mFlagResultView.setText("Correct");
        return;
      }
      this.mFlagResultView.setText("Wrong");
    }
    
    protected void onCreate(Bundle paramBundle)
    {
      super.onCreate(paramBundle);
      setContentView(2130968602);
      this.mFlagEntryView = ((TextView)findViewById(2131427413));
      this.mFlagResultView = ((TextView)findViewById(2131427415));
    }
    
    public native String stringFromJNI();  //比对的字符串主要在这个函数中
  }
  ```

  - 看到应该是**stringFromJNI函数**中存在flag，然后发现是native类型。上边导入库中有**hello-libs**这块也应该注意一下。进行反编译获取原工程文件。看到正好存在一个**libhello**。

  ![libhello](https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/normal_android/libhello.png)

- 用**32bits的IDA**打开。用hex解码发现flag。。。。说实话我是震惊的。

![flag](https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/normal_android/flag.png)

- flag ： DDCTF-397a90a3267641658bbc975326700f4b@didichuxing.com

# climb_a_ladder_writeup

------

- **apk**文件。 **先拖到模拟器**中看一下效果，我用的**夜神模拟器**。百度搜就可以去官网下载。

<img src="https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/climb_a_ladder/image/origin.png" width="400" height="300" alt="图片加载失败"/>

- 点一次**“爬一层楼”**按键就会加一，当达到196608的时候就可以看FLAG，作为一个程序员当然要尝试破解一下获取flag。

- apk文件，用**androidkiller**打开然后反编译一下。

```
package com.ctf.test.ctf_100;

import android.os.Bundle;
import android.os.Debug;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import java.util.Random;

public class MainActivity
  extends AppCompatActivity
{
  public int has_gone_int;
  public int to_reach_int;
  
  static
  {
    if (!Debug.isDebuggerConnected()) {
      System.loadLibrary("ctf");
    }
  }
  
  public void Btn_up_onclick(View paramView)
  {
    this.has_gone_int += 1;
    paramView = "" + this.has_gone_int;
    ((TextView)findViewById(2131492948)).setText(paramView);
    if (this.to_reach_int <= this.has_gone_int) {
      ((Button)findViewById(2131492950)).setClickable(true);
    }
  }
  
  public void btn2_onclick(View paramView)
  {
    ((TextView)findViewById(2131492951)).setText("{Flag:" + get_flag(this.to_reach_int) + "}");
  }
  
  public native String get_flag(int paramInt);
  
  protected void onCreate(Bundle paramBundle)
  {
    super.onCreate(paramBundle);
    setContentView(2130968601);
    ((Button)findViewById(2131492950)).setClickable(false);
    this.has_gone_int = 0;
    paramBundle = new Random();
    for (this.to_reach_int = paramBundle.nextInt();; this.to_reach_int = paramBundle.nextInt())
    {
      if (this.to_reach_int < 0) {
        this.to_reach_int *= -1;
      }
      if (5 < this.to_reach_int)
      {
        this.to_reach_int %= 32;
        this.to_reach_int *= 16384;
        ((TextView)findViewById(2131492947)).setText("" + this.to_reach_int);
        ((TextView)findViewById(2131492951)).setText("");
        return;
      }
    }
  }
}
```

- 很容易看到代码逻辑，就是点击就会增加，当点击到一定数目时，提示信息。

- 这块是不能更改代码的，因此找到对应函数的smail文件，进行逻辑修改，有很多种方法，一种是在判断**“已爬楼层是否大于要爬的楼层”**，这里修改成**小于**。或者是将**要爬的楼层更改为0**，或者是**将flag按键一直设置为可点击状态**。
  
<img src="https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/climb_a_ladder/image/clickable.png" width="600" height="80" alt="图片加载失败"/>


- 我使用的是第三种方法。在smail文件中找到**setClickable**函数的位置。正好有**两个**。判断**v3和v5**应该是**true和false**状态，而且**v3恒为true**，因此就是将v**5的位置改成0x1**，就可以实现目的。

<img src="https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/climb_a_ladder/image/v5.png" width="800" height="100" alt="图片加载失败"/><br>
<img src="https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/climb_a_ladder/image/v3.png" width="1000" height="150" alt="图片加载失败"/>
<br>
- 向上找到**v5的定义位置，将0x0，更改为0x1**。

<img src="https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/climb_a_ladder/image/change.png" width="800" height="150" alt="图片加载失败"/><br>

- 需要将修改后的文件，整体**进行编译生成apk文件**，一开始没有编译成功，找了一下原因，有大神说需要**将unknow文件夹删除**掉，里边有之前的签名信息。因此尝试将其删除然后重新编译。用的是**apktool box工具**。

<img src="https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/climb_a_ladder/image/apktool_box.png" width="400" height="300" alt="图片加载失败"/><br>

- 然后就是最后的部分了，将编译好的**apk文件放到夜神模拟器**中测试一下子。
<img src="https://github.com/sunSUNQ/PCTF_REVERSE/raw/master/climb_a_ladder/image/flag.png" width="400" height="300" alt="图片加载失败"/>
<br>

- 拿到了flag，**{flag:268796A5E68A25A1}, 最后提交的时候注意一下格式要求，16位大写MD5。**


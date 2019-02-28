.class public Lcom/example/findpass/MainActivity;
.super Landroid/app/Activity;
.source "MainActivity.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 26
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method


# virtual methods
.method public GetKey(Landroid/view/View;)V
    .locals 15
    .param p1, "view"    # Landroid/view/View;

    .prologue
    .line 35
    const v13, 0x7f080001

    invoke-virtual {p0, v13}, Lcom/example/findpass/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    .line 36
    .local v0, "Fkey":Landroid/widget/EditText;
    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v13

    invoke-interface {v13}, Landroid/text/Editable;->toString()Ljava/lang/String;

    move-result-object v5

    .line 37
    .local v5, "fkey":Ljava/lang/String;
    invoke-virtual {v5}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v13

    invoke-static {v13}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v13

    if-nez v13, :cond_3

    .line 39
    invoke-virtual {p0}, Lcom/example/findpass/MainActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v13

    const v14, 0x7f050003

    invoke-virtual {v13, v14}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v8

    .line 40
    .local v8, "mess":Ljava/lang/String;
    invoke-virtual {v8}, Ljava/lang/String;->toCharArray()[C

    move-result-object v4

    .line 41
    .local v4, "ekey":[C
    array-length v2, v4

    .line 42
    .local v2, "changdu":I
    const/16 v13, 0x400

    new-array v1, v13, [C

    .line 45
    .local v1, "cha":[C
    :try_start_0
    new-instance v7, Ljava/io/InputStreamReader;

    invoke-virtual {p0}, Lcom/example/findpass/MainActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v13

    invoke-virtual {v13}, Landroid/content/res/Resources;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v13

    const-string v14, "src.jpg"

    invoke-virtual {v13, v14}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v13

    invoke-direct {v7, v13}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    .line 46
    .local v7, "inputReader":Ljava/io/InputStreamReader;
    invoke-virtual {v7, v1}, Ljava/io/InputStreamReader;->read([C)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 50
    .end local v7    # "inputReader":Ljava/io/InputStreamReader;
    :goto_0
    const/4 v6, 0x0

    .line 51
    .local v6, "i":I
    :goto_1
    if-lt v6, v2, :cond_0

    .line 65
    new-instance v9, Ljava/lang/String;

    invoke-direct {v9, v4}, Ljava/lang/String;-><init>([C)V

    .line 66
    .local v9, "result":Ljava/lang/String;
    invoke-virtual {v5, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_2

    .line 67
    const-string v13, "\u606d\u559c\u60a8\uff0c\u8f93\u5165\u6b63\u786e\uff01Flag==flag{Key}"

    const/4 v14, 0x1

    invoke-static {p0, v13, v14}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v13

    invoke-virtual {v13}, Landroid/widget/Toast;->show()V

    .line 77
    .end local v1    # "cha":[C
    .end local v2    # "changdu":I
    .end local v4    # "ekey":[C
    .end local v6    # "i":I
    .end local v8    # "mess":Ljava/lang/String;
    .end local v9    # "result":Ljava/lang/String;
    :goto_2
    return-void

    .line 47
    .restart local v1    # "cha":[C
    .restart local v2    # "changdu":I
    .restart local v4    # "ekey":[C
    .restart local v8    # "mess":Ljava/lang/String;
    :catch_0
    move-exception v3

    .line 48
    .local v3, "e":Ljava/lang/Exception;
    invoke-virtual {v3}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0

    .line 53
    .end local v3    # "e":Ljava/lang/Exception;
    .restart local v6    # "i":I
    :cond_0
    aget-char v10, v4, v6

    .line 54
    .local v10, "temp":I
    aget-char v11, v1, v10

    .line 55
    .local v11, "temp1":I
    rem-int/lit8 v12, v11, 0xa

    .line 56
    .local v12, "temp2":I
    rem-int/lit8 v13, v6, 0x2

    const/4 v14, 0x1

    if-ne v13, v14, :cond_1

    .line 58
    aget-char v13, v4, v6

    add-int/2addr v13, v12

    int-to-char v13, v13

    aput-char v13, v4, v6

    .line 51
    :goto_3
    add-int/lit8 v6, v6, 0x1

    goto :goto_1

    .line 62
    :cond_1
    aget-char v13, v4, v6

    sub-int/2addr v13, v12

    int-to-char v13, v13

    aput-char v13, v4, v6

    goto :goto_3

    .line 70
    .end local v10    # "temp":I
    .end local v11    # "temp1":I
    .end local v12    # "temp2":I
    .restart local v9    # "result":Ljava/lang/String;
    :cond_2
    const-string v13, "not right! lol\u3002\u3002\u3002\u3002"

    const/4 v14, 0x1

    invoke-static {p0, v13, v14}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v13

    invoke-virtual {v13}, Landroid/widget/Toast;->show()V

    goto :goto_2

    .line 73
    .end local v1    # "cha":[C
    .end local v2    # "changdu":I
    .end local v4    # "ekey":[C
    .end local v6    # "i":I
    .end local v8    # "mess":Ljava/lang/String;
    .end local v9    # "result":Ljava/lang/String;
    :cond_3
    const-string v13, "\u8bf7\u8f93\u5165key\u503c\uff01"

    const/4 v14, 0x1

    invoke-static {p0, v13, v14}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v13

    invoke-virtual {v13}, Landroid/widget/Toast;->show()V

    goto :goto_2
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 1
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 30
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 31
    const/high16 v0, 0x7f030000

    invoke-virtual {p0, v0}, Lcom/example/findpass/MainActivity;->setContentView(I)V

    .line 32
    return-void
.end method

.method public onCreateOptionsMenu(Landroid/view/Menu;)Z
    .locals 2
    .param p1, "menu"    # Landroid/view/Menu;

    .prologue
    .line 83
    invoke-virtual {p0}, Lcom/example/findpass/MainActivity;->getMenuInflater()Landroid/view/MenuInflater;

    move-result-object v0

    const/high16 v1, 0x7f070000

    invoke-virtual {v0, v1, p1}, Landroid/view/MenuInflater;->inflate(ILandroid/view/Menu;)V

    .line 84
    const/4 v0, 0x1

    return v0
.end method

.method public onOptionsItemSelected(Landroid/view/MenuItem;)Z
    .locals 2
    .param p1, "item"    # Landroid/view/MenuItem;

    .prologue
    .line 92
    invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I

    move-result v0

    .line 93
    .local v0, "id":I
    const v1, 0x7f080003

    if-ne v0, v1, :cond_0

    .line 94
    const/4 v1, 0x1

    .line 96
    :goto_0
    return v1

    :cond_0
    invoke-super {p0, p1}, Landroid/app/Activity;->onOptionsItemSelected(Landroid/view/MenuItem;)Z

    move-result v1

    goto :goto_0
.end method

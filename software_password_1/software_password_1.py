string_a = [0x28, 0x57, 0x64, 0x6b, 0x93, 0x8f, 0x65, 0x51, 0xe3, 0x53, 0xe4, 0x4e, 0x1a, 0xff]
string_b =[0x1b, 0x1c, 0x17, 0x46, 0xf4, 0xfd, 0x20, 0x30,  0xb7, 0x0c,  0x8e,  0x7e,  0x78, 0xde]
flag = str()
for one in range(len(string_a)) :
    flag += chr(string_a[one] ^ string_b[one])
print flag



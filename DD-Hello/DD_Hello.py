string_a =[0x41, 0x10, 0x11, 0x11, 0x1B, 0x0A, 0x64, 0x67, 0x6A, 0x68, 0x62, 0x68, 0x6E, 0x67, 0x68, 0x6B, 0x62, 0x3D, 0x65, 0x6A, 0x6A, 0x3D, 0x68, 0x04, 0x05, 0x08, 0x03, 0x02, 0x02, 0x55, 0x08, 0x5D, 0x61, 0x55, 0x0A, 0x5F, 0x0D, 0x5D, 0x61, 0x32, 0x17, 0x1D, 0x19, 0x1F, 0x18, 0x20, 0x04, 0x02, 0x12, 0x16, 0x1E, 0x54, 0x20, 0x13, 0x14, 0x00, 0x00 ]
C90_add = 0x0000000100000C90
start_add = 0x0000000100000CB0

v2 = (start_add - C90_add >> 2) ^ string_a[0]

for i in range(0, 55) :
    string_a[i] -= 2
    string_a[i] ^= v2
    i += 1
    v2 += 1
del string_a[0]
flag = str()
for one in string_a :
    flag += chr(one)

print flag



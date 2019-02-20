import string
s = [113, 123, 118, 112, 108, 94, 99, 72, 38, 68, 72, 87, 89, 72, 36, 118, 100, 78, 72, 87, 121, 83, 101, 39, 62, 94, 62, 38, 107, 115, 106 ]

flag = str()

for one in range(0, len(s)) :
        flag += chr(s[one] ^ 0x17)
print flag

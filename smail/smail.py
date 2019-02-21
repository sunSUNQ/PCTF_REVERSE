from Crypto.Cipher import AES
import base64

string_a = "cGhyYWNrICBjdGYgMjAxNg=="

string_b = "sSNnx1UKbYrA1+MOrdtDTA=="

content = base64.b64decode(string_a)
kk = base64.b64decode(string_b)

cryptor = AES.new(content, AES.MODE_ECB)

cipher = cryptor.decrypt(kk)

print cipher



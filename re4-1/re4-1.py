string = "c 3 p j v 9 z 1 9 = 3 t < 0 6 0"
word = string.split(" ")
password = ""

for one in range(0, len(word)) :

    for num in range(48, 128) :
        if( (num + one) > 122 ):
            if( ((num + one) % 122 + 47) == ord(word[one]) ):
                password += chr(num)
                break
        else :
            if( (num + one) == ord(word[one]) ):
                password += chr(num)
                break
                
print "flag{" + password + "}"                    
print "flag{c0ngr4tu14ti0ns!}" 



   

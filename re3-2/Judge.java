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

            for (int x = 0; x < flag.length() - 7; x++){
                flaglist.add("flag{" + flag.substring( x, x+8 ) + "}");
            }
            System.out.println( flaglist );

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

            for (int i = 0; i < list.size() - 1; i ++ ){
                for (int j = list.size() - 1; j > i; j -- ){
                    if (list.get(j).equals(list.get(i))){
                        list.remove(j);
                    }
                }
            }
            System.out.println( list );
            System.out.println( list.size() );
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

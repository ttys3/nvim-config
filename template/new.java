import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

// warning: java file basename must be the same as Class name
// this file should be named: Main.java
public class Main {
    public static void main(String[] args) {
        String inputString = "https://www.bing.com/images/feed?form=Z9LH";
        System.out.printf("original string: %s%n", inputString);

        try {
            // Encode the string using UTF-8 encoding
            String encodedString = URLEncoder.encode(inputString, "UTF-8");

            // Print the encoded string
            System.out.println("Encoded string: " + encodedString);
        } catch (UnsupportedEncodingException e) {
            // Handle the exception
            System.out.println("Error: " + e.getMessage());
        }
    }
}

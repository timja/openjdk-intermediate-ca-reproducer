import javax.net.ssl.HttpsURLConnection;
import java.io.IOException;
import java.net.URI;
import java.security.KeyStore;
import java.util.Iterator;
import java.util.Spliterator;
import java.util.Spliterators;
import java.util.stream.Stream;
import java.util.stream.StreamSupport;

public class Main {
    public static void main(String[] args) throws Exception {
        KeyStore keyStore = KeyStore.getInstance(args[1], "Apple");
        keyStore.load(null, null);
        Iterator<String> iterator = keyStore.aliases().asIterator();
        StreamSupport.stream(Spliterators.spliteratorUnknownSize(iterator, Spliterator.ORDERED), false)
                .sorted()
                .forEach(alias -> {
                    if (alias.toLowerCase().contains("timja")) {
                        System.out.println(alias);
                    }
                });
        System.out.println("size:" + keyStore.size());

        System.setProperty("javax.net.ssl.trustStoreType", args[1]);

        String url = args[0];

        try {
            HttpsURLConnection httpsCon = (HttpsURLConnection) new URI(url).toURL().openConnection();
            if (httpsCon.getResponseCode() != 200) {
                throw new RuntimeException("Test failed : bad http response code : " + httpsCon.getResponseCode());
            }
            System.out.println("Success");
        } catch (IOException ioe) {
            throw new RuntimeException("Test failed: ", ioe);
        }
    }
}

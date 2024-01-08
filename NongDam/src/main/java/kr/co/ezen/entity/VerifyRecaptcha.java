package kr.co.ezen.entity;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.URL;
import javax.net.ssl.HttpsURLConnection;

public class VerifyRecaptcha {
    public static final String url = "https://www.google.com/recaptcha/api/siteverify";
    private final static String USER_AGENT = "Mozilla/5.0";
    private static String secret = "6LePKTkpAAAAAMVgafPHWD4wEEy5O8ejitcrzKnh";
    
    								

    public static void setSecretKey(String key) {
        secret = key;
    }

    public static boolean verify(String gRecaptchaResponse) throws IOException {
        if (gRecaptchaResponse == null || "".equals(gRecaptchaResponse)) {
            return false;
        }

        try {
            URL obj = new URL(url);
            HttpsURLConnection con = (HttpsURLConnection) obj.openConnection();

            // add request header
            con.setRequestMethod("POST");
            con.setRequestProperty("User-Agent", USER_AGENT);
            con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");

            String postParams = "secret=" + secret + "&response=" + gRecaptchaResponse;

            // Send post request
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.writeBytes(postParams);
            wr.flush();
            wr.close();

            int responseCode = con.getResponseCode();
            System.out.println("\nSending 'POST' request to URL : " + url);
            System.out.println("Post parameters : " + postParams);
            System.out.println("Response Code : " + responseCode);

            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuilder response = new StringBuilder();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // print result
            System.out.println(response.toString());

            // parse JSON response and return 'success' value using Gson
            JsonObject jsonObject = JsonParser.parseString(response.toString()).getAsJsonObject();

            return jsonObject.getAsJsonPrimitive("success").getAsBoolean();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}

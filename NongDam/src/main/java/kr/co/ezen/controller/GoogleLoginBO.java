package kr.co.ezen.controller;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.UUID;

import javax.servlet.http.HttpSession;


import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Component
public class GoogleLoginBO {
    private final String CODE_URI = "https://accounts.google.com/o/oauth2/auth";
    private final String TOKEN_URI = "https://oauth2.googleapis.com/token";
    private final String USER_INFO_URI = "https://www.googleapis.com/oauth2/v3/userinfo";
    private final String RESPONSE_TYPE = "code";
    private final String GRANT_TYPE = "authorization_code";
    private final String CLIENT_ID = "220297266440-0j0v50kmorgqq1hh49igc2qon03lnrqm.apps.googleusercontent.com";
    private final String CLIENT_SECRET = "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";
    private final String REDIRECT_URI = "http://localhost:8080/ezen/user/googlecallback";
    private final String SCOPE = "openid profile email";
    private final String SESSION_STATE = "google_state";

    RestTemplate restTemplate = new RestTemplate();

    public String requestCode(HttpSession session) throws Exception {
        String state = generateRandomString();
        setSession(session, state);

        String codeRequestUrl = CODE_URI;
        codeRequestUrl += "?response_type=" + RESPONSE_TYPE;
        codeRequestUrl += "&client_id=" + CLIENT_ID;
        codeRequestUrl += "&redirect_uri=" + REDIRECT_URI;
        codeRequestUrl += "&state=" + state;
        codeRequestUrl += "&scope=" + SCOPE;

        System.out.println(codeRequestUrl);
        return codeRequestUrl;
    }

    public String requestToken(HttpSession session, String code, String state) {
        String sessionState = getSession(session);
        String response = "";

        if (StringUtils.pathEquals(state, sessionState)) {
            MultiValueMap<String, String> parameters = new LinkedMultiValueMap<>();
            parameters.add("grant_type", GRANT_TYPE);
            parameters.add("client_id", CLIENT_ID);
            parameters.add("client_secret", CLIENT_SECRET);
            parameters.add("redirect_uri", REDIRECT_URI);
            parameters.add("code", code);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

            HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(parameters, headers);

            try {
                response = restTemplate.postForObject(TOKEN_URI, request, String.class);
                // 토큰에서 access_token 추출
                JsonObject jsonObject = JsonParser.parseString(response).getAsJsonObject();
                response = jsonObject.get("access_token").getAsString();
            } catch (RestClientException e) {
                e.printStackTrace();
                response = "Socket read timed out";
            } catch (Exception e) {
                e.printStackTrace();
                response = "I/O Errors";
            }
        }

        return response;
    }

    public String requestProfile(String token) {
        String result = "";

        try {
            URL url = new URL(USER_INFO_URI);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "Bearer " + token);

            int responseCode = conn.getResponseCode();
            System.out.println("responseCode :" + responseCode);

            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";

            while ((line = bufferedReader.readLine()) != null) {
                result += line;
            }

            System.out.println("responseBody :" + result);
        } catch (Exception e) {
            e.printStackTrace();
            result = "Errors";
        }

        return result;
    }

    // 세션 유효성 검증을 위한 난수 생성
    private String generateRandomString() {
        return UUID.randomUUID().toString();
    }

    // http session에 데이터 저장
    private void setSession(HttpSession session, String state) {
        session.setAttribute(SESSION_STATE, state);
    }

    // http session에서 데이터 가져오기
    private String getSession(HttpSession session) {
        return (String) session.getAttribute(SESSION_STATE);
    }
}

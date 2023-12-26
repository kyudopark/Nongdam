package kr.co.ezen.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import kr.co.ezen.entity.User;
import lombok.Getter;


@Component
public class NaverLoginBO {
	//기본
	private final String clientId = "ceHPG4s5kt7czvVLiEAB";
	private final String clientSecret = "WKIZZH0cdj";
	
	//삭제
	private final String service_provider = "NAVER";
	
	//토큰 요청시 redirect
	public String getRedirectURI() {
		try {
			return URLEncoder.encode("http://localhost:8080/ezen/user/naver-callback", "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public String getState() {
		SecureRandom random = new SecureRandom();
		return new BigInteger(130, random).toString();
	}
	
	//요청시
	public String getRedirectApiURI(String state) {
		String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
		apiURL += "&client_id=" + clientId;
	    apiURL += "&redirect_uri=" + getRedirectURI();
	    apiURL += "&state=" + state;
		
		return apiURL;
	}
	
	//콜백시
	public String getAuthorizationApiURI(String code, String state){
	    String apiURL;
	    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
	    apiURL += "client_id=" + clientId;
	    apiURL += "&client_secret=" + clientSecret;
	    apiURL += "&code=" + code;
	    apiURL += "&state=" + state;
	    
	    return apiURL;
	}
	

	private String getEncodeAccess_token(String access_token) {
		try {
			access_token = URLEncoder.encode(access_token, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return null;
		}
		return access_token;
	}
	
	//탈퇴시
	//authorization
	public String getDeleteApiURL(String access_token) {
		//접근 토큰 갱신 / 삭제 요청시 access_token 값은 URL 인코딩해야만 한다.

		// 로그인 연동해제를 할 경우 입력한 토큰이 유효한 토큰일 경우 정상적으로 연동해제가 됩니다. 
		// 주의 하실 점은 토큰이 유효하지 않을 경우에도 결과가 'success'값으로 리턴되므로 
		// 토큰이 유효한지 먼저 검증한 다음 유효한 토큰으로 갱신하여 연동해제 처리를 하시면 됩니다. 
		// 연동해제를 확인하려면 delete token 이후, 기존 발급 refresh token을 이용하여
		// 더이상 token refresh를 할 수 없을 경우 정상 연동해지가 되었다고 판단하시는 방법이 있습니다.
		String apiURL;
		apiURL ="https://nid.naver.com/oauth2.0/token?grant_type=delete&";
		apiURL += "client_id=" + clientId;
	    apiURL += "&client_secret=" + clientSecret;
	    apiURL += "&access_token=" + getEncodeAccess_token(access_token);
	    apiURL += "&service_provider=" + service_provider;
	    
		return apiURL;
	}
	
	
	//============================================
	//네이버 회원 조회
	public User getNaverProfile(String access_token) {
		//String token = "YOUR_ACCESS_TOKEN"; // 네이버 로그인 접근 토큰;
        String header = "Bearer " + access_token; // Bearer 다음에 공백 추가
        String apiURL = "https://openapi.naver.com/v1/nid/me";
        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("Authorization", header);
        String responseBody = get(apiURL,requestHeaders);

        Gson gson = new Gson();
        JsonObject json = gson.fromJson(responseBody, JsonObject.class);
        
        JsonObject response= (JsonObject) json.get("response");
        String id = response.get("id").getAsString();
        String nickname = response.get("nickname").getAsString();
        String gender = response.get("gender").getAsString();
        String name = response.get("name").getAsString();
        String email = response.get("email").getAsString();
        
        User uvo = new User();
        uvo.setUser_id(id);
        uvo.setUser_pw(id);
        uvo.setUser_nickname(nickname);
        uvo.setUser_gender(gender);
        uvo.setUser_name(name);
        uvo.setUser_email(email);
        uvo.setUser_kakaologin("N");
        uvo.setUser_admin(false);
        
        System.out.println("가져온 사람의 id:"+uvo.getUser_id());
        System.out.println("가져온 사람의 이름:"+uvo.getUser_name());
        System.out.println("가져온 사람의 이메일:"+uvo.getUser_email());
        System.out.println("N?:"+uvo.getUser_kakaologin());
        return uvo;
	}
	private static String get(String apiUrl, Map<String, String> requestHeaders){
        HttpURLConnection con = connect(apiUrl);
        try {
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }
            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
                return readBody(con.getInputStream());
            } else { // 에러 발생
                return readBody(con.getErrorStream());
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();
        }
    }


    private static HttpURLConnection connect(String apiUrl){
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection)url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결에 실패했습니다. : " + apiUrl, e);
        }
    }


    private static String readBody(InputStream body){
        InputStreamReader streamReader = new InputStreamReader(body);
        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();
            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }
            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
        }
    }
	
	
}

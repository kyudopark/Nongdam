package kr.co.ezen.controller;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

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
	
		
		
		
	    private final String googleAuthUrl="https://oauth2.googleapis.com";
		private final String googleLoginUrl="https://accounts.google.com";
		private final String googleRedirectUrl="http://localhost:8080/ezen/user/googlecallback";
		private final String googleClientId="220297266440-0j0v50kmorgqq1hh49igc2qon03lnrqm.apps.googleusercontent.com";
		private final String googleSecret="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";
		private final String scopes="profile,email,openid";
	
    

		public String googleInitUrl() {
	        Map<String, Object> params = new HashMap<>();
	        params.put("client_id", getGoogleClientId());
	        params.put("redirect_uri", getGoogleRedirectUri());
	        params.put("response_type", "code");
	        params.put("scope", getScopeUrl());

	        String paramStr = params.entrySet().stream()
	                .map(param -> param.getKey() + "=" + param.getValue())
	                .collect(Collectors.joining("&"));

	        return getGoogleLoginUrl()
	                + "/o/oauth2/v2/auth"
	                + "?"
	                + paramStr;
	    }

	    public String getGoogleAuthUrl() {
	        return googleAuthUrl;
	    }

	    public String getGoogleLoginUrl() {
	        return googleLoginUrl;
	    }

	    public String getGoogleClientId() {
	        return googleClientId;
	    }

	    public String getGoogleRedirectUri() {
	        return googleRedirectUrl;
	    }

	    public String getGoogleSecret() {
	        return googleSecret;
	    }

		// scope의 값을 보내기 위해 띄어쓰기 값을 UTF-8로 변환하는 로직 포함 
	    public String getScopeUrl() {
//	        return scopes.stream().collect(Collectors.joining(","))
//	                .replaceAll(",", "%20");
	        return scopes.replaceAll(",", "%20");
	    }
	}


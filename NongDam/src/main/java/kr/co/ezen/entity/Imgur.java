package kr.co.ezen.entity;


import java.net.URI;
import java.util.Collections;

import org.json.JSONObject;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;



public class Imgur {
   
   
      private final String API_URI = "https://api.imgur.com/3/image?privacy=private";
      private final String CLIENT_ID = "eb15125b04e445d";

      RestTemplate restTemplate = new RestTemplate();

      public String requestUpload(byte[] imageData) {
         HttpHeaders headers = new HttpHeaders();
         headers.setContentType(MediaType.APPLICATION_JSON);
         headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
         headers.set("Authorization", "Client-ID " + CLIENT_ID);
         headers.set("privacy", "private");
         
         RequestEntity<byte[]> requestEntity = new RequestEntity<byte[]>(imageData, headers, HttpMethod.POST, URI.create(API_URI));
         ResponseEntity<String> responseEntity = restTemplate.exchange(requestEntity, String.class);
         
         JSONObject jsonResponse = new JSONObject(responseEntity.getBody());
         
           String uploadedImageUrl = jsonResponse.getJSONObject("data").getString("link");
         
         return uploadedImageUrl;
      }
   }


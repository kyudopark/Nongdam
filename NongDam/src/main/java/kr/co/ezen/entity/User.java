package kr.co.ezen.entity;

 

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
	private int user_idx;
	
    private String user_id;
	
	
    private String user_pw;
    private String user_zipcode;
    private String user_addr;
    private String user_gender;
    
    private String user_nickname;
    
    private String user_name;
    private String user_profile;
    private String user_email;
    private String user_kakaologin;
    private boolean user_admin;
    
    
}
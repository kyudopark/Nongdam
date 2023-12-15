package kr.co.ezen.entity;

 

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Data;


@Data
public class User {
	private Long user_idx;
	@NotNull
	@Size(min = 4, max = 20)
    private String user_id;
	@NotNull
	@Size(min = 4, max = 20)
    private String user_pw;
    private String user_zipcode;
    private String user_addr;
    private String user_gender;
    @NotNull
    private String user_nickname;
    @NotNull
    private String user_name;
    private String user_profile;
    private String user_email;
    private String user_kakaologin;
    private boolean user_admin;
    
    public User(String user_id,  String user_nickname,  String user_email, String user_kakaologin) {
        this.user_id = user_id;
        
        this.user_nickname = user_nickname;
        
        this.user_email = user_email;
        this.user_kakaologin = user_kakaologin;
        
    }
}
package kr.co.ezen.entity;

import lombok.Data;

@Data
public class User {
	private Long user_idx;
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
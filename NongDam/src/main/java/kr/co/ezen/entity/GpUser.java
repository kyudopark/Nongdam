package kr.co.ezen.entity;

import java.util.Date;

import lombok.Data;

@Data
public class GpUser {
	
	private int gp_idx;
	private int user_idx;
	
	private String gp_addr;
	private String gp_name;
	private String gp_email;
	private String gp_num;

	
}

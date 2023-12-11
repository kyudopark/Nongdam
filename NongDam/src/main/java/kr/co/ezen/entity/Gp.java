package kr.co.ezen.entity;

import java.time.LocalDateTime;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class Gp {
	
	private int gp_idx;
	private String gp_title;
	private String gp_product;
	private String gp_content;
	private String gp_price;
	private Date gp_date;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date gp_date_start;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date gp_date_last;
	
	
	private String gp_thumb;
	private int user_idx;
	
}

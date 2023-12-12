package kr.co.ezen.controller;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/inquire/*")
public class InquireController {

	@Autowired 
	private JavaMailSender javaMailSender;
	
	@RequestMapping("/main")
	public String main() {	
		return "inquire/main";
	}
	
	//@CrossOrigin(origins = {"http://localhost:8080", "https://localhost:8080"}, allowedHeaders = "*")
	@PostMapping("/submitEmailForm")
	@ResponseBody
	public void submitEmailForm(
            @RequestParam String inquire_category,
            @RequestParam String inquire_title,
            @RequestParam String inquire_content,
            @RequestParam String inquire_email
            
    ) {
        try {
            // Create a SimpleMailMessage
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo("kdpark1002@gmail.com"); // Set the recipient email address
            message.setSubject(inquire_title); // Set the email subject
            message.setText("Category: " + inquire_category + "\n\n" + inquire_content); // Set the email content
            message.setFrom(inquire_email);
            
            
            // Send the email
            javaMailSender.send(message);
            
            
        } catch (MailException e) {
            e.printStackTrace();
            
        }
    }
	
}
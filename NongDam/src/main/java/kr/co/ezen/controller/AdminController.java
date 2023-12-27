package kr.co.ezen.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Gp;
import kr.co.ezen.entity.GpUser;
import kr.co.ezen.entity.Tr;
import kr.co.ezen.entity.User;
import kr.co.ezen.service.AdminService;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	
	@RequestMapping("/main")
	public String main(Model m, Gp gp, Tr tr, GpUser gpUser) {

		gp.setGpCount(adminService.countGpAll(gp));
		tr.setTrCount(adminService.countTrAll(tr));
		gpUser.setGpUserCount(adminService.countGpUserAll(gpUser));

		m.addAttribute("gp", gp);
		m.addAttribute("tr", tr);
		m.addAttribute("gpUser", gpUser);
		return "admin/main";
	}
	
	
	@RequestMapping("/userManage")
	public String findAll(Model m,Criteria cri){
		if (cri.getKeyword() == null) {
			cri.setKeyword("");
		}
		
		List<User> li = adminService.findAll(cri);
		
		m.addAttribute("cri", cri);
		m.addAttribute("li", li);
		
		return "admin/userManage";
		
	}
	
	@PostMapping("/deleteByIdx")
	public @ResponseBody void deleteByIdx(int user_idx) {
		adminService.deleteByIdx(user_idx);
	}
	
	@PostMapping("/deleteByCheckbox")
	public @ResponseBody void deleteByCheckbox(@RequestBody List<Integer> selectedUsers) {
	    adminService.deleteByCheckbox(selectedUsers);
	}
	
	@PostMapping("/updateAdminStatus")
	public @ResponseBody void updateAdminStatus(User user) {
		adminService.updateAdminStatus(user);
	}
 
}

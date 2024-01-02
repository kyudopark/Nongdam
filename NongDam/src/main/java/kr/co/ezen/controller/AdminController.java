package kr.co.ezen.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.ezen.entity.Criteria;
import kr.co.ezen.entity.Free;
import kr.co.ezen.entity.Gp;
import kr.co.ezen.entity.Tr;
import kr.co.ezen.entity.User;
import kr.co.ezen.service.AdminService;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	
	@RequestMapping("/main")
	public String main(Model m, Gp gp, Tr tr, Free free, @RequestParam(name = "selectedDate", required = false) String selectedDate) {
		
		gp.setGpCount(adminService.countGpAll());
		tr.setTrCount(adminService.countTrAll());
		free.setFreeCount(adminService.countFreeAll());

		m.addAttribute("gp", gp);
		m.addAttribute("tr", tr);
		m.addAttribute("free", free);
		
		// 선택된 날짜가 없으면 기본 데이터만 가져옴
	    if (selectedDate != null && !selectedDate.isEmpty()) {
	        // 선택된 날짜에 대한 데이터 가져오기
	        Map<String, Integer> dateCounts = adminService.getCountsByDate(selectedDate);

	        // 새로운 데이터 추가
	        m.addAttribute("gpCountByDate", dateCounts.get("gpCount"));
	        m.addAttribute("trCountByDate", dateCounts.get("trCount"));
	        m.addAttribute("freeCountByDate", dateCounts.get("freeCount"));
	    }
	    
		return "admin/main";
	}
	
	@RequestMapping("/getCountsByDate")
	public @ResponseBody Map<String, Object> getCountsByDate(@RequestParam(name = "date") String date) {
	    Map<String, Object> resultMap = new HashMap<>();

	    // 기존의 데이터
	    Map<String, Integer> baseCounts = adminService.getCountsByDate(date);
	    resultMap.put("baseCounts", baseCounts);

	    // 전일과 다음날 데이터 가져오기
	    Map<String, Integer> minus1DayCounts = adminService.getCountsByDate(date, -1);
	    resultMap.put("minus1DayCounts", minus1DayCounts);
	    
	    Map<String, Integer> plus1DayCounts = adminService.getCountsByDate(date, 1);
	    resultMap.put("plus1DayCounts", plus1DayCounts);
	    
	    resultMap.put("selectedDate", date); // 추가된 부분

	    return resultMap;
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

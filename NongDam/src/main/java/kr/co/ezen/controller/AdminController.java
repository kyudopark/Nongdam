package kr.co.ezen.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
		public String main(Model m, Gp gp, Tr tr, GpUser gpUser, @RequestParam(required = false) String selectedDate) {
		    // 기본 기간 설정
		    gp.setStartDate(parseDate("2023-07-19"));
		    gp.setEndDate(parseDate("2024-01-17"));
		    tr.setStartDate(parseDate("2023-07-19"));
		    tr.setEndDate(parseDate("2024-01-17"));
	
		    // 선택한 날짜가 있을 경우 해당 날짜로 설정
		    if (selectedDate != null) {
		        Date selectedDateObj = parseDate(selectedDate);
		        gp.setStartDate(selectedDateObj);
		        gp.setEndDate(selectedDateObj);
		        tr.setStartDate(selectedDateObj);
		        tr.setEndDate(selectedDateObj);
		    }
	
		    // 날짜 범위에 해당하는 라벨 생성
		    List<String> dateLabels = generateDateLabels(gp.getStartDate(), gp.getEndDate());
	
		    // Retrieve and update counts
		    gp.setGpCount(adminService.countGpAll(gp));
		    tr.setTrCount(adminService.countTrAll(tr));
		    gpUser.setGpUserCount(adminService.countGpUserAll(gpUser));
	
		    // 데이터를 Model에 추가
		    m.addAttribute("gp", gp);
		    m.addAttribute("tr", tr);
		    m.addAttribute("gpUser", gpUser);
		    m.addAttribute("labels", dateLabels);
	
		    // 뷰 페이지 경로 반환
		    return "admin/main";
		}

		private List<String> generateDateLabels(Date startDate, Date endDate) {
		    // startDate와 endDate 사이의 날짜를 생성하여 List에 추가
		    List<String> dateLabels = new ArrayList<>();
		    Calendar calendar = Calendar.getInstance();
		    calendar.setTime(startDate);

		    while (!calendar.getTime().after(endDate)) {
		        dateLabels.add(new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime()));
		        calendar.add(Calendar.DAY_OF_MONTH, 1);
		    }

		    return dateLabels;
		}
	
		private Date parseDate(String dateStr) {
		    try {
		        return new SimpleDateFormat("yyyy-MM-dd").parse(dateStr);
		    } catch (ParseException e) {
		        e.printStackTrace();
		        // 예외 처리 로직 추가
		        return null;
		    }
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

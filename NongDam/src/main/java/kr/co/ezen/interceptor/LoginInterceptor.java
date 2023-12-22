package kr.co.ezen.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.co.ezen.entity.User;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	
   @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        HttpSession session = request.getSession();
        User uvo = (User) session.getAttribute("uvo");
               
        if(uvo.isUser_admin() == false) {
        	String redirectUrl = request.getContextPath(); // 로그인 페이지로 리다이렉트
            response.sendRedirect(redirectUrl);
        	
        	return false;
        }

        return true;
    }

}
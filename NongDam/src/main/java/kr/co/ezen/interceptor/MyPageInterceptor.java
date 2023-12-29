package kr.co.ezen.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.co.ezen.entity.User;

public class MyPageInterceptor extends HandlerInterceptorAdapter{

	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        HttpSession session = request.getSession();
        User uvo = (User) session.getAttribute("uvo");
        
        
        //true false select 
        
        if (uvo == null) {
            // 로그인이 되어 있지 않은 경우 처리할 내용
            String redirectUrl = request.getContextPath(); // 로그인 페이지로 리다이렉트
            response.sendRedirect(redirectUrl);
            return false;
        }

        
        
        return true;
   }
}
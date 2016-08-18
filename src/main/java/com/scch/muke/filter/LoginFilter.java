package com.scch.muke.filter;

import java.io.IOException;
  
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
  
import org.springframework.web.filter.OncePerRequestFilter;

public class LoginFilter extends OncePerRequestFilter {
	@Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
    	throws ServletException, IOException {
		Object objs = request.getSession().getAttribute("username");
        if (null == objs) {
        	Cookie cookie = null;
        	cookie = new Cookie("login","0");
			cookie.setPath("/");
			cookie.setMaxAge(-1);
			//cookie.setHttpOnly(true);
			response.addCookie(cookie);
        }
        // 不过滤的uri
        String[] notFilter = new String[] { "login", "logout", "favicon", "static", "index", "study", "exam"};
  
        // 请求的uri
        String uri = request.getRequestURI();

        // uri中包含background时才进行过滤
        //if (uri.indexOf("background") != -1) {
        if (uri != "") {
            // 是否过滤
            boolean doFilter = true;
            for (String s : notFilter) {
                if (uri.indexOf(s) != -1 || uri.equals("/")) {
                    // 如果uri中包含不过滤的uri，则不进行过滤
                    doFilter = false;
                    break;
                }
            }
            if (doFilter) {
                // 执行过滤
                // 从session中获取登录者实体
                Object obj = request.getSession().getAttribute("username");
                if (null == obj) {
                	response.sendRedirect("/login");
                } else {
                    // 如果session中存在登录者实体，则继续  
                    filterChain.doFilter(request, response);
                }
            } else {
                // 如果不执行过滤，则继续  
                filterChain.doFilter(request, response);
            }
        } else {
            // 如果uri中不包含background，则继续  
            filterChain.doFilter(request, response);
        }
    }
}
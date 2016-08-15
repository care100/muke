package com.scch.muke.filter;

import java.io.IOException;
import java.io.PrintWriter;
  
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
  
import org.springframework.web.filter.OncePerRequestFilter;

public class LoginFilter extends OncePerRequestFilter {
	@Override
    protected void doFilterInternal(HttpServletRequest request,
            HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
  
        // 不过滤的uri
        String[] notFilter = new String[] { "login", "logout", "index", "favicon", "static"};
  
        // 请求的uri
        String uri = request.getRequestURI();
        System.out.println(uri+"=======================filter");

        // uri中包含background时才进行过滤
        //if (uri.indexOf("background") != -1) {
        if (uri != "") {
            // 是否过滤
            boolean doFilter = true;
            for (String s : notFilter) {
                if (uri.indexOf(s) != -1) {
                    // 如果uri中包含不过滤的uri，则不进行过滤
                    doFilter = false;
                    break;
                }
            }
            if (doFilter) {
                // 执行过滤
                // 从session中获取登录者实体
            	System.out.println("need filter=======================filter");
                Object obj = request.getSession().getAttribute("username");
                if (null == obj) {
                    // 如果session中不存在登录者实体，则弹出框提示重新登录  
                    // 设置request和response的字符集，防止乱码  
                    /*request.setCharacterEncoding("UTF-8");  
                    response.setCharacterEncoding("UTF-8");  
                    PrintWriter out = response.getWriter();  
                    String loginPage = "....";  
                    StringBuilder builder = new StringBuilder();  
                    builder.append("<meta charset='UTF-8'>");  
                    builder.append("网页过期，请重新登录！");  
                    out.print(builder.toString());  */
                	
                	response.sendRedirect("/login");
                } else {
                    // 如果session中存在登录者实体，则继续  
                    filterChain.doFilter(request, response);
                }
            } else {
                // 如果不执行过滤，则继续  
            	System.out.println("do not need filter=======================filter");
                filterChain.doFilter(request, response);
            }
        } else {
            // 如果uri中不包含background，则继续  
            filterChain.doFilter(request, response);
        }
    }
}
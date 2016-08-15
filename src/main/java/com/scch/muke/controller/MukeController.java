package com.scch.muke.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

//@Controller
//@RequestMapping("/welcome")
public class MukeController extends HttpServlet {
//	@Resource
	//private static User user;
	
	/*public static void main (String args[]) {
		String name = user.getName();
    	System.out.println(name);a
	}*/
	
	
	
//	@Autowired
//    @RequestMapping("/welcome")
//    public String getNewName(@RequestParam("userName") String userName, HttpServletRequest request){
//        System.out.println("sada");
//        
//		return "helloworld";
//    }
//	
/*	@Autowired
	@RequestMapping("/test")
	public String supplierIndex(HttpServletRequest request, HttpServletResponse response) {
		return "test";
	}*/
	
	public void doGet(HttpServletRequest req,HttpServletResponse resp)throws IOException,ServletException //抛出异常

    {

           PrintWriter out = resp.getWriter();//实例化out对象。

           out.println("<HTML>");

           out.println("<HEAD>");

           out.println("<TITLE>THE FIRSTSERVLET</TITLE>") ;

           out.println("</HEAD>");

           out.println("<BODY>");

           out.println("<H1>HelloWorld!!!</H1>") ;

           out.println("</BODY>");

           out.println("</HTML>");

           out.close() ;

    }

    public void doPost(HttpServletRequest req,HttpServletResponse resp)throws IOException,ServletException

    {

        HttpServletRequest request = null;
		HttpServletResponse response = null;
		this.doGet(request,response);

    }
}
	
	
	
	
	
	
	
	
	
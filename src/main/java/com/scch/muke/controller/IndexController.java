package com.scch.muke.controller;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import org.json.JSONObject;

import com.scch.muke.dao.UserDao;
import com.scch.muke.encrypt.MD5;
import com.scch.muke.service.UserService;
import com.scch.muke.vo.Sixiu;
import com.scch.muke.vo.User;

@Controller
public class IndexController {
	@Resource
	private UserService userService;
	
	//登录
	@RequestMapping("/login")
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession) throws Exception {
		if ("POST".equalsIgnoreCase(request.getMethod())) {
			String username = request.getParameter("username").trim();
			String password = request.getParameter("password").trim();
			User user = new User();
			try{
				user = userService.getUserByUsername(username);
				password = MD5.md5Encode("scch+"+password);
				String usernames = user.getUsername();
				String passwords = user.getPassword();
				Integer userId = user.getId();
				if(password.equals(passwords)){
					httpSession.setAttribute("login",true);
					httpSession.setAttribute("username",usernames);
					httpSession.setAttribute("userId",userId);
					//String refererUrl = request.getHeader("referer");
					response.sendRedirect("/index");
				}else{
					System.out.println("username or password wrongs!");
					ModelAndView mv = new ModelAndView("login");
					mv.addObject("errorMsg","用户名或密码错误，请重新登录！");
					return mv;
				}
			}catch(Exception e){
				System.out.println("username or password wrong!");
				ModelAndView mv = new ModelAndView("login");
				mv.addObject("errorMsg","用户名或密码错误，请重新登录！");
				return mv;
			}
			
			
			/*HashMap<String,Object> data = new HashMap<String,Object>();
			data.put("username", username);
			data.put("password", password);
			System.out.println(username);
			System.out.println(password);*/
			
			
			
			ModelAndView mv = new ModelAndView("login");
			return mv;
		}else{
			try{
				Object login = httpSession.getAttribute("login");
				System.out.println(login.toString());
			}catch(Exception e){
				System.out.println("not loginin");
			}
			
			//Object username = httpSession.
			String id = httpSession.getId();
			System.out.println(id);
			Enumeration<String> name = httpSession.getAttributeNames();
			System.out.println(name);
			Cookie cookie = null;
			Cookie[] cookies = null;
			cookies = request.getCookies();
			System.out.println(cookies);
			if( cookies != null ){
				for (int i = 0; i < cookies.length; i++){
			         cookie = cookies[i];
			         System.out.print("Name : " + cookie.getName() + ",  ");
			         System.out.println("Value: " + cookie.getValue());
				}
			}
			String refererUrl = request.getHeader("referer");
        	System.out.println(refererUrl);
			ModelAndView mv = new ModelAndView("login");
			return mv;
		}
	}
	
	//退出
	@RequestMapping("/logout")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession) throws Exception {
		httpSession.removeAttribute("username");
		httpSession.removeAttribute("login");
		response.sendRedirect("/index");
		ModelAndView mv = new ModelAndView("login");
		return mv;
	}
	
	//首页
	@RequestMapping("/index")
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession){
		//String name = user.getName();
		HashMap<String,Object> data = new HashMap<String,Object>();
		data.put("name", "David");
		ModelAndView mv = new ModelAndView("index",data);
		User user = new User();
		Integer userId = (Integer) httpSession.getAttribute("userId");
		user.setId(userId);
		user = userService.getUser(user);
		String username = user.getUsername();
		
		List<Map<String,Object>> chapters = new ArrayList<Map<String,Object>>();
		
		Map<String,Object> chapterX = new HashMap();
		chapterX.put("chapName", "绪论 珍惜大学生活 开拓新的境界");
		chapterX.put("studyLink","/xulun");
		chapterX.put("exam",-2);
		
		Map<String,Object> chapter1 = new HashMap();
		chapter1.put("chapName", "第一章 追求远大理想 坚定崇高信念");
		chapter1.put("studyLink","/chap1");
		
		Map<String,Object> chapter2 = new HashMap();
		chapter2.put("chapName", "第二章 弘扬中国精神 共筑精神家园");
		chapter2.put("studyLink","/chap2");
		
		Map<String,Object> chapter3 = new HashMap();
		chapter3.put("chapName", "第三章 领悟人生真谛 创造人生价值");
		chapter3.put("studyLink","/chap3");
		
		Map<String,Object> chapter4 = new HashMap();
		chapter4.put("chapName", "第四章 注重道德传承  加强道德实践");
		chapter4.put("studyLink","/chap4");
		
		Map<String,Object> chapter5 = new HashMap();
		chapter5.put("chapName", "第五章 遵守道德规范  锤炼高尚品格");
		chapter5.put("studyLink","/chap5");
		
		Map<String,Object> chapter6 = new HashMap();
		chapter6.put("chapName", "第六章 学习先发法律  建设法治体系");
		chapter6.put("studyLink","/chap6");
		
		Map<String,Object> chapter7 = new HashMap();
		chapter7.put("chapName", "第七章 树立法治观念  尊重法律权威");
		chapter7.put("studyLink","/chap7");
		chapter7.put("exam",-2);
		
		Map<String,Object> chapter8 = new HashMap();
		chapter8.put("chapName", "第八章 形式法律权利  履行法律义务");
		chapter8.put("studyLink","/chap8");
		chapter8.put("exam",-2);
		try{
			Sixiu sixiu = userService.getSixiuByUserId(user.getId());
			chapterX.put("study",sixiu.getXulun());
			chapter1.put("study",sixiu.getChap1());
			chapter1.put("exam",sixiu.getChap1Exam());
			chapter2.put("study",sixiu.getChap2());
			chapter2.put("exam",sixiu.getChap2Exam());
			chapter3.put("study",sixiu.getChap3());
			chapter3.put("exam",sixiu.getChap3Exam());
			chapter4.put("study",sixiu.getChap4());
			chapter4.put("exam",sixiu.getChap4Exam());
			chapter5.put("study",sixiu.getChap5());
			chapter5.put("exam",sixiu.getChap5Exam());
			chapter6.put("study",sixiu.getChap6());
			chapter6.put("exam",sixiu.getChap6Exam());
			chapter7.put("study",sixiu.getChap7());
			chapter8.put("study",sixiu.getChap8());
		}catch (Exception e){
			Sixiu sixiu = new Sixiu();
			sixiu.setUserId(userId);
			userService.insertSixiu(sixiu);
			chapterX.put("study",null);
			chapter1.put("study",null);
			chapter1.put("exam",null);
			chapter2.put("study",null);
			chapter2.put("exam",null);
			chapter3.put("study",null);
			chapter3.put("exam",null);
			chapter4.put("study",null);
			chapter4.put("exam",null);
			chapter5.put("study",null);
			chapter5.put("exam",null);
			chapter6.put("study",null);
			chapter6.put("exam",null);
			chapter7.put("study",null);
			chapter8.put("study",null);
		}
		
		chapters.add(chapterX);
		chapters.add(chapter1);
		chapters.add(chapter2);
		chapters.add(chapter3);
		chapters.add(chapter4);
		chapters.add(chapter5);
		chapters.add(chapter6);
		chapters.add(chapter7);
		chapters.add(chapter8);
		mv.addObject("chapters", chapters);
		mv.addObject("username", username);
		return mv;
	}
	
	//绪论学习
	@RequestMapping("/xulun")
	public ModelAndView xulun(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession){
		Sixiu sixiu = new Sixiu();
		Integer userId = (Integer) httpSession.getAttribute("userId");
		sixiu.setUserId(userId);
		sixiu.setXulun(1);
		userService.updateSixiu(sixiu);
		
		
		ModelAndView mv = new ModelAndView("xulun");
		return mv;
	}
	
	//异步更新学习进度：完成
	@RequestMapping(value = "/chapster")
	@ResponseBody
	public String chapster(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession){
		List<String> aaa = new ArrayList<String>();
		Map<String,Object> obj = new HashMap<String,Object>();
		obj.put("key1", "value1");
		obj.put("key2", "value2");
		obj.put("key3", "value3");
		JSONObject jsonObj = new JSONObject(obj);
		System.out.println(jsonObj);
		System.out.println(jsonObj.toString());
		aaa.add("nimei");
		aaa.add("nige");
		Sixiu sixiu = new Sixiu();
		Integer userId = (Integer) httpSession.getAttribute("userId");
		sixiu.setUserId(userId);
		
		String chap = request.getParameterValues("chap")[0];
		Integer status = Integer.parseInt(request.getParameterValues("status")[0]);
		if("xulun".equals(chap)){
			sixiu.setXulun(status);
		}else if("chap1".equals(chap)){
			sixiu.setChap1(status);
		}else if("chap2".equals(chap)){
			sixiu.setChap2(status);
		}else if("chap3".equals(chap)){
			sixiu.setChap3(status);
		}else if("chap3".equals(chap)){
			sixiu.setChap3(status);
		}else if("chap4".equals(chap)){
			sixiu.setChap4(status);
		}else if("chap5".equals(chap)){
			sixiu.setChap5(status);
		}else if("chap6".equals(chap)){
			sixiu.setChap6(status);
		}else if("chap7".equals(chap)){
			sixiu.setChap7(status);
		}else if("chap8".equals(chap)){
			sixiu.setChap8(status);
		}
		userService.updateSixiu(sixiu);
		System.out.println(chap);
		System.out.println(status);
		return jsonObj.toString();
	 }
}

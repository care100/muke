package com.scch.muke.controller;

import java.io.InputStream;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import com.scch.muke.encrypt.MD5;
import com.scch.muke.service.UserService;
import com.scch.muke.vo.Exam;
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
				String name = user.getName();
				if(password.equals(passwords)){
					httpSession.setAttribute("login",true);
					httpSession.setAttribute("username",usernames);
					httpSession.setAttribute("userId",userId);
					httpSession.setAttribute("password",passwords);
					httpSession.setAttribute("name",name);
					Cookie cookie = new Cookie("login","1");
					cookie.setPath("/");
					cookie.setMaxAge(-1);
					//cookie.setHttpOnly(true);
					response.addCookie(cookie);
					if(usernames.equals("admin")){
						response.sendRedirect("/admin");
					}else{
						response.sendRedirect("/");
					}
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
			ModelAndView mv = new ModelAndView("login");
			return mv;
		}else{
			try{
				Object login = httpSession.getAttribute("login");
				System.out.println(login.toString());
			}catch(Exception e){
				System.out.println("not loginin");
			}
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
	public void logout(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession) throws Exception {
		httpSession.removeAttribute("username");
		httpSession.removeAttribute("userId");
		httpSession.removeAttribute("login");
		httpSession.removeAttribute("passwords");
		httpSession.removeAttribute("name");
		Cookie cookie = new Cookie("login", null);
		cookie.setMaxAge(0);
		cookie.setPath("/");
		response.addCookie(cookie);
		response.sendRedirect("/");
	}
	
	//修改密码页面
	@RequestMapping("/changePass")
	public ModelAndView changePass(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession) throws Exception {
		ModelAndView mv = new ModelAndView("changePass");
		return mv;
	}
	
	//异步修改密码
	@RequestMapping(value = "/change")
	@ResponseBody
	public Map<String,Object> change(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession) throws Exception{
		String password = (String) httpSession.getAttribute("password");
		String oldPass = request.getParameterValues("oldPass")[0];
		String newPass = request.getParameterValues("newPass")[0];
		String renewPass = request.getParameterValues("renewPass")[0];
		oldPass = MD5.md5Encode("scch+"+oldPass);
		Map<String,Object> obj = new HashMap<String,Object>();
		if(!newPass.equals(renewPass)){
			obj.put("status", false);
			obj.put("msg", "两次输入的密码不一致！");
			return obj;
		}
		if(password.equals(oldPass)){
			String username = (String) httpSession.getAttribute("username");
			User user = userService.getUserByUsername(username);
			String Md5NewPass = MD5.md5Encode("scch+"+newPass);
			user.setPassword(Md5NewPass);
			try{
				userService.updateUser(user);
				obj.put("status", true);
				obj.put("msg", "修改成功！");
			}catch(Exception e){
				obj.put("status", false);
				obj.put("msg", "修改失败，请重试！");
				throw e;
			}
		}else{
			obj.put("status", false);
			obj.put("msg", "原密码不正确！");
		}
		return obj;
	}
	
	//首页
	@RequestMapping("/")
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession){
		List<Map<String,Object>> chapters = new ArrayList<Map<String,Object>>();
		Map<String,Object> chapterX = new HashMap<String,Object>();
		chapterX.put("chapName", "绪论 珍惜大学生活 开拓新的境界");
		
		Map<String,Object> chapter1 = new HashMap<String,Object>();
		chapter1.put("chapName", "第一章 追求远大理想 坚定崇高信念");
		
		Map<String,Object> chapter2 = new HashMap<String,Object>();
		chapter2.put("chapName", "第二章 弘扬中国精神 共筑精神家园");
		
		Map<String,Object> chapter3 = new HashMap<String,Object>();
		chapter3.put("chapName", "第三章 领悟人生真谛 创造人生价值");
		
		Map<String,Object> chapter4 = new HashMap<String,Object>();
		chapter4.put("chapName", "第四章 注重道德传承  加强道德实践");
		
		Map<String,Object> chapter5 = new HashMap<String,Object>();
		chapter5.put("chapName", "第五章 遵守道德规范  锤炼高尚品格");
		
		Map<String,Object> chapter6 = new HashMap<String,Object>();
		chapter6.put("chapName", "第六章 学习先发法律  建设法治体系");
		
		Map<String,Object> chapter7 = new HashMap<String,Object>();
		chapter7.put("chapName", "第七章 树立法治观念  尊重法律权威");
		
		Map<String,Object> chapter8 = new HashMap<String,Object>();
		chapter8.put("chapName", "第八章 形式法律权利  履行法律义务");
		
		User user = new User();
		Integer userId = (Integer) httpSession.getAttribute("userId");
		if(userId == null){
			Sixiu sixiu = new Sixiu();
			chapterX.put("study",sixiu.getXulun());
			chapterX.put("exam",sixiu.getXulunExam());
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
			chapter7.put("exam",sixiu.getChap7Exam());
			chapter8.put("study",sixiu.getChap8());
			chapter8.put("exam",sixiu.getChap8Exam());
		}else{
			user.setId(userId);
			user = userService.getUser(user);
			try{
				Sixiu sixiu = userService.getSixiuByUserId(userId);
				chapterX.put("study",sixiu.getXulun());
				chapterX.put("exam",sixiu.getXulunExam());
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
				chapter7.put("exam",sixiu.getChap7Exam());
				chapter8.put("study",sixiu.getChap8());
				chapter8.put("exam",sixiu.getChap8Exam());
			}catch (Exception e){
				Sixiu sixiu = new Sixiu();
				sixiu.setUserId(userId);
				userService.insertSixiu(sixiu);
				sixiu = userService.getSixiuByUserId(userId);
				chapterX.put("study",sixiu.getXulun());
				chapterX.put("exam",sixiu.getXulunExam());
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
				chapter7.put("exam",sixiu.getChap7Exam());
				chapter8.put("study",sixiu.getChap8());
				chapter8.put("exam",sixiu.getChap8Exam());
			}
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
		ModelAndView mv = new ModelAndView("index");
		mv.addObject("chapters", chapters);
		return mv;
	}
	
	//学习进度更新：进行中
	@RequestMapping("/study")
	public ModelAndView xulun(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession){
		Integer chapIndex = Integer.parseInt(request.getParameter("chapIndex").trim());
		Integer userId = (Integer) httpSession.getAttribute("userId");
		String flash = "chap" + chapIndex.toString();
		if(userId == null){
			
		}else{
			Sixiu sixiu = userService.getSixiuByUserId(userId);
			switch(chapIndex){
			case 0:
				if(sixiu.getXulun() == null){
					sixiu.setXulun(1);
				}
				break;
			case 1:
				if(sixiu.getChap1() == null){
					sixiu.setChap1(1);
				}
				break;
			case 2:
				if(sixiu.getChap2() == null){
					sixiu.setChap2(1);
				}
				break;
			case 3:
				if(sixiu.getChap3() == null){
					sixiu.setChap3(1);
				}
				break;
			case 4:
				if(sixiu.getChap4() == null){
					sixiu.setChap4(1);
				}
				break;
			case 5:
				if(sixiu.getChap5() == null){
					sixiu.setChap5(1);
				}
				break;
			case 6:
				if(sixiu.getChap6() == null){
					sixiu.setChap6(1);
				}
				break;
			case 7:
				if(sixiu.getChap7() == null){
					sixiu.setChap7(1);
				}
				break;
			case 8:
				if(sixiu.getChap8() == null){
					sixiu.setChap8(1);
				}
				break;
			}
			userService.updateSixiu(sixiu);
		}
		ModelAndView mv = new ModelAndView("study");
		mv.addObject("flash", flash);
		return mv;
	}
	
	//异步更新学习进度：完成
	@RequestMapping(value = "/chapster")
	@ResponseBody
	public Map<String,Object> chapster(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession){
		Integer userId = (Integer) httpSession.getAttribute("userId");
		Sixiu sixiu = userService.getSixiuByUserId(userId);
		Integer chap = Integer.parseInt(request.getParameterValues("chap")[0]);
		Integer status = Integer.parseInt(request.getParameterValues("status")[0]);
		switch(chap){
		case 0:
			sixiu.setXulun(status);
			break;
		case 1:
			sixiu.setChap1(status);
			break;
		case 2:
			sixiu.setChap2(status);
			break;
		case 3:
			sixiu.setChap3(status);
			break;
		case 4:
			sixiu.setChap4(status);
			break;
		case 5:
			sixiu.setChap5(status);
			break;
		case 6:
			sixiu.setChap6(status);
			break;
		case 7:
			sixiu.setChap7(status);
			break;
		case 8:
			sixiu.setChap8(status);
			break;
		}
		userService.updateSixiu(sixiu);
		Map<String,Object> obj = new HashMap<String,Object>();
		obj.put("status", true);
		return obj;
	 }
	
	//测试题
	@RequestMapping("/exam")
	public ModelAndView exam(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession){
		Integer chapIndex = Integer.parseInt(request.getParameter("chapIndex").trim());
		List<Exam> examPan = userService.getExam(chapIndex, 0);
		List<Exam> examDan = userService.getExam(chapIndex, 1);
		List<Exam> examDuo = userService.getExam(chapIndex, 2);
		List<Exam> examJian = userService.getExam(chapIndex, 3);
		String[] code = {"A","B","C","D","E","F","G","H","I","J"};
		List<Map<String,Object>> chapters = new ArrayList<Map<String,Object>>();
		Map<String,Object> chapterX = new HashMap<String,Object>();
		chapterX.put("chapName", "绪论 珍惜大学生活 开拓新的境界");
		
		Map<String,Object> chapter1 = new HashMap<String,Object>();
		chapter1.put("chapName", "第一章 追求远大理想 坚定崇高信念");
		
		Map<String,Object> chapter2 = new HashMap<String,Object>();
		chapter2.put("chapName", "第二章 弘扬中国精神 共筑精神家园");
		
		Map<String,Object> chapter3 = new HashMap<String,Object>();
		chapter3.put("chapName", "第三章 领悟人生真谛 创造人生价值");
		
		Map<String,Object> chapter4 = new HashMap<String,Object>();
		chapter4.put("chapName", "第四章 注重道德传承  加强道德实践");
		
		Map<String,Object> chapter5 = new HashMap<String,Object>();
		chapter5.put("chapName", "第五章 遵守道德规范  锤炼高尚品格");
		
		Map<String,Object> chapter6 = new HashMap<String,Object>();
		chapter6.put("chapName", "第六章 学习先发法律  建设法治体系");
		
		Map<String,Object> chapter7 = new HashMap<String,Object>();
		chapter7.put("chapName", "第七章 树立法治观念  尊重法律权威");
		
		Map<String,Object> chapter8 = new HashMap<String,Object>();
		chapter8.put("chapName", "第八章 形式法律权利  履行法律义务");
		
		chapters.add(0,chapterX);
		chapters.add(1,chapter1);
		chapters.add(2,chapter2);
		chapters.add(3,chapter3);
		chapters.add(4,chapter4);
		chapters.add(5,chapter5);
		chapters.add(6,chapter6);
		chapters.add(7,chapter7);
		chapters.add(8,chapter8);
		ModelAndView mv = new ModelAndView("exam");
		mv.addObject("examPan", examPan);
		mv.addObject("examDan", examDan);
		mv.addObject("examDuo", examDuo);
		mv.addObject("examJian", examJian);
		mv.addObject("code", code);
		mv.addObject("chapters", chapters.get(chapIndex));
		return mv;
	}
	//异步更新测试状态：未通过+通过
	@RequestMapping(value = "/examGrade")
	@ResponseBody
	public Map<String,Object> examGrade(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession){
		Integer chap = Integer.parseInt(request.getParameterValues("chap")[0]);
		Integer result = Integer.parseInt(request.getParameterValues("result")[0]);
		Integer userId = (Integer) httpSession.getAttribute("userId");
		Sixiu sixiu = userService.getSixiuByUserId(userId);
		switch(chap){
		case 0:
			sixiu.setXulunExam(result);
			break;
		case 1:
			sixiu.setChap1Exam(result);
			break;
		case 2:
			sixiu.setChap2Exam(result);
			break;
		case 3:
			sixiu.setChap3Exam(result);
			break;
		case 4:
			sixiu.setChap4Exam(result);
			break;
		case 5:
			sixiu.setChap5Exam(result);
			break;
		case 6:
			sixiu.setChap6Exam(result);
			break;
		case 7:
			sixiu.setChap7Exam(result);
			break;
		case 8:
			sixiu.setChap8Exam(result);
			break;
		}
		userService.updateSixiu(sixiu);
		Map<String,Object> obj = new HashMap<String,Object>();
		obj.put("status", true);
		return obj;
	}

	@RequestMapping(value="/admin")
	public ModelAndView admin(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession) throws Exception{
		String username = (String) httpSession.getAttribute("username");
		ModelAndView mv = new ModelAndView("admin");
		if(username.equals("admin")){
			if("POST".equalsIgnoreCase(request.getMethod())){
				try{
					MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
					MultipartFile file = multipartRequest.getFile("students");
					 InputStream input = file.getInputStream();
					 Workbook excel = null;
					 excel = Workbook.getWorkbook(input);
					 Sheet readsheet = excel.getSheet(0);
					 int rsColumns = readsheet.getColumns();
					 if(rsColumns != 6){
						 mv.addObject("fileUploadrMsg","表格格式有误，请参考模板！");
						 return mv;
					 }
					 int rsRows = readsheet.getRows();
					 for (int i = 1; i < rsRows; i++)
			         {
						 User user = new User();
			             for (int j = 0; j < rsColumns; j++)
			             {
			                 Cell cell = readsheet.getCell(j, i);
			                 switch(j){
			                 case 0:	 
			                	 user.setUsername(cell.getContents());
			                 case 1:
			                	 String pass = "scch+"+cell.getContents();
			                	 user.setPassword(MD5.md5Encode(pass));
			                 case 2:
			                	 user.setName(cell.getContents());
			                 case 3:
			                	 user.setStudentId(cell.getContents());
			                 case 4:
			                	 user.setMajor(cell.getContents());
			                 case 5:
			                	 user.setClasss(cell.getContents());
			                 }
			             }
			             userService.insertUser(user);
			         }
					mv.addObject("fileUploadrMsg","上传成功！");
					return mv;
				}catch(Exception e){
					mv.addObject("fileUploadrMsg","上传失败，请重试！");
					return mv;
				}
			}else{
				String searchKey = request.getParameter("student");
				if(searchKey == null){
					List<Map<String,Object>> status = userService.getGrade();
					mv.addObject("status", status);
				}else{
					byte source [] = searchKey.getBytes("iso8859-1");
					searchKey = new String (source,"UTF-8");
					searchKey = searchKey.trim();
					if(searchKey.length() < 1){
						List<Map<String,Object>> status = userService.getGrade();
						mv.addObject("status", status);
					}else{
						String searchMsg = "";
						try{
							List<Map<String,Object>> status = userService.searchGrade(searchKey);
							mv.addObject("status", status);
							if(status.size() == 0){
								searchMsg = "学员不存在！";
							}
						}catch(Exception e){
							searchMsg = "学员不存在！";
						}
						mv.addObject("searchKey", searchKey);
						mv.addObject("searchMsg", searchMsg);
					}
				}
				return mv;
			}
		}else{
			response.sendRedirect("/");
		}
		return mv;
	}
}

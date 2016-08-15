package com.scch.muke.controller;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.scch.muke.dao.UserDao;
import com.scch.muke.service.MeimeiService;

@Controller
public class MeimeiController {
	
	@Resource
	private UserDao userDao;
	
//	@Autowired
	@RequestMapping("/meimei")
	@ResponseBody
	public String meimei(HttpServletRequest request, HttpServletResponse response){
		//System.out.println("sada");
		//String name = user.getName();
		return "meimei";
	}
	
	@RequestMapping("/tt")
	public ModelAndView tt(HttpServletRequest request, HttpServletResponse response){
		System.out.println("3232");
		//String name = user.getName();
		ModelAndView mv = new ModelAndView("tt");
		return mv;
	}
	
	@RequestMapping("/tx/{username}")
	public String tx(@PathVariable("username") String username){
		System.out.println(username);
		//String name = user.getName();
		return "tt";
	}
	
	@RequestMapping(value = "/method", method = RequestMethod.GET)
	public String methodG(HttpServletRequest request, HttpServletResponse response, @RequestParam("oo") String oo){
		String method = request.getParameter("get").trim();
		String ooo = oo.trim();
		System.out.println(method);
		System.out.println(ooo);
		//String name = user.getName();
		return "tt";
	}
	
	@RequestMapping(value = "/method", method = RequestMethod.POST)
	public String methodP(HttpServletRequest request, HttpServletResponse response){
		String method = request.getParameter("post").trim();
		System.out.println(method);
		//String name = user.getName();
		return "tt";
	}
	
	@RequestMapping(value = "/param")
	public ModelAndView param(HttpServletRequest request, HttpServletResponse response){
		//String name = user.getName();
		HashMap<String,Object> data = new HashMap<String,Object>();
		data.put("name", "David");
		ModelAndView mv = new ModelAndView("param",data);
		String xing = "Sun";
		String meiname = userDao.getName();
		mv.addObject("xing",xing);
		mv.addObject("meiname",meiname);
		return mv;
	}
}
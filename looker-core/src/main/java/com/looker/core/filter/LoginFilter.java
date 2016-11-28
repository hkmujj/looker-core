package com.looker.core.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.looker.core.model.CoresBase;
import com.looker.core.model.SysUser;
import com.looker.core.util.SpringContextUtil;

public class LoginFilter implements Filter {
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
//		loginUrl=coresBase.getLoginUrl();
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest servletRequest = (HttpServletRequest) request;
		HttpServletResponse servletResponse = (HttpServletResponse) response;
		HttpSession session = servletRequest.getSession();
		
		StringBuffer url = servletRequest.getRequestURL();
		
		// 从session获取用户信息
		SysUser user = (SysUser) session.getAttribute("loginUserInfo");
		// 判断如果没有取到用户信息,就跳转到登陆页面
		if (user == null || "".equals(user.getUserId())) {
			// 跳转到登陆页面
			CoresBase coresBase = (CoresBase) SpringContextUtil.getBean("coresBase");
			
			// 特殊用途的路径可以直接访问
			String urlStr = url.toString();
			String[] urls = new String[]{"login","checkLogin","dataApiManager","frontend_view/libs","frontend_view/images","frontend_view/css","frontend_view/js/common"}; 
			
			for(String str:urls){
				if(urlStr.contains(str)){
					chain.doFilter(servletRequest, servletResponse);
					return;
				}
			}
			servletResponse.sendRedirect(request.getServletContext().getContextPath() + "/frontend_view/login.html"+"?"+System.currentTimeMillis());
		    
		} else {
			// 已经登陆,继续此次请求
			chain.doFilter(request, response);
		}
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
	}
	
}

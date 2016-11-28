package com.looker.core.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.looker.core.util.DesUtil;

public class CoresRequestFilter implements Filter {
	
	private final Log logger = LogFactory.getLog(CoresRequestFilter.class);
	
	public void destroy() {
		logger.info("☻ ☻ ☻ ☻ CoresRequestFilter 销毁了  ☻ ☻ ☻ ☻ ");
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");
		String data=request.getParameter("data");
		String json = "";
		if(StringUtils.isNotEmpty(data)){
			try {
				json = DesUtil.decrypt(data);
//				logger.info(" 爬虫请求DSC解密后的参数："+json);
				request.setAttribute("jsonParam", json);
				chain.doFilter(request, response);
			} catch (Exception e) {
				logger.error("解密失败,请检查参数格式!");
				e.printStackTrace();
				response.getWriter().write("解密失败,请检查参数格式"+e.getMessage());
				return;
			}
		}else{
			logger.info("请检查参数格式,不能为空");
			response.getWriter().write("请检查参数格式,不能为空");
			return;
		}
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		
	}
	
	public String getIpAddr(HttpServletRequest request) { 
	       String ip = request.getHeader("x-forwarded-for"); 
	       if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	           ip = request.getHeader("Proxy-Client-IP"); 
	       } 
	       if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	           ip = request.getHeader("WL-Proxy-Client-IP"); 
	       } 
	       if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	           ip = request.getRemoteAddr(); 
	       } 
	       return ip; 
	}

	public static void main(String[] args) {

	}
}

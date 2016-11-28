package com.looker.core.common;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import com.star.common.util.Util;

/**
 * @author Administrator
 *
 */
public class ExceptionHandler implements HandlerExceptionResolver {

	@Override
	public ModelAndView resolveException(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex) {
		
		boolean isAjaxRequest = isAjaxRequest(request);
		Map<String,Object> resultMap = new HashMap<String,Object>();
        ex.printStackTrace();  
        request.setAttribute("ex", ex);  
        //根据不同的请求返回错误页面或包装JSON数据
        String errorMsg = ex.getLocalizedMessage();
        // 根据不同错误转向不同页面  
        if((errorMsg == null || "".equals(errorMsg)) || isAjaxRequest){
        	if(ex instanceof NullPointerException){
        		errorMsg = "空指针异常";
        	}else if(ex instanceof ArrayIndexOutOfBoundsException){
        		errorMsg = "数组越界";
        	}else{
        		errorMsg = "操作异常";
        	}
        	//定义数据库异常、业务异常、事务异常等
        }
        
        
        if(isAjaxRequest){
        	Util.putFailedRes(resultMap, errorMsg, ex);
        	this.writeJson(response, resultMap);
        	return null;
        }else{
        	return new ModelAndView("/mainstyle/errorGlobal");
        }
	}
	
	public boolean isAjaxRequest(HttpServletRequest request){
		String requestPath = request.getRequestURI();
		
		return requestPath.indexOf("/ajax/")!= -1 ||requestPath.indexOf("/tab/")!= -1 ||requestPath.indexOf("/dialog/")!= -1 ;
	}
	
	
	public void writeJson(HttpServletResponse response,Object obj){
		try {
			response.reset();
			response.setContentType("text/json;charset=UTF-8");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().println(Util.toJSonString(obj));
			response.getWriter().flush();
			response.getWriter().close();
		 } catch (Exception e) {
			 
		}
	}

}

package com.looker.core.token;

import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * @description 防重提交拦截器
 */
public class TokenInterceptor extends HandlerInterceptorAdapter {
	
	private Log logger = LogFactory.getLog(getClass());

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	if (handler instanceof HandlerMethod) {
            HandlerMethod handlerMethod = (HandlerMethod) handler;
            Method method = handlerMethod.getMethod();
            Token annotation = method.getAnnotation(Token.class);
            if (annotation != null) {
                boolean needRemoveSession = annotation.checkToken();
                if (needRemoveSession) {
                    if (isRepeatSubmit(request)) {
                    	logger.error("该请求"+request.getServletPath()+"存在重复提交，服务端不接受此请求！");
                        return false;
                    }
                }
            }
            return true;
        } else {
            return super.preHandle(request, response, handler);
        }
    }

    /**
     * @Description 通过比较session中的token和request中的token是否一致来判断是否重复提交
     * @param request
     * @return
     */
    private boolean isRepeatSubmit(HttpServletRequest request) {
        String serverToken = (String) request.getSession(false).getAttribute("token");
        if (serverToken == null) {
            return true;
        }
        String clinetToken = request.getParameter("token");
        if (clinetToken == null) {
            return true;
        }
        if (!clinetToken.equals(serverToken)) {
            return true;
        }
        return false;
    }
    
    public void postHandle(     
            HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView)     
            throws Exception {     
    	if (handler instanceof HandlerMethod) {
            HandlerMethod handlerMethod = (HandlerMethod) handler;
            Method method = handlerMethod.getMethod();
            Token annotation = method.getAnnotation(Token.class);
            if (annotation != null) {
                boolean needRemoveSession = annotation.checkToken();
                if (needRemoveSession ) {
                    request.getSession(false).removeAttribute("token");
                	System.out.println("成功删除token");
                }
            }
        }
    }     
}
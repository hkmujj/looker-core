package com.looker.core.service;

import java.util.List;
import java.util.Map;


/**
 * @description 邮件发送服务
 */
public interface MailService {
	
	/**
	 * @Description 邮件发送服务 ,一个模板对应一组参数或者一个模板对应多组参数
	 * @param subject 邮件主题
	 * @param messageType 邮件类别，如果有多个类别用","分隔
	 * @param to 收件人
	 * @param param 邮件模板中对用的占位符
	 * @param params 针对一条邮件中有多个记录,邮件模板只有一条情况
	 * @return
	 */
	void sendSimpleMail(String subject,String messageType,String to,Object[] param,List<Object[]> params) throws Exception;
	
	
	/**
	 * @Description 邮件发送服务 ,多个模板对应多组参数
	 * @param subject 邮件主题
	 * @param params key值为邮件模板，value值为，邮件模板对应的参数
	 * @param to 收件人
	 * @return
	 */
	void sendMassMail(String subject,Map<String, List<Object[]>> params,String to) throws Exception;
	
	
}

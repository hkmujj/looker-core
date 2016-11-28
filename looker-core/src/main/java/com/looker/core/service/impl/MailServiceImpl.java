package com.looker.core.service.impl;

import java.text.MessageFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.looker.core.model.ZMessageRecords;
import com.looker.core.service.MailService;
import com.looker.core.service.MessageRecordService;
import com.looker.core.util.mail.MailSenderManager;
import com.niwodai.tech.base.dao.IBaseDao;
import com.niwodai.tech.base.util.StringUtil;

/**
 * @description 邮件发送服务实现类
 * @author helei
 * @date 2016-7-21 14:07:29
 */
@Service("mailSendService")
public class MailServiceImpl implements MailService{
	
	@Resource
	IBaseDao<Map<String,Object>> iBaseDao;
	
	@Resource
	private MessageRecordService messageRecordService;

	@Override
	public void sendSimpleMail(String subject,String messageType,String to,Object[] param,List<Object[]>  params) throws Exception {

		try {
			
			boolean isSendSuccess = false;
			
			Map<String, Object> mapParams = new HashMap<String, Object>();
			mapParams.put("messageType", messageType);
			Map<String, Object> message = queryMessageTemplatesByType(mapParams);
		
			if(message != null){
				//是否发送
				String sendSwitch = (String) message.get("SEND_SWITCH");
				//邮件模板
				String template = (String) message.get("TEMPLATE_CONTENT");
				
				//可以发送
				if("0".equals(sendSwitch)){
					//组装邮件内容
					String mailContent = "";
					StringBuffer mailBuffer = new StringBuffer();
					
					//对于单条数据发送邮件
					if(param != null){
						mailContent = mailBuffer.append(MessageFormat.format(template, param)).toString();
					}
					
					//对于多条数据要拼装
					if(params != null){
						for(Object[] o : params){
							mailBuffer.append(MessageFormat.format(template, o));
							mailBuffer.append("\n");
						}
						mailContent = mailBuffer.toString();
					}
					
					//发送给多个人
					if(!StringUtil.isEmpty(to) && to.indexOf(",") != -1){
						isSendSuccess = MailSenderManager.sendMassMailSender(to, subject, mailContent);
					}else{
						isSendSuccess = MailSenderManager.sendSimpleMailSender(to, subject, mailContent);
					}
					
					//邮件入库
					if(isSendSuccess){
						insertMailRecord(mailContent,to,String.valueOf((Long) message.get("ID")));
					}
					
				}
				
			}else{
				throw new Exception("获取邮件模板出错");
			}
		
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("系统出错");
		}
		
	}

	@Override
	public void sendMassMail(String subject, Map<String, List<Object[]>> params,
			String to) throws Exception {
		try {
			
			boolean isSendSuccess = false;
			
			//邮件内容
			StringBuffer mailBuffer = new StringBuffer();
			Map<String, Object> mapParams = new HashMap<String, Object>();
			
			String temId = "";
			
			//取出map
			Set<String> keySet = params.keySet();
			
			for(String obj:keySet){//遍历key
				//通过key取出模板内容
				mapParams.put("messageType", obj);
				Map<String, Object> message = queryMessageTemplatesByType(mapParams);
				
				if(message != null){
					//是否发送
					String sendSwitch = (String) message.get("SEND_SWITCH");
					//邮件模板
					String template = (String) message.get("TEMPLATE_CONTENT");
					
					temId += (Long) message.get("ID") + ",";
					
					//可以发送
					if("0".equals(sendSwitch)){
						//组装邮件内容
						//对于多条数据要拼装
						if(params.get(obj) != null){
							for(Object[] o : params.get(obj)){
								mailBuffer.append(MessageFormat.format(template, o));
								mailBuffer.append("\n");
							}
						}
						
					}
					
				}else{
					throw new Exception("获取邮件模板出错");
				}
				
			}
			
			if(!StringUtil.isEmpty(mailBuffer.toString())){
				isSendSuccess = MailSenderManager.sendSimpleMailSender(to, subject, mailBuffer.toString());
			}
			
			//邮件内容入库
			if(isSendSuccess){
				insertMailRecord(mailBuffer.toString(),to,temId);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("系统出错");
		}
	}
	
	

	private Map<String, Object> queryMessageTemplatesByType(Map<String, Object> params){
		return iBaseDao.findObjectByQuery("ZMessageTemplates.findZMessageTemplates", params);
	}

	
	private void insertMailRecord(String mailContent,String to,String temId){
		ZMessageRecords messageRecord = new ZMessageRecords();
		messageRecord.setCreateTime(new Date());
		messageRecord.setMessageContent(mailContent);
		messageRecord.setSendDate(new Date());
		messageRecord.setRecipient(to);
		messageRecord.setTemplateId(temId);
		messageRecordService.insertMessageRecord(messageRecord);
	}
	
}

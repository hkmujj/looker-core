package com.looker.core.util.mail;

/**
 * @ClassName: MailSenderManager 
 * @Description: 邮件发送
 * @author zhengyangjun 
 * @date 2016年7月18日 上午10:14:57 
 */
public class MailSenderManager {

	/**发送邮件的服务器的IP和端口**/
	//public static final String MAIL_SERVERHOST = "smtp1.niwodai.net";
	public static final String MAIL_SERVERHOST = "smtp.163.com";
	public static final String MAIL_SERVERPORT = "25";
	/**登陆邮件发送服务器的用户名和密码**/
	//public static final String MAIL_USERNAME = "system@jiayincredit.com";
	//public static final String MAIL_PASSWORD = "LoveWinCredit";
	public static final String MAIL_USERNAME = "esportxufei@163.com";
	public static final String MAIL_PASSWORD = "jiayincredit";

	/**邮件发送者的地址**/
	public static final String MAIL_FROMADDRESS = "esportxufei@163.com";
	//public static final String MAIL_FROMADDRESS = "system@jiayincredit.com";
	/**发送系统签名**/
	private static final String MAIL_SYSTEM_NAME = "【征信管理平台】";
	
	/**
	 * @Title: getMailInfo 
	 * @Description: 获得邮件主体
	 * @param @param toAddress 邮件接收者的地址
	 * @param @param subject 邮件主题
	 * @param @param content 邮件的文本内容
	 * @return MailSenderInfo
	 * @throws
	 */
	public static MailSenderInfo getMailInfo(String toAddress,String subject,String content){
		MailSenderInfo mailInfo = new MailSenderInfo();
        mailInfo.setMailServerHost(MAIL_SERVERHOST);
        mailInfo.setMailServerPort(MAIL_SERVERPORT);
        mailInfo.setValidate(true);
        mailInfo.setUserName(MAIL_USERNAME);
        mailInfo.setPassword(MAIL_PASSWORD);//您的邮箱密码
        mailInfo.setFromAddress(MAIL_FROMADDRESS);
        mailInfo.setToAddress(toAddress);
        mailInfo.setSubject(subject);
        mailInfo.setContent(MAIL_SYSTEM_NAME+content);
        return mailInfo;
	}
	
	/**
	 * @Title: sendSimpleMailSender 
	 * @Description: 单个邮件发送
	 * @param @param toAddress 邮件接收者的地址
	 * @param @param subject 邮件主题
	 * @param @param content 邮件的文本内容
	 * @param @return 
	 * @return boolean
	 * @throws
	 */
	public static boolean sendSimpleMailSender(String toAddress,String subject,String content){
		return SimpleMailSender.sendTextMail(MailSenderManager.getMailInfo(toAddress,subject,content));
	}
	
	/**
	 * @Title: sendMassMailSender 
	 * @Description: 多个邮件发送（群发）
	 * @param @param toAddress 邮件接收者的地址用逗号隔开：zhengyangjun@jiayincredit.com,system@jiayincredit.com 
	 * @param @param subject 邮件主题
	 * @param @param content 邮件的文本内容
	 * @param @return 
	 * @return boolean
	 * @throws
	 */
	public static boolean sendMassMailSender(String toAddress,String subject,String content){
		return MassMailSender.sendTextMail(MailSenderManager.getMailInfo(toAddress,subject,content));
	}
	
	public static void main(String[] args) {
		//这个类主要来发送邮件(单个)
        boolean success = MailSenderManager.sendSimpleMailSender("zhengyangjun@jiayincredit.com", "管理重置用户密码", "测试邮件，管理重置用户密码成功！您的密码为：654321");
        //这个类主要来发送邮件(多个)
//        boolean success = MailSenderManager.sendMassMailSender("zhengyangjun@jiayincredit.com,helei@jiayincredit.com,lvfanrui@jiayincredit.com", "管理重置用户密码", "测试邮件，管理重置用户密码成功！您的密码为：654321");
        if(success){
            System.out.println("Email 发送成功！");
        }
	}

}

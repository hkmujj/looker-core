package com.looker.core.util;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
/**
 * 通过手机号码,获得该号码的归属地
 * 
 * @author 郑阳军
 *
 */
public class MobileFromUtil {
	
//	private Log logger = LogFactory.getLog(getClass());
	
	//正则表达式,审核要获取手机归属地的手机是否符合格式,可以只输入手机号码前7位
	public static final String REGEX_IS_MOBILE = "(?is)(^1[3|4|5|8][0-9]\\d{4,8}$)";
	
	/**
	 * 获得手机号码归属地：(上海,移动全球通卡)
	 * 
	 * @param mobileNumber
	 * @return
	 * @throws Exception
	 */
	public static String getMobileFrom(String mobileNumber) throws Exception {
		if(mobileNumber.length()>11){
			return  ",";
//			logger.info("-------- 不是完整的11位手机号或者正确的手机号前七位 ----------- ---");
		}
		HttpClient client=null;
		PostMethod method=null;
		NameValuePair mobileParameter=null;
		NameValuePair actionParameter=null;
		int httpStatusCode;
		String htmlSource=null;
		String result=null;
		try {
			client=new HttpClient();
			client.getHostConfiguration().setHost("www.ip138.com", 8080, "http");
			method=new PostMethod("/search.asp");
			mobileParameter=new NameValuePair("mobile",mobileNumber);
			actionParameter=new NameValuePair("action","mobile");
			method.setRequestBody(new NameValuePair[] { actionParameter,mobileParameter }); 
			//设置编码
			method.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, "GB2312");
			
			client.executeMethod(method);
			httpStatusCode=method.getStatusLine().getStatusCode();
			if(httpStatusCode!=200){
				result = ",";
//				logger.error("获得手机号码归属地网页异常！Http Status Code:"+httpStatusCode);
			}else{
				htmlSource=method.getResponseBodyAsString();
				if(htmlSource!=null&&!htmlSource.equals("")){
					result=parseMobileFrom(htmlSource);
				}				
			}
		} catch (RuntimeException e) {
			result = ",";
			e.printStackTrace();
		}finally{
			method.releaseConnection();
		}
		
		return result;
		
	}


	/**
	 * 从www.ip138.com返回的结果网页内容中获取手机号码归属地,结果为：省份 城市
	 * 
	 * @param htmlSource
	 * @return
	 */
	public static String parseMobileFrom(String htmlSource){
		Document  d =Jsoup.parse(htmlSource);
		String phoneAddress = d.select(".tdc").get(4).select("td").get(1).text();
		phoneAddress = phoneAddress.replace(new String(new char[] { (char) 160 }), "");
		String type = d.select(".tdc").get(5).select("td").get(1).text();
		return phoneAddress+","+type;
		
	}
	
	/**
	 * Test
	 * @param args
	 * @throws Exception 
	 */
	public static void main(String[] args) throws Exception {
		System.out.println(getMobileFrom("13593083241"));
	}

}
package com.looker.core.util;

import com.alibaba.fastjson.JSONObject;

import org.apache.commons.io.IOUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.Charset;

/**
 *
 * 发送HTTP 请求 聚信立服务方法
 * @author jacobdong@juxinli.com
 * 2015年1月22日
 *
 */
public class HttpUtils {

    private static final Logger LOGGER = LoggerFactory.getLogger(HttpUtils.class);

    public static JSONObject getJSONResponse(String url) {
//        LOGGER.info("# GET 请求URL 为" + url);
        JSONObject jsonObject = new JSONObject();
        HttpClientBuilder httpClientBuilder = HttpClientBuilder.create();
        HttpGet get = new HttpGet(url);
        try (CloseableHttpClient closeableHttpClient = httpClientBuilder.build()) {
            HttpResponse resp = closeableHttpClient.execute(get);
            jsonObject = convertResponseBytes2JSONObject(resp);
        } catch (IOException e) {
            e.printStackTrace();
        }
//        LOGGER.info("# GET 响应结果：{}", jsonObject);
        return jsonObject;
    }

    public static JSONObject postJSONData(String url, String jsonStrData) {
        LOGGER.info("# POST JSON 请求URL 为{}", url);
//        LOGGER.info("# POST JSON 数据为{}",jsonStrData);
        HttpClientBuilder httpClientBuilder = HttpClientBuilder.create();
        HttpPost post = new HttpPost(url);
        JSONObject jsonObject = null;
        try (CloseableHttpClient closeableHttpClient = httpClientBuilder.build()) {
            HttpEntity entity = new StringEntity(jsonStrData, "UTF-8");
            post.setEntity(entity);
            post.setHeader("Content-type", "application/json");
            HttpResponse resp = closeableHttpClient.execute(post);
            jsonObject = convertResponseBytes2JSONObject(resp);
        } catch (IOException e) {
            e.printStackTrace();
        }
//        LOGGER.info("# POST 响应结果：{}", jsonObject);
        return jsonObject;
    }


    public static JSONObject convertResponseBytes2JSONObject(HttpResponse resp) {
        JSONObject jsonObject = null;
        try {
            InputStream respIs = resp.getEntity().getContent();
            byte[] respBytes = IOUtils.toByteArray(respIs);
            String result = new String(respBytes, Charset.forName("UTF-8"));

            if (null == result || result.length() == 0) {
                // TODO
                LOGGER.info("无响应");
            } else {
                if (result.startsWith("{") && result.endsWith("}")) {
                    jsonObject = (JSONObject) JSONObject.parse(result);
                } else {
                    // TODO
                    LOGGER.info("不能转成JSON对象");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return jsonObject;
    }
    
    
	public static JSONObject getIdentity(String cardId) {
	    BufferedReader reader = null;
	    String result = null;
	    StringBuffer sbf = new StringBuffer();
	    String httpUrl = "http://apis.baidu.com/apistore/idservice/id?id=" + cardId;
	    try {
	        URL url = new URL(httpUrl);
	        HttpURLConnection connection = (HttpURLConnection) url
	                .openConnection();
	        connection.setRequestMethod("GET");
	        // 填入apikey到HTTP header
	        connection.setRequestProperty("apikey",  "a040d1d88e13474dba6302174fa1e85a");
	        connection.connect();
	        InputStream is = connection.getInputStream();
	        reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
	        String strRead = null;
	        while ((strRead = reader.readLine()) != null) {
	            sbf.append(strRead);
	            sbf.append("\r\n");
	        }
	        reader.close();
	        result = sbf.toString();
        } catch (Exception e) {
	        e.printStackTrace();
	    }
	    JSONObject json = (JSONObject) JSONObject.parse(result);
	    return json;
	}
}

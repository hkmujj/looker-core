package com.looker.core.util;

import java.io.StringWriter;
import java.util.Calendar;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.Reader;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Clob;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.zip.Adler32;
import java.util.zip.CheckedInputStream;
import java.util.zip.CheckedOutputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.w3c.dom.Document;



import freemarker.template.Configuration;
import freemarker.template.Template;

public class Common {

	public static String DataFill(Class<?> clas,Object obj, String name, String templateFile,Map<String, Object> root ) {
		// 用户登录信息 取得
		//SecSysUser secSysUser = (SecSysUser) SecurityContextHolder.getContext()
				//	.getAuthentication().getPrincipal();
		String str = "";
//		Map<String, Object> root = new HashMap<String, Object>();
		root.put(name, obj);
//		root.put("systemName", "adm");
//		Calendar now = Calendar.getInstance();
//		String currentDate = now.get(Calendar.YEAR) + "年" + 
//							(now.get(Calendar.MONTH) + 1) + "月" + 
//							now.get(Calendar.DAY_OF_MONTH) + "日" + 
//							now.get(Calendar.HOUR_OF_DAY) + "时" + 
//							now.get(Calendar.MINUTE) + "分";
//		root.put("systemDate", currentDate);
		// 创建一个Configuration实例
		Configuration cfg = new Configuration();
		// 设置FreeMarker的模版文件位置
		cfg.setClassForTemplateLoading(clas, "/");
		cfg.setDefaultEncoding("UTF-8");
		// 取得模版文件
		StringWriter sw = new StringWriter();
		try {
			Template t = cfg.getTemplate(templateFile);
			t.setEncoding("UTF-8");
			t.process(root, sw);// 用模板来开发servlet可以只在代码里面加入动态的数据
			str = sw.toString();
			sw.close();
			sw.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return str;
	}
	
}

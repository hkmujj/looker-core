package com.looker.core.util;

import java.io.IOException;  
import java.text.SimpleDateFormat;  
import java.util.Date;  
  
import org.codehaus.jackson.JsonGenerator;  
import org.codehaus.jackson.JsonProcessingException;  
import org.codehaus.jackson.map.JsonSerializer;  
import org.codehaus.jackson.map.ObjectMapper;  
import org.codehaus.jackson.map.SerializerProvider;  
import org.codehaus.jackson.map.ser.CustomSerializerFactory;  
/**
 * @description 解决@ResponseBody注解返回json的日期格式问题
 * @author lvfanrui
 * @date 2016年7月25日
 */
public class CoresObjectMapper extends ObjectMapper {
	public CoresObjectMapper() {
		CustomSerializerFactory factory = new CustomSerializerFactory();
		factory.addGenericMapping(Date.class, new JsonSerializer<Date>() {

			@Override
			public void serialize(Date value, JsonGenerator jgen,SerializerProvider provider) throws IOException,JsonProcessingException {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				jgen.writeString(sdf.format(value));
			}
		});
		this.setSerializerFactory(factory);
	}
	
}

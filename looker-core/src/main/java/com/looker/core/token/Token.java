package com.looker.core.token;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @description 防重提交的token注解，使用方式：在需要做防重提交的方法上注解@Token(checkToken=true)
 * @author lvfanrui
 * @date 2016年7月12日
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface Token {

	boolean checkToken() default false;
	
}
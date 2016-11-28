package com.looker.core.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: Yang Guang
 * Date: 2015/6/24 18:22
 * Description:
 */
public class DateUtil {

    public static final String CHINA_DATE = "yyyy年MM月";
    public static final String CHINA_DATETIME = "yyyy年MM月dd日";
    public static final String defaultDatePattern = "yyyy-MM-dd HH:mm:ss";
    public static final String simpleMsPattern = "yyyy-MM-dd HH:mm:ss SSS";
    public static final String simpleDatePattern = "yyyyMMdd";
    public static final String simpleHourDatePattern = "yyyyMMddHH";
    public static final String simpleMinuteDatePattern = "yyyyMMddHHmm";
    public static final String simpleSecDatePattern = "yyyyMMddHHmmss";

    public static String format(String date, String pattern){
        String result = null;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat(pattern);
            Date d = sdf.parse(date);
            sdf = new SimpleDateFormat("yyyy-MM-dd");
            result = sdf.format(d);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public static String format(Date date, String pattern){
        return parseDateToString(date, pattern);
    }


    /**
     * 将日期转化成指定格式
     * @param date
     * @param pattern
     * @return
     */
    public static String parseDateToString(Date date, String pattern) {
        DateFormat format = new SimpleDateFormat(pattern);
        if (date != null) {
            return format.format(date);
        }
        return null;
    }

    public static void main(String[] args) {
        System.out.println(format("20150206", simpleDatePattern));
    }

}
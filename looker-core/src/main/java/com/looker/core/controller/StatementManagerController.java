package com.looker.core.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.looker.core.model.CoresBase;
import com.looker.core.token.Token;

/**
 * @description 报表管理controller
 */
@Controller
@RequestMapping("/cores/statementManager")
public class StatementManagerController {
	
	@Resource
	CoresBase coresBase;
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	/**
	 * @Description 报表上传
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/uploadStatement.qyzx")
	@ResponseBody
	@Token(checkToken=true)
	public JSONObject uploadStatement(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONObject resJson = new JSONObject();
		resJson.put("resCode", 0);
		resJson.put("resMsg", "success");
		
		// 报表类型
		String statementType = request.getParameter("statementType");
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;
		MultipartFile multipartFile = multipartRequest.getFile("uploadFile");
		// 文件流
		InputStream is = multipartFile.getInputStream();
		// 解析报表
		try {
			//statementManagerService.readExcel(is, statementType);
		} catch (Exception e) {
			resJson.put("resCode", -1);
			resJson.put("resMsg", "excel解析错误：请确认excel文件是否正确。");
		}
		
		return resJson;
	}
	
	/**
	 * @Description 报表业务日期查询
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/queryStatementBizDate.qyzx")
	public JSONObject queryStatementBizDate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONObject resJson = new JSONObject();
		resJson.put("resCode", 0);
		resJson.put("resMsg", "success");
		
		Map<String,Object> params = new HashMap<String, Object>();
		// 报表类型
		String statementType = request.getParameter("statementType");
//		if ("1".equals(statementType)) {
//			resJson.put("resData", statementManagerService.queryOrgInfoBizDate(params));
//		} else if ("2".equals(statementType)) {
//			resJson.put("resData", statementManagerService.queryOrgCollectBizDate(params));
//		} else if ("3".equals(statementType)) {
//			resJson.put("resData", statementManagerService.queryOrgProviderBizDate(params));
//		} else if ("4".equals(statementType)) {
//			resJson.put("resData", statementManagerService.queryOrgUserBizDate(params));
//		} else if ("5".equals(statementType)) {
//			resJson.put("resData", statementManagerService.queryUsedInfoBizDate(params));
//		} else if ("6".equals(statementType)) {
//			resJson.put("resData", statementManagerService.queryObjInfoBizDate(params));
//		} else if ("7".equals(statementType)) {
//			resJson.put("resData", statementManagerService.querySecurityInfoBizDate(params));
//		} else if ("8".equals(statementType)) {
//			resJson.put("resData", statementManagerService.querySmeRuralInfoBizDate(params));
//		}
		
		return resJson;
	}
	
	/**
	 * @Description 查询报表
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/queryStatement.qyzx")
	@ResponseBody
	public JSONObject queryStatement(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONObject resJson = new JSONObject();
		resJson.put("resCode", 0);
		resJson.put("resMsg", "success");

		List<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("bizDate", request.getParameter("bizDate"));
		
		// 报表类型
		String statementType = request.getParameter("statementType");
		params.put("statementType", statementType);
//		if ("1".equals(statementType)) {
//			resultList = statementManagerService.queryStatementOrgInfo(params);
//		} else if ("2".equals(statementType)) {
//			resultList = statementManagerService.queryStatementOrgCollect(params);
//		} else if ("3".equals(statementType)) {
//			resultList = statementManagerService.queryStatementOrgProvider(params);
//		} else if ("4".equals(statementType)) {
//			resultList = statementManagerService.queryStatementOrgUser(params);
//		} else if ("5".equals(statementType)) {
//			resultList = statementManagerService.queryStatementUsedInfo(params);
//		} else if ("6".equals(statementType)) {
//			resultList = statementManagerService.queryStatementObjInfo(params);
//		} else if ("7".equals(statementType)) {
//			resultList = statementManagerService.queryStatementSecurityInfo(params);
//		} else if ("8".equals(statementType)) {
//			resultList = statementManagerService.queryStatementSmeRuralInfo(params);
//		}
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("statementList", resultList);
		resJson.put("resData", map); 
		return resJson;
	}
	
	/**
	 * @Description 报表下载
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/exportExcel.qyzx")
	@ResponseBody
	public JSONObject exportExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONObject resJson = new JSONObject();
		resJson.put("resCode", 0);
		resJson.put("resMsg", "success");
		
		String statementType = request.getParameter("statementType");
		String bizDate = request.getParameter("bizDate");
		String fileName = "";
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("bizDate", bizDate);
		if ("1".equals(statementType)) {
			fileName = "企业征信机构基本情况统计表.xls";
		} else if ("2".equals(statementType)) {
			fileName = "企业征信机构信息采集情况表.xls";
		} else if ("3".equals(statementType)) {
			fileName = "企业征信机构信息提供者统计表.xls";
		} else if ("4".equals(statementType)) {
			fileName = "企业征信机构信息使用者统计表.xls";
		} else if ("5".equals(statementType)) {
			fileName = "企业征信机构征信信息使用情况表.xls";
		} else if ("6".equals(statementType)) {
			fileName = "企业征信机构异议及投诉处理情况表.xls";
		} else if ("7".equals(statementType)) {
			fileName = "企业征信机构信息安全事件统计表.xls";
		} else if ("8".equals(statementType)) {
			fileName = "企业征信机构支持中小微企业、三农情况统计表.xls";
		} else if ("all".equals(statementType)) {
			fileName = "企业征信机构统计表.xls";
		}
		String exampleFile = fileName.substring(0,fileName.lastIndexOf("."))+"_example.xls";
		if (!copyFile(coresBase.getExcelFilePath(), exampleFile, fileName)) {
			logger.error("模板文件不存在");
			throw new Exception("模板文件不存在");
		}
		fillExcelData(fileName, statementType, bizDate);
		
		// 设置response参数，可以打开下载页面
        response.reset();
        response.setContentType("application/vnd.ms-excel;charset=utf-8");
		bizDate = bizDate.replaceAll("\\(", "");
		bizDate = bizDate.replaceAll("\\)", "");
		bizDate = bizDate.replaceAll("\\（", "");
		bizDate = bizDate.replaceAll("\\）", "");
		// 文件名字做特殊处理
		String outFileName = fileName.substring(0,fileName.lastIndexOf("."));
		
        response.setHeader("Content-disposition", "attachment;filename="+new String((outFileName+"_"+bizDate+".xls").getBytes("UTF-8"),"iso-8859-1"));
        ServletOutputStream out = response.getOutputStream();
        BufferedInputStream bis = null;
        BufferedOutputStream bos = null;
        InputStream is = new FileInputStream(new File(coresBase.getExcelFilePath()+fileName));
        try {
            bis = new BufferedInputStream(is);
            bos = new BufferedOutputStream(out);
            byte[] buff = new byte[2048];
            int bytesRead;
            // Simple read/write loop.
            while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
                bos.write(buff, 0, bytesRead);
            }
        } catch (IOException e) {
            throw e;
        } finally {
            if (bis != null)
                bis.close();
            if (bos != null)
                bos.close();
        }
		
		return resJson;
		
	}
	
	/**
	 * @Description 下载一个汇总的报表
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/exportExcelAll.qyzx")
	@ResponseBody
	public JSONObject exportExcelAll(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String bizDate = request.getParameter("bizDate");
		
		String fileName = "企业征信机构统计表.xls";
		String exampleFile = fileName.substring(0,fileName.lastIndexOf("."))+"_example.xls";
		if (!copyFile(coresBase.getExcelFilePath(), exampleFile, fileName)) {
			logger.error("模板文件不存在");
			throw new Exception("模板文件不存在！！！");
		}
		for (int i = 1; i < 9; i++) {
			if (i == 1) {// 换算成季度
				String year = bizDate.substring(0,bizDate.indexOf("年"));
				String month = bizDate.substring(bizDate.indexOf("年")+1,bizDate.indexOf("月"));
				//确定季度
				int j = (int) Math.ceil(Double.parseDouble(month) / 3);
				bizDate = year + "年" + "第" + j + "季度";
			} else {
				bizDate = request.getParameter("bizDate");
			}
			fillExcelData(fileName, String.valueOf(i), bizDate);
		}
		
		// 设置response参数，可以打开下载页面
        response.reset();
        response.setContentType("application/vnd.ms-excel;charset=utf-8");
		bizDate = bizDate.replaceAll("\\(", "");
		bizDate = bizDate.replaceAll("\\)", "");
		bizDate = bizDate.replaceAll("\\（", "");
		bizDate = bizDate.replaceAll("\\）", "");
		// 文件名字做特殊处理
		String outFileName = fileName.substring(0,fileName.lastIndexOf("."));
		
        response.setHeader("Content-disposition", "attachment;filename="+new String((outFileName+"_"+bizDate+".xls").getBytes("UTF-8"),"iso-8859-1"));
        ServletOutputStream out = response.getOutputStream();
        BufferedInputStream bis = null;
        BufferedOutputStream bos = null;
        InputStream is = new FileInputStream(new File(coresBase.getExcelFilePath()+fileName));
        try {
            bis = new BufferedInputStream(is);
            bos = new BufferedOutputStream(out);
            byte[] buff = new byte[2048];
            int bytesRead;
            // Simple read/write loop.
            while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
                bos.write(buff, 0, bytesRead);
            }
        } catch (IOException e) {
            throw e;
        } finally {
            if (bis != null)
                bis.close();
            if (bos != null)
                bos.close();
        }
        return null;
	}
	
	/**
	 * @Description excel数据填充
	 * @param reportType
	 * @param bizDate
	 * @return
	 * @throws Exception
	 */
	private void fillExcelData(String fileName,String reportType,String bizDate) throws Exception{
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("bizDate", bizDate);
		String sheetName = "";
		List<Map<String,Object>> dataList = new ArrayList<Map<String,Object>>();
//		if ("1".equals(reportType)) {
//			sheetName = "企业征信机构基本情况统计表";
//			dataList = statementManagerService.queryStatementOrgInfo(params);
//			if (dataList != null && dataList.size() > 0) {
//				fillOrgInfoData(fileName,sheetName,dataList);
//			}
//		} else if ("2".equals(reportType)) {
//			sheetName = "企业征信机构信息采集情况表";
//			dataList = statementManagerService.queryStatementOrgCollect(params);
//			if (dataList != null && dataList.size() > 0) {
//				fillOrgCollectData(fileName,sheetName,dataList);
//			}
//		} else if ("3".equals(reportType)) {
//			sheetName = "企业征信机构信息提供者统计表";
//			dataList = statementManagerService.queryStatementOrgProvider(params);
//			if (dataList != null && dataList.size() > 0) {
//				fillOrgProviderData(fileName,sheetName,dataList);
//			}
//		} else if ("4".equals(reportType)) {
//			sheetName = "企业征信机构信息使用者统计表";
//			dataList = statementManagerService.queryStatementOrgUser(params);
//			if (dataList != null && dataList.size() > 0) {
//				fillOrgUserData(fileName,sheetName,dataList);
//			}
//		} else if ("5".equals(reportType)) {
//			sheetName = "企业征信机构征信信息使用情况表";
//			dataList = statementManagerService.queryStatementUsedInfo(params);
//			if (dataList != null && dataList.size() > 0) {
//				fillUsedInfoData(fileName,sheetName,dataList);
//			}
//		} else if ("6".equals(reportType)) {
//			sheetName = "企业征信机构异议及投诉处理情况表";
//			dataList = statementManagerService.queryStatementObjInfo(params);
//			if (dataList != null && dataList.size() > 0) {
//				fillObjInfoData(fileName,sheetName,dataList);
//			}
//		} else if ("7".equals(reportType)) {
//			sheetName = "企业征信机构信息安全事件统计表";
//			dataList = statementManagerService.queryStatementSecurityInfo(params);
//			if (dataList != null && dataList.size() > 0) {
//				fillSecurityInfoData(fileName,sheetName,dataList);
//			}
//		} else if ("8".equals(reportType)) {
//			sheetName = "企业征信机构支持中小微企业、三农情况统计表";
//			dataList = statementManagerService.queryStatementSmeRuralInfo(params);
//			if (dataList != null && dataList.size() > 0) {
//				fillSmeRuralInfoData(fileName,sheetName,dataList);
//			}
//		}
	}

	/**
	 * @Description 企业征信机构基本情况统计表
	 * @param fileName
	 * @param dataList
	 */
	private void fillOrgInfoData(String fileName,String sheetName, List<Map<String, Object>> dataList) throws Exception{
		HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(new File(coresBase.getExcelFilePath()+fileName)));
		HSSFSheet sheet = wb.getSheet(sheetName);
		HSSFRow row = sheet.getRow(3)==null?sheet.createRow(3):sheet.getRow(3);
		HSSFCell cell = row.getCell(0)==null?row.createCell(0):row.getCell(0);
		cell.setCellValue((String)dataList.get(0).get("BIZDATE"));
		for (int i = 6; i < 13; i++) {
			if (dataList.size() <= i - 6) {
				logger.error("企业征信机构基本情况统计表数据有误");
				break;
			}
			row = sheet.getRow(i);
			// 机构总量
			cell = row.getCell(2);
			cell.setCellValue((String)dataList.get(i-6).get("ORGTOTAL"));
			// 个人征信业务
			cell = row.getCell(3);
			cell.setCellValue((String)dataList.get(i-6).get("PERSONTOTAL"));
			// 企业征信业务
			cell = row.getCell(4);
			cell.setCellValue((String)dataList.get(i-6).get("ENTERTOTAL"));
			// 其他
			cell = row.getCell(5);
			cell.setCellValue((String)dataList.get(i-6).get("OTHERTOTAL"));
		}
		
		// 填表人
		row = sheet.getRow(13);
		cell = row.getCell(1);
		cell.setCellValue((String)dataList.get(0).get("BIZPERSON"));
		
		// 复核人
		cell = row.getCell(4);
		cell.setCellValue((String)dataList.get(0).get("RECHECKPERSON"));
		
		// 填表机构
		row = sheet.getRow(14);
		cell = row.getCell(1);
		cell.setCellValue((String)dataList.get(0).get("BIZORG"));
		
		// 填表日期
		cell = row.getCell(4);
		cell.setCellValue((String)dataList.get(0).get("FILLDATE"));
		
		FileOutputStream out = null;
        out = new FileOutputStream(coresBase.getExcelFilePath()+fileName);
        wb.write(out);
		if (out != null) {
			out.close();
		}
	}
	

	/**
	 * @Description 企业征信机构信息采集情况表
	 * @param fileName
	 * @param sheetName
	 * @param dataList
	 * @throws Exception
	 */
	private void fillOrgCollectData(String fileName, String sheetName,List<Map<String, Object>> dataList) throws Exception{
		
		HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(new File(coresBase.getExcelFilePath()+fileName)));
		HSSFSheet sheet = wb.getSheet(sheetName);
		HSSFRow row = sheet.getRow(2)==null?sheet.createRow(2):sheet.getRow(2);
		HSSFCell cell = row.getCell(0)==null?row.createCell(0):row.getCell(0);
		cell.setCellValue((String)dataList.get(0).get("BIZDATE"));
		int j = 0;
		for (int i = 5; i < 13; i++) {
			j = j + 1;
			//第七条数据过滤
			if (i == 6){
				j = j - 1;
				continue;
			}
			
			if (i == 12) {
				j = 0;
        	}
			if (dataList.size() <= j) {
				logger.error("企业征信机构信息采集情况表数据有误");
				break;
			}
			row = sheet.getRow(i);
			// 当月新增
			cell = row.getCell(2)==null?row.createCell(2):row.getCell(2);
			cell.setCellValue((String)dataList.get(j).get("MONTHADD"));
			// 当年累计
			cell = row.getCell(3)==null?row.createCell(3):row.getCell(3);
			cell.setCellValue((String)dataList.get(j).get("YEARTOTAL"));
			// 总累计
			cell = row.getCell(4)==null?row.createCell(4):row.getCell(4);
			cell.setCellValue((String)dataList.get(j).get("ALLTOTAL"));
		}
		
		// 填表人
		row = sheet.getRow(13);
		cell = row.getCell(1);
		cell.setCellValue((String)dataList.get(0).get("BIZPERSON"));
		
		// 复核人
		cell = row.getCell(3);
		cell.setCellValue((String)dataList.get(0).get("RECHECKPERSON"));
		
		// 填表机构
		row = sheet.getRow(14);
		cell = row.getCell(1);
		cell.setCellValue((String)dataList.get(0).get("BIZORG"));
		
		// 填表日期
		cell = row.getCell(3);
		cell.setCellValue((String)dataList.get(0).get("FILLDATE"));
		
		FileOutputStream out = null;
        out = new FileOutputStream(coresBase.getExcelFilePath()+fileName);
        wb.write(out);
		if (out != null) {
			out.close();
		}
	}
	
	/**
	 * @Description 企业征信机构信息提供者统计表
	 * @param fileName
	 * @param sheetName
	 * @param dataList
	 * @throws Exception
	 */
	private void fillOrgProviderData(String fileName, String sheetName,List<Map<String, Object>> dataList) throws Exception{
		
		HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(new File(coresBase.getExcelFilePath()+fileName)));
		HSSFSheet sheet = wb.getSheet(sheetName);
		HSSFRow row = sheet.getRow(2)==null?sheet.createRow(2):sheet.getRow(2);
		HSSFCell cell = row.getCell(0)==null?row.createCell(0):row.getCell(0);
		cell.setCellValue((String)dataList.get(0).get("BIZDATE"));
		for (int i = 6; i < 11; i++) {
			int j = 0;
			
			if (i < 10) {
				j = i - 5;
			}
			if (dataList.size() <= j) {
				logger.error("企业征信机构信息提供者统计表数据有误");
				break;
			}
			row = sheet.getRow(i);
			// 当月新增
			cell = row.getCell(1);
			cell.setCellValue((String)dataList.get(j).get("MONTHADD"));
			// 当年累计
			cell = row.getCell(2);
			cell.setCellValue((String)dataList.get(j).get("YEARTOTAL"));
			// 总累计
			cell = row.getCell(3);
			cell.setCellValue((String)dataList.get(j).get("ALLTOTAL"));
		}
		
		// 填表人
		row = sheet.getRow(11);
		cell = row.getCell(1);
		cell.setCellValue((String)dataList.get(0).get("BIZPERSON"));
		
		// 复核人
		cell = row.getCell(3);
		cell.setCellValue((String)dataList.get(0).get("RECHECKPERSON"));
		
		// 填表机构
		row = sheet.getRow(12);
		cell = row.getCell(1);
		cell.setCellValue((String)dataList.get(0).get("BIZORG"));
		
		// 填表日期
		cell = row.getCell(3);
		cell.setCellValue((String)dataList.get(0).get("FILLDATE"));
		
		FileOutputStream out = null;
		out = new FileOutputStream(coresBase.getExcelFilePath()+fileName);
		wb.write(out);
		if (out != null) {
			out.close();
		}
	}
	
	/**
	 * @Description 企业征信机构信息使用者统计表
	 * @param fileName
	 * @param sheetName
	 * @param dataList
	 * @throws Exception
	 */
	private void fillOrgUserData(String fileName, String sheetName,List<Map<String, Object>> dataList) throws Exception{
		
		HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(new File(coresBase.getExcelFilePath()+fileName)));
		HSSFSheet sheet = wb.getSheet(sheetName);
		HSSFRow row = sheet.getRow(2)==null?sheet.createRow(2):sheet.getRow(2);
		HSSFCell cell = row.getCell(0)==null?row.createCell(0):row.getCell(0);
		cell.setCellValue((String)dataList.get(0).get("BIZDATE"));
		for (int i = 6; i < 11; i++) {
			int j = 0;
			
			if (i < 10) {
				j = i - 5;
			}
			if (dataList.size() <= j) {
				logger.error("企业征信机构信息使用者统计表数据有误");
				break;
			}
			row = sheet.getRow(i);
			// 当月新增
			cell = row.getCell(1);
			cell.setCellValue((String)dataList.get(j).get("USERORGMONTHADD"));
			// 当年累计
			cell = row.getCell(2);
			cell.setCellValue((String)dataList.get(j).get("USERORGYEARTOTAL"));
			// 总累计
			cell = row.getCell(3);
			cell.setCellValue((String)dataList.get(j).get("UserOrgAllTotal"));
			// 当月新增
			cell = row.getCell(4);
			cell.setCellValue((String)dataList.get(j).get("ACCOUNTMONTHADD"));
			// 当年累计
			cell = row.getCell(5);
			cell.setCellValue((String)dataList.get(j).get("ACCOUNTYEARTOTAL"));
			// 总累计
			cell = row.getCell(6);
			cell.setCellValue((String)dataList.get(j).get("ACCOUNTALLTOTAL"));
		}
		
		// 填表人
		row = sheet.getRow(11);
		cell = row.getCell(1);
		cell.setCellValue((String)dataList.get(0).get("BIZPERSON"));
		
		// 复核人
		cell = row.getCell(5);
		cell.setCellValue((String)dataList.get(0).get("RECHECKPERSON"));
		
		// 填表机构
		row = sheet.getRow(12);
		cell = row.getCell(1);
		cell.setCellValue((String)dataList.get(0).get("BIZORG"));
		
		// 填表日期
		cell = row.getCell(5);
		cell.setCellValue((String)dataList.get(0).get("FILLDATE"));
		
		FileOutputStream out = null;
		out = new FileOutputStream(coresBase.getExcelFilePath()+fileName);
		wb.write(out);
		if (out != null) {
			out.close();
		}
	}
	
	/**
	 * @Description 企业征信机构信息使用信息表
	 * @param fileName
	 * @param sheetName
	 * @param dataList
	 * @throws Exception
	 */
	private void fillUsedInfoData(String fileName, String sheetName,List<Map<String, Object>> dataList) throws Exception{
		
		HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(new File(coresBase.getExcelFilePath()+fileName)));
		HSSFSheet sheet = wb.getSheet(sheetName);
		HSSFRow row = sheet.getRow(2)==null?sheet.createRow(2):sheet.getRow(2);
		HSSFCell cell = row.getCell(0)==null?row.createCell(0):row.getCell(0);
		cell.setCellValue((String)dataList.get(0).get("BIZDATE"));
		for (int i = 6; i < 12; i++) {
			int j = 0;
			
			if (i < 11) {
				j = 3*(i - 5);
			}
			if (dataList.size() <= j) {
				logger.error("企业征信机构信息使用信息表数据有误");
				break;
			}
			row = sheet.getRow(i);
			// 当月新增
			cell = row.getCell(1);
			cell.setCellValue((String)dataList.get(j).get("INCREASEMONTH"));
			// 当年累计
			cell = row.getCell(2);
			cell.setCellValue((String)dataList.get(j).get("TOTALCURYEAR"));
			// 总累计
			cell = row.getCell(3);
			cell.setCellValue((String)dataList.get(j).get("TOTAL"));
			// 当月新增
			cell = row.getCell(4);
			cell.setCellValue((String)dataList.get(j+1).get("INCREASEMONTH"));
			// 当年累计
			cell = row.getCell(5);
			cell.setCellValue((String)dataList.get(j+1).get("TOTALCURYEAR"));
			// 总累计
			cell = row.getCell(6);
			cell.setCellValue((String)dataList.get(j+1).get("TOTAL"));
			// 当月新增
			cell = row.getCell(7);
			cell.setCellValue((String)dataList.get(j+2).get("INCREASEMONTH"));
			// 当年累计
			cell = row.getCell(8);
			cell.setCellValue((String)dataList.get(j+2).get("TOTALCURYEAR"));
			// 总累计
			cell = row.getCell(9);
			cell.setCellValue((String)dataList.get(j+2).get("TOTAL"));
		}
		
		// 填表人
		row = sheet.getRow(12);
		cell = row.getCell(1);
		cell.setCellValue((String)dataList.get(0).get("BIZPERSON"));
		
		// 复核人
		cell = row.getCell(7);
		cell.setCellValue((String)dataList.get(0).get("RECHECKPERSON"));
		
		// 填表机构
		row = sheet.getRow(13);
		cell = row.getCell(1);
		cell.setCellValue((String)dataList.get(0).get("BIZORG"));
		
		// 填表日期
		cell = row.getCell(7);
		cell.setCellValue((String)dataList.get(0).get("FILLDATE"));
		
		FileOutputStream out = null;
		out = new FileOutputStream(coresBase.getExcelFilePath()+fileName);
		wb.write(out);
		if (out != null) {
			out.close();
		}
	}
	
	/**
	 * @Description 企业征信机构异议及投诉处理表
	 * @param fileName
	 * @param sheetName
	 * @param dataList
	 * @throws Exception
	 */
	private void fillObjInfoData(String fileName, String sheetName,List<Map<String, Object>> dataList) throws Exception{
		
		HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(new File(coresBase.getExcelFilePath()+fileName)));
		HSSFSheet sheet = wb.getSheet(sheetName);
		HSSFRow row = sheet.getRow(2)==null?sheet.createRow(2):sheet.getRow(2);
		HSSFCell cell = row.getCell(0)==null?row.createCell(0):row.getCell(0);
		cell.setCellValue((String)dataList.get(0).get("BIZDATE"));
		for (int i = 5; i < 10; i++) {
			int j = i - 5;
			if (dataList.size() <= j) {
				logger.error("企业征信机构异议及投诉处理表数据有误");
				break;
			}
			row = sheet.getRow(i);
			// 当月新增
			cell = row.getCell(2);
			cell.setCellValue((String)dataList.get(j).get("INCREASEMONTH"));
			// 当年累计
			cell = row.getCell(3);
			cell.setCellValue((String)dataList.get(j).get("TOTALCURYEAR"));
			// 总累计
			cell = row.getCell(4);
			cell.setCellValue((String)dataList.get(j).get("TOTAL"));
		}
		
		// 填表人
		row = sheet.getRow(10);
		cell = row.getCell(1);
		cell.setCellValue((String)dataList.get(0).get("BIZPERSON"));
		
		// 复核人
		cell = row.getCell(3);
		cell.setCellValue((String)dataList.get(0).get("RECHECKPERSON"));
		
		// 填表机构
		row = sheet.getRow(11);
		cell = row.getCell(1);
		cell.setCellValue((String)dataList.get(0).get("BIZORG"));
		
		// 填表日期
		cell = row.getCell(3);
		cell.setCellValue((String)dataList.get(0).get("FILLDATE"));
		
		FileOutputStream out = null;
		out = new FileOutputStream(coresBase.getExcelFilePath()+fileName);
		wb.write(out);
		if (out != null) {
			out.close();
		}
	}
	
	/**
	 * @Description 企业征信机构信息安全事件统计表
	 * @param fileName
	 * @param sheetName
	 * @param dataList
	 * @throws Exception
	 */
	private void fillSecurityInfoData(String fileName, String sheetName,List<Map<String, Object>> dataList) throws Exception{
		
		HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(new File(coresBase.getExcelFilePath()+fileName)));
		HSSFSheet sheet = wb.getSheet(sheetName);
		HSSFRow row = sheet.getRow(1)==null?sheet.createRow(1):sheet.getRow(1);
		HSSFCell cell = row.getCell(0)==null?row.createCell(0):row.getCell(0);
		cell.setCellValue((String)dataList.get(0).get("BIZDATE"));
		for (int i = 4; i < 12; i++) {
			int j = i - 3;
			if (i == 11) {
				j = 0;
			}
			if (dataList.size() <= j) {
				logger.error("企业征信机构信息安全事件统计表数据有误");
				break;
			}
			row = sheet.getRow(i);
			// 本月发生次数
			cell = row.getCell(2);
			cell.setCellValue((String)dataList.get(j).get("FREQUENCYMONTH"));
			// 本年累计发生次数
			cell = row.getCell(3);
			cell.setCellValue((String)dataList.get(j).get("FREQUENCYYEAR"));
			// 总累计发生次数
			cell = row.getCell(4);
			cell.setCellValue((String)dataList.get(j).get("FREQUENCYTOTAL"));
		}
		
		// 填表人
		row = sheet.getRow(12);
		cell = row.getCell(1);
		cell.setCellValue((String)dataList.get(0).get("BIZPERSON"));
		
		// 复核人
		cell = row.getCell(3);
		cell.setCellValue((String)dataList.get(0).get("RECHECKPERSON"));
		
		// 填表机构
		row = sheet.getRow(13);
		cell = row.getCell(1);
		cell.setCellValue((String)dataList.get(0).get("BIZORG"));
		
		// 填表日期
		cell = row.getCell(3);
		cell.setCellValue((String)dataList.get(0).get("FILLDATE"));
		
		FileOutputStream out = null;
		out = new FileOutputStream(coresBase.getExcelFilePath()+fileName);
		wb.write(out);
		if (out != null) {
			out.close();
		}
	}
	
	/**
	 * @Description 企业征信机构支持中小微企业、三农情况统计表
	 * @param fileName
	 * @param sheetName
	 * @param dataList
	 * @throws Exception
	 */
	private void fillSmeRuralInfoData(String fileName, String sheetName,List<Map<String, Object>> dataList) throws Exception{
		
		HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(new File(coresBase.getExcelFilePath()+fileName)));
		HSSFSheet sheet = wb.getSheet(sheetName);
		HSSFRow row = sheet.getRow(3)==null?sheet.createRow(3):sheet.getRow(3);
		HSSFCell cell = row.getCell(0)==null?row.createCell(0):row.getCell(0);
		cell.setCellValue((String)dataList.get(0).get("BIZDATE"));
		for (int i = 6; i < 16; i++) {
			int j = i-6;
			if (dataList.size() <= j) {
				logger.error("企业征信机构支持中小微企业、三农情况统计表数据有误");
				break;
			}
			row = sheet.getRow(i);
			// 当月新增
			cell = row.getCell(3);
			cell.setCellValue((String)dataList.get(j).get("INCREASEMONTH"));
			// 当年累计
			cell = row.getCell(4);
			cell.setCellValue((String)dataList.get(j).get("TOTALCURYEAR"));
			// 总累计
			cell = row.getCell(5);
			cell.setCellValue((String)dataList.get(j).get("TOTAL"));
		}
		
		// 填表人
		row = sheet.getRow(16);
		cell = row.getCell(1);
		cell.setCellValue((String)dataList.get(0).get("BIZPERSON"));
		
		// 复核人
		cell = row.getCell(3);
		cell.setCellValue((String)dataList.get(0).get("RECHECKPERSON"));
		
		// 填表机构
		row = sheet.getRow(17);
		cell = row.getCell(1);
		cell.setCellValue((String)dataList.get(0).get("BIZORG"));
		
		// 填表日期
		cell = row.getCell(3);
		cell.setCellValue((String)dataList.get(0).get("FILLDATE"));
		
		FileOutputStream out = null;
		out = new FileOutputStream(coresBase.getExcelFilePath()+fileName);
		wb.write(out);
		if (out != null) {
			out.close();
		}
	}
	
	
    /**
     * @Description copy文件
     * @param srcFileName
     * @param destFileName
     * @return
     */
    public static boolean copyFile(String path,String srcFileName, String targetFileName) {  
        File srcFile = new File(path+srcFileName);  
  
        // 判断源文件是否存在  
        if (!srcFile.exists()) {  
            return false;  
        } else if (!srcFile.isFile()) {  
            return false;
        }  
  
        // 判断目标文件是否存在  
        File destFile = new File(path+targetFileName);  
        if (destFile.exists()) {  
            // 删除已经存在的目标文件
            new File(targetFileName).delete();  
        }
  
        // 复制文件  
        int byteread = 0; // 读取的字节数  
        InputStream in = null;  
        OutputStream out = null;  
  
        try {  
            in = new FileInputStream(srcFile);  
            out = new FileOutputStream(destFile);  
            byte[] buffer = new byte[1024];  
  
            while ((byteread = in.read(buffer)) != -1) {  
                out.write(buffer, 0, byteread);  
            }  
            return true;  
        } catch (FileNotFoundException e) {  
            return false;  
        } catch (IOException e) {  
            return false;  
        } finally {  
            try {  
                if (out != null)  
                    out.close();  
                if (in != null)  
                    in.close();  
            } catch (IOException e) {  
                e.printStackTrace();  
            }  
        }  
    }  
	
}

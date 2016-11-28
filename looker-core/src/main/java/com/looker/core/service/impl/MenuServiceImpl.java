package com.looker.core.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.looker.core.model.SysUser;
import com.looker.core.service.MenuService;
import com.niwodai.tech.base.dao.IBaseDao;

@Service("menuService")
public class MenuServiceImpl implements MenuService {
	
	@Resource
	IBaseDao<Map<String,Object>> iBaseDao;
	
	public boolean isAdmin(SysUser sysUser){
		return "admin".equals(sysUser.getUserAccount());
	}

	@Override
	public List<Map<String, Object>> getAllMenus() {
		return iBaseDao.findByQuery("SysMenu.get_all_menu");
	}

	@Override
	public List<Map<String, Object>> getMenus(Map<String, Object> params) {
		return iBaseDao.findByQuery("SysMenu.get_menu",params);
	}
	
	@Override
	public List<Map<String, Object>> getUserMenus(Map<String, Object> params) {
		return iBaseDao.findByQuery("SysMenu.get_user_menu",params);
	}
	
	public String listEleToString(List<String> list){
		StringBuffer sb = new StringBuffer();
		for(String str:list){
			sb.append(str);
		}
		return sb.toString();
	}
	
	@Override
	public String getRightConfig_html(List<Map<String,Object>> menuList,List<Map<String,Object>> roleMenuList){
		// TODO 需要和前端沟通统一后才可以优化
		/*boolean firstFlg = true;
		StringBuffer sb = new StringBuffer();
		sb.append("<ul class='yijiyiji'>");
		int curLevel =1;
		for (Map<String, Object> temp : list) {
			int level = Integer.parseInt((String)temp.get("MENU_LEVEL"));
			if (level == curLevel) {
				if (firstFlg) {
					firstFlg = false;
				} else {
					sb.append("</li>");
				}
			} else if (level > curLevel) {
				sb.append("<ul style='display: none'>");
				curLevel=level;
			} else if (level < curLevel) {
				for (int i = level; i < curLevel; i++) {
					sb.append("</li>");
					sb.append("</ul>");
				}
				curLevel=level;
			}
			String str = "style='padding-left:25px;'";
			String menuType = (String)temp.get("MENU_TYPE");
			String menuName = (String) temp.get("MENU_NAME");
			sb.append("<li>");
			if ("1".equals(menuType)) { // 是操作
				sb.append("<input type = 'checkbox' name='menuIds' value='"+temp.get("MENU_ID")+"' style='margin-left:5px;'/>");
			} else if ("0".equals(menuType)) { // 是菜单
				str ="class='inactivess'";
			}
			sb.append("<a href='#'"+str+">"+menuName+"</a>");
		}
		if (curLevel > 1) {
			for (int i = 1; i < curLevel; i++) {
				sb.append("</li>");
				sb.append("</ul>");
			}
			sb.append("</li>");
		}
		sb.append("</ul>");
		return sb.toString();*/
		StringBuffer sb = new StringBuffer();
		boolean firstFlg = true;
		sb.append("<ul class='yijiyiji'>");
		int curLevel =1;
		for (Map<String, Object> temp : menuList) {
			int level = Integer.parseInt((String)temp.get("MENU_LEVEL"));
			if (level == curLevel) {
				if (firstFlg) {
					firstFlg = false;
				} else {
					sb.append("</li>");
				}
			} else if (level > curLevel) {
				if (level == 2) {
					sb.append("<ul style='display: none'>");
				}
				curLevel = level;
			} else if (level < curLevel) {
				for (int i = level; i < curLevel; i++) {
					sb.append("</li>");
					sb.append("</ul>");
				}
				curLevel=level;
			}
			String menuType = (String)temp.get("MENU_TYPE");
			String menuName = (String) temp.get("MENU_NAME");
			if (level == 1) {
				sb.append("<li>");
				Object menuId = temp.get("MENU_ID");
				if ("1".equals(menuType)) { // 是操作
					String checked = "";
					if(listContainsEle(roleMenuList, menuId, "MENU_ID")){
						checked=" checked='checked'";
					}
					sb.append("<input type = 'checkbox' name='menuId' value='"+menuId+"'"+checked+" style='margin-left:5px;'/>");
					sb.append("<a href='#'  style='padding-left:25px;'>"+menuName+"</a>");
				} else if ("0".equals(menuType)) { // 是菜单
					sb.append("<input type = 'checkbox' name='selectAll' value='"+menuId+"' style='margin-left:5px;'/>");
					sb.append("<a href='#' class='inactivess'>"+menuName+"</a>");
				}
			} else if (level == 2) {
				String checked = "";
				Object menuId = temp.get("MENU_ID");
				if(listContainsEle(roleMenuList, menuId, "MENU_ID")){
					checked=" checked='checked'";
				}
				sb.append("<li class='last'><a href='#'><input type='checkbox' name='menuId' value='"+menuId+"'"+checked+" style='margin-right:5px;' >"+menuName+"</a>");
			}
		}
		if (curLevel > 1) {
			for (int i = 1; i < curLevel; i++) {
				sb.append("</li>");
				sb.append("</ul>");
			}
			sb.append("</li>");
		}
		sb.append("</ul>");
		return sb.toString();
		
	}
	
	public boolean listContainsEle(List<Map<String,Object>> list,Object obj,String key){
		for (Map<String, Object> temp : list) {
			if (obj.equals(temp.get(key))) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 拼接菜单，目前只有2级的
	 */
	@Override
	public List<Map<String, Object>> getMenuList(String userId) {
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		
		//获取菜单列表数据
		List<Map<String, Object>> userMenusList = getUserMenus(params);
		
		List<Map<String, Object>> menuList = new ArrayList<Map<String,Object>>();
		
		if(userMenusList != null && userMenusList.size() > 0){
			
			for(Map<String, Object> temp : userMenusList){
				boolean addFlag = false;
				//获取菜单父节点
				Long menuId = (Long) temp.get("MENU_ID");
				int menuLevel = Integer.parseInt((String)temp.get("MENU_LEVEL"));
				//父菜单map
				Map<String, Object> menu = new HashMap<String, Object>();
				List<Map<String, Object>> childList = new ArrayList<Map<String,Object>>();
				
				//一级菜单
				if (menuLevel == 1) {
					menu.put("name", temp.get("MENU_NAME"));
					menu.put("icon", temp.get("MENU_ICON"));
				}
				
				for(Map<String, Object> temp1 : userMenusList){
					
					int menuType1 = Integer.parseInt((String)temp1.get("MENU_TYPE"));
					
					//菜单Id
					Long parentId  = (Long) temp1.get("PARENT_ID");
					
					Map<String, Object> child = new HashMap<String, Object>();
					
					if(parentId == menuId){
						//为0表示其下有子菜单
						if(menuType1 != 0){
							//子菜单map
							child.put("className", (String)temp1.get("MENU_URL"));
							child.put("childName", (String)temp1.get("MENU_NAME"));
							childList.add(child);
						}
						menu.put("child", childList);
						addFlag = true;
					}
				}
				if(addFlag){
					menuList.add(menu);
				}
			}
			
		}else{
			return null;
		}
		
		return menuList;
	}
}

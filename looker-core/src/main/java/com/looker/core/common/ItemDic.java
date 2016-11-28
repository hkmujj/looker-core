package com.looker.core.common;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class ItemDic {

	static Log logger = LogFactory.getLog(ItemDic.class);

	/**邮件发送**/
	public static enum MailType{
		/**机构模块*/
		JG01("新建机构", "JG01"),
		JG02("机构密码重置", "JG02"),
		JG03("机构启用", "JG03"),
		JG04("机构停用", "JG04"),
		
		/**渠道模块*/
		QD01("新建渠道", "QD01"),
		QD02("渠道启用", "QD02"),
		QD03("渠道停用", "QD03"),
		
		/**用户授权模块*/
		YHSQ01("获取用户授权", "YHSQ01"),
		
		/**产品模块*/
		CP01("产品复核通过", "CP01"),
		CP02("产品复核未通过", "CP02"),
		CP03("产品启用", "CP03"),
		CP04("产品停用", "CP04"),
		
		/**产品授权模块*/
		CPSQ01("新建产品授权", "CPSQ01"),
		CPSQ02("修改产品授权", "CPSQ02"),
		CPSQ03("删除产品授权", "CPSQ03"),
		CPSQ04("产品授权复核通过", "CPSQ04"),
		CPSQ05("产品授权复核不通过", "CPSQ05"),
		CPSQ06("产品授权还剩一天", "CPSQ06"),
		CPSQ07("产品授权到期", "CPSQ07"),
		
		/**异议模块*/
		YY01("异议登记", "YY01"),
		YY02("异议核查", "YY02"),
		
		/**用户模块*/
		YH01("启用用户", "YH01"),
		YH02("停用用户", "YH02"),
		
		/**费用模块*/
		CZ01("充值成功", "CZ01"),
		CZ02("余额到达预警值", "CZ02"),
		CZ03("余额到达预警值50%", "CZ03"),
		CZ04("余额为零", "CZ04"),
		;
		
		public final String subject;
		public final String type;
		
		MailType(String subject, String type) {
			this.subject = subject;
			this.type = type;
		}
	}
}

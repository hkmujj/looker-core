define([], function () {
    var env = 'TEST',
        baseURL = '';


    switch(env){
        case 'TEST':
            baseURL = 'http://localhost:8080/looker-core/cores/';
            break;
    /*    case 'YFB':
            baseURL = 'http://pangu.jiayincredit.net/cores-war/cores/';
            break;
        case 'PRO':
            baseURL = 'http://pangu.jiayincredit.com/cores/';
            break;
        case 'HL':
            baseURL = 'http://10.15.91.180:10102/cores-war/cores/';
            break;
        case 'LFR':
            baseURL = 'http://10.15.90.176:8090/cores-war/cores/';
            break;*/
        default:
            baseURL = 'http://pangu.jiayincredit.com/';
    }
    //alert(baseURL);
    var apis = {
        //字典项查询接口
        DICCODES: baseURL + 'common/getDicCode.qyzx',
        DICCODES2: baseURL + 'common/getDicCode.qyzx',
        //机构列表查询接口
        ORGANIZITION: baseURL + 'organization/orgList.qyzx',
        //重置密码接口
        RESTPWD: baseURL + 'organization/orgResetPwd.qyzx',
        //机构详情和修改接口
        MODIFY: baseURL + 'organization/orgModify.qyzx',
        //机构新增和修改接口
        ORGSAVE: baseURL + 'organization/orgSave.qyzx',
        //渠道是否被使用接口
        CHANNELISUSED: baseURL + 'channel/isChannelInUse.qyzx',
        //获取机构代码接口
        GETORGCODE: baseURL + 'organization/getOrgCode.qyzx',
        //机构状态修改
        ORGSTATUSCHANGE: baseURL + 'organization/orgStatusChange.qyzx',
        //渠道查询
        CHANNEL_LIST: baseURL + 'channel/channelList.qyzx',
        //渠道详情
        CAHNNEL_LIST_DETAIL: baseURL + 'channel/channelDetail.qyzx',
        //获取渠道代码
        GETCHANNELCODE: baseURL + 'channel/getChannelCode.qyzx',
        //渠道信息保存接口
        CHANNEL_SAVE: baseURL + 'channel/channelSave.qyzx',
        //渠道状态修改
        CHANNELSTATUSCHANGE: baseURL + 'channel/channelStatusChange.qyzx',
        //机构是否启用接口
        ISORGOPEN: baseURL + 'organization/isOrgOpen.qyzx',
        //校验产品授权是否使用
        ISPRODUCTAUTHUSED: baseURL + 'channel/isProductAuthInUse.qyzx',
        //异议列表接口
        OBJECTION_LIST: baseURL + 'objection/objList.qyzx',
        //异议详情
        OBJECTION_DETAIL: baseURL + 'objection/showObjInfo.qyzx',
        //异议提交接口
        UPDATEOBJINFO: baseURL + 'objection/updateObjInfo.qyzx',
        //异议核查列表接口
        OBJECTIONCHECK_LIST: baseURL + 'objection/objAssistList.qyzx',
        //异议协查详情
        OBJECTCHECK_DETAIL: baseURL + 'objection/showObjAssistInfo.qyzx',
        //异议协查保存接口
        OBJCHECK_SUBMIT: baseURL + 'objection/objAssistInsert.qyzx',
        //用户授权列表接口
        USERAUTH_LIST: baseURL + 'userAuth/userAuthList.qyzx',
        //申请授权接口
        APPLYUSERAUTH: baseURL + 'userAuth/applyUserAuth.qyzx',
        //用户授权管理详情
        QUERYUSERAUTHINFO: baseURL + 'userAuth/queryAuthInfo.qyzx',
        //产品查询列表
        PRODUCT_LIST: baseURL + 'productManager/queryProductList.qyzx',
        //产品列表下的产品详情
        PRODUCT_DETAIL: baseURL + 'productManager/queryProductDetail.qyzx',
        //产品启用停用
        PRODUCT_STATUS: baseURL + 'productManager/changeProductStatus.qyzx',
        //产品修改后的保存
        PRODUCT_SAVE: baseURL + 'productManager/saveProduct.qyzx',
        //产品新建后提交
        ADD_PRODUCT: baseURL + 'productManager/addProduct.qyzx',
        //获取产品编码
        GETPRODUCTCODE: baseURL + 'productManager/getProductCode.qyzx',
        //产品复核
        RECHECK_PRODUCT: baseURL + 'productManager/recheckProduct.qyzx',
        //校验产品是否被更改接口
        CHECKPRODUCTUSED: baseURL + 'productManager/checkProductUsed.qyzx',
        //计费列表接口
        QUERYFEETLIST: baseURL + 'feeManager/queryFeeList.qyzx',
        //计费详情接口
        FEETDETAIL: baseURL + 'feeManager/queryFeeDetail.qyzx',
        //充值统计接口
        FEETSTATUIS: baseURL + 'feeManager/queryStatisticsInfo.qyzx',
        //确定充值接口
        SUBMITFEETCHARGE: baseURL + 'feeManager/recharge.qyzx',
        //充值查询接口
        QUERYRECHARGELIST: baseURL + 'feeManager/queryRechargeList.qyzx',
        //登录接口
        LOGIN: baseURL + 'login.qyzx',
        //退出
        LOGOUT: baseURL + 'logout.qyzx',
        //登录后的菜单接口
        LONGIN_MENU: baseURL + 'menu/menu.qyzx',
        //系统管理 用户角色查询
        QUERYROLELIST: baseURL + 'userManager/queryRoleList.qyzx',
        //系统管理 新建用户
        ADDUSER: baseURL + 'userManager/addUser.qyzx',
        //用户列表查询接口
        USERLIST: baseURL + 'userManager/queryUserList.qyzx',
        //用户详情
        USERDETAIL: baseURL + 'userManager/queryUserDetail.qyzx',
        //用户管理 重置密码
        RESETPASSWORD: baseURL + 'userManager/resetPassword.qyzx',
        //用户管理里的 启用停用修改接口
        UPDATEUSER: baseURL + 'userManager/updateUser.qyzx',
        //产品授权列表
        PRODUCTAUTHLIST: baseURL + 'productAuthManager/queryProductAuthList.qyzx',
        //新建产品授权
        ADDPRODUCTAUTH: baseURL + 'productAuthManager/addProductAuth.qyzx',
        //产品授权复核详情
        PRODUCTAUTHDETAIL: baseURL + 'productAuthManager/queryProductAuthDetail.qyzx',
        //产品授权详情更新
        UPDATEPRODUCTAUTH: baseURL + 'productAuthManager/updateProductAuth.qyzx',
        //公共接口  查询产品列表
        COMMON_PRODUCTLIST: baseURL + 'common/queryProductList.qyzx',
        //公共接口 查询机构列表
        QUERYORGLIST: baseURL + 'common/queryOrgList.qyzx',
        //公共接口  查询渠道列表
        COMMON_CHANNELLIST: baseURL + 'common/queryChannelList.qyzx',
        //公共接口  token列表
        COMMON_TOKENLIST: baseURL + 'token/tokenList.qyzx',
        //公共接口  tokensrarch列表
        COMMON_TOKENSEARCH: baseURL + 'token/generate.qyzx',
        //公共接口  reportsrarch列表
        COMMON_REPORTSEARCH: baseURL + 'statementManager/queryStatement.qyzx',
        //公共接口  报表查询日期
        COMMON_REPORTDATASEARCH: baseURL + 'statementManager/queryStatementBizDate.qyzx',
        //报表查询接口
        REPORT_SEARCH: baseURL + 'statementManager/queryStatement.qyzx',
        //报表上传接口
        STATEMENT_UPLOAD: baseURL + 'statementManager/uploadStatement.qyzx',
        //当前报表下载
        STATEMENT_EXPORT: baseURL + 'statementManager/exportExcel.qyzx',
        //字典项查询接口
        DICCODES: baseURL + 'common/getDicCode.qyzx',
        DICCODES2: baseURL + 'common/getDicCode.qyzx',
        //机构列表查询接口
        ORGANIZITION: baseURL + 'organization/orgList.qyzx',
        //重置密码接口
        RESTPWD: baseURL + 'organization/orgResetPwd.qyzx',
        //机构详情和修改接口
        MODIFY: baseURL + 'organization/orgModify.qyzx',
        //机构新增和修改接口
        ORGSAVE: baseURL + 'organization/orgSave.qyzx',
        //渠道是否被使用接口
        CHANNELISUSED: baseURL + 'channel/isChannelInUse.qyzx',
        //获取机构代码接口
        GETORGCODE: baseURL + 'organization/getOrgCode.qyzx',
        //机构状态修改
        ORGSTATUSCHANGE: baseURL + 'organization/orgStatusChange.qyzx',
        //渠道查询
        CHANNEL_LIST: baseURL + 'channel/channelList.qyzx',
        //渠道详情
        CAHNNEL_LIST_DETAIL: baseURL + 'channel/channelDetail.qyzx',
        //获取渠道代码
        GETCHANNELCODE: baseURL + 'channel/getChannelCode.qyzx',
        //渠道信息保存接口
        CHANNEL_SAVE: baseURL + 'channel/channelSave.qyzx',
        //渠道状态修改
        CHANNELSTATUSCHANGE: baseURL + 'channel/channelStatusChange.qyzx',
        //机构是否启用接口
        ISORGOPEN: baseURL + 'organization/isOrgOpen.qyzx',
        //校验产品授权是否使用
        ISPRODUCTAUTHUSED: baseURL + 'channel/isProductAuthInUse.qyzx',
        //异议列表接口
        OBJECTION_LIST: baseURL + 'objection/objList.qyzx',
        //异议详情
        OBJECTION_DETAIL: baseURL + 'objection/showObjInfo.qyzx',
        //异议提交接口
        UPDATEOBJINFO: baseURL + 'objection/updateObjInfo.qyzx',
        //异议核查列表接口
        OBJECTIONCHECK_LIST: baseURL + 'objection/objAssistList.qyzx',
        //异议协查详情
        OBJECTCHECK_DETAIL: baseURL + 'objection/showObjAssistInfo.qyzx',
        //异议协查保存接口
        OBJCHECK_SUBMIT: baseURL + 'objection/objAssistInsert.qyzx',
        //用户授权列表接口
        USERAUTH_LIST: baseURL + 'userAuth/userAuthList.qyzx',
        //申请授权接口
        APPLYUSERAUTH: baseURL + 'userAuth/applyUserAuth.qyzx',
        //用户授权管理详情
        QUERYUSERAUTHINFO: baseURL + 'userAuth/queryAuthInfo.qyzx',
        //产品查询列表
        PRODUCT_LIST: baseURL + 'productManager/queryProductList.qyzx',
        //产品列表下的产品详情
        PRODUCT_DETAIL: baseURL + 'productManager/queryProductDetail.qyzx',
        //产品启用停用
        PRODUCT_STATUS: baseURL + 'productManager/changeProductStatus.qyzx',
        //产品修改后的保存
        PRODUCT_SAVE: baseURL + 'productManager/saveProduct.qyzx',
        //产品新建后提交
        ADD_PRODUCT: baseURL + 'productManager/addProduct.qyzx',
        //获取产品编码
        GETPRODUCTCODE: baseURL + 'productManager/getProductCode.qyzx',
        //产品复核
        RECHECK_PRODUCT: baseURL + 'productManager/recheckProduct.qyzx',
        //校验产品是否被更改接口
        CHECKPRODUCTUSED: baseURL + 'productManager/checkProductUsed.qyzx',
        //计费列表接口
        QUERYFEETLIST: baseURL + 'feeManager/queryFeeList.qyzx',
        //计费详情接口
        FEETDETAIL: baseURL + 'feeManager/queryFeeDetail.qyzx',
        //充值统计接口
        FEETSTATUIS: baseURL + 'feeManager/queryStatisticsInfo.qyzx',
        //确定充值接口
        SUBMITFEETCHARGE: baseURL + 'feeManager/recharge.qyzx',
        //充值查询接口
        QUERYRECHARGELIST: baseURL + 'feeManager/queryRechargeList.qyzx',
        //登录接口
        LOGIN: baseURL + 'login.qyzx',
        //登录后的菜单接口
        LONGIN_MENU: baseURL + 'menu/menu.qyzx',
        //系统管理 用户角色查询
        QUERYROLELIST: baseURL + 'userManager/queryRoleList.qyzx',
        //系统管理 新建用户
        ADDUSER: baseURL + 'userManager/addUser.qyzx',
        //用户列表查询接口
        USERLIST: baseURL + 'userManager/queryUserList.qyzx',
        //用户详情
        USERDETAIL: baseURL + 'userManager/queryUserDetail.qyzx',
        //用户管理 重置密码
        RESETPASSWORD: baseURL + 'userManager/resetPassword.qyzx',
        //用户管理里的 启用停用修改接口
        UPDATEUSER: baseURL + 'userManager/updateUser.qyzx',
        //产品授权列表
        PRODUCTAUTHLIST: baseURL + 'productAuthManager/queryProductAuthList.qyzx',
        //新建产品授权
        ADDPRODUCTAUTH: baseURL + 'productAuthManager/addProductAuth.qyzx',
        //产品授权复核详情
        PRODUCTAUTHDETAIL: baseURL + 'productAuthManager/queryProductAuthDetail.qyzx',
        //产品授权详情更新
        UPDATEPRODUCTAUTH: baseURL + 'productAuthManager/updateProductAuth.qyzx',
        //公共接口  查询产品列表
        COMMON_PRODUCTLIST: baseURL + 'common/queryProductList.qyzx',
        //公共接口 查询机构列表
        QUERYORGLIST: baseURL + 'common/queryOrgList.qyzx',
        //公共接口  查询渠道列表
        COMMON_CHANNELLIST: baseURL + 'common/queryChannelList.qyzx',
        //公共接口  token列表
        COMMON_TOKENLIST: baseURL + 'token/tokenList.qyzx',
        //公共接口  tokensrarch列表
        COMMON_TOKENSEARCH: baseURL + 'token/generate.qyzx',
        //当前报表下载
        STATEMENT_EXPORTALL: baseURL + 'statementManager/exportExcelAll.qyzx',
        //文件上传
        UPLOADFILE: baseURL + 'statementManager/uploadStatement.qyzx',
        //公共接口 -- 判断是否已经登录
        ISLOGIN: baseURL + 'common/checkLogin.qyzx'


        //DICCODES: 'data/dicCodes.json',
        //DICCODES2: 'data/dicCodes.json',
        //ORGANIZITION: 'data/organization.json',
        //RESTPWD: 'data/dicCodes.json',
        //MODIFY: 'data/organization_detail.json',
        //ORGSAVE: 'data/organization_save.json',
        //CHANNELISUSED: 'data/channelisused.json',
        //GETORGCODE: 'data/organization_getorgcode.json',
        //ORGSTATUSCHANGE: 'data/dicCodes.json',
        //CHANNEL_LIST: 'data/channel_list.json',
        //CAHNNEL_LIST_DETAIL: 'data/channel_list_detail.json',
        //GETCHANNELCODE: 'data/channel_list_getchannelcode.json',
        //CHANNEL_SAVE: 'data/channel_list_detail.json',
        //CHANNELSTATUSCHANGE: 'data/channelisused.json',
        //ISORGOPEN: 'data/isorgopen.json',
        //ISPRODUCTAUTHUSED: 'data/channelisused.json',
        //OBJECTION_LIST: 'data/objection_list.json',
        //OBJECTION_DETAIL: 'data/objection_detail.json',
        //UPDATEOBJINFO: 'data/objection_detail.json',
        //OBJECTIONCHECK_LIST: 'data/objectioncheck_list.json',
        //OBJECTCHECK_DETAIL: 'data/objection_detail_detail.json',
        //OBJCHECK_SUBMIT: 'data/objectioncheck_list.json',
        //USERAUTH_LIST: 'data/userAuth_list.json',
        //APPLYUSERAUTH: 'data/applyuserauth.json',
        //QUERYUSERAUTHINFO: 'data/userAuth_detail.json',
        //PRODUCT_LIST: 'data/product_list.json',
        //PRODUCT_DETAIL: 'data/product_detail.json',
        //PRODUCT_STATUS: 'data/dicCodes.json',
        //PRODUCT_SAVE: 'data/dicCodes.json',
        //ADD_PRODUCT: 'data/dicCodes.json',
        //GETPRODUCTCODE: 'data/product_getcode.json',
        //RECHECK_PRODUCT: 'data/dicCodes.json',
        //CHECKPRODUCTUSED: 'data/checkproductused.json',
        //QUERYFEETLIST: 'data/feet_list.json',
        //FEETDETAIL: 'data/feet_detail.json',
        //FEETSTATUIS: 'data/feet_statius.json',
        //SUBMITFEETCHARGE: 'data/feet_list.json',
        //QUERYRECHARGELIST: 'data/feet_record.json',
        //LOGIN: 'data/login1.json',
        //LONGIN_MENU: 'data/login.json',
        //LOGOUT: 'data/login.json',
        //QUERYROLELIST: 'data/queryrolelist.json',
        //ADDUSER: 'data/adduser.json',
        //USERLIST: 'data/userlist.json',
        //USERDETAIL: 'data/userdetail.json',
        //RESETPASSWORD: 'data/userdetail.json',
        //UPDATEUSER: 'data/userdetail.json',
        //PRODUCTAUTHLIST: 'data/productAuth_list.json',
        //ADDPRODUCTAUTH: 'data/productAuth_new.json',
        //PRODUCTAUTHDETAIL: 'data/productAuth_recheck_detail.json',
        //UPDATEPRODUCTAUTH: 'data/productAuth_recheck_detail.json',
        //COMMON_PRODUCTLIST: 'data/common_productList.json',
        //QUERYORGLIST: 'data/queryorglist.json',
        //COMMON_CHANNELLIST: 'data/common_channelList.json',
        //COMMON_TOKENLIST: 'data/token.json',
        //COMMON_TOKENSEARCH: 'data/genetoken.json',
        //COMMON_REPORTSEARCH: 'data/searchreport.json',
        //COMMON_REPORTDATASEARCH: 'data/reportdatasearch.json',
        //REPORT_SEARCH: 'data/reportSearch.json',
        //STATEMENT_UPLOAD: 'data/statement_upload.json',
        //STATEMENT_EXPORT: 'data/statement_upload.json',
        //STATEMENT_EXPORTALL: 'data/statement_uploadall.json',
        //UPLOADFILE: 'data/statement_uploadall.json',
        //ISLOGIN: 'data/islogin.json'


    };
    return {apis: apis};
});

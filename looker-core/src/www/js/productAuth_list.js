/**
 * Created by fananyuan on 2016/6/20.
 */
define(['ko', 'underscore', 'C', 'jquery',
    'js/productAuth_recheck_detail',
    'js/productAuth_noPass_detail',
    'js/productAuth_open_detail',
    'js/productAuth_opened_detail',
    'js/productAuth_delete_detail',
    'js/productAuth_modify',
    'js/productAuth_opened_modify'],
    function (ko, _, C, $,
              productAuth_recheck_detail,
              productAuth_noPass_detail,
              productAuth_open_detail,
              productAuth_opened_detail,
              productAuth_delete_detail,
              productAuth_modify,
              productAuth_opened_modify) {
    var productAuth_list,
    //产品授权管理主模板
        TEM_PRODUCTAUTH_LIST = _.template($('#tem_productAuth_list').html()),
    //表单-- 全部
        TEM_PRODUCTAUTH_LIST_ALL_TABLE = _.template($('#tem_productAuth_list_all_table').html()),
    //表单 -- 已删除
        TEM_PRODUCTAUTH_LIST_DELETE_TABLE = _.template($('#tem_productAuth_list_delete_table').html()),
    //已申请表单
        TEM_PRODUCTAUTH_LIST_APPLYIED_TABLE = _.template($('#tem_productAuth_list_applied_table').html()),
    //表单-- 不通过、已开通
        TEM_PRODUCTAUTH_LIST_OTHER_TABLE = _.template($('#tem_productAuth_list_other_table').html()),
        URL = C.Api.PRODUCTAUTHLIST,
        // 查询状态：0-全部,1-已申请,2-不通过,3-已开通,4-已删除
        QUERYSTATUS = '0',
        //用户登录信息
        USERINFO =   C.Utils.data('userInfo') || {},
        roleList = USERINFO.roleList ? USERINFO.roleList.join(',') : '',
    //是否仅仅是查询员
        isCPCXY = roleList.indexOf('CPSQCXY') != -1 && roleList.indexOf('CPSQGLY') == -1,
    //是否仅仅是管理员
        isCPSQGLY = roleList.indexOf('CPSQGLY') != -1 && roleList.indexOf('CPSQCXY') == -1;

    productAuth_list = {
        init: function (backTo) {
            var _this = this,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO), backTo);
            _this.bind($('#' + CONTAINERNO));
            window.location.hash = 'productAuth_list';

        },
        render: function (CONTAINER, backTo) {
            var _this = this;
            $('.show_position_pre').text('产品授权管理');
            $('.show_position').text('>产品授权查询');
            $('.show_position_next').hide();
            $('#organization_modify_header').show().siblings().hide();
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.DICCODES,
                data: {dicType: 'auth_status'},
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        CONTAINER.html(TEM_PRODUCTAUTH_LIST(res.resData));
                       _this.setAll(QUERYSTATUS);
                        switch(backTo){
                            case '1':
                                CONTAINER.find('.productAuth_1').trigger('click');
                                break;
                            case '2':
                                CONTAINER.find('.productAuth_2').trigger('click');
                                break;
                            case '3':
                                CONTAINER.find('.productAuth_3').trigger('click');
                                break;
                            case '4':
                                CONTAINER.find('.productAuth_4').trigger('click');
                                break;
                        }
                    }
                }
            });
        },
        bind: function (CONTAINER, backTo) {
            var _this = this;
            //查询按钮
            CONTAINER.on('click', '.productAuth_list_search', function () {
                var tem = '',
                    productName = $('.productName').val(),
                    orgName = $('.orgName').val(),
                    channelName = $('.channelName').val(),
                    authCode = $('.authCode').val(),
                    authStatus = $('.authStatus').val();
                    if(QUERYSTATUS == '0' || QUERYSTATUS == '4'){
                        tem = TEM_PRODUCTAUTH_LIST_ALL_TABLE;
                    }else if(QUERYSTATUS == '1'){
                        tem = TEM_PRODUCTAUTH_LIST_APPLYIED_TABLE;
                    }else if(QUERYSTATUS == '2' || QUERYSTATUS == '3'){
                        tem = TEM_PRODUCTAUTH_LIST_OTHER_TABLE
                    }
                C.PageBreak.table({
                    //表格内容包裹层
                    $tablebox: $('.productAuth_list_table_box'),
                    headcontent: [{name: '产品名称', icon: 'iconfont sort', order_by: 'PRODUCT_NAME'}, {name: '机构名称', icon: 'iconfont sort', order_by: 'ORG_NAME'},
                        {name: '渠道名称', icon: 'iconfont sort', order_by: 'CHANNEL_NAME'}, {name: '授权状态', icon: 'iconfont sort', order_by: 'AUTH_STATUS'},
                        {name: '授权条数', icon: 'iconfont sort', order_by: 'AUTH_NUM'}, {name: '授权开始日期', icon: 'iconfont sort', order_by: 'AUTH_BEGIN_TIME'},
                        {name: '授权结束日期', icon: 'iconfont sort', order_by: 'AUTH_END_TIME'}, {name: '授权状态', icon: 'iconfont sort', order_by: 'STATE'},
                        {name: '操作', icon: '', order_by: ''}],
                    //编译后的表单
                    tem: tem,
                    //当前页
                    cindex: '1',
                    pageSize: '10',
                    url: URL,
                    //向后端传递的附加参数
                    parm: {
                        totalCount: 0,
                        queryStatus: QUERYSTATUS,
                        productName: productName,
                        orgName: orgName,
                        channelName: channelName,
                        authCode: authCode,
                        authStatus: authStatus
                    },
                    callback: function(){
                        if(QUERYSTATUS == '1' && isCPCXY || QUERYSTATUS == '1' && isCPSQGLY){
                            $('.productAuth_list_applied').text('详情');
                        }else if((QUERYSTATUS == '2' || QUERYSTATUS == '3') && isCPCXY){
                            $('.productAuth_list_other_modify').hide();
                        }
                    }
                });
            });
           //重置按钮
            CONTAINER.on('click', '.productAuth_list_reset', function () {
                var selectDom = $('.secondtclm select option[value=""]');
                $('.secondtclm input').val('');
                selectDom.attr('selected', true);
                selectDom.removeAttr('selected');
            });

            //点击全部
            CONTAINER.on('click', '.productAuth_0', function(){
                var self = $(this);
                QUERYSTATUS = '0';
                _this.removeCur(self);
                _this.setAll(QUERYSTATUS);
                CONTAINER.find('.productAuth_list_reset').trigger('click');

            });

            //点击已申请
            CONTAINER.on('click', '.productAuth_1', function(){
                var self = $(this);
                QUERYSTATUS = '1';
                _this.removeCur(self);
                _this.setApplied(QUERYSTATUS);
                CONTAINER.find('.productAuth_list_reset').trigger('click');
            });

          //点击不通过
            CONTAINER.on('click', '.productAuth_2', function(){
                var self = $(this);
                QUERYSTATUS = '2';
                _this.removeCur(self);
                _this.setOther(QUERYSTATUS);
                CONTAINER.find('.productAuth_list_reset').trigger('click');
            });
            //点击已开通
            CONTAINER.on('click', '.productAuth_3', function(){
                var self = $(this);
                QUERYSTATUS = '3';
                _this.removeCur(self);
                _this.setOther(QUERYSTATUS);
                CONTAINER.find('.productAuth_list_reset').trigger('click');
            });
            //点击已删除
            CONTAINER.on('click', '.productAuth_4', function(){
                var self = $(this);
                QUERYSTATUS = '4';
                _this.removeCur(self);
                _this.setdelete(QUERYSTATUS);
                CONTAINER.find('.productAuth_list_reset').trigger('click');
            });

            //点击全部 已删除 里的详情
            CONTAINER.on('click', '.productAuth_list_all', function(){
                var $this = $(this),
                    state = $this.attr('state'),
                    id = $this.attr('authId'),
                    data = {id: id, type: '1'};

                if( state == '0' || state == '1' || state == '2'){
                    productAuth_recheck_detail.init(data); //已申请
                }else if(state == '3' || state == '4' || state == '5'){
                    productAuth_noPass_detail.init(data); //不通过
                }else if(state == '6' || state == '7'){
                    productAuth_open_detail.init(data); // 开通详情页
                }else if(state == '8'){
                    productAuth_delete_detail.init(data); //已删除详情页
                }else if(state == '9'){
                    productAuth_opened_detail.init(data); //已开通详情页
                }
            });
            //已删除里的详情
            CONTAINER.on('click', '.productAuth_list_delete', function(){
                var $this = $(this),
                    state = $this.attr('state'),
                    id = $this.attr('authId'),
                    data = {id: id, type: '1', backTo: '4'};
                  productAuth_delete_detail.init(data); //已删除详情页
            });

            //已申请里的复核
            CONTAINER.on('click', '.productAuth_list_applied', function(){
                var $this = $(this),
                    id = $this.attr('authId'),
                    data = {id: id, type: '1', backTo: '1'};
                   productAuth_recheck_detail.init(data);
            });

            //不通过 已开通里的详情
            CONTAINER.on('click', '.productAuth_list_other_detail', function(){
                var $this = $(this),
                    state = $this.attr('state'),
                    id = $this.attr('authId');

                if( state == '3' || state == '4' || state == '5'){
                    productAuth_noPass_detail.init({id: id, type: '1', backTo: '2'});
                }else if(state == '9'){
                    productAuth_opened_detail.init({id: id, type: '1', backTo: '3'}); //已开通详情页
                }
            });

            //不通过 已开通里的修改
            CONTAINER.on('click', '.productAuth_list_other_modify', function(){
                var $this = $(this),
                    state = $this.attr('state'),
                    id = $this.attr('authId');

                if( state == '3' || state == '4' || state == '5'){
                    productAuth_modify.init({id: id, type: '1', backTo: '2'});//不通过
                }else if(state == '9'){
                    productAuth_opened_modify.init({id: id, type: '1', backTo: '3'}); //已开通详情页
                }
            });
        },
        removeCur: function(self){
            self.addClass('cur').siblings().removeClass('cur');
        },
        //生成 全部
        setAll: function(QUERYSTATUS){
            C.PageBreak.table({
                //表格内容包裹层
                $tablebox: $('.productAuth_list_table_box'),
                headcontent: [{name: '产品名称', icon: 'iconfont sort', order_by: 'PRODUCT_NAME'}, {name: '机构名称', icon: 'iconfont sort', order_by: 'ORG_NAME'},
                    {name: '渠道名称', icon: 'iconfont sort', order_by: 'CHANNEL_NAME'}, {name: '授权状态', icon: 'iconfont sort', order_by: 'AUTH_STATUS'},
                    {name: '授权条数', icon: 'iconfont sort', order_by: 'AUTH_NUM'}, {name: '授权开始日期', icon: 'iconfont sort', order_by: 'AUTH_BEGIN_TIME'},
                    {name: '授权结束日期', icon: 'iconfont sort', order_by: 'AUTH_END_TIME'}, {name: '状态', icon: 'iconfont sort', order_by: 'STATE'},
                    {name: '操作', icon: '', order_by: ''}],
                //编译后的表单
                tem: TEM_PRODUCTAUTH_LIST_ALL_TABLE,
                //当前页
                cindex: '1',
                pageSize: '10',
                url: URL,
                //向后端传递的附加参数
                parm: {
                    totalCount: 0,
                    queryStatus: QUERYSTATUS
                }
            });
        },
        //已删除表格
        setdelete: function(QUERYSTATUS){
            C.PageBreak.table({
                //表格内容包裹层
                $tablebox: $('.productAuth_list_table_box'),
                headcontent: [{name: '产品名称', icon: 'iconfont sort', order_by: 'PRODUCT_NAME'}, {name: '机构名称', icon: 'iconfont sort', order_by: 'ORG_NAME'},
                    {name: '渠道名称', icon: 'iconfont sort', order_by: 'CHANNEL_NAME'}, {name: '授权状态', icon: 'iconfont sort', order_by: 'AUTH_STATUS'},
                    {name: '授权条数', icon: 'iconfont sort', order_by: 'AUTH_NUM'}, {name: '授权开始日期', icon: 'iconfont sort', order_by: 'AUTH_BEGIN_TIME'},
                    {name: '授权结束日期', icon: 'iconfont sort', order_by: 'AUTH_END_TIME'}, {name: '状态', icon: 'iconfont sort', order_by: 'STATE'},
                    {name: '操作', icon: '', order_by: ''}],
                //编译后的表单
                tem: TEM_PRODUCTAUTH_LIST_DELETE_TABLE,
                //当前页
                cindex: '1',
                pageSize: '10',
                url: URL,
                //向后端传递的附加参数
                parm: {
                    totalCount: 0,
                    queryStatus: QUERYSTATUS
                }
            });
        },
        setApplied: function(QUERYSTATUS){  //已申请表格
            C.PageBreak.table({
                //表格内容包裹层
                $tablebox: $('.productAuth_list_table_box'),
                headcontent: [{name: '产品名称', icon: 'iconfont sort', order_by: 'PRODUCT_NAME'}, {name: '机构名称', icon: 'iconfont sort', order_by: 'ORG_NAME'},
                    {name: '渠道名称', icon: 'iconfont sort', order_by: 'CHANNEL_NAME'}, {name: '授权状态', icon: 'iconfont sort', order_by: 'AUTH_STATUS'},
                    {name: '授权条数', icon: 'iconfont sort', order_by: 'AUTH_NUM'}, {name: '授权开始日期', icon: 'iconfont sort', order_by: 'AUTH_BEGIN_TIME'},
                    {name: '授权结束日期', icon: 'iconfont sort', order_by: 'AUTH_END_TIME'}, {name: '状态', icon: 'iconfont sort', order_by: 'STATE'},
                    {name: '操作', icon: '', order_by: ''}],
                //编译后的表单
                tem: TEM_PRODUCTAUTH_LIST_APPLYIED_TABLE,
                //当前页
                cindex: '1',
                pageSize: '10',
                url: URL,
                //向后端传递的附加参数
                parm: {
                    totalCount: 0,
                    queryStatus: QUERYSTATUS
                },
                callback: function(){
                    if(isCPCXY || isCPSQGLY){
                        $('.productAuth_list_applied').text('详情');
                    }
                }
            });
        },
        //生成不通过 已开通表格
        setOther: function(QUERYSTATUS){
            C.PageBreak.table({
                //表格内容包裹层
                $tablebox: $('.productAuth_list_table_box'),
                headcontent: [{name: '产品名称', icon: 'iconfont sort', order_by: 'PRODUCT_NAME'}, {name: '机构名称', icon: 'iconfont sort', order_by: 'ORG_NAME'},
                    {name: '渠道名称', icon: 'iconfont sort', order_by: 'CHANNEL_NAME'}, {name: '授权状态', icon: 'iconfont sort', order_by: 'AUTH_STATUS'},
                    {name: '授权条数', icon: 'iconfont sort', order_by: 'AUTH_NUM'}, {name: '授权开始日期', icon: 'iconfont sort', order_by: 'AUTH_BEGIN_TIME'},
                    {name: '授权结束日期', icon: 'iconfont sort', order_by: 'AUTH_END_TIME'}, {name: '状态', icon: 'iconfont sort', order_by: 'STATE'},
                    {name: '操作', icon: '', order_by: ''}],
                //编译后的表单
                tem: TEM_PRODUCTAUTH_LIST_OTHER_TABLE,
                //当前页
                cindex: '1',
                pageSize: '10',
                url: URL,
                //向后端传递的附加参数
                parm: {
                    totalCount: 0,
                    queryStatus: QUERYSTATUS
                },
                callback: function(){
                    if(isCPCXY){
                       $('.productAuth_list_other_modify').hide();
                    }
                }
            });
        }
    };
    return productAuth_list;
});
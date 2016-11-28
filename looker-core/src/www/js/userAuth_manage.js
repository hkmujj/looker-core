/**
 * Created by fananyuan on 2016/6/20.
 */
define(['ko', 'underscore', 'C', 'jquery', 'js/userAuth_detail'], function (ko, _, C, $, userAuth_detail) {
    var userAuth_manage,
    //用户授权管理主模板
        TEM_USERAUTH_MANAGE = _.template($('#tem_userAuth_manage').html()),
    //用户授权管理表单--未获取
        TEM_USERAUTH_MANAGE_TABLE = _.template($('#tem_userAuth_manage_table').html()),
    //用户授权管理表单--其他
        TEM_USERAUTH_MANAGE_OTHER_TABLE = _.template($('#tem_userAuth_manage_other_table').html()),
        URL = C.Api.USERAUTH_LIST,
        STATE = '1',
        //未获取返回的总条数
        TOTAL_COUNT = 0;

    userAuth_manage = {
        init: function (backTo) {
            var _this = this,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO),backTo);
            _this.bind($('#' + CONTAINERNO));
            window.location.hash = 'userAuth_manage';
        },
        render: function (CONTAINER, backTo) {
            var _this = this;
            $('.show_position_pre').text('用户授权管理');
            $('.show_position').text('>用户授权管理');
            $('.show_position_next').hide();
            $('#organization_modify_header').show().siblings().hide();
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.DICCODES,
                data: {dicType: 'status'},
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        var item = res.resData;
                        CONTAINER.html(TEM_USERAUTH_MANAGE(res.resData));
                          C.PageBreak.table({
                            //表格内容包裹层
                            $tablebox: $('.userAuth_manage_table_box'),
                            headcontent: [{name: '姓名', icon: 'iconfont sort', order_by: 'user_Name'}, {name: '身份证号', icon: 'iconfont sort', order_by: 'cert_No'},
                                {name: '所属产品', icon: 'iconfont sort', order_by: 'product_Id'}, {name: '所属渠道', icon: 'iconfont sort', order_by: 'create_Time'},
                                {name: '所属机构', icon: '', order_by: ''}, {name: '授权日期', icon: 'iconfont sort', order_by: 'AUTH_TIME'}, {name: '操作', icon: '', order_by: ''}],
                            //编译后的表单
                            tem: TEM_USERAUTH_MANAGE_TABLE,
                            //当前页
                            cindex: '1',
                            pageSize: '10',
                            url: URL,
                            //向后端传递的附加参数
                            parm: {
                                totalCount: 0,
                                state: STATE
                            },
                            callback: function(total){
                                TOTAL_COUNT = total;
                                if(total != '0' && STATE == '1'){
                                    $('.state_all').fadeIn();
                                }
                            }
                        });

                        switch (backTo){
                            case '3':
                                CONTAINER.find('.state_checking').trigger('click');
                                break;
                            case '4':
                                CONTAINER.find('.state_timeout').trigger('click');
                                break;
                            case '5':
                                CONTAINER.find('.state_already').trigger('click');
                                break;
                        }
                    }
                }
            });
        },
        bind: function (CONTAINER) {
            var _this = this;
            //查询按钮
            CONTAINER.on('click', '.userAuth_manage_search', function () {
                var tem = STATE == '1' ? TEM_USERAUTH_MANAGE_TABLE : TEM_USERAUTH_MANAGE_OTHER_TABLE,
                    userName = $('.userName').val(),
                    certNo = $('.certNo').val(),
                    orgCode = $('.orgCode').val(),
                    channelId = $('.channelId').val(),
                    authStartTime = $('.authStartTime').val(),
                    authStopTime = $('.authStopTime').val(),
                    productId = $('.productId').val(),
                    orgName = $('.orgName').val();
                C.PageBreak.table({
                    //表格内容包裹层
                    $tablebox: $('.userAuth_manage_table_box'),
                    headcontent: [{name: '姓名', icon: 'iconfont sort', order_by: 'user_Name'}, {name: '身份证号', icon: 'iconfont sort', order_by: 'cert_No'},
                        {name: '所属产品', icon: 'iconfont sort', order_by: 'product_Id'}, {name: '所属渠道', icon: 'iconfont sort', order_by: 'create_Time'},
                        {name: '所属机构', icon: '', order_by: ''}, {name: '授权日期', icon: 'iconfont sort', order_by: 'AUTH_TIME'}, {name: '操作', icon: '', order_by: ''}],
                    //编译后的表单
                    tem: tem,
                    //当前页
                    cindex: '1',
                    pageSize: '10',
                    url: URL,
                    //向后端传递的附加参数
                    parm: {
                        totalCount: 0,
                        state: STATE,
                        userName:userName,
                        certNo:certNo,
                        channelName:channelId,
                        productName:productId,
                        authStartTime:authStartTime,
                        authStopTime:authStopTime,
                        orgName: orgName
                    }
                });
            });
           //重置按钮
            CONTAINER.on('click', '.userAuth_managet_reset', function () {
                $('.secondtclm input').val('');
            });

            //点击未获取
            CONTAINER.on('click', '.state_no', function(){
                var self = $(this);
                    STATE = '1';
                _this.removeCur(self);
                if(TOTAL_COUNT != '0' && STATE == '1'){
                    $('.state_all').fadeIn();
                }else{
                    $('.state_all').hide();
                }
                C.PageBreak.table({
                    //表格内容包裹层
                    $tablebox: $('.userAuth_manage_table_box'),
                    headcontent: [{name: '姓名', icon: 'iconfont sort', order_by: 'user_Name'}, {name: '身份证号', icon: 'iconfont sort', order_by: 'cert_No'},
                        {name: '所属产品', icon: 'iconfont sort', order_by: 'product_Id'}, {name: '所属渠道', icon: 'iconfont sort', order_by: 'create_Time'},
                        {name: '所属机构', icon: '', order_by: ''}, {name: '授权日期', icon: 'iconfont sort', order_by: 'AUTH_TIME'}, {name: '操作', icon: '', order_by: ''}],
                    //编译后的表单
                    tem: TEM_USERAUTH_MANAGE_TABLE,
                    //当前页
                    cindex: '1',
                    pageSize: '10',
                    url: URL,
                    //向后端传递的附加参数
                    parm: {
                        totalCount: 0,
                        state: STATE
                    }
                });
            });

            //点击协查中
            CONTAINER.on('click', '.state_checking', function(){
                var self = $(this);
                    STATE = '3';
                _this.removeCur(self);
                $('.state_all').hide();
                _this.stateChange();
            });

          //点击已超时
            CONTAINER.on('click', '.state_timeout', function(){
                var self = $(this);
                    STATE = '4';
                _this.removeCur(self);
                $('.state_all').hide();
                _this.stateChange();
            });
            //点击已获取
            CONTAINER.on('click', '.state_already', function(){
                var self = $(this);
                    STATE = '5';
                _this.removeCur(self);
                $('.state_all').hide();
                _this.stateChange();
            });
            //点击一键申请全部
            CONTAINER.on('click', '.state_all', function(){
                var self = $(this),authId = '';
                C.UI.warm({
                    header: '确定一键申请全部吗？',
                    content: '一键申请将申请当前所有',
                    cancelText:'取消',
                    okText: '确定',
                    ok: function () {
                        C.PageBreak.Loading();
                        $.ajax({
                            type: 'get',
                            url: C.Api.APPLYUSERAUTH,
                            data: {authId: authId},
                            success: function(res){
                                C.PageBreak.stopLoading();
                                if (res.resCode == C.ResCodes.SUCCESS && res.resData.updateCount) {
                                    var successCount = res.resData.updateCount;
                                    C.UI.warm({
                                        header: '申请用户授权成功',
                                        content: '成功申请'+ successCount +'条用户授权',
                                        okText: '确定',
                                        ok: function () {
                                             CONTAINER.find('.state_no').trigger('click');
                                        }
                                    });
                                }
                            }
                        });
                    }
                });

            });
            //列表中的申请
            CONTAINER.on('click', '.manage_apply', function(){
                var self = $(this),
                    authId = self.attr('authId');
                $.ajax({
                    type: 'get',
                    url: C.Api.APPLYUSERAUTH,
                    data: {authId: authId},
                    success: function(res){
                        C.PageBreak.stopLoading();
                        if (res.resCode == C.ResCodes.SUCCESS && res.resData.updateCount) {
                            var successCount = res.resData.updateCount;
                            if( successCount == 1){
                                C.UI.warm({
                                    header: '申请用户授权成功',
                                    content: '当前用户授权已成功申请',
                                    okText: '确定',
                                    ok: function () {
                                        CONTAINER.find('.state_no').trigger('click');
                                    }
                                });
                            }
                        }
                    }
                });
            });
            //点击已获取里的查看
            CONTAINER.on('click', '.userAuth_mamage_detail', function(){
                var authId = $(this).attr('authId'),
                    data = {authId:authId, type: '2', backTo: STATE};
                userAuth_detail.init(data);
            });
            //开始时间
            CONTAINER.on('focus', '#userAuth_manage_start', function(){
                laydate({
                    elem: '#userAuth_manage_start',
                    istime: true,
                    istoday: false,
                    max: $('#userAuth_manage_end').val()

                });
            });
            //结束时间
            CONTAINER.on('focus', '#userAuth_manage_end', function(){
                laydate({
                    elem: '#userAuth_manage_end',
                    istime: true,
                    istoday: false,
                    min: $('#userAuth_manage_start').val()
                });
            });
        },
        removeCur: function(self){
            self.addClass('cur').siblings().removeClass('cur');
        },
        //其他
        stateChange: function(){
            C.PageBreak.table({
                //表格内容包裹层
                $tablebox: $('.userAuth_manage_table_box'),
                headcontent: [{name: '姓名', icon: 'iconfont sort', order_by: 'user_Name'}, {name: '身份证号', icon: 'iconfont sort', order_by: 'cert_No'},
                    {name: '所属产品', icon: 'iconfont sort', order_by: 'product_Id'}, {name: '所属渠道', icon: 'iconfont sort', order_by: 'create_Time'},
                    {name: '所属机构', icon: '', order_by: ''}, {name: '授权日期', icon: 'iconfont sort', order_by: 'AUTH_TIME'}, {name: '操作', icon: '', order_by: ''}],
                //编译后的表单
                tem: TEM_USERAUTH_MANAGE_OTHER_TABLE,
                //当前页
                cindex: '1',
                pageSize: '10',
                url: URL,
                //向后端传递的附加参数
                parm: {
                    totalCount: 0,
                    state: STATE
                }
            });
        }
    };
    return userAuth_manage;
});
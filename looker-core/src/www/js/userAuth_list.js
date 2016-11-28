/**
 * Created by fananyuan on 2016/6/20.
 */
define(['ko', 'underscore', 'C', 'jquery', 'js/userAuth_detail'], function (ko, _, C, $, userAuth_detail) {
    var userAuth_list,
    //用户授权管理主模板
        TEM_USERAUTH_LIST = _.template($('#tem_userAuth_list').html()),
    //用户授权管理表单-- 未获取
        TEM_USERAUTH_LIST_TABLE = _.template($('#tem_userAuth_list_table').html()),
    //用户授权管理表单-- 已获取
        TEM_USERAUTH_ALREADY_LIST_TABLE = _.template($('#tem_userAuth_list_already_table').html()),
        URL = C.Api.USERAUTH_LIST,
        //授权状态 未获取1
        STATE = 1;

    userAuth_list = {
        init: function (backTo) {
            var _this = this,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO), backTo);
            _this.bind($('#' + CONTAINERNO));
            window.location.hash = 'userAuth_list';
        },
        render: function (CONTAINER, backTo) {
            var _this = this;
            $('.show_position_pre').text('用户授权管理');
            $('.show_position').text('>用户授权查询');
            $('.show_position_next').hide();
            $('#organization_modify_header').show().siblings().hide();
            C.PageBreak.Loading();
            //todo 模糊匹配
            $.ajax({
                type: 'get',
                url: C.Api.DICCODES,
                data: {dicType: 'status'},
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        CONTAINER.html(TEM_USERAUTH_LIST({}));
                        C.PageBreak.table({
                            //表格内容包裹层
                            $tablebox: $('.userAuth_list_table_box'),
                            headcontent: [{name: '姓名', icon: 'iconfont sort', order_by: 'user_Name'}, {name: '身份证号', icon: 'iconfont sort', order_by: 'cert_No'},
                                          {name: '所属产品', icon: 'iconfont sort', order_by: 'PRODUCT_ID'}, {name: '所属渠道', icon: 'iconfont sort', order_by: 'CHANNEL_ID'},
                                          {name: '所属机构', icon: '', order_by: ''}, {name: '授权日期', icon: 'iconfont sort', order_by: 'AUTH_TIME'}],
                            //编译后的表单
                            tem: TEM_USERAUTH_LIST_TABLE,
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

                        if(backTo == '2'){
                            CONTAINER.find('.state_already').trigger('click');
                        }
                    }
                }
            });
        },
        bind: function (CONTAINER) {
            var _this = this;
            //查询按钮
            CONTAINER.on('click', '.userAuth_list_search', function () {
                var tem = STATE == 1 ? TEM_USERAUTH_LIST_TABLE : TEM_USERAUTH_ALREADY_LIST_TABLE,
                    userName = $('.userName').val(),
                    certNo = $('.certNo').val(),
                    channelId = $('.channelId').val(),
                    authStartTime = $('.authStartTime').val(),
                    authStopTime = $('.authStopTime').val(),
                    productId = $('.productId').val(),
                    orgName = $('.orgName').val();
                C.PageBreak.table({
                    //表格内容包裹层
                    $tablebox: $('.userAuth_list_table_box'),
                    headcontent: [{name: '姓名', icon: 'iconfont sort', order_by: 'user_Name'}, {name: '身份证号', icon: 'iconfont sort', order_by: 'cert_No'},
                        {name: '所属产品', icon: 'iconfont sort', order_by: 'PRODUCT_ID'}, {name: '所属渠道', icon: 'iconfont sort', order_by: 'CHANNEL_ID'},
                        {name: '所属机构', icon: '', order_by: ''}, {name: '授权日期', icon: 'iconfont sort', order_by: 'AUTH_TIME'}],
                    //编译后的表单
                    tem: tem,
                    //当前页
                    cindex: '1',
                    pageSize: '10',
                    url: URL,
                    parm: {
                        totalCount: 0,
                        state: STATE,
                        userName:userName,
                        certNo:certNo,
                        orgName:orgName,
                        channelName:channelId,
                        productName:productId,
                        authStartTime:authStartTime,
                        authStopTime:authStopTime
                    }
                });
            });
           //重置按钮
            CONTAINER.on('click', '.userAuth_list_reset', function () {
                $('.secondtclm input').val('');
            });

         //点击已获取按钮
            CONTAINER.on('click', '.state_already', function(){
               var self = $(this);
                   STATE = 5;
                self.addClass('cur').siblings('.state_no').removeClass('cur');
                C.PageBreak.table({
                    //表格内容包裹层
                    $tablebox: $('.userAuth_list_table_box'),
                    headcontent: [{name: '姓名', icon: 'iconfont sort', order_by: 'user_Name'}, {name: '身份证号', icon: 'iconfont sort', order_by: 'cert_No'},
                        {name: '所属产品', icon: 'iconfont sort', order_by: 'PRODUCT_ID'}, {name: '所属渠道', icon: 'iconfont sort', order_by: 'CHANNEL_ID'},
                        {name: '所属机构', icon: '', order_by: ''}, {name: '授权日期', icon: 'iconfont sort', order_by: 'AUTH_TIME'}, {name: '操作', icon: '', order_by: ''}],
                    //编译后的表单
                    tem: TEM_USERAUTH_ALREADY_LIST_TABLE,
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
            //点击未获取
            CONTAINER.on('click', '.state_no', function(){
                var self = $(this);
                    STATE = 1;
                self.addClass('cur').siblings('.state_already').removeClass('cur');
                C.PageBreak.table({
                    //表格内容包裹层
                    $tablebox: $('.userAuth_list_table_box'),
                    headcontent: [{name: '姓名', icon: 'iconfont sort', order_by: 'user_Name'}, {name: '身份证号', icon: 'iconfont sort', order_by: 'cert_No'},
                        {name: '所属产品', icon: 'iconfont sort', order_by: 'PRODUCT_ID'}, {name: '所属渠道', icon: 'iconfont sort', order_by: 'CHANNEL_ID'},
                        {name: '所属机构', icon: '', order_by: ''}, {name: '授权日期', icon: 'iconfont sort', order_by: 'AUTH_TIME'}],
                    //编译后的表单
                    tem: TEM_USERAUTH_LIST_TABLE,
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

            //点击已获取里的查看
            CONTAINER.on('click', '.userAuth_list_detail', function(){
                var authId = $(this).attr('authId'),
                    data = {authId:authId, type: '1', backTo: '2'};
                userAuth_detail.init(data);
            });

            //开始时间
            CONTAINER.on('focus', '#userAuth_list_start', function(){
                laydate({
                    elem: '#userAuth_list_start',
                    istime: true,
                    istoday: false,
                    max: $('#userAuth_list_end').val()
                });
            });
            //结束时间
            CONTAINER.on('focus', '#userAuth_list_end', function(){
                laydate({
                    elem: '#userAuth_list_end',
                    istime: true,
                    istoday: false,
                    min: $('#userAuth_list_start').val()
                });
            })
        }
    };
    return userAuth_list;
});
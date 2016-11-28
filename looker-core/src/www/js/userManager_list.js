/**
 * Created by fananyuan on 2016/6/20.
 */
define(['ko', 'underscore', 'C', 'jquery', 'js/userManager_detail', 'js/userManager_modify'], function (ko, _, C, $, userManager_detail, userManager_modify) {
    var userManager_list,
    //用户管理主模板
        TEM_USERMANAGER_LIST = _.template($('#tem_userManager_list').html()),
    //表单
        TEM_USERMANAGER_LIST_TABLE = _.template($('#tem_userManager_list_table').html()),
        URL = C.Api.USERLIST;

    userManager_list = {
        init: function () {
            var _this = this,
                CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO));
            _this.bind($('#' + CONTAINERNO));
            window.location.hash = 'userManager_list';

        },
        render: function (CONTAINER) {
            var _this = this;
            $('.show_position_pre').text('用户管理');
            $('.show_position').text('>用户查询');
            $('.show_position_next').hide();
            $('#organization_modify_header').show().siblings().hide();
            C.PageBreak.Loading();
            $.when(
                $.ajax({type: 'get', url:  C.Api.DICCODES, data: {dicType: 'status'}}),
                $.ajax({type:'get', url: C.Api.QUERYROLELIST, data: {}})
            ).
                done(function(res1,res2){
                    C.PageBreak.stopLoading();
                    var item = $.extend(res1[0].resData,res2[0].resData);
                    CONTAINER.html(TEM_USERMANAGER_LIST(item));
                    C.PageBreak.table({
                        //表格内容包裹层
                        $tablebox: $('.userManager_list_table_box'),
                        headcontent: [{name: '用户账号', icon: 'iconfont sort', order_by: 'USER_ACCOUNT'}, {name: '用户姓名', icon: 'iconfont sort', order_by: 'USER_NAME'},
                            {name: '用户状态', icon: '', order_by: ''}, {name: '用户角色', icon: '', order_by: ''},
                            {name: '所属部门', icon: '', order_by: ''}, {name: '手机号码', icon: 'iconfont sort', order_by: 'PHONE_NO'}, {name: '操作', icon: '', order_by: ''}],
                        //编译后的表单
                        tem: TEM_USERMANAGER_LIST_TABLE,
                        //当前页
                        cindex: '1',
                        pageSize: '10',
                        url: URL,
                        //向后端传递的附加参数
                        parm: {
                            totalCount: 0
                        }
                    });
                }).
                fail(function(){C.UI.msg('系统忙,请稍后再试！')});
        },
        bind: function (CONTAINER) {
            var _this = this;
            //查询按钮
            CONTAINER.on('click', '.userManager_list_search', function () {
                var userAccount = $('.userAccount').val(),
                    userName = $('.userName').val(),
                    roleId = $('.roleId').val(),
                    depart = $('.depart').val(),
                    phoneNo = $('.phoneNo').val(),
                    userStatus = $('.userStatus').val();
                C.PageBreak.table({
                    //表格内容包裹层
                    $tablebox: $('.userManager_list_table_box'),
                    headcontent: [{name: '用户账号', icon: 'iconfont sort', order_by: 'USER_ACCOUNT'}, {name: '用户姓名', icon: 'iconfont sort', order_by: 'USER_NAME'},
                        {name: '用户状态', icon: '', order_by: ''}, {name: '用户角色', icon: '', order_by: ''},
                        {name: '所属部门', icon: '', order_by: ''}, {name: '手机号码', icon: 'iconfont sort', order_by: 'PHONE_NO'}, {name: '操作', icon: '', order_by: ''}],
                    //编译后的表单
                    tem: TEM_USERMANAGER_LIST_TABLE,
                    //当前页
                    cindex: '1',
                    pageSize: '10',
                    url: URL,
                    //向后端传递的附加参数
                    parm: {
                        totalCount: 0,
                        userAccount: userAccount,
                        userName: userName,
                        roleId: roleId,
                        depart: depart,
                        phoneNo: phoneNo,
                        userStatus: userStatus
                    }
                });
            });
            //重置按钮
            CONTAINER.on('click', '.userManager_list_reset', function () {
                var selectDom = $('.secondtclm select option[value=""]');
                $('.secondtclm input').val('');
                selectDom.attr('selected', true);
                selectDom.removeAttr('selected');
            });

            //点击详情
            CONTAINER.on('click', '.userManager_detail', function () {

                var userId = $(this).attr('userId'),
                    data = {userId: userId};
                userManager_detail.init(data);

            });
            //修改
            CONTAINER.on('click', '.userManager_modify', function(){
                var  userId = $(this).attr('userId'),
                    data = {userId: userId, type: '1'};
                userManager_modify.init(data);
            });

        }
    };
    return userManager_list;
});
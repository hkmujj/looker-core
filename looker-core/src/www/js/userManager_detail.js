/**
 * Created by fananyuan on 2016/6/20.
 */
define(['require' ,'ko', 'underscore', 'C', 'jquery', 'js/userManager_modify'], function (require ,ko, _, C, $, userManager_modify) {

   var userManager_detail = {
        init: function (data) {
            var _this = this,
            //用户详情
             TEM_USERMANAGER_DETAIL = _.template($('#tem_userManager_detail').html()),
                userId = data.userId,

            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO), userId, TEM_USERMANAGER_DETAIL);
            _this.bind($('#' + CONTAINERNO));

        },
        render: function (CONTAINER, userId, TEM_USERMANAGER_DETAIL) {
            var _this = this;
            $('.show_position_pre').text('用户管理');
            $('.show_position').text('>用户详情');
            C.PageBreak.Loading();
            $.when(
                $.ajax({type: 'get', url:  C.Api.USERDETAIL, data: {userId: userId}}),
                $.ajax({type:'get', url: C.Api.QUERYROLELIST, data:  {userId: userId}})
            ).done(function(res1, res2){
                    C.PageBreak.stopLoading();
                    var item = $.extend(res1[0].resData.userInfo,res2[0].resData);
                    CONTAINER.html(TEM_USERMANAGER_DETAIL(item));
                });

        },
        bind: function (CONTAINER) {
            var _this = this,
                userManager_list = require('js/userManager_list'),
                userAuth_manage = require('js/userAuth_manage');
            //重置密码
            CONTAINER.on('click', '.userManager_restpwd', function(){
                 var userId = $(this).attr('userManager_restpwd');
                $.ajax({
                    type: 'get',
                    url: C.Api.RESETPASSWORD,
                    data: {
                        userId: userId
                    },
                    success: function(res){
                        if (res.resCode == C.ResCodes.SUCCESS) {
                            C.UI.warm({
                                header: '密码重置成功！',
                                content: '您的密码已经重置成功',
                                okText: '确定',
                                ok: function () {

                                }
                            });
                        }
                    }
                });
            });
          //返回
            CONTAINER.on('click', '.userManager_calcel', function(){
                userManager_list.init();
            });

            //启用 停用
            CONTAINER.on('click', '.opcl_stop', function () {
                var $this = $(this),
                    userId = $this.attr('userId'),
                    userStatus = $this.attr('userStatus');
                C.PageBreak.Loading();
                $.ajax({
                    type: 'get',
                    url: C.Api.UPDATEUSER,
                    data: {
                        userId: userId,
                        userStatus: userStatus
                    },
                    success: function(res){
                        C.PageBreak.stopLoading();
                        if (res.resCode == C.ResCodes.SUCCESS) {
                            C.UI.msg('用户启用成功！');
                            $this.hide();
                            $this.siblings('.opcl_open').show();
                        }
                    }
                });

            });
            CONTAINER.on('click', '.opcl_open', function () {
                var $this = $(this),
                    userId = $this.attr('userId'),
                    userStatus = $this.attr('userStatus');
                C.PageBreak.Loading();
                $.ajax({
                    type: 'get',
                    url: C.Api.UPDATEUSER,
                    data: {
                        userId: userId,
                        userStatus: userStatus
                    },
                    success: function(res){
                        C.PageBreak.stopLoading();
                        if (res.resCode == C.ResCodes.SUCCESS) {
                            C.UI.msg('用户停用成功！');
                            $this.hide();
                            $this.siblings('.opcl_stop').show();
                        }
                    }
                });

            });

            //修改
            CONTAINER.on('click', '.userManager_modify', function(){
                var  userId = $(this).attr('userId'),
                    data = {userId: userId, type: '2'};
                userManager_modify.init(data);
            });



        }
    };
    return userManager_detail;
});
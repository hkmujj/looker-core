/**
 * Created by fananyuan on 2016/6/20.
 */
define(['ko', 'underscore', 'C', 'jquery', 'js/userManager_list', 'js/userManager_detail'], function (ko, _, C, $, userManager_list, userManager_detail) {
    var userManager_new,
    //新建用户主模板
        TEM_USERMANAGER_NEW = _.template($('#tem_userManager_new').html()),
        TEM_USERMANAGER_NEW_TABLE = _.template($('#tem_userManager_new_table').html());


    userManager_new = {
        init: function () {
            var _this = this,
                CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO));
            _this.bind($('#' + CONTAINERNO));
            window.location.hash = 'userManager_new';
        },
        render: function (CONTAINER) {
            var _this = this;
            $('.show_position_pre').text('用户管理');
            $('.show_position').text('>新建用户');
            $('.show_position_next').hide();
            $('#organization_modify_header').show().siblings().hide();
            $.ajax({
                type: 'get',
                url: C.Api.DICCODES,
                data: {dicType: 'status'},
                success: function (res1) {
                    if (res1.resCode == C.ResCodes.SUCCESS) {
                        CONTAINER.html(TEM_USERMANAGER_NEW(res1.resData));
                        $.ajax({
                            type: 'get',
                            url: C.Api.QUERYROLELIST,
                            data: {},
                            success: function (res2) {
                                if (res2.resCode == C.ResCodes.SUCCESS) {
                                    $('.usermanager_table').html(TEM_USERMANAGER_NEW_TABLE(res2.resData));
                                }
                            }
                        });
                    }
                }
            });
        },
        bind: function (CONTAINER) {
            var _this = this;
            CONTAINER.on('blur', '.userManager_new_email', function(){
                var email = $('.userManager_new_email').val();
                if(/^[A-Za-z][A-Za-z0-9_]{2,20}$/.test(email)){
                    $('.userAccount').val(email);
                }else{
                    $('.userAccount').val('');
                }
            });

            CONTAINER.on('click', '.userManager_new_submit', function () {
                if(!_this.isValidator()){
                    return;
                }
                var email = $('.email').val(),
                    userAccount = $('.userAccount').val(),
                    userName = $('.userName').val(),
                    depart = $('.depart').val(),
                    phoneNo = $('.phoneNo').val(),
                    userStatus = $('.userStatus').val(),
                    roleIds = _this.getvalue();
                C.PageBreak.Loading();
                $.ajax({
                    type: 'get',
                    url: C.Api.ADDUSER,
                    data: {
                        email: email,
                        userAccount: userAccount,
                        userName: userName,
                        depart: depart,
                        phoneNo: phoneNo,
                        userStatus: userStatus,
                        roleIds: roleIds
                    },
                    success: function (res) {
                        C.PageBreak.stopLoading();
                        if (res.resCode == C.ResCodes.SUCCESS) {
                            var userId = res.resData;
                            C.UI.msg('用户新建成功！');
                            userManager_list.init();
                        }
                    }
                });

            });
            //取消
            CONTAINER.on('click', '.userManager_new_cancel', function(){
                userManager_list.init();
            });
            CONTAINER.on('focus', 'input', function(){
                $('.tips').hide();
            });
        },
        //输入框校验
        isValidator: function(){
            var _this = this,
                email = $('.email').val(),
                userAccount = $('.userAccount').val(),
                userName = $('.userName').val(),
                phoneNo = $('.phoneNo').val(),
                roleIds = _this.getvalue();
            if(!/^[A-Za-z][A-Za-z0-9_]{2,20}$/.test(email)){
                $('.email_tip').show();
                return false;
            }else{
                $('.email_tip').hide();
            }

            if(userAccount == ''){
                $('.userAccount_tip').show();
                return false;
            }else{
                $('.userAccount_tip').hide();
            }
            if(!C.Utils.isName(userName)){
                $('.userName_tip').show();
                return false;
            }else{
                $('.userName_tip').hide();
            }
            if(!C.Utils.isPhoneNum(phoneNo)){
                $('.phoneNo_tip').show();
                return false;
            }else{
                $('.phoneNo_tip').hide();
            }

            if(roleIds == ''){
                C.UI.msg('请至少配置一个角色！');
                return false;
            }
            return true;
        },
        getvalue: function () {
            var dom = $('.roleIds:checked'),
                pool = [],
                value = '';
            for (var i = 0; i < dom.length; i++) {
                pool.push(dom[i].getAttribute('roleIds'));
            }
            value = pool.join(',');
            return value;
        }
    };
    return userManager_new;
});

define(['ko', 'underscore', 'C', 'jquery'], function (ko, _, C, $) {
    var userManager_modify,
    //修改用户
        TEM_USERMANAGER_MODIFY = _.template($('#tem_userManager_modify').html()),
        TEM_USERMANAGER_MODIFY_TABLE = _.template($('#tem_userManager_modify_table').html());

    var userManager_modify = {
        init: function (data) {
            var _this = this,
                userId = data.userId, type = data.type,
                CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO), userId);
            _this.bind($('#' + CONTAINERNO), type, userId);

        },
        render: function (CONTAINER, userId) {
            var _this = this;
            $('.show_position_pre').text('用户管理');
            $('.show_position').text('>修改用户');

            C.PageBreak.Loading();
            $.when(
                $.ajax({type: 'get', url: C.Api.USERDETAIL, data: {userId: userId}}),
                $.ajax({type: 'get', url: C.Api.DICCODES, data: {dicType: 'status'}})).
                done(function (res1, res2) {
                    C.PageBreak.stopLoading();
                    var item = $.extend(res1[0].resData.userInfo, res2[0].resData);
                    CONTAINER.html(TEM_USERMANAGER_MODIFY(item));
                    //默认选中产品原始状态
                    $('.userStatus [value = ' + item.USER_STATUS + ']').attr('selected', true);

                    $.when(
                        $.ajax({type: 'get', url: C.Api.QUERYROLELIST, data: {userId: ''}}),
                        $.ajax({type: 'get', url: C.Api.QUERYROLELIST, data: {userId: userId}})).
                        done(function (res3, res4) {
                            $('.usermanager_modify_table').html(TEM_USERMANAGER_MODIFY_TABLE(res3[0].resData));
                            var map = res4[0].resData.roleList;
                            for (var i = 0; i < map.length; i++) {
                                $('.roleIds[roleids=' + map[i].ROLE_ID + ']').attr('checked', true);
                            }
                        });
                }).fail(function () {
                    C.UI.msg('系统忙,请稍后再试！')
                });
        },
        bind: function (CONTAINER, type, userId) {
            var _this = this,
                userManager_detail = require('js/userManager_detail'),
                userManager_list = require('js/userManager_list');
            //点击修改--确认
            CONTAINER.on('click', '.userManager_modify_submit', function () {
                if(!_this.isValidator()){
                    return;
                }
                var userName = $('.userName').val(),
                    depart = $('.depart').val(),
                    phoneNo = $('.phoneNo').val(),
                    userStatus = $('.userStatus').val(),
                    roleIds = _this.getvalue();
                $.ajax({
                    type: 'get',
                    url: C.Api.UPDATEUSER,
                    data: {
                        userId: userId,
                        userName: userName,
                        depart: depart,
                        phoneNo: phoneNo,
                        userStatus: userStatus,
                        roleIds: roleIds
                    },
                    success: function(res){
                        if (res.resCode == C.ResCodes.SUCCESS) {
                            C.UI.msg('修改用户成功！');
                            switch (type){
                                case '1':
                                    userManager_list.init();
                                    break;
                                case '2':
                                    userManager_detail.init({userId: userId});
                            }
                        }else{
                            C.UI.msg(res.resMsg);
                        }
                    }
                });

            });

            //取消
            CONTAINER.on('click', '.userManager_modify_cancel', function(){
                switch (type){
                    case '1':
                        userManager_list.init();
                        break;
                    case '2':
                        userManager_detail.init({userId: userId});
                }
            });
        },
        //输入框校验
        isValidator: function(){
            var _this = this,
                userName = $('.userName').val(),
                phoneNo = $('.phoneNo').val(),
                roleIds = _this.getvalue();

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
    return userManager_modify;
});
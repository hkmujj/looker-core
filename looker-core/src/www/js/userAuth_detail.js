/**
 * Created by fananyuan on 2016/6/20.
 */
define(['require' ,'ko', 'underscore', 'C', 'jquery'], function (require ,ko, _, C, $) {




   var userAuth_detail = {
        init: function (data) {
            var _this = this,
            //机构详情
             TEM_USERAUTH_DETAIL = _.template($('#tem_userAuth_detail').html()),
                AUTHID = data.authId,
                type = data.type,
                backTo = data.backTo,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO),AUTHID,TEM_USERAUTH_DETAIL);
            _this.bind($('#' + CONTAINERNO),type, backTo);

        },
        render: function (CONTAINER,AUTHID,TEM_USERAUTH_DETAIL) {
            var _this = this;
            $('.show_position_next').show().text('>用户授权详情');
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.QUERYUSERAUTHINFO,
                data: {authId: AUTHID},
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        CONTAINER.html(TEM_USERAUTH_DETAIL(res.resData));
                    } else {

                    }
                }
            });

        },
        bind: function (CONTAINER, type, backTo) {
            var _this = this,
                userAuth_list = require('js/userAuth_list'),
                userAuth_manage = require('js/userAuth_manage');
            //返回
            CONTAINER.on('click', '.userAuth_detail_cancel', function(){
                if(type == '1'){
                    userAuth_list.init(backTo);
                }else if(type == '2'){
                    userAuth_manage.init(backTo);
                }
            });
            CONTAINER.on('click', '.autopower', function(){

                $('.objection_check_mask').fadeIn(200);
                $('.user_power_auto').fadeIn(100);
            });
            //取消
            $('body').on('click', '.close_image', function(){
                $('.objection_check_mask').hide();
                $('.user_power_auto').hide();
            });


        }
    };
    return userAuth_detail;
});
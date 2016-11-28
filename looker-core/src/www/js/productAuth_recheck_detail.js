/**
 * Created by fananyuan on 2016/6/20.
 */
define(['require' ,'ko', 'underscore', 'C', 'jquery'], function (require ,ko, _, C, $) {




   var productAuth_recheck_detail = {
        init: function (data) {
            var _this = this,
            //产品授权复核详情
             TEM_PRODUCTAUTH_RECHECK_DETAIL = _.template($('#tem_productAuth_recheck_detail').html()),
                id = data.id,
                type = data.type,
                backTo = data.backTo,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO), id, TEM_PRODUCTAUTH_RECHECK_DETAIL);
            _this.bind($('#' + CONTAINERNO), type, backTo);

        },
        render: function (CONTAINER, id, TEM_PRODUCTAUTH_RECHECK_DETAIL) {
            var _this = this,
            USERINFO =   C.Utils.data('userInfo') || {},
                roleList = USERINFO.roleList ? USERINFO.roleList.join(',') : '',
                //是否仅仅是查询员
                isCPCXY = roleList.indexOf('CPSQCXY') != -1 && roleList.indexOf('CPSQGLY') == -1,
               //是否仅仅是管理员
                isCPSQGLY = roleList.indexOf('CPSQGLY') != -1 && roleList.indexOf('CPSQCXY') == -1;
            $('.show_position_pre').text('产品授权管理');
            $('.show_position').text('>产品授权详情');
            $('.show_position_next').hide();
            $('#organization_modify_header').show().siblings().hide();
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.PRODUCTAUTHDETAIL,
                data: {id: id},
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS && res.resData) {
                        CONTAINER.html(TEM_PRODUCTAUTH_RECHECK_DETAIL(res.resData.productAuthInfo));
                        if(isCPCXY || isCPSQGLY){
                            $('.productAuth_recheck_detail_pass').hide();
                            $('.productAuth_recheck_detail_reback').hide();
                        }
                    } else {
                        C.UI.msg(res.resMsg);
                    }
                }
            });

        },
        bind: function (CONTAINER, type, backTo) {
            var _this = this,
                productAuth_recheck = require('js/productAuth_recheck'),
                productAuth_list = require('js/productAuth_list');

             //产品复核详情--通过
            CONTAINER.on('click', '.productAuth_recheck_detail_pass', function(){
                var $this = $(this),
                    id = $this.attr('authId'),
                    state = parseInt($this.attr('authS')) + 6;
                C.PageBreak.Loading();
                $.ajax({
                    type: 'get',
                    url: C.Api.UPDATEPRODUCTAUTH,
                    data: {
                        id: id,
                        state: state
                    },
                    success: function (res) {
                        C.PageBreak.stopLoading();
                        if (res.resCode == C.ResCodes.SUCCESS) {
                            C.UI.msg('该产品授权已通过！');
                            if(type == '1'){
                                productAuth_list.init(backTo);
                            }else if(type ==  '2'){
                                productAuth_recheck.init();
                            }
                        } else {
                            C.UI.msg(res.resMsg);
                        }
                    }
                });
            });
            //产品复核详情--驳回
            CONTAINER.on('click', '.productAuth_recheck_detail_reback', function(){
                var $this = $(this),
                    id = $this.attr('authId'),
                    state = parseInt($this.attr('authS')) + 3;
                C.UI.warm({
                    header: '填写驳回理由',
                    content_area: '111',
                    okText: '确定',
                    cancelText: '取消',
                    ok: function (val) {
                        if(val == ''){
                            C.UI.msg('驳回失败, 请填写驳回理由！');
                            return;
                        }
                        C.PageBreak.Loading();
                        $.ajax({
                            type: 'get',
                            url: C.Api.UPDATEPRODUCTAUTH,
                            data: {
                                refuseReason: val,
                                id: id,
                                state: state
                            },
                            success: function (res) {
                                C.PageBreak.stopLoading();
                                if (res.resCode == C.ResCodes.SUCCESS) {
                                    C.UI.msg('驳回理由提交成功');
                                    if(type == '1'){
                                        productAuth_list.init(backTo);
                                    }else if(type ==  '2'){
                                        productAuth_recheck.init();
                                    }
                                } else {
                                    C.UI.msg(res.resMsg);
                                }
                            }
                        });
                    }
                });
            });
            //取消
            CONTAINER.on('click', '.productAuth_recheck_detail_cancel', function(){
                if(type == '1'){
                    productAuth_list.init(backTo);
                }else if(type ==  '2'){
                    productAuth_recheck.init();
                }
            });


        }

    };
    return productAuth_recheck_detail;
});
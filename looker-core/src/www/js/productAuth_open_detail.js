/**
 * Created by fananyuan on 2016/6/20.
 */
define(['require' ,'ko', 'underscore', 'C', 'jquery'], function (require ,ko, _, C, $) {

   var productAuth_open_detail = {
        init: function (data) {
            var _this = this,
            //产品授权复核详情
             TEM_PRODUCTAUTH_OPEN_DETAIL = _.template($('#tem_productAuth_open_detail').html()),
                id = data.id,
                type = data.type,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO), id, TEM_PRODUCTAUTH_OPEN_DETAIL);
            _this.bind($('#' + CONTAINERNO), id, type);

        },
        render: function (CONTAINER, id, TEM_PRODUCTAUTH_OPEN_DETAIL) {
            var _this = this;
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
                        CONTAINER.html(TEM_PRODUCTAUTH_OPEN_DETAIL(res.resData.productAuthInfo));
                    } else {
                        C.UI.msg(res.resMsg);
                    }
                }
            });

        },
        bind: function (CONTAINER, id, type) {
            var _this = this,
                productAuth_open = require('js/productAuth_open'),
                productAuth_list = require('js/productAuth_list');

             //产品复核详情--通过
            CONTAINER.on('click', '.productAuth_open_detail_open', function(){
                var productName = $(this).attr('productName');
                C.UI.warm({
                    header: '确定开通产品授权?',
                    content: '确定开通产品授权后,',
                    content2: '渠道会正式获得此产品的使用权限',
                    okText: '确定',
                    cancelText: '取消',
                    ok: function () {
                        $.ajax({
                            type: 'get',
                            url: C.Api.UPDATEPRODUCTAUTH,
                            data:{
                                id: id,
                                state: '9'
                            },
                            success: function(res){
                                if (res.resCode == C.ResCodes.SUCCESS) {
                                    C.UI.msg(productName + '已开通！');
                                    if(type == '1'){
                                        productAuth_list.init()
                                    }else if(type ==  '2'){
                                        productAuth_open.init();
                                    }
                                }else{
                                    C.UI.msg(res.resMsg);
                                }
                            }
                        });
                    }
                });
            });

            //取消
            CONTAINER.on('click', '.productAuth_open_detail_cancel', function(){
                if(type == '1'){
                    productAuth_list.init()
                }else if(type ==  '2'){
                    productAuth_open.init();
                }

            });


        }

    };
    return productAuth_open_detail;
});
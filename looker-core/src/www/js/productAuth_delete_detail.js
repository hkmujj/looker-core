/**
 * Created by fananyuan on 2016/6/20.
 */
define(['require' ,'ko', 'underscore', 'C', 'jquery'], function (require ,ko, _, C, $) {

   var productAuth_delete_detail = {
        init: function (data) {
            var _this = this,
            //产品授权复核详情
             TEM_PRODUCTAUTH_DELETE_DETAIL = _.template($('#tem_productAuth_delete_detail').html()),
                id = data.id,
                backTo = data.backTo,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO), id, TEM_PRODUCTAUTH_DELETE_DETAIL);
            _this.bind($('#' + CONTAINERNO), id, backTo);

        },
        render: function (CONTAINER, id, TEM_PRODUCTAUTH_DELETE_DETAIL) {
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
                        CONTAINER.html(TEM_PRODUCTAUTH_DELETE_DETAIL(res.resData.productAuthInfo));
                    } else {
                        C.UI.msg(res.resMsg);
                    }
                }
            });

        },
        bind: function (CONTAINER, id, backTo) {
            var _this = this,
                productAuth_list = require('js/productAuth_list');

             //返回
            CONTAINER.on('click', '.productAuth_delete_detail_cancel', function(){
                productAuth_list.init(backTo);
            });




        }

    };
    return productAuth_delete_detail;
});
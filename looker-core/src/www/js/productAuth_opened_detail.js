/**
 * Created by fananyuan on 2016/6/20.
 */
define(['require' ,'ko', 'underscore', 'C', 'jquery', 'js/productAuth_opened_modify'], function (require ,ko, _, C, $, productAuth_opened_modify) {

   var productAuth_opened_detail = {
        init: function (data) {
            var _this = this,
            //产品授权复核详情
             TEM_PRODUCTAUTH_OPENED_DETAIL = _.template($('#tem_productAuth_opened_detail').html()),
                id = data.id,
                backTo = data.backTo,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO), id, TEM_PRODUCTAUTH_OPENED_DETAIL);
            _this.bind($('#' + CONTAINERNO), id, backTo);

        },
        render: function (CONTAINER, id, TEM_PRODUCTAUTH_OPENED_DETAIL) {
            var _this = this,
                USERINFO =   C.Utils.data('userInfo') || {},
                roleList = USERINFO.roleList ? USERINFO.roleList.join(',') : '',
            //是否仅仅是查询员
                isCPCXY = roleList.indexOf('CPSQCXY') != -1 && roleList.indexOf('CPSQGLY') == -1;
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
                        CONTAINER.html(TEM_PRODUCTAUTH_OPENED_DETAIL(res.resData.productAuthInfo));
                        if(isCPCXY){
                            $('.productAuth_opened_detail_modify').hide();
                            $('.productAuth_opened_detail_delete').hide();
                        }
                    } else {
                        C.UI.msg(res.resMsg);
                    }
                }
            });

        },
        bind: function (CONTAINER, id, backTo) {
            var _this = this,
                productAuth_list = require('js/productAuth_list');

            //删除
            CONTAINER.on('click', '.productAuth_opened_detail_delete', function(){
                var $this = $(this),
                    id = $this.attr('authId'),
                    state = $this.attr('state'),
                    productName = $this.attr('productName'),
                    productCode = $this.attr('productCode');
                C.PageBreak.Loading();
                $.ajax({
                    type: 'get',
                    url: C.Api.UPDATEPRODUCTAUTH,
                    data: {id: id, state: '2',productName:productName},
                    success: function(res){
                        C.PageBreak.stopLoading();
                        if (res.resCode == C.ResCodes.SUCCESS) {
                            C.UI.msg('删除已申请成功！');
                            productAuth_list.init(backTo);
                        }
                    }
                });

            });

            //返回
            CONTAINER.on('click', '.productAuth_opened_detail_cancel', function(){
                productAuth_list.init(backTo);
            });

            //修改
            CONTAINER.on('click', '.productAuth_opened_detail_modify', function(){
                productAuth_opened_modify.init({id: id, backTo: backTo, type: '2'});
            });


        }

    };
    return productAuth_opened_detail;
});
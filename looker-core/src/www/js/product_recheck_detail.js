/**
 * Created by fananyuan on 2016/6/20.
 */
define(['require' ,'ko', 'underscore', 'C', 'jquery'], function (require ,ko, _, C, $) {




   var product_recheck_detail = {
        init: function (data) {
            var _this = this,
            //机构详情
             TEM_PRODUCT_RECHECK_DETAIL = _.template($('#tem_product_recheck_detail').html()),
                PRODUCTID = data.productId,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO), PRODUCTID, TEM_PRODUCT_RECHECK_DETAIL);
            _this.bind($('#' + CONTAINERNO));

        },
        render: function (CONTAINER, PRODUCTID, TEM_PRODUCT_RECHECK_DETAIL) {
            var _this = this;
            $('.show_position').text('>产品复核');
            $('.show_position_next').show();
            $('#organization_modify_header').show().siblings().hide();
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.PRODUCT_DETAIL,
                data: {productId: PRODUCTID},
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS && res.resData) {
                        CONTAINER.html(TEM_PRODUCT_RECHECK_DETAIL(res.resData.productInfo));
                    } else {

                    }
                }
            });

        },
        bind: function (CONTAINER) {
            var _this = this,
                product_recheck = require('js/product_recheck');

             //产品复核详情--通过
            CONTAINER.on('click', '.product_recheck_detail_pass', function(){
                C.PageBreak.Loading();
                var productId = $(this).attr('productId');
                $.ajax({
                    type: 'get',
                    url: C.Api.RECHECK_PRODUCT,
                    data: {
                        recheckStatus: 1,
                        productId: productId
                    },
                    success: function (res) {
                        C.PageBreak.stopLoading();
                        if (res.resCode == C.ResCodes.SUCCESS) {
                            C.UI.warm({
                                header: '产品通过复核',
                                content: '产品已通过复核，进入产品列表',
                                okText: '确定',
                                ok: function () {
                                    var recheckStatus = 0;
                                    product_recheck.init(recheckStatus);
                                }
                            });
                        } else {
                            C.UI.msg(res.resMsg);
                        }
                    }
                });
            });
            //产品复核详情--驳回
            CONTAINER.on('click', '.product_recheck_detail_reback', function(){
                var productId = $(this).attr('productId');
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
                            url: C.Api.RECHECK_PRODUCT,
                            data: {
                                refuseReason: val,
                                productId: productId,
                                recheckStatus: 2
                            },
                            success: function (res) {
                                C.PageBreak.stopLoading();
                                if (res.resCode == C.ResCodes.SUCCESS) {
                                    var recheckStatus = 0;
                                    C.UI.msg('驳回理由提交成功');
                                    product_recheck.init(recheckStatus);
                                } else {
                                    C.UI.msg(res.resMsg);
                                }
                            }
                        });
                    }
                });
            });
            //取消
            CONTAINER.on('click', '.product_recheck_detail_prev', function(){
                var recheckStatus = 0;
                product_recheck.init(recheckStatus);
            });


        }

    };
    return product_recheck_detail;
});
/**
 * Created by fananyuan on 2016/6/20.
 */
define(['require' ,'ko', 'underscore', 'C', 'jquery', 'js/product_modify'], function (require ,ko, _, C, $, product_modify) {




   var product_detail = {
        init: function (data) {
            var _this = this,
            //机构详情
             TEM_PRODUCT_DETAIL = _.template($('#tem_product_detail').html()),
                PRODUCTID = data.productId,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO),PRODUCTID,TEM_PRODUCT_DETAIL);
            _this.bind($('#' + CONTAINERNO));

        },
        render: function (CONTAINER,PRODUCTID,TEM_PRODUCT_DETAIL) {
            var _this = this;
            $('.show_position').text('>产品详情');
            //头部样式的切换
            $('#product_detail_header').show().siblings().hide();
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.PRODUCT_DETAIL,
                data: {productId: PRODUCTID},
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        CONTAINER.html(TEM_PRODUCT_DETAIL(res.resData.productInfo));
                    } else {

                    }
                }
            });

        },
        bind: function (CONTAINER) {
            var _this = this,
                product_list = require('js/product_list');


            //点击产品详情 -- 启用 /停用
            CONTAINER.on('click', '.opcl_stop', function () {
                var $this = $(this),
                    productId = $this.attr('productId'),
                    productStatus = $this.attr('productStatus'),
                    data = {
                        productId: productId,
                        productStatus: productStatus
                    };

                _this.productStatusChange(data, function () {
                    $this.hide();
                    $this.siblings('.opcl_open').show();
                    C.UI.msg('产品状态已启用');
                });
            });
            CONTAINER.on('click', '.opcl_open', function () {
                var $this = $(this),
                    productId = $this.attr('productId'),
                    productStatus = $this.attr('productStatus'),
                    data = {
                        productId: productId,
                        productStatus: productStatus
                    };

                //校验产品是否有在使用的
                C.PageBreak.Loading();
                $.ajax({
                    type: 'get',
                    url: C.Api.CHECKPRODUCTUSED,
                    data:{productId: productId},
                    success: function(res){
                        C.PageBreak.stopLoading();
                        if (res.resCode == C.ResCodes.SUCCESS && res.resData){
                            if(res.resData.isAdmin && res.resData.isUsed){
                                C.UI.warm({
                                    header: '确定停用产品吗?',
                                    content: '停用产品将导致渠道不可使用该产品',
                                    okText: '确定',
                                    cancelText: '取消',
                                    ok: function () {
                                        _this.productStatusChange(data, function () {
                                            $this.hide();
                                            $this.siblings('.opcl_stop').show();
                                            C.UI.msg('产品状态已停用');
                                        });
                                    }
                                });
                            }else if(!res.resData.isAdmin && res.resData.isUsed){
                                C.UI.warm({
                                    header: '停用机构失败!',
                                    content: '当前机构下有正在使用的渠道',
                                    content2: '请先手动关闭渠道',
                                    cancelText: '取消'
                                });
                            }else{
                                _this.productStatusChange(data, function () {
                                    $this.hide();
                                    $this.siblings('.opcl_stop').show();
                                    C.UI.msg('产品状态已停用');
                                });
                            }
                        }else{
                            C.UI.msg(res.resMsg)
                        }
                    }
                });
            });
            //返回
            CONTAINER.on('click', '.product_detail_prev', function(){
                var recheckStatuis = 1;
                product_list.init(recheckStatuis);
            });

            //产品详情--修改
            CONTAINER.on('click', '.product_detail_modify', function () {
                var productId = $(this).attr('productId'),
                    data = {productId:productId,type:'2'};
                    product_modify.init(data);
            });
        },
        //机构状态修改接口
        productStatusChange: function(data,cb){
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.PRODUCT_STATUS,
                data: data,
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        cb && cb();
                    } else {
                        C.UI.msg(res.resMsg || '产品更新失败！');
                    }
                }
            });
        }
    };
    return product_detail;
});
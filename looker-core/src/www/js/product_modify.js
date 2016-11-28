/**
 * Created by fananyuan on 2016/6/20.
 */
define(['ko', 'underscore', 'C', 'jquery', 'js/organization_modify'], function (ko, _, C, $, organization_modify) {

   var product_modify = {
        init: function (data) {
            var _this = this,
            //机构详情
              TEM_PRODUCT_MODIFY = _.template($('#tem_product_modify').html()),
                PRODUCTID = data.productId,type = data.type,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO),PRODUCTID,TEM_PRODUCT_MODIFY);
            _this.bind($('#' + CONTAINERNO),type);

        },
        render: function (CONTAINER,PRODUCTID,TEM_PRODUCT_MODIFY) {
            var _this = this;
            $('.show_position').text('>修改产品');
            //头部样式的切换
            $('#organization_modify_header').show().siblings().hide();
            C.PageBreak.Loading();
            $.when(
                $.ajax({type: 'get', url: C.Api.PRODUCT_DETAIL, data: {productId: PRODUCTID}}),
                $.ajax({type:'get', url: C.Api.DICCODES, data: {dicType: 'type,status'}})).
                done(function(res1,res2){
                    C.PageBreak.stopLoading();
               var item = $.extend(res1[0].resData.productInfo, res2[0].resData);
                    CONTAINER.html(TEM_PRODUCT_MODIFY(item));
                    //默认选中产品原始状态
                    $('.product_status [value = '+ item.productStatus +']').attr('selected', true);
                    $('.product_desc').val(item.productDesc);
            });
        },
        bind: function (CONTAINER,type) {
            var _this = this,
                product_list = require('js/product_list'),
                product_detail = require('js/product_detail');
            //点击修改机构里的确认
            CONTAINER.on('click', '.submit_modify_product', function () {
                var $this = $(this),
                    productStatus1 = $this.attr('productStatus'),
                    productStatus2 = $('.product_status').val(),
                    productName = $this.attr('productName'),
                    productId = $this.attr('productId'),
                    productDesc = $('.product_desc').val(),
                    data = {
                        productStatus:productStatus2,
                        productName:productName,
                        productId:productId,
                        productDesc:productDesc,
                        productNameChgFlg: 0
                    };
                if(productStatus1 == '0' && productStatus1 != productStatus2){
                    //校验产品是否有在使用的
                    $.ajax({
                        type: 'get',
                        url: C.Api.CHECKPRODUCTUSED,
                        data:{productId:productId},
                        success: function(res){
                            if (res.resCode == C.ResCodes.SUCCESS && res.resData){
                                if(res.resData.isAdmin && res.resData.isUsed){
                                    C.UI.warm({
                                        header: '确定停用产品吗?',
                                        content: '停用产品将导致渠道不可使用该产品',
                                        okText: '确定',
                                        cancelText: '取消',
                                        ok: function () {
                                            _this.saveInfo(data, function () {
                                                C.UI.msg('产品修改成功');
                                                if(type == '1'){
                                                    product_list.init();
                                                }else if(type == '2'){
                                                    product_detail.init({productId:productId});
                                                }
                                            });
                                        }
                                    });
                                }else if(!res.resData.isAdmin && res.resData.isUsed){
                                    C.UI.warm({
                                        header: '停用产品失败!',
                                        content: '有渠道正在使用当前产品',
                                        content2: '请先手动关闭',
                                        cancelText: '取消'
                                    });
                                }
                            }else{
                                _this.saveInfo(data, function () {
                                    C.UI.msg('产品修改成功');
                                    if(type == '1'){
                                        product_list.init();
                                    }else if(type == '2'){
                                        product_detail.init({productId:productId});
                                    }
                                });
                            }
                        }
                    });
                }else{
                    _this.saveInfo(data, function () {
                        C.UI.msg('产品修改成功');
                        if(type == '1'){
                            product_list.init();
                        }else if(type == '2'){
                            product_detail.init({productId:productId});
                        }
                    });
                }
           });
            //点击修改机构里的取消
            CONTAINER.on('click', '.cancel__modify_product', function () {
                var  productId = $(this).attr('productId'),
                    data = {productId:productId};
                if(type == '1'){
                    product_list.init();
                }else if(type == '2'){
                    product_detail.init(data);
                }
            });

        },
       //机构新增修改接口调用
       saveInfo: function (data, cb) {
           $.ajax({
               type: 'get',
               url: C.Api.PRODUCT_SAVE,
               data: data,
               success: function (res) {
                   if (res.resCode == C.ResCodes.SUCCESS) {
                       cb && cb();
                   } else {
                       C.UI.msg(res.resMsg);
                   }
               }
           });
       }
    };
    return product_modify;
});
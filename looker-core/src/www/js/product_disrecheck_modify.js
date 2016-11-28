/**
 * Created by fananyuan on 2016/6/20.
 */
define(['ko', 'underscore', 'C', 'jquery', 'js/organization_modify'], function (ko, _, C, $, organization_modify) {

   var product_modify = {
        init: function (data) {
            var _this = this,
            //机构详情
              TEM_PRODUCT_DISRECHECK_MODIFY = _.template($('#tem_product_disrecheck_modify').html()),
                PRODUCTID = data.productId,type = data.type,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO),PRODUCTID,TEM_PRODUCT_DISRECHECK_MODIFY);
            _this.bind($('#' + CONTAINERNO),type);

        },
        render: function (CONTAINER,PRODUCTID,TEM_PRODUCT_DISRECHECK_MODIFY) {
            var _this = this;
            $('.show_position').text('>修改产品');
            //头部样式的切换
            $('#organization_modify_header').show().siblings().hide();
            C.PageBreak.Loading();
            $.when(
                $.ajax({type: 'get', url: C.Api.PRODUCT_DETAIL, data: {productId: PRODUCTID}}),
                $.ajax({type:'get', url: C.Api.DICCODES2, data: {dicType: 'type,status'}})).
                done(function(res1,res2){
                    C.PageBreak.stopLoading();
               var item = $.extend(res1[0].resData.productInfo, res2[0].resData);
                    CONTAINER.html(TEM_PRODUCT_DISRECHECK_MODIFY(item));
                    //默认选中产品原始状态
                    $('.product_status [value = '+ item.productStatus +']').attr('selected', true);
                    $('.product_desc').val(item.productDesc);
            }).fail(function(){C.UI.msg('系统忙,请稍后再试！')});
        },
        bind: function (CONTAINER,type) {
            var _this = this,
                product_disrecheck = require('js/product_disrecheck'),
                product_disrecheck_detail = require('js/product_disrecheck_detail');
            //点击修改--确认
            CONTAINER.on('click', '.submit_modify_disrecheck_product', function () {
                var $this = $(this),
                    productStatus1 = $this.attr('productStatus'),
                    productStatus2 = $('.product_status').val(),
                    productName1 = $this.attr('productName'),
                    productName2 = $('.productName').val(),
                    productId = $this.attr('productId'),
                    productDesc = $('.product_desc').val(),
                    productNameChgFlg = productName1 == productName2 ? '0' : '1',
                    data = {
                        productStatus:productStatus2,
                        productName:productName2,
                        productId:productId,
                        productDesc:productDesc,
                        productNameChgFlg:productNameChgFlg,
                        recheckStatus: '0'
                    };
                if(!C.Utils.illegalChar(productName2) || productName2 == '' ){
                    $('.productName_tip').show();
                    return;
                }
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
                                            saveInfo();
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
                                saveInfo();
                            }
                        }
                    });
                }else{
                   saveInfo();
                }

                //保存修改的信息
                function saveInfo(){
                    $('.productName_tip').hide();
                    _this.saveInfo(data, function () {
                        C.UI.msg('产品修改成功');
                        if(type == '1'){
                            var recheckStatus = 2;
                            product_disrecheck.init(recheckStatus);
                        }else if(type == '2'){
                            product_disrecheck_detail.init({productId:productId});
                        }
                    });
                }
            });
            //点击未通过产品里的取消
            CONTAINER.on('click', '.cancle_modify_disrecheck_product', function () {
                var  productId = $(this).attr('productId');
                if(type == '1'){
                    var recheckStatus = 2;
                    product_disrecheck.init(recheckStatus);
                }else if(type == '2'){
                    product_disrecheck_detail.init({productId:productId});
                }
            });

        },
       //修改接口调用
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
define(['ko', 'underscore', 'C', 'jquery',
         'js/product_detail',
          'js/product_list'],
    function (ko, _, C, $,
              product_detail,
              product_list) {
    var product_new,
    //新建机构模板
        TEM_PRODUCT_NEW = _.template($('#tem_product_new').html());

    product_new = {
        init: function () {
            var _this = this,
                CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO));
            _this.bind($('#' + CONTAINERNO));
            window.location.hash = 'product_new';

        },
        render: function (CONTAINER) {
            $('.show_position_pre').text('产品管理');
            $('.show_position').text('>新建产品');
            $('#product_new_header').show().siblings().hide();
            C.PageBreak.Loading();
            $.when(
                $.ajax({type: 'get', url: C.Api.GETPRODUCTCODE, data: {}}),
                $.ajax({type:'get', url: C.Api.DICCODES2, data: {dicType: 'status'}})).
                done(function(res1,res2){
                    C.PageBreak.stopLoading();
                    var item = $.extend(res1[0], res2[0].resData);
                    CONTAINER.html(TEM_PRODUCT_NEW(item));
                });

        },
        bind: function (CONTAINER) {
            var _this = this;
            //确认按钮
            CONTAINER.on('click', '.product_new_submit', function(){

                var productCode = $(this).attr('productCode'),
                    productName = $('.product_new_name').val(),
                    productStatus = $('.product_new_status').val(),
                    productDesc = $('.product_new_desc').val(),
                    data = {
                        productCode:productCode,
                        productName:productName,
                        productStatus:productStatus,
                        productDesc:productDesc
                    };
                if(productName == '' || !C.Utils.illegalChar(productName)){
                    $('.product_new_name_tip').show();
                    return;
                }else{
                    $('.product_new_name_tip').hide();
                }
                C.PageBreak.Loading();
                $.ajax({
                    type:'get',
                    url: C.Api.ADD_PRODUCT,
                    data:data,
                    success:function(res){
                        C.PageBreak.stopLoading();
                        if (res.resCode == C.ResCodes.SUCCESS) {
                            var data = {productId:res.resData};
                            product_list.init('1');
                        }else{
                            C.UI.msg(res.resMsg);
                        }
                    }
                });
            });
            CONTAINER.on('click', '.product_new_cancel', function(){
                product_list.init();
            });
            CONTAINER.on('focus', 'input', function(){
                $('.tips').hide();
            });
        }
    };
    return product_new;
});
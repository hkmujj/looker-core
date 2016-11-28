/**
 * Created by fananyuan on 2016/6/20.
 */
define(['require' ,'ko', 'underscore', 'C', 'jquery',
    'js/product_list',
    'js/product_disrecheck_modify'
], function (require ,ko, _, C, $,
             product_list,
             product_disrecheck_modify) {




   var product_recheck_detail = {
        init: function (data) {
            var _this = this,
            //未通过产品详情
             TEM_PRODUCT_DISRECHECK_DETAIL = _.template($('#tem_product_disrecheck_detail').html()),
                PRODUCTID = data.productId,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO), PRODUCTID, TEM_PRODUCT_DISRECHECK_DETAIL);
            _this.bind($('#' + CONTAINERNO));

        },
        render: function (CONTAINER, PRODUCTID, TEM_PRODUCT_DISRECHECK_DETAIL) {
            var _this = this;
            $('.show_position').text('>产品复核');
            $('.show_position_next').show().text('>未通过产品详情');
            $('#organization_modify_header').show().siblings().hide();
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.PRODUCT_DETAIL,
                data: {productId: PRODUCTID},
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        CONTAINER.html(TEM_PRODUCT_DISRECHECK_DETAIL(res.resData.productInfo));
                    } else {

                    }
                }
            });

        },
        bind: function (CONTAINER) {
            var _this = this,
                product_disrecheck = require('js/product_disrecheck');

             //未通过产品详情--修改
            CONTAINER.on('click', '.product_disrecheck_modify', function(){
                var productId = $(this).attr('productId'),
                     data = {productId:productId,type:'2'};
                product_disrecheck_modify.init(data);
            });

            //取消
            CONTAINER.on('click', '.product_disrecheck_detail_prev', function(){
                var recheckStatuis = 2;
                product_disrecheck.init(recheckStatuis);
            });


        }

    };
    return product_recheck_detail;
});
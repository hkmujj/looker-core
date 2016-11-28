/**
 * Created by fananyuan on 2016/6/20.
 */
define(['ko', 'underscore', 'C', 'jquery', 'layer', 'js/product_recheck_detail'], function (ko, _, C, $, layer, product_recheck_detail) {
    var product_recheck,
    //产品复核主模板
        TEM_PRODUCT_RECHECK = _.template($('#tem_product_recheck').html()),
    //产品复核表单
        TEM_PRODUCT_RECHECK_TABLE = _.template($('#tem_product_recheck_table').html()),
        URL = C.Api.PRODUCT_LIST;

    product_recheck = {
        init: function (recheckStatuis) {
            var _this = this,
                recheckStatuis = recheckStatuis,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO),recheckStatuis);
            _this.bind($('#' + CONTAINERNO),recheckStatuis);
            window.location.hash = 'product_recheck';
        },
        render: function (CONTAINER,recheckStatuis) {
            var _this = this;
            $('.show_position_pre').text('产品管理');
            $('.show_position').text('>产品复核');
            $('#organization_modify_header').show().siblings().hide();
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.DICCODES2,
                data: {dicType: 'type,status'},
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        CONTAINER.html(TEM_PRODUCT_RECHECK(res.resData));
                        C.PageBreak.table({
                            //表格内容包裹层
                            $tablebox: $('.product_recheck_table_box'),
                            //todo
                            headcontent: [{name: '产品代码', icon: 'iconfont sort', order_by: 'product_Code'}, {name: '产品名称', order_by: ''},
                                          {name: '产品状态', icon: '', order_by: ''}, {name: '创建时间', icon: 'iconfont sort', order_by: 'create_Time'},
                                          {name: '产品描述', icon: '', order_by: ''}, {name: '操作', icon: '', order_by: ''}],
                            //编译后的表单
                            tem: TEM_PRODUCT_RECHECK_TABLE,
                            //当前页
                            cindex: '1',
                            pageSize: '10',
                            url: URL,
                            //向后端传递的附加参数
                            parm: {
                                totalCount: 0,
                                recheckStatus:recheckStatuis
                            }
                        });
                    }
                }
            });
        },
        bind: function (CONTAINER,recheckStatuis) {
            var _this = this,zindex = 100;
            //查询按钮
            CONTAINER.on('click', '.product_recheck_search', function () {
                var productCode = $('.productCode').val(),
                    productName = $('.productName').val(),
                    productStatus = $('.product_recheck_status').val();
                C.PageBreak.table({
                    //表格内容包裹层
                    $tablebox: $('.product_recheck_table_box'),
                    //todo
                    headcontent: [{name: '产品代码', icon: 'iconfont sort', order_by: 'product_Code'}, {name: '产品名称', order_by: ''},
                        {name: '产品状态', icon: '', order_by: ''}, {name: '创建时间', icon: '', order_by: ''},
                        {name: '产品描述', icon: '', order_by: ''}, {name: '操作', icon: '', order_by: ''}],
                    //编译后的表单
                    tem: TEM_PRODUCT_RECHECK_TABLE,
                    //当前页
                    cindex: '1',
                    pageSize: '10',
                    url: URL,
                    parm: {
                        productCode: productCode,
                        productName: productName,
                        productStatus:productStatus,
                        totalCount: 0,
                        recheckStatus: recheckStatuis
                    }
                });
            });
           //重置按钮
            CONTAINER.on('click', '.product_list_reset', function () {
                var selectDom = $('.secondtclm select option[value=""]');
                $('.secondtclm input').val('');
                selectDom.attr('selected', true);
                selectDom.removeAttr('selected');
            });

            //产品复核--点击复核
            CONTAINER.on('click', '.product_table_recheck', function () {

                var productId = $(this).attr('productId'),
                data = {productId:productId};
                product_recheck_detail.init(data);

            });

            //tips
            CONTAINER.on('mouseover', '.width15', function(){
               var self = $(this),text = self.text();
                layer.tips(text, self, {
                    tips: [1, '#353A52'],
                    time: 1000

                });
            });

        }
    };
    return product_recheck;
});
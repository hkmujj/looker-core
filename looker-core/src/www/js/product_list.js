/**
 * Created by fananyuan on 2016/6/20.
 */
define(['ko', 'underscore', 'C', 'jquery', 'layer','js/product_detail', 'js/product_modify'], function (ko, _, C, $, layer, product_detail, product_modify) {
    var product_list,
    //产品查询主模板
        TEM_PRODUCT_LIST = _.template($('#tem_product_list').html()),
    //产品查询表单
        TEM_PRODUCT_LIST_TABLE = _.template($('#tem_product_list_table').html()),
        URL = C.Api.PRODUCT_LIST;

    product_list = {
        init: function (recheckStatuis) {
            var _this = this,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO),recheckStatuis);
            _this.bind($('#' + CONTAINERNO), recheckStatuis);
            window.location.hash = 'product_list';

        },
        render: function (CONTAINER, recheckStatuis) {
            var _this = this;
            $('.show_position_pre').text('产品管理');
            $('.show_position').text('>产品查询');
            $('#product_list_header').show().siblings().hide();
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.DICCODES2,
                data: {dicType: 'status'},
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        CONTAINER.html(TEM_PRODUCT_LIST(res.resData));
                        C.PageBreak.table({
                            //表格内容包裹层
                            $tablebox: $('.product_list_table_box'),
                            headcontent: [{name: '产品代码', icon: 'iconfont sort', order_by: 'product_Code'}, {name: '产品名称', icon: '', order_by: ''},
                                          {name: '产品状态', icon: '', order_by: ''}, {name: '创建时间', icon: 'iconfont sort', order_by: 'create_Time'},
                                          {name: '产品描述', icon: '', order_by: ''}, {name: '操作', icon: '', order_by: ''}],
                            //编译后的表单
                            tem: TEM_PRODUCT_LIST_TABLE,
                            //当前页
                            cindex: '1',
                            pageSize: '10',
                            url: URL,
                            //向后端传递的附加参数
                            parm: {
                                totalCount: 0,
                                recheckStatus: recheckStatuis
                            }
                        });
                    }
                }
            });
        },
        bind: function (CONTAINER, recheckStatuis) {
            var _this = this,zindex = 100;
            //查询按钮
            CONTAINER.on('click', '.product_list_search', function () {
                var productCode = $('.productCode').val(),
                    productName = $('.productName').val(),
                    productStatus = $('.product_list_status').val();
                C.PageBreak.table({
                    //表格内容包裹层
                    $tablebox: $('.product_list_table_box'),
                    headcontent: [{name: '产品代码', icon: 'iconfont sort', order_by: 'product_Code'}, {name: '产品名称', icon: 'iconfont sort', order_by: 'product_Name'},
                        {name: '产品状态', icon: '', order_by: ''}, {name: '创建时间', icon: 'iconfont sort', order_by: 'create_Time'},
                        {name: '产品描述', icon: '', order_by: ''}, {name: '操作', icon: '', order_by: ''}],
                    //编译后的表单
                    tem: TEM_PRODUCT_LIST_TABLE,
                    //当前页
                    cindex: '1',
                    pageSize: '10',
                    url: URL,
                    parm: {
                        productCode: productCode,
                        productName: productName,
                        productStatus: productStatus,
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

            //产品列表--点击详情
            CONTAINER.on('click', '.product_detail', function () {

                var productId = $(this).attr('productId'),
                data = {productId:productId};
                product_detail.init(data);

            });
           //产品列表/点击修改
            CONTAINER.on('click', '.product_modify', function () {
                var productId = $(this).attr('productId'),
                    data = {productId: productId,type: '1'};
                    product_modify.init(data);
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
    return product_list;
});
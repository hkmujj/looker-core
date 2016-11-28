
define(['ko', 'underscore', 'C', 'jquery', 'layer',
    'js/product_disrecheck_detail',
    'js/product_disrecheck_modify'],
    function (ko, _, C, $, layer,
              product_disrecheck_detail,
              product_disrecheck_modify) {
    var product_disrecheck,
    //产品复核主模板
        TEM_PRODUCT_DISRECHECK = _.template($('#tem_product_disrecheck').html()),
    //产品复核表单
        TEM_PRODUCT_DISRECHECK_TABLE = _.template($('#tem_product_disrecheck_table').html()),
        URL = C.Api.PRODUCT_LIST;

    product_disrecheck = {
        init: function (recheckStatuis) {
            var _this = this,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO), recheckStatuis);
            _this.bind($('#' + CONTAINERNO), recheckStatuis);
            window.location.hash = 'product_disrecheck';
        },
        render: function (CONTAINER, recheckStatuis) {
            var _this = this;
            $('.show_position_pre').text('产品管理');
            $('.show_position').text('>产品复核');
            $('.show_position_next').hide();
            $('#organization_modify_header').show().siblings().hide();
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.DICCODES2,
                data: {dicType: 'type,status'},
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        CONTAINER.html(TEM_PRODUCT_DISRECHECK(res.resData));
                        C.PageBreak.table({
                            //表格内容包裹层
                            $tablebox: $('.product_disrecheck_table_box'),
                            headcontent: [{name: '产品代码', icon: 'iconfont sort', order_by: 'product_Code'}, {name: '产品名称', icon: 'iconfont sort', order_by: 'product_Name'},
                                          {name: '创建时间', icon: 'iconfont sort', order_by: 'create_Time'}, {name: '产品描述', icon: '', order_by: ''},
                                          {name: '驳回理由', icon: '', order_by: ''}, {name: '操作', icon: '', order_by: ''}],
                            //编译后的表单
                            tem: TEM_PRODUCT_DISRECHECK_TABLE,
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
            CONTAINER.on('click', '.product_disrecheck_search', function () {
                var productCode = $('.productCode').val(),
                    productName = $('.productName').val();
                C.PageBreak.table({
                    //表格内容包裹层
                    $tablebox: $('.product_disrecheck_table_box'),
                    headcontent: [{name: '产品代码', icon: 'iconfont sort', order_by: 'product_Code'}, {name: '产品名称', icon: 'iconfont sort', order_by: 'product_Name'},
                        {name: '创建时间', icon: 'iconfont sort', order_by: 'create_Time'}, {name: '产品描述', icon: '', order_by: ''},
                        {name: '驳回理由', icon: '', order_by: ''}, {name: '操作', icon: '', order_by: ''}],
                    //编译后的表单
                    tem: TEM_PRODUCT_DISRECHECK_TABLE,
                    //当前页
                    cindex: '1',
                    pageSize: '10',
                    url: URL,
                    parm: {
                        productCode: productCode,
                        productName: productName,
                        totalCount: 0,
                        recheckStatus: recheckStatuis
                    }
                });
            });
           //重置按钮
            CONTAINER.on('click', '.product_disrecheck_reset', function () {
                $('.productCode').val('');
                $('.productName').val('');
            });

            //未通过复核，点击详情
            CONTAINER.on('click', '.product_disrecheck_detail', function () {

                var productId = $(this).attr('productId'),
                data = {productId:productId};
                product_disrecheck_detail.init(data);

            });
           //未通过复核，点击修改
            CONTAINER.on('click', '.product_disrecheck_modify', function(){
                var productId = $(this).attr('productId'),
                    data = {productId:productId,type:1};
                   product_disrecheck_modify.init(data);
            });
            //tips
            CONTAINER.on('mouseover', '.width15', function(){
               var self = $(this),text = self.text();
                layer.tips(text, self, {
                    tips: [1, '#353A52']

                });
            });
            CONTAINER.on('mouseover', '.width152', function(){
                var self = $(this),text = self.text();
                layer.tips(text, self, {
                    tips: [1, '#353A52'],
                    time: 1000

                });
            });

        }
    };
    return product_disrecheck;
});
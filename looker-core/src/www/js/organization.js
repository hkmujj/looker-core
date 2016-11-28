/**
 * Created by fananyuan on 2016/6/20.
 */
define(['ko', 'underscore', 'C', 'jquery', 'js/organization_detail', 'js/organization_modify'], function (ko, _, C, $, organization_detail, organization_modify) {
    var organization,
    //机构管理模板
        TEM_ORGANIZATION = _.template($('#tem_organization').html()),
    //机构查询表单
        TEM_ORGANIZATION_TABLE = _.template($('#tem_organization_table').html()),
        URL = C.Api.ORGANIZITION;

    organization = {
        init: function () {
            var _this = this,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO));
            _this.bind($('#' + CONTAINERNO));
            window.location.hash = 'organization';
        },
        render: function (CONTAINER) {
            var _this = this;
            $('.show_position_pre').text('机构管理');
            $('.show_position').text('>机构查询');
            $('#organization_search_header').show().siblings().hide();
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.DICCODES,
                data: {dicType: 'type,status'},
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        CONTAINER.html(TEM_ORGANIZATION(res.resData));
                        C.PageBreak.table({
                            //表格内容包裹层
                            $tablebox: $('.organization_table_box'),
                            headcontent: [{name: '机构代码', icon: 'iconfont sort', order_by: 'org_Code'}, {
                                name: '机构名称',
                                icon: '',
                                order_by: ''
                            },
                                {name: '机构类型', icon: '', order_by: ''}, {
                                    name: '联系人',
                                    icon: '',
                                    order_by: ''
                                }, {name: '联系电话', icon: 'iconfont sort', order_by: 'org_Phone'},
                                {name: '机构状态', icon: '', order_by: ''}, {name: '操作', icon: '', order_by: ''}],
                            //编译后的表单
                            tem: TEM_ORGANIZATION_TABLE,
                            //当前页
                            cindex: '1',
                            pageSize: '10',
                            url: URL,
                            //向后端传递的附加参数
                            parm: {
                                totalCount: 0
                            }
                        });
                    }
                }
            });
        },
        bind: function (CONTAINER) {
            var _this = this;
            //查询按钮
            CONTAINER.on('click', '.organizition_search', function () {

                var orgCode = $('.orgCode').val(),
                    orgName = $('.orgName').val(),
                    orgStatus = $('.orgStatus').val(),
                    orgType = $('.orgType').val();
                C.PageBreak.table({
                    //表格内容包裹层
                    $tablebox: $('.organization_table_box'),
                    headcontent: [{name: '机构代码', icon: 'iconfont sort', order_by: 'org_Code'}, {
                        name: '机构名称',
                        icon: '',
                        order_by: ''
                    },
                        {name: '机构类型', icon: '', order_by: ''}, {
                            name: '联系人',
                            icon: 'iconfont sort',
                            order_by: 'org_Atten'
                        }, {name: '联系电话', icon: 'iconfont sort', order_by: 'org_Phone'},
                        {name: '机构状态', icon: '', order_by: ''}, {name: '操作', icon: '', order_by: ''}],
                    //编译后的表单
                    tem: TEM_ORGANIZATION_TABLE,
                    //当前页
                    cindex: '1',
                    pageSize: '10',
                    url: URL,
                    parm: {
                        orgCode: orgCode,
                        orgName: orgName,
                        orgStatus: orgStatus,
                        orgType: orgType,
                        totalCount: 0
                    }
                });
            });
            //重置按钮
            CONTAINER.on('click', '.organizition_reset', function () {
                var selectDom = $('.secondtclm select option[value=""]');
                $('.secondtclm input').val('');
                selectDom.removeAttr('selected');
                selectDom.attr('selected', true);
                selectDom.removeAttr('selected');

            });

            //点击详情按钮
            CONTAINER.on('click', '.detail', function () {
                var orgCode = $(this).attr('orgCode'),
                data = {orgCode:orgCode};
                organization_detail.init(data);
                window.location.hash= 'organization_detail';
            });
           //机构列表/点击修改机构
            CONTAINER.on('click', '.org_modify', function () {
                var orgCode = $(this).attr('orgCode'),
                    data = {orgCode:orgCode,type:'1'};
                organization_modify.init(data);
                window.location.hash= 'organization_modify';
            });
        }
    };
    return organization;
});
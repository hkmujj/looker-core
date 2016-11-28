/**
 * Created by fananyuan on 2016/6/20.
 */
define(['require', 'ko', 'underscore', 'C', 'jquery', 'js/organization_modify'], function (require, ko, _, C, $, organization_modify) {




   var organization_detail = {
        init: function (data) {
            var _this = this,
            //机构详情
             TEM_ORGANIZATION_DETAIL = _.template($('#tem_organization_detail').html()),
                ORGCODE = data.orgCode,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO),ORGCODE,TEM_ORGANIZATION_DETAIL);
            _this.bind($('#' + CONTAINERNO));
            window.location.hash= 'organization_detail';
        },
        render: function (CONTAINER,ORGCODE,TEM_ORGANIZATION_DETAIL) {
            var _this = this;
            $('.show_position').text('>新建机构');
            //头部样式的切换
            $('#organization_detail_header').show().siblings().hide();
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.MODIFY,
                data: {orgCode: ORGCODE},
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        CONTAINER.html(TEM_ORGANIZATION_DETAIL(res.resData.organizition));
                    } else {

                    }
                }
            });

        },
        bind: function (CONTAINER) {
            var _this = this,
                organization = require('js/organization');

            //点击机构详情---重置密码
            CONTAINER.on('click', '.detail_modify', function () {
                var orgCode = $(this).attr('orgCode');
                C.UI.warm({
                    header: '确认重置密码吗?',
                    content: '重置密码会将机构密码重置为原始密码',
                    content2: '机构之前设定的密码将失效',
                    okText: '确定',
                    cancelText: '取消',
                    ok: function () {
                        C.PageBreak.Loading();
                        $.ajax({
                            type: 'get',
                            url: C.Api.RESTPWD,
                            data: {orgCode: orgCode},
                            success: function (res) {
                                if (res.resCode == C.ResCodes.SUCCESS) {
                                    C.PageBreak.stopLoading();
                                    C.UI.warm({
                                        header: '密码重置成功',
                                        content: '已将密码重置为'+ res.resData.orgPassword,
                                        okText: '确定',
                                        ok: function () {

                                        }
                                    });
                                }
                            }
                        });
                    }
                });
            });
            //点击机构详情 -- 启用 /停用
            CONTAINER.on('click', '.opcl_stop', function () {
                var $this = $(this),
                    orgId = $this.attr('orgId'),
                    orgCode = $this.attr('orgCode'),
                    orgStatus = $this.attr('orgStatus'),
                    data = {
                        orgId: orgId,
                        orgCode: orgCode,
                        orgStatus: orgStatus
                    };

                _this.orgstatuschange(data, function () {
                    $this.hide();
                    $this.siblings('.opcl_open').show();
                    C.UI.msg('机构状态已启用');
                });
            });
            CONTAINER.on('click', '.opcl_open', function () {
                var $this = $(this),
                    orgId = $this.attr('orgId'),
                    orgCode = $this.attr('orgCode'),
                    orgStatus = $this.attr('orgStatus'),
                    data = {
                        orgId: orgId,
                        orgCode: orgCode,
                        orgStatus: orgStatus
                    };
                //校验机构下渠道是否有在使用的
                C.PageBreak.Loading();
                $.ajax({
                    type: 'get',
                    url: C.Api.CHANNELISUSED,
                    data:{orgCode:orgCode},
                    success: function(res){
                        C.PageBreak.stopLoading();
                        if (res.resCode == C.ResCodes.SUCCESS && res.resData){
                            if(res.resData.isAdmin && res.resData.isUsed){
                                C.UI.warm({
                                    header: '确定停用机构吗?',
                                    content: '当前机构下有正在使用的渠道',
                                    content2: '停用机构将导致渠道不可用',
                                    okText: '确定',
                                    cancelText: '取消',
                                    ok: function () {

                                        _this.orgstatuschange(data, function () {
                                            $this.hide();
                                            $this.siblings('.opcl_stop').show();
                                            C.UI.msg('机构状态已停用');
                                        });
                                    }
                                });
                            }else if(!res.resData.isAdmin && res.resData.isUsed){
                                C.UI.warm({
                                    header: '停用机构失败!',
                                    content: '当前机构下有正在使用的渠道',
                                    content2: '请先手动关闭渠道',
                                    okText: '确定'
                                });
                            }else{
                                _this.orgstatuschange(data, function () {
                                    $this.hide();
                                    $this.siblings('.opcl_stop').show();
                                    C.UI.msg('机构状态已停用');
                                });
                            }
                        }else{
                            C.UI.msg(res.resMsg)
                        }
                    }
                });

            });
            //机构详情--修改机构
            CONTAINER.on('click', '.org_detail_modify', function () {
                var orgCode = $(this).attr('orgCode'),
                    data = {orgCode:orgCode,type:'2'};
                organization_modify.init(data);
                window.location.hash= 'organization_modify';
            });

            if(window.addEventListener){
                window.addEventListener('hashchange',routerChange,false);
            }else{
                window.attachEvent("onhashchange", routerChange);
            }

            function routerChange(){
                var hash = window.location.hash;
                switch (hash){

                    case '#organization_modify':
                        CONTAINER.find('.org_detail_modify').trigger('click');
                        break;
                }
            }
        },
        //机构状态修改接口
        orgstatuschange: function(data,cb){
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.ORGSTATUSCHANGE,
                data: data,
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        cb && cb();
                    } else {
                        C.UI.msg(res.resMsg)
                    }
                },
                error: function(){

                }
            });
        }
    };
    return organization_detail;
});
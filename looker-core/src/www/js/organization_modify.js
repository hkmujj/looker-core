/**
 * Created by fananyuan on 2016/6/20.
 */
define(['require','ko', 'underscore', 'C', 'jquery'], function (require,ko, _, C, $) {
   var channel_list_modify = {
        init: function (data) {
            var _this = this,
                TEM_ORGANIZATION_MODIFY = _.template($('#tem_organization_modify').html()),
                ORGCODE = data.orgCode,type = data.type;
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO), TEM_ORGANIZATION_MODIFY, ORGCODE);
            _this.bind($('#' + CONTAINERNO),type);

        },
        render: function (CONTAINER, TEM_ORGANIZATION_MODIFY, ORGCODE) {
            var _this = this;
            $('.show_position').text('>修改机构');
            //头部样式的切换
            $('#organization_modify_header').show().siblings().hide();
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.DICCODES,
                data: {dicType: 'type,status'},
                success: function (res1) {
                    if (res1.resCode == C.ResCodes.SUCCESS) {
                        C.PageBreak.stopLoading();
                        $.ajax({
                            type: 'get',
                            url: C.Api.MODIFY,
                            data: {orgCode: ORGCODE},
                            success: function (res2) {
                                if (res2.resCode == C.ResCodes.SUCCESS) {
                                    var item = $.extend(res1.resData, res2.resData.organizition);
                                    CONTAINER.html(TEM_ORGANIZATION_MODIFY(item));
                                    //默认选中产品原始状态
                                    $('.modify_org_status [value = '+ item.orgStatus +']').attr('selected', true);
                                    $('.modify_org_type [value = '+ item.orgType +']').attr('selected', true);
                                    $('.modify_org_desc').val(item.orgDesc);
                                } else {
                                    C.UI.msg(res2.resMsg);
                                }
                            }
                        });
                    } else {
                        C.UI.msg(res1.resMsg);
                    }
                }
            });

        },
        bind: function (CONTAINER,type) {

            var _this = this,
                organazition = require('js/organization'),
                organization_detail = require('js/organization_detail');
            //点击修改机构里的确认
            CONTAINER.on('click', '.submit_modify_org', function () {
                if(!_this.isValidator()){
                    return
                }
                var $this = $(this),
                    orgId = $this.attr('orgId'),
                    orgCode = $this.attr('orgCode'),
                    orgName = $this.attr('orgName'),
                    orgUserName = $this.attr('orgUserName'),
                    orgStatus1 = $(this).attr('orgStatus'),
                    orgStatus2 = $('.modify_org_status').val(),
                    orgType = $('.modify_org_type').val(),
                    orgAtten = $('.modify_org_user').val(),
                    orgPhone = $('.modify_org_phone').val(),
                    orgEmail = $('.modify_org_email').val(),
                    orgDesc = $('.modify_org_desc').val(),
                    data = {
                        orgId: orgId,
                        orgCode: orgCode,
                        orgName: orgName,
                        orgUserName: orgUserName,
                        orgStatus: orgStatus2,
                        orgType: orgType,
                        orgAtten: orgAtten,
                        orgPhone: orgPhone,
                        orgEmail: orgEmail,
                        orgDesc: orgDesc
                    };

                if(orgStatus1 == '0' && orgStatus1 != orgStatus2){
                    //校验机构下渠道是否有在使用的
                    $.ajax({
                        type: 'get',
                        url: C.Api.CHANNELISUSED,
                        data:{orgCode:orgCode},
                        success: function(res){
                            if (res.resCode == C.ResCodes.SUCCESS && res.resData){
                                if(res.resData.isAdmin && res.resData.isUsed){
                                    C.UI.warm({
                                        header: '确定停用机构吗?',
                                        content: '当前机构下有正在使用的渠道',
                                        content2: '停用机构将导致起到不可用',
                                        okText: '确定',
                                        cancelText: '取消',
                                        ok: function () {
                                           saveInfo();
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
                                   saveInfo();
                                }
                            }else{
                                C.UI.msg(res.resMsg)
                            }
                        }
                    });
                }else{
                    saveInfo();
                }
                //保存信息接口
                function saveInfo(){
                    _this.saveInfo(data, function () {
                        C.UI.msg('机构修改成功');
                        if(type == '1'){
                            organazition.init();
                        }else if(type == '2'){
                            organization_detail.init({orgCode:orgCode});
                        }
                    });
                }

            });
            //点击修改机构里的取消
            CONTAINER.on('click', '.cancel__modify_org', function () {
                var  orgCode = $(this).attr('orgCode');
                if(type == '1'){
                    organazition.init();
                }else if(type == '2'){
                    organization_detail.init({orgCode:orgCode});
                }
            });

            if(window.addEventListener){
                window.addEventListener('hashchange',routerChange,false);
            }else{
                window.attachEvent("onhashchange", routerChange);
            }

            function routerChange(){
                var hash = window.location.hash;
                switch (hash){

                    case '#organazition':
                        CONTAINER.find('.cancel__modify_org').trigger('click');
                        break;
                    case '#organization_detail':
                        CONTAINER.find('.cancel__modify_org').trigger('click');
                        break;
                }
            }

        },
        //机构新增修改接口调用
        saveInfo: function (data, cb) {
            $.ajax({
                type: 'get',
                url: C.Api.ORGSAVE,
                data: data,
                success: function (res) {
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        cb && cb();
                    } else {

                    }
                }
            });
        },
       isValidator: function(){
           var orgPhnum = $('.new_org_phone').val(),
               orgEmail = $('.new_orgEmail').val(),
               new_org_concat = $('.modify_org_user').val();

           if(!C.Utils.isPhoneNum(orgPhnum)){
               $('.new_org_phone_tip').show();
               return false;
           }else{
               $('.new_org_phone_tip').hide();
           }

           if(orgEmail && !C.Utils.isEmail(orgEmail)){
               $('.new_org_email_tip').show();
               return false;
           }else{
               $('.new_org_email_tip').hide();
           }

           if(new_org_concat && !C.Utils.isName(new_org_concat)){
               $('.new_org_concat_tip').show();
               return false;
           }else{
               $('.new_org_concat_tip').hide();
           }
           return true;
       }
    };
    return channel_list_modify;
});
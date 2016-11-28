define(['ko', 'underscore', 'C', 'jquery', 'js/organization_detail', 'js/organization'], function (ko, _, C, $, organization_detail,organization) {
    var organization_new,
    //新建机构模板
        TEM_ORGANIZATION_NEW = _.template($('#tem_organization_new').html());

    organization_new = {
        init: function () {
            var _this = this,
                CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO));
            _this.bind($('#' + CONTAINERNO));
            window.location.hash= 'organization_new';
        },
        render: function (CONTAINER) {
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.DICCODES,
                data: {dicType: 'type,status'},
                success: function (res1) {
                    C.PageBreak.stopLoading();
                    if (res1.resCode == C.ResCodes.SUCCESS) {
                        $.ajax({
                            type: 'get',
                            url: C.Api.GETORGCODE,
                            data:{},
                            success: function(res2){
                                if (res1.resCode == C.ResCodes.SUCCESS) {
                                    var item = $.extend(res1.resData,{orgCode:res2.resData.orgCode});
                                    CONTAINER.html(TEM_ORGANIZATION_NEW(item));
                                }
                            }
                        });

                    }else{
                        C.UI.msg(res1.resMsg);
                    }
                }
            });

        },
        bind: function (CONTAINER) {
            var _this = this,orgCode;


            //新建机构确认按钮
            CONTAINER.on('click', '.new_org_submit', function(){
                if(!_this.isValidator()){
                    return;
                }
                C.PageBreak.Loading();
                 orgCode = $(this).attr('orgCode');
                var orgName = $('.new_orgName').val(),
                    orgStatus = $('.new_org_status').val(),
                    orgType = $('.new_org_type').val(),
                    orgUserName = $('.new_orgUserName').val(),
                    orgAtten = $('.new_org_concat').val(),
                    orgPhone = $('.new_org_phone').val(),
                    orgEmail = $('.new_orgEmail').val(),
                    orgDesc = $('.new_org_desc').val(),
                    data = {
                        orgCode:orgCode,
                        orgName:orgName,
                        orgStatus:orgStatus,
                        orgType:orgType,
                        orgUserName:orgUserName,
                        orgAtten:orgAtten,
                        orgPhone:orgPhone,
                        orgEmail:orgEmail,
                        orgDesc:orgDesc
                    };
                $.ajax({
                    type:'get',
                    url: C.Api.ORGSAVE,
                    data:data,
                    success:function(res){
                        C.PageBreak.stopLoading();
                        if (res.resCode == C.ResCodes.SUCCESS) {
                            C.UI.msg('新建机构保存成功');
                            organization.init();
                        }else if(res.resCode == '-1001'){
                            C.UI.msg(res.resMsg);
                        }else if(res.resCode == '-1002'){
                            $('.new_org_uesrName').show();
                        }
                    }
                });
            });
            CONTAINER.on('click', '.new_org_cancel', function(){
                organization.init();
            });

            CONTAINER.on('input', 'input', function(){
                $('.tips').hide();
            });

        },
        //输入框校验
        isValidator: function(){
            var orgname = $('.new_orgName').val(),
                orgPhnum = $('.new_org_phone').val(),
                orgEmail = $('.new_orgEmail').val(),
                orgusername = $('.new_orgUserName').val(),
                new_org_concat = $('.new_org_concat').val();
            if( !C.Utils.illegalChar(orgname) || orgname == ''){
                $('.new_org_name_tip').show();
                return false;
            }else{
                $('.new_org_name_tip').hide();
            }
            if(new_org_concat && !C.Utils.isName(new_org_concat)){
                $('.new_org_concat_tip').show();
                return false;
            }else{
                $('.new_org_concat_tip').hide();
            }
            if( !C.Utils.isPhoneNum(orgPhnum)){
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

            if(orgusername == ''){
                $('.new_org_uesrName_tip').show();
                return false;
            }else{
                $('.new_org_uesrName_tip').hide();
            }
            return true;
        }
    };
    return organization_new;
});
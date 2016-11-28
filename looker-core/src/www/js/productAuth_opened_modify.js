define(['require', 'ko', 'underscore', 'C', 'jquery'], function (require, ko, _, C, $) {
    var productAuth_opened_modify,
    //产品授权修改 -- 已开通
        TEM_PRODUCTAUTH_OPENED_MODIFY = _.template($('#tem_productAuth_opened_modify').html());

    productAuth_opened_modify = {
        init: function (data) {
            var _this = this,
                CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO), data);
            _this.bind($('#' + CONTAINERNO), data);
            window.location.hash = 'productAuth_opened_modify';

        },
        render: function (CONTAINER, data) {
            var _this = this;
            $('.show_position_pre').text('产品授权管理');
            $('.show_position').text('>修改产品授权');
            $('.show_position_next').hide();
            $('#organization_modify_header').show().siblings().hide();
            $.when(
                $.ajax({type: 'get', url: C.Api.PRODUCTAUTHDETAIL, data: {id: data.id}}),
                $.ajax({type: 'get', url: C.Api.DICCODES, data: {dicType: 'auth_status'}})
            ).done(function(res1, res2){
                    var item = $.extend(res1[0].resData.productAuthInfo,res2[0].resData);
                    CONTAINER.html(TEM_PRODUCTAUTH_OPENED_MODIFY(item));
                    $('.authStatus option[value="'+ item.AUTH_STATUS +'"]').attr('selected', true);
                });
        },
        bind: function (CONTAINER, data) {
            var _this = this,
                productAuth_list = require('js/productAuth_list'),
                productAuth_opened_detail = require('js/productAuth_opened_detail');


            //修改确认按钮
            CONTAINER.on('click', '.productAuth_opened_modify_submit', function () {

                C.PageBreak.Loading();

                var id = data.id,
                    productCode = $('.productCode').val(),
                    orgCode = $('.orgCode').val(),
                    channelCode = $('.channelCode').val(),
                    authCode = $('.authCode').val(),
                    authNum = $('.authNum').val(),
                    authBeginTime = $('.authBeginTime').val(),
                    authEndTime = $('.authEndTime').val(),
                    productPrice = $('.productPrice').val(),
                    authStatus = $('.authStatus').val(),
                    productRebate = $('.productRebate').val(),
                    warningAmount = $('.warningAmount').val(),
                    productName = $('.productName').val(),
                    parm = {
                        id: id,
                        productCode: productCode,
                        orgCode: orgCode,
                        channelCode: channelCode,
                        authCode: authCode,
                        authNum: authNum,
                        authBeginTime: authBeginTime,
                        authEndTime: authEndTime,
                        productPrice: productPrice,
                        authStatus: authStatus,
                        productRebate: productRebate,
                        warningAmount: warningAmount,
                        state: '1',
                        productName: productName
                    };
                $.ajax({
                    type: 'get',
                    url: C.Api.UPDATEPRODUCTAUTH,
                    data: parm,
                    success: function (res) {
                        C.PageBreak.stopLoading();
                        if (res.resCode == C.ResCodes.SUCCESS) {
                            C.UI.msg('产品授权修改成功！');
                            if(data.type == '1'){
                                productAuth_list.init(data.backTo);
                            }else if(data.type == '2'){
                                productAuth_opened_detail.init(data);
                            }
                        }
                    }
                });
            });
            //取消
            CONTAINER.on('click', '.productAuth_opened_modify_cancel', function () {
                if(data.type == '1'){
                    productAuth_list.init(data.backTo);
                }else if(data.type == '2'){
                    productAuth_opened_detail.init(data);
                }
            });

            //开始时间
            CONTAINER.on('focus', '#productAuth_opened_modify_start', function(){
                laydate({
                    elem: '#productAuth_opened_modify_start',
                    istime: true,
                    istoday: false,
                    min: laydate.now(),
                    max: $('#productAuth_opened_modify_end').val()
                });
            });

            //结束时间
            CONTAINER.on('focus', '#productAuth_opened_modify_end', function(){
                laydate({
                    elem: '#productAuth_opened_modify_end',
                    istime: true,
                    istoday: false,
                    min: $('#productAuth_opened_modify_start').val()
                });
            });

        },
        //输入框校验
        isValidator: function () {
            var orgname = $('.new_orgName').val(),
                orgPhnum = $('.new_org_phone').val(),
                orgEmail = $('.new_orgEmail').val(),
                orgusername = $('.new_orgUserName').val();
            if (orgname == '') {
                $('.new_org_name_tip').show();
                return false;
            } else {
                $('.new_org_name_tip').hide();
            }

            if (!C.Utils.isPhoneNum(orgPhnum)) {
                $('.new_org_phone_tip').show();
                return false;
            } else {
                $('.new_org_phone_tip').hide();
            }

            if (!C.Utils.isEmail(orgEmail)) {
                $('.new_org_email_tip').show();
                return false;
            } else {
                $('.new_org_email_tip').hide();
            }

            if (orgusername == '') {
                $('.new_org_uesrName_tip').show();
                return false;
            } else {
                $('.new_org_uesrName_tip').hide();
            }
            return true;
        }
    };
    return productAuth_opened_modify;
});
/**
 * Created by fananyuan on 2016/6/20.
 */
define(['require', 'ko', 'underscore', 'C', 'jquery'], function (require, ko, _, C, $) {
    var feet_charge ;
    feet_charge = {
        init: function (data) {
            var _this = this,
                TEM_TEET_CHARGE = _.template($('#tem_feet_charge').html()),
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO),TEM_TEET_CHARGE,data);
            _this.bind($('#' + CONTAINERNO),data);

        },
        render: function (CONTAINER, TEM_TEET_CHARGE,data) {
            var _this = this,
                balanceMoney = C.Utils.formatNum(data.balanceMoney);
            $('.show_position_pre').text('计费管理');
            $('.show_position').text('>充值');
            $('#organization_modify_header').show().siblings().hide();

            CONTAINER.html(TEM_TEET_CHARGE({balanceMoney:balanceMoney}));
        },
        bind: function (CONTAINER, data) {
            var _this = this,
                feet_detail = require('js/feet_detail'),
                feet_list = require('js/feet_list');
           //确定充值
            CONTAINER.on('click', '.feet_charge_submit', function(){
                var orgCode = data.orgCode,
                    channelName = data.channelName,
                    orgName = data.orgName,
                    productName = data.productName,
                    ID = data.ID,
                    channelCode = data.channelCode,
                    productCode = data.productCode,
                    rechargeMoney = $('.rechargeMoney').val(),
                    rechargeComment = $('.rechargeComment').val();
                C.UI.warm({
                    header: '确定充值？',
                    content: '为渠道名称' + channelName + '充值' + rechargeMoney + '元',
                    cancelText:'取消',
                    okText: '确定',
                    ok: function () {
                        C.PageBreak.Loading();
                        $.ajax({
                            type: 'get',
                            url: C.Api.SUBMITFEETCHARGE,
                            data: {
                                orgCode: orgCode,
                                channelCode: channelCode,
                                productCode: productCode,
                                rechargeMoney:rechargeMoney,
                                rechargeComment: rechargeComment,
                                orgName: orgName,
                                productName: productName,
                                channelName: channelName
                            },
                            success: function(res){
                                C.PageBreak.stopLoading();
                                if (res.resCode == C.ResCodes.SUCCESS) {
                                    feet_list.init();
                                }
                            },
                            error:function(){

                            }
                        });
                    }
                });
            });
            CONTAINER.on('focusout', '.rechargeMoney', function(){
                var $this = $(this),
                    val = Number($this.val()).toFixed(2);
                    $this.val(val);
            });
            //取消充值
         CONTAINER.on('click', '.feet_charge_cancel', function(){
             if(data.type == '1'){
                 feet_list.init();
             }else if(data.type == '2'){
                 feet_detail.init({ID:data.ID});
             }
         });
        }
    };
    return feet_charge;
});
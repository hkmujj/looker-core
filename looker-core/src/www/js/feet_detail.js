/**
 * Created by fananyuan on 2016/6/20.
 */
define(['require' ,'ko', 'underscore', 'C', 'jquery', 'js/feet_charge', 'js/feet_record'], function (require ,ko, _, C, $, feet_charge, feet_record) {




   var feet_detail = {
        init: function (data) {
            var _this = this,
            //机构详情
             TEM_FEET_DETAIL = _.template($('#tem_feet_detail').html()),
                ID = data.ID,
            CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO),ID,TEM_FEET_DETAIL);
            _this.bind($('#' + CONTAINERNO));

        },
        render: function (CONTAINER,ID,TEM_FEET_DETAIL) {
            var _this = this;
            $('.show_position').text('>计费详情');
            C.PageBreak.Loading();
            $.ajax({
                type: 'get',
                url: C.Api.FEETDETAIL,
                data: {id: ID},
                success: function (res) {
                    C.PageBreak.stopLoading();
                    if (res.resCode == C.ResCodes.SUCCESS) {
                        CONTAINER.html(TEM_FEET_DETAIL(res.resData.feeInfo));
                    } else {
                        C.UI.msg(res.resMsg);
                    }
                }
            });

        },
        bind: function (CONTAINER) {
            var _this = this;
        //充值
            CONTAINER.on('click', '.feet_detail_charge', function(){
                var $this = $(this),
                    orgCode = $this.attr('orgCode'),
                    channelCode = $this.attr('channelCode'),
                    productCode = $this.attr('productCode'),
                    balanceMoney = $this.attr('balanceMoney'),
                    ID = $this.attr('feetId'),
                    channelName = $this.attr('channelName'),
                    productName = $this.attr('productName'),
                    orgName = $this.attr('orgName'),
                    data = {
                        orgCode: orgCode,
                        channelCode: channelCode,
                        productCode: productCode,
                        balanceMoney: balanceMoney,
                        channelName: channelName,
                        productName: productName,
                        orgName: orgName,
                        ID: ID,
                        type: '2'
                    };
                feet_charge.init(data);
            });
            //充值记录
            CONTAINER.on('click', '.feet_record', function(){
                var $this = $(this),
                    orgCode = $this.attr('orgCode'),
                    channelCode = $this.attr('channelCode'),
                    productCode = $this.attr('productCode'),
                    data = {
                        orgCode: orgCode,
                        channelCode: channelCode,
                        productCode: productCode
                    };
                feet_record.init(data);
            });
        }
    };
    return feet_detail;
});
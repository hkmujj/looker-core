define(['ko', 'underscore', 'C', 'jquery'], function (ko, _, C, $) {
    var srarchreport,
        //报表查询
        TEM_REPORT_SEARCH = _.template($('#tem_report_search').html()),
        //1--8的报表内容
        TEM_REPORT_CONTENT_1 = _.template($('#tem_report_detail_1').html()),
        TEM_REPORT_CONTENT_2 = _.template($('#tem_report_detail_2').html()),
        TEM_REPORT_CONTENT_3 = _.template($('#tem_report_detail_3').html()),
        TEM_REPORT_CONTENT_4 = _.template($('#tem_report_detail_4').html()),
        TEM_REPORT_CONTENT_5 = _.template($('#tem_report_detail_5').html()),
        TEM_REPORT_CONTENT_6 = _.template($('#tem_report_detail_6').html()),
        TEM_REPORT_CONTENT_7 = _.template($('#tem_report_detail_7').html()),
        TEM_REPORT_CONTENT_8 = _.template($('#tem_report_detail_8').html()),
        URL = C.Api.COMMON_REPORTSEARCH;

    srarchreport = {
        init: function () {
            var _this = this,
                CONTAINERNO = "zx_container_" + Math.floor(Math.random() * 1000000);
            $('.zx_container').html('<div id="' + CONTAINERNO + '">' + '</div>');
            _this.render($('#' + CONTAINERNO));
            _this.bind($('#' + CONTAINERNO));
            window.location.hash = 'srarchreport';

        },

        render: function (CONTAINER) {
            var _this = this;
            $('.show_position_pre').text('报表管理');
            $('.show_position').text('>报表查询');
            $('.show_position_next').hide();
            $('#organization_modify_header').show().siblings().hide();
            CONTAINER.html(TEM_REPORT_SEARCH({}));
        },
        bind: function (CONTAINER) {
            var _this = this;
            //报表类型选择对应时间
            CONTAINER.on('change', '.sereport', function () {
                var self = $(this),
                    statementType=self.val() ;
                $.ajax({
                    type: 'get',
                    url: C.Api.COMMON_REPORTDATASEARCH,
                    data: {
                        statementType: statementType
                    },
                    success: function (res) {
                        if (res.resCode == C.ResCodes.SUCCESS) {
                            var item = res.resData,
                                dataDOM = $('.datadom'),
                                pool = ['<option value="">'+'请选择'+'</option>'];
                            for (var i = 0; i < item.length; i++) {
                                pool.push('<option value="'+ item[i] +'">' + item[i] + '</option>');
                            }
                            dataDOM.html(pool.join(''));
                        }
                    }
                });
            });
            //查询
            CONTAINER.on('click', '.report_search', function(){
                var bizDate = $('.datadom').val(),
                    statementType = $('.sereport').val(),
                    reportContentDom = $('.report_content');
                 if(statementType == ''){
                    C.UI.msg('请选择查询报表！');
                    return;
                }else if(bizDate == ''){
                    C.UI.msg('请选择查询时间！');
                    return;
                }
                $.ajax({
                    type: 'get',
                    url: C.Api.REPORT_SEARCH,
                    data: {
                        bizDate: bizDate,
                        statementType: statementType
                    },
                    success: function(res){
                        if (res.resCode == C.ResCodes.SUCCESS) {
                           switch(statementType){
                               case '1':
                                   reportContentDom.html(TEM_REPORT_CONTENT_1(res.resData));
                                   break;
                               case '2':
                                   reportContentDom.html(TEM_REPORT_CONTENT_2(res.resData));
                                   break;
                               case '3':
                                   reportContentDom.html(TEM_REPORT_CONTENT_3(res.resData));
                                   break;
                               case '4':
                                   reportContentDom.html(TEM_REPORT_CONTENT_4(res.resData));
                                   break;
                               case '5':
                                   reportContentDom.html(TEM_REPORT_CONTENT_5(res.resData));
                                   break;
                               case '6':
                                   reportContentDom.html(TEM_REPORT_CONTENT_6(res.resData));
                                   break;
                               case '7':
                                   reportContentDom.html(TEM_REPORT_CONTENT_7(res.resData));
                                   break;
                               case '8':
                                   reportContentDom.html(TEM_REPORT_CONTENT_8(res.resData));
                                   break;
                           }
                        }
                    }
                });
            });

            //重置
            CONTAINER.on('click', '.report_reset', function(){
               var selectDom =  $('.mecsearch select option[value=""]');
                selectDom.attr('selected', true);
                selectDom.removeAttr('selected');
            });
            //上传当前报表
            CONTAINER.on('click', '.downloadnow', function(){
                var bizDate = $('.datadom').val(),
                    statementType = $('.sereport').val();
                location.href = C.Api.STATEMENT_EXPORT+"?bizDate=" + bizDate +"&statementType=" + statementType;

            });
            //下载全部报表
            CONTAINER.on('click', '.downloadall', function(){
                var bizDate = $('.datadom').val();
                location.href = C.Api.STATEMENT_EXPORTALL+"?bizDate=" + bizDate;

            });

        }
    };
    return srarchreport;
});
/**
 * Created by fananyuan on 2016/6/17.
 */
define(['jquery'], function ($) {
    var PageBreak = {

        table: function (os) {
            PageBreak.Loading();
            var _this = this;
            var TOTAL = 0,
                pool = [],
                maxlen = 6,
                cindex = os.cindex || '1',
            //行数
                direct = 1,
            //每页显示条数 默认5条
                pageSize = os.pageSize || '10',
            // 总页数
                pageindex = 0,
            //总行数
                total_direct = pageindex % maxlen ? Math.floor(pageindex / maxlen) + 1 : pageindex / maxlen,
            //排序  asc升序  dsc降序
                ORDER = '',
            //排序依据的属性
                ORDER_BY = '',
                URL = os.url || '',
                parm = os.parm || {},
                PARM = $.extend(parm, {pageNo: cindex, pageSize: pageSize,order:ORDER,order_by:ORDER_BY}),
                DATA = {pageNo: cindex, pageSize: pageSize},
                OS = os || {};
                function setTable(){}
            $.ajax({
                type: 'get',
                url: URL,
                data: PARM,
                success: function (res) {
                    PageBreak.stopLoading();
                    if (res.resCode == '0' && res.resData) {
                        var item = res.resData;
                        TOTAL = res.totalCount;
                        pageindex = TOTAL % pageSize ? Math.floor(TOTAL / pageSize) + 1 : TOTAL / pageSize;
                        console.log(11111111111111+JSON.stringify(PARM))
                        os.$tablebox.html(
                            '<table class="tab_info">'+'<thead class="organization_head">'+' <tr class="nwd_header">'+'</tr>'+' </thead>'+
                            '<tbody class="nwd_table">'+'</tbody>'+'</table>'+' <div class="fifthclm">'+
                            '<div class="nwd_pagebreak">' + '<span class="nwd_left">'+
                            '<span class="nwd_pagebreak_font">' + '每页显示' + '</span>' +
                            '<select class="nwd_pagebreak_select">' +
                            '<option>' + '10' + '</option>' +
                            '<option>' + '20' + '</option>' +
                            '<option>' + '30' + '</option>' +
                            '</select>' +
                            '<span >' + '条&nbsp;' + '</span>' +
                            '<span>' + '共' + '</span>' + '<span>' + TOTAL + '</span>' +
                            '<span>' + '条' + '</span>' + '</span>'+
                            '<span class="nwd_pagebreak_right">' +
                            '<span class="nwd_pagebreak_pre">' + '<i class="button_box">'+
                            '<button type="button" class="nwd_firstpage">' + '首页' + '</button>' + '</i>'+
                            '<button type="button" class="nwd_pagebreak_previos">' + '上一页' + '</button>' +
                            '</span>' +
                            '<span class="nwd_pagebreak_num">' +
                            '</span>' +
                            '<button class="nwd_pagebreak_next">' + '下一页' + '</button>' +
                            '<button class="nwd_lastpage">' + '尾页' + '</button>' +
                            '</span>' +
                            '</div>'+
                            '</div>'
                        );

                        function setheader(){
                            var arr =[],i=0;
                            for(;i<os.headcontent.length;i++){
                                arr.push('<th class="'+os.headcontent[i].icon+'" order_by="'+os.headcontent[i].order_by+'">'+os.headcontent[i].name+'</th>')
                            }
                            $('.nwd_header').html(arr.join(''));
                        }

                        function pagenum() {
                            var i = 1, arr = [];
                            for (i; i < pageindex + 1; i++) {
                                pool.push('<a>' + i + '</a>');
                            }
                            arr = pool.slice((direct - 1) * maxlen, (direct - 1) * maxlen + 6);
                            $('.nwd_pagebreak_num').html(arr.join(''));
                        }
                        //设置头部
                        setheader();
                        os.callback && os.callback(TOTAL);
                        if(TOTAL == 0){
                            $('.fifthclm').html('<div class="failMsg">'+'未查询到数据！'+'</div>');
                            return;
                        }

                        //表格内容
                        $('.nwd_table').html(os.tem(item));
                        os.callback && os.callback(TOTAL);
                        //初始化时默认选中第一页
                        pagenum();
                        $('.nwd_pagebreak_num a').eq(0).addClass('nwd_pagebreak_active');
                        $('.nwd_pagebreak_select').val(pageSize);
                        //页数点击事件
                        $('.nwd_pagebreak_num').on('click', 'a', function () {
                            var self = $(this);
                            cindex = self.text();
                            self.addClass('nwd_pagebreak_active').siblings().removeClass('nwd_pagebreak_active');
                            DATA = $.extend(parm,{pageNo: cindex, pageSize: pageSize,order:ORDER,order_by:ORDER_BY});
                            _this.loadData(DATA, $('.nwd_table') , os, URL);
                        });

                        //下一页点击事件
                        $('.nwd_pagebreak_next').click(function () {
                            var ieq = cindex % 6;
                            //点击下一页到 最后一页
                            if (cindex == pageindex) {
                                return;
                            }
                            // 下一页分行
                            if (!$('.nwd_pagebreak_num .nwd_pagebreak_active').next().text() && cindex >= maxlen * direct) {
                                direct++;
                                cindex = (cindex * 1 + 1).toString();
                                pool = [];
                                pagenum();
                                $('.nwd_pagebreak_num a').eq(ieq).addClass('nwd_pagebreak_active').siblings().removeClass('nwd_pagebreak_active');
                            } else {
                                $('.nwd_pagebreak_num a').eq(ieq).addClass('nwd_pagebreak_active').siblings().removeClass('nwd_pagebreak_active');
                                cindex = (cindex * 1 + 1).toString();

                            }
                            DATA = $.extend(parm,{pageNo: cindex, pageSize: pageSize,order:ORDER,order_by:ORDER_BY});
                            _this.loadData(DATA,  $('.nwd_table'), os, URL);
                        });
                        //点击上一页事件
                        $('.nwd_pagebreak_previos').click(function () {
                            var ieq = cindex % 6;
                            if (cindex == '1') {
                                return;
                            }
                            if (!$('.nwd_pagebreak_num .nwd_pagebreak_active').prev().text() && (cindex - 1) <= maxlen * (direct - 1)) {
                                direct--;
                                cindex = cindex - 1;
                                pool = [];
                                pagenum();
                                $('.nwd_pagebreak_num a').eq(ieq + 4).addClass('nwd_pagebreak_active').siblings().removeClass('nwd_pagebreak_active');
                            } else {
                                $('.nwd_pagebreak_num a').eq(ieq - 2).addClass('nwd_pagebreak_active').siblings().removeClass('nwd_pagebreak_active');
                                cindex = cindex - 1;
                            }
                            DATA = $.extend(parm,{pageNo: cindex, pageSize: pageSize,order:ORDER,order_by:ORDER_BY});
                            _this.loadData(DATA,  $('.nwd_table'), os, URL);
                        });

                        //点击首页按钮事件
                        $('.nwd_firstpage').click(function () {
                            if (cindex == '1') {
                                return;
                            }
                            direct = 1;
                            cindex = '1';
                            pool = [];
                            pagenum();
                            $('.nwd_pagebreak_num a').eq(0).addClass('nwd_pagebreak_active').siblings().removeClass('nwd_pagebreak_active');
                            DATA = $.extend(parm,{pageNo: cindex, pageSize: pageSize,order:ORDER,order_by:ORDER_BY});
                            _this.loadData(DATA,  $('.nwd_table'), os, URL);
                        });
                        //尾页点击事件
                        $('.nwd_lastpage').click(function () {
                            if (cindex == pageindex) {
                                return;
                            }
                            total_direct = pageindex % maxlen ? Math.floor(pageindex / maxlen) + 1 : pageindex / maxlen;
                            direct = total_direct;
                            cindex = pageindex.toString();
                            pool = [];
                            pagenum();
                            $('.nwd_pagebreak_num a').last().addClass('nwd_pagebreak_active').siblings().removeClass('nwd_pagebreak_active');
                            DATA = $.extend(parm,{pageNo: cindex, pageSize: pageSize,order:ORDER,order_by:ORDER_BY});
                            _this.loadData(DATA,  $('.nwd_table'), os, URL);
                        });

                        //选择每页显示条数
                        $('.nwd_pagebreak_select').change(function () {
                            OS.pageSize = $(this).val();
                            OS.cindex = '1';
                            $('.nwd_header').find('.iconfont').removeClass('sort_dsc').removeClass('sort_asc').addClass('sort');
                            _this.table(OS);
                        });
                        //点击表头排序
                        $('.nwd_header').on('click', '.sort', function(){
                            var $this = $(this);
                            ORDER = 'asc',
                                ORDER_BY = $this.attr('order_by');
                            $this.addClass('sort_asc').removeClass('sort').siblings('.iconfont').removeClass('sort_asc')
                                .addClass('sort');
                            $this.siblings('.iconfont').removeClass('sort_dsc');
                            DATA = $.extend(parm,{pageNo: cindex, pageSize: pageSize,order:ORDER,order_by:ORDER_BY});
                            _this.loadData(DATA,  $('.nwd_table'), os, URL);
                        });
                        //点击已经升序的表头 转换为降序
                        $('.nwd_header').on('click', '.sort_asc', function(){
                            var $this = $(this);
                            ORDER = 'desc',
                                ORDER_BY = $this.attr('order_by');
                            $this.addClass('sort_dsc').removeClass('sort_asc');
                            DATA = $.extend(parm,{pageNo: cindex, pageSize: pageSize,order:ORDER,order_by:ORDER_BY});
                            _this.loadData(DATA,  $('.nwd_table'), os, URL);
                        });
                        //点击已经降序的表头
                        $('.nwd_header').on('click', '.sort_dsc', function(){
                            var $this = $(this);
                            ORDER = 'asc',
                                ORDER_BY = $this.attr('order_by'),
                                CINDEX =cindex,
                                PAGESIZE = pageSize;
                            $this.addClass('sort_asc').removeClass('sort_dsc');
                            DATA = $.extend(parm,{pageNo: CINDEX, pageSize: PAGESIZE,order:ORDER,order_by:ORDER_BY});
                            _this.loadData(DATA,  $('.nwd_table'), os, URL);
                        });
                    }else{
                        $('.fifthclm').html('<div class="failMsg">'+res.resMsg+'</div>');
                    }
                }

            });

        },
        loadData: function (data, $table, os, url) {
            PageBreak.Loading();
            var self = this;
            $.ajax({
                type: 'get',
                url: url,
                data: data,
                success: function (res) {
                    console.log(22222222222222+JSON.stringify(data))
                    PageBreak.stopLoading();
                    if (res.resCode == '0') {
                        var item = res.resData;
                        $table.html(os.tem(item));
                        os.callback && os.callback();
                    }else{
                        $table.html('<div class="failMsg">'+res.resMsg+'</div>');
                    }
                }
            });
        },
        //loading组件
        loading: function () {
            if (!document.getElementById('#nwd_loading_container')) {
                var container = document.createElement('div');
                container.id = 'nwd_loading_container';
                container.style.display = "none";
                container.style.zIndex = "99999";
                container.innerHTML = ['<div class="nwd_load_dialog">' + '</div>'].join("");
                document.body.appendChild(container);
                var dialogNo = "dialog_" + Math.floor(Math.random() * 1000000);
                $(document.body).prepend('<div class="mask_loading" id=' + dialogNo + ' style="display:block;z-index:600"></div>');
            }
        },
        Loading: function () {
            PageBreak.loading();
            $('#nwd_loading_container').show();
        },
        stopLoading: function () {
            var dialog = $('#nwd_loading_container');
            if (dialog) {
                dialog.remove();
                $('.mask_loading').remove();
            }
        }

    };
    return PageBreak;
});
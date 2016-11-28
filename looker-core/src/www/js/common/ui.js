/** UI类
 * Created by fananyuan on 2016/6/7.
 */
define(['jquery', 'layer'], function ($, layer) {
    var UI = {
        warm: function (opt) {
            UI.dialog(opt);
        },
        msg: function(msg){
            layer.msg(msg);
        },
        Loading: function () {
            UI.loadingDialog();
            $('#zx_loading_box').show();
        },
        stopLoading: function () {
            var $loading_box = $('#zx_loading_box');
            if ($loading_box) {
                $loading_box.remove();
                $('.mask').remove();
            }
        }
    };

    //弹窗组件
    UI.dialog = (function () {
        var okBtn, cancelBtn, contentarea, content_replay, wrap, active = false;
        return function (opt) {
            if (active) return;
            active = true;
            opt = opt || {};
            opt.header = opt.header || {};
            opt.content = opt.content || "";
            opt.content2 = opt.content2 || "";
            opt.content3 = opt.content3 || "";
            opt.content_area = opt.content_area || "";
            opt.okText = opt.okText || "";
            opt.ok = opt.ok;
            opt.cancelText = opt.cancelText || "";
            opt.cancel = opt.cancel;
            if (!document.getElementById('nwd_dialod_wrap')) {
                wrap = document.createElement("div");
                wrap.id = "nwd_dialod_wrap";
                wrap.style.display = "none";
                wrap.style.zIndex = "999";
                wrap.className = 'nwd_dialog_box';
                wrap.innerHTML = [
                    '<div class="nwd_dialog_head">' + opt.header + '</div>' + '<div class="nwd_dialog_content" style="display:'+(opt.content ? 'block' : 'none')+'">'+
                    '<p id="nwd_dialog_content" style="display:'+(opt.content ? 'block' : 'none')+'">' + opt.content + '</p>' +
                    '<p  style="font-size: 14px;display:' + (opt.content2 ? 'block' : 'none') + '">' + opt.content2 + '</p>' +
                    '<p style="font-size: 14px;display:' + (opt.content3 ? 'block' : 'none') + '">' + opt.content3 + '</p>' +'</div>'+

                    '<div id="nwd_dialog_content_textarea" class="nwd_dialog_content_textarea" maxlength="150" style="display:'+(opt.content_area ? 'block' : 'none')+'">' +
                    '<textarea class="nwd_dialog_textarea" maxlength="150">' + '</textarea>' + '</div>' +
                    '<div class="nwd_dialog_footer">' + '<a id="nwd_dialog_con" class="nwd_dialog_ok  nwd_dialog_btn" style="display:'+(opt.okText ? 'block' : 'none')+'">' + '确&nbsp;&nbsp;&nbsp;认' +
                    '</a>' + '<a  id="nwd_dialog_can" class="nwd_dialog_cancle  nwd_dialog_btn" style="display:'+(opt.cancelText ? 'block' : 'none')+'">' + '取&nbsp;&nbsp;&nbsp;消' + '</a>' + '</div>'
                ].join("");

                document.body.appendChild(wrap);
                var dialogNo = "dialog_" + Math.floor(Math.random() * 1000000);
                $(document.body).prepend('<div class="nwd_dialog_mask" id=' + dialogNo + ' style="display:none;z-index:600"></div>');
                okBtn = document.getElementById('nwd_dialog_con');
                cancelBtn = document.getElementById('nwd_dialog_can');
                contentarea = document.getElementById('nwd_dialog_content');
                content_replay = document.getElementById('nwd_dialog_content_textarea');

                okBtn.onclick = function () {
                    var val =  opt.content_area ? $('.nwd_dialog_textarea').val() : '';
                    $('#' + dialogNo + '.nwd_dialog_mask').remove();
                    $(wrap).remove();
                    active = false;
                    opt.ok && opt.ok(val);
                };
                cancelBtn.onclick = function () {
                    $('#' + dialogNo + '.nwd_dialog_mask').remove();
                    $(wrap).remove();
                    active = false;
                    opt.cancel && opt.cancel();
                };
            }
            //okBtn.style.display = !!opt.okText ? "inlineBlock" : "none";
            //cancelBtn.style.display = !!opt.cancelText ? "inlineBlock" : "none";
            //contentarea.style.display = !!opt.content ? "inlineBlock" : "none";
            //content_replay.style.display = !!opt.content_area ? "inlineBlock" : "none";
            $('#' + dialogNo + '.nwd_dialog_mask').fadeIn(100);
           $('#nwd_dialod_wrap').fadeIn(200);
        }
    })();

    //loading组件
    UI.loadingDialog = function () {
        var active = false, wrap;
        if (active) return;
        active = true;
        if (!document.getElementById("zx_loading_box")) {
            wrap = document.createElement("div");
            wrap.id = "zx_loading_box";
            wrap.style.display = "none";
            wrap.style.zIndex = "999";
            wrap.className = 'zeng_msgbox_layer_wrap';
            wrap.innerHTML = [
                "<div id='zx_loading_box' class='zeng_msgbox_layer_wrap'>" +
                "<span class='zeng_msgbox_layer'>" +
                "<span class='gtl_ico_clear'>" + "</span>" +
                "<span class='gtl_ico_loading'>" + "</span>" +
                "正在加载中，请稍后..." +
                "<span class='gtl_end'>" + "</span>" +
                "</span>" +
                "</div>"
            ].join("");
            document.body.appendChild(wrap);
            var dialogNo = "dialog_" + Math.floor(Math.random() * 1000000);
            $(document.body).prepend('<div class="mask" id=' + dialogNo + ' style="display:block;z-index:600"></div>');
        }
    };
    return UI;
});
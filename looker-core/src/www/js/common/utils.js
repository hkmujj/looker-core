/** 工具类
 * Created by fananyuan on 2016/6/7.
 */
define(['underscore'], function (_) {
    var Utils = {
        RegexMap:{
            // 手机号码
            MobileNo: /^1[34587]\d{9}$/
        },
        isPhoneNum: function(str){
            var reg = /^1[34587]\d{9}$/;
            return reg.test(str);
        },
        isEmail: function(str){
            var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
            return reg.test(str);
        },
        isName: function(str){
            var reg = /^([\u4e00-\u9fa5]){2,7}$/;
            return reg.test(str);
        },
        isIp: function (str) {
            var reg = /^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$/;
            return reg.test(str);
        },
        //非法字符
        illegalChar: function(str) {
            var pattern = /[`~!@#\$%\^\&\*\(\)_\+<>\?:"\{\},\.\\\/;'\[\]]/im;
            if (pattern.test(str)) {
                return false;
            }
            return true;
        },
        //转千分位

        formatNum:  function(num) {
             return (parseFloat(num).toFixed(2) + '').replace(/\d{1,3}(?=(\d{3})+(\.\d*)?$)/g, '$&,');
       },



        /**
         * 转义<> ", 页面带出数据时需先调用该方法替换，避免跨站脚本攻击
         * @param  {[type]} str [description]
         * @return {[type]}     [description]
         */
        escapeHtml: function (str) {
            return str ? str.toString().replace(/\</g, '&lt;').replace(/\>/g, '&gt;').replace(/\\"/g, '&quot;') : '';
        },
        /**
         * 本地数据操作
         * @param key
         * @param value
         */
        data: function (key, value) {
            var self = this;
            var getItemValue = function () {
                var data = localStorage.getItem(key);
                try {
                    data = JSON.parse(self.escapeHtml(data));
                } catch (e) {
                    Utils.logs(e.message);
                }
                return data;
            };
            if (key && value === undefined) {
                return getItemValue();
            } else if (key && value === null) {
                localStorage.removeItem(key);
            } else {
                // 转义<> ", 页面带出数据时需先调用该方法替换
                value = JSON.parse(self.escapeHtml(JSON.stringify(value)));
                localStorage.setItem(key, JSON.stringify(value));
            }
        },
        /**
         * 日志打印方法
         * @param text 需要打印的日志内容
         */
        logs: function(text) {
            window.console && console.log && console.log(text);
        },
        /** 转换日期格式
         * @param {Date|String} date 日期格式|String类型 (如：'2012-12-12' | '2012/12/12' | Date().now(), 总之为标准日期格式，将会作为Date对象实例化参数)
         * @param {String} formatStr
         * String类型 （如: 'yyyy年MM月dd日'或'yyyy年MM月dd日 hh时mm分ss秒',默认'yyyy-MM-dd'）
         * 参数：formatStr-格式化字符串
         * d：将日显示为不带前导零的数字，如1
         * dd：将日显示为带前导零的数字，如01
         * ddd：将日显示为缩写形式，如Sun
         * dddd：将日显示为全名，如Sunday
         * M：将月份显示为不带前导零的数字，如一月显示为1
         * MM：将月份显示为带前导零的数字，如01
         * MMM：将月份显示为缩写形式，如Jan
         * MMMM：将月份显示为完整月份名，如January
         * yy：以两位数字格式显示年份
         * yyyy：以四位数字格式显示年份
         * h：使用12小时制将小时显示为不带前导零的数字，注意||的用法
         * hh：使用12小时制将小时显示为带前导零的数字
         * H：使用24小时制将小时显示为不带前导零的数字
         * HH：使用24小时制将小时显示为带前导零的数字
         * m：将分钟显示为不带前导零的数字
         * mm：将分钟显示为带前导零的数字
         * s：将秒显示为不带前导零的数字
         * ss：将秒显示为带前导零的数字
         * l：将毫秒显示为不带前导零的数字
         * ll：将毫秒显示为带前导零的数字
         * tt：显示am/pm
         * TT：显示AM/PM
         * @returns {String} formated date string
         **/
        dateFormat: function (date, formatStr) {
            date = date instanceof Date ? date : new Date(date);
            /*
             函数：填充0字符
             参数：value-需要填充的字符串, length-总长度
             返回：填充后的字符串
             */
            var zeroize = function (value, length) {
                if (!length) {
                    length = 2;
                }
                value = String(value);
                for (var i = 0, zeros = ''; i < (length - value.length); i++) {
                    zeros += '0';
                }
                return zeros + value;
            };
            return (formatStr || "").replace(/"[^"]*"|'[^']*'|\b(?:d{1,4}|M{1,4}|yy(?:yy)?|([hHmstT])\1?|[lLZ])\b/g, function ($0) {
                switch ($0) {
                    case 'd':
                        return date.getDate();
                    case 'dd':
                        return zeroize(date.getDate());
                    case 'ddd':
                        return ['Sun', 'Mon', 'Tue', 'Wed', 'Thr', 'Fri', 'Sat'][date.getDay()];
                    case 'dddd':
                        return ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'][date.getDay()];
                    case 'M':
                        return date.getMonth() + 1;
                    case 'MM':
                        return zeroize(date.getMonth() + 1);
                    case 'MMM':
                        return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][date.getMonth()];
                    case 'MMMM':
                        return ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'][date.getMonth()];
                    case 'yy':
                        return String(date.getFullYear()).substr(2);
                    case 'yyyy':
                        return date.getFullYear();
                    case 'h':
                        return date.getHours() % 12 || 12;
                    case 'hh':
                        return zeroize(date.getHours() % 12 || 12);
                    case 'H':
                        return date.getHours();
                    case 'HH':
                        return zeroize(date.getHours());
                    case 'm':
                        return date.getMinutes();
                    case 'mm':
                        return zeroize(date.getMinutes());
                    case 's':
                        return date.getSeconds();
                    case 'ss':
                        return zeroize(date.getSeconds());
                    case 'l':
                        return date.getMilliseconds();
                    case 'll':
                        return zeroize(date.getMilliseconds());
                    case 'tt':
                        return date.getHours() < 12 ? 'am' : 'pm';
                    case 'TT':
                        return date.getHours() < 12 ? 'AM' : 'PM';
                }
            });
        },
        /** 转换日期格式
         * @param date : 日期格式|String类型 (如：'2012-12-12' | '2012年12月12日' | new Date())
         * @param format : String类型 （如: 'yyyy年MM月dd日'或'yyyy年MM月dd日 hh时mm分ss秒',默认'yyyy-MM-dd'）
         * @example C.parseDateFormat(new Date(), 'yyyy年MM月dd日') 输出："2014年04月29日"
         * @example C.parseDateFormat(new Date()) 输出："2014-04-29"
         * @exmaple C.parseDateFormat("2014-05-07 16:09:47","yyyy年MM月dd日 hh时mm分ss秒")
         *          输出："2014年05月07日 16时09分47秒"
         **/
        parseDateFormat: function(date, format) {
            if (!date) {
                return date;
            }
            if (!isNaN(date) && String(date).length == 8) {
                date = (date + '').replace(/^(\d{4})(\d{2})(\d{2})$/, "$1/$2/$3");
            }
            var addZero = function(val) {
                return /^\d{1}$/.test(val) ? '0' + val : val;
            };
            format = format || 'yyyy-MM-dd';
            var year = '',
                month = '',
                day = '',
                hours = "",
                minutes = "",
                seconds = "";
            if (typeof date == 'string') {
                var dateReg = Utils.RegexMap.parseDateFormat;
                var dateMatch = date.match(dateReg);
                if (dateMatch) {
                    year = dateMatch[1];
                    month = dateMatch[2];
                    day = dateMatch[3];
                    hours = dateMatch[5];
                    minutes = dateMatch[6];
                    seconds = dateMatch[7];
                }
            } else {
                year = date.getFullYear();
                month = date.getMonth() + 1;
                day = date.getDate();
                hours = date.getHours();
                minutes = date.getMinutes();
                seconds = date.getSeconds();
            }
            month = addZero(month);
            day = addZero(day);
            hours = addZero(hours);
            minutes = addZero(minutes);
            seconds = addZero(seconds);
            return format.replace('yyyy', year).replace('MM', month).replace('dd', day).replace("hh", hours).replace("mm", minutes).replace("ss", seconds);
        },
        // 判断对象中属性的值为空的个数
        isEmptyAttrValObject: function(obj) {
            var count = 0;
            if (_.isArray(obj)) {
                for (var i = 0, len = obj.length; i < len; i++) {
                    count = _.filter(obj[i], function(val) {
                        return !!val == false;
                    }).length;
                }
            } else {
                count = _.filter(obj, function(val) {
                    return !!val == false;
                }).length;
            }
            return !!count;
        },
        /**
         * 公共方法定义
         * @example: http://xxx.com/a.do?productCode=P001
         *     Result:  C.getParameter('productCode')  // 'P001'
         */
        getParameter: function(param) {
            var reg = new RegExp('[&,?]' + param + '=([^\\&]*)', 'i');
            var value = reg.exec(location.search);
            return value ? value[1] : '';
        }
    };
    return Utils;
});

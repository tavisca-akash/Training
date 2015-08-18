function normalize(value) {
    while (value.indexOf("<") > -1) {
        value = value.replace("<", "&lt;");
    }
    while (value.indexOf(">") > -1) {
        value = value.replace(">", "&gt;");
    }
    return value;
}

function removeAllSpaces(value) {
    var newvalue = "";
    var pos = 0;
    while (pos < value.length) {
        if (value.charAt(pos) != ' ') {
            newvalue = newvalue + value.charAt(pos);
        }
        pos++;
    }
    return newvalue;
}

function escapeAllQuotes(value) {
    var newvalue = "";
    var pos = 0;
    while (pos < value.length) {
        if (value.charAt(pos) == '"') {
            newvalue = newvalue + "\\";
        }
        newvalue = newvalue + value.charAt(pos);
        pos++;
    }
    return newvalue;
}

function trim(stringToTrim) {
    return stringToTrim.replace(/^\s+|\s+$/g, "");
}

var EnvironmentData = {
    Actions: {
        updateTips: function (t) {
            if (t != '' || t != null) {
                TemplarFx.ShowMsg('Error', t, 'Error');
            }
        },
        checkLength: function (o, n, min, max) {

            if (o.val().length == 0 && min > 0) {
                o.addClass('ui-state-error');
                this.updateTips(n + " is required.");
                return false;
            }
            else if (o.val().length > max || o.val().length < min) {
                o.addClass('ui-state-error');
                this.updateTips("Length of " + n + " must be between " + min + " and " + max + ".");
                return false;
            }
            return true;
        },
        checkRegexp: function (o, regexp, n) {

            if (!(regexp.test(o.val()))) {
                o.addClass('ui-state-error');
                this.updateTips(n);
                return false;
            }
            return true;
        },
        CheckIfExists: function (o, n, lists) {

            var bExists = false;
            lists.each(function (index) {
                if (index != (lists.length - 1)) {
                    if ($(this).html().toLowerCase() == o.val().toLowerCase()) {
                        bExists = true;
                        return;
                    }
                }
            });
            if (bExists) {
                o.addClass('ui-state-error');
                this.updateTips(n + " already exists.");
            }
            return bExists;
        },
        AddType: function (control) {
            var textControls = $(control).parent().find(':text');
            $(textControls[0]).removeClass('ui-state-error');

            var bValid = true;
            bValid = bValid && this.checkLength($(textControls[0]), "Type name", 3, 30) && this.checkRegexp($(textControls[0]), /^([0-9a-zA-Z])+$/, "Type name  only allow : a-z 0-9") && !this.CheckIfExists($(textControls[0]), 'Type name', $(control).parent().parent().parent().find('tr td:first-child'));
            if (bValid) {
                $(control).parent().parent().before(
                    '<tr>' +
                        '<td valign="top">' +
                            $(textControls[0]).val() +
                        '</td>' +
                        '<td>' +
                            '<div class="ui-widget ui-widget-content ui-corner-all" style="padding: 2px;">' +
                                '<div class="ui-widget-header ui-corner-all ui-helper-clearfix keyValueGroups" onclick="javascript:$(this).siblings(\'div\').toggle();" title="Click to Hide/Show">' +
                                    '<span>Key Collections</span>' +
                                '</div>' +
                                '<div class="EnvDataDiv justAdded" style="display:inline-block;width: 98.2%; height: 100%;padding: 2px;">' +
                                '</div>' +
                            '</div>' +
                        '</td>' +
                        '<td valign="top">' +
                            '<a onclick="javascript:return DeleteRow(this);" title="Remove"><span class="ui-icon ui-icon-trash"></span></a>' +
                        '</td>' +
                    '</tr>');
                $(textControls[0]).val('');
                $('.justAdded').PageData({ 'CustomKeyValidator': function (key) {
                    var regexp = /^([0-9a-zA-Z])+$/;
                    if (!key || !(regexp.test(key)) || key.length < 3 || key.length > 30) {
                        return false;
                    }
                    return true;
                }, 'KeyValidationFailedMsg': 'Only alphanumeric key of length between 3 and 30 are valid.'
                });
                $('.justAdded').removeClass('justAdded');
            }
            return false;
        }        
    }
}

var SiteMetaData =
{
    Actions: {

        Validate: function (key, value) {
            return KeyValueCollection.Actions.checkRegexp(key, /^([a-zA-Z])+$/, "Invalid Name") &&
                   KeyValueCollection.Actions.checkLength(value, "Content", 3, Infinity);
        },
        AddKeyData: function (container) {
            return KeyValueCollection.Actions.AddKeyData(container, this.Validate);
        },
        Serialize: function (container) {
            return KeyValueCollection.Actions.Serialize(container, this.Validate);
        },
        Deserialize: function (container, value) {
            KeyValueCollection.Actions.DeSerialize(container, value, 'Name', 'Content', 'SiteMetaData.Actions.AddKeyData');
        }
    }
}




var PageEnvData =
{
    Actions: {

        Validate: function (key, value) {
            return KeyValueCollection.Actions.checkRegexp(key, /^([0-9a-zA-Z])+$/, "Invalid Key") &&
                   KeyValueCollection.Actions.checkLength(value, "value", 3, Infinity);
        },
        AddKeyData: function (container) {
            return KeyValueCollection.Actions.AddKeyData(container, this.Validate);
        },
        Serialize: function (container) {
            return KeyValueCollection.Actions.Serialize(container, this.Validate);
        },
        Deserialize: function (container, value) {
            KeyValueCollection.Actions.DeSerialize(container, value, 'Key', 'Value', 'PageEnvData.Actions.AddKeyData');
        }
    }
}


var ErrorData =
{
    Actions: {

        Validate: function (key, value) {
            return KeyValueCollection.Actions.checkRegexp(key, /^([0-9])+$/, "Invalid Error Status Code. Please Enter Numeric Error Code.") &&
                   KeyValueCollection.Actions.checkRegexp(value, new RegExp("^/.*"), "Invalid Errorpage Url. Please Enter Url Starting With \\.");
            //KeyValueCollection.Actions.checkRegexp(value, new RegExp("^(((http(s?)))\:\/\/)?(www.|[a-zA-Z].)[a-zA-Z0-9\-\.]+\.([a-zA-Z]{2,3})(\:[0-9]+)*(\/($|[a-zA-Z0-9\.\,\;\?'\\\+&%\$#\=~_\-]+))*$", "g"), "Invalid Errorpage url");
        },
        AddKeyData: function (container) {
            return KeyValueCollection.Actions.AddKeyData(container, this.Validate);
        },
        Serialize: function (container) {
            return KeyValueCollection.Actions.Serialize(container, this.Validate);
        },
        Deserialize: function (container, value) {
            KeyValueCollection.Actions.DeSerialize(container, value, 'Status Code', 'Error Page Url', 'ErrorData.Actions.AddKeyData');
        }
    }
}

var KeyValueCollection =
{
    Actions:
    {
        checkLength: function (o, n, min, max) {
            if (o.val().length == 0 && min > 0) {
                o.addClass('ui-state-error');
                TemplarFx.ShowMsg('Error', n + " is required.", 'Error');
                return false;
            }
            else if (o.val().length > max || o.val().length < min) {
                o.addClass('ui-state-error');
                if (min == max)
                    TemplarFx.ShowMsg('Error', "Length of " + n + " must be equal to " + max + ".", 'Error');
                else
                    TemplarFx.ShowMsg('Error', "Length of " + n + " must be between " + min + " and " + max + ".", 'Error');
                return false;
            }
            return true;
        },
        checkRegexp: function (o, regexp, n) {
            if (!(regexp.test(o.val()))) {
                o.addClass('ui-state-error');
                TemplarFx.ShowMsg('Error', n, 'Error');
                return false;
            }
            return true;
        },
        CheckIfExists: function (o, n, lists) {
            var bExists = false;
            lists.each(function (index) {
                if (index != (lists.length - 1)) {
                    if ($(this).html().toLowerCase() == o.val().toLowerCase()) {
                        bExists = true;
                        return;
                    }
                }
            });
            if (bExists) {
                o.addClass('ui-state-error');
                TemplarFx.ShowMsg('Error', n + " already exists.", 'Error');
            }
            return bExists;
        },
        AddKeyData: function (control, validateFunction) {
            var parentTR = $(control).parent().parent();
            var headerTD = parentTR.parent().find('tr:first-child td');
            var keyHeader = $(headerTD[0]).val();
            var valueHeader = $(headerTD[1]).val();

            var textControls = parentTR.find(':text');
            var key = $(textControls[0]);
            var value = $(textControls[1]);

            key.removeClass('ui-state-error');
            value.removeClass('ui-state-error');
            var bValid = true;
            bValid = bValid && validateFunction(key, value) && !this.CheckIfExists(key, 'Key', parentTR.parent().find('ul li:first-child'));
            if (bValid) {
                key.val(trim(key.val()));
                value.val(trim(normalize(value.val())));
                $(control).parent().parent().before('<ul>' +
                    '<li>' + key.val() + '</li>' +
                    '<li>' + value.val() + '</li>' +
                    '<li><a onclick="javascript:return DeleteRow(this);" title="Remove">' +
                    '<span class="ui-icon ui-icon-trash"></span></a></li>' +
                    '</ul>');
                key.val('');
                value.val('');
            }

            return false;
        },

        Serialize: function (control) {
            var kvc = '';
            var colList = $('#' + control + ' div.KeyValueCollection ul');

            colList = colList.filter(function (ind) { return ind > 0 && ind < colList.length - 1; });

            colList.each(function (indexInner) {
                kvc = kvc + String.format('{{"K":"{0}","V":"{1}"}},', $($(this).children('li')[0]).text(), escapeAllQuotes($($(this).children('li')[1]).text()));
            });
            if (kvc.length > 0)
                kvc = kvc.substring(0, kvc.length - 1);

            return '[' + kvc + ']';
        },
        DeSerialize: function (control, value, headerKey, headerValue, functionforAdd) {
            var keyvaluecolHolder = $('#' + control + ' div.KeyValueCollection');
            //Sort KeyvalueCollection
            var KVC = Sys.Serialization.JavaScriptSerializer.deserialize(value).sort(function (a, b) { return a.K > b.K ? 1 : (a.K < b.K ? -1 : 0); });

            var tRow = '<ul class="ui-widget-header ui-corner-all">' +
                                '<li>' + headerKey + '</li>' +
                                '<li>' + headerValue + '</li>' +
                                '<li>&nbsp;</li>' +
                            '</ul>';
            for (var index = 0; index < KVC.length; index++) {
                tRow = tRow + '<ul>' +
                                    '<li>' + KVC[index].K + '</li>' +
                                    '<li>' + KVC[index].V + '</li>' +
                                    '<li>' +
                                        '<a onclick="javascript:return DeleteRow(this);" title="Remove"><span class="ui-icon ui-icon-trash"></span></a>' +
                                    '</li>' +
                                 '</ul>';
            }

            tRow = tRow + '<ul>' +
                                '<li>' +
                                    '<input type="text" class="ui-widget-content ui-corner-all" style="width: 98%;" value="" />' +
                                '</li>' +
                                '<li>' +
                                    '<input type="text" class="ui-widget-content ui-corner-all" style="width: 98%;" value="" />' +
                                '</li>' +
                                '<li>' +
                                    '<input type="button" class="ui-state-default ui-corner-all" onclick="return ' + functionforAdd + '(this);" value="Add" />' +
                                '</li>' +
                            '</ul>';


            keyvaluecolHolder.html(tRow);
        }
    }
}

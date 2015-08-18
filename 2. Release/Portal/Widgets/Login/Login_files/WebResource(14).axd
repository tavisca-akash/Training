(function () { var _after = 1, _afterThrow = 2, _afterFinally = 3, _before = 4, _around = 5, _intro = 6, _regexEnabled = true, _arguments = "arguments", _undef = "undefined", getType = (function () { var toString = Object.prototype.toString, toStrings = {}, nodeTypes = { 1: "element", 3: "textnode", 9: "document", 11: "fragment" }, types = "Arguments Array Boolean Date Document Element Error Fragment Function NodeList Null Number Object RegExp String TextNode Undefined Window".split(" "); for (var i = types.length; i--; ) { var type = types[i], constructor = window[type]; if (constructor) { try { toStrings[toString.call(new constructor)] = type.toLowerCase() } catch (e) { } } } return function (item) { return item == null && (item === undefined ? _undef : "null") || item.nodeType && nodeTypes[item.nodeType] || typeof item.length == "number" && (item.callee && _arguments || item.alert && "window" || item.item && "nodelist") || toStrings[toString.call(item)] } })(); var isFunc = function (obj) { return getType(obj) == "function" }; var weaveOne = function (source, method, advice) { var old = source[method]; if (advice.type != _intro && !isFunc(old)) { var oldObject = old; old = function () { var code = arguments.length > 0 ? _arguments + "[0]" : ""; for (var i = 1; i < arguments.length; i++) { code += "," + _arguments + "[" + i + "]" } return eval("oldObject(" + code + ");") } } var aspect; if (advice.type == _after || advice.type == _afterThrow || advice.type == _afterFinally) { aspect = function () { var returnValue, exceptionThrown = null; try { returnValue = old.apply(this, arguments) } catch (e) { exceptionThrown = e } if (advice.type == _after) { if (exceptionThrown == null) { returnValue = advice.value.apply(this, [returnValue, method]) } else { throw exceptionThrown } } else { if (advice.type == _afterThrow && exceptionThrown != null) { returnValue = advice.value.apply(this, [exceptionThrown, method]) } else { if (advice.type == _afterFinally) { returnValue = advice.value.apply(this, [returnValue, exceptionThrown, method]) } } } return returnValue } } else { if (advice.type == _before) { aspect = function () { advice.value.apply(this, [arguments, method]); return old.apply(this, arguments) } } else { if (advice.type == _intro) { aspect = function () { return advice.value.apply(this, arguments) } } else { if (advice.type == _around) { aspect = function () { var invocation = { object: this, args: Array.prototype.slice.call(arguments) }; return advice.value.apply(invocation.object, [{ arguments: invocation.args, method: method, proceed: function () { return old.apply(invocation.object, invocation.args) } }]) } } } } } aspect.unweave = function () { source[method] = old; pointcut = source = aspect = old = null }; source[method] = aspect; return aspect }; var search = function (source, pointcut, advice) { var methods = []; for (var method in source) { var item = null; try { item = source[method] } catch (e) { } if (item != null && method.match(pointcut.method) && isFunc(item)) { methods[methods.length] = { source: source, method: method, advice: advice} } } return methods }; var weave = function (pointcut, advice) { var source = typeof (pointcut.target.prototype) != _undef ? pointcut.target.prototype : pointcut.target; var advices = []; if (advice.type != _intro && typeof (source[pointcut.method]) == _undef) { var methods = search(pointcut.target, pointcut, advice); if (methods.length == 0) { methods = search(source, pointcut, advice) } for (var i in methods) { advices[advices.length] = weaveOne(methods[i].source, methods[i].method, methods[i].advice) } } else { advices[0] = weaveOne(source, pointcut.method, advice) } return _regexEnabled ? advices : advices[0] }; jQuery.aop = { after: function (pointcut, advice) { return weave(pointcut, { type: _after, value: advice }) }, afterThrow: function (pointcut, advice) { return weave(pointcut, { type: _afterThrow, value: advice }) }, afterFinally: function (pointcut, advice) { return weave(pointcut, { type: _afterFinally, value: advice }) }, before: function (pointcut, advice) { return weave(pointcut, { type: _before, value: advice }) }, around: function (pointcut, advice) { return weave(pointcut, { type: _around, value: advice }) }, introduction: function (pointcut, advice) { return weave(pointcut, { type: _intro, value: advice }) }, setup: function (settings) { _regexEnabled = settings.regexMatch } } })();

(function ($, context, core) {

	var pageId = -1,
		userName = '',
		isPolling = false,
		lastLogId = 0,
		pollDuration = defaultPollDuration,
		maxPollDuration = 900000,
		defaultPollDuration = 30000,
		logEntriesToDisplay = 5,
		logDisplayButton = '<div><a id="lnkShowActivityLog" href="#" title="View activity logs"><div id="divActivityLogIcon" style="display: inline; float: left;" class="templar-toolbaricon templar-log_inactive"></div></a></div>',
		markUp = '<div id="activityLogs" style="display:none;width:150px;background-color:White;">' +
					'<div id="activityLogEntries">' +
						'<div style="clear:both;"></div>' +
					'</div>' +
					'<div id="divAddLogEntry" style="float:right;font-weight:bold;padding:3px;" class="ui-state-default">' +
						'<a href="#" onclick="$(\'#divUserLogEntry\').toggle();$(\'#divAddLogEntry\').toggle();return false;">Add log entry</a>' +
					'</div>' +
					'<div id="divUserLogEntry" style="display:none;">' +
						'<textarea style="width: 100%;" id="txtLogEntry"></textarea>' +
						'<input type="button" class="ui-state-default" value="Cancel" onclick="$(\'#divUserLogEntry\').toggle();$(\'#divAddLogEntry\').toggle();" style="float: right; margin-top: 5px; margin-left: 5px; cursor: pointer; padding: 3px;">' +
						'<input id="btnAddLogEntry" class="ui-state-default" type="button" value="Add Entry" style="float: right; margin-top: 5px; padding: 3px; cursor: pointer;">' +
					'<div>' +
				'</div>',
		log = function (msg, isBySystem) {
			var entry = {};
			entry.PId = pageId;
			entry.M = msg;
			entry.IS = isBySystem;

			core.AddLog(entry);

			pollDuration = defaultPollDuration;
		},
		poll = function () {
			var pages = [];
			var data = {};
			data.Id = lastLogId;
			data.PId = pageId;
			pages.push(data);
			core.GetLogs(pages, function (logs) {
				displayLog(logs);
				setTimeout(function () { poll(); }, pollDuration);
			});
		},
		updateLog = function () {
			var pages = [],
				data = {};
			data.Id = lastLogId;
			data.PId = pageId;
			pages.push(data);
			core.GetLogs(pages, function (logs) {
				displayLog(logs);
			});
		},
		displayLog = function (logList) {
			if (logList && logList.length > 0) {
				pollDuration = defaultPollDuration;
				var logs = logList[0],
					previousTime,
					currentTime,
					markUp = '',
					notified = false,
					typeIcon = '',
					i = 0,
					chatIcon = '<div style="float:left;" class="ui-icon ui-icon-chat ui-button"></div>';

				previousTime = $('#activityLogs').data('time')
				$('#activityLogs').data('time', logs.T.toLowerCase().replace(' ', ''));
				currentTime = $('#activityLogs').data('time');
				updateTimeInLogs(previousTime, currentTime);
				$('#activityLogs').dialog('option', 'title', 'Activity Logs ( ' + logs.T.toLowerCase().replace(' ', '') + ' )');
				if (logs.L.length > 0) {
					lastLogId = logs.L[0].Id;
					$('#divActivityLogIcon').removeClass('templar-log_inactive').addClass('templar-log_active');
				}

				if (logs && logs.L && logs.L.length > 0) {
					for (i = logs.L.length - 1; i >= 0; i -= 1) {
						if (!notified && logs.L[i].UN !== userName) {
							showNotification(logs.L[i]);
							notified = true;
						}
						if (logs.L[i].IS === '1') {
							typeIcon = '';
						} else {
							typeIcon = chatIcon;
						}
						markUp += '<div class="logEntry" style="float:left;clear:left;width:100%;">' +
									typeIcon +
									'<div style="float:right;" class="ui-icon ui-icon-trash ui-button removeLogEntry"></div>' +
									'<div style="float:left;">' + logs.L[i].M + '</div>' +
									'<div style="float:left;clear:left;font-size:11px;color:#808080;"><span class="logTime">';
						if (+(logs.L[i].T) > 0) {
							markUp += logs.L[i].T + '</span><span> minutes ago</span> by ';
						} else {
							markUp += 'just now </span><span></span> by ';
						}
						markUp += logs.L[i].UN + '</div>' +
									'<div style="float:left;clear:left;width:100%;"><hr></div>' +
								'</div>';
					}
				}
				$(markUp).insertBefore('#activityLogEntries > div:last-child');

				var length = $('#activityLogEntries > .logEntry').length;
				if (length > logEntriesToDisplay) {
					$('#activityLogEntries > .logEntry').slice(0, length - logEntriesToDisplay).remove();
				}
			} else {
				pollDuration = 2 * pollDuration;
				if (pollDuration > maxPollDuration) {
					pollDuration = maxPollDuration;
				}
			}
		},
		logAndSync = function (msg, isBySystem) {
			log(msg, isBySystem);
			updateLog();
		},
		displayLogModal = function () {
			$('#divActivityLogIcon').removeClass('templar-log_active').addClass('templar-log_inactive');
			var heading = 'Activity Logs ( ' + $('#activityLogs').data('time') + ' )';
			$('#activityLogs').dialog({ minHeight: 0, modal: false, title: heading });
			$('form').click(function () {
				$('#activityLogs').dialog('close');
			});
		},
		updateTimeInLogs = function (previousTime, currentTime) {
			if (!previousTime || !currentTime) {
				return;
			}
			var previousMinutes = +previousTime.substring(0, previousTime.indexOf(':')) * 60 + (previousTime.substring(previousTime.indexOf(':') + 1, previousTime.indexOf(':') + 3) - 0);
			var currentMinutes = +currentTime.substring(0, currentTime.indexOf(':')) * 60 + (currentTime.substring(currentTime.indexOf(':') + 1, currentTime.indexOf(':') + 3) - 0);
			var difference = currentMinutes - previousMinutes;
			$('#activityLogs').find('.logTime').each(function () {
				var pt = $(this).text().trim();
				if (+pt) {
					$(this).text(+pt + difference);
				} else if (difference > 0) {
					$(this).text(difference);
					$(this).siblings().filter('span').text(' minutes ago');
				}
			});
		},
		showNotification = function (logEntry) {
			var logNotifier = $('#logNotification');
			if (logNotifier.length === 0) {
				logNotifier = '<div id="logNotification" class="infoMsg" style="z-index:1000;display:none;float: none;left: 0;margin: 0;padding-top: 14px;position: absolute;right: 0;top: 0;"></div>';
				$('body').append(logNotifier);
			}
			if (+(logEntry.T) > 0) {
				$('#logNotification').text(logEntry.M + ' ' + logEntry.T + ' minutes ago by ' + logEntry.UN).show().delay(3000).slideUp(500);
			} else {
				$('#logNotification').text(logEntry.M + ' ' + ' just now by ' + logEntry.UN).show().delay(3000).slideUp(500);
			}
		},
		addPublishPageLog = function () {
			var pageObj = {};
			pageObj.UN = userName;
			pageObj.Id = pageId;
			var pageIdJson = Sys.Serialization.JavaScriptSerializer.serialize(pageObj);
			$.ajax({
				type: "POST",
				contentType: "application/json",
				url: serviceUrl + "/addpublishlog/1",
				data: pageIdJson,
				dataType: 'json',
				cache: false,
				processData: false
			});
		};

	context.DesignerActivityLogger = {};
    var intialised = false;
	context.DesignerActivityLogger.Init = function (uName) {

		userName = uName;
		pageId = $('input[type="hidden"][id$="hfPageId"]').val();
		$('.designer-toolbar > div:nth-child(2) > div:first').append(logDisplayButton);

		$('#lnkShowActivityLog').click(function () {
			displayLogModal();
			return false;
		});

        if(intialised)
            return;

        intialised = true;

		$('body').append(markUp);

		//binding remove log entry
		$('#activityLogEntries').delegate('.removeLogEntry', 'click', function () {
			$(this).closest('.logEntry').remove();
		});

		//binding manual log entry
		$('#btnAddLogEntry').click(function () {
			$('#divUserLogEntry').toggle();
			$('#divAddLogEntry').toggle();
			var msg = $('#txtLogEntry').val();
			$('#txtLogEntry').val('');
			logAndSync(msg, '0');
		});

		//binding add widget
		$.aop.before({ target: TemplarFx.Designer.Actions, method: 'onWidgetAdd' }, function (args) {
			var widgetName = $('#upMultiView .new_Widget[data-widgetid="' + args[1] + '"]').attr('title');
			logAndSync('Added ' + widgetName + ' widget', '1');
		});

		//binding move widget
		$.aop.before({ target: TemplarFx.Designer.Actions, method: 'onDrop' },
			function (args) {
				var instanceId = args[2];
				var widgetName = $('.MyWidget[data-instanceid="' + instanceId + '"]').find('.MyHeader').text().trim();
				logAndSync('Moved ' + widgetName + ' widget', '1');
			}
		);

		//binding delete widget
	    //Moved this code to after confirming widget deletion
		/*
        $('div[id$="AlignContainer_Page"]').delegate('a[id$="CloseWidget"]', 'click', function () {
			var widgetName = $(this).parent().find('.MyHeader').text().trim();
			logAndSync('Deleted ' + widgetName + ' widget', '1');
		});*/
	    TemplarFx.LogAndSync = logAndSync;

		//binding change in page layout
		$('#upMultiView').delegate('#PageLayoutDataList td > a', 'click', function () {
			var layoutName = $(this).find('img').attr('alt');
			logAndSync('Changed page layout to ' + layoutName, '1');
		});

		//binding change in page settings
		$('#upModalPopup').delegate('#btnSavePageData', 'click', function () {
			logAndSync('Updated page setting', '1');
		});

		//binding page publish
		$('#upModalPopup').delegate('#btnSaveDesign', 'click', function () {
			addPublishPageLog(pageId);
		});

		updateLog();
		setTimeout(function () { poll(); }, defaultPollDuration);
	};

} (TemplarFx.jq, TemplarFx, TemplarFx.ActivityLogger));
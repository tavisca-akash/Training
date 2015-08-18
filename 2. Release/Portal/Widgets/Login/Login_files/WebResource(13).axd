/*globals Sys,TemplarFx */



/*** ActivityLogger Core ***/
(function ($, context) {
	var userName = '',
		serviceUrl = '';

	context.ActivityLogger = {};

	context.ActivityLogger.Init = function (uName, svcUrl) {
		userName = uName;
		serviceUrl = svcUrl;
	};

	context.ActivityLogger.AddLog = function (logEntryObj, callbackFn) {
		logEntryObj.UN = userName;
		var logEntry = window.JSON.stringify(logEntryObj);
		$.ajax({
			type: "POST",
			contentType: "application/json",
			url: serviceUrl + "/addlog",
			data: logEntry,
			dataType: 'json',
			cache: false,
			processData: false,
			success: function (response) {
				if (typeof (callbackFn) === 'function') {
					callbackFn(response);
				}
			},
			error: function () {
				if (typeof (callbackFn) === 'function') {
					callbackFn(false);
				}
			}
		});
	};

	context.ActivityLogger.GetLogs = function (pagesInfo, callbackFn) {
		var i = 0,
			userJson;
		for (i = 0; i < pagesInfo.length; i += 1) {
			pagesInfo[i].UN = userName;
		}

		userJson = window.JSON.stringify(pagesInfo);
		$.ajax({
			type: "POST",
			contentType: "application/json",
			url: serviceUrl + "/viewlog",
			data: userJson,
			dataType: 'json',
			cache: false,
			processData: false,
			success: function (logs) {
				if (typeof (callbackFn) === 'function') {
					callbackFn(logs);
				}
			},
			error: function () {
				if (typeof (callbackFn) === 'function') {
					callbackFn(undefined);
				}
			}
		});
	};

} (TemplarFx.jq, TemplarFx));

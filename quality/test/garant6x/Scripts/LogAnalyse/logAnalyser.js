var fso = new ActiveXObject("Scripting.FileSystemObject");
var WshShell = WScript.CreateObject("WScript.Shell");
var WshNetwork = WScript.CreateObject("WScript.Network");
var endOfLine = "\r\n";
var ForReading = 1;
var ForWriting = 2;
var IT_SERVER = 1;
var IT_CLIENT = 2;
var IT_INTRANET = 3;
var MAX_LOG_SIZE_TO_ATTACH = 1024*1024; // если архив с логом больше этого значения, то он не отправляется на почту
var MAX_LOG_SIZE_TO_PACK = 30*1024*1024; // еслим файл с логом больше этого значения, то он не пакуется и не отправляется

function IsNonEmptyString(str)
{
	return (str != null) && ((str instanceof String) || (typeof(str) == "string")) && (str != "");
}

function CompName()
{
	return WshNetwork.ComputerName;
}

///////////////////////////////////////////////////////////////////
// строка лога обязательно соответствует этому регэкспу
var rexpInclude = new RegExp("^.*(?:" +
	"UNKNOWN_EX:"+
	"|LM_ERROR" +
	"|LM_ALERT" +
	"|STD_EX" +
	"|Base pool:" +
	"|CORBA_EX:" +
").*?$", "mgi");
// и обязательно НЕ соответствует этому
var rexpExclude = new RegExp("(?:" +
	"BaseUpdate:update is not performed" +
	"|CanNotFindData:1\\.0:\\s*LegalDocument_i::get_correspond_list" +
	"|CanNotFindData:1\\.0:\\s*in UserManager" +
	"|CanNotFindData:1\\.0:\\s*Search(?:Mng|Manager)_i:*search" +
	"|already locked \\(errno == EACCES\\)" +
	"|IDL:garant\\.ru\\/GslUserManager\\/NoMoreConnections:1\\.0" +
	"|SavedQuery_i::create_attribute: can't create correct query" +
	"|LifeCycleManager_i::release_object: Warning! CORBA exception handled" +
")", "i");
///////////////////////////////////////////////////////////////////

function GetScriptPath()
{
	return fso.GetFile(WScript.ScriptFullName).ParentFolder;
}

function PackFileWithRAR(
	fileName,
	archiveName
)
{
	if (!fso.FileExists(fileName))
		return false;
	//
	if (fso.FileExists(archiveName))
		fso.DeleteFile(archiveName);
	//
	var cmdLine = "\"" + GetScriptPath() + "\\rar.exe\" a -m5 -dh -ep \"" + archiveName + "\" \"" + fileName + "\""; 
	WshShell.Run(cmdLine, 0, true);
	return true;
}

// Функция возвращает из указанного файла лога сервера массив сообщений, которые она считает
// ошибочными. Если таковых не найдено, то возвращается null 
function GetArrayOfErrors(
	logFileName // полный путь к файлу с логом
)
{	
	var bufSize = 2*1024*1024; // по столько символов будем читать файл
		
	var result = new Array();
				
	if ( fso.FileExists(logFileName) )
	{
		var logFile = fso.OpenTextFile(logFileName, ForReading);
		var str = new String();
		var tempArr = new Array();
		while ( !logFile.atEndOfStream )
		{
			str = logFile.Read(bufSize);
			if ( !logFile.atEndOfStream )
				str += logFile.ReadLine();

			tempArr = str.match(rexpInclude);
			
			if ( tempArr != null )
				for (var i = 0; i < tempArr.length; i++)
					if ( rexpExclude.exec(tempArr[i]) == null )
						result.push( tempArr[i] );
		}
		logFile.close();
	}
	return ((result.length > 0) ? result : null);
}

// Посылает пиьсмо в формате HTML с указанными параметрами
function SendMail(
	fromAddr, // от кого письмо
	toAddr, // кому письмо
	subj, // тема
	htmlBody, // текст в формате HTML
	attachFilesArr
) 
{ 
	var objEmail = WScript.CreateObject("CDO.Message"); 
	objEmail.Organization = "Garant.PU.OIT.QC";
	objEmail.AutoGenerateTextBody = false;
	//
	objEmail.From = fromAddr; 
	objEmail.To = toAddr; 
	objEmail.Subject = subj; 	
	objEmail.HTMLBody = htmlBody; 	
	//
	objEmail.BodyPart.Charset = "utf-8";
	objEmail.BodyPart.ContentTransferEncoding = "base64";
	objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2; 
	objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "smtp.garant.ru"; 
	objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25; 	
	objEmail.Configuration.Fields.Update();

	if (attachFilesArr instanceof Array)
	{ // нам передали массив
		for (var i=0; i < attachFilesArr.length; i++)
		{
			var fileName = attachFilesArr[i];
			if (fso.FileExists(fileName))
				objEmail.AddAttachment( fso.GetFile(fileName).Path );
		}
	}
	//
	objEmail.Send(); 
}

// Возвращает содержимое файла,
function GetFileBody(
	fileName // полный путь к файлу
)
{
	var result = "";
	if ( fso.FileExists(fileName) )
		result = fso.OpenTextFile(fileName, ForReading).ReadAll();
	return result;	
}



// Возвращает полный путь к папке где находится ГАРАНТ (garant.ini)
function GetPathToGarantFolder(
	pType
)
{
	var result = "";
	var str = "";
	var ex;
	
	if (pType == IT_SERVER)
		try {
			str = WshShell.RegRead("HKEY_LOCAL_MACHINE\\SOFTWARE\\Garant.F1\\ApplicationServerOptions");
		}
		catch (ex) {
			str = "";
		}
	else if (pType == IT_INTRANET)
		try {
			str = WshShell.RegRead("HKEY_LOCAL_MACHINE\\SOFTWARE\\Garant Intranet Data 5151:80\\ApplicationServerOptions");
		}
		catch (ex) {
			str = "";
		}		
	else if (pType == IT_CLIENT)
		try {
			str = WshShell.RegRead("HKEY_CURRENT_USER\\SOFTWARE\\Garant.F1\\ApplicationAdapterOptions");
		}
		catch (ex) {
			str = "";
		}
	else
		throw "Unknown pType: " + pType.toString();
	var rexp = /GCMConfigFile \"(.*)\\garant\.ini\"/i;
	var resArr = str.match(rexp);
	if (resArr != null)
		result = resArr[1];
	return result;	 
}

// Возвращает полный путь к файлу garant.ini
function GetPathToGarantINI(
	pType
)
{
	var result = GetPathToGarantFolder(pType);
	if (result != "")
		result += "\\garant.ini";
	return result;	 
}

// Возвращает значение из файла garant.ini
function GetValueFromGarantINI(
	pType, 
	sectionName, // имя секции (без квадратных скобок)
	paramName // имя параметра
)
{
	var iniBody = GetFileBody( GetPathToGarantINI(pType) );
	iniBody += endOfLine;
	//	
	var rexpSection = new RegExp("^\\[" + sectionName + "\\]$\\r\\n([\\s\\S]*?)\\r\\n(?:\\r\\n|^$)", "mi");
	var sectionBody = "";	
	var arr;
	if ( (arr=rexpSection.exec(iniBody)) != null )
		sectionBody = arr[1];
	//
	var rexpParam = new RegExp("^;{0}" + paramName + "=(.*?)$", "im");
	if ( (arr=rexpParam.exec(sectionBody)) != null )
		return arr[1];
	else
		return null;
}

// функция возвращает новые ошибки в логе с момента предыдущего запуска
function GetNewAndOldErrors(
	pathToLogFile,
	oldErrorsSuffix // суффикс файла со старыми ошибками. Нужен для того чтобы разные функции-пользователи (посылатель_писем и просто_просмотрщик) не пересекались.
)
{
	if ( IsNonEmptyString(oldErrorsSuffix) )
		oldErrorsSuffix = "." + oldErrorsSuffix;
	else
		oldErrorsSuffix = "";


	var oldErrorsFileName = pathToLogFile + oldErrorsSuffix + ".old_errors.txt";
	var arrOldErrors = new Array();	
	var result = new Object();
	result.oldErrors = null;
	result.newErrors = null;
	// получаем все ошибки
	
	if ( !fso.FileExists(pathToLogFile) )		
		throw "Log file can not be found!";	
	var arrNewErrors =	GetArrayOfErrors( pathToLogFile );
	if (arrNewErrors != null)
	{		 
		// полчаем строку, содержащую старые ошибки
		var strOldErrors = GetFileBody(oldErrorsFileName);
		// пишем в файл со старыми ошибками новые ошибки
		fso.OpenTextFile(oldErrorsFileName, ForWriting, true).write( arrNewErrors.join(endOfLine) );
	
		// из массива со всеми ошибками выбрасываем все старые ошибки
		var i;
		if (( arrNewErrors.length != 0 ) && (strOldErrors != ""))
			for (i = arrNewErrors.length-1 ; i >= 0 ; i--)
				if ( strOldErrors.indexOf(arrNewErrors[i]) != -1 )
				{
					arrOldErrors.push(arrNewErrors[i]);
					arrNewErrors.splice(i, 1);
				}
	
		result.oldErrors = (((arrOldErrors != null)&&(arrOldErrors.length > 0)) ? arrOldErrors : null);
		// теперь в arrNewErrors у нас только новые ошибки
		result.newErrors = (((arrNewErrors != null)&&(arrNewErrors.length > 0)) ? arrNewErrors : null);
	}
	return result;
}

function CreateHTMLTableFromErrors(
	tableTitle,
	arrErrors
)
{
	var tableClass = Math.round( Math.random()*1000000000 ).toString();
	//
	var result = new Object();		
	// составляем таблицу
	var table = 	
		"<table border=1 align=center class=\"" + tableClass + "\">" +
		"<caption>" + tableTitle + "</caption>" + endOfLine;
	var rowClass = "";		
	for (var i = 0; i < arrErrors.length; i++)
	{
		if (arrErrors[i].indexOf("LM_ALERT") != -1)
			rowClass = "lm_alert";
		else if (arrErrors[i].indexOf("STD_EX") != -1)
			rowClass = "std_ex";
		else if (arrErrors[i].indexOf("Base pool") != -1)
			rowClass = "base_pool";
		else 	
			rowClass = "";
		table += "<tr class=\"" + rowClass + "\"><td><tt>" + arrErrors[i] + "</tt></td></tr>" + endOfLine; 
	}
	table += "</table>";
	result.tableBody = table;
	//
	result.tableStyles = 
		"table." + tableClass + " caption {font-size: large}" + endOfLine + 
		"table." + tableClass + " tr.lm_alert {background:red}" + endOfLine +
		"table." + tableClass + " tr.std_ex {background:red}" + endOfLine +
		"table." + tableClass + " tr.base_pool {background:yellow}";
	return result;
}

function GetLogFileNameByINIType(
	iniType	
)
{
	var logFileName = null;
	if ( GetPathToGarantINI(iniType) != "" )
	{ // если инишник есть
		var iniSection = "";
		var product = GetValueFromGarantINI(iniType, "Version", "-Product");
		if ( (iniType == IT_SERVER) || (iniType == IT_INTRANET) )
		{ // для серверного инишника
			if (product == "server")
				iniSection = "F1Server Params";
			else if ((product == "client") || (product == "fileserver") || (product == "desktop") || (product == "cd_or_dvd"))
				WScript.Quit();
			else
				throw "Unknown product!";
		}
		else if (iniType == IT_CLIENT)
		{ // для адаптерного инишника
			if ((product == "server") || (product == "client"))
				iniSection = "F1Client Params";
			else if ((product == "fileserver") || (product == "desktop"))
				iniSection = "F1Server Params";
			else if (product == "cd_or_dvd")
				WScript.Quit();
			else
				throw "Unknown product!";
		}
		else
			throw "Unknown ini-type";
		//
		logFileName = GetValueFromGarantINI(iniType, iniSection, "-SBELogFile");
		//
		if (logFileName != null)
			return WshShell.ExpandEnvironmentStrings(logFileName);		
	}	
	return logFileName;
}

// Отсылает письмо с новыми ошибками на указанный адрес
function CheckForErrorsAndSendEmail(
	toAddr, // на этот адрес посылаются пиьсма без аттача
	toAddrWithAttach // на этот адрес посылаются письма с аттачем, если пусто то аттач вообще не изготавливается
)
{
	//
	var isAttachLog = false;
	if ( IsNonEmptyString(toAddrWithAttach) )
	{
		isAttachLog = true;
	}
	// получаем массив в новыми ошибками
	var logFileName = GetLogFileNameByINIType(IT_SERVER);
	arrNewErrors = GetNewAndOldErrors(logFileName).newErrors;
	if (arrNewErrors != null) 
	{
		// формируем письмо
		//
		// составляем таблицу
		var tableObj = CreateHTMLTableFromErrors("Таблица с сообщениями об ошибках", arrNewErrors);
		var tableBody = tableObj.tableBody;
		var tableStyles = tableObj.tableStyles;
		//

		// создаем аттач		
		var logFileSize = fso.GetFile(logFileName).Size;
		var archiveFileSize;
		var isAttached = false;
		var isBadLogSize = true;
		var isBadArchiveSize = true;
		var attachErr = "";
		//		//
		var attachments = new Array();
		if (isAttachLog = true)
		{
			if ( logFileSize <= MAX_LOG_SIZE_TO_PACK ) // если размер лога не превышает заданной границы
			{ // то пакуем его
				isBadLogSize = false;
				var archiveFileName = WshShell.ExpandEnvironmentStrings("%TEMP%") + "\\" + fso.GetFile(logFileName).Name + ".rar";
				if ( PackFileWithRAR(logFileName, archiveFileName) && fso.FileExists(archiveFileName)
				) // если архив создали 
				{ // то отправляем
					archiveFileSize = fso.GetFile(archiveFileName).Size;
					if ( archiveFileSize <= MAX_LOG_SIZE_TO_ATTACH)
					{
						attachments.push(archiveFileName);
						isBadArchiveSize = false;
						isAttached = true;
					}
				}
			}
			//
			if (!isAttached)
			{
				attachErr = attachErr + "<p> Лог не приаттачен. ";
				if (isBadLogSize)
					attachErr = attachErr + "Размер лога (" + logFileSize + " байт) больше допустимого (" + MAX_LOG_SIZE_TO_PACK + " байт).";
				else if (isBadArchiveSize)
					attachErr = attachErr + "Размер архива с логом (" + archiveFileSize + " байт) больше допустимого (" + MAX_LOG_SIZE_TO_ATTACH + " байт).";
				attachErr = attachErr + endOfLine;
			}
		}
		else
			attachments = null;


		// составляем само сообщение
		var htmlBody = new String();
		htmlBody =			
			"<html>" + endOfLine +
				"<head>" + endOfLine +
				"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=Windows-1251\">" + endOfLine +
				"<style>" + endOfLine +
				tableStyles + endOfLine +
				"</style>" + endOfLine +
					"<title>Ошибки в логе сервера на машине " + WshNetwork.ComputerName + "</title>" + endOfLine +
				"</head>" + endOfLine +
				"<body>" + endOfLine +
					"<p>Ошибки в логе сервера на машине <b>" + WshNetwork.ComputerName + "</b>" + endOfLine +
					attachErr +					
					"<hr>" + endOfLine +					
					tableBody + endOfLine +
				"</body>" + endOfLine +
			"</html>";


		// высылаем письмо
		var fromAddr = "logAnalyser@garant.ru";
		var letterSubj = "В логе сервера на машине " + WshNetwork.ComputerName + " обнаружены ошибки!";
			// сначала простое
		if ( IsNonEmptyString(toAddr) )
		{
			SendMail(fromAddr, toAddr, letterSubj, htmlBody);
		}
			// затем с аттачем
		if (isAttachLog)
		{
			SendMail(fromAddr, toAddrWithAttach, letterSubj, htmlBody, attachments);
		}
	}		
}



function _LastLineFile(
	lastLineFileName
)
{
	this.lastLineFileName = lastLineFileName;
	
	this.OpenNode = function( 
		nodeName, // имя ноды
		isForceCreate
	)
	{
		// открываем xml-хранилище
		var objDoc = new ActiveXObject("Msxml2.DOMDocument.3.0");
		if (fso.FileExists(this.lastLineFileName))
		try {
			objDoc.load(this.lastLineFileName);
		} catch (e) {
			objDoc = new ActiveXObject("Msxml2.DOMDocument.3.0");
		}
			
		var objRootNode = null;
		var objRootColl = objDoc.getElementsByTagName("root");
		if (objRootColl.length == 0) {
			objRootNode = objDoc.createNode(1, "root", "");
			objDoc.appendChild(objRootNode);
		} else
			objRootNode = objRootColl.item(0);
				
		// запрашиваем существующие ноды
		var objNode = null;
		var objNodeColl = objDoc.getElementsByTagName(nodeName);
		if (objNodeColl.length == 0) {
			// создаем ноду
			if ((isForceCreate != null) && (isForceCreate)) {
				objNode = objDoc.createNode(1, nodeName, "");
				objRootNode.appendChild(objNode);
			}
		} else	{
			// получаем существующую
			objNode = objNodeColl.item(0);
		}
		//
		return objNode;
	}
	
	
	this.CloseNode = function(
		objNode // объект ноды
	)
	{
		objNode.ownerDocument.save(this.lastLineFileName);
	}
	
	this.GetLastLine = function()
	{
		var lastLineNode = this.OpenNode("last_line");
		if (lastLineNode != null)
			return lastLineNode.text;
		else
			return null;			
	}
	
	this.SetLastLine = function(lastLine)
	{
		var lastLineNode = this.OpenNode("last_line", true);
		lastLineNode.text = lastLine;
		this.CloseNode(lastLineNode);
	}
	
	this.GetTimeStamp = function()
	{
		var timeStampNode = this.OpenNode("time_stamp");
		if (timeStampNode != null)
			return timeStampNode.text/1;
		else
			return null;			
	}
	
	this.SetTimeStamp = function(timeStamp)
	{
		var timeStampNode = this.OpenNode("time_stamp", true);
		timeStampNode.text = timeStamp;
		this.CloseNode(timeStampNode);
	}

	this.GetAlwaysReported = function()
	{
		var alwaysReportedNode = this.OpenNode("always_reported");
		if (alwaysReportedNode != null)
			return alwaysReportedNode.text == true.toString();
		else
			return null;
	}
	
	this.SetAlwaysReported = function(isAlwaysReported)
	{
		var alwaysReportedNode = this.OpenNode("always_reported", true);
		alwaysReportedNode.text = (isAlwaysReported == true).toString();
		this.CloseNode(alwaysReportedNode);
	}
}

// Смотрит последнюю строку лог-файла. Если она не изменилась со времени последнего запуска функции, то возвращает объект со
// свойствами LastLine и TimeDiff - соотстветсвенно, последняя строка и промежуток времени между текущим временем запуска
// функции и временем когда была запомнена последняя строка.
// Если строка не изменялась, то возвращаем null.
function GetLogLastLineIfItChanged(
	iniType, // тип инишника
	isReportOnlyOne // true - если один раз уже сообщили о неизменившейся строке, то больше не сообщать (выдавать null). false - сообщать всегда.
)
{
	var MAX_LINE_LENGTH = 4096;

	// определяем путь к логу
	var pathToLogFile = GetLogFileNameByINIType(iniType);
	if ( !fso.FileExists(pathToLogFile) )		
		throw "Log file can not be found!";	
	// формируем путь к файлу хранилищу последней строки
	var lastLineFileName = pathToLogFile + '.last_line.txt';
	var lastLineStorage = new _LastLineFile(lastLineFileName);
	
	// получаем текущую последнюю строку
	var logFile = fso.OpenTextFile(pathToLogFile, ForReading);
		// позиционируемся в файл ориентировочно перед последней строкой
	var toSkip = fso.GetFile(pathToLogFile).Size - MAX_LINE_LENGTH;
	if (toSkip > 0) {
		logFile.Skip(toSkip);
	}
		// читаем построчно до последней строки
	var currLastLine = "";
	while (!logFile.AtEndOfStream)
		currLastLine = logFile.ReadLine();
	// к этому моменту currLastLine должна содержать последнюю строку лога или быть пустой
	var currTime = (new Date()).getTime();	
	
	// теперь узнаем последнюю строку на момент предыдущего запуска функции
	var prevLastLine = lastLineStorage.GetLastLine();
	var prevTime = lastLineStorage.GetTimeStamp();
	var isAlwaysReported = lastLineStorage.GetAlwaysReported();	
	// к этому моменту prevLastLine содержит последнюю строку на момент последнего запуска функции, или null
		
	// сравниваем	
	if ( (prevLastLine != null) && (currLastLine == prevLastLine) )
	{ // строки одинаковые
		if ((isReportOnlyOne != null) && isReportOnlyOne && isAlwaysReported)
			return null;
		var result = new Object();
		result.LastLine = currLastLine;
		result.TimeDiff = currTime - prevTime;
		lastLineStorage.SetAlwaysReported(true);
		return result;
	}
	else 
	{ // строки разные
		// сохраняем текущую последнюю строку в файл
		lastLineStorage.SetLastLine(currLastLine);
		lastLineStorage.SetTimeStamp(currTime);
		lastLineStorage.SetAlwaysReported(false);
		return null;
	}
}

// проверяет, если последняя строка лог-файла с момента последнего запуска функции не изменилась, то высылает e-mail об этом
function CheckForLastLogLineNotChangedAndSendEMail(
	toAddr
)
{
	var resObj = GetLogLastLineIfItChanged(IT_SERVER, true);
	
	if (resObj != null)
	{		
		var htmlBody = new String();
		htmlBody =			
			"<html>" + endOfLine +
				"<head>" + endOfLine +
					"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=Windows-1251\">" + endOfLine +
					"<title>Не меняется последняя строка лог-файла на машине " + WshNetwork.ComputerName + "</title>" + endOfLine +
				"</head>" + endOfLine +
				"<body>" + endOfLine +				
					"<p>Последняя строка лога сервера на машине <b>" + WshNetwork.ComputerName + "</b> не менялась в течении " + resObj.TimeDiff/1000 + " секунд!" + endOfLine +
					"<hr>" + endOfLine +
					"Последняя строка лога сервера:<br>" +
					"<pre>" + resObj.LastLine + "</pre>"
				"</body>" + endOfLine +
			"</html>";		
		//
		var fromAddr = "logAnalyser@garant.ru";
		
		var letterSubj = "На машине " + WshNetwork.ComputerName + " в течение " + resObj.TimeDiff/1000 + " cекунд не менялась последняя строка лога сервера!";
		SendMail(fromAddr, toAddr, letterSubj, htmlBody);
	}
}

function GenerateHTMLDocWithErrors(
	logFileName, // тип лога
	docTitle	
)
{
	var htmlBody = null;
	var errorsTableObj = null;	
				
	if (logFileName != null)
	{
		var errorsArr = GetArrayOfErrors(logFileName);
		
		if (errorsArr != null)
			errorsTableObj = CreateHTMLTableFromErrors("Таблица с сообщениями об ошибках", errorsArr);
				
		htmlBody = new String();
		htmlBody =			
			"<html>" + endOfLine +
				"<head>" + endOfLine +
				"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=Windows-1251\">" + endOfLine +
				"<style>" + endOfLine +
					((errorsTableObj != null) ? errorsTableObj.tableStyles : "") + endOfLine +
				"</style>" + endOfLine +
					"<title>" + docTitle + "</title>" + endOfLine +
				"</head>" + endOfLine +
				"<body>" + endOfLine +
					"<p><big><center>Файл с логом: \"" + logFileName + "\"</center></big>" + endOfLine +
					"<hr>" + endOfLine +
					((errorsTableObj != null) ? errorsTableObj.tableBody : "<center>Ошибок нет</center>") + endOfLine +
				"</body>" + endOfLine +
			"</html>";
	}		

	return htmlBody;
}


function GenerateHTMLDocWithOldAndNewErrors(
	iniType, // тип лога
	docTitle	
)
{
	var logFileName;
	var htmlBody = null;
	var oldErrorsTableObj = null;
	var newErrorsTableObj = null;	
				
	logFileName = GetLogFileNameByINIType(iniType);
	if (logFileName != null)
	{
		var errorsObj = GetNewAndOldErrors(logFileName, "viewer");
		
		if (errorsObj.newErrors != null)
			newErrorsTableObj = CreateHTMLTableFromErrors("Таблица с сообщениями о новых ошибках", errorsObj.newErrors);

		if (errorsObj.oldErrors != null)
			oldErrorsTableObj = CreateHTMLTableFromErrors("Таблица с сообщениями о старых ошибках", errorsObj.oldErrors);
		
		
		htmlBody = new String();
		htmlBody =			
			"<html>" + endOfLine +
				"<head>" + endOfLine +
				"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=Windows-1251\">" + endOfLine +
				"<style>" + endOfLine +
					((newErrorsTableObj != null) ? newErrorsTableObj.tableStyles : "") + endOfLine +
					((oldErrorsTableObj != null) ? oldErrorsTableObj.tableStyles : "") + endOfLine +
				"</style>" + endOfLine +
					"<title>" + docTitle + "</title>" + endOfLine +
				"</head>" + endOfLine +
				"<body>" + endOfLine +
					"<p><big><center>Файл с логом: \"" + logFileName + "\"</center></big>" + endOfLine +
					"<hr>" + endOfLine +
					((newErrorsTableObj != null) ? newErrorsTableObj.tableBody : "<center>Новых ошибок нет</center>") + endOfLine +
					"<hr>" + endOfLine +					
					((oldErrorsTableObj != null) ? oldErrorsTableObj.tableBody : "<center>Старых ошибок нет</center>") + endOfLine +
				"</body>" + endOfLine +
			"</html>";
	}		

	return htmlBody;
}

//CheckForErrorsAndSendEmail("ushakov@garant.ru", true);


function RealTimeLogAnalyse(logFileName)
{		
	var logFile;
	var currLogSize = 0;
	var oldLogSize = 0;
	var isLogOpened = false;
	var isFirstLaunch = true;
	var logStr = "";
	
	while (true)
	{				
		if (isLogOpened)
		{ // файл уже открыт, с ним можно работать
			oldLogSize = currLogSize;
			currLogSize = fso.GetFile(logFileName).Size;
			
			if (!logFile.atEndOfStream)
			{ // из файла можно читать новые строки
				logStr = logFile.ReadLine();
				if ( (rexpInclude.test(logStr)) && (!rexpExclude.test(logStr)) )
					WshShell.Popup("В логе " + endOfLine + "\t" + logFileName + endOfLine + "найдена ошибка: " + endOfLine + "\t" + logStr, 0, "Ошибка в логе!", 16 );
			}
			else
			{ // новых данных в файле нет
				if ( currLogSize < oldLogSize )
				{ // если текущий размер файла меньше старого, то считаем что файл создали заново и его надо переоткрыть
					logFile.close();
					isLogOpened = false;
				}
				else
				{ // файл просто еще не обновился, ждем
					WScript.Sleep(500);
				}
			}				
		}			
		else
		{ // файл еще не открыт
			if ( fso.FileExists(logFileName) )
			{ // файл есть, открываем
				logFile = fso.OpenTextFile(logFileName, ForReading);
				isLogOpened = true;
				if (isFirstLaunch)
				{ // при первом запуске прыгаем в конец файла
					while (!logFile.atEndOfStream) logFile.ReadLine();
					isFirstLaunch = false;	
				}
				if (logStr != "") // если известна строка, которую обрабатывали последний раз
				{ // позиционируемся на последнюю известную строку файла
					var isPositioned = false;
					while (!logFile.atEndOfStream)
						if (logFile.ReadLine() == logStr)
						{ // нашли эту строку
							isPositioned = true;
							break;
						}
					if ( !isPositioned )
					{ // если не удалось спозиционироваться, то переоткрываем лог
						logFile.close();
						isLogOpened = false;
						logStr = "";						
					}					
				}
			}
			else	
			{ // файла нет, ждем
				WScript.Sleep(1000);
			}
		}
	}
}

// открывает файл на запись. Возвращает Null - если не удалось открыть файл на запись
// иначе возвращает объект файла, который вызывающий должен держать для сохранения залоченности файла.
function TryLockFile(lockFileName)
{
	var lockFile;
	//
	try	{
		lockFile = fso.OpenTextFile(lockFileName, ForWriting, true);
	}
	catch(ex)	{
		if (ex.number == -2146828218 ) //if "Permission denied"
			return null;
		else
			throw ex + " re-thrown";				
	}
	//
	return lockFile
}

function GetLockFileName(forWhat)
{
	var basePath = WshShell.ExpandEnvironmentStrings(WshShell.Environment("USER")("TMP"));
	if (forWhat == IT_SERVER)	
		return basePath + "\\realtimeloganalyser.server.lock";
	if (forWhat == IT_INTRANET)
		return basePath + "\\realtimeloganalyser.intranet.lock";
	else if (forWhat == IT_CLIENT )
		return basePath + "\\realtimeloganalyser.client.lock";
	else
		throw "Unknown parameter";	
}
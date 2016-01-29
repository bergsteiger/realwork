var fso = new ActiveXObject("Scripting.FileSystemObject");
var WshShell = WScript.CreateObject("WScript.Shell");
var WshNetwork = WScript.CreateObject("WScript.Network");
var endOfLine = "\r\n";
var ForReading = 1;
var ForWriting = 2;
var IT_SERVER = 1;
var IT_CLIENT = 2;
var IT_INTRANET = 3;
var MAX_LOG_SIZE_TO_ATTACH = 1024*1024; // ���� ����� � ����� ������ ����� ��������, �� �� �� ������������ �� �����
var MAX_LOG_SIZE_TO_PACK = 30*1024*1024; // ����� ���� � ����� ������ ����� ��������, �� �� �� �������� � �� ������������

function IsNonEmptyString(str)
{
	return (str != null) && ((str instanceof String) || (typeof(str) == "string")) && (str != "");
}

function CompName()
{
	return WshNetwork.ComputerName;
}

///////////////////////////////////////////////////////////////////
// ������ ���� ����������� ������������� ����� ��������
var rexpInclude = new RegExp("^.*(?:" +
	"UNKNOWN_EX:"+
	"|LM_ERROR" +
	"|LM_ALERT" +
	"|STD_EX" +
	"|Base pool:" +
	"|CORBA_EX:" +
").*?$", "mgi");
// � ����������� �� ������������� �����
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

// ������� ���������� �� ���������� ����� ���� ������� ������ ���������, ������� ��� �������
// ����������. ���� ������� �� �������, �� ������������ null 
function GetArrayOfErrors(
	logFileName // ������ ���� � ����� � �����
)
{	
	var bufSize = 2*1024*1024; // �� ������� �������� ����� ������ ����
		
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

// �������� ������ � ������� HTML � ���������� �����������
function SendMail(
	fromAddr, // �� ���� ������
	toAddr, // ���� ������
	subj, // ����
	htmlBody, // ����� � ������� HTML
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
	{ // ��� �������� ������
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

// ���������� ���������� �����,
function GetFileBody(
	fileName // ������ ���� � �����
)
{
	var result = "";
	if ( fso.FileExists(fileName) )
		result = fso.OpenTextFile(fileName, ForReading).ReadAll();
	return result;	
}



// ���������� ������ ���� � ����� ��� ��������� ������ (garant.ini)
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

// ���������� ������ ���� � ����� garant.ini
function GetPathToGarantINI(
	pType
)
{
	var result = GetPathToGarantFolder(pType);
	if (result != "")
		result += "\\garant.ini";
	return result;	 
}

// ���������� �������� �� ����� garant.ini
function GetValueFromGarantINI(
	pType, 
	sectionName, // ��� ������ (��� ���������� ������)
	paramName // ��� ���������
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

// ������� ���������� ����� ������ � ���� � ������� ����������� �������
function GetNewAndOldErrors(
	pathToLogFile,
	oldErrorsSuffix // ������� ����� �� ������� ��������. ����� ��� ���� ����� ������ �������-������������ (����������_����� � ������_�����������) �� ������������.
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
	// �������� ��� ������
	
	if ( !fso.FileExists(pathToLogFile) )		
		throw "Log file can not be found!";	
	var arrNewErrors =	GetArrayOfErrors( pathToLogFile );
	if (arrNewErrors != null)
	{		 
		// ������� ������, ���������� ������ ������
		var strOldErrors = GetFileBody(oldErrorsFileName);
		// ����� � ���� �� ������� �������� ����� ������
		fso.OpenTextFile(oldErrorsFileName, ForWriting, true).write( arrNewErrors.join(endOfLine) );
	
		// �� ������� �� ����� �������� ����������� ��� ������ ������
		var i;
		if (( arrNewErrors.length != 0 ) && (strOldErrors != ""))
			for (i = arrNewErrors.length-1 ; i >= 0 ; i--)
				if ( strOldErrors.indexOf(arrNewErrors[i]) != -1 )
				{
					arrOldErrors.push(arrNewErrors[i]);
					arrNewErrors.splice(i, 1);
				}
	
		result.oldErrors = (((arrOldErrors != null)&&(arrOldErrors.length > 0)) ? arrOldErrors : null);
		// ������ � arrNewErrors � ��� ������ ����� ������
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
	// ���������� �������
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
	{ // ���� ������� ����
		var iniSection = "";
		var product = GetValueFromGarantINI(iniType, "Version", "-Product");
		if ( (iniType == IT_SERVER) || (iniType == IT_INTRANET) )
		{ // ��� ���������� ��������
			if (product == "server")
				iniSection = "F1Server Params";
			else if ((product == "client") || (product == "fileserver") || (product == "desktop") || (product == "cd_or_dvd"))
				WScript.Quit();
			else
				throw "Unknown product!";
		}
		else if (iniType == IT_CLIENT)
		{ // ��� ����������� ��������
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

// �������� ������ � ������ �������� �� ��������� �����
function CheckForErrorsAndSendEmail(
	toAddr, // �� ���� ����� ���������� ������ ��� ������
	toAddrWithAttach // �� ���� ����� ���������� ������ � �������, ���� ����� �� ����� ������ �� ���������������
)
{
	//
	var isAttachLog = false;
	if ( IsNonEmptyString(toAddrWithAttach) )
	{
		isAttachLog = true;
	}
	// �������� ������ � ������ ��������
	var logFileName = GetLogFileNameByINIType(IT_SERVER);
	arrNewErrors = GetNewAndOldErrors(logFileName).newErrors;
	if (arrNewErrors != null) 
	{
		// ��������� ������
		//
		// ���������� �������
		var tableObj = CreateHTMLTableFromErrors("������� � ����������� �� �������", arrNewErrors);
		var tableBody = tableObj.tableBody;
		var tableStyles = tableObj.tableStyles;
		//

		// ������� �����		
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
			if ( logFileSize <= MAX_LOG_SIZE_TO_PACK ) // ���� ������ ���� �� ��������� �������� �������
			{ // �� ������ ���
				isBadLogSize = false;
				var archiveFileName = WshShell.ExpandEnvironmentStrings("%TEMP%") + "\\" + fso.GetFile(logFileName).Name + ".rar";
				if ( PackFileWithRAR(logFileName, archiveFileName) && fso.FileExists(archiveFileName)
				) // ���� ����� ������� 
				{ // �� ����������
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
				attachErr = attachErr + "<p> ��� �� ����������. ";
				if (isBadLogSize)
					attachErr = attachErr + "������ ���� (" + logFileSize + " ����) ������ ����������� (" + MAX_LOG_SIZE_TO_PACK + " ����).";
				else if (isBadArchiveSize)
					attachErr = attachErr + "������ ������ � ����� (" + archiveFileSize + " ����) ������ ����������� (" + MAX_LOG_SIZE_TO_ATTACH + " ����).";
				attachErr = attachErr + endOfLine;
			}
		}
		else
			attachments = null;


		// ���������� ���� ���������
		var htmlBody = new String();
		htmlBody =			
			"<html>" + endOfLine +
				"<head>" + endOfLine +
				"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=Windows-1251\">" + endOfLine +
				"<style>" + endOfLine +
				tableStyles + endOfLine +
				"</style>" + endOfLine +
					"<title>������ � ���� ������� �� ������ " + WshNetwork.ComputerName + "</title>" + endOfLine +
				"</head>" + endOfLine +
				"<body>" + endOfLine +
					"<p>������ � ���� ������� �� ������ <b>" + WshNetwork.ComputerName + "</b>" + endOfLine +
					attachErr +					
					"<hr>" + endOfLine +					
					tableBody + endOfLine +
				"</body>" + endOfLine +
			"</html>";


		// �������� ������
		var fromAddr = "logAnalyser@garant.ru";
		var letterSubj = "� ���� ������� �� ������ " + WshNetwork.ComputerName + " ���������� ������!";
			// ������� �������
		if ( IsNonEmptyString(toAddr) )
		{
			SendMail(fromAddr, toAddr, letterSubj, htmlBody);
		}
			// ����� � �������
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
		nodeName, // ��� ����
		isForceCreate
	)
	{
		// ��������� xml-���������
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
				
		// ����������� ������������ ����
		var objNode = null;
		var objNodeColl = objDoc.getElementsByTagName(nodeName);
		if (objNodeColl.length == 0) {
			// ������� ����
			if ((isForceCreate != null) && (isForceCreate)) {
				objNode = objDoc.createNode(1, nodeName, "");
				objRootNode.appendChild(objNode);
			}
		} else	{
			// �������� ������������
			objNode = objNodeColl.item(0);
		}
		//
		return objNode;
	}
	
	
	this.CloseNode = function(
		objNode // ������ ����
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

// ������� ��������� ������ ���-�����. ���� ��� �� ���������� �� ������� ���������� ������� �������, �� ���������� ������ ��
// ���������� LastLine � TimeDiff - ���������������, ��������� ������ � ���������� ������� ����� ������� �������� �������
// ������� � �������� ����� ���� ��������� ��������� ������.
// ���� ������ �� ����������, �� ���������� null.
function GetLogLastLineIfItChanged(
	iniType, // ��� ��������
	isReportOnlyOne // true - ���� ���� ��� ��� �������� � �������������� ������, �� ������ �� �������� (�������� null). false - �������� ������.
)
{
	var MAX_LINE_LENGTH = 4096;

	// ���������� ���� � ����
	var pathToLogFile = GetLogFileNameByINIType(iniType);
	if ( !fso.FileExists(pathToLogFile) )		
		throw "Log file can not be found!";	
	// ��������� ���� � ����� ��������� ��������� ������
	var lastLineFileName = pathToLogFile + '.last_line.txt';
	var lastLineStorage = new _LastLineFile(lastLineFileName);
	
	// �������� ������� ��������� ������
	var logFile = fso.OpenTextFile(pathToLogFile, ForReading);
		// ��������������� � ���� �������������� ����� ��������� �������
	var toSkip = fso.GetFile(pathToLogFile).Size - MAX_LINE_LENGTH;
	if (toSkip > 0) {
		logFile.Skip(toSkip);
	}
		// ������ ��������� �� ��������� ������
	var currLastLine = "";
	while (!logFile.AtEndOfStream)
		currLastLine = logFile.ReadLine();
	// � ����� ������� currLastLine ������ ��������� ��������� ������ ���� ��� ���� ������
	var currTime = (new Date()).getTime();	
	
	// ������ ������ ��������� ������ �� ������ ����������� ������� �������
	var prevLastLine = lastLineStorage.GetLastLine();
	var prevTime = lastLineStorage.GetTimeStamp();
	var isAlwaysReported = lastLineStorage.GetAlwaysReported();	
	// � ����� ������� prevLastLine �������� ��������� ������ �� ������ ���������� ������� �������, ��� null
		
	// ����������	
	if ( (prevLastLine != null) && (currLastLine == prevLastLine) )
	{ // ������ ����������
		if ((isReportOnlyOne != null) && isReportOnlyOne && isAlwaysReported)
			return null;
		var result = new Object();
		result.LastLine = currLastLine;
		result.TimeDiff = currTime - prevTime;
		lastLineStorage.SetAlwaysReported(true);
		return result;
	}
	else 
	{ // ������ ������
		// ��������� ������� ��������� ������ � ����
		lastLineStorage.SetLastLine(currLastLine);
		lastLineStorage.SetTimeStamp(currTime);
		lastLineStorage.SetAlwaysReported(false);
		return null;
	}
}

// ���������, ���� ��������� ������ ���-����� � ������� ���������� ������� ������� �� ����������, �� �������� e-mail �� ����
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
					"<title>�� �������� ��������� ������ ���-����� �� ������ " + WshNetwork.ComputerName + "</title>" + endOfLine +
				"</head>" + endOfLine +
				"<body>" + endOfLine +				
					"<p>��������� ������ ���� ������� �� ������ <b>" + WshNetwork.ComputerName + "</b> �� �������� � ������� " + resObj.TimeDiff/1000 + " ������!" + endOfLine +
					"<hr>" + endOfLine +
					"��������� ������ ���� �������:<br>" +
					"<pre>" + resObj.LastLine + "</pre>"
				"</body>" + endOfLine +
			"</html>";		
		//
		var fromAddr = "logAnalyser@garant.ru";
		
		var letterSubj = "�� ������ " + WshNetwork.ComputerName + " � ������� " + resObj.TimeDiff/1000 + " c����� �� �������� ��������� ������ ���� �������!";
		SendMail(fromAddr, toAddr, letterSubj, htmlBody);
	}
}

function GenerateHTMLDocWithErrors(
	logFileName, // ��� ����
	docTitle	
)
{
	var htmlBody = null;
	var errorsTableObj = null;	
				
	if (logFileName != null)
	{
		var errorsArr = GetArrayOfErrors(logFileName);
		
		if (errorsArr != null)
			errorsTableObj = CreateHTMLTableFromErrors("������� � ����������� �� �������", errorsArr);
				
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
					"<p><big><center>���� � �����: \"" + logFileName + "\"</center></big>" + endOfLine +
					"<hr>" + endOfLine +
					((errorsTableObj != null) ? errorsTableObj.tableBody : "<center>������ ���</center>") + endOfLine +
				"</body>" + endOfLine +
			"</html>";
	}		

	return htmlBody;
}


function GenerateHTMLDocWithOldAndNewErrors(
	iniType, // ��� ����
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
			newErrorsTableObj = CreateHTMLTableFromErrors("������� � ����������� � ����� �������", errorsObj.newErrors);

		if (errorsObj.oldErrors != null)
			oldErrorsTableObj = CreateHTMLTableFromErrors("������� � ����������� � ������ �������", errorsObj.oldErrors);
		
		
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
					"<p><big><center>���� � �����: \"" + logFileName + "\"</center></big>" + endOfLine +
					"<hr>" + endOfLine +
					((newErrorsTableObj != null) ? newErrorsTableObj.tableBody : "<center>����� ������ ���</center>") + endOfLine +
					"<hr>" + endOfLine +					
					((oldErrorsTableObj != null) ? oldErrorsTableObj.tableBody : "<center>������ ������ ���</center>") + endOfLine +
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
		{ // ���� ��� ������, � ��� ����� ��������
			oldLogSize = currLogSize;
			currLogSize = fso.GetFile(logFileName).Size;
			
			if (!logFile.atEndOfStream)
			{ // �� ����� ����� ������ ����� ������
				logStr = logFile.ReadLine();
				if ( (rexpInclude.test(logStr)) && (!rexpExclude.test(logStr)) )
					WshShell.Popup("� ���� " + endOfLine + "\t" + logFileName + endOfLine + "������� ������: " + endOfLine + "\t" + logStr, 0, "������ � ����!", 16 );
			}
			else
			{ // ����� ������ � ����� ���
				if ( currLogSize < oldLogSize )
				{ // ���� ������� ������ ����� ������ �������, �� ������� ��� ���� ������� ������ � ��� ���� �����������
					logFile.close();
					isLogOpened = false;
				}
				else
				{ // ���� ������ ��� �� ���������, ����
					WScript.Sleep(500);
				}
			}				
		}			
		else
		{ // ���� ��� �� ������
			if ( fso.FileExists(logFileName) )
			{ // ���� ����, ���������
				logFile = fso.OpenTextFile(logFileName, ForReading);
				isLogOpened = true;
				if (isFirstLaunch)
				{ // ��� ������ ������� ������� � ����� �����
					while (!logFile.atEndOfStream) logFile.ReadLine();
					isFirstLaunch = false;	
				}
				if (logStr != "") // ���� �������� ������, ������� ������������ ��������� ���
				{ // ��������������� �� ��������� ��������� ������ �����
					var isPositioned = false;
					while (!logFile.atEndOfStream)
						if (logFile.ReadLine() == logStr)
						{ // ����� ��� ������
							isPositioned = true;
							break;
						}
					if ( !isPositioned )
					{ // ���� �� ������� ������������������, �� ������������� ���
						logFile.close();
						isLogOpened = false;
						logStr = "";						
					}					
				}
			}
			else	
			{ // ����� ���, ����
				WScript.Sleep(1000);
			}
		}
	}
}

// ��������� ���� �� ������. ���������� Null - ���� �� ������� ������� ���� �� ������
// ����� ���������� ������ �����, ������� ���������� ������ ������� ��� ���������� ������������ �����.
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
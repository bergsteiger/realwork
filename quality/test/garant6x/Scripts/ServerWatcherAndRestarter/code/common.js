// ��� ������� ��� conditional compilation
@cc_on
@set @DEBUG = false
@if(@DEBUG)
	function DebugInfo(sStr) {
		Logger().Info(sStr);
	}

	function DebugError(sStr) {
		Logger().Error(sStr);
	}

	function DebugException(oEx) {
		WScript.Echo( Logger().Exception(oEx) );
	}
@end

// ===== ���������� ���������, ������� ������ ���� ���������� ������� =====
var	PT_SCRIPT_FOLDER = 1; // ���� � ����� � ������� ��������
var	PT_LOGS_FOLDER = 2; // ���� � ����� � ������
var	PT_GLOBAL_INI_FILE = 3; // ���� � ���-�����
var	PT_F1SERVER_CHECKER = 4; // ���� � ������� F1ServerChecrker.eze
var PT_SYNC_FOLDER = 5; // ���� � ����� ��������� ������ ��� �������������
var PT_VMMAP = 6; // ���� � ������� vmmap
var PT_DEBUGGER_BREAKPOINT_FILE = 8; // ���� � ����� � ������� ������ ��������� �������� � �����������
// ������� ������
var END_OF_LINE = "\r\n";
// ��� FSO.OpenTextFile � FSO::File.OpenAsTextStream
var FOR_READING = 1;
var FOR_WRITING = 2;
var FOR_APPENDING = 8;
// ��� ExecEx � �.�.
var WSH_RUNNING = 0;
var WSH_FINISHED = 1;
// ��� Dictionary. CompareMode_
var CM_BINARY = 1;
var CM_TEXT = 2;


// ===== ��������� ��������� =====

var INI_SECTION = "ServerWatcher";

// ���� ���������� ��������� �� ������� � ���� �������
var TO_EMAIL_ERRORS = INIFile().GetAsStr(INI_SECTION, "ToEMailErrors", "");
// ���� ���������� ����������� ��� ����������� �������. ���� �����, �� ����� �� ����������
var TO_EMAIL_SERVER_RESTART = INIFile().GetAsStr(INI_SECTION, "ToEMailServerRestart", "");
// ���� ����� ������������� � ���� from ��� ������� e-mail.
var FROM_EMAIL = INIFile().GetAsStr(INI_SECTION, "FromEMail", "");
// smtp-������
var SMTP_SERVER = INIFile().GetAsStr(INI_SECTION, "SMTPServer", "");
// smtp-������������ (���� ������ �� ���������� ����� ��� �����������)
var SMTP_USER = INIFile().GetAsStr(INI_SECTION, "SMTPUser", "");
// ������ smtp-������������
var SMTP_PASSWORD = INIFile().GetAsStr(INI_SECTION, "SMTPPassword", "");
// ����� (� �������������) � ������� �������� ����� ������� ��������� ������� ��� ��� �����������. ���� � ������� ������� ������� ������ �� ������ �����������, �� �� ����� ����
var SERVER_STOP_TIMEOUT = INIFile().GetAsNum(INI_SECTION, "ServerStopTimeout", 300);
if (SERVER_STOP_TIMEOUT > 0) SERVER_STOP_TIMEOUT *= 1000;
// ���� � ������� ����� ������� (� �������������) ��� ������� �� ��������, �� ������� ��� ������ �����. ���� -1 �� �������� �� ������������
var SERVER_HANGUP_TIMEOUT = INIFile().GetAsNum(INI_SECTION, "ServerHangupTimeout", 300);
if (SERVER_HANGUP_TIMEOUT > 0) SERVER_HANGUP_TIMEOUT *= 1000;
// ����� �� ������������� ������ ��� ����������� ��������� ��� ����������� ������ � ����
var IS_CAN_RESTART_SERVER = INIFile().GetAsBool(INI_SECTION, "IsCanRestartServer", false);
// ����� ����� ���������� ������� ��������� ���������� ������� (���� -1, �� �� �����������)
var F1SERVER_CHECKER_START_INTERVAL = INIFile().GetAsNum(INI_SECTION, "F1ServerCheckerStartInterval", 180);
if (F1SERVER_CHECKER_START_INTERVAL > 0) F1SERVER_CHECKER_START_INTERVAL *= 1000;
//  ���� � ������� ����� ������� ���������� ������� �� �������� ���� ������, �� ����� �������, ��� ������ �����
var F1SERVER_CHECKER_RUN_TIMEOUT = INIFile().GetAsNum(INI_SECTION, "F1ServerCheckerRunTimeout", 60);
if (F1SERVER_CHECKER_RUN_TIMEOUT > 0) F1SERVER_CHECKER_RUN_TIMEOUT *= 1000;
// ����� �� ������������ ���-���� ��� ��������
var IS_USE_LOG_FILE = INIFile().GetAsBool(INI_SECTION, "IsUseLogFile", true);
// ����� �� ��������� ������� F1 ��� ����������� ������� ���������
var IS_KILL_F1_UTILITIES_ON_SERVER_RESTART = INIFile().GetAsBool(INI_SECTION, "IsKillF1UtilitiesOnServerRestart", true);
// �������������� �������� ��� ������� ������
var IS_MUST_CONTROL_INTRANET = INIFile().GetAsBool(INI_SECTION, "IsMustControlIntranet", false);
// ���� web-������� ���������
var INTRANET_WEB_SERVER_PORT = INIFile().GetAsNum(INI_SECTION, "IntranetWebServerPort", -1);
// ���� ������� f1 ���������
var INTRANET_DATA_SERVER_PORT = INIFile().GetAsNum(INI_SECTION, "IntranetDataServerPort", -1);
// ���� ���������� ������ � ������ VMMap
var TO_EMAIL_VMMAP = INIFile().GetAsStr(INI_SECTION, "ToEMailVMMap", "");
// ���������� �� ������� ����������� ���������� �������� ��� �������
var IS_DETECT_ASSERTS = INIFile().GetAsBool(INI_SECTION, "IsDetectAsserts", false);
// ������� �� �� ������ � ������� �������� �������� � �����������
var IS_WATCH_FOR_DEBUGGER_BREAKPOINTS = INIFile().GetAsBool(INI_SECTION, "IsWatchForDebuggerBreakpoints", false);

// == ����������������� ��������� ==
// ��������� �� 64-� ������ ��������
var IS_64_BIT_SERVER = INIFile().GetAsBool(INI_SECTION, "Is64BitServer", false);
//
var F1BU_DB_SWITCH_TIMEOUT = INIFile().GetAsNum(INI_SECTION, "F1BUDBSwitchTimeout", -1);
if (F1BU_DB_SWITCH_TIMEOUT > 0) F1BU_DB_SWITCH_TIMEOUT *= 1000;

// ===== ����� ������� =====

// ������� ��� �������� ������� ���������� ������� �� ��������� ��������
function TreatAsStr(
	inputValue,
	defaultValue
)
{
	if (typeof(inputValue) == "undefined") inputValue = null;
	if ( (inputValue != null) && ((inputValue instanceof String) || (typeof(inputValue) == "string")) )
		return inputValue;
	else
		return defaultValue;
}

// ������� ��� �������� ������� ���������� ������� �� ���������� ��������
function TreatAsBool(
	inputValue,
	defaultValue
)
{
	if (typeof(inputValue) == "undefined") inputValue = null;
	if ( (inputValue != null) && ((inputValue instanceof Boolean) || (typeof(inputValue) == "boolean")) )
		return inputValue;
	else
		return defaultValue;
}

// ������� ��� �������� ������� ���������� ������� �� �������� ��������
function TreatAsNum(
	inputValue,
	defaultValue
)
{
	if (typeof(inputValue) == "undefined") inputValue = null;
	if ( (inputValue != null) && ((inputValue instanceof Number) || (typeof(inputValue) == "number")) )
		return inputValue;
	else
		return defaultValue;
}

// ������������ ����� � 32-� ��������� 16-������ �������������. ���������� ����������� �����-�� ����������...
function ToHEXStr(
	iNumber
)
{
	var sTmp = "";
	for (var i = 0; i < 8; i++)
	{
		sTmp = (iNumber & 0xF).toString(16) + sTmp;
		iNumber >>= 4;
	}
	return "0x" + sTmp;
}

// ���������� 32���� ����� (������� ��� ��������� ������, � �� ��� �����-�� ���������� �������������� �� ������� �����������)
function IsInt32Equal(left, right)
{
	return (left & 0xFFFFFFFF) == (right & 0xFFFFFFFF);
}

// ������� ���������� ���������� ����������� ��������� � 01.01.1970
function CurrTimeStamp()
{
	return (new Date()).getTime();
}

var gbl_FSO_Cache;
// �������-������� ���������� ��������� FileSystemObject
function FSO()
{
	if (typeof(gbl_FSO_Cache) != "object") {
		gbl_FSO_Cache = new ActiveXObject("Scripting.FileSystemObject");
	}
	return gbl_FSO_Cache;
}

// �������-������� ������ WshShell.Exec
function ExecEx(
	sPathToExe, // ���� � ������������ �����
	sParameters // ���������
)
{
	sParameters = TreatAsStr(sParameters, "");
	if (sParameters != "") sParameters = " " + sParameters;
	//
	var oFile = FSO().GetFile(sPathToExe);
	var oWshShell = WScript.CreateObject("WScript.Shell"); // ���������� ������� ��������� ������
	//
	oWshShell.CurrentDirectory = oFile.ParentFolder;
	return oWshShell.Exec(sPathToExe + sParameters);
}

var gbl_WshShell_Cache;
// �������-������� ���������� ��������� WshShell
function WshShell()
{
	if (typeof(gbl_WshShell_Cache) != "object")	 {
		gbl_WshShell_Cache = WScript.CreateObject("WScript.Shell");
	}
	return gbl_WshShell_Cache;
}

//
function GetTempDir()
{
	return WshShell().ExpandEnvironmentStrings(WshShell().Environment("SYSTEM")("TMP"));
}

//
function GetTempDirForSyncOps()
{
	var sPath = GetPathTo(PT_SYNC_FOLDER);
	if (!FSO().FolderExists(sPath))
	{
		// ������� �����
		FSO().CreateFolder(sPath);
		// ������������� ���������� ��� ����
		GrantFoFAccessToEveryoneSilent(sPath);
	}
	//
	return sPath;
}


var gbl_WshNethwork_Cache;
// �������-������� ���������� ��������� WshNetwork
function WshNetwork()
{
	if (typeof(gbl_WshNethwork_Cache) != "object")	 {
		gbl_WshNethwork_Cache = WScript.CreateObject("WScript.Network");
	}
	return gbl_WshNethwork_Cache;
}

// ���������� ��� ������
function CompName()
{
	return WshNetwork().ComputerName;
}

var gbl_Is64bitWindows_Cache;
// ������� ������� �������� �� ������ Windows 64-� ���������
function Is64bitWindows()
{
	if (typeof(gbl_Is64bitWindows_Cache) != "boolean")
	{
		// ������ �������� ��������� ���������� PROCESSOR_ARCHITECTURE
		var oWshSysEnv = WshShell().Environment("SYSTEM");
		var sProcArch = oWshSysEnv("PROCESSOR_ARCHITECTURE");
		// ���� ��� ����� AMD64 ��� IA64 �� ������� ��� ����� 64-� ���������
		gbl_Is64bitWindows_Cache = ((sProcArch == "AMD64") || (sProcArch == "IA64"));
	}
	return gbl_Is64bitWindows_Cache;
}

// ������� ���������� ���������� ���������� �����,
function GetFileBody(
	sPathToFile // ������ ���� � �����
)
{
	var sResult = "";
	if ( FSO().FileExists(sPathToFile) && (FSO().GetFile(sPathToFile).Size > 0))
	{		
		oFile = FSO().OpenTextFile(sPathToFile, FOR_READING);
		try {
			sResult = oFile.ReadAll();
		} finally {
			oFile.Close();
		}
	}
	return sResult;
}

var gbl_WMIService_Cache;
// �������-������� ���������� ��������� WMIService
function WMIService()
{
	if (typeof(gbl_WMIService_Cache) != "object") {
		gbl_WMIService_Cache = GetObject("winmgmts:{impersonationLevel=impersonate}!\\\\.\\root\\cimv2");
	}
	return gbl_WMIService_Cache;
}

// ������������ ���� �� wmi date-time ������� � �������� Date
function WMIDate2StandardDate(
  sWMIDate // ������ � �������� � ������� wmi (http://technet.microsoft.com/en-us/library/ee156576.aspx)
)
{
	var sYear = sWMIDate.substr(0, 4);
	var sMonth = sWMIDate.substr(4, 2);
	var sDay = sWMIDate.substr(6, 2);
	var sHour = sWMIDate.substr(8, 2); 
	var sMinute = sWMIDate.substr(10, 2);
	var sSecond = sWMIDate.substr(12, 2);
	var sMillisecond = sWMIDate.substr(15, 3);
		
	return new Date(sYear, new Number(sMonth) - 1, sDay, sHour, sMinute, sSecond, sMillisecond);
}

// �������-������� ���������� WMI-������ (Win32_Process) ��� ���������� �������� ���� null ���� ������� �� ������
function GetWMIObjectForProcess(
	sProcName, // ��� �������� c �����������. ���� �� ������� �� ���� ������ �� PID
	iPID // ������������� �������� (���� �����, �� ��� ������ ����������� � ������ �� �������� �)
)
{
	var bIsMustUsePID = TreatAsNum(iPID, -2578) != -2578;
	//
	var oResult = null;
	// �������� ��������� �������� ���������
	var sQuery = "SELECT * FROM Win32_Process WHERE";
	if (sProcName != "") {
		sQuery += " Name = '" + sProcName + "'";
	}
	if (bIsMustUsePID) {
		sQuery += ((sProcName != "") ? " AND" : "") + " ProcessID = '" + iPID + "'";
	}
	var oColProc = WMIService().ExecQuery(sQuery);
	// ���� � ��������� ������ ������ �������� �� �������� �� ��� �� ������� ��� �� ������ �� ��� ����, �� ��� ����� ��������
	if (oColProc.Count >= 1)
	{ // ������� �� ��������� ��� ������
		var oProcEnum = new Enumerator(oColProc);
		oResult = oProcEnum.item();
	}
	return oResult;
}

// �������-������� ���������� WMI-������ (Win32_Service) ��� ���������� ������� ���� null ���� ������ �� ������
function GetWMIObjectForService(
	sServiceName // ��� �������
)
{
	var oResult = null;
	//
	try {
		oResult =  WMIService().Get("Win32_Service.Name=\"" + sServiceName + "\"");
	} catch (oEx) {}
	//
	return oResult;
}

// ������� ���������� ����������� WMI-������. ��������� ��� � ������� ����.������ ��� �������������� �������
function GetRefreshedWMIObject(
	oObject
)
{
	if ("Refresh_" in oObject)	{
		// � ������� ������� ������
		oObject.Refresh_();
	} else {
		// � ������� ������������� �������
		oObject = WMIService().Get(oObject.Path_.Path);
	}
	return oObject;
}

// ������� ��������� ������. �������� ��������� ������� ������ �������, ����� ���������� �������� ������� � ��������� Running � ������� ���������� �������
function StartService(
	oService, // ������ �������
	iTimeout // ����� � ������� �������� ���� �������� ������� � ��������� Running. ��-��������� 10 ���
)
{
	iTimeout = TreatAsNum(iTimeout, 10000);
	//
	var bResult = false;
	var iSleepTime = 200;
	var iMaxAttemptsCount = 3;

	// ������ ��������� ������� ������� �������
	var iErrCode;
	var iAttemptN = 1;
	do {
		iErrCode = oService.StartService();
		//
		if (iErrCode != 0) {
			// �� ������� ���������
			Logger().Error("������� � " + iAttemptN + " ������� ������� \"" + oService.Name + "\" �� �������. �������� ��� ������: " + iErrCode);
		}
	} while ((iErrCode != 0) && (iAttemptN++ < iMaxAttemptsCount));

	if (iErrCode != 0) {
		// �� ������� ���������
		Logger().Error("�� ������� ��������� ������ \"" + oService.Name + "\" �� " + iMaxAttemptsCount + " �������.");
	} else {
		// ������ ������� ���������
		Logger().Info("������ \"" + oService.Name + "\" ���������. ������ ���� ���� ����������.");
		// ���� ���� �������� � ��������� Running
		var iDeadLine = CurrTimeStamp() + iTimeout;
		do {
			oService = GetRefreshedWMIObject(oService);
			bResult = (oService.State == "Running");
			if (bResult) break;
			WScript.Sleep(iSleepTime);
		} while (CurrTimeStamp() < iDeadLine);
		//
		if (bResult) {
			Logger().Info("������ \"" + oService.Name + "\" ������� ����������.");
		} else {
			Logger().Info("������ \"" + oService.Name + "\" �� " + iTimeout + " �� ��� � �� ������� � ��������� Running. �������, ��� �� ����������.");
		}
	}

	return bResult;
}

// ������� ������������� ��������� ������, ������� true, ���� ����� �� ������� ������ ��������� ����������
function StopService(
	oService, // ������ �������
	iTimeout // ����� � ������� �������� ���� ���������� ��������� �������. ��-��������� 10 ���
)
{
	iTimeout = TreatAsNum(iTimeout, 10000);
	//
	var iSleepTime = 200;

	oService = GetRefreshedWMIObject(oService);
	// ���������, ����� ����������
	var bResult = oService.State == "Stopped";
	if (!bResult)
	{
		// �������� ���������� ������ ���������
		var iErrCode = oService.StopService();
		if (iErrCode != 0) {
			Logger().Error("��� ������� ���������� ������� \"" + oService.Name + "\" ��� ������� ��� ������ " + iErrCode);
		} else {
			// ���� ����� �����������. ������ ��� ������������ ������ StopService!
			var iDeadLine = CurrTimeStamp() + iTimeout;
			do {
				oService = GetRefreshedWMIObject(oService);
				bResult = oService.State == "Stopped";
				if (bResult) break;
				WScript.Sleep(iSleepTime);
			} while (CurrTimeStamp() < iDeadLine);
		}
	}

	return bResult;
}

// �������-������� ��� ������ Terminate ������� Win32_Process. ������� true, ���� ����� ��� ������� �� �����������
function TerminateWMIProcess(
	oProcess, // ������ ��������
	iTimeout // �����, � ������� �������� ����� ������� ������� ��������. ��-��������� 10 ���.
)
{
	iTimeout = TreatAsNum(iTimeout, 10000);
	var bResult = false;
	var iSleepTime = 200;
	// ���������� ������ �������� ��� ����������� �������� ��� �������
	var sProcName = oProcess.Name;
	var iPID = oProcess.ProcessId;
	// ��������� ����������� ����������
	oProcess.Security_.Privileges.AddAsString("SeDebugPrivilege");
	// ��������� ���
	var iErrCode = oProcess.Terminate();
	if (iErrCode != 0) {
		Logger().Error("��� ������� ���������� �������� " + sProcName + " c PID " + iPID + " ��� ������� ��� ������ " + iErrCode);
	}
	// ���� ���� �� ������� ��������
	var iDeadLine = CurrTimeStamp() + iTimeout;
	do {
		bResult = (GetWMIObjectForProcess(sProcName, iPID) == null);
		if (bResult) break;
		WScript.Sleep(iSleepTime);
	} while (CurrTimeStamp() < iDeadLine);
	//
	return bResult;
}

// ������� ������� �������� ��������. ������� true, ���� ����� ��� �������� �� ������������
function TerminateChildsProcess(
	iPID, // ������������� ������������� ��������
	iTimeout // �����, � ������� �������� ����� ������� ������� ��������. ��-��������� 10 ���.
)
{
	iTimeout = TreatAsNum(iTimeout, 10000);
	var bResult = true;
	//
	var oProcCol = WMIService().ExecQuery("SELECT * FROM Win32_Process WHERE ParentProcessId = " + iPID);
	// ��������� �������� �������� (� ��� ����� �������� �������� � �.�.)
	if ((oProcCol != null) && (oProcCol.Count > 0)) {
		var oEnum = new Enumerator(oProcCol);
		for (; !oEnum.atEnd(); oEnum.moveNext())
		{
			var oProc = oEnum.item();
			// ������� ��� �������
			oProc = GetWMIObjectForProcess(oProc.Name, oProc.ProcessID);
			iBegin = CurrTimeStamp();
			bResult = TerminateWMIProcess(oProc, iTimeout) && bResult;
			iTimeout -= CurrTimeStamp() - iBegin;
			// ������� �������� �������� ����������� ��������
			var iBegin = CurrTimeStamp();
			bResult = TerminateChildsOfWMIProcess(oProc, iTimeout) && bResult;
			iTimeout -= CurrTimeStamp() - iBegin;
		}
	}
	return bResult;
}

// ������� ������� �������� �������� ������� Win32_Process. ������� true, ���� ����� ��� �������� �� ������������
function TerminateChildsOfWMIProcess(
	oProcess, // ������ ��������
	iTimeout // �����, � ������� �������� ����� ������� ������� ��������. ��-��������� 10 ���.
)
{
	iTimeout = TreatAsNum(iTimeout, 10000);
	return TerminateChildsProcess(oProcess.ProcessId, iTimeout);
}

// ������� ������� ������ �������� (��� � �������� ��������). ������� true, ���� ����� ��� �������� �� ������������
function TerminateWMIProcessTree(
	oProcess, // ������ ��������
	iTimeout // �����, � ������� �������� ����� ������� ������� ��������. ��-��������� 10 ���.
)
{
	iTimeout = TreatAsNum(iTimeout, 10000);
	var bResult = false;
	// ������� ��� �������
	var iBegin = CurrTimeStamp();
	bResult = TerminateWMIProcess(oProcess, iTimeout);
	iTimeout -= CurrTimeStamp() - iBegin;
	// ������� �������� ��������
	bResult = TerminateChildsOfWMIProcess(oProcess, iTimeout) && bResult;
	return bResult;
}



var gbl_VBArrayMaker_Cache;
// �������-������� ���������� VBArrayMaker
function VBArrayMaker()
{
	if (typeof(gbl_VBArrayMaker_Cache) != "object")	 {
		// �������� ����������
		try {
			gbl_VBArrayMaker_Cache = new ActiveXObject("F1ServerWatcher.VBArrayMaker.1");
		} catch (oEx) {
			Logger().Error("�� ������� ������� ���������� F1ServerWatcher.VBArrayMaker.1");
			Logger().Exception(oEx);
			throw oEx;
		}
	}
	return gbl_VBArrayMaker_Cache;
}

// ������������� � ���������� ����� ��� ����� ��� ���������� ��� Everyone
function GrantFoFAccessToEveryone(
	sPath
)
{
	var oWMI = WMIService();
	sPath = sPath.replace(/\\/g, "\\\\"); // ��������� �����
	// �������� ��������� Win32_LogicalFileSecuritySetting ��� ��������� ����
	var oLFSS;
	try {
		oLFSS = oWMI.Get("Win32_LogicalFileSecuritySetting.Path=\"" + sPath + "\"");
	} catch (oEx) {
		if (IsInt32Equal(oEx.number, 0x80041002)) // Not found
		{
			try {
				var oSSCol = oWMI.ExecQuery("SELECT * FROM Win32_LogicalFileSecuritySetting WHERE Path = \"" + sPath + "\"");
				if (oSSCol.Count == 0)
					throw "���� ��� ����� �� ��������!";
				oLFSS = (new Enumerator(oSSCol).item());
			} catch (oEx2) {
				throw oEx2;
			}
		}
		else
			throw oEx;
	}

	// ������������ SecurityDescriptor � �����������: ��� ��������� Everyone � Owner
	//
	var oTrustee = oWMI.Get("Win32_Trustee");//.SpawnInstance_();
	oTrustee.SIDString = "S-1-1-0"; // Everyone
	//
	var oACE = oWMI.Get("Win32_ACE");//.SpawnInstance_();
	oACE.Trustee = oTrustee;
	oACE.AccessMask = 1|2|4|8|16|32|64|128|256|65536|131072|262144|524288;
	oACE.AceType = 0; // Access Allowed
	oACE.AceFlags = 1 | 2; // OBJECT_INHERIT_ACE | CONTAINER_INHERIT_ACE
	//
	var oACE2 = oACE.Clone_();
	oACE2.Trustee = oLFSS.ExecMethod_("GetSecurityDescriptor").Descriptor.Owner;
	//
	var oSD = oWMI.Get("Win32_SecurityDescriptor");//.SpawnInstance_();
	oSD.DACL = VBArrayMaker().Make2ItemsVBArray(oACE, oACE2);
	oSD.ControlFlags = 4 | 1024; // SE_DACL_PRESENT | SE_DACL_AUTO_INHERITED
	// ��������� ��������� ������������
	var bResult = oLFSS.SetSecurityDescriptor(oSD) == 0;
	return bResult;
}

function GrantFoFAccessToEveryoneSilent(
	sPath
)
{
	try {
		var bResult = GrantFoFAccessToEveryone(sPath);
		@if(@DEBUG)
			if (bResult)
				DebugInfo("������� ��������� GrantFoFAccessToEveryone ��� \"" + sPath + "\"");
			else
				DebugError("�� ������� ��������� GrantFoFAccessToEveryone ��� \"" + sPath + "\"");
		@end
	} catch (oEx) {
		Loger().Error("���������� ��� ���������� GrantFoFAccessToEveryone ��� \"" + sPath + "\"");
		Logger().Exception(oEx);
	}
}

// �������� ������ � ������� HTML � ���������� �����������. ���������� ���� ������ ������ (���� ��� �������� �� ���� ������), ���� ����� ������.
function SendMail(
	fromAddr, // �� ���� ������
	toAddr, // ���� ������
	subj, // ����
	htmlBody, // ����� � ������� HTML
	attachFilesArr, // ������ � ������� ��������������� ������, ���� �� ������, �� ������ �� ���������������
	isRethrowException
)
{
	var sError = "";
	var SEND_ATTEMPTS_COUNT = 6; // ������� ������ ������� ��������� �����
	var SEND_ATTEMPT_TIMEOUT = 20000; // ������� ���� ����� ��������� ��������
	try
	{
		var objEmail = WScript.CreateObject("CDO.Message");
		objEmail.Organization = "Garant.ServerWatcher";
		objEmail.AutoGenerateTextBody = false;
		//
		objEmail.From = fromAddr;
		objEmail.To = toAddr;
		objEmail.Subject = subj;
		objEmail.HTMLBody = htmlBody;
		//
		objEmail.BodyPart.Charset = "utf-8";
		objEmail.BodyPart.ContentTransferEncoding = "base64";
		var objFields = objEmail.Configuration.Fields;
		objFields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2;
		objFields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = SMTP_SERVER;
		objFields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25;
		if (SMTP_USER != "") {
			objFields.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1; //clear-text
			objFields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = SMTP_USER;
			objFields.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = SMTP_PASSWORD;
		}
		objFields.Update();

		if (attachFilesArr instanceof Array)
		{ // ��� �������� ������
			for (var i=0; i < attachFilesArr.length; i++)
			{
				var fileName = attachFilesArr[i];
				if (FSO().FileExists(fileName))
					objEmail.AddAttachment( FSO().GetFile(fileName).Path );
			}
		}

		// ������������ ������, ������ �������� ��� ������� ��������� ���, � �� �� ����������� �������� ����� ��������� ������ The transport failed to connect to the server
		Logger().Info("�������� ������ c ����� \"" + subj + "\" � ������ " + fromAddr + " �� ����� " + toAddr);
		for (var i=1; i <= SEND_ATTEMPTS_COUNT; i++)
		{
			try {
				objEmail.Send();
				Logger().Info("������ ������� ������� � " + i + "-� �������.");
				break;
			} catch (oEx) {
				Logger().Exception(oEx);
				if (i != SEND_ATTEMPTS_COUNT) // ���� ��� �� ��������� �������
				{
					if (IsInt32Equal(oEx.number, 0x80040213)) //  ���������  ������ The transport failed to connect to the server
					{ // �� ������ ��� �������
						var iSleepTime = SEND_ATTEMPT_TIMEOUT;
						Logger().Warning("��� ������� ��������� ������ ��������� ������ ����������� � �������. �������� ������ ���������� ��� ���������� ����������� �����������/���������. �������� " + iSleepTime +" �� � ��������� ��� ���.");
						WScript.Sleep(iSleepTime);
						continue;
					}
				} else {
					throw oEx;
				}
			}
		}

	} catch (oEx) {
		sError = oEx.message;
		var sMessage = "������������ ������� �������� �� �������� ��� ������� ��������� ����� ����������� � ���������: " + sError;
		WshShell().LogEvent(1, sMessage);
		Logger().Error(sMessage);
		Logger().Exception(oEx);
	}
	return sError;
}

// ��������� html-��������
function HTMLDoc(
	sTitle, // ��������
	sBody, // ���� (� ������� HTML)
	sStyles // ������� ������ (��-��������� ������)
)
{
	sStyles = TreatAsStr(sStyles, "");
	//
	var sRes =
		"<html>" + END_OF_LINE +
			"<head>" + END_OF_LINE +
			"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=Windows-1251\">" + END_OF_LINE +
			"<style>" + END_OF_LINE +
				sStyles +
			"</style>" + END_OF_LINE +
				"<title>" + sTitle + "</title>" + END_OF_LINE +
			"</head>" + END_OF_LINE +
			"<body>" + END_OF_LINE +
				sBody +
			"</body>" + END_OF_LINE +
		"</html>";
	return sRes;
}

var gbl_QCCF_Cache;
// �������-������� ���������� ��������� QCComponentsFactory
function QCComponentsFactory()
{
	if (typeof(gbl_QCCF_Cache) != "object") {
		try {
			gbl_QCCF_Cache = new ActiveXObject("QCFileComponents.QCComponentsFactory");
		} catch (oEx) {
			Logger().Error("������ ��� �������� ���������� QCFileComponents.QCComponentsFactory");
			Logger().Exception(oEx);
			throw oEx;
		}
	}
	return gbl_QCCF_Cache;
}

// �������� � ������ ����������� ������� ����� ������
function TrimTrailingEOLs(
	sText
)
{
	while (sText.length > 0)
	{
		var sLastChar = sText.charAt(sText.length-1);
		if ( (sLastChar == '\n') || (sLastChar == '\r') )
			sText = sText.substr(0, sText.length-1);
		else
			break;
	}
	return sText;
}

// �������� � ������ ����������� �����������
function Trim(
	sText
)
{
	var oRExp = /^\s*([\s\S]*?)\s*$/;
	if ((arrRes = oRExp.exec(sText)) != null)
		sText = arrRes[1];
	return sText;
}

// ���������� ���� � ������� �������
function GetPathTo(
	pathTo
)
{
	pathTo = TreatAsNum(pathTo, null);
	if (pathTo == null) throw "pathTo must be number!";
	switch (pathTo)
	{
		case PT_SCRIPT_FOLDER :
			return FSO().GetFile(WScript.ScriptFullName).ParentFolder;
		case PT_LOGS_FOLDER :
			return GetPathTo(PT_SCRIPT_FOLDER) + "\\..\\logs";
		case PT_GLOBAL_INI_FILE :
			return GetPathTo(PT_SCRIPT_FOLDER) + "\\..\\settings\\settings.ini";
		case PT_F1SERVER_CHECKER :
			return GetPathTo(PT_SCRIPT_FOLDER) + "\\..\\server-checker\\F1ServerChecker.exe";
		case PT_SYNC_FOLDER :
			return GetPathTo(PT_SCRIPT_FOLDER) + "\\..\\temp_for_sync";
		case PT_VMMAP :
			return GetPathTo(PT_SCRIPT_FOLDER) + "\\vmmap.exe";
		case PT_DEBUGGER_BREAKPOINT_FILE:
			return GetPathTo(PT_SCRIPT_FOLDER) + "\\..\\debugger_breakpoint.txt";			
		default:
			throw "Unknown option!";
	}
}

var gbl_Logger_Cache;
// �������-������� ���������� ��������� �������
function Logger()
{
	if (typeof(gbl_Logger_Cache) != "object") {
		// �������������� ������ ����-������
		var sScriptFolder = GetPathTo(PT_SCRIPT_FOLDER);
		var oFolder = null;
		try {
			var sLogFolder = sScriptFolder + "\\..\\logs";
			if (!FSO().FolderExists(sLogFolder))
			{
				FSO().CreateFolder(sLogFolder);
				GrantFoFAccessToEveryoneSilent(sLogFolder);
			}
			oFolder = FSO().GetFolder(sLogFolder);
		} catch(ex) {
		}
		if (oFolder == null)
			oFolder = FSO().GetFolder(sScriptFolder);
		//
		var oDate = new Date();
		var sFileName =
			oDate.getDate() + "-" + (oDate.getMonth()+1) + "-" + oDate.getYear() + "_" +
			oDate.getHours() + "-" + oDate.getMinutes() + "-" + oDate.getSeconds() + "-" + oDate.getMilliseconds() + ".log";
		AttachLoggerToFile(	oFolder.Path + "\\" + sFileName );
	}
	return gbl_Logger_Cache;
}

// ����������� ������ � ������� �����
function AttachLoggerToFile(
	sFilePath // ������ ���� � ���-�����
)
{
	if (gbl_Logger_Cache != null) {
		gbl_Logger_Cache.Close();
	}
	gbl_Logger_Cache = new CLogger(sFilePath);
}

var gbl_INIFile_Cache;
// �������-������ ���������� ��������� ����������� ���-�����
function INIFile()
{
	if (typeof(gbl_INIFile_Cache) != "object") {
		gbl_INIFile_Cache = new IniMan( GetPathTo(PT_GLOBAL_INI_FILE) );
		gbl_INIFile_Cache.Load();
	}
	return gbl_INIFile_Cache;
}

// ��������� ������� F1DataUpd.run, F1DataSetup.run, F1Download.run
function KillF1Utilities()
{
	var arrProcNames = ["F1DataUpd.run", "F1DataSetup.run", "F1Download.run"];
	// ��������� ��� ��������� ��������
	for (iIdx in arrProcNames)
	{
		var sProcName = arrProcNames[iIdx];
		var oProcess = GetWMIObjectForProcess(sProcName);
		if (oProcess != null) {
			if (TerminateWMIProcess(oProcess))
				Logger().Info("������� ������� ������� " + sProcName);
			else
				Logger().Error("�� ������� ������� ������� " + sProcName);
		}
	}
}

// ===== ����������� ������� =====


// �������� ��� �����
function _IniMan_Parameter()
{
	// �������� ���������
	this.pm_Value;

	// ������� �����������
	this.isComment = false;

	// ������������� ��������
	this.Set = function(
		value
	)
	{
		this.pm_Value = value;
	}

	// �������,����������������� �� �������� ���������
	this.IsInitialized = function()
	{
		return typeof(this.pm_Value) != "undefined";
	}

	// ���������� �������� ��������� ��� ������
	this.GetAsStr = function ()
	{
		return this.pm_Value.toString();
	}

	// ���������� �������� ��������� ��� �����
	this.GetAsNum = function ()
	{
		return this.pm_Value/1;
	}

	// ���������� �������� ��������� ��� ����������
	this.GetAsBool = function ()
	{
		var sUpCased = this.pm_Value.toString().toUpperCase();
		return (sUpCased == "YES") || (sUpCased == "TRUE");
	}
}

// ������ ���-�����
function _IniMan_Section()
{
	// ���������
	this.pm_oParameters = new ActiveXObject("Scripting.Dictionary");
	this.pm_oParameters.CompareMode = CM_TEXT;

	// ���������� ������ ���������
	this.Parameter = function(
		sParamName,
		isForceCreate
	)
	{
		isForceCreate = TreatAsBool(isForceCreate, false);
		//
		if (this.pm_oParameters.Exists(sParamName))
			return this.pm_oParameters.Item(sParamName);
		else if (isForceCreate)
		{
			this.pm_oParameters.Add(sParamName, new _IniMan_Parameter());
			return this.Parameter(sParamName);
		}
		else
			return null;
	}

	// ���������� ������ � ������� ���� ����������
	this.ParametersNames = function()
	{
		return this.pm_oParameters.Keys().toArray();
	}

	// �������, ���� �� � ������ ���� ���� ������������������ ��������
	this.IsInitialized = function()
	{
		var bResult = false;
		//
		var arrParamNames = this.ParametersNames();
		for (i in arrParamNames)
		{
			bResult |= this.Parameter(arrParamNames[i]).IsInitialized();
			if (bResult) break;
		}
		return bResult;
	}
}

function IniMan(
	sPathToINI
)
{
	// ������ ���� � ���-�����
	this.pm_sPathToINI = sPathToINI;
	// ������
	this.pm_oSections = new ActiveXObject("Scripting.Dictionary");
	this.pm_oSections.CompareMode = CM_TEXT;

	// ����� ������ ��� ini-�����
	this.pm_sEndOfLineStr = "\r\n";
	// ������ �����������
	this.pm_sCommentPrefix = ";";


	// ���������� ���� � ini-�����
	this.GetPathToINI = function()
	{
		return this.pm_sPathToINI;
	}

	// ���������� ������ ������ ��� null ���� ��� ��� � ������ ���������
	this.Section = function(
		sSectionName, // ��� ������
		isForceCreate // ��������� ���� ����
	)
	{
		isForceCreate = TreatAsBool(isForceCreate, false);
		//
		if (this.pm_oSections.Exists(sSectionName))
			return this.pm_oSections.Item(sSectionName);
		else if (isForceCreate)
		{
			this.pm_oSections.Add(sSectionName, new _IniMan_Section());
			return this.Section(sSectionName);
		}
		else
			return null;
	}

	// ���������� ������ � ������� ���� ������
	this.SectionsNames = function()
	{
		return this.pm_oSections.Keys().toArray();
	}

	// �����������
	this.pm_Serialize = function()
	{
		var sResult = "";

		// ���������� ��� ������
		var arrSectionNames = this.SectionsNames();
		for (iSectionNum in arrSectionNames)
		{
			var sSectionName = arrSectionNames[iSectionNum];
			var oSection = this.Section(sSectionName);
			if (oSection.IsInitialized())
			{
				// ��������� ��������� ������
				sResult += "[" + sSectionName + "]" + this.pm_sEndOfLineStr;
				// ���������� ��������� � ������
				var arrParametersNames = oSection.ParametersNames();
				for (iParamNum in arrParametersNames)
				{
					var sParamName = arrParametersNames[iParamNum];
					var oParameter = oSection.Parameter(sParamName);
					// ��������� ��������
					if (oParameter.IsInitialized())
					{
						if (oParameter.isComment)
							sResult += this.pm_sCommentPrefix;
						else
							sResult += sParamName + "=";
						sResult += oParameter.GetAsStr() + this.pm_sEndOfLineStr;
					}
				}
				sResult += this.pm_sEndOfLineStr; // ����� ������ ���� ������ ������
			}
		}
		return sResult;
	}

	// �������������
	this.pm_Unserialize = function(
		sData
	)
	{
		this.pm_oSections.RemoveAll();

		// ���������� ��������� ��� �������� �� ������
		var oRExpSection = /(?:^|[\r\n]+)\[([ \w]*)\]\s?([\s\S]*?)(?=\s+\[|\s*$)/g;
		// ���������� ��������� ��� �������� ����������
		var oRExpParam = /^(.*?)\s*=(.*?)$/;
		// ���������� ��������� ��� ��������� ��������� ������
		var oRExpLine = /^(.*)$/gm;

		// ��������� ������� ������ �� ���_������ - ����_������
		while ((arrSec = oRExpSection.exec(sData)) != null)
		{
			var sSectionName = arrSec[1];
			var sSectionBody = arrSec[2];
			//
			var oSection = this.Section(sSectionName, true);
			// ������������� ������ ���������
			var i = 0;
			while ((arrLine = oRExpLine.exec(sSectionBody)) != null)
			{
				++i;
				var sLine = arrLine[1];
				if (sLine.length > 0) // ���� ������ �� ������
				{
					var sParamName = "";
					var sParamValue = "";
					// ���������� ������
					var isComment = (sLine.charAt(0) == this.pm_sCommentPrefix);
					if (isComment)
					{ 	// ���� ������ - ��� �����������
						sParamName = this.pm_sCommentPrefix + "comment_" + i;
						sParamValue = TrimTrailingEOLs(sLine.substr(1));
					} else if ((arrParam = oRExpParam.exec(sLine)) != null)
					{ 	// ���� ������ - ��� ��������
						sParamName = Trim(arrParam[1]);
						sParamValue = Trim(arrParam[2]);
					}
					// ������� �������� ���� ���-�� �����
					if (sParamName != "")
					{
						var oParam = oSection.Parameter(sParamName, true);
						oParam.Set(sParamValue);
						oParam.isComment = isComment;
					}
				}
			}
		}
	}

	// ��������� � ����
	this.Save = function()
	{
		var oFile = FSO().OpenTextFile(this.pm_sPathToINI, FOR_WRITING, true);
		GrantFoFAccessToEveryoneSilent(this.pm_sPathToINI);
		oFile.Write(this.pm_Serialize());
	}

	// ��������� �� �����
	this.Load = function(
		sPathToFile
	)
	{
		sPathToFile = TreatAsStr(sPathToFile, this.pm_sPathToINI);
		this.pm_Unserialize(GetFileBody(this.pm_sPathToINI));
	}

	//
	this.pm_GetParam = function(
		sSection,
		sParamName
	)
	{
		var oParam = null;
		var oSection = this.Section(sSection);
		if (oSection != null) {
			oParam = oSection.Parameter(sParamName);
		}
		return oParam;
	}

	//
	this.GetAsStr = function(
		sSection,
		sParamName,
		sDefaultValue
	)
	{
		sDefaultValue = TreatAsStr(sDefaultValue, null);
		var oParam = this.pm_GetParam(sSection, sParamName);
		if (oParam  != null)
			return oParam.GetAsStr();
		else
			return sDefaultValue;
	}

	//
	this.GetAsNum = function(
		sSection,
		sParamName,
		iDefaultValue
	)
	{
		iDefaultValue = TreatAsNum(iDefaultValue, null);
		var oParam = this.pm_GetParam(sSection, sParamName);
		if (oParam  != null)
			return oParam.GetAsNum();
		else
			return iDefaultValue;
	}

	//
	this.GetAsBool = function(
		sSection,
		sParamName,
		bDefaultValue
	)
	{
		bDefaultValue = TreatAsBool(bDefaultValue, null);
		var oParam = this.pm_GetParam(sSection, sParamName);
		if (oParam  != null)
			return oParam.GetAsBool();
		else
			return bDefaultValue;
	}
}

// ����� ��� ������������ ���������
function CLogger(
	sPathToLogFile // ������ ���� � ��� �����
)
{
	// ������ ������ ���� � ���-�����
	this.pm_sPathToLogFile = sPathToLogFile;
	// FSO::TextStream ��� �����
	this.pm_oLogFileTS = FSO().OpenTextFile(this.pm_sPathToLogFile, FOR_APPENDING, true);

	// ��������� ���
	this.Close = function()
	{
		this.pm_oLogFileTS.Close();
		this.pm_oLogFileTS = null;
	}

	// ��������� ������ � ����
	this.pm_AddMessage = function(
		sMessage // ����� ������������ ���������
	)
	{
		// ��������� ��������� �����
		var oDate = new Date();
		var sTimeStamp = oDate.toDateString() + " " + oDate.toLocaleTimeString() + "." + oDate.getMilliseconds();;
		// ����� ���������
		this.pm_oLogFileTS.WriteLine(sTimeStamp + " | " + TrimTrailingEOLs(sMessage));
	}

	// ��������� �������������� ���������
	this.Info = function(
		sMessage // ����� ������������ ���������
	)
	{
		return this.pm_AddMessage("INFO: " + sMessage);
	}

	// ��������� ��������������
	this.Warning = function(
		sMessage // ����� ������������ ���������
	)
	{
		return this.pm_AddMessage("WARNING: " + sMessage);
	}

	// ��������� ��������� �� ������
	this.Error = function(
		sMessage // ����� ������������ ���������
	)
	{
		return this.pm_AddMessage("ERROR: " + sMessage);
	}

	// ��������� ��������� �� ����������
	this.Exception = function(
		oException //
	)
	{
		if (oException instanceof Error) {
			return this.pm_AddMessage("EXCEPTION: number: " + ToHEXStr(oException.number) + "; name: " + oException.name + "; message: " + oException.message);
		} else {
			return this.pm_AddMessage("EXCEPTION: " + oException);
		}
	}
}

// ����� �������������� ���������������� � ����� ������� ������������� ���� "����������� ������"
function CriticalSection(
	sCSName // ��� ����������� ������ (������ ���� �������� ������ �����)
)
{
	// ��� ����������� ������
	this.pm_csCSName = "cs." + sCSName;
	// ��� �����
	this.pm_sPathToLockFile = GetTempDirForSyncOps() + "\\" + this.pm_csCSName;
	// Fso:TextStream ��� �����
	this.pm_oLockFile = null;
	// ��������� �� ���
	this.pm_bIsLocked = false;
	// ������� �������
	this.pm_iLockCount = 0;

	// �������� ����� � ����������� ������ � ������� ��������� �������. True - ���� �����������, False - �����.
	this.Enter = function(
		iTimeout // ����� � ������� �������� ����� ����� ����� � ������, ���� -1 �� ���� �� �����
	)
	{
		iTimeout = TreatAsNum(iTimeout, 0);
		//
		if (!this.pm_bIsLocked)
		{
			// �������� �������� ���� � ������� ��������� �������
			var iDeadLine = CurrTimeStamp() + iTimeout;
			do {
				try	{
					this.pm_oLockFile = FSO().OpenTextFile(this.pm_sPathToLockFile, FOR_WRITING, true);
					if (this.pm_oLockFile != null) {
						GrantFoFAccessToEveryoneSilent(this.pm_sPathToLockFile);
					}
					this.pm_bIsLocked = true;
				} catch(oEx) {
					if (oEx.number == -2146828218) {//if "Permission denied"
						WScript.Sleep(iTimeout/50);
					} else {
						Logger().Exception(oEx);
						Logger().Error("���������� ��� ������� �������� ���� ��� ����������� ������ �� ���� \"" + this.pm_sPathToLockFile + "\"");
						throw oEx;
					}
				}
			} while ( ((iTimeout == -1) || (CurrTimeStamp() < iDeadLine)) && (!this.pm_bIsLocked) );
		}
		if (this.pm_bIsLocked) this.pm_iLockCount++;
		return this.pm_bIsLocked;
	}

	// ������� �� ����������� ������
	this.Leave = function()
	{
		if (this.pm_bIsLocked) {
			this.pm_iLockCount--;
			if (this.pm_iLockCount == 0) {
				this.pm_oLockFile.Close();
				this.pm_oLockFile = null;
				this.pm_bIsLocked = false;
			}
		}
	}
}

// ����� ��������� ������, ������������ �� ������ ���-�� ���, ���-�� ���� �������� ������
function UseCounter (
	sName // ��� (������ ���� �������� ������ �����)
)
{
	// ��� �������
	this.pm_sName = "uc." + sName;
	// ��� �����
	this.pm_sFileName = GetTempDirForSyncOps() + "\\" + this.pm_sName;
	// ����������� ������ ��� ������������� ��������
	this.pm_oSyncCS	= new CriticalSection(this.pm_sName);
	// ������ �����
	this.pm_oTextStream = null;
	//
	this.pm_iUseCount = 0;

	// ��������� ����
	this.pm_OpenFile = function()
	{
		if (this.pm_oSyncCS.Enter(-1))
			try {
				this.pm_oTextStream = FSO().OpenTextFile(this.pm_sFileName, FOR_READING, true);
				GrantFoFAccessToEveryoneSilent(this.pm_sFileName);
			} finally {
				this.pm_oSyncCS.Leave();
			}
	}

	// ��������� ����
	this.pm_CloseFile = function()
	{
		this.pm_oTextStream.Close();
		this.pm_oTextStream = null;
	}

	// ������������ ������
	this.Use = function()
	{
		this.pm_iUseCount++;
		if (this.pm_iUseCount == 1) {
			this.pm_OpenFile();
		}
	}

	// ���������� ������
	this.Free = function()
	{
		if (this.pm_iUseCount > 0) {
			if (this.pm_iUseCount == 1) {
				this.pm_CloseFile();
			}
			this.pm_iUseCount--;
		}
	}

	// �������, ���������� �� ���-�� ��� ���� ������
	this.IsUsing = function()
	{
		var bRes = false;
		//
		if ( (this.pm_oSyncCS.Enter(-1)) )
			try {
				// �������� ��� �������, ���� ������� �� ��������� ������ ���-�� ��� ��� ������
				try {
					if (FSO().FileExists(this.pm_sFileName))
						FSO().DeleteFile(this.pm_sFileName);
				} catch (oEx) {
					if (IsInt32Equal(oEx.number, 0x800a0046)) {// Access denied
						bRes = true;
					} else {
						Logger().Exception(oEx);
						Logger().Error("���������� ��� ������� ������� ���� UseCounter �� ���� \"" + this.pm_sFileName + "\"");
						throw oEx;
					}
				}
			} finally {
				this.pm_oSyncCS.Leave();
			}
		//
		return bRes;
	}

	// ������� ������������ ������� (��� ������������� ������� ������������ Event)
	this.WaitForFree = function(
		iTimeout
	)
	{
		iTimeout = TreatAsNum(iTimeout, 0);
		var bResult = false;
		//
		var iDeadLine = CurrTimeStamp() + iTimeout;
		do {
			bResult = !this.IsUsing();
			if (bResult) break;
			WScript.Sleep(500);
		} while ((iTimeout == -1) || (CurrTimeStamp() < iDeadLine));
		//
		return bResult;
	}
}


// �����, �������������� ���������������� � ����� ������� ������������� ���� event
function Event(
	sEventName, // ��� event'� (������ ���� �������� ������ �����)
	bInitialState // ��������� ��������� (false - non signaled, true - signaled), ��-��������� false
)
{
	//
	bInitialState = TreatAsBool(bInitialState, false);

	// ���
	this.pm_sEventName = "event." + sEventName;
	// ����� ������
	this.pm_sPathToEventFile_1 = GetTempDirForSyncOps() + "\\" + this.pm_sEventName + ".1";
	this.pm_sPathToEventFile_2 = GetTempDirForSyncOps() + "\\" + this.pm_sEventName + ".2";
	// �������, ����������, ������������ �� ������� ���-������
	this.pm_oUC = new UseCounter(this.pm_sEventName);
	// ����������� ������ ���������������� ��������� ���������
	this.pm_oCS = new CriticalSection(this.pm_sEventName + ".change");

	//
	this.pm_ciDelayTime = 100;

	// ������������� �������
	this.pm_Initialize = function(
		bInitialState
	)
	{
		var oCSInit = new CriticalSection(this.pm_sEventName + ".init");
		if (oCSInit.Enter(-1))
			try	{
				if (!this.pm_oUC.IsUsing()) { // ������� ����� �� ������������, ������� ����� ��������������������
					bInitialState ? this.Set() : this.Reset();
				}
				// ������� ��� ���������� ������, �.�. ��� ����������������� ����� ��� �� �������
				this.pm_oUC.Use(); // free ����� �� ��������, �.�. ���������� ��������� ��� ����������� ���������� �������
			} finally {
				oCSInit.Leave();
			}
	}

	// ��������� � ��������� signaled
	this.Set = function()
	{
		if (this.pm_oCS.Enter(-1))
			try {
				if (!FSO().FileExists(this.pm_sPathToEventFile_1)) {
					FSO().CreateTextFile(this.pm_sPathToEventFile_1).Close();
					GrantFoFAccessToEveryoneSilent(this.pm_sPathToEventFile_1);
					WScript.Sleep(this.pm_ciDelayTime*3/2);
				}
				if (!FSO().FileExists(this.pm_sPathToEventFile_2)) {
					FSO().CreateTextFile(this.pm_sPathToEventFile_2).Close();
					GrantFoFAccessToEveryoneSilent(this.pm_sPathToEventFile_2);
				}
			} finally {
				this.pm_oCS.Leave();
			}
	}

	// ����� � ��������� unsignaled
	this.Reset = function()
	{
		if (this.pm_oCS.Enter(-1))
			try {
				if (FSO().FileExists(this.pm_sPathToEventFile_1))
					FSO().DeleteFile(this.pm_sPathToEventFile_1);
				if (FSO().FileExists(this.pm_sPathToEventFile_2))
					FSO().DeleteFile(this.pm_sPathToEventFile_2);
			} finally {
				this.pm_oCS.Leave();
			}
	}

	// ���� ���� ��������� �� ������ signaled, ���������� true ���� ���������
	this.Wait = function(
		iTimeout // ������� ����� �����, ���� -1, �� ���������
	)
	{
		iTimeout = TreatAsNum(iTimeout, 0);
		var bResult = false;
		//
		var iDeadLine = CurrTimeStamp() + iTimeout;
		var bIs1Exists = false;
		do {
			if (!bIs1Exists) {
				bIs1Exists = FSO().FileExists(this.pm_sPathToEventFile_1);
				if (!bIs1Exists)
					WScript.Sleep(this.pm_ciDelayTime);
			}
			bResult = bIs1Exists && FSO().FileExists(this.pm_sPathToEventFile_2);
			if (bResult) break;
		} while ((iTimeout == -1) || (CurrTimeStamp() < iDeadLine));
		//
		return bResult;
	}

	//
	this.pm_Initialize(bInitialState);
}

// �����, ����������� �������� �������� �������
function F1ServerChecker(
	sPathToUtil, // ������ ���� � ������� F1ServerChecker
	sPathToUtilINIFile, // ������ ���� � ini-����� ��� �������, ���� �� ������, �� �� ������������
	sPathToAdapterINIFile // ������ ���� � ini-����� ��������, ���� �� ������, �� �� ������������
)
{
	// ������ ���� � ������� F1ServerChecker
	this.pm_sPathToUtil = sPathToUtil;
	// ������ ���� � ini-����� ��� �������, ���� �� ������, �� �� ������������
	this.pm_sPathToUtilINIFile = TreatAsStr(sPathToUtilINIFile, "");
	// ������ ���� � ini-����� ��������, ���� �� ������, �� �� ������������
	this.pm_sPathToAdapterINIFile = TreatAsStr(sPathToAdapterINIFile, "");

	// ��� ������ �������
	this.pm_iExitCode = -1;
	
	// ����� �������������� ������ ��� ��������. �����, ������ ��� ����������� ��-��� �������� System, � ��� ������ ������� ����� � �� ����
	this.pm_PrepareRegistry = function()
	{
		// ���� � ������� ��� ������� 
		var sRegKey = "HKCU\\Software\\Garant.F1\\ApplicationAdapterOptions";
	
		// �������������				
		var sRegValue =
			"-GCMConfigFile \"" + this.pm_sPathToAdapterINIFile + "\" " +
			"-GPMAdapterConfigSection \"F1Client Params\"";
		WshShell().RegWrite(sRegKey, sRegValue, "REG_SZ");
	}
	
	//
	this.GetExitCode = function ()
	{
		return this.pm_iExitCode;
	}

	// ����� ��������� ��������. ���� ������� ���������� �� �������� �����, �� ���������� true, ���� ��� - �� false
	this.RunChecker = function(
		iTimeout // ����� � ������������� � ������� �������� ����� ����� �������� �������
	)
	{
		this.pm_PrepareRegistry();
		
		// ��������� �������
		var oWshScriptExec = ExecEx(this.pm_sPathToUtil, "\"" + this.pm_sPathToUtilINIFile + "\"");
		// ���� ���� ����������
		var iDeadLine = CurrTimeStamp() + iTimeout;
		while (iDeadLine > CurrTimeStamp())
			if (oWshScriptExec.Status == WSH_FINISHED)
				break;
			else {
				// pipe'� ���� ���������� ����� �����(!) ���� ������. �� ���� ��� ���� ������ � ����������� ������� ������ ��� ���������� read ����������, �� � ��� ��� �� ���, � ����������� ���� ����������. �������, �������� � stderr, ������ ��� ���� ������� �����.
				if (!oWshScriptExec.StdErr.AtEndOfStream)
					oWshScriptExec.StdErr.ReadAll();
				if (!oWshScriptExec.StdOut.AtEndOfStream)
					oWshScriptExec.StdOut.ReadAll();

				WScript.Sleep(500);
			}

		// ������� �����, ���������, ���������� �� �������
		if (oWshScriptExec.Status == WSH_FINISHED) {
			this.pm_iExitCode = oWshScriptExec.ExitCode;
			return true;
		} else {
			oWshScriptExec.Terminate(); // ��������� �����
			return false;
		}
	}
}

// ����� ����������� �������� ��������� �������
function F1SrvStopper(
	sPathToServer // ���� � ����� ���� ���������� ������
)
{
	if ( !FSO().FolderExists(sPathToServer) )
		throw "���� � ������� �� ����������!";

	// ��������� �� �����, ��� ����� ������
	this.pm_sPathToServerFolder = sPathToServer;
	// ��� �������� ������� ��������� �������
	this.pm_csProcName = "F1ServerStopper.exe";

	// ����� ���������� WMI-������ ���� Win32_Process ��� ������� ��������� �������
	this.pm_GetWMIProcessToSrvStopper = function()
	{
		return GetWMIObjectForProcess(this.pm_csProcName);
	}

	// ����� ������� �������� �� ������� ��������� �������
	this.IsSrvStopperRunning = function()
	{
		return (this.pm_GetWMIProcessToSrvStopper() != null);
	}

	// ����� ��������� ������� ��������� �������. � ������ �������� ������� ���������� ������ WshScriptExec, ����� null
	this.Start = function(
		iTimeout // � ������� ����� ������� (� �������������) ���� ������� ������� ��������� �������
	)
	{
		if (typeof(iTimeout) != "number")
			throw "iTimeout ������ ���� ����� � ������ ���� ������!";

		// ��������� ���� � ������� ��������� �������
		var sPathToSrvStop = "";
		sPathToSrvStop = this.pm_sPathToServerFolder + "\\apps\\winNT\\" + this.pm_csProcName;
		if ( !FSO().FileExists(sPathToSrvStop) ) {
			Logger().Error("������� ��������� ������� �� ������� �� ���� \"" + sPathToSrvStop + "\"");
			throw "�� ���� ����� ���� � srvstop.bat";
		}

		// ��������� �������
		var oWshScriptExec = ExecEx(
			sPathToSrvStop,
			"-GCMConfigFile \"" + this.pm_sPathToServerFolder + "\\garant.ini\" -GPMAdapterConfigSection \"F1Client Params\""
		);
		Logger().Info("�������� ������� ��� �������� �������");

		return oWshScriptExec;
	}

	// ����� ������������� ��������� ������ �������. ������� true ���� ����� ��������� ��� ������ ������� ��������� ������� �� ��������
	this.Terminate = function()
	{
		var oWMISrvStopper = this.pm_GetWMIProcessToSrvStopper();
		if (oWMISrvStopper != null)
		{
			Logger().Info("������ ������� ��������� ������� ����� ������������� ���������");
			TerminateWMIProcess(oWMISrvStopper);
			// ��������� ��� ��� ����������
			oWMISrvStopper = this.pm_GetWMIProcessToSrvStopper();
			if (oWMISrvStopper == null) {
				Logger().Info("�������������� ���������� ������ ������� ��������� ������� ������ �������.");
			} else {
				Logger().Error("�� ������� ������������� ��������� ������� ��������� �������! PID ��������: " + oWMISrvStopper.ProcessId);
			}
		}
		return !this.IsSrvStopperRunning();
	}
}

// ����������� �����-��������� ��� callback-�����������, ������������� ��� ����������� �������
function RestartHandlerBase()
{
	// ���� ���������� ���������� ����� ������� ��������� �������
	this.OnStopBegin = function()
	{
		throw "Must be implemented!";
	}

	// ���� ���������� ���������� ����� ��������� �������
	this.OnStopEnd = function(
		isStopSuccess
	)
	{
		throw "Must be implemented!";
	}

	// ���� ���������� ���������� ����� ������� ������� �������
	this.OnStartBegin = function()
	{
		throw "Must be implemented!";
	}

	// ���� ���������� ���������� ����� ������� �������
	this.OnStartEnd = function(
		isStartSuccess
	)
	{
		throw "Must be implemented!";
	}
}

RestartHandler4EMailNotifications.prototype = new RestartHandlerBase();
function RestartHandler4EMailNotifications(
	sRestartCause, // ������� �����������
	sName, // �������� ���� ��� �������������
	sFromEMail, // �� ���� �������� ������
	sToEMail // ���� �������� ������
)
{
	this.pm_sRestartCause = sRestartCause;
	this.pm_sFromEMail = sFromEMail;
	this.pm_sToEMail = sToEMail;
	this.pm_sName = sName;

	this.OnStopBegin = function()
	{
		if (this.pm_sToEMail != "")
			SendMail(this.pm_sFromEMail, this.pm_sToEMail,
				"������ ������������ " + this.pm_sName + " �� ������ " + CompName(),
				HTMLDoc("������������ " + this.pm_sName, this.pm_sName + " ����� ������������.<div>�������: " + this.pm_sRestartCause + "<div>������ ��������� " + this.pm_sName + ".")
			);
	}

	this.OnStopEnd = function(
		isStopSuccess
	)
	{
		if (this.pm_sToEMail != "")
			if (isStopSuccess)
				SendMail(this.pm_sFromEMail, this.pm_sToEMail,
					"������� ���������� " + this.pm_sName + " �� ������ " + CompName(),
					 HTMLDoc("��������� " + this.pm_sName, this.pm_sName + " ������� ����������."));
			else
				SendMail(this.pm_sFromEMail, this.pm_sToEMail,
					"������ ��� ��������� " + this.pm_sName + " �� ������ " + CompName(),
					HTMLDoc("��������� " + this.pm_sName, "��� ��������� " + this.pm_sName + " �������� ������. ��������, ��������� ������ �������������!") );
	}

	this.OnStartBegin = function()
	{
		if (this.pm_sToEMail != "")
			SendMail(this.pm_sFromEMail, this.pm_sToEMail,
				"����� ������ " + this.pm_sName + " �� ������ " + CompName(),
				HTMLDoc("������ " + this.pm_sName, "������ ������ " + this.pm_sName + ".")
			);
	}

	this.OnStartEnd = function(
		isStartSuccess
	)
	{
		if (this.pm_sToEMail != "")
			if (isStartSuccess)	{
				SendMail(this.pm_sFromEMail, this.pm_sToEMail,
					"������� ����������� " + this.pm_sName + " �� ������ " + CompName(),
					HTMLDoc("������ " + this.pm_sName, "���������� " + this.pm_sName + " ��������� �������.") );
			} else {
				SendMail(this.pm_sFromEMail, this.pm_sToEMail,
					"������ ��� ������� " + this.pm_sName + " �� ������ " + CompName(),
					HTMLDoc("������ " + this.pm_sName, "��� ������� " + this.pm_sName + " �������� ������. ��������, ��������� ������ �������������!")	);
			}
	}
}

// �����, ����������� ����� (��� F1Server � intranet) ���������������� ����������������/������������ ��������
function ManageableProduct(
	sUniqueID, // ������������� ��������
	sNameForLog // ������������������ ���, ��� ������ � ���
)
{
	sUniqueID = TreatAsStr(sUniqueID, "");
	if (sUniqueID == "") throw "sUniqueID ������ ���� �������!";
	// ��� ��� ������ � ���
	this.sNameForLog = TreatAsStr(sNameForLog, "");
	if (this.sNameForLog != "") {
		this.sNameForLog = "\"" + this.sNameForLog + "\"";
	} else {
		throw "sNameForLog ������ ���� �������!";
	}

	// ����������� ������ �������������� ������/��������� �������
	this.pm_oCSStartOrStopPerformed = new CriticalSection(sUniqueID + ".control.utility.sos");
	// ������� ��� ��������� ���������� � ���, ���� �� ������� �������/���������
	this.pm_oUCStartOrStopPerformed = new UseCounter(sUniqueID + ".control.utility.sos");

	// ����� ��������� �������. � ������ ��������� ������� ������� true, ����� false
	this.Start = function()
	{
		if ( this.BeginStartOrStop() )
		{
			Logger().Info("��������� " + this.sNameForLog);
			try {
				if (!this.IsRunning()) {
					// ������� ��� �� �������
					try {
						this.pm_Start();
					} catch (oEx) {
						Logger().Exception(oEx);
						Logger().Error("���������� ��� ���������� this.pm_Start");
					}
				} else {
					//  ������� ��� �������
					Logger().Warning("������� ��������� " + this.sNameForLog + " � �� ����� ��� �� ��� �������!");
				}
				//
				var bResult = this.IsRunning();
				if (bResult) {
					Logger().Info("������� ��������� " + this.sNameForLog);
				} else {
					Logger().Warning("�� ������� ��������� " + this.sNameForLog);
				}
				//
				return bResult;
			} finally {
				this.FinishStartOrStop();
			}
		} else {
			throw "��� ���������� �����-�� �������� ���������� " + this.sNameForLog + ".";
		}
	}

	// ����� ������������� �������. ���� �� ��������� ������ ������� ������ �� ������� �� ���������� true, ����� - false.
	this.Stop = function(
		iTimeout, // � ������� ����� ������� (� �������������) ����� ����� ���������� ��������� �������
		isKill // ������� ������� ���� �� �� ����������� � ������� ��������� ������� (��-���������: true)
	)
	{
		if (TreatAsNum(iTimeout) == null) throw "iTimeout ����� ���� ������!";
		isKill = TreatAsBool(isKill, true);
		//
		if ( this.BeginStartOrStop() )
		{
			Logger().Info("������������� " + this.sNameForLog);
			try {
				if (this.IsRunning()) {
					// ������� �������
					try {
						this.pm_Stop(iTimeout, isKill);
					} catch (oEx) {
						Logger().Exception(oEx);
						Logger().Error("���������� ��� ���������� this.pm_Stop");
					}
				} else {
					// ������� ��� ����������
					Logger().Warning("������� ���������� " + this.sNameForLog + " � �� ����� ��� �� ��� ����������");
				}
				//
				var bResult = !this.IsRunning();
				if (bResult) {
					Logger().Info("������� ���������� " + this.sNameForLog);
				} else {
					Logger().Warning("�� ������� ���������� " + this.sNameForLog + " �� ���������� ����� (" + iTimeout + " ��)");
				}
				//
				return bResult;
			} finally {
				this.FinishStartOrStop();
			}
		} else {
			throw "��� ���������� �����-�� �������� ���������� " + this.sNameForLog + ".";
		}
	}

	// ����� ������������� �������
	this.Restart = function(
		iTimeout, // ����� � ������� �������� ���� ��������� ��������
		oHandler // ��������� ������, ��������������� �� RestartHandlerBase
	)
	{
		if (TreatAsNum(iTimeout) == null) throw "iTimeout ������ ���� ������!";
		if (typeof(oHandler) != "object") oHandler = null;
		//
		if ( this.BeginStartOrStop() )
		{
			Logger().Info("������������� " + this.sNameForLog);
			try {
				var bStartSuccess = false;
				var bStopSuccess = false;

				// �������� ���������� ������� "����� ����������"
				if (oHandler != null)
					oHandler.OnStopBegin();
				// ������������� ������
				bStopSuccess = this.Stop(iTimeout);
				// �������� ���������� ������� "����� ���������" � ����������� ���������
				if (oHandler != null)
					oHandler.OnStopEnd(bStopSuccess);
				// ���� ������ ����������� �� ��������� ���
				if (bStopSuccess)
				{
					// �������� ���������� ������� "����� ��������"
					if (oHandler != null)
						oHandler.OnStartBegin();
					// ��������� �������
					bStartSuccess = this.Start();
					// �������� ���������� ������� "����� �������" � ����������� �������
					if ( oHandler != null )
						oHandler.OnStartEnd(bStartSuccess);
				}
				//
				var bResult = bStopSuccess && bStartSuccess;
				if (bResult) {
					Logger().Info("������� ������������� " + this.sNameForLog);
				} else {
					Logger().Warning("�� ������� ������������� " + this.sNameForLog + " �� ���������� ����� (" + iTimeout + " ��)");
				}
				//
				return bResult;
			} finally {
				this.FinishStartOrStop();
			}
		} else {
			throw "��� ���������� �����-�� �������� ���������� " + this.sNameForLog + ".";
		}
	}

	// ��������� ������/��������� ������ ����������� "������"
	this.PermitStartOrStopOnlyForMe = function()
	{
		return this.pm_oCSStartOrStopPerformed.Enter(0);
	}

	// ���������/������ ��������� ����
	this.PermitStartOrStopForAll = function()
	{
		this.pm_oCSStartOrStopPerformed.Leave();
	}

	// ������, ������� ������ ���� ������� ��� ������ �������� ���������, �������, ����������� �������
	// ����� ����� ���� ���������������� ������ ���������� ��������������
	this.BeginStartOrStop = function()
	{
		var bResult = this.pm_oCSStartOrStopPerformed.Enter(0);
		if (bResult) {
			this.pm_oUCStartOrStopPerformed.Use();
		}
		return bResult;
	}

	//
	this.FinishStartOrStop = function()
	{
		this.pm_oCSStartOrStopPerformed.Leave();
		this.pm_oUCStartOrStopPerformed.Free();
	}

	// ����� ������� ������������ �� �����-������ �������� �������� ��� ��������
	this.IsStartingOrStopping = function()
	{
		return this.pm_oUCStartOrStopPerformed.IsUsing();
	}

	// ------- ����������� ������ --------

	// ����� ������� ������� �� �������. ���������� true ��� false
	this.IsRunning = function()
	{
		throw "Must be implemented!";
	}

	// ����� ��������� �������
	this.pm_Start = function()
	{
		throw "Must be implemented!";
	}

	// ����� ������������� �������
	this.pm_Stop = function(
		iTimeout, // � ������� ����� ������� (� �������������) ����� ����� ���������� ���������
		isKill // ������� ������� ���� �� �� ����������� � ������� ��������� ������� (��-���������: true)
	)
	{
		throw "Must be implemented!";
	}
}

// ����� ����������� ��������
function F1Server(
	sForcedRegSubPath, // ������� � �������. ���� �����, �� ���������� ���, ���� ��� - �� ���������� ��������� (�� ��������� ������ ��� ������� ��-������)
	sForcedServiceName, // ��� ������� �������. ���� �����, �� ���������� ���, ���� ��� - �� ���������� ��������� (�� ��������� ������ ��� ������� ��-������)
	bIs64BitServer // 64-������ ������, ��-��������� false
)
{
	// �������� ������������ �����������
	ManageableProduct.apply(this, ["f1server", "C����� ������"]);

	// ������� � �������
	this.pm_sRegSubPath = TreatAsStr(sForcedRegSubPath, "");
	// ��� �������
	this.pm_sServiceName = TreatAsStr(sForcedServiceName, "");
	// ������� 64-�������� �������
	this.pm_bIs64BitServer = TreatAsBool(bIs64BitServer, false);
	if ( (!Is64bitWindows()) && this.pm_bIs64BitServer ) {
		throw "������ ��������� 64-� ��������� �������� �� 32-� ��������� ��!";
	}

	// ��������� �� ������ ������ ��� ������ (true), ��� ���������� ������������� (���� ������, ����������� � ������� - ��������� ��� ������, ��� - ��� ������� �������)
	this.isForceStartAsService = false;

	// ����� ���������� ������ ���� � ����� � ��������. ����� ��� �� �������.
	this.pm_GetPathToServerFolder = function()
	{
		// ���������� ����� ���� ������� ������
		var sRegPath = "";
		if (Is64bitWindows() && !this.pm_bIs64BitServer) {
			sRegPath = "HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\";
		} else {
			sRegPath = "HKEY_LOCAL_MACHINE\\SOFTWARE\\";
		}
		if (this.pm_sRegSubPath != "") {
			// ������� � ������� ����� ����
			sRegPath += this.pm_sRegSubPath;
		} else {
			// ������� �� �����, ���������� ����������� �������� ��� ��-������
			sRegPath += "Garant.F1";
		}
		sRegPath += "\\ApplicationServerOptions";
		// ������ ��� ��������
		var sKeyValue = "";
		try {
			sKeyValue = WshShell().RegRead(sRegPath);
		} catch (oEx) {
			sKeyValue = "";
		}
		// ��������� ����
		var sResult = "";
		var oRExp = /GCMConfigFile \"(.*)\\garant\.ini\"/i;
		var arrRes = sKeyValue.match(oRExp);
		if (arrRes != null)
			sResult = arrRes[1];
		return sResult;
	}

	// ����� ���������� ������ ���� � ini-����� �������. ����� ��� �� �������.
	this.GetPathToINIFile = function()
	{
		var sResult = this.pm_GetPathToServerFolder();
		if (sResult != "") {
			sResult += "\\garant.ini";
		}
		return sResult;
	}

	// ������ ������ ���-�����, ������ ��� ������ ������, �.�. � ����� ��� ����������
	this.pm_MakeFreshINIFile = function()
	{
		var oIniFile = new IniMan( this.GetPathToINIFile() );
		oIniFile.Load();
		return oIniFile;
	}

	// ����� ���������� �������� �� ini-����� �������. ���� �������� �� ������� �� ���������� null.
	this.GetValueFromGarantINI = function(
		sSectionName, // ��� ������ (��� ���������� ������)
		sParamName // ��� ���������
	)
	{
		return this.pm_MakeFreshINIFile().GetAsStr(sSectionName, sParamName, null);
	}
		
	// ����� ���������� ������ ���� � ���� ������
	this.pm_GetDataPath = function(
		isActiveDB // ���������� ������ �������� (true) ��� ���������� ���� (false)
	) 
	{	
		isActiveDB = TreatAsBool(isActiveDB, true);
		//
		var sDP = null;
		try {
			sDP = this.GetValueFromGarantINI("F1Server Params", "-GCMActiveDataPath");
		} catch (oEx) {
			Logger().Error("�� ������� �������� �������� -GCMActiveDataPath �� ������ F1Server Params");
			Logger().Exception(oEx);
			throw oEx;
		}
		//
		if ((sDP != "1") && (sDP != "2"))
		{
			Logger().Error("�������� ��������� ����������: " + sDP);
			throw "����������� �������� ���������!";
		}
		//
		if (isActiveDB) 
			return sDP/1; // � �����
		else	
			return sDP ^ 3; // 2 -> 1, 1 -> 2
	}

	// ������ � ���-����� �������� ��������� -GCMActiveDataPath
	this.SwitchDataBaseInINIFile = function()
	{
		var oIniFile = this.pm_MakeFreshINIFile();
		// �� ������ ������ ������ ����� ���-�����
		try {
			FSO().CopyFile(oIniFile.GetPathToINI(), oIniFile.GetPathToINI() + ".backuped_by_serverwatcher", true);
		} catch(oEx) {
			Logger().Error("�� ������� ������� ����� ���-�����, � ��� � ���");
			Logger().Exception(oEx);
		}
		//
		oIniFile.Section("F1Server Params").Parameter("-GCMActiveDataPath").Set(this.pm_GetDataPath(false));
		//
		try {
			oIniFile.Save();
		} catch (oEx) {
			Logger().Error("������ ��� ���������� ����������� ini-����� � ������ SwitchDataBaseInINIFile");
			Logger().Exception(oEx);
		}
	}
	
	// ����� ���������� ���� � ���� ������ ������ �� ���-�����
	this.GetPathToDB = function(
		isActiveDB // �������� (true) ��� ���������� (false) ����
	)
	{
		return this.GetValueFromGarantINI("F1Server Params", "-GCMDataPath" + this.pm_GetDataPath(isActiveDB));
	}
	

	// ����� ���������� ������ ���� � ���� �������.
	this.GetPathToLog = function()
	{
		var sPathToLog = this.GetValueFromGarantINI("F1Server Params", "-SBELogFile");
		if (sPathToLog != null) {
			WshShell().ExpandEnvironmentStrings(sPathToLog);
		}
		return sPathToLog;
	}

	// ����� ���������� ������ Scripting::File ��� ���� �������. ���� ���� �� ���������� ��� �� ����� ��� ������� �� null
	this.GetLogFileObject = function()
	{
		var oResult = null;
		var sLogFilePath = this.GetPathToLog();
		//
		if ( FSO().FileExists(sLogFilePath) )
			try {
				oResult = FSO().GetFile(sLogFilePath);
			} catch (oEx) {
				Logger().Error("��� �������� ���� �� ���� " + sLogFilePath + " ��������� ���������� " + oEx.message);
				oResult = null;
			}
		//
		return oResult;

	}

	// ����� ������� ������� �� � �������� ������� �������� ORBDebugLevel
	this.IsORBDebugLevelON = function()
	{
		return (this.GetValueFromGarantINI("ORB Params", "-ORBDebugLevel") != null);
	}

	// ����� ���������� WMI-������ (Win32_Process) ��� �������� ������� (F1Server ��� GblPilotServer ��� garantServer) ���� null ���� ����� �� ������
	this.pm_GetWMIProcessToServer = function()
	{
		var oResult = null;
		var arrProcNames = ["F1Server.exe", "garantServer.exe", "GblPilotServer.exe"];
		// ���������� ��������� ����� ��������
		for (iIdx in arrProcNames)
		{
			var sProcName = arrProcNames[iIdx];
			oResult = GetWMIObjectForProcess(sProcName);
			if (oResult != null) break;
		}
		return oResult;
	}
	
	// ���������� PID �������
	this.GetProcessID = function()
	{
		var oF1ServerWMIProc = this.pm_GetWMIProcessToServer();
		if (oF1ServerWMIProc != null)
			return oF1ServerWMIProc.ProcessID
		else
			return -1;
	}

	// ------ ���������� ����������� ������� ---------

	// ����� ������� ������� �� ������� �������. ���������� true ��� false
	this.IsRunning = function()
	{
		var oF1ServerWMIProc = this.pm_GetWMIProcessToServer();
		return (oF1ServerWMIProc != null);
	}

	// ����� ������������� ������
	this.pm_Stop = function(
		iTimeout, // � ������� ����� ������� (� �������������) ����� ����� ���������� ��������� �������
		isKill // ������� ������ ���� �� �� ����������� � ������� ��������� ������� (��-���������: true)
	)
	{
		var isServerStopped = !this.IsRunning();
		// --- ������� ���������� ������ ��-����������� ---
		var oF1SrvStopper = new F1SrvStopper( this.pm_GetPathToServerFolder() );
		var isSrvStopperAlwaysStarted = oF1SrvStopper.IsSrvStopperRunning();

		// ���� ������� ��������� ������� �� ��������, �� ���������
		if ( !isSrvStopperAlwaysStarted ) {
			// ��������� �������
			var iBegTime = CurrTimeStamp();
			oF1SrvStopper.Start(iTimeout/2);
			iTimeout -= (CurrTimeStamp() - iBegTime);
		} else { // ����� ��������
			Logger().Warning("������� ��������� ������� ��� ���-�� ��������.");
		}

		// ���� ��������� �������
		var iDeadLine = CurrTimeStamp() + iTimeout;
		while (iDeadLine > CurrTimeStamp())
		{
			isServerStopped = !this.IsRunning();
			if (isServerStopped) break;
			WScript.Sleep(300);
		}

		if (isServerStopped) {
			Logger().Info(this.sNameForLog + " ��������� �������� ���� ������ � ������� ����������� ������� " + iTimeout + " ��");
		} else {
			Logger().Warning(this.sNameForLog + " �� ����������� � ������� " + iTimeout + "��");
		}

		// ������, ���� ������� ��������� ������� �������� ����, �� ��������� �� ���� ��� ��� ��������
		if ( (!isSrvStopperAlwaysStarted) && oF1SrvStopper.IsSrvStopperRunning()) {
			Logger().Warning("������� ��������� ������� ��� ��� ��������, ���� ����� ���������� �� ��������� ������� �������!");
			oF1SrvStopper.Terminate();
		}

		// --- ������� ������ ---
		// ���� ��������� ����� ������ �� ������ ���
		if ((!isServerStopped) && isKill)
		{
			// ������� ������� �������
			Logger().Info("��� ��� ������� " + this.sNameForLog + " �� ���� ��������� ����������� ������������� ��������� ���");
			var oF1ServerWMIProc = this.pm_GetWMIProcessToServer();
			TerminateWMIProcess(oF1ServerWMIProc);
			// ��������� ������� �� ��� ���
			isServerStopped = !this.IsRunning();
			if (isServerStopped) {
				Logger().Info("�������������� ���������� ������ " + this.sNameForLog + " ������ �������");
			} else {
				Logger().Error("�� ������� ������������� ��������� ������ " + this.sNameForLog + "!");
			}
		}
	}

	// ����� ��������� ������. ���� ���������� ������ � ��� ����� ������� ���������� � Auto, �� ��������� ������ ���, � ��������� ������ ������ ��� �������
	// � ������ ��������� ������� ������� true, ����� false
	this.pm_Start = function()
	{
		// ���������� ��� �������
		var sSrvServiceName = "";
		if (this.pm_sServiceName != "") {
			// ��� ������� ������ ����
			sSrvServiceName = this.pm_sServiceName;
		} else {
			// ��� ������� �� ������, ������ ��� �� �������� ����� (�������� ������ ��� ��-������)
			sSrvServiceName = this.GetValueFromGarantINI("ServerManager", "-Services");
		}
		if (sSrvServiceName == "")
			throw "��� ������� �� ����� ���� ������!";

		// ������� WMI-������ ��� �������
		var oSrvService = GetWMIObjectForService(sSrvServiceName);

		// ���������� ��� ����� ���������
		var isRunAsService = false;
		if (this.isForceStartAsService)
			isRunAsService = true;
		else
			isRunAsService = ((oSrvService != null) && (oSrvService.StartMode == "Auto"));

		// ----- ��������� -----
		if (isRunAsService)
		{ // ��������� ��� ������
			if (oSrvService != null) {
				StartService(oSrvService, 30000);
			} else  {
				Logger().Error("������ �� ������");
			}
		}
		else
		{ // ��������� ��� ������� �������
			Logger().Info(this.sNameForLog + " ����� ������� ��� ������� �������.");
			// ���������� ��� ����� ������
			var csExeName = "F1Server.exe";
			var sPathToExe = this.pm_GetPathToServerFolder() + "\\apps\\" + (this.pm_bIs64BitServer ? "win64" : "winNT") + "\\" + csExeName;
			if ( FSO().FileExists(sPathToExe) ) {
				// ���������
				ExecEx(sPathToExe, "-d");
				// ���� �������
				var iTimeout = 30000;
				var iDeadLine = CurrTimeStamp() + iTimeout;
				while (iDeadLine > CurrTimeStamp())
				{
					if (this.IsRunning()) break;
					WScript.Sleep(300);
				}

				if (this.IsRunning()) {
					Logger().Info(this.sNameForLog + " ������� �������!");
				} else	{
					Logger().Warning("� ������� " + iTimeout + " �� �� ��������� ������� �������� " + this.sNameForLog + "!");
				}
			} else {
				Logger().Error("exe-���� " + this.sNameForLog + " �� ������ �� ���� " + sPathToExe);
			}
		}
	}
}

// ��������� �����, ����� ��� ������������
function _PortUsingClass(
	iHTTPPort, // ���� hhtp-�������
	iF1ServerPort // ���� ������� f1
)
{
	this.pm_iHTTPPort = TreatAsNum(iHTTPPort, 0);
	this.pm_iF1ServerPort = TreatAsNum(iF1ServerPort, 0);
	if ((this.pm_iHTTPPort == 0) || (this.pm_iF1ServerPort == 0)) {
		throw "iHTTPPort ��� iF1ServerPort ������ ���� ������";
	}
}

// ����� ����������� web-�������� ���������
function IntranetWebServer(
	iHTTPPort, // ���� hhtp-�������
	iF1ServerPort // ���� ������� f1
)
{
	// �������� ������������ �����������
	_PortUsingClass.apply(this, [iHTTPPort, iF1ServerPort]);
	ManageableProduct.apply(this, ["intranet_web_server", "Web-������ ������-��������"]);


	// ��� ������� web-�������
	this.pm_sWebServiceName = "Garant Intranet Web " + this.pm_iF1ServerPort +  ":" + this.pm_iHTTPPort;
	if (GetWMIObjectForService(this.pm_sWebServiceName) == null) {
		throw "������ " + this.pm_sWebServiceName + " �� ������";
	}

	// ���������� WMI-������ Win32_Service ��� ������� web-�������
	this.pm_GetWMIObjectForWebService = function()
	{
		return GetWMIObjectForService(this.pm_sWebServiceName);
	}

	// ------ ���������� ����������� ������� ---------

	// ����� ������� ������� �� web-������ ���������. ���������� true ��� false
	this.IsRunning = function()
	{
		return this.pm_GetWMIObjectForWebService().State == "Running";
	}

	// ����� ������������� web-������ ���������. ���� �� ��������� ������ ������� �� ������� �� ���������� true, ����� - false.
	this.pm_Stop = function(
		iTimeout, // � ������� ����� ������� (� �������������) ����� ����� ���������� ��������� ���������
		isKill // ������� �������� ���� �� �� ����������� � ������� ��������� ������� (��-���������: true)
	)
	{
		var oService = this.pm_GetWMIObjectForWebService();
		// ���������� PID
		var iPID = oService.ProcessId;
		// �������� ��������� ���������� ������
		if ( StopService(oService, iTimeout) ) {
			// �������
			Logger().Info("������� ���������� ������ \"" + oService.Name + "\"");
		} else {
			// ������ �� ����������� �� �������� �����
			Logger().Error("�� ������� ���������� ������ \"" + oService.Name + "\". ������ ��������� � ��������� " + GetRefreshedWMIObject(oService).State + ". ���������� ��� �����");

			// ���������� ����� ������ �������� �������
			var oProc = GetWMIObjectForProcess("", iPID);
			if (oProc != null) {
				if (TerminateWMIProcessTree(oProc, iTimeout)) {
					Logger().Info("������� ����� ������ ��������� ��� ������� \"" + oService.Name + "\"");
				} else {
					Logger().Error("�� ������� ����� ������ ��������� ��� ������� \"" + oService.Name + "\"");
				}
			} else {
				Logger().Warning("�������, �� ������� ������� �� ������. ����� ����� �������� ��������, ��� ����� ���� ����.");
				// ������� �������� ��������
				if (TerminateChildsProcess(iPID, iTimeout)) {
					Logger().Info("������� ����� �������� �������� ��� ������� \"" + oService.Name + "\"");
				} else {
					Logger().Error("�� ������� ����� �������� �������� ��� ������� \"" + oService.Name + "\"");
				}
			}
		}
	}

	// ����� ��������� web-������ ���������. � ������ ��������� ������� ������� true, ����� false
	this.pm_Start = function()
	{
		var oService = this.pm_GetWMIObjectForWebService();
		// ��������� ������ ������� ��������
		StartService(oService, 30000);
	}
}

// ����� ����������� ����������
function Intranet(
	iHTTPPort, // ���� hhtp-�������
	iF1ServerPort, // ���� ������� f1
	bIs64BitServer // 64-�������� f1
)
{
	// �������� ������������ �����������
	_PortUsingClass.apply(this, [iHTTPPort, iF1ServerPort]);
	ManageableProduct.apply(this, ["intranet", "������-��������"]);


	// ��� ������� ������� f1
	this.pm_sDataServiceName = "Garant Intranet Data " + this.pm_iF1ServerPort +  ":" + this.pm_iHTTPPort;
	if (GetWMIObjectForService(this.pm_sDataServiceName) == null) {
		throw "������ " + this.pm_sDataServiceName + " �� ������";
	}
	// ������� � ������� ��� ������� f1
	this.pm_sF1ServerRegSubPath = this.pm_sDataServiceName;

	// ������ ��� ���������� �������� F1. Public.
	this.oF1Server = new F1Server(this.pm_sF1ServerRegSubPath, this.pm_sDataServiceName);
	this.oF1Server.isForceStartAsService = true;

	// ������ ��� ���������� web-��������
	this.pm_oWebServer = new IntranetWebServer(this.pm_iHTTPPort, this.pm_iF1ServerPort, bIs64BitServer);

	// ------ ���������� �������������� ������� -------

	this.parent_PermitStartOrStopOnlyForMe = this.PermitStartOrStopOnlyForMe;
	//
	this.PermitStartOrStopOnlyForMe = function()
	{
		if (this.parent_PermitStartOrStopOnlyForMe()) {
			if (this.oF1Server.PermitStartOrStopOnlyForMe()) {
				if (this.pm_oWebServer.PermitStartOrStopOnlyForMe())
					return true;
				this.oF1Server.PermitStartOrStopForAll();
			}
			this.parent_PermitStartOrStopForAll()
		}
		return false;
	}

	this.parent_PermitStartOrStopForAll = this.PermitStartOrStopForAll;
	//
	this.PermitStartOrStopForAll = function()
	{
		this.pm_oWebServer.PermitStartOrStopForAll();
		this.oF1Server.PermitStartOrStopForAll();
		this.parent_PermitStartOrStopForAll();
	}


	this.parent_BeginStartOrStop = this.BeginStartOrStop;
	//
	this.BeginStartOrStop = function()
	{
		if (this.parent_BeginStartOrStop()) {
			if (this.oF1Server.BeginStartOrStop()) {
				if (this.pm_oWebServer.BeginStartOrStop())
					return true;
				this.oF1Server.FinishStartOrStop();
			}
			this.parent_FinishStartOrStop()
		}
		return false;
	}

	this.parent_FinishStartOrStop = this.FinishStartOrStop;
	//
	this.FinishStartOrStop = function()
	{
		this.pm_oWebServer.FinishStartOrStop();
		this.oF1Server.FinishStartOrStop();
		this.parent_FinishStartOrStop();
	}

	this.parent_IsStartingOrStopping = this.IsStartingOrStopping;
	//
	this.IsStartingOrStopping = function()
	{
		return this.parent_IsStartingOrStopping() || this.oF1Server.IsStartingOrStopping() || this.pm_oWebServer.IsStartingOrStopping();
	}

	// ------ ���������� ����������� ������� ---------

	//
	this.IsRunning = function()
	{
		return this.oF1Server.IsRunning() && this.pm_oWebServer.IsRunning();
	}

	//
	this.pm_Stop = function(
		iTimeout,
		isKill
	)
	{
		// ������� ������������� web-������, ����� ������ f1
		return this.pm_oWebServer.Stop(iTimeout, isKill) && this.oF1Server.Stop(iTimeout, isKill);
	}

	//
	this.pm_Start = function()
	{
		// ������� ��������� ������ f1, ����� web-������,
		return this.oF1Server.Start() && this.pm_oWebServer.Start();
	}
}

// �����, �������������� ������� ���������� � ������� �� ������ ���-�����
function INIControlledObjectCreator()
{
	// �������������� ������
	this.oManageableProduct = null; // �������������� �����
	// ������ ��� �������� �� �������� F1
	this.oF1Server = null; // �������������� �����
	//

	try {
		if (IS_MUST_CONTROL_INTRANET)
		{ // ���������� �������� � ����������
			// ��������� ��� ����� ������
			if ((INTRANET_WEB_SERVER_PORT == -1) || (INTRANET_DATA_SERVER_PORT == -1)) {
				var sErr = "������ ���� ������ ���� web-������� � ������� ������!";
				Logger().Error(sErr);
				throw sErr;
			}

			// ������� ������ ��� ���������� ����������
			this.oManageableProduct = new Intranet(INTRANET_WEB_SERVER_PORT, INTRANET_DATA_SERVER_PORT, IS_64_BIT_SERVER);

			// �������������� ������ F1Server
			this.oF1Server = this.oManageableProduct.oF1Server;
		}
		else
		{ // ���������� �������� � �������� F1
			// ����� ��� ������
			this.oManageableProduct = new F1Server("", "", IS_64_BIT_SERVER);
			this.oF1Server = this.oManageableProduct;
		}
	} catch (oEx) {
		Logger().Exception(oEx);
		Logger().Error("������ ��� �������� Intranet");
		throw oEx;
	}


	if ((this.oManageableProduct == null) || (this.oF1Server == null) )
		throw "������� �� ����������������!";
}

// ��������� ���������� ��������� ������. ES - Error Status
var
	ES_OK = 0; // ��� ������
	ES_CRITICAL_ERROR = 1; // ������� ����������� ������
	ES_SERVER_HANGUP = 2; // ������ �����
	ES_ERROR = 4; // ������� ������� ������
	ES_F1BU_DB_SWITCH_HANGUP = 5; // ������������ ��� � ������� F1BU �� ����������� �� ���������� �����

// ���������, ���������� �������, ��������� � ����������� ���, ������������ �� ���� �������. US - Update Status
var
	US_NO_INFO = 0; // ������ ������ ������� ��� ����������
	US_UPDATE_STARTED = 1; // �������� ����������
	US_BASE_UPDATED = 2; // ���� ���������� (�� ��� �� �������� ��� ������ �� ��� ������������ � ������������)
	US_NEW_DB_OPENED = 4; // ������ ������ ����� ���� � ���������� ������� �� ���
	US_UPDATE_FINISHED = 8; // ������� ���������� ��������, ������� ��� � � ����� �����������, ������� ��� ���
	US_OPEN_NEW_D�_FAILED = 16; // ������� �� ������� ������� ����� ����
	US_OPEN_OLD_DB_FAILED = 32; // ������� �� ������� ������� ������ ����

// ����� ����������� �������� �� ����� ������� � ������������ ��� � ������ ���������, ������� � ���� ����������� ������ � ������� �� �������� e-mail ��������� � ������������� �������
function Watcher()
{
	// ���� � ������� ����� ������� �� ������� ���, �� ������� ��� ������ �����. ���� -1 �� �������� �� ��� �� �����������
	this.pm_ciHangupTimeout = SERVER_HANGUP_TIMEOUT;
	// � ������� ����� ������� ����� ����� ���������� ��������� ������� ��� ������������
	this.pm_ciServerStopTimeout = SERVER_STOP_TIMEOUT;
	// ���� ����� ����� �������� � ���� From ��� ������� �������� ���������
	this.pm_csFromEMail = FROM_EMAIL;
	// �� ���� ����� ����� ��������� ��������� � ����������� �������. ���� ����� �� ������ �� ����������
	this.pm_csToEmailServerRestart = TO_EMAIL_SERVER_RESTART;
	// �� ���� ����� ����� ���������� ��������� � ��� ��� � ���� ������� ������� ������. ���� ����� �� ������ �� ����������.
	this.pm_csToEmailErrors = TO_EMAIL_ERRORS;
	// ����� �� ������������� ������ �������������. ���� ��� - �� ������ email � ����� ������
	this.pm_bIsCanRestartServer = IS_CAN_RESTART_SERVER;
	//
	this.pm_bIsKillF1UtilitiesOnServerRestart = IS_KILL_F1_UTILITIES_ON_SERVER_RESTART;
	
	// �� ���� ����� ����� �������� ���� vmmap
	this.pm_csToEmailVMMap = TO_EMAIL_VMMAP;

	// ������������ ����� (��), ������� ����� ������� ���� �������� (������������, ����� ���� ����� ��� ����� ����� ������ ����� �� ��������� �����)
	this.pm_ciMinTimeForOneCheck = 10000; // 10 ������
	// ���� ������ ���-����� ��������� ���� ������, �� �� ����� ��� ���������
	this.pm_ciMaxInitialLogSize = -1;  // ��� �����������
	// ����� �� ������������ ���-���� ��� ��������
	this.pm_bIsUseLogFile = IS_USE_LOG_FILE;
	
	// ����� � ������� �������� ������ ������������� ����, ���� ��� ������������� � ������� F1BU
	this.pm_ciF1BUDBSwitchTimeout = F1BU_DB_SWITCH_TIMEOUT;
	// ������� ���� ��� ������������ ��� ������������ � ������� F1BU
	this.pm_bIsDBSwitchingWithF1BU = false;
	// ���� �������� ������� F1BU ����� �� ��� ��������� �������� ������������ ��� (���� �������� ������, �� �� ���������, ����� �� ����������� �� �������� ��������)
	this.pm_ciF1BULimitationPeriod = 10*60*1000; // 10 �����
	// ������� ���� ��� ��������� F1BU ��� ������������ ��� ��� ����������
	this.pm_bIsF1BUDBSwitchHangupDetected = false;
	

	// ������� ��� �������������� ����������� �������
	this.pm_oUseGuard = new UseCounter("f1server.watcher.run");
	// ������� ��� ������������ ������������� ������
	this.pm_oNeedExitEvent = new Event("f1server.watcher.need_exit", false);
	// ������ Fso::File ��� ���� �������
	this.pm_oLogFile = null;
	// o����� FSO::TextStream ��� ���� �������
	this.pm_oLogFileTS = null;
	// ��������� ����������� �� ���� ������� ������
	this.pm_sLastLine = "";
	// �����, ����� ���� ��������� ��������� ������ �� ���� �������
	this.pm_tLastLineTimestamp = 0;
	
	this.pm_csAssertDetectorCmdFile = GetPathTo(PT_SCRIPT_FOLDER) + "\\ad_cmd";
	//
	this.pm_csAssertDetectorResFile = GetPathTo(PT_SCRIPT_FOLDER) + "\\ad_res";
	//
	this.pm_iProcessIDForAssertDetector = 0;
	// ������ � �������� ���� ��������
	this.pm_arrAssertHandles = new Array();
	// ��������� �� ������� ��������
	this.pm_bIsDetectAsserts = IS_DETECT_ASSERTS;
	// ��������� �� ������� ������������
	this.pm_bIsWatchForDebuggerBreakpoints = IS_WATCH_FOR_DEBUGGER_BREAKPOINTS;
	//
	this.pm_csBreakpointFilePath = GetPathTo(PT_DEBUGGER_BREAKPOINT_FILE);

	// ����, ���������� ���������� �� �� �������� ��������� ������� � ������� �������� �� �����. �����, ����� ������� �� ������ � �������� "������ �����! ������ �����!", ����� �� ����� � ����������� ��� ���������
	this.pm_bIsLLHangupDetected = false;
	// ����, ����������, ���������� �� �� �������� ��������� ������� � ������� ����������� �������.
	this.pm_bIsSCHangupDetected = false;

	// ����� ���������� ������� ������� �������� �������
	this.pm_tF1SCTimestamp = 0;
	// �������� �������� ������� ����� ������ ��������. �����, ����� �������� �������� ��������� ����������� ��������� ������� �� ����� ���������� �������
	this.pm_tF1SCCheckDelay = 5*60*1000;
	// ����� ��� ����� ����� ����������� ���������� �������
	this.pm_tF1SCStartInterval = F1SERVER_CHECKER_START_INTERVAL;
	// ���� � ������� ����� ������� ������� �������� ������� �� ����������, �� ����� ������� ��� ������ �����
	this.pm_tF1SCRunTimeout = F1SERVER_CHECKER_RUN_TIMEOUT;

	// ���� ������ ��������� �� ������� ������� ���� ����� ��������� ��������� �� ����������� ��������
	this.pm_ciWaitTimeIfCanNotCheck = 5000; // 5 ������
	// ������� ������� ���� ������, ����� ���� ��� ��� ������
	this.pm_ciWaitTimeForExit = (this.pm_ciWaitTimeIfCanNotCheck + this.pm_ciMinTimeForOneCheck + this.pm_tF1SCRunTimeout)*2;

	// ������ ����� �� ���� ������� ���������� ��������� ����������� ������ (������ ��� ������� ������ ������ ���� ������������) �� ��������� ������
	this.pm_arrCriticalErrorLines = new Array();
	// ������ ����� � �������� ��������� �� ��������� ������
	this.pm_arrErrorLines = new Array();
	
	// ������ ��������� ����������� �� ���� �����
	this.pm_arrLastLines = new Array();
	// ������������ ���������� ���������� ��������� ����� �� ����
	this.pm_cMaxLastLines = 200;

	// ���������� ��������� ��� �����������, �������� �� ������ �� ���� ������� ����������� �������. ���� null �� �������� �� �����������
	this.pm_oRExpCriticalError = new RegExp(
		"-LM_ERROR:.*The End of Memory",
		"i");	
	// ���������� ��������� ��� �����������, �������� �� ������ ���� �� ������� �������. ���� null �� �������� �� �����������
	this.pm_oRExpError = new RegExp(
		"UNKNOWN_EX:|LM_ERROR|LM_ALERT|STD_EX|Base pool:|CORBA_EX:",
		"i");
	// ���������� ��������� ��� �����������, �������� �� ������ ���� �� ������� �� �������. ���� null �� �������� �� �����������
	this.pm_oRExpNotError = new RegExp(
		"BaseUpdate:update is not performed" +
		"|CanNotFindData:1\\.0:\\s*in UserManager" +
		"|CanNotFindData:1\\.0:\\s*Search(?:Mng|Manager)_i:*search" +
		"|CanNotFindData:1\\.0:\\s*InternalObj_i::get_blob" + 
		"|already locked \\(errno == EACCES\\)" +
		"|IDL:garant\\.ru\\/GslUserManager\\/NoMoreConnections:1\\.0" +
		"|SavedQuery_i::create_attribute: can't create correct query" +
		"|LifeCycleManager_i::release_object: Warning! CORBA exception handled" + 
		"|ServerInInterceptor::receive_request_service_contexts",
		"i");

	// ������ ������, � ������� ��������� ��������
	this.pm_iErrorStatus = ES_OK;
	// ������ ���������� ���, �� ������ ��������� ��������
	this.pm_iUpdateStatus = US_NO_INFO;

	// ���������� ��������� ��� ����������� �������� ������ ����������
	this.pm_oRExpUpdateStarted = new RegExp("-LM_GARANT: UPDATE_START", "i");
	// ���������� ��������� ��� ����������� ������� ��������� ���������� ���� (�� �� �������� ����������!)
	this.pm_oRExpBaseUpdated = new RegExp("-LM_INFO: BaseUpdate: data.org update complete", "i");
	// ���������� ��������� ��� ����������� ������� �������� ����� ����
	this.pm_oRExpOpenNewDBFailed = new RegExp("-LM_INFO: BaseUpdate: open new datastore failed", "i");
	// ���������� ��������� ��� ����������� ������� �������� ������ ����
	this.pm_oRExpOpenOldDBFailed = new RegExp("-LM_INFO: BaseUpdate: open old datastore failed", "i");	
	// ���������� ��������� ��� ����������� ������� ������������ ������� �� ����� ����
	this.pm_oRExpNewDBOpened = new RegExp("-LM_INFO: BaseUpdate_i::swap_dirs: update .ini file complete", "i");
	// ���������� ��������� ��� ����������� ������� ��������� ���������� (������� � ����� �����������)
	this.pm_oRExpUpdateFinished = new RegExp(
		"-LM_ERROR: BaseUpdate_i::update_complete: update failed" +
		"|-LM_GARANT:\\s*(?:UPDATE_FINISH|UPDATE_FAILED|UPDATE_CANCEL)",
		"i");
	
	//
	this.pm_bIsOpenNewDBFailed = false;
				
	// ����� �� ������������� �������
	this.pm_bIsRestartProduct = false;
	// ������� ����������� ��������
	this.pm_sRestartCause = "";
	// ������������ �� ����������� ������ (�� ������ ���������� ����)
	this.pm_bIsIgnoreCriticalErrorsWhileDBUpdate = false;
		
	// ������� ����, ��� ������/������� ������� �������� ������ �������� "������"
	this.pm_bIsSoSPermittedOnlyForMe = false;
	// ����� �� ����� ��� ����������� ������� ����������� ����
	this.pm_bIsNeedManualDBSwitching = false;
	// ������� �� �� ���������� ��� ������ � ���� �������
	this.pm_bIsWatchForDBUpdateInLog = true;

	// ��������, ����� ������� ������� � ��� keepalive
	this.pm_tKeepAliveInterval = 30*60*1000;
	// ����� ���������� keepalive
	this.pm_tKeepAliveLastTimestamp = 0;

	//
	var pm_INICOC = new INIControlledObjectCreator();
	// ��������� ������� ���� F1Server ��� ���������� ��������
	this.pm_oF1Server = pm_INICOC.oF1Server;
	// ��������� ��������������� �������
	this.pm_oManageableProduct = pm_INICOC.oManageableProduct;

	// ������ �� ���-����
	this.pm_bIsLogOpened = false;
	// ������ ���-�����. ����� ��� ����������� ������������ ���� ��� �� ������
	this.pm_iCurrLogSize;
	
	//
	this.pm_StoreLogLineForSendingWithVMMapLog = function(
		sLogLine
	)
	{
		if (this.pm_csToEmailVMMap != "")
		{
			this.pm_arrLastLines.push(sLogLine);
			if (this.pm_arrLastLines.length > this.pm_cMaxLastLines)
			{
				this.pm_arrLastLines.shift();
			}
		}		
	}
	
	//
	this.pm_WriteLogLineForSendingWithVMMapLogToFile = function()
	{
		var sRes = "";
		//
		try {
			var sLinesFilePath = GetTempDirForSyncOps() + "\\�������� ���� ����� �������.txt";
			if (FSO().FileExists(sLinesFilePath)) {
				FSO().DeleteFile(sLinesFilePath);
			}
			var sLinesFile = FSO().OpenTextFile(sLinesFilePath, FOR_WRITING, true);
			for (idx in this.pm_arrLastLines) {
				sLinesFile.WriteLine(this.pm_arrLastLines[idx]);
			}
			sLinesFile.Close();
			this.pm_arrLastLines = new Array();			
			//	
			sRes = sLinesFilePath;
		} catch (oEx) {
			Logger().Error("������ ��� ���������� pm_WriteLogLineForSendingWithVMMapLogToFile");
			Logger().Exception(oEx);
		}
		//
		return sRes;
	}
	
	//
	this.pm_DoVMMapLog = function()
	{	
		if (this.pm_csToEmailVMMap != "")
		try {
			// ������� vmmmap ���
			var sVMMapLogFileName = GetTempDirForSyncOps() + "\\vmmap_log_" + CurrTimeStamp().toString() + ".mmp";
			var sVMMapParams = "-accepteula -p " + this.pm_oF1Server.GetProcessID() + " \"" + sVMMapLogFileName + "\"";			
			Logger().Info("��������� VMMap �� ���� \"" + GetPathTo(PT_VMMAP) + "\" c ����������� " + sVMMapParams);
			var oWshScriptExec = ExecEx(GetPathTo(PT_VMMAP), sVMMapParams);			
			// ���� ���� ����������
			var iDeadLine = CurrTimeStamp() + 30000;
			while (iDeadLine > CurrTimeStamp())
				if (oWshScriptExec.Status == WSH_FINISHED)
					break;
				else
					WScript.Sleep(500);
			// ������� �����, �������, ���� �����
			if (oWshScriptExec.Status != WSH_FINISHED) {				
				oWshScriptExec.Terminate(); 
				Logger().Error("VMMap �� ��������� �� ���������� �����!");
				return;
			}
			
			// ���� ���� ����, �� ����������
			if (FSO().FileExists(sVMMapLogFileName)) 
			{		
				Logger().Info("������ ��� VMMap �� ���� \"" + sVMMapLogFileName + "\"");
			
				// �������� � ���� ��������� ������ �� ����
				var sLinesFilePath = this.pm_WriteLogLineForSendingWithVMMapLogToFile();
				
				SendMail(
					this.pm_csFromEMail, this.pm_csToEmailVMMap, "��� VMMap � ������ " + CompName(),
					this.pm_GenerateHTMLDocWithErrors(), [sVMMapLogFileName, sLinesFilePath]
				);
				//FSO().DeleteFile(sVMMapLogFileName);				
			} else {
				Logger().Error("���� ���� VMMap �� ���� \"" + sVMMapLogFileName + "\"");
			}
									
			
		} catch (oEx) {
			Logger().Error("������ ��� ���������� pm_DoVMMapLog");
			Logger().Exception(oEx);
		}
	}

	// ����� ��������� ��� ������� � ��������������� �� ��������� ������. ���� ������� ������� true, ����� false.
	this.pm_OpenLogFile = function(
		isWaitForLogFile // ����� �� �������� ���-����� � ������ ���� �� ���������� ����������� (��-��������� false)
	)
	{
		if (this.pm_bIsUseLogFile)
		{
			isWaitForLogFile = TreatAsBool(isWaitForLogFile, false);
			//
			if (!this.pm_bIsLogOpened)
			{
				var sLogFilePath = this.pm_oF1Server.GetPathToLog();
				// ��������� ������������� ����� �  ���� ��� �������� ���� �������
				while (!FSO().FileExists(sLogFilePath))
				{
					if (!isWaitForLogFile) {
						// ����� ��� � ����� ��� ������ - �������
						Logger().Warning("���-���� �� ������ �� ���� " + sLogFilePath);
						this.pm_bIsLogOpened = false;
						return this.pm_bIsLogOpened;
					}
					WScript.Sleep(1000);
				}

				// ��������� ����
				this.pm_oLogFile = this.pm_oF1Server.GetLogFileObject();
				if (this.pm_oLogFile != null) {
					try	 {
						Logger().Info("��������� ���-����");
						this.pm_oLogFileTS = QCComponentsFactory().MakeQCTextStream(this.pm_oLogFile.Path, FOR_READING, false);
					} catch (oEx) {
						Logger().Error("������ ��� �������� ���-�����");
						Logger().Exception(oEx);
						throw oEx;
					}
					Logger().Info("������� ������� ���-����");
					// ��������������� � ����� �����
					this.pm_oLogFileTS.Skip(this.pm_oLogFile.Size);
					//
					this.pm_tLastLineTimestamp = CurrTimeStamp();
					this.pm_iCurrLogSize = this.pm_oLogFile.Size;
					this.pm_bIsLogOpened = true;
				} else {
					Logger().Error("���-���� ����� �� ����������, �� ������-�� �� ������!");
				}
			}
		}
		return this.pm_bIsLogOpened;
	}

	// ����� ���������, ������ �� ���� ���������� ���-���� (��������, ���� ��� ������ ��������� ����� ������ ����). ���������� ������ ������ ��� �������� ����.
	this.pm_IsMustReOpenLogFile = function()
	{
		if (this.pm_bIsUseLogFile) {
			var iOldLogSize = this.pm_iCurrLogSize;
			this.pm_iCurrLogSize = this.pm_oLogFile.Size;
			// ���� ������ ����� ���������� ������������ ���������� ��������, �� ������� ��� ��� ���� �����������
			return (this.pm_iCurrLogSize < iOldLogSize);
		} else {
			return false;
		}
	}

	// ����� ��������� ���-����
	this.pm_CloseLogFile = function()
	{
		if (this.pm_bIsUseLogFile && this.pm_bIsLogOpened) {
			this.pm_oLogFile = null;
			this.pm_oLogFileTS.Close();
			this.pm_oLogFileTS = null;
			this.pm_bIsLogOpened = false;
			Logger().Info("������� ���-����");
		}
	}

	// ����� ��������� ����� �� ���������� ��������. �� - true, ����� - false.
	// ����������� ������� �� ������, �� ��������������� �� ��, ������������� �� ��� �������� ������������
	this.pm_IsCanDoNextCheck = function()
	{
		var bResult = false;
		// � ������ ���������, ������� �� �������. ���� ���, �� � ��������� ������.
		bResult = this.pm_oManageableProduct.IsRunning();
		// ���� ������� ��������������� ��� ����������� ���� ������ ���������
		bResult = bResult && ( !this.pm_oManageableProduct.IsStartingOrStopping() );

		// ���� ��� ��� �� ������ � ��� ����� ������������
		if ( bResult && this.pm_bIsUseLogFile  && !this.pm_bIsLogOpened )
		{
			// ��������� ��� ��� �������� � ��� ������ �� ������ ��� �����
			var oLogFile = this.pm_oF1Server.GetLogFileObject();
			bResult = bResult && (oLogFile != null); // && ((this.pm_ciMaxInitialLogSize == -1) || (oLogFile.Size <= this.pm_ciMaxInitialLogSize)) );
		}
		return bResult;
	}

	// ����� ��������� �������� �� ������� ������ c ������� ������� F1ServerChecker
	this.pm_DoNextCheckWithF1SC = function()
	{
		// ���������, ����� �� ������������ �� ������
		if ( 	(this.pm_tF1SCStartInterval != -1) // ���� ����� ���������
			&&	(this.pm_tF1SCTimestamp + this.pm_tF1SCStartInterval < CurrTimeStamp()) ) // � ���� ������� ����� ���������� �������
		{ // ����� ���������
			var sPathToF1ServerChecker = GetPathTo(PT_F1SERVER_CHECKER);
			if ( !FSO().FileExists(sPathToF1ServerChecker) )
			{
				Logger().Warning("F1ServerChecker �� ������ �� ���� " + sPathToF1ServerChecker);
				return;
			}
			//
			var oF1ServerChecker = new F1ServerChecker(
				sPathToF1ServerChecker,
				INIFile().GetPathToINI(),
				this.pm_oF1Server.GetPathToINIFile()
			);
			// ���������
			Logger().Info("��������� ������� �������� �������");
			var bCheckResult = oF1ServerChecker.RunChecker(this.pm_tF1SCRunTimeout);
			var iExitCode = oF1ServerChecker.GetExitCode();
			Logger().Info("��������� ��������: " + bCheckResult + ". ��� ������: " + iExitCode);
			this.pm_tF1SCTimestamp = CurrTimeStamp();
			//
			if ( !bCheckResult ) {  // ������� �� ���������� �� ���������� ����� - ������� ��� ������ �����
				// ���������� ���� ��������� ������ � ��� ������ ���� ��� �� ����� ������������ ���������
				if ( (!this.pm_bIsLLHangupDetected) && (!this.pm_bIsSCHangupDetected) ) {
					this.pm_iErrorStatus |= ES_SERVER_HANGUP;
					this.pm_bIsSCHangupDetected = true;
				}
			} else { // ��� ��
				this.pm_bIsSCHangupDetected = false; // ������� ���� ���������
			}
			// � ���� ����������, ��� ��� ������ �� ������, �������� ��� ������ ������������ �����/������ � �.�. � �.�.
		}
	}

	// ����� ���������, �������� �� ������� ������ ���� ������� � ���������� ������
	this.pm_CheckLastLogLineForError = function()
	{
		// ��������� �������� �� ��� ������ ����������� �������
		if ( (this.pm_oRExpCriticalError != null) && (this.pm_oRExpCriticalError.test(this.pm_sLastLine)) )
		{
			this.pm_arrCriticalErrorLines.push(this.pm_sLastLine);
			this.pm_iErrorStatus |= ES_CRITICAL_ERROR;
			@if(@DEBUG)
				DebugInfo(this.pm_sLastLine + " ���������������� ��� ES_CRITICAL_ERROR");
			@end
		}

		// ��������� �������� �� ������ ������� �������
		if(    ((this.pm_oRExpError != null) && (this.pm_oRExpError.test(this.pm_sLastLine)))
			&& ( ((this.pm_oRExpNotError != null) && (!this.pm_oRExpNotError.test(this.pm_sLastLine))) || (this.pm_oRExpNotError == null) )
		  )
		{
			this.pm_arrErrorLines.push(this.pm_sLastLine);
			this.pm_iErrorStatus |= ES_ERROR;
			@if(@DEBUG)
				DebugInfo(this.pm_sLastLine + " ���������������� ��� ES_ERROR");
			@end
		}
	}

	// ��������� ������ ���� �� ������� ����� �� ��� ������ ��� ���������� �� ���������� ���
	this.pm_CheckLastLogLineForUpdate = function()
	{
		if (this.pm_oRExpUpdateStarted.test(this.pm_sLastLine)) {
			this.pm_iUpdateStatus |= US_UPDATE_STARTED;
			@if(@DEBUG)
				DebugInfo(this.pm_sLastLine + " ���������������� ��� US_UPDATE_STARTED");
			@end
		}
		//
		if (this.pm_oRExpBaseUpdated.test(this.pm_sLastLine)) {
			this.pm_iUpdateStatus |= US_BASE_UPDATED;
			@if(@DEBUG)
				DebugInfo(this.pm_sLastLine + " ���������������� ��� US_BASE_UPDATED");
			@end
		}
		//		
		if (this.pm_oRExpOpenNewDBFailed.test(this.pm_sLastLine)) {
			this.pm_iUpdateStatus |= US_OPEN_NEW_D�_FAILED;
			@if(@DEBUG)
				DebugInfo(this.pm_sLastLine + " ���������������� ��� US_OPEN_NEW_D�_FAILED");
			@end
		}
		//		
		if (this.pm_oRExpOpenOldDBFailed.test(this.pm_sLastLine)) {
			this.pm_iUpdateStatus |= US_OPEN_OLD_DB_FAILED;
			@if(@DEBUG)
				DebugInfo(this.pm_sLastLine + " ���������������� ��� US_OPEN_OLD_DB_FAILED");
			@end
		}		
		//
		if (this.pm_oRExpNewDBOpened.test(this.pm_sLastLine)) {
			this.pm_iUpdateStatus |= US_NEW_DB_OPENED;
			@if(@DEBUG)
				DebugInfo(this.pm_sLastLine + " ���������������� ��� US_NEW_DB_OPENED");
			@end
		}
		//
		if (this.pm_oRExpUpdateFinished.test(this.pm_sLastLine)) {
			this.pm_iUpdateStatus |= US_UPDATE_FINISHED;
			@if(@DEBUG)
				DebugInfo(this.pm_sLastLine + " ���������������� ��� US_UPDATE_FINISHED");
			@end
		}
	}


	// ����� ��������� �������� �� ������� ������ � ���� � ������ ���������. ������� �� ������� ��������  this.pm_ciMinTimeForOneCheck ��
	this.pm_DoNextCheckWithLog = function()
	{
		try {
			this.pm_arrCriticalErrorLines = new Array();
			this.pm_arrErrorLines = new Array();

			// ==== � ������ ��������� �������� �� ������� ������ ====
			var iDeadLine = CurrTimeStamp() + this.pm_ciMinTimeForOneCheck;
			var iBufSize = 128*1024;
			// �������� �� ������ ��������� �������
			while (CurrTimeStamp() < iDeadLine)
				if (!this.pm_oLogFileTS.AtEndOfStream)
				{
					// ������ �� ����� �� ��������� � �������, �.�. � ������ QCTextStream ���� ��� ������� ������ ����������� ������
					var sBuf = this.pm_oLogFileTS.Read(iBufSize) + this.pm_oLogFileTS.ReadLine();
					var arrLines = sBuf.split(END_OF_LINE);
					for (iLineIdx in arrLines)
					{
						var sLine = arrLines[iLineIdx];
						if (sLine.length > 0)
						{
							// �������� ��������� ������ �� ����
							this.pm_bIsLLHangupDetected = false; // ���� ���-�� �����������, ������ ���� �� ����� ��������� ��������� �������
							this.pm_sLastLine = sLine;
							this.pm_tLastLineTimestamp = CurrTimeStamp();
							
							this.pm_StoreLogLineForSendingWithVMMapLog(this.pm_sLastLine);

							// ��������� ��� �� ������
							this.pm_CheckLastLogLineForError();
							// ��������� ��� �� ������� �������� � ����������� ���
							if (this.pm_bIsWatchForDBUpdateInLog) {
								this.pm_CheckLastLogLineForUpdate();
							}
						}
					}
				} else {
					WScript.Sleep(this.pm_ciMinTimeForOneCheck / 10);
				}

			// ===== ������ ���������, � �� ����� �� ������ =====
			// ��������� �� ���������� ����
			if (this.pm_ciHangupTimeout != -1) {
				// ���������, ������ �� � ������� ������ ��������� ������ �������� ����� (�.�. ��� �� �������� ��� ��� �����)
				if ( (!this.pm_bIsSCHangupDetected) && (!this.pm_bIsLLHangupDetected) && ((CurrTimeStamp() - this.pm_tLastLineTimestamp) > this.pm_ciHangupTimeout)) {
					this.pm_iErrorStatus |= ES_SERVER_HANGUP;
					this.pm_bIsLLHangupDetected = true;
				}
			}
			
			// ���������, �� ������� �� ������������ ��� � ������� F1BU
			if (this.pm_ciF1BUDBSwitchTimeout != -1) {
				// ������� ��� �������, ���� ������� ������������ ��� �� �������, � F1BU �������� ������ ��������� �������
				if ((!this.pm_bIsF1BUDBSwitchHangupDetected) && this.pm_bIsDBSwitchingWithF1BU && (this.pm_GetF1BURunningTime() > this.pm_ciF1BUDBSwitchTimeout)) {
					this.pm_iErrorStatus |= ES_F1BU_DB_SWITCH_HANGUP;
					this.pm_bIsF1BUDBSwitchHangupDetected = true;
					@if(@DEBUG)
						DebugInfo("������� ��� ���������� ��������� ��� ������������ ��� � ������� F1BU");	
					@end
				}
			}						
		} catch(oEx) {
			Logger().Error("������ ��� ���������� ������ pm_DoNextCheckWithLog");
			Logger().Exception(oEx);
			throw oEx;
		}	
	}

	// ����� ���������� HTML �������� � ������� �� �������. ���� ������ ���, �� ���������� ������ ������.
	this.pm_GenerateHTMLDocWithErrors = function()
	{
		// ������� ������������ HTML-������� �� ������� ����� � ��������
		function _GenerateTableWithErrors(
			sTableTitle, // �������� �������
			oArrayWithErrors // ������ ����� � ��������
		)
		{
			var oResult = new Object();
			var sTableClass = Math.round( Math.random()*1000000000 ).toString();
			// ���������� �������
			var sTable =
				"<table border=1 align=center class=\"" + sTableClass + "\">" +
				"<caption>" + sTableTitle + "</caption>" + END_OF_LINE;
			var sRowClass = "";
			for (var i = 0; i < oArrayWithErrors.length; i++)
			{
				var sErrorLine = oArrayWithErrors[i];
				if (sErrorLine.indexOf("LM_ALERT") != -1)
					sRowClass = "lm_alert";
				else if (sErrorLine.indexOf("STD_EX") != -1)
					sRowClass = "std_ex";
				else if (sErrorLine.indexOf("Base pool") != -1)
					sRowClass = "base_pool";
				else
					sRowClass = "";
				sTable += "<tr class=\"" + sRowClass + "\"><td><tt>" + sErrorLine + "</tt></td></tr>" + END_OF_LINE;
			}
			sTable += "</table>";
			oResult.sTableBody = sTable;
			//
			oResult.sTableStyles =
				"table." + sTableClass + " caption {font-size: large}" + END_OF_LINE +
				"table." + sTableClass + " tr.lm_alert {background:red}" + END_OF_LINE +
				"table." + sTableClass + " tr.std_ex {background:red}" + END_OF_LINE +
				"table." + sTableClass + " tr.base_pool {background:yellow}";
			return oResult;
		}

		// ������������ ������
		var oErrorsTable = null;
		if (this.pm_arrErrorLines.length > 0) {
			var oErrorsTable = _GenerateTableWithErrors("��� ������", this.pm_arrErrorLines);
		}
		// ������������ ����������� ������
		var oCriticalErrorsTable = null;
		if (this.pm_arrCriticalErrorLines.length > 0) {
			var oCriticalErrorsTable = _GenerateTableWithErrors("����������� ������", this.pm_arrCriticalErrorLines);
		}
		// ��������� ��������
		var sResult =	"";
		if ((oErrorsTable != null) || (oCriticalErrorsTable != null))
		{
			var sLogFileBlock = "";
			try {
				sLogFileBlock =
					"<p><big><center>���� � �����: \"" + this.pm_oF1Server.GetLogFileObject().Path + "\"</center></big>";
			} catch(ex) {};
			var sStyles =
				((oCriticalErrorsTable != null) ? oCriticalErrorsTable.sTableStyles : "") + END_OF_LINE +
				((oErrorsTable != null) ? oErrorsTable.sTableStyles : "") + END_OF_LINE;
			var sHTMLBody =
				sLogFileBlock + END_OF_LINE +
				((oCriticalErrorsTable != null) ? "<hr>" + oCriticalErrorsTable.sTableBody : "") + END_OF_LINE +
				((oErrorsTable != null) ? "<hr>" + oErrorsTable.sTableBody : "") + END_OF_LINE;
			sResult= HTMLDoc("������ � ���� �������", sHTMLBody, sStyles);
		}
		return sResult;
	}

	// ����� ���������� ��������� ���������, �.�. ��������� ����� ���������� � ������� �����
	this.pm_ResetHangupState = function()
	{
		// ���������� ������ �������� �������� ����������� �������
		this.pm_tF1SCTimestamp = CurrTimeStamp() + this.pm_tF1SCCheckDelay - this.pm_tF1SCStartInterval;
		// ���������� ����� ����������� ���������
		this.pm_bIsSCHangupDetected = false;
		this.pm_bIsLLHangupDetected	= false;
		this.pm_bIsF1BUDBSwitchHangupDetected = false;
		//
		@if(@DEBUG)
			DebugInfo("�������� �����, ��������� � ����������");
		@end
	}

	// ���������� ����� ��������� �� �������� ���������� � ��������� ������������ ������� ������ ������������
	this.pm_ResetUpdateRelatedFlags = function()
	{
		if (this.pm_bIsSoSPermittedOnlyForMe) {
			this.pm_oManageableProduct.PermitStartOrStopForAll();
			this.pm_bIsSoSPermittedOnlyForMe = false;
		}
		//
		this.pm_bIsNeedManualDBSwitching = false;
		this.pm_bIsOpenNewDBFailed = false;
		this.pm_bIsIgnoreCriticalErrorsWhileDBUpdate = false;
		this.pm_bIsDBSwitchingWithF1BU = false;
		//
		@if(@DEBUG)
			DebugInfo("�������� �����, ��������� � �����������");
		@end
	}

	// ����� �������� ������������ ������ ����������
	// ��������� �� ��� �����, �.�. ����� ���������� ��������:
	//	1) ����������� ����� US_UPDATE_FINISHED | US_BASE_UPDATED 
	//  2) ��� ���� ��������� ����������� ������, ��������� ������������ �������
	// � ���� ������ ����� ��������� � ����������� ����� �������� �� ������������ �������
	this.pm_BeginProcessUpdateStatus = function()
	{
		if (this.pm_iUpdateStatus != US_NO_INFO)
		{
			// ���� ������ ����������
			if ((this.pm_iUpdateStatus & US_UPDATE_STARTED) == US_UPDATE_STARTED) {
				// ��������� ������������ ������� ������ ����, ����� �������������� ��-���������� �� ������ ��� ������� ����������
				this.pm_bIsSoSPermittedOnlyForMe = this.pm_oManageableProduct.PermitStartOrStopOnlyForMe();
				this.pm_bIsIgnoreCriticalErrorsWhileDBUpdate = true;								
				@if(@DEBUG)
					if (this.pm_bIsSoSPermittedOnlyForMe)
						DebugInfo("������� ��������� ������������ ������� ���� ����� ����");
					else
						DebugError("�� ������� ��������� ������������ ������� ���� ����� ����");
				@end				

				// ���������, �� ������ �� ������������ ��� � ������� F1BU
				var iF1BURunningTime = this.pm_GetF1BURunningTime();
				this.pm_bIsDBSwitchingWithF1BU = (iF1BURunningTime > 0) && (iF1BURunningTime < this.pm_ciF1BULimitationPeriod);
				if (this.pm_bIsDBSwitchingWithF1BU)
					Logger().Info("�������, ��� ������������ ��� ������ � ������� F1BU");
				@if(@DEBUG)
					DebugInfo("iF1BURunningTime = " + iF1BURunningTime);
					DebugInfo("this.pm_bIsDBSwitchingWithF1BU = " + this.pm_bIsDBSwitchingWithF1BU);
				@end
			}

			// ���� ���� ����������
			if ((this.pm_iUpdateStatus & US_BASE_UPDATED) == US_BASE_UPDATED)	{
				// ���������� ���� ������������� ������ ������������ ��� ��� ������������
				this.pm_bIsNeedManualDBSwitching = true;
				this.pm_bIsIgnoreCriticalErrorsWhileDBUpdate = false;
				@if(@DEBUG)
					DebugInfo("this.pm_bIsNeedManualDBSwitching = " + this.pm_bIsNeedManualDBSwitching);
					DebugInfo("this.pm_bIsIgnoreCriticalErrorsWhileDBUpdate = " + this.pm_bIsIgnoreCriticalErrorsWhileDBUpdate);
				@end
			}
			
			// ���� �� ������� ������� ����� ����
			if ((this.pm_iUpdateStatus & US_OPEN_NEW_D�_FAILED) == US_OPEN_NEW_D�_FAILED)	{
				// ���������� ���� � ��� ��� ����� ���� �� ���������
				this.pm_bIsDBSwitchingWithF1BU = false;
				this.pm_bIsOpenNewDBFailed = true;
				this.pm_bIsRestartProduct = true;
				this.pm_sRestartCause = "����� ���� �� ���������!";
				@if(@DEBUG)
					DebugInfo("this.pm_bIsOpenNewDBFailed = " + this.pm_bIsOpenNewDBFailed);
					DebugInfo("this.pm_bIsRestartProduct = " + this.pm_bIsRestartProduct);
				@end
			}
			
			// ���� �� ������� ������� ������ ����
			if ((this.pm_iUpdateStatus & US_OPEN_OLD_DB_FAILED) == US_OPEN_OLD_DB_FAILED)	{
				if (this.pm_bIsOpenNewDBFailed)	{
					// ���� � ����� � ������ ���� �� ���������, �� ���� ������������� ������
					this.pm_bIsRestartProduct = true;
					this.pm_sRestartCause = "�� ����� �� ������ ���� �� ���������!";
				} else {
					Logger().Warning("���-�� ������� - ������ ���� �� ���������, � ��� ����� ����� ���������� ���.");
				}
				@if(@DEBUG)
					DebugInfo("������ ������������� ������, �.�. " + this.pm_sRestartCause);
				@end
			}

			// ���� ���� ���������
			if ((this.pm_iUpdateStatus & US_NEW_DB_OPENED) == US_NEW_DB_OPENED) {
				// ���������� ���� ������������� ������ ������������ ���				
				this.pm_bIsNeedManualDBSwitching = false;
				this.pm_bIsOpenNewDBFailed = false;
				this.pm_bIsDBSwitchingWithF1BU = false;
				@if(@DEBUG)
					DebugInfo("this.pm_bIsOpenNewDBFailed = " + this.pm_bIsOpenNewDBFailed);
					DebugInfo("this.pm_bIsNeedManualDBSwitching = " + this.pm_bIsNeedManualDBSwitching);
				@end
			}
		}
	}
	
	// ����� ����������� ������������ ������ ����������
	this.pm_FinishProcessUpdateStatus = function()
	{
		if (this.pm_iUpdateStatus != US_NO_INFO)
		{
			// ���� ���������� �����������
			if ((this.pm_iUpdateStatus & US_UPDATE_FINISHED) == US_UPDATE_FINISHED) {
				// ���������� ��� �����
				this.pm_ResetUpdateRelatedFlags();
			}
		}
	}

	// ����� ������������ ������ ������
	this.pm_ProcessErrorStatus = function()
	{
		if (this.pm_iErrorStatus != ES_OK)
		{ // �� ��� � ������� � ���� ����������
			// === ����� ��������� ������ �� ��������� ����������� ������� ===
			// ���� ���� ������ ������� ��� ����������� - �������� ������
			if ( ((this.pm_iErrorStatus & ES_ERROR) == ES_ERROR) || ((this.pm_iErrorStatus & ES_CRITICAL_ERROR) == ES_CRITICAL_ERROR) )
			{
				Logger().Info("������� ������");
				// �������� ������ � ��������
				var sHTMLDocWithErrors = this.pm_GenerateHTMLDocWithErrors();
				if ((this.pm_csToEmailErrors != "") && (sHTMLDocWithErrors != ""))
				{
					Logger().Info("��������� ������ ����� ������� �� ����� " + this.pm_csToEmailErrors);
					SendMail(this.pm_csFromEMail, this.pm_csToEmailErrors,
						"� ���� " + this.pm_oF1Server.sNameForLog + " �� ������ " + CompName() + " ���������� ������!",
						sHTMLDocWithErrors	);
				}
			}

			// === ����� ��������� ������ ��������� ����������� ������� ===
			if ( (this.pm_iErrorStatus & ES_CRITICAL_ERROR) == ES_CRITICAL_ERROR)
			{			
				this.pm_DoVMMapLog();
				//
				if (!this.pm_bIsIgnoreCriticalErrorsWhileDBUpdate) {
					this.pm_bIsRestartProduct = true;
					this.pm_sRestartCause = "� ���� ������� ���������� ����������� ������!";
				} else {
					Logger().Info("���� ����������� ������, �� �� ��������������� ������ ��� � ������ ������ ����������� ����.");
				}
			}
			if ((this.pm_iErrorStatus & ES_SERVER_HANGUP) == ES_SERVER_HANGUP) {
				this.pm_bIsRestartProduct = true;
				this.pm_sRestartCause = "������, ������, �����!";
			}
			if ((this.pm_iErrorStatus & ES_F1BU_DB_SWITCH_HANGUP) == ES_F1BU_DB_SWITCH_HANGUP) {
				this.pm_bIsRestartProduct = true;
				this.pm_sRestartCause = "������ ��� ������������ ���, ������� � ������� F1BU �� ����������� �� �������� ����� (" + Math.round(this.pm_ciF1BUDBSwitchTimeout/1000).toString() + " ���)!";
				@if(@DEBUG)
					DebugInfo("��������� ������� ES_F1BU_DB_SWITCH_HANGUP");
					DebugInfo("this.pm_bIsRestartProduct = " + this.pm_bIsRestartProduct);
					DebugInfo("this.pm_sRestartCause = " + this.pm_sRestartCause);
				@end
			};
		}
	}
	
	// ����� ������������� ������� ��� �������������
	this.pm_ProcessRestartStatus = function()
	{
		if (this.pm_bIsRestartProduct)
		{
			Logger().Info(this.pm_sRestartCause);
			Logger().Info("����� ����������� ������");
			// ����� ����������� ������
			try {			
				if (this.pm_bIsCanRestartServer) {
					// ��������� ����, �.�. � �������� ��������� ����� ���������� ��������� ������
					this.pm_CloseLogFile();
					// ���� ��� ����� �� ������������� � ������� ������ ��������
					if (!this.pm_oManageableProduct.IsStartingOrStopping() && this.pm_oManageableProduct.BeginStartOrStop()) {
						try {
							// ������ ���� �������, ������ ����� ������ ��� �� ���������� ��������� ������ �������� ������ (���� ���������� ��� ���������, �� �� �� ������� ���������� � ������������ ����� ������ ������ �� ������)
							_classRestartHandler.prototype = new RestartHandler4EMailNotifications(
								this.pm_sRestartCause,
								this.pm_oManageableProduct.sNameForLog,
								this.pm_csFromEMail,
								this.pm_csToEmailServerRestart
							);	
							//
							_classRestartHandler.prototype.OnStartBegin = (function(oWatcher, func){
								var fParentMethod = _classRestartHandler.prototype.OnStartBegin;								
								return function() {
									func.apply(oWatcher);
									fParentMethod.apply(this);
								}									
							})(this, this.pm_OnServerStart);
							_classRestartHandler.prototype.OnStopBegin = (function(oWatcher, func){
								var fParentMethod = _classRestartHandler.prototype.OnStopBegin;								
								return function() {
									func.apply(oWatcher);
									fParentMethod.apply(this);
								}									
							})(this, this.pm_OnServerStopBegin);
							_classRestartHandler.prototype.OnStopEnd = (function(oWatcher, func){
								var fParentMethod = _classRestartHandler.prototype.OnStopEnd;								
								return function() {
									func.apply(oWatcher);
									fParentMethod.apply(this);
								}									
							})(this, this.pm_OnServerStopEnd);
							//
							function _classRestartHandler(){};
							//
							this.pm_oManageableProduct.Restart(this.pm_ciServerStopTimeout, new _classRestartHandler());
						} finally {
							this.pm_oManageableProduct.FinishStartOrStop()
						}

						// ������ ��� �����, �.�. ���� �� ���� �����������, �� � ���������� �� ����
						this.pm_ResetUpdateRelatedFlags();
					} else {
						Logger().Info("������ ������ ���� �����������, �� ���-�� ��� ��� �������������");
					}
					//
					this.pm_ResetHangupState();
				} else {
					Logger().Info("���������� ��������, ��������� ������������ �������, �� ��� ���������");
					if (this.pm_csToEmailServerRestart != "")
						SendMail(this.pm_csFromEMail, this.pm_csToEmailServerRestart,
							"���������� �������� � " + this.pm_oManageableProduct.sNameForLog + " �� ������ " + CompName(),
							HTMLDoc("�������� � ��������", "������� �������� �� " + this.pm_oManageableProduct.sNameForLog + " �� ������ " + CompName() + " ���������� ��������� ��������: " + this.pm_sRestartCause + "<div>��� ��� �������������� ������������ ���������, ��������, ��������� ������ �������������.")
						);
				}
			} catch (ex) {
				Logger().Error("���������� ��� ������� ������������� " + this.pm_oManageableProduct.sNameForLog);
				Logger().Exception(ex);
			}
		}	
	}
	
	// ����� ������������� �� ������ ���������� ���� ������� ReadOnly
	this.pm_ChangeROAttrOnInactiveDBFiles = function(
		isRO // true - ������������� RO, false - ���������� RO
	)
	{
		try {			
			var oFileEnum = new Enumerator(FSO().GetFolder(this.pm_oF1Server.GetPathToDB(false)).Files);
			for ( ; !oFileEnum.atEnd(); oFileEnum.moveNext() )
			{
				var oFile = oFileEnum.item();
				//
				if ( /data\..{3}/i.test(oFile.Name) )
					try {
						if ((oFile.Attributes & 1) == 1) {
							if (!isRO)
								oFile.Attributes -= 1;
						} else {
							if (isRO)
								oFile.Attributes += 1;
						}
					} catch(oEx) {
						Logger().Warning("������ ��������� (��� ���������) �������� ����� " + oFile.Name);
						Logger().Exception(oEx);
					}				
			}
		} catch (oEx) {
			Logger().Error("������ ��� ��������� ���������� ������ ���������� ����.");
			Logger().Exception(oEx);
		}		
	}
	
	// ����� ����������� ��� ����������� �������, ��������������� ����� �������� �������
	this.pm_OnServerStart = function()
	{
		// ��������� ��� ����� �������� �������, ����� �� ���������� ������, ������� ����� ���������� ��� �������
		this.pm_OpenLogFile();
		// ���� �����, ������ � �������� ���� ������
		if (this.pm_bIsNeedManualDBSwitching) {
			Logger().Info("����������� ���� ������ � ini-����� �������");
			this.pm_oF1Server.SwitchDataBaseInINIFile();
		}
		// ��������� ������� F1
		if (this.pm_bIsKillF1UtilitiesOnServerRestart) {
			KillF1Utilities();
		}
	}
	
	// ����� ����������� ��� ����������� ��������, ��������������� ����� ������� ���������
	this.pm_OnServerStopBegin = function()
	{
		if (this.pm_bIsNeedManualDBSwitching) {
			Logger().Info("������������� ������� RO �� ����� ���������� ����");
			this.pm_ChangeROAttrOnInactiveDBFiles(true);
		}
	}
	
	// ����� ����������� ��� ����������� ��������, ��������������� ����� ��������� �������
	this.pm_OnServerStopEnd = function()
	{
		if (this.pm_bIsNeedManualDBSwitching) {
			Logger().Info("���������� ������� RO � ������ ���������� ����");
			this.pm_ChangeROAttrOnInactiveDBFiles(false);
		}	
	}
	
	
	// ����� ���������, ���� �� ������ � ��� ��������� � ��� ��� �� ��� ����, � ���� ���� �� �����
	this.pm_KeepAlive = function()
	{
		try {
			if ( (this.pm_tKeepAliveInterval > 0)
				&& (CurrTimeStamp() > this.pm_tKeepAliveLastTimestamp + this.pm_tKeepAliveInterval) )
			{
				Logger().Info("������� ��� ��� ����. ��������� ����������� ������ ����: " + Trim(this.pm_sLastLine));
				this.pm_tKeepAliveLastTimestamp = CurrTimeStamp();
			}
		} catch(oEx) {
			Logger().Error("������ ��� ���������� ������ pm_KeepAlive");
			Logger().Info("typeof(this.pm_sLastLine): " + typeof(this.pm_sLastLine));
			Logger().Exception(oEx);
		}
	}

	// ���������� ����� � ������������� � ������� �������� �������� ������������ ��� F1BU, ���� �� ��������, �� ���������� -1
	this.pm_GetF1BURunningTime = function()
	{
		var result = -1;
		var oF1BU = GetWMIObjectForProcess("F1BU.exe");
		if (oF1BU != null) {
			result =  CurrTimeStamp() - WMIDate2StandardDate(oF1BU.CreationDate);
		}		
		@if(@DEBUG)
			DebugInfo("this.pm_GetF1BURunningTime ���������� " + result);
		@end		
		return result;
	}
	
	this.pm_CheckForAsserts = function()
	{
		if (this.pm_bIsDetectAsserts) {			
			@if(@DEBUG)
				DebugInfo("��������� ��������� �� ����� �������");			
			@end
			
			if (FSO().FileExists(this.pm_csAssertDetectorCmdFile))
				try {
					FSO().DeleteFile(this.pm_csAssertDetectorCmdFile);
				} catch (oEx) {
					Logger().Exception(oEx);
					Logger().Error("�� ������� ������� ���� ������� ����������� ��������!");
					return;
				}
				
			if (FSO().FileExists(this.pm_csAssertDetectorResFile))
				try {
					FSO().DeleteFile(this.pm_csAssertDetectorResFile);
				} catch (oEx) {
					Logger().Exception(oEx);
					Logger().Error("�� ������� ������� ���� ���������� ����������� ��������!");
					return;
				}
				
			var iProcessID = this.pm_oF1Server.GetProcessID();
			
			// ����� � ��������� ���� ��� �������� ������� ����� �������� ������ ���� � ���������
			var sTempCmdFile = this.pm_csAssertDetectorCmdFile + ".tmp";
			var oTmpCmdFile = FSO().CreateTextFile(sTempCmdFile, true);
			oTmpCmdFile.Write(iProcessID.toString());
			oTmpCmdFile.Close();
			FSO().MoveFile(sTempCmdFile, this.pm_csAssertDetectorCmdFile);
			
			// ���� ���� ����������
			var iDeadLine = CurrTimeStamp() + 3000;
			while (iDeadLine > CurrTimeStamp())
				if (FSO().FileExists(this.pm_csAssertDetectorResFile))
					break;
				else
					WScript.Sleep(100);
			if (!FSO().FileExists(this.pm_csAssertDetectorResFile)) {
				Logger().Error("���� � ����������� ����������� ������� �� ������� �� ���������� �����! ��������, �� ������� ������ ������ ��������");
				return;
			}
			
			//������ ����� ��������� ������ ������			
			var sHandles = GetFileBody(this.pm_csAssertDetectorResFile);
			FSO().DeleteFile(this.pm_csAssertDetectorResFile);
			var arrHandles = sHandles.split(END_OF_LINE);
			for (var i = 0; i != arrHandles.length; )
				if (arrHandles[i] == "") 
					arrHandles.splice(i, 1);
				else
					i++;
			@if(@DEBUG)
				DebugInfo("sHandles: " + sHandles);
				DebugInfo("arrHandles.length: " + arrHandles.length.toString());
			@end				
			
			// ���������� ���� �� ����� �������
			var bHasNewAsserts = false;			
			if (arrHandles.length > 0) {
				if (iProcessID == this.pm_iProcessIDForAssertDetector) {
					// ��� ����� �������� ��� ���� �������, ���������, ��� ��������� �����
					for (var i = 0; i != arrHandles.length; i++) {
						sHandle = arrHandles[i];
						
						var bIsNew = true;
						for (var j = 0; j != this.pm_arrAssertHandles.length; j++) {
							sOldHandle = this.pm_arrAssertHandles[j];
							if (sHandle == sOldHandle) {
								bIsNew = false;
								break;
							}
						}
						if (bIsNew) {
							@if(@DEBUG)
								DebugInfo("������� ����� ����� ���� ������� " + sHandle);			
							@end							
							bHasNewAsserts = true;
							this.pm_arrAssertHandles.push(sHandle);
						}						
					}
				} else {
					// ���� ����� ������� � ��� ����� �������� ��� ��� �� ��������������
					this.pm_iProcessIDForAssertDetector = iProcessID;
					bHasNewAsserts = true;
					this.pm_arrAssertHandles = arrHandles;
				}
			}
			
			if (bHasNewAsserts) {
				Logger().Info("���������� ����� �������");				
				SendMail(this.pm_csFromEMail, this.pm_csToEmailErrors,
						"�������� ������ � ������� �� ������ " + CompName() + "!", "")
			} else {
				@if(@DEBUG)
					DebugInfo("����� ������� �� ����������");			
				@end
			}
		}
	}
	
	this.pm_CheckForExceptionBreakpoints = function()
	{
		if (this.pm_bIsWatchForDebuggerBreakpoints)
		{
			@if(@DEBUG)
				DebugInfo("��������� �������� �� ����������");
			@end
						
			if (FSO().FileExists(this.pm_csBreakpointFilePath))
			{
				Logger().Info("�������� ���������� � ���������");
				var sBreakpointDescription = "";
				for (var i = 0; i < 3; i++)
					try {
						sBreakpointDescription = GetFileBody(this.pm_csBreakpointFilePath);
						FSO().DeleteFile(this.pm_csBreakpointFilePath);
						break;
					} catch (oEx) {
						@if(@DEBUG)
							DebugException(oEx);
						@end
						WScript.Sleep(300);
					}				
				
				if (sBreakpointDescription != "") {
					Logger().Info("����������: " + sBreakpointDescription);
					SendMail(
						this.pm_csFromEMail, this.pm_csToEmailErrors,
						"�������� ���������� � ��������� �� ������ " + CompName() + "!",
						sBreakpointDescription
					)
				} else {
					Logger().Error("��������� �����-�� ������ ��� ��������� ������ �����������");
				}
			} else {
				@if(@DEBUG)
					DebugInfo("����������� �� ���������");
				@end
			}
		}		
	}

	// ����� ����������� �������� �����
	this.Run = function()
	{		
		// ���������, ��� ��� ������������ ���������� ������
		with (new CriticalSection("f1server.watcher.run.check_unique"))
			if (Enter(5000)) {
				try {
					if (this.pm_oUseGuard.IsUsing())
						throw "��� ������� ���� ��������� ���������!";
					else
						this.pm_oUseGuard.Use();
				} finally {
					Leave()
				}
			} else {
				throw "�� ���� ����� � ����������� ������ ��� �������!";
			}

		try {
			Logger().Info("Watcher ����� ������");
			// ��������� ��� ORBDebugLevel ��������, � ���� �������, �� ��������� ������������� ����
			if ( this.pm_bIsUseLogFile && this.pm_oF1Server.IsORBDebugLevelON() ) {
				Logger().Warning("ORBDebugLevel �������, ������� ��������� ������������� ���-�����!");
				this.pm_bIsUseLogFile = false;
			}

			// �������� ���� �� ����������� �����
			var bIsFirstAllowedCheck = true;
			while ( !this.pm_oNeedExitEvent.Wait(0) )
			{
				this.pm_KeepAlive();
				//
				if ( this.pm_IsCanDoNextCheck() )
				{
					// ���������, ��� ����� ������ ��������, ���� ������ ����� ��������, ����� ������ ���� ���������
					if (bIsFirstAllowedCheck) {
						bIsFirstAllowedCheck = false;
						this.pm_ResetHangupState();
						this.pm_ResetUpdateRelatedFlags();
					}

					// ���������� ����� ������ ��������
					var	iStartCheck = CurrTimeStamp();

					if (this.pm_bIsUseLogFile)	{
						// ������������� ���, ���� ����
						if ( this.pm_bIsLogOpened && this.pm_IsMustReOpenLogFile() ) {
							Logger().Info("������������� ��� �������");
							this.pm_CloseLogFile();
							this.pm_ResetUpdateRelatedFlags(); // ����� ������������ ���� (������� ����� ���� ��-�� ����������) ����� ���������� �������� ��� ����� ��������� �� ���������� ��������� �������������, ��� ����� ���� ��������� �� ��������� ���������� �, ����� �������, ����� �� ����� �������� � �� ����� ��������� ������������ �������
						}
						// ��������� ��� ���� ����
						if ( (!this.pm_bIsLogOpened) && (!this.pm_OpenLogFile()) ) {
							Logger().Warning("�������, �� ������ ������� ��� ����...");
						}
					}

					this.pm_iErrorStatus = ES_OK;
					this.pm_iUpdateStatus = US_NO_INFO;
					this.pm_bIsRestartProduct = false;
					this.pm_sRestartCause = "";

					// ���� ��� ������ ��������� �������� � ������� ����
					if ( this.pm_bIsLogOpened ) {
						this.pm_DoNextCheckWithLog();
					}

					// ��������� � ������� ������� �������� �������
					this.pm_DoNextCheckWithF1SC();
					
					// ��������� �� ��������� �� �������
					this.pm_CheckForAsserts();
					// ��������� �� ��������� �� ����������� � ���������
					this.pm_CheckForExceptionBreakpoints();
					
					
					// �������� ��������� ������� ����������
					if (this.pm_bIsWatchForDBUpdateInLog) {
						this.pm_BeginProcessUpdateStatus();
					}
					try {
						// ������������ ������
						this.pm_ProcessErrorStatus();
						
						if ( this.pm_IsCanDoNextCheck() ) {						
							// ������������ ������ �����������, ������ ���� ������ ��� ��������
							this.pm_ProcessRestartStatus();
						} else {
							// ���� ������ ���� ����� ����������� ���������� ����, �� �� ������������ ��� � ��������,
							// �� ��������� ��� ������������ (��� �����������)
							if (this.pm_bIsWatchForDBUpdateInLog && this.pm_bIsNeedManualDBSwitching) {
								Logger().Info("��������� ������������ ��� � ���-����� ��� ������� �������");
								this.pm_oF1Server.SwitchDataBaseInINIFile();
								this.pm_bIsNeedManualDBSwitching = false;
							}
						}
					} catch(oEx) {
						Logger().Error("������ ��� ��������� ������� ������");
						Logger().Exception(oEx);
						throw oEx;
					} finally {
						// ����������� ��������� ������� ����������
						if (this.pm_bIsWatchForDBUpdateInLog) {
							this.pm_FinishProcessUpdateStatus();
						}
					}

					// ���� �������� ����������� ������� ��� this.pm_ciMinTimeForOneCheck, �� ���� �������
					var iTimeToWait = this.pm_ciMinTimeForOneCheck - (CurrTimeStamp() - iStartCheck);
					if (iTimeToWait > 0) {
						WScript.Sleep(iTimeToWait);
					}
				} else {
					// ��������� ���, ������ ��� ��� ����� ���� ����� �������
					this.pm_CloseLogFile();
					Logger().Info("������ ���������...");
					WScript.Sleep(this.pm_ciWaitTimeIfCanNotCheck);
					bIsFirstAllowedCheck = true;
				}
			}
		} catch(oEx) {
			Logger().Error("������ ��� ���������� ������ Run");
			Logger().Exception(oEx);
		} finally {
			this.pm_oUseGuard.Free();
			Logger().Info("Watcher �������� ������");
		}
	}

	// ����� ���������� ���������� ���������� ������ ������������� ��������� ���������
	this.Exit = function()
	{
		// ���������, � ����� ������ � �� ��������
		var bResult = !this.pm_oUseGuard.IsUsing();

		if (!bResult) {
			this.pm_oNeedExitEvent.Set()
			bResult = this.pm_oUseGuard.WaitForFree(this.pm_ciWaitTimeForExit);
			this.pm_oNeedExitEvent.Reset();
		}

		return bResult;
	}
}
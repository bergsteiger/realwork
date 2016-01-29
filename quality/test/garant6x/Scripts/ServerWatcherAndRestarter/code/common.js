// Это дефайны для conditional compilation
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

// ===== ГЛОБАЛЬНЫЕ КОНСТАНТЫ, КОТОРЫЕ ДОЛЖНЫ БЫТЬ ОПРЕДЕЛЕНЫ ПЕРВЫМИ =====
var	PT_SCRIPT_FOLDER = 1; // путь к папке с текущим скриптом
var	PT_LOGS_FOLDER = 2; // путь к папке с логами
var	PT_GLOBAL_INI_FILE = 3; // путь к ини-файлу
var	PT_F1SERVER_CHECKER = 4; // путь к утилите F1ServerChecrker.eze
var PT_SYNC_FOLDER = 5; // путь к папке временных файлов для синхронизации
var PT_VMMAP = 6; // путь к утилите vmmap
var PT_DEBUGGER_BREAKPOINT_FILE = 8; // путь к файлу в который макрос дебаггера сообщает о брейкпоинте
// перевод строки
var END_OF_LINE = "\r\n";
// для FSO.OpenTextFile и FSO::File.OpenAsTextStream
var FOR_READING = 1;
var FOR_WRITING = 2;
var FOR_APPENDING = 8;
// для ExecEx и т.п.
var WSH_RUNNING = 0;
var WSH_FINISHED = 1;
// для Dictionary. CompareMode_
var CM_BINARY = 1;
var CM_TEXT = 2;


// ===== КОНСТАНТЫ НАСТРОЙКИ =====

var INI_SECTION = "ServerWatcher";

// сюда посылаются сообщения об ошибках в логе сервера
var TO_EMAIL_ERRORS = INIFile().GetAsStr(INI_SECTION, "ToEMailErrors", "");
// сюда посылаются уведомления при перезапуске сервера. Если пусто, то почта не высылается
var TO_EMAIL_SERVER_RESTART = INIFile().GetAsStr(INI_SECTION, "ToEMailServerRestart", "");
// этот адрес подставляется в поле from при посылке e-mail.
var FROM_EMAIL = INIFile().GetAsStr(INI_SECTION, "FromEMail", "");
// smtp-сервер
var SMTP_SERVER = INIFile().GetAsStr(INI_SECTION, "SMTPServer", "");
// smtp-пользователь (если пустой то отправляем почту без авторизации)
var SMTP_USER = INIFile().GetAsStr(INI_SECTION, "SMTPUser", "");
// пароль smtp-пользователя
var SMTP_PASSWORD = INIFile().GetAsStr(INI_SECTION, "SMTPPassword", "");
// время (в миллисекундах) в течение которого будем ожидать остановки сервера при его перезапуске. Если в течение данного времени сервер не успеет остановится, то он будет убит
var SERVER_STOP_TIMEOUT = INIFile().GetAsNum(INI_SECTION, "ServerStopTimeout", 300);
if (SERVER_STOP_TIMEOUT > 0) SERVER_STOP_TIMEOUT *= 1000;
// если в течение этого времени (в миллисекундах) лог сервера не меняется, то считаем что сервер повис. Если -1 то проверка не производится
var SERVER_HANGUP_TIMEOUT = INIFile().GetAsNum(INI_SECTION, "ServerHangupTimeout", 300);
if (SERVER_HANGUP_TIMEOUT > 0) SERVER_HANGUP_TIMEOUT *= 1000;
// можно ли перезапускать сервер при обнаружении зависания или критических ошибок в логе
var IS_CAN_RESTART_SERVER = INIFile().GetAsBool(INI_SECTION, "IsCanRestartServer", false);
// через какой промежуток времени запускать проыерялку сервера (если -1, то не запускается)
var F1SERVER_CHECKER_START_INTERVAL = INIFile().GetAsNum(INI_SECTION, "F1ServerCheckerStartInterval", 180);
if (F1SERVER_CHECKER_START_INTERVAL > 0) F1SERVER_CHECKER_START_INTERVAL *= 1000;
//  если в течение этого времени проверялка сервера не завершит свою работу, то будем считать, что сервер висит
var F1SERVER_CHECKER_RUN_TIMEOUT = INIFile().GetAsNum(INI_SECTION, "F1ServerCheckerRunTimeout", 60);
if (F1SERVER_CHECKER_RUN_TIMEOUT > 0) F1SERVER_CHECKER_RUN_TIMEOUT *= 1000;
// можно ли искользовать лог-файл для проверки
var IS_USE_LOG_FILE = INIFile().GetAsBool(INI_SECTION, "IsUseLogFile", true);
// можно ли прибивать утилиты F1 при перезапуске сервера следилкой
var IS_KILL_F1_UTILITIES_ON_SERVER_RESTART = INIFile().GetAsBool(INI_SECTION, "IsKillF1UtilitiesOnServerRestart", true);
// контролировать интранет или обычный сервер
var IS_MUST_CONTROL_INTRANET = INIFile().GetAsBool(INI_SECTION, "IsMustControlIntranet", false);
// порт web-сервера интранета
var INTRANET_WEB_SERVER_PORT = INIFile().GetAsNum(INI_SECTION, "IntranetWebServerPort", -1);
// порт сервера f1 интранета
var INTRANET_DATA_SERVER_PORT = INIFile().GetAsNum(INI_SECTION, "IntranetDataServerPort", -1);
// куда отправлять письма с логами VMMap
var TO_EMAIL_VMMAP = INIFile().GetAsStr(INI_SECTION, "ToEMailVMMap", "");
// определять ли наличие сработавших отладочных ассертов для сервера
var IS_DETECT_ASSERTS = INIFile().GetAsBool(INI_SECTION, "IsDetectAsserts", false);
// следить ли за файлом в который отладчик сообщает о брейпоинтах
var IS_WATCH_FOR_DEBUGGER_BREAKPOINTS = INIFile().GetAsBool(INI_SECTION, "IsWatchForDebuggerBreakpoints", false);

// == ЭКСПЕРИМЕНТАЛЬНЫЕ НАСТРОЙКИ ==
// управлять ли 64-х битным сервером
var IS_64_BIT_SERVER = INIFile().GetAsBool(INI_SECTION, "Is64BitServer", false);
//
var F1BU_DB_SWITCH_TIMEOUT = INIFile().GetAsNum(INI_SECTION, "F1BUDBSwitchTimeout", -1);
if (F1BU_DB_SWITCH_TIMEOUT > 0) F1BU_DB_SWITCH_TIMEOUT *= 1000;

// ===== ОБЩИЕ ФУНКЦИИ =====

// Функция для проверки входных параметров функции на строковое значение
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

// Функция для проверки входных параметров функции на логическое значение
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

// Функция для проверки входных параметров функции на числовое значение
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

// Конвертирует число в 32-х разрядное 16-ричное представление. Встроенная конвертация какая-то непонятная...
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

// сравнивает 32бита числа (полезно при обработке ошибок, а то там какие-то непонятные преобразования со знаками выполняются)
function IsInt32Equal(left, right)
{
	return (left & 0xFFFFFFFF) == (right & 0xFFFFFFFF);
}

// Функция возвращает количество миллисекунд прошедших с 01.01.1970
function CurrTimeStamp()
{
	return (new Date()).getTime();
}

var gbl_FSO_Cache;
// Функция-фабрика экземпляра синглтона FileSystemObject
function FSO()
{
	if (typeof(gbl_FSO_Cache) != "object") {
		gbl_FSO_Cache = new ActiveXObject("Scripting.FileSystemObject");
	}
	return gbl_FSO_Cache;
}

// Функция-обертка вокруг WshShell.Exec
function ExecEx(
	sPathToExe, // путь к запускаемому файлу
	sParameters // параметры
)
{
	sParameters = TreatAsStr(sParameters, "");
	if (sParameters != "") sParameters = " " + sParameters;
	//
	var oFile = FSO().GetFile(sPathToExe);
	var oWshShell = WScript.CreateObject("WScript.Shell"); // специально создаем отдельный объект
	//
	oWshShell.CurrentDirectory = oFile.ParentFolder;
	return oWshShell.Exec(sPathToExe + sParameters);
}

var gbl_WshShell_Cache;
// Функция-фабрика экземпляра синглтона WshShell
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
		// создаем папку
		FSO().CreateFolder(sPath);
		// устанавливаем разрешения для всех
		GrantFoFAccessToEveryoneSilent(sPath);
	}
	//
	return sPath;
}


var gbl_WshNethwork_Cache;
// Функция-фабрика экземпляра синглтона WshNetwork
function WshNetwork()
{
	if (typeof(gbl_WshNethwork_Cache) != "object")	 {
		gbl_WshNethwork_Cache = WScript.CreateObject("WScript.Network");
	}
	return gbl_WshNethwork_Cache;
}

// Возвращает имя машины
function CompName()
{
	return WshNetwork().ComputerName;
}

var gbl_Is64bitWindows_Cache;
// Функция говорит является ли версия Windows 64-х разрядной
function Is64bitWindows()
{
	if (typeof(gbl_Is64bitWindows_Cache) != "boolean")
	{
		// читаем значение системной переменной PROCESSOR_ARCHITECTURE
		var oWshSysEnv = WshShell().Environment("SYSTEM");
		var sProcArch = oWshSysEnv("PROCESSOR_ARCHITECTURE");
		// если она равна AMD64 или IA64 то считаем что винда 64-х разрядная
		gbl_Is64bitWindows_Cache = ((sProcArch == "AMD64") || (sProcArch == "IA64"));
	}
	return gbl_Is64bitWindows_Cache;
}

// Функция возвращает содержимое текстового файла,
function GetFileBody(
	sPathToFile // полный путь к файлу
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
// Функция-фабрика экземпляра синглтона WMIService
function WMIService()
{
	if (typeof(gbl_WMIService_Cache) != "object") {
		gbl_WMIService_Cache = GetObject("winmgmts:{impersonationLevel=impersonate}!\\\\.\\root\\cimv2");
	}
	return gbl_WMIService_Cache;
}

// Конвертирует дату из wmi date-time формата в нативный Date
function WMIDate2StandardDate(
  sWMIDate // строка с временем в формате wmi (http://technet.microsoft.com/en-us/library/ee156576.aspx)
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

// Функция-фабрика возвращает WMI-объект (Win32_Process) для указанного процесса либо null если процесс не найден
function GetWMIObjectForProcess(
	sProcName, // имя процесса c расширением. Если не указано то ищем только по PID
	iPID // идентификатор процесса (Если задан, то при поиске учитывается с именем по критерию И)
)
{
	var bIsMustUsePID = TreatAsNum(iPID, -2578) != -2578;
	//
	var oResult = null;
	// получаем коллекцию объектов процессов
	var sQuery = "SELECT * FROM Win32_Process WHERE";
	if (sProcName != "") {
		sQuery += " Name = '" + sProcName + "'";
	}
	if (bIsMustUsePID) {
		sQuery += ((sProcName != "") ? " AND" : "") + " ProcessID = '" + iPID + "'";
	}
	var oColProc = WMIService().ExecQuery(sQuery);
	// если в коллекции больше одного элемента то возможно то что мы получим это не совсем то что надо, но все равно получаем
	if (oColProc.Count >= 1)
	{ // достаем из коллекции наш объект
		var oProcEnum = new Enumerator(oColProc);
		oResult = oProcEnum.item();
	}
	return oResult;
}

// Функция-фабрика возвращает WMI-объект (Win32_Service) для указанного сервиса либо null если сервис не найден
function GetWMIObjectForService(
	sServiceName // имя сервиса
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

// функция возвращает обновленный WMI-объект. Обновляет или с помощью спец.методв или переполучением объекта
function GetRefreshedWMIObject(
	oObject
)
{
	if ("Refresh_" in oObject)	{
		// с помощью родного метода
		oObject.Refresh_();
	} else {
		// с помощью переполучения объекта
		oObject = WMIService().Get(oObject.Path_.Path);
	}
	return oObject;
}

// функция запускает сервис. Делается несколько попыток старта сервиса, потом дожидается перехода сервиса в состояние Running в течение указанного времени
function StartService(
	oService, // объект сервиса
	iTimeout // время в течение которого ждем перехода сервера в состояние Running. По-умолчанию 10 сек
)
{
	iTimeout = TreatAsNum(iTimeout, 10000);
	//
	var bResult = false;
	var iSleepTime = 200;
	var iMaxAttemptsCount = 3;

	// делаем несколько попыток запуска сервиса
	var iErrCode;
	var iAttemptN = 1;
	do {
		iErrCode = oService.StartService();
		//
		if (iErrCode != 0) {
			// не удалось запустить
			Logger().Error("Попытка № " + iAttemptN + " запуска сервиса \"" + oService.Name + "\" не удалась. Вернулся код ошибки: " + iErrCode);
		}
	} while ((iErrCode != 0) && (iAttemptN++ < iMaxAttemptsCount));

	if (iErrCode != 0) {
		// не удалось запустить
		Logger().Error("Не удалось запустить сервис \"" + oService.Name + "\" за " + iMaxAttemptsCount + " попытки.");
	} else {
		// сервис успешно стартовал
		Logger().Info("Сервис \"" + oService.Name + "\" стартовал. Теперь ждем пока запустится.");
		// ждем пока перейдет в состояние Running
		var iDeadLine = CurrTimeStamp() + iTimeout;
		do {
			oService = GetRefreshedWMIObject(oService);
			bResult = (oService.State == "Running");
			if (bResult) break;
			WScript.Sleep(iSleepTime);
		} while (CurrTimeStamp() < iDeadLine);
		//
		if (bResult) {
			Logger().Info("Сервис \"" + oService.Name + "\" успешно запустился.");
		} else {
			Logger().Info("Сервис \"" + oService.Name + "\" за " + iTimeout + " мс так и не перешел в состояние Running. Считаем, что не запустился.");
		}
	}

	return bResult;
}

// Функция останавливает указанный сервис, говорит true, если после ее запуска сервис корректно остановлен
function StopService(
	oService, // объект сервиса
	iTimeout // время в течение которого ждем корректной остановки сервиса. По-умолчанию 10 сек
)
{
	iTimeout = TreatAsNum(iTimeout, 10000);
	//
	var iSleepTime = 200;

	oService = GetRefreshedWMIObject(oService);
	// проверяем, может остановлен
	var bResult = oService.State == "Stopped";
	if (!bResult)
	{
		// пытаемся остановить сервис корректно
		var iErrCode = oService.StopService();
		if (iErrCode != 0) {
			Logger().Error("При попытке завершения сервиса \"" + oService.Name + "\" нам вернули код ошибки " + iErrCode);
		} else {
			// ждем когда остановится. Только при безошибочном вызове StopService!
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

// Функция-обертка для метода Terminate объекта Win32_Process. Говорит true, если после нее процесс не существовал
function TerminateWMIProcess(
	oProcess, // объект процесса
	iTimeout // время, в течение которого будем ожидать прибитя процесса. По-умолчанию 10 сек.
)
{
	iTimeout = TreatAsNum(iTimeout, 10000);
	var bResult = false;
	var iSleepTime = 200;
	// Запоминаем данные процесса для последующей проверки его наличия
	var sProcName = oProcess.Name;
	var iPID = oProcess.ProcessId;
	// Добавляем необходимые привилегии
	oProcess.Security_.Privileges.AddAsString("SeDebugPrivilege");
	// Прибиваем его
	var iErrCode = oProcess.Terminate();
	if (iErrCode != 0) {
		Logger().Error("При попытке завершения процесса " + sProcName + " c PID " + iPID + " нам вернули код ошибки " + iErrCode);
	}
	// Ждем пока он реально исчезнет
	var iDeadLine = CurrTimeStamp() + iTimeout;
	do {
		bResult = (GetWMIObjectForProcess(sProcName, iPID) == null);
		if (bResult) break;
		WScript.Sleep(iSleepTime);
	} while (CurrTimeStamp() < iDeadLine);
	//
	return bResult;
}

// Функция убивает дочерние процессы. Говорит true, если после нее процессы не существовали
function TerminateChildsProcess(
	iPID, // идентификатор родительского процесса
	iTimeout // время, в течение которого будем ожидать прибитя процесса. По-умолчанию 10 сек.
)
{
	iTimeout = TreatAsNum(iTimeout, 10000);
	var bResult = true;
	//
	var oProcCol = WMIService().ExecQuery("SELECT * FROM Win32_Process WHERE ParentProcessId = " + iPID);
	// прибиваем дочерние процессы (в том числе дочерние дочерних и т.д.)
	if ((oProcCol != null) && (oProcCol.Count > 0)) {
		var oEnum = new Enumerator(oProcCol);
		for (; !oEnum.atEnd(); oEnum.moveNext())
		{
			var oProc = oEnum.item();
			// убиваем сам процесс
			oProc = GetWMIObjectForProcess(oProc.Name, oProc.ProcessID);
			iBegin = CurrTimeStamp();
			bResult = TerminateWMIProcess(oProc, iTimeout) && bResult;
			iTimeout -= CurrTimeStamp() - iBegin;
			// убиваем дочерние процессы конкретного процесса
			var iBegin = CurrTimeStamp();
			bResult = TerminateChildsOfWMIProcess(oProc, iTimeout) && bResult;
			iTimeout -= CurrTimeStamp() - iBegin;
		}
	}
	return bResult;
}

// Функция убивает дочерние процессы объекта Win32_Process. Говорит true, если после нее процессы не существовали
function TerminateChildsOfWMIProcess(
	oProcess, // объект процесса
	iTimeout // время, в течение которого будем ожидать прибитя процесса. По-умолчанию 10 сек.
)
{
	iTimeout = TreatAsNum(iTimeout, 10000);
	return TerminateChildsProcess(oProcess.ProcessId, iTimeout);
}

// Функция убивает дерево процесса (его и дочерние процессы). Говорит true, если после нее процессы не существовали
function TerminateWMIProcessTree(
	oProcess, // объект процесса
	iTimeout // время, в течение которого будем ожидать прибитя процесса. По-умолчанию 10 сек.
)
{
	iTimeout = TreatAsNum(iTimeout, 10000);
	var bResult = false;
	// убиваем сам процесс
	var iBegin = CurrTimeStamp();
	bResult = TerminateWMIProcess(oProcess, iTimeout);
	iTimeout -= CurrTimeStamp() - iBegin;
	// убиваем дочерние процессы
	bResult = TerminateChildsOfWMIProcess(oProcess, iTimeout) && bResult;
	return bResult;
}



var gbl_VBArrayMaker_Cache;
// Функция-фабрика компонента VBArrayMaker
function VBArrayMaker()
{
	if (typeof(gbl_VBArrayMaker_Cache) != "object")	 {
		// получаем компоненту
		try {
			gbl_VBArrayMaker_Cache = new ActiveXObject("F1ServerWatcher.VBArrayMaker.1");
		} catch (oEx) {
			Logger().Error("Не удалось создать компоненту F1ServerWatcher.VBArrayMaker.1");
			Logger().Exception(oEx);
			throw oEx;
		}
	}
	return gbl_VBArrayMaker_Cache;
}

// Устанавливает у указанного файла или папки все разрешения для Everyone
function GrantFoFAccessToEveryone(
	sPath
)
{
	var oWMI = WMIService();
	sPath = sPath.replace(/\\/g, "\\\\"); // удваиваем слэши
	// получаем экземпляр Win32_LogicalFileSecuritySetting для заданного пути
	var oLFSS;
	try {
		oLFSS = oWMI.Get("Win32_LogicalFileSecuritySetting.Path=\"" + sPath + "\"");
	} catch (oEx) {
		if (IsInt32Equal(oEx.number, 0x80041002)) // Not found
		{
			try {
				var oSSCol = oWMI.ExecQuery("SELECT * FROM Win32_LogicalFileSecuritySetting WHERE Path = \"" + sPath + "\"");
				if (oSSCol.Count == 0)
					throw "Файл или папка не доступны!";
				oLFSS = (new Enumerator(oSSCol).item());
			} catch (oEx2) {
				throw oEx2;
			}
		}
		else
			throw oEx;
	}

	// конструируем SecurityDescriptor с параметрами: все разрешено Everyone и Owner
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
	// применяем настройки безопасности
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
				DebugInfo("Успешно выполнили GrantFoFAccessToEveryone для \"" + sPath + "\"");
			else
				DebugError("Не удалось выполнить GrantFoFAccessToEveryone для \"" + sPath + "\"");
		@end
	} catch (oEx) {
		Loger().Error("Исключение при выполнении GrantFoFAccessToEveryone для \"" + sPath + "\"");
		Logger().Exception(oEx);
	}
}

// Посылает пиьсмо в формате HTML с указанными параметрами. Возвращает либо пустую строку (если при отправке не было ошибок), либо текст ошибки.
function SendMail(
	fromAddr, // от кого письмо
	toAddr, // кому письмо
	subj, // тема
	htmlBody, // текст в формате HTML
	attachFilesArr, // массив с именами приаттачиваемых файлов, если не указан, то ничего не приаттачивается
	isRethrowException
)
{
	var sError = "";
	var SEND_ATTEMPTS_COUNT = 6; // столько делаем попыток отправить почту
	var SEND_ATTEMPT_TIMEOUT = 20000; // столько ждем перед следующей попыткой
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
		{ // нам передали массив
			for (var i=0; i < attachFilesArr.length; i++)
			{
				var fileName = attachFilesArr[i];
				if (FSO().FileExists(fileName))
					objEmail.AddAttachment( FSO().GetFile(fileName).Path );
			}
		}

		// сформировали письмо, теперь пытаемся его послать несколько раз, а то по неизвестным причинам может возникать ошибка The transport failed to connect to the server
		Logger().Info("Посылаем письмо c темой \"" + subj + "\" с адреса " + fromAddr + " на адрес " + toAddr);
		for (var i=1; i <= SEND_ATTEMPTS_COUNT; i++)
		{
			try {
				objEmail.Send();
				Logger().Info("Письмо успешно выслано с " + i + "-й попытки.");
				break;
			} catch (oEx) {
				Logger().Exception(oEx);
				if (i != SEND_ATTEMPTS_COUNT) // если это не последняя попытка
				{
					if (IsInt32Equal(oEx.number, 0x80040213)) //  случилась  ошибка The transport failed to connect to the server
					{ // то делаем еще попытку
						var iSleepTime = SEND_ATTEMPT_TIMEOUT;
						Logger().Warning("При попытке отправить письмо произошла ошибка подключения к серверу. Возможно сервер перегружен или соединение блокируется антивирусом/файрволом. Подождем " + iSleepTime +" мс и попробуем еще раз.");
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
		var sMessage = "ГАРАНТовская утилита слежения за сервером при попытке отправить почту столкнулась с проблемой: " + sError;
		WshShell().LogEvent(1, sMessage);
		Logger().Error(sMessage);
		Logger().Exception(oEx);
	}
	return sError;
}

// формирует html-документ
function HTMLDoc(
	sTitle, // название
	sBody, // тело (в офрмате HTML)
	sStyles // таблица стилей (по-умолчанию пустая)
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
// Функция-фабрика экземпляра синглтона QCComponentsFactory
function QCComponentsFactory()
{
	if (typeof(gbl_QCCF_Cache) != "object") {
		try {
			gbl_QCCF_Cache = new ActiveXObject("QCFileComponents.QCComponentsFactory");
		} catch (oEx) {
			Logger().Error("Ошибка при создании экземпляра QCFileComponents.QCComponentsFactory");
			Logger().Exception(oEx);
			throw oEx;
		}
	}
	return gbl_QCCF_Cache;
}

// обрезает у строки заверщающие символы конца строки
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

// обрезает у строки обрамляющие разделители
function Trim(
	sText
)
{
	var oRExp = /^\s*([\s\S]*?)\s*$/;
	if ((arrRes = oRExp.exec(sText)) != null)
		sText = arrRes[1];
	return sText;
}

// возвращает путь к нужному объекту
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
// Функция-фабрика экземпляра синглтона логгера
function Logger()
{
	if (typeof(gbl_Logger_Cache) != "object") {
		// инициализируем логгер куда-нибудь
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

// Прикрепляет логгер к нужному файлу
function AttachLoggerToFile(
	sFilePath // полный путь к лог-файлу
)
{
	if (gbl_Logger_Cache != null) {
		gbl_Logger_Cache.Close();
	}
	gbl_Logger_Cache = new CLogger(sFilePath);
}

var gbl_INIFile_Cache;
// функция-фбрика экземпляра синглтона глобального ини-файла
function INIFile()
{
	if (typeof(gbl_INIFile_Cache) != "object") {
		gbl_INIFile_Cache = new IniMan( GetPathTo(PT_GLOBAL_INI_FILE) );
		gbl_INIFile_Cache.Load();
	}
	return gbl_INIFile_Cache;
}

// Прибивает утилиты F1DataUpd.run, F1DataSetup.run, F1Download.run
function KillF1Utilities()
{
	var arrProcNames = ["F1DataUpd.run", "F1DataSetup.run", "F1Download.run"];
	// прибиваем все указанные процессы
	for (iIdx in arrProcNames)
	{
		var sProcName = arrProcNames[iIdx];
		var oProcess = GetWMIObjectForProcess(sProcName);
		if (oProcess != null) {
			if (TerminateWMIProcess(oProcess))
				Logger().Info("Успешно прибили процесс " + sProcName);
			else
				Logger().Error("Не удалось прибить процесс " + sProcName);
		}
	}
}

// ===== ОПРЕДЕЛЕНИЯ КЛАССОВ =====


// параметр ини файла
function _IniMan_Parameter()
{
	// значение параметра
	this.pm_Value;

	// признак комментария
	this.isComment = false;

	// утсанааливает значение
	this.Set = function(
		value
	)
	{
		this.pm_Value = value;
	}

	// говорит,проинициалзирован ли параметр значением
	this.IsInitialized = function()
	{
		return typeof(this.pm_Value) != "undefined";
	}

	// возвращает значение параметра как строку
	this.GetAsStr = function ()
	{
		return this.pm_Value.toString();
	}

	// возвращает значение параметра как число
	this.GetAsNum = function ()
	{
		return this.pm_Value/1;
	}

	// возвращает значение параметра как логическое
	this.GetAsBool = function ()
	{
		var sUpCased = this.pm_Value.toString().toUpperCase();
		return (sUpCased == "YES") || (sUpCased == "TRUE");
	}
}

// секция ини-файла
function _IniMan_Section()
{
	// параметры
	this.pm_oParameters = new ActiveXObject("Scripting.Dictionary");
	this.pm_oParameters.CompareMode = CM_TEXT;

	// возвращает объект параметра
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

	// возвращает массив с именами всех параметров
	this.ParametersNames = function()
	{
		return this.pm_oParameters.Keys().toArray();
	}

	// говорит, есть ли у секции хоть один инициализированный параметр
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
	// полный путь к ини-файлу
	this.pm_sPathToINI = sPathToINI;
	// секции
	this.pm_oSections = new ActiveXObject("Scripting.Dictionary");
	this.pm_oSections.CompareMode = CM_TEXT;

	// конец строки для ini-файла
	this.pm_sEndOfLineStr = "\r\n";
	// символ комментария
	this.pm_sCommentPrefix = ";";


	// возвращает путь к ini-файлу
	this.GetPathToINI = function()
	{
		return this.pm_sPathToINI;
	}

	// возвращает объект секции или null если его нет и нельзя создавать
	this.Section = function(
		sSectionName, // имя секции
		isForceCreate // создавать если нету
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

	// возвращает массив с именами всех секций
	this.SectionsNames = function()
	{
		return this.pm_oSections.Keys().toArray();
	}

	// сериализует
	this.pm_Serialize = function()
	{
		var sResult = "";

		// перебираем все секции
		var arrSectionNames = this.SectionsNames();
		for (iSectionNum in arrSectionNames)
		{
			var sSectionName = arrSectionNames[iSectionNum];
			var oSection = this.Section(sSectionName);
			if (oSection.IsInitialized())
			{
				// добавляем заголовок секции
				sResult += "[" + sSectionName + "]" + this.pm_sEndOfLineStr;
				// перебираем параметры в секции
				var arrParametersNames = oSection.ParametersNames();
				for (iParamNum in arrParametersNames)
				{
					var sParamName = arrParametersNames[iParamNum];
					var oParameter = oSection.Parameter(sParamName);
					// добавляем параметр
					if (oParameter.IsInitialized())
					{
						if (oParameter.isComment)
							sResult += this.pm_sCommentPrefix;
						else
							sResult += sParamName + "=";
						sResult += oParameter.GetAsStr() + this.pm_sEndOfLineStr;
					}
				}
				sResult += this.pm_sEndOfLineStr; // после секции идет пустая строка
			}
		}
		return sResult;
	}

	// десериализует
	this.pm_Unserialize = function(
		sData
	)
	{
		this.pm_oSections.RemoveAll();

		// регулярное выражение для разбивки на секции
		var oRExpSection = /(?:^|[\r\n]+)\[([ \w]*)\]\s?([\s\S]*?)(?=\s+\[|\s*$)/g;
		// регулярное выражение для парсинга параметров
		var oRExpParam = /^(.*?)\s*=(.*?)$/;
		// регулярное выражения для выделения отдельной строки
		var oRExpLine = /^(.*)$/gm;

		// разбиваем входную строку на имя_секции - тело_секции
		while ((arrSec = oRExpSection.exec(sData)) != null)
		{
			var sSectionName = arrSec[1];
			var sSectionBody = arrSec[2];
			//
			var oSection = this.Section(sSectionName, true);
			// рассматриваем секцию построчно
			var i = 0;
			while ((arrLine = oRExpLine.exec(sSectionBody)) != null)
			{
				++i;
				var sLine = arrLine[1];
				if (sLine.length > 0) // если строка не пустая
				{
					var sParamName = "";
					var sParamValue = "";
					// распознаем строку
					var isComment = (sLine.charAt(0) == this.pm_sCommentPrefix);
					if (isComment)
					{ 	// если строка - это комментарий
						sParamName = this.pm_sCommentPrefix + "comment_" + i;
						sParamValue = TrimTrailingEOLs(sLine.substr(1));
					} else if ((arrParam = oRExpParam.exec(sLine)) != null)
					{ 	// если строка - это параметр
						sParamName = Trim(arrParam[1]);
						sParamValue = Trim(arrParam[2]);
					}
					// создаем параметр если что-то нашли
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

	// сохраняет в файл
	this.Save = function()
	{
		var oFile = FSO().OpenTextFile(this.pm_sPathToINI, FOR_WRITING, true);
		GrantFoFAccessToEveryoneSilent(this.pm_sPathToINI);
		oFile.Write(this.pm_Serialize());
	}

	// загружает из файла
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

// Класс для логгирования сообщений
function CLogger(
	sPathToLogFile // полный путь к лог файлу
)
{
	// Храним полный путь к лог-файлу
	this.pm_sPathToLogFile = sPathToLogFile;
	// FSO::TextStream для файла
	this.pm_oLogFileTS = FSO().OpenTextFile(this.pm_sPathToLogFile, FOR_APPENDING, true);

	// Закрывает лог
	this.Close = function()
	{
		this.pm_oLogFileTS.Close();
		this.pm_oLogFileTS = null;
	}

	// Добавляет запись в файл
	this.pm_AddMessage = function(
		sMessage // текст добавляемого сообщения
	)
	{
		// Формируем временную метку
		var oDate = new Date();
		var sTimeStamp = oDate.toDateString() + " " + oDate.toLocaleTimeString() + "." + oDate.getMilliseconds();;
		// пишем сообщение
		this.pm_oLogFileTS.WriteLine(sTimeStamp + " | " + TrimTrailingEOLs(sMessage));
	}

	// Добавляет информационное сообщение
	this.Info = function(
		sMessage // текст добавляемого сообщения
	)
	{
		return this.pm_AddMessage("INFO: " + sMessage);
	}

	// Добавляет предупреждение
	this.Warning = function(
		sMessage // текст добавляемого сообщения
	)
	{
		return this.pm_AddMessage("WARNING: " + sMessage);
	}

	// Добавляет сообщение об ошибке
	this.Error = function(
		sMessage // текст добавляемого сообщения
	)
	{
		return this.pm_AddMessage("ERROR: " + sMessage);
	}

	// Добавляет сообщение об исключении
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

// Класс представляющий функциональность в стиле объекта синхронизации типа "критическая секция"
function CriticalSection(
	sCSName // имя критической секции (должно быть валидным именем файла)
)
{
	// имя критической секции
	this.pm_csCSName = "cs." + sCSName;
	// имя файла
	this.pm_sPathToLockFile = GetTempDirForSyncOps() + "\\" + this.pm_csCSName;
	// Fso:TextStream для файла
	this.pm_oLockFile = null;
	// захвачена ли уже
	this.pm_bIsLocked = false;
	// счетчик залочек
	this.pm_iLockCount = 0;

	// Пытаемся войти в критическую секцию в течение заданного времени. True - если получилиось, False - иначе.
	this.Enter = function(
		iTimeout // время в течение которого будем ждать входа в секцию, если -1 то ждем до конца
	)
	{
		iTimeout = TreatAsNum(iTimeout, 0);
		//
		if (!this.pm_bIsLocked)
		{
			// пытаемся залочить файл в течение заданного времени
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
						Logger().Error("Исключение при попытке залочить файл для критической секции по пути \"" + this.pm_sPathToLockFile + "\"");
						throw oEx;
					}
				}
			} while ( ((iTimeout == -1) || (CurrTimeStamp() < iDeadLine)) && (!this.pm_bIsLocked) );
		}
		if (this.pm_bIsLocked) this.pm_iLockCount++;
		return this.pm_bIsLocked;
	}

	// Выходим из критической секции
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

// Класс позволяет узнать, используется ли ресурс кем-то еще, что-то типа счетчика ссылок
function UseCounter (
	sName // имя (должно быть валидным именем файла)
)
{
	// имя ресурса
	this.pm_sName = "uc." + sName;
	// имя файла
	this.pm_sFileName = GetTempDirForSyncOps() + "\\" + this.pm_sName;
	// критическая секция для синхронизации проверки
	this.pm_oSyncCS	= new CriticalSection(this.pm_sName);
	// объект файла
	this.pm_oTextStream = null;
	//
	this.pm_iUseCount = 0;

	// открывает файл
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

	// закрывает файл
	this.pm_CloseFile = function()
	{
		this.pm_oTextStream.Close();
		this.pm_oTextStream = null;
	}

	// Использовать ресурс
	this.Use = function()
	{
		this.pm_iUseCount++;
		if (this.pm_iUseCount == 1) {
			this.pm_OpenFile();
		}
	}

	// Освободить ресурс
	this.Free = function()
	{
		if (this.pm_iUseCount > 0) {
			if (this.pm_iUseCount == 1) {
				this.pm_CloseFile();
			}
			this.pm_iUseCount--;
		}
	}

	// Говорит, использует ли кто-то еще этот ресурс
	this.IsUsing = function()
	{
		var bRes = false;
		//
		if ( (this.pm_oSyncCS.Enter(-1)) )
			try {
				// пытаемся его удалить, если удалить не получится значит кто-то его еще держит
				try {
					if (FSO().FileExists(this.pm_sFileName))
						FSO().DeleteFile(this.pm_sFileName);
				} catch (oEx) {
					if (IsInt32Equal(oEx.number, 0x800a0046)) {// Access denied
						bRes = true;
					} else {
						Logger().Exception(oEx);
						Logger().Error("Исключение при попытке удалить файл UseCounter по пути \"" + this.pm_sFileName + "\"");
						throw oEx;
					}
				}
			} finally {
				this.pm_oSyncCS.Leave();
			}
		//
		return bRes;
	}

	// Ожидает освобождения объекта (для синхронизации следует использовать Event)
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


// Класс, представляющий функциональность в стиле объекта синхронизации типа event
function Event(
	sEventName, // имя event'а (должно быть валидным именем файла)
	bInitialState // начальное состояние (false - non signaled, true - signaled), по-умолчанию false
)
{
	//
	bInitialState = TreatAsBool(bInitialState, false);

	// имя
	this.pm_sEventName = "event." + sEventName;
	// имена файлов
	this.pm_sPathToEventFile_1 = GetTempDirForSyncOps() + "\\" + this.pm_sEventName + ".1";
	this.pm_sPathToEventFile_2 = GetTempDirForSyncOps() + "\\" + this.pm_sEventName + ".2";
	// счетчик, показывает, используется ли событие кем-нибудь
	this.pm_oUC = new UseCounter(this.pm_sEventName);
	// критическая секция синхронизирующая изменение состояния
	this.pm_oCS = new CriticalSection(this.pm_sEventName + ".change");

	//
	this.pm_ciDelayTime = 100;

	// инициализация события
	this.pm_Initialize = function(
		bInitialState
	)
	{
		var oCSInit = new CriticalSection(this.pm_sEventName + ".init");
		if (oCSInit.Enter(-1))
			try	{
				if (!this.pm_oUC.IsUsing()) { // событие никем не используется, поэтому можно переинициализировать
					bInitialState ? this.Set() : this.Reset();
				}
				// говорим что используем объект, т.о. при переинициализации никто его не изменит
				this.pm_oUC.Use(); // free нигде не вызываем, т.к. отпустится автоматом при уничтожении экземпляра объекта
			} finally {
				oCSInit.Leave();
			}
	}

	// Установка в состояние signaled
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

	// Сброс в состояние unsignaled
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

	// Ждет пока состояние не станет signaled, возвращает true если дождались
	this.Wait = function(
		iTimeout // сколько время ждать, если -1, то постоянно
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

// Класс, управляющий утилитой проверки сервера
function F1ServerChecker(
	sPathToUtil, // полный путь к утилите F1ServerChecker
	sPathToUtilINIFile, // полный путь к ini-файлу для утилиты, если не задано, то не используется
	sPathToAdapterINIFile // полный путь к ini-файлу адаптера, если не задано, то не используется
)
{
	// полный путь к утилите F1ServerChecker
	this.pm_sPathToUtil = sPathToUtil;
	// полный путь к ini-файлу для утилиты, если не задано, то не используется
	this.pm_sPathToUtilINIFile = TreatAsStr(sPathToUtilINIFile, "");
	// полный путь к ini-файлу адаптера, если не задано, то не используется
	this.pm_sPathToAdapterINIFile = TreatAsStr(sPathToAdapterINIFile, "");

	// код выхода утилиты
	this.pm_iExitCode = -1;
	
	// Метод подготавливает реестр для адаптера. Нужно, потому что запускаемся из-под аккаунта System, а там нужных записей может и не быть
	this.pm_PrepareRegistry = function()
	{
		// ключ в реестре для клиента 
		var sRegKey = "HKCU\\Software\\Garant.F1\\ApplicationAdapterOptions";
	
		// устанавливаем				
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

	// Метод выполняет проверку. Если утилита отработала за заданное время, то возвращает true, если нет - то false
	this.RunChecker = function(
		iTimeout // время в миллисекундах в течение которого будем ждать отрботки утилиты
	)
	{
		this.pm_PrepareRegistry();
		
		// запускаем утилиту
		var oWshScriptExec = ExecEx(this.pm_sPathToUtil, "\"" + this.pm_sPathToUtilINIFile + "\"");
		// ждем пока отработает
		var iDeadLine = CurrTimeStamp() + iTimeout;
		while (iDeadLine > CurrTimeStamp())
			if (oWshScriptExec.Status == WSH_FINISHED)
				break;
			else {
				// pipe'ы надо опустошать иначе может(!) быть дедлок. По идее это надо делать в независимых потоках потому что внутренний read синхронный, но у нас тут их нет, а посимвольно тоже дедлочится. Поэтому, начинаем с stderr, потому что туда адаптер пишет.
				if (!oWshScriptExec.StdErr.AtEndOfStream)
					oWshScriptExec.StdErr.ReadAll();
				if (!oWshScriptExec.StdOut.AtEndOfStream)
					oWshScriptExec.StdOut.ReadAll();

				WScript.Sleep(500);
			}

		// таймаут истек, проверяем, отработала ли утилита
		if (oWshScriptExec.Status == WSH_FINISHED) {
			this.pm_iExitCode = oWshScriptExec.ExitCode;
			return true;
		} else {
			oWshScriptExec.Terminate(); // прибиваем чекер
			return false;
		}
	}
}

// Класс управляющий утилитой остановки сервера
function F1SrvStopper(
	sPathToServer // путь к папке куда установлен сервер
)
{
	if ( !FSO().FolderExists(sPathToServer) )
		throw "Путь к серверу не существует!";

	// Указывает на папку, где лежит сервер
	this.pm_sPathToServerFolder = sPathToServer;
	// Имя процесса утилиты остановки сервера
	this.pm_csProcName = "F1ServerStopper.exe";

	// Метод возвращает WMI-объект типа Win32_Process для утилиты остановки сервера
	this.pm_GetWMIProcessToSrvStopper = function()
	{
		return GetWMIObjectForProcess(this.pm_csProcName);
	}

	// Метод говорит запущена ли утилита остановки сервера
	this.IsSrvStopperRunning = function()
	{
		return (this.pm_GetWMIProcessToSrvStopper() != null);
	}

	// Метод запускает утилиту остановки сервера. В случае упешного запуска возвращает объект WshScriptExec, иначе null
	this.Start = function(
		iTimeout // в течение этого времени (в миллисекундах) ждем запуска утилиты остановки сервера
	)
	{
		if (typeof(iTimeout) != "number")
			throw "iTimeout должен быть задан и должен быть числом!";

		// Вычисляем путь к утилите остановки сервера
		var sPathToSrvStop = "";
		sPathToSrvStop = this.pm_sPathToServerFolder + "\\apps\\winNT\\" + this.pm_csProcName;
		if ( !FSO().FileExists(sPathToSrvStop) ) {
			Logger().Error("Утилита остановки сервера не найдена по пути \"" + sPathToSrvStop + "\"");
			throw "Не могу найти путь к srvstop.bat";
		}

		// Запускаем утилиту
		var oWshScriptExec = ExecEx(
			sPathToSrvStop,
			"-GCMConfigFile \"" + this.pm_sPathToServerFolder + "\\garant.ini\" -GPMAdapterConfigSection \"F1Client Params\""
		);
		Logger().Info("Запущена утилита для останова сервера");

		return oWshScriptExec;
	}

	// Метод принудительно завершает работу утилиты. Говорит true если после окончания его работы утилита остановки сервера не запущена
	this.Terminate = function()
	{
		var oWMISrvStopper = this.pm_GetWMIProcessToSrvStopper();
		if (oWMISrvStopper != null)
		{
			Logger().Info("Работа утилиты остановки сервера будет принудительно завершена");
			TerminateWMIProcess(oWMISrvStopper);
			// Проверяем что все получилось
			oWMISrvStopper = this.pm_GetWMIProcessToSrvStopper();
			if (oWMISrvStopper == null) {
				Logger().Info("Принудительное завершение работы утилиты остановки сервера прошло успешно.");
			} else {
				Logger().Error("Не удалось принудительно завершить утилиту остановки сервера! PID процесса: " + oWMISrvStopper.ProcessId);
			}
		}
		return !this.IsSrvStopperRunning();
	}
}

// абстрактный класс-интерфейс для callback-обработчика, используемого при перезапуске сервера
function RestartHandlerBase()
{
	// этот обработчик вызывается перед началом остановки сервера
	this.OnStopBegin = function()
	{
		throw "Must be implemented!";
	}

	// этот обработчик вызывается после остановки сервера
	this.OnStopEnd = function(
		isStopSuccess
	)
	{
		throw "Must be implemented!";
	}

	// этот обработчик вызывается перед началом запуска сервера
	this.OnStartBegin = function()
	{
		throw "Must be implemented!";
	}

	// этот обработчик вызывается после запуска сервера
	this.OnStartEnd = function(
		isStartSuccess
	)
	{
		throw "Must be implemented!";
	}
}

RestartHandler4EMailNotifications.prototype = new RestartHandlerBase();
function RestartHandler4EMailNotifications(
	sRestartCause, // причина перезапуска
	sName, // название того что перезапускаем
	sFromEMail, // от кого посылать письмо
	sToEMail // кому посылать письмо
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
				"Начата перезагрузка " + this.pm_sName + " на машине " + CompName(),
				HTMLDoc("Перезагрузка " + this.pm_sName, this.pm_sName + " будет перезагружен.<div>Причина: " + this.pm_sRestartCause + "<div>Начата остановка " + this.pm_sName + ".")
			);
	}

	this.OnStopEnd = function(
		isStopSuccess
	)
	{
		if (this.pm_sToEMail != "")
			if (isStopSuccess)
				SendMail(this.pm_sFromEMail, this.pm_sToEMail,
					"Успешно остановлен " + this.pm_sName + " на машине " + CompName(),
					 HTMLDoc("Остановка " + this.pm_sName, this.pm_sName + " успешно остановлен."));
			else
				SendMail(this.pm_sFromEMail, this.pm_sToEMail,
					"Ошибка при остановке " + this.pm_sName + " на машине " + CompName(),
					HTMLDoc("Остановка " + this.pm_sName, "При остановке " + this.pm_sName + " возникла ошибка. Возможно, требуется ручное вмешательство!") );
	}

	this.OnStartBegin = function()
	{
		if (this.pm_sToEMail != "")
			SendMail(this.pm_sFromEMail, this.pm_sToEMail,
				"Начат запуск " + this.pm_sName + " на машине " + CompName(),
				HTMLDoc("Запуск " + this.pm_sName, "Начали запуск " + this.pm_sName + ".")
			);
	}

	this.OnStartEnd = function(
		isStartSuccess
	)
	{
		if (this.pm_sToEMail != "")
			if (isStartSuccess)	{
				SendMail(this.pm_sFromEMail, this.pm_sToEMail,
					"Успешно перезапущен " + this.pm_sName + " на машине " + CompName(),
					HTMLDoc("Запуск " + this.pm_sName, "Перезапуск " + this.pm_sName + " произошел успешно.") );
			} else {
				SendMail(this.pm_sFromEMail, this.pm_sToEMail,
					"Ошибка при запуске " + this.pm_sName + " на машине " + CompName(),
					HTMLDoc("Запуск " + this.pm_sName, "При запуске " + this.pm_sName + " возникла ошибка. Возможно, требуется ручное вмешательство!")	);
			}
	}
}

// Класс, реализующий общую (для F1Server и intranet) функциональность останавливаемого/запускаемого продукта
function ManageableProduct(
	sUniqueID, // идентификатор продукта
	sNameForLog // человекопонимаемое имя, для вывода в лог
)
{
	sUniqueID = TreatAsStr(sUniqueID, "");
	if (sUniqueID == "") throw "sUniqueID должно быть указано!";
	// имя для вывода в лог
	this.sNameForLog = TreatAsStr(sNameForLog, "");
	if (this.sNameForLog != "") {
		this.sNameForLog = "\"" + this.sNameForLog + "\"";
	} else {
		throw "sNameForLog должно быть указано!";
	}

	// Критическая секция контролирующая запуск/остановку сервера
	this.pm_oCSStartOrStopPerformed = new CriticalSection(sUniqueID + ".control.utility.sos");
	// Счетчик для получения информации о том, идет ли процесс запуска/остановки
	this.pm_oUCStartOrStopPerformed = new UseCounter(sUniqueID + ".control.utility.sos");

	// Метод запускает продукт. В случае успешного запуска говорит true, иначе false
	this.Start = function()
	{
		if ( this.BeginStartOrStop() )
		{
			Logger().Info("Запускаем " + this.sNameForLog);
			try {
				if (!this.IsRunning()) {
					// продукт еще не запущен
					try {
						this.pm_Start();
					} catch (oEx) {
						Logger().Exception(oEx);
						Logger().Error("Исключение при выполнении this.pm_Start");
					}
				} else {
					//  продукт уже запущен
					Logger().Warning("Попытка запустить " + this.sNameForLog + " в то время как он уже запущен!");
				}
				//
				var bResult = this.IsRunning();
				if (bResult) {
					Logger().Info("Успешно запустили " + this.sNameForLog);
				} else {
					Logger().Warning("Не удалось запустить " + this.sNameForLog);
				}
				//
				return bResult;
			} finally {
				this.FinishStartOrStop();
			}
		} else {
			throw "Уже проводится какая-то операция управления " + this.sNameForLog + ".";
		}
	}

	// Метод останавливает продукт. Если по окончании работы функции сервер не запущен то возвращает true, иначе - false.
	this.Stop = function(
		iTimeout, // в течение этого времени (в миллисекундах) будем ждать нормальной остановки сервера
		isKill // убивать продукт если он не остановился в течение заданного времени (по-умолчанию: true)
	)
	{
		if (TreatAsNum(iTimeout) == null) throw "iTimeout долен быть числом!";
		isKill = TreatAsBool(isKill, true);
		//
		if ( this.BeginStartOrStop() )
		{
			Logger().Info("Останавливаем " + this.sNameForLog);
			try {
				if (this.IsRunning()) {
					// продукт запущен
					try {
						this.pm_Stop(iTimeout, isKill);
					} catch (oEx) {
						Logger().Exception(oEx);
						Logger().Error("Исключение при выполнении this.pm_Stop");
					}
				} else {
					// продукт уже остановлен
					Logger().Warning("Попытка остановить " + this.sNameForLog + " в то время как он уже остановлен");
				}
				//
				var bResult = !this.IsRunning();
				if (bResult) {
					Logger().Info("Успешно остановили " + this.sNameForLog);
				} else {
					Logger().Warning("Не удалось остановить " + this.sNameForLog + " за отведенное время (" + iTimeout + " мс)");
				}
				//
				return bResult;
			} finally {
				this.FinishStartOrStop();
			}
		} else {
			throw "Уже проводится какая-то операция управления " + this.sNameForLog + ".";
		}
	}

	// Метод перезапускает продукт
	this.Restart = function(
		iTimeout, // время в течение которого ждем остановки продукта
		oHandler // экземпляр класса, унаследованного от RestartHandlerBase
	)
	{
		if (TreatAsNum(iTimeout) == null) throw "iTimeout должен быть числом!";
		if (typeof(oHandler) != "object") oHandler = null;
		//
		if ( this.BeginStartOrStop() )
		{
			Logger().Info("Перезапускаем " + this.sNameForLog);
			try {
				var bStartSuccess = false;
				var bStopSuccess = false;

				// вызываем обработчик события "перед остановкой"
				if (oHandler != null)
					oHandler.OnStopBegin();
				// останавливаем сервер
				bStopSuccess = this.Stop(iTimeout);
				// вызываем обработчик событий "после остановки" с результатом остановки
				if (oHandler != null)
					oHandler.OnStopEnd(bStopSuccess);
				// если сервер остановился то запускаем его
				if (bStopSuccess)
				{
					// вызываем обработчик события "перед запуском"
					if (oHandler != null)
						oHandler.OnStartBegin();
					// запускаем продукт
					bStartSuccess = this.Start();
					// вызываем обработчик событий "после запуска" с результатом запуска
					if ( oHandler != null )
						oHandler.OnStartEnd(bStartSuccess);
				}
				//
				var bResult = bStopSuccess && bStartSuccess;
				if (bResult) {
					Logger().Info("Успешно перезапустили " + this.sNameForLog);
				} else {
					Logger().Warning("Не удалось перезапустить " + this.sNameForLog + " за отведенное время (" + iTimeout + " мс)");
				}
				//
				return bResult;
			} finally {
				this.FinishStartOrStop();
			}
		} else {
			throw "Уже проводится какая-то операция управления " + this.sNameForLog + ".";
		}
	}

	// Разрешает запуск/остановку только вызывающему "потоку"
	this.PermitStartOrStopOnlyForMe = function()
	{
		return this.pm_oCSStartOrStopPerformed.Enter(0);
	}

	// Разрешает/запуск остановку всем
	this.PermitStartOrStopForAll = function()
	{
		this.pm_oCSStartOrStopPerformed.Leave();
	}

	// скобка, которая должна быть вызвана при начале операций остановки, запуска, перезапуска сервера
	// Чтобы можно было синхронизировать работу нескольких перезапускалок
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

	// Метод говорит производится ли какая-нибудь операция контроля над сервером
	this.IsStartingOrStopping = function()
	{
		return this.pm_oUCStartOrStopPerformed.IsUsing();
	}

	// ------- Абстрактные методы --------

	// Метод говорит запущен ли продукт. Возвращает true или false
	this.IsRunning = function()
	{
		throw "Must be implemented!";
	}

	// Метод запускает продукт
	this.pm_Start = function()
	{
		throw "Must be implemented!";
	}

	// Метод останавливает продукт
	this.pm_Stop = function(
		iTimeout, // в течение этого времени (в миллисекундах) будем ждать нормальной остановки
		isKill // убивать продукт если он не остановился в течение заданного времени (по-умолчанию: true)
	)
	{
		throw "Must be implemented!";
	}
}

// Класс управляющий сервером
function F1Server(
	sForcedRegSubPath, // подпуть в реестре. Если задан, то используем его, если нет - то определяем автоматом (но сработает только для обычной КС-версии)
	sForcedServiceName, // имя сервиса сервера. Если задан, то используем его, если нет - то определяем автоматом (но сработает только для обычной КС-версии)
	bIs64BitServer // 64-битный сервер, по-умолчанию false
)
{
	// вызываем родительский конструктор
	ManageableProduct.apply(this, ["f1server", "Cервер ГАРАНТ"]);

	// подпуть в реестре
	this.pm_sRegSubPath = TreatAsStr(sForcedRegSubPath, "");
	// имя сервиса
	this.pm_sServiceName = TreatAsStr(sForcedServiceName, "");
	// признак 64-битности сервера
	this.pm_bIs64BitServer = TreatAsBool(bIs64BitServer, false);
	if ( (!Is64bitWindows()) && this.pm_bIs64BitServer ) {
		throw "Нельзя управлять 64-и разрядным сервером на 32-х разрядной ОС!";
	}

	// запускать ли сервер только как сервис (true), или попытаться автоматически (есть сервис, разрешенный к запуску - запускаем как сервим, нет - как обычный процесс)
	this.isForceStartAsService = false;

	// Метод возвращает полный путь к папке с сервером. Берет его из реестра.
	this.pm_GetPathToServerFolder = function()
	{
		// Определяем какой ключ реестра читать
		var sRegPath = "";
		if (Is64bitWindows() && !this.pm_bIs64BitServer) {
			sRegPath = "HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\";
		} else {
			sRegPath = "HKEY_LOCAL_MACHINE\\SOFTWARE\\";
		}
		if (this.pm_sRegSubPath != "") {
			// подпуть в реестре задан явно
			sRegPath += this.pm_sRegSubPath;
		} else {
			// подпуть не задан, используем стандартное значение для КС-версии
			sRegPath += "Garant.F1";
		}
		sRegPath += "\\ApplicationServerOptions";
		// Читаем его значение
		var sKeyValue = "";
		try {
			sKeyValue = WshShell().RegRead(sRegPath);
		} catch (oEx) {
			sKeyValue = "";
		}
		// Вычленяем путь
		var sResult = "";
		var oRExp = /GCMConfigFile \"(.*)\\garant\.ini\"/i;
		var arrRes = sKeyValue.match(oRExp);
		if (arrRes != null)
			sResult = arrRes[1];
		return sResult;
	}

	// Метод возвращает полный путь к ini-файлу сервера. Берет его из реестра.
	this.GetPathToINIFile = function()
	{
		var sResult = this.pm_GetPathToServerFolder();
		if (sResult != "") {
			sResult += "\\garant.ini";
		}
		return sResult;
	}

	// Отдает объект ини-файла, каждый раз грузит заново, т.к. а вдруг что поменялось
	this.pm_MakeFreshINIFile = function()
	{
		var oIniFile = new IniMan( this.GetPathToINIFile() );
		oIniFile.Load();
		return oIniFile;
	}

	// Метод возвращает значение из ini-файла сервера. Если значения не найдено то возвращает null.
	this.GetValueFromGarantINI = function(
		sSectionName, // имя секции (без квадратных скобок)
		sParamName // имя параметра
	)
	{
		return this.pm_MakeFreshINIFile().GetAsStr(sSectionName, sParamName, null);
	}
		
	// Метод возвращает индекс пути к базе данных
	this.pm_GetDataPath = function(
		isActiveDB // возвращать индекс активной (true) или неактивной базы (false)
	) 
	{	
		isActiveDB = TreatAsBool(isActiveDB, true);
		//
		var sDP = null;
		try {
			sDP = this.GetValueFromGarantINI("F1Server Params", "-GCMActiveDataPath");
		} catch (oEx) {
			Logger().Error("Не удалось получить параметр -GCMActiveDataPath из секции F1Server Params");
			Logger().Exception(oEx);
			throw oEx;
		}
		//
		if ((sDP != "1") && (sDP != "2"))
		{
			Logger().Error("Значение параметра неизвестно: " + sDP);
			throw "Невозможное значение параметра!";
		}
		//
		if (isActiveDB) 
			return sDP/1; // в число
		else	
			return sDP ^ 3; // 2 -> 1, 1 -> 2
	}

	// Меняет в ини-файле значение параметра -GCMActiveDataPath
	this.SwitchDataBaseInINIFile = function()
	{
		var oIniFile = this.pm_MakeFreshINIFile();
		// на всякий случай делаем бэкап ини-файла
		try {
			FSO().CopyFile(oIniFile.GetPathToINI(), oIniFile.GetPathToINI() + ".backuped_by_serverwatcher", true);
		} catch(oEx) {
			Logger().Error("Не удалось сделать бэкап ини-файла, и фиг с ним");
			Logger().Exception(oEx);
		}
		//
		oIniFile.Section("F1Server Params").Parameter("-GCMActiveDataPath").Set(this.pm_GetDataPath(false));
		//
		try {
			oIniFile.Save();
		} catch (oEx) {
			Logger().Error("Ошибка при сохранении измененного ini-файла в методе SwitchDataBaseInINIFile");
			Logger().Exception(oEx);
		}
	}
	
	// Метод возвращает путь к базе данных взятый из ини-файла
	this.GetPathToDB = function(
		isActiveDB // активная (true) или неактивная (false) база
	)
	{
		return this.GetValueFromGarantINI("F1Server Params", "-GCMDataPath" + this.pm_GetDataPath(isActiveDB));
	}
	

	// Метод возвращает полный путь к логу сервера.
	this.GetPathToLog = function()
	{
		var sPathToLog = this.GetValueFromGarantINI("F1Server Params", "-SBELogFile");
		if (sPathToLog != null) {
			WshShell().ExpandEnvironmentStrings(sPathToLog);
		}
		return sPathToLog;
	}

	// Метод возвращает объект Scripting::File для лога сервера. Если лога не существует или не можем его открыть то null
	this.GetLogFileObject = function()
	{
		var oResult = null;
		var sLogFilePath = this.GetPathToLog();
		//
		if ( FSO().FileExists(sLogFilePath) )
			try {
				oResult = FSO().GetFile(sLogFilePath);
			} catch (oEx) {
				Logger().Error("При открытии лога по пути " + sLogFilePath + " произошло исключение " + oEx.message);
				oResult = null;
			}
		//
		return oResult;

	}

	// Метод говорит включен ли в инишнике сервера параметр ORBDebugLevel
	this.IsORBDebugLevelON = function()
	{
		return (this.GetValueFromGarantINI("ORB Params", "-ORBDebugLevel") != null);
	}

	// Метод возвращает WMI-объект (Win32_Process) для процесса сервера (F1Server или GblPilotServer или garantServer) либо null если такой не найден
	this.pm_GetWMIProcessToServer = function()
	{
		var oResult = null;
		var arrProcNames = ["F1Server.exe", "garantServer.exe", "GblPilotServer.exe"];
		// перебираем возможные имена процесса
		for (iIdx in arrProcNames)
		{
			var sProcName = arrProcNames[iIdx];
			oResult = GetWMIObjectForProcess(sProcName);
			if (oResult != null) break;
		}
		return oResult;
	}
	
	// Возвращает PID сервера
	this.GetProcessID = function()
	{
		var oF1ServerWMIProc = this.pm_GetWMIProcessToServer();
		if (oF1ServerWMIProc != null)
			return oF1ServerWMIProc.ProcessID
		else
			return -1;
	}

	// ------ Реализация абстрактных методов ---------

	// Метод говорит запущен ли процесс сервера. Возвращает true или false
	this.IsRunning = function()
	{
		var oF1ServerWMIProc = this.pm_GetWMIProcessToServer();
		return (oF1ServerWMIProc != null);
	}

	// Метод останавливает сервер
	this.pm_Stop = function(
		iTimeout, // в течение этого времени (в миллисекундах) будем ждать нормальной остановки сервера
		isKill // убивать сервер если он не остановился в течение заданного времени (по-умолчанию: true)
	)
	{
		var isServerStopped = !this.IsRunning();
		// --- Пробуем остановить сервер по-нормальному ---
		var oF1SrvStopper = new F1SrvStopper( this.pm_GetPathToServerFolder() );
		var isSrvStopperAlwaysStarted = oF1SrvStopper.IsSrvStopperRunning();

		// Если утилита остановки сервера не запущена, то запускаем
		if ( !isSrvStopperAlwaysStarted ) {
			// Запускаем утилиту
			var iBegTime = CurrTimeStamp();
			oF1SrvStopper.Start(iTimeout/2);
			iTimeout -= (CurrTimeStamp() - iBegTime);
		} else { // иначе ругаемся
			Logger().Warning("Утилита остановки сервера уже кем-то запущена.");
		}

		// Ждем остановки сервера
		var iDeadLine = CurrTimeStamp() + iTimeout;
		while (iDeadLine > CurrTimeStamp())
		{
			isServerStopped = !this.IsRunning();
			if (isServerStopped) break;
			WScript.Sleep(300);
		}

		if (isServerStopped) {
			Logger().Info(this.sNameForLog + " корректно завершил свою работу в течение отведенного времени " + iTimeout + " мс");
		} else {
			Logger().Warning(this.sNameForLog + " не остановился в течении " + iTimeout + "мс");
		}

		// Теперь, если утилита остановки сервера запущена нами, то прибиваем ее если она еще работает
		if ( (!isSrvStopperAlwaysStarted) && oF1SrvStopper.IsSrvStopperRunning()) {
			Logger().Warning("Утилита остановки сервера все еще работает, хотя время отведенное на остановку сервера истекло!");
			oF1SrvStopper.Terminate();
		}

		// --- Убиваем сервер ---
		// если разрешено убить сервер то делаем это
		if ((!isServerStopped) && isKill)
		{
			// Убиваем процесс сервера
			Logger().Info("Так как процесс " + this.sNameForLog + " не смог корректно остановится принудительно завершаем его");
			var oF1ServerWMIProc = this.pm_GetWMIProcessToServer();
			TerminateWMIProcess(oF1ServerWMIProc);
			// Проверяем удалось ли нам это
			isServerStopped = !this.IsRunning();
			if (isServerStopped) {
				Logger().Info("Принудительное завершение работы " + this.sNameForLog + " прошло успешно");
			} else {
				Logger().Error("Не удалось принудительно завершить работу " + this.sNameForLog + "!");
			}
		}
	}

	// Метод запускает сервер. Если существует сервис и его режим запуска установлен в Auto, то запускаем именно его, в противном случае просто как процесс
	// В случае успешного запуска говорит true, иначе false
	this.pm_Start = function()
	{
		// Определяем имя сервиса
		var sSrvServiceName = "";
		if (this.pm_sServiceName != "") {
			// имя сервиса задано явно
			sSrvServiceName = this.pm_sServiceName;
		} else {
			// имя сервиса не задано, читаем его из настроек ПУПСа (работает только для КС-версии)
			sSrvServiceName = this.GetValueFromGarantINI("ServerManager", "-Services");
		}
		if (sSrvServiceName == "")
			throw "Имя сервиса не может быть пустым!";

		// Создаем WMI-объект для сервиса
		var oSrvService = GetWMIObjectForService(sSrvServiceName);

		// Определяем как будем запускать
		var isRunAsService = false;
		if (this.isForceStartAsService)
			isRunAsService = true;
		else
			isRunAsService = ((oSrvService != null) && (oSrvService.StartMode == "Auto"));

		// ----- Запускаем -----
		if (isRunAsService)
		{ // запускаем как сервис
			if (oSrvService != null) {
				StartService(oSrvService, 30000);
			} else  {
				Logger().Error("Сервис не найден");
			}
		}
		else
		{ // запускаем как обычный процесс
			Logger().Info(this.sNameForLog + " будет запущен как обычный процесс.");
			// Определяем где лежит сервер
			var csExeName = "F1Server.exe";
			var sPathToExe = this.pm_GetPathToServerFolder() + "\\apps\\" + (this.pm_bIs64BitServer ? "win64" : "winNT") + "\\" + csExeName;
			if ( FSO().FileExists(sPathToExe) ) {
				// Запускаем
				ExecEx(sPathToExe, "-d");
				// Ждем запуска
				var iTimeout = 30000;
				var iDeadLine = CurrTimeStamp() + iTimeout;
				while (iDeadLine > CurrTimeStamp())
				{
					if (this.IsRunning()) break;
					WScript.Sleep(300);
				}

				if (this.IsRunning()) {
					Logger().Info(this.sNameForLog + " успешно запущен!");
				} else	{
					Logger().Warning("В течение " + iTimeout + " мс не дождались запуска процесса " + this.sNameForLog + "!");
				}
			} else {
				Logger().Error("exe-файл " + this.sNameForLog + " не найден по пути " + sPathToExe);
			}
		}
	}
}

// служебный класс, чисто для наследования
function _PortUsingClass(
	iHTTPPort, // порт hhtp-сервера
	iF1ServerPort // порт сервера f1
)
{
	this.pm_iHTTPPort = TreatAsNum(iHTTPPort, 0);
	this.pm_iF1ServerPort = TreatAsNum(iF1ServerPort, 0);
	if ((this.pm_iHTTPPort == 0) || (this.pm_iF1ServerPort == 0)) {
		throw "iHTTPPort или iF1ServerPort должны быть заданы";
	}
}

// Класс управляющий web-сервером интранета
function IntranetWebServer(
	iHTTPPort, // порт hhtp-сервера
	iF1ServerPort // порт сервера f1
)
{
	// вызываем родительский конструктор
	_PortUsingClass.apply(this, [iHTTPPort, iF1ServerPort]);
	ManageableProduct.apply(this, ["intranet_web_server", "Web-сервер ГАРАНТ-Интранет"]);


	// имя сервиса web-сервера
	this.pm_sWebServiceName = "Garant Intranet Web " + this.pm_iF1ServerPort +  ":" + this.pm_iHTTPPort;
	if (GetWMIObjectForService(this.pm_sWebServiceName) == null) {
		throw "Сервис " + this.pm_sWebServiceName + " не найден";
	}

	// Возвращает WMI-объект Win32_Service для сервиса web-сервера
	this.pm_GetWMIObjectForWebService = function()
	{
		return GetWMIObjectForService(this.pm_sWebServiceName);
	}

	// ------ Реализация абстрактных методов ---------

	// Метод говорит запущен ли web-сервер интранета. Возвращает true или false
	this.IsRunning = function()
	{
		return this.pm_GetWMIObjectForWebService().State == "Running";
	}

	// Метод останавливает web-сервер интранета. Если по окончании работы функции не запущен то возвращает true, иначе - false.
	this.pm_Stop = function(
		iTimeout, // в течение этого времени (в миллисекундах) будем ждать нормальной остановки интранета
		isKill // убивать интранет если он не остановился в течение заданного времени (по-умолчанию: true)
	)
	{
		var oService = this.pm_GetWMIObjectForWebService();
		// запоминаем PID
		var iPID = oService.ProcessId;
		// пытаемся корректно остановить сервер
		if ( StopService(oService, iTimeout) ) {
			// удалось
			Logger().Info("Успешно остановили сервис \"" + oService.Name + "\"");
		} else {
			// сервис не остановился за заданное время
			Logger().Error("Не удалось остановить сервис \"" + oService.Name + "\". Сервис находится в состоянии " + GetRefreshedWMIObject(oService).State + ". Попытаемся его убить");

			// попытаемся убить дерево процесса сервиса
			var oProc = GetWMIObjectForProcess("", iPID);
			if (oProc != null) {
				if (TerminateWMIProcessTree(oProc, iTimeout)) {
					Logger().Info("Успешно убили дерево процессов для сервиса \"" + oService.Name + "\"");
				} else {
					Logger().Error("Не удалось убить дерево процессов для сервиса \"" + oService.Name + "\"");
				}
			} else {
				Logger().Warning("Странно, но процесс сервиса не найден. Тогда убьем дочерние процессы, они могут быть живы.");
				// убиваем дочерние процессы
				if (TerminateChildsProcess(iPID, iTimeout)) {
					Logger().Info("Успешно убили дочерние процессы для сервиса \"" + oService.Name + "\"");
				} else {
					Logger().Error("Не удалось убить дочерние процессы для сервиса \"" + oService.Name + "\"");
				}
			}
		}
	}

	// Метод запускает web-сервер интранета. В случае успешного запуска говорит true, иначе false
	this.pm_Start = function()
	{
		var oService = this.pm_GetWMIObjectForWebService();
		// запускаем сервер штатным способом
		StartService(oService, 30000);
	}
}

// Класс управляющий интранетом
function Intranet(
	iHTTPPort, // порт hhtp-сервера
	iF1ServerPort, // порт сервера f1
	bIs64BitServer // 64-битность f1
)
{
	// вызываем родительский конструктор
	_PortUsingClass.apply(this, [iHTTPPort, iF1ServerPort]);
	ManageableProduct.apply(this, ["intranet", "ГАРАНТ-Интранет"]);


	// имя сервиса сервера f1
	this.pm_sDataServiceName = "Garant Intranet Data " + this.pm_iF1ServerPort +  ":" + this.pm_iHTTPPort;
	if (GetWMIObjectForService(this.pm_sDataServiceName) == null) {
		throw "Сервис " + this.pm_sDataServiceName + " не найден";
	}
	// подпуть в реестре для сервера f1
	this.pm_sF1ServerRegSubPath = this.pm_sDataServiceName;

	// объект для управления сервером F1. Public.
	this.oF1Server = new F1Server(this.pm_sF1ServerRegSubPath, this.pm_sDataServiceName);
	this.oF1Server.isForceStartAsService = true;

	// объект для управления web-сервером
	this.pm_oWebServer = new IntranetWebServer(this.pm_iHTTPPort, this.pm_iF1ServerPort, bIs64BitServer);

	// ------ Перекрытие унаследованных методов -------

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

	// ------ Реализация абстрактных методов ---------

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
		// сначала останавливаем web-сервер, затем сервер f1
		return this.pm_oWebServer.Stop(iTimeout, isKill) && this.oF1Server.Stop(iTimeout, isKill);
	}

	//
	this.pm_Start = function()
	{
		// сначала запускаем сервер f1, затем web-сервер,
		return this.oF1Server.Start() && this.pm_oWebServer.Start();
	}
}

// Класс, конструирующий объекты управления и сервера по данным ини-файла
function INIControlledObjectCreator()
{
	// Контролируемый объект
	this.oManageableProduct = null; // инициализируем потом
	// Объект для контроля за сервером F1
	this.oF1Server = null; // инициализируем потом
	//

	try {
		if (IS_MUST_CONTROL_INTRANET)
		{ // собираемся работать с интранетом
			// проверяем что порты заданы
			if ((INTRANET_WEB_SERVER_PORT == -1) || (INTRANET_DATA_SERVER_PORT == -1)) {
				var sErr = "Должны быть заданы порт web-сервера и сервера данных!";
				Logger().Error(sErr);
				throw sErr;
			}

			// создаем объект для управления интранетом
			this.oManageableProduct = new Intranet(INTRANET_WEB_SERVER_PORT, INTRANET_DATA_SERVER_PORT, IS_64_BIT_SERVER);

			// инициализируем объект F1Server
			this.oF1Server = this.oManageableProduct.oF1Server;
		}
		else
		{ // собираемся работать с сервером F1
			// здесь все просто
			this.oManageableProduct = new F1Server("", "", IS_64_BIT_SERVER);
			this.oF1Server = this.oManageableProduct;
		}
	} catch (oEx) {
		Logger().Exception(oEx);
		Logger().Error("Ошибка при создании Intranet");
		throw oEx;
	}


	if ((this.oManageableProduct == null) || (this.oF1Server == null) )
		throw "Объекты не инициализированы!";
}

// Константы означающие найденные ошибки. ES - Error Status
var
	ES_OK = 0; // все хорошо
	ES_CRITICAL_ERROR = 1; // найдены критические ошибки
	ES_SERVER_HANGUP = 2; // сервер повис
	ES_ERROR = 4; // найдены простые ошибки
	ES_F1BU_DB_SWITCH_HANGUP = 5; // переключение баз с помощью F1BU не завершилось за отведенное время

// Константы, означающие событие, связанное с обновлением баз, обнаруженное по логу сервера. US - Update Status
var
	US_NO_INFO = 0; // ничего нельзя сказать про обновление
	US_UPDATE_STARTED = 1; // началось обновление
	US_BASE_UPDATED = 2; // база обновилась (но это не означает что сервер на нее переключился и переключится)
	US_NEW_DB_OPENED = 4; // сервер открыл новую базу и переключил инишник на нее
	US_UPDATE_FINISHED = 8; // процесс обновление завершен, неважно как и с каким результатом, главное его нет
	US_OPEN_NEW_DВ_FAILED = 16; // серверу не удалось открыть новую базу
	US_OPEN_OLD_DB_FAILED = 32; // серверу не удалось открыть старую базу

// Класс реализующий слежение за логом сервера и перезагрузку его в случае зависания, наличия в логе критических ошибок и отсылку на заданный e-mail сообщений о некритических ошибках
function Watcher()
{
	// если в течение этого времени не менялся лог, то считаем что сервер повис. Если -1 то проверка на это не выполняется
	this.pm_ciHangupTimeout = SERVER_HANGUP_TIMEOUT;
	// в течение этого времени будем ждать корректной остановки сервера при перезагрузке
	this.pm_ciServerStopTimeout = SERVER_STOP_TIMEOUT;
	// этот адрес будет ставится в поле From при посылке почтовых сообщений
	this.pm_csFromEMail = FROM_EMAIL;
	// на этот адрес будут высыласть сообщения о перезапуске сервера. Если пусто то ничего не посылается
	this.pm_csToEmailServerRestart = TO_EMAIL_SERVER_RESTART;
	// на этот адрем будут высылаться сообщения о том что в логе сервера найдены ошибки. Если пусто то ничего не посылается.
	this.pm_csToEmailErrors = TO_EMAIL_ERRORS;
	// Можно ли перезагружать сервер автоматически. Если нет - то постим email о факте ошибки
	this.pm_bIsCanRestartServer = IS_CAN_RESTART_SERVER;
	//
	this.pm_bIsKillF1UtilitiesOnServerRestart = IS_KILL_F1_UTILITIES_ON_SERVER_RESTART;
	
	// на этот адрес будем высылать логи vmmap
	this.pm_csToEmailVMMap = TO_EMAIL_VMMAP;

	// максимальное время (мс), которое может длиться одна проверка (ограничиваем, чтобы если вдруг лог будет очень быстро расти не проверять вечно)
	this.pm_ciMinTimeForOneCheck = 10000; // 10 секунд
	// если размер лог-файла превышает этот размер, то не будем его открывать
	this.pm_ciMaxInitialLogSize = -1;  // нет ограничения
	// можно ли использовать лог-файл для проверки
	this.pm_bIsUseLogFile = IS_USE_LOG_FILE;
	
	// время в течение которого должна переключиться база, если она переключается с помощью F1BU
	this.pm_ciF1BUDBSwitchTimeout = F1BU_DB_SWITCH_TIMEOUT;
	// признак того что переключение баз инициировано с помощью F1BU
	this.pm_bIsDBSwitchingWithF1BU = false;
	// срок давности запуска F1BU когда он еще считается начавшим переключение баз (если работает дольше, то не учитываем, чтобы не реагировать на возможно повисший)
	this.pm_ciF1BULimitationPeriod = 10*60*1000; // 10 минут
	// признак того что зависание F1BU при переключении баз уже обнаружено
	this.pm_bIsF1BUDBSwitchHangupDetected = false;
	

	// счетчик для предотвращения двукратного запуска
	this.pm_oUseGuard = new UseCounter("f1server.watcher.run");
	// событие для сигнализации необходимости выхода
	this.pm_oNeedExitEvent = new Event("f1server.watcher.need_exit", false);
	// объект Fso::File для лога сервера
	this.pm_oLogFile = null;
	// oбъект FSO::TextStream для лога сервера
	this.pm_oLogFileTS = null;
	// последняя прочитанная из лога сервера строка
	this.pm_sLastLine = "";
	// время, когда была прочитана последняя строка из лога сервера
	this.pm_tLastLineTimestamp = 0;
	
	this.pm_csAssertDetectorCmdFile = GetPathTo(PT_SCRIPT_FOLDER) + "\\ad_cmd";
	//
	this.pm_csAssertDetectorResFile = GetPathTo(PT_SCRIPT_FOLDER) + "\\ad_res";
	//
	this.pm_iProcessIDForAssertDetector = 0;
	// строки с хэндлами окон ассертов
	this.pm_arrAssertHandles = new Array();
	// проверять ли наличие ассертов
	this.pm_bIsDetectAsserts = IS_DETECT_ASSERTS;
	// проверять ли наличие брейкпоинтов
	this.pm_bIsWatchForDebuggerBreakpoints = IS_WATCH_FOR_DEBUGGER_BREAKPOINTS;
	//
	this.pm_csBreakpointFilePath = GetPathTo(PT_DEBUGGER_BREAKPOINT_FILE);

	// флаг, означающий обнаружили ли мы ситуацию зависания сервера с помощью слежения за логом. Нужно, чтобы утилита не билась в истерике "сервер повис! сервер повис!", когда он повис а перегружать его запрещено
	this.pm_bIsLLHangupDetected = false;
	// флаг, означающий, обнаружили ли мы ситуацию зависания сервера с помощью специальной утилиты.
	this.pm_bIsSCHangupDetected = false;

	// время последнего запуска утилиты проверки сервера
	this.pm_tF1SCTimestamp = 0;
	// задержка проверки сервера после начала пррверки. Нужно, чтобы избежать ситуации неверного определения зависания сервера на долго стартующем сервере
	this.pm_tF1SCCheckDelay = 5*60*1000;
	// через это время будет запускаться проверялка сервера
	this.pm_tF1SCStartInterval = F1SERVER_CHECKER_START_INTERVAL;
	// ечли в течение этого времени утилита проверки сервера не отработает, то будем считать что сервер повис
	this.pm_tF1SCRunTimeout = F1SERVER_CHECKER_RUN_TIMEOUT;

	// если нельзя проверять то столько времени ждем перед следующей проверкой на возможность проверки
	this.pm_ciWaitTimeIfCanNotCheck = 5000; // 5 секунд
	// столько времени ждем выхода, после того как его начали
	this.pm_ciWaitTimeForExit = (this.pm_ciWaitTimeIfCanNotCheck + this.pm_ciMinTimeForOneCheck + this.pm_tF1SCRunTimeout)*2;

	// массив строк из лога сервера содержащих найденные критические ошибки (ошибки при которой сервер должен быть перезагружен) за последний проход
	this.pm_arrCriticalErrorLines = new Array();
	// массив строк с ошибками найденных за последний проход
	this.pm_arrErrorLines = new Array();
	
	// массив последних прочитанных из лога строк
	this.pm_arrLastLines = new Array();
	// максимальное количество сохраняемы последних строк из лога
	this.pm_cMaxLastLines = 200;

	// регулярное выражения для определения, является ли строка из лога сервера критической ошибкой. Если null то проверка не выполняется
	this.pm_oRExpCriticalError = new RegExp(
		"-LM_ERROR:.*The End of Memory",
		"i");	
	// регулярное выражение для определения, является ли строка лога из сервера ошибкой. Если null то проверка не выполняется
	this.pm_oRExpError = new RegExp(
		"UNKNOWN_EX:|LM_ERROR|LM_ALERT|STD_EX|Base pool:|CORBA_EX:",
		"i");
	// регулярное выражение для определения, является ли строка лога из сервера не ошибкой. Если null то проверка не выполняется
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

	// статус ошибки, с момента последней проверки
	this.pm_iErrorStatus = ES_OK;
	// статус обновления баз, на момент последней проверки
	this.pm_iUpdateStatus = US_NO_INFO;

	// регулярное выражение для определения ситуации начала обновления
	this.pm_oRExpUpdateStarted = new RegExp("-LM_GARANT: UPDATE_START", "i");
	// регулярное выражение для определения момента успешного обновления базы (но не процесса обновления!)
	this.pm_oRExpBaseUpdated = new RegExp("-LM_INFO: BaseUpdate: data.org update complete", "i");
	// регулярное выражения для определения неудачи открытия новой базы
	this.pm_oRExpOpenNewDBFailed = new RegExp("-LM_INFO: BaseUpdate: open new datastore failed", "i");
	// регулярное выражения для определения неудачи открытия старой базы
	this.pm_oRExpOpenOldDBFailed = new RegExp("-LM_INFO: BaseUpdate: open old datastore failed", "i");	
	// регулярное выражение для определения момента переключения сервера на новую базу
	this.pm_oRExpNewDBOpened = new RegExp("-LM_INFO: BaseUpdate_i::swap_dirs: update .ini file complete", "i");
	// регулярное выражение для определения момента окончания обновления (неважно с каким результатом)
	this.pm_oRExpUpdateFinished = new RegExp(
		"-LM_ERROR: BaseUpdate_i::update_complete: update failed" +
		"|-LM_GARANT:\\s*(?:UPDATE_FINISH|UPDATE_FAILED|UPDATE_CANCEL)",
		"i");
	
	//
	this.pm_bIsOpenNewDBFailed = false;
				
	// нужно ли перезапускать продукт
	this.pm_bIsRestartProduct = false;
	// причина перезапуска продукта
	this.pm_sRestartCause = "";
	// игнорировать ли критические ошибки (на период обновления базы)
	this.pm_bIsIgnoreCriticalErrorsWhileDBUpdate = false;
		
	// признак того, что запуск/останов сервера разрешен только текущему "потоку"
	this.pm_bIsSoSPermittedOnlyForMe = false;
	// нужно ли самим при перезапуске сервера переключать базы
	this.pm_bIsNeedManualDBSwitching = false;
	// следить ли за обновление баз данных в логе сервера
	this.pm_bIsWatchForDBUpdateInLog = true;

	// интервал, через который пишутся в лог keepalive
	this.pm_tKeepAliveInterval = 30*60*1000;
	// время последнего keepalive
	this.pm_tKeepAliveLastTimestamp = 0;

	//
	var pm_INICOC = new INIControlledObjectCreator();
	// экземпляр объекта типа F1Server для управления сервером
	this.pm_oF1Server = pm_INICOC.oF1Server;
	// экземпляр контролируемого объекта
	this.pm_oManageableProduct = pm_INICOC.oManageableProduct;

	// открыт ли лог-файл
	this.pm_bIsLogOpened = false;
	// размер лог-файла. Нужен для определения пересоздания лога при ео бэкапе
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
			var sLinesFilePath = GetTempDirForSyncOps() + "\\фрагмент лога перед ошибкой.txt";
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
			Logger().Error("Ошибка при выполнении pm_WriteLogLineForSendingWithVMMapLogToFile");
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
			// создаем vmmmap лог
			var sVMMapLogFileName = GetTempDirForSyncOps() + "\\vmmap_log_" + CurrTimeStamp().toString() + ".mmp";
			var sVMMapParams = "-accepteula -p " + this.pm_oF1Server.GetProcessID() + " \"" + sVMMapLogFileName + "\"";			
			Logger().Info("Запускаем VMMap по пути \"" + GetPathTo(PT_VMMAP) + "\" c параметрами " + sVMMapParams);
			var oWshScriptExec = ExecEx(GetPathTo(PT_VMMAP), sVMMapParams);			
			// ждем пока отработает
			var iDeadLine = CurrTimeStamp() + 30000;
			while (iDeadLine > CurrTimeStamp())
				if (oWshScriptExec.Status == WSH_FINISHED)
					break;
				else
					WScript.Sleep(500);
			// таймаут истек, убиваем, если висит
			if (oWshScriptExec.Status != WSH_FINISHED) {				
				oWshScriptExec.Terminate(); 
				Logger().Error("VMMap не отработал за отведенное время!");
				return;
			}
			
			// если файл есть, то отправляем
			if (FSO().FileExists(sVMMapLogFileName)) 
			{		
				Logger().Info("Найден лог VMMap по пути \"" + sVMMapLogFileName + "\"");
			
				// выливаем в файл последние строки из лога
				var sLinesFilePath = this.pm_WriteLogLineForSendingWithVMMapLogToFile();
				
				SendMail(
					this.pm_csFromEMail, this.pm_csToEmailVMMap, "Лог VMMap с машины " + CompName(),
					this.pm_GenerateHTMLDocWithErrors(), [sVMMapLogFileName, sLinesFilePath]
				);
				//FSO().DeleteFile(sVMMapLogFileName);				
			} else {
				Logger().Error("Нету лога VMMap по пути \"" + sVMMapLogFileName + "\"");
			}
									
			
		} catch (oEx) {
			Logger().Error("Ошибка при выполнении pm_DoVMMapLog");
			Logger().Exception(oEx);
		}
	}

	// Метод открывает лог сервера и позиционируется на последнюю строку. Если удалось говорим true, иначе false.
	this.pm_OpenLogFile = function(
		isWaitForLogFile // ждать ли создания лог-файла в случае если он изначалбно отсутствует (по-умолчанию false)
	)
	{
		if (this.pm_bIsUseLogFile)
		{
			isWaitForLogFile = TreatAsBool(isWaitForLogFile, false);
			//
			if (!this.pm_bIsLogOpened)
			{
				var sLogFilePath = this.pm_oF1Server.GetPathToLog();
				// Проверяем существование файла и  ждем его создания если сказано
				while (!FSO().FileExists(sLogFilePath))
				{
					if (!isWaitForLogFile) {
						// Файла нет и ждать его нельзя - выходим
						Logger().Warning("Лог-файл не найден по пути " + sLogFilePath);
						this.pm_bIsLogOpened = false;
						return this.pm_bIsLogOpened;
					}
					WScript.Sleep(1000);
				}

				// Открываем файл
				this.pm_oLogFile = this.pm_oF1Server.GetLogFileObject();
				if (this.pm_oLogFile != null) {
					try	 {
						Logger().Info("Открываем лог-файл");
						this.pm_oLogFileTS = QCComponentsFactory().MakeQCTextStream(this.pm_oLogFile.Path, FOR_READING, false);
					} catch (oEx) {
						Logger().Error("Ошибка при открытии лог-файла");
						Logger().Exception(oEx);
						throw oEx;
					}
					Logger().Info("Успешно открыли лог-файл");
					// Позиционируемся в конец файла
					this.pm_oLogFileTS.Skip(this.pm_oLogFile.Size);
					//
					this.pm_tLastLineTimestamp = CurrTimeStamp();
					this.pm_iCurrLogSize = this.pm_oLogFile.Size;
					this.pm_bIsLogOpened = true;
				} else {
					Logger().Error("Лог-файл вроде бы существует, но почему-то не открыт!");
				}
			}
		}
		return this.pm_bIsLogOpened;
	}

	// Метод проверяет, должен ли быть переоткрыт лог-файл (например, если его размер изменился после бэкапа лога). Вызываться должна только при открытом логе.
	this.pm_IsMustReOpenLogFile = function()
	{
		if (this.pm_bIsUseLogFile) {
			var iOldLogSize = this.pm_iCurrLogSize;
			this.pm_iCurrLogSize = this.pm_oLogFile.Size;
			// Если размер файла уменьшился относительно предыдущей проверки, то считаем что лог надо переоткрыть
			return (this.pm_iCurrLogSize < iOldLogSize);
		} else {
			return false;
		}
	}

	// Метод закрывает лог-файл
	this.pm_CloseLogFile = function()
	{
		if (this.pm_bIsUseLogFile && this.pm_bIsLogOpened) {
			this.pm_oLogFile = null;
			this.pm_oLogFileTS.Close();
			this.pm_oLogFileTS = null;
			this.pm_bIsLogOpened = false;
			Logger().Info("Закрыли лог-файл");
		}
	}

	// Метод проверяет можно ли прозводить проверку. Да - true, иначе - false.
	// Проверяется запущен ли сервер, не перезапускается ли он, соответствует ли лог заданным ограничениям
	this.pm_IsCanDoNextCheck = function()
	{
		var bResult = false;
		// В начале проверяем, запущен ли продукт. Если нет, то и проверять нечего.
		bResult = this.pm_oManageableProduct.IsRunning();
		// Если продукт останавливается или запускается тоже нельзя проверять
		bResult = bResult && ( !this.pm_oManageableProduct.IsStartingOrStopping() );

		// Если лог еще не открыт и его можно использовать
		if ( bResult && this.pm_bIsUseLogFile  && !this.pm_bIsLogOpened )
		{
			// Проверяем что лог доступен и его размер не больше чем можно
			var oLogFile = this.pm_oF1Server.GetLogFileObject();
			bResult = bResult && (oLogFile != null); // && ((this.pm_ciMaxInitialLogSize == -1) || (oLogFile.Size <= this.pm_ciMaxInitialLogSize)) );
		}
		return bResult;
	}

	// Метод выполняет проверку на наличие ошибок c помощью утилиты F1ServerChecker
	this.pm_DoNextCheckWithF1SC = function()
	{
		// проверяем, можно ли залогиниться на сервер
		if ( 	(this.pm_tF1SCStartInterval != -1) // если можно проверять
			&&	(this.pm_tF1SCTimestamp + this.pm_tF1SCStartInterval < CurrTimeStamp()) ) // и если подошло время очередного запуска
		{ // можно проверять
			var sPathToF1ServerChecker = GetPathTo(PT_F1SERVER_CHECKER);
			if ( !FSO().FileExists(sPathToF1ServerChecker) )
			{
				Logger().Warning("F1ServerChecker не найден по пути " + sPathToF1ServerChecker);
				return;
			}
			//
			var oF1ServerChecker = new F1ServerChecker(
				sPathToF1ServerChecker,
				INIFile().GetPathToINI(),
				this.pm_oF1Server.GetPathToINIFile()
			);
			// проверяем
			Logger().Info("Запускаем утилиту проверки сервера");
			var bCheckResult = oF1ServerChecker.RunChecker(this.pm_tF1SCRunTimeout);
			var iExitCode = oF1ServerChecker.GetExitCode();
			Logger().Info("Результат проверки: " + bCheckResult + ". Код выхода: " + iExitCode);
			this.pm_tF1SCTimestamp = CurrTimeStamp();
			//
			if ( !bCheckResult ) {  // утилита не отработала за отведенное время - считаем что сервер висит
				// выставляем флаг зависания только в том случае если это не ранее обнаруженное зависание
				if ( (!this.pm_bIsLLHangupDetected) && (!this.pm_bIsSCHangupDetected) ) {
					this.pm_iErrorStatus |= ES_SERVER_HANGUP;
					this.pm_bIsSCHangupDetected = true;
				}
			} else { // все ОК
				this.pm_bIsSCHangupDetected = false; // снимаем флаг зависания
			}
			// а если отработала, это еще ничего не значит, возможно что просто неправильный логин/пароль и т.д. и т.п.
		}
	}

	// Метод проверяет, является ли текущая строка лога ошибкой и выставляет статус
	this.pm_CheckLastLogLineForError = function()
	{
		// проверяем является ли эта строка критической ошибкой
		if ( (this.pm_oRExpCriticalError != null) && (this.pm_oRExpCriticalError.test(this.pm_sLastLine)) )
		{
			this.pm_arrCriticalErrorLines.push(this.pm_sLastLine);
			this.pm_iErrorStatus |= ES_CRITICAL_ERROR;
			@if(@DEBUG)
				DebugInfo(this.pm_sLastLine + " классифицирована как ES_CRITICAL_ERROR");
			@end
		}

		// проверяем является ли строка простой ошибкой
		if(    ((this.pm_oRExpError != null) && (this.pm_oRExpError.test(this.pm_sLastLine)))
			&& ( ((this.pm_oRExpNotError != null) && (!this.pm_oRExpNotError.test(this.pm_sLastLine))) || (this.pm_oRExpNotError == null) )
		  )
		{
			this.pm_arrErrorLines.push(this.pm_sLastLine);
			this.pm_iErrorStatus |= ES_ERROR;
			@if(@DEBUG)
				DebugInfo(this.pm_sLastLine + " классифицирована как ES_ERROR");
			@end
		}
	}

	// Проверяет строку лога на предмет несет ли она нужную нам информацию об обновлении баз
	this.pm_CheckLastLogLineForUpdate = function()
	{
		if (this.pm_oRExpUpdateStarted.test(this.pm_sLastLine)) {
			this.pm_iUpdateStatus |= US_UPDATE_STARTED;
			@if(@DEBUG)
				DebugInfo(this.pm_sLastLine + " классифицирована как US_UPDATE_STARTED");
			@end
		}
		//
		if (this.pm_oRExpBaseUpdated.test(this.pm_sLastLine)) {
			this.pm_iUpdateStatus |= US_BASE_UPDATED;
			@if(@DEBUG)
				DebugInfo(this.pm_sLastLine + " классифицирована как US_BASE_UPDATED");
			@end
		}
		//		
		if (this.pm_oRExpOpenNewDBFailed.test(this.pm_sLastLine)) {
			this.pm_iUpdateStatus |= US_OPEN_NEW_DВ_FAILED;
			@if(@DEBUG)
				DebugInfo(this.pm_sLastLine + " классифицирована как US_OPEN_NEW_DВ_FAILED");
			@end
		}
		//		
		if (this.pm_oRExpOpenOldDBFailed.test(this.pm_sLastLine)) {
			this.pm_iUpdateStatus |= US_OPEN_OLD_DB_FAILED;
			@if(@DEBUG)
				DebugInfo(this.pm_sLastLine + " классифицирована как US_OPEN_OLD_DB_FAILED");
			@end
		}		
		//
		if (this.pm_oRExpNewDBOpened.test(this.pm_sLastLine)) {
			this.pm_iUpdateStatus |= US_NEW_DB_OPENED;
			@if(@DEBUG)
				DebugInfo(this.pm_sLastLine + " классифицирована как US_NEW_DB_OPENED");
			@end
		}
		//
		if (this.pm_oRExpUpdateFinished.test(this.pm_sLastLine)) {
			this.pm_iUpdateStatus |= US_UPDATE_FINISHED;
			@if(@DEBUG)
				DebugInfo(this.pm_sLastLine + " классифицирована как US_UPDATE_FINISHED");
			@end
		}
	}


	// Метод выполняет проверку на наличие ошибок в логе и прочие зависания. Функция по времени работает  this.pm_ciMinTimeForOneCheck мс
	this.pm_DoNextCheckWithLog = function()
	{
		try {
			this.pm_arrCriticalErrorLines = new Array();
			this.pm_arrErrorLines = new Array();

			// ==== В начале выполняем проверку на наличие ошибок ====
			var iDeadLine = CurrTimeStamp() + this.pm_ciMinTimeForOneCheck;
			var iBufSize = 128*1024;
			// работаем не больше заданного времени
			while (CurrTimeStamp() < iDeadLine)
				if (!this.pm_oLogFileTS.AtEndOfStream)
				{
					// читаем из файла не построчно а буфером, т.к. в кишках QCTextStream файл для каждого чтения открывается заново
					var sBuf = this.pm_oLogFileTS.Read(iBufSize) + this.pm_oLogFileTS.ReadLine();
					var arrLines = sBuf.split(END_OF_LINE);
					for (iLineIdx in arrLines)
					{
						var sLine = arrLines[iLineIdx];
						if (sLine.length > 0)
						{
							// получаем следующую строку из лога
							this.pm_bIsLLHangupDetected = false; // если что-то прочиталось, значит надо по новой детектить зависание сервера
							this.pm_sLastLine = sLine;
							this.pm_tLastLineTimestamp = CurrTimeStamp();
							
							this.pm_StoreLogLineForSendingWithVMMapLog(this.pm_sLastLine);

							// проверяем лог на ошибки
							this.pm_CheckLastLogLineForError();
							// проверяем лог на события свзанные с обновлением баз
							if (this.pm_bIsWatchForDBUpdateInLog) {
								this.pm_CheckLastLogLineForUpdate();
							}
						}
					}
				} else {
					WScript.Sleep(this.pm_ciMinTimeForOneCheck / 10);
				}

			// ===== Теперь проверяем, а не повис ли сервер =====
			// проверяем по обновлению лога
			if (this.pm_ciHangupTimeout != -1) {
				// Проверяем, прошло ли с момента чтения последней строки заданное время (т.е. она не менялась все это время)
				if ( (!this.pm_bIsSCHangupDetected) && (!this.pm_bIsLLHangupDetected) && ((CurrTimeStamp() - this.pm_tLastLineTimestamp) > this.pm_ciHangupTimeout)) {
					this.pm_iErrorStatus |= ES_SERVER_HANGUP;
					this.pm_bIsLLHangupDetected = true;
				}
			}
			
			// Проверяем, не повисло ли переключение баз с помощью F1BU
			if (this.pm_ciF1BUDBSwitchTimeout != -1) {
				// считаем что повисло, если признак переключения еще не сброшен, а F1BU работает больше заданного времени
				if ((!this.pm_bIsF1BUDBSwitchHangupDetected) && this.pm_bIsDBSwitchingWithF1BU && (this.pm_GetF1BURunningTime() > this.pm_ciF1BUDBSwitchTimeout)) {
					this.pm_iErrorStatus |= ES_F1BU_DB_SWITCH_HANGUP;
					this.pm_bIsF1BUDBSwitchHangupDetected = true;
					@if(@DEBUG)
						DebugInfo("Считаем что обнаружено зависание при переключении баз с помощью F1BU");	
					@end
				}
			}						
		} catch(oEx) {
			Logger().Error("Ошибка при выполнении метода pm_DoNextCheckWithLog");
			Logger().Exception(oEx);
			throw oEx;
		}	
	}

	// Метод генерирует HTML документ с таблице об ошибках. Если ошибок нет, то возвращает пустую строку.
	this.pm_GenerateHTMLDocWithErrors = function()
	{
		// функция генерирующая HTML-таблицу из массива строк с ошибками
		function _GenerateTableWithErrors(
			sTableTitle, // название таблицы
			oArrayWithErrors // массив строк с ошибками
		)
		{
			var oResult = new Object();
			var sTableClass = Math.round( Math.random()*1000000000 ).toString();
			// составляем таблицу
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

		// Обрабатываем ошибки
		var oErrorsTable = null;
		if (this.pm_arrErrorLines.length > 0) {
			var oErrorsTable = _GenerateTableWithErrors("Все ошибки", this.pm_arrErrorLines);
		}
		// Обрабатываем критические ошибки
		var oCriticalErrorsTable = null;
		if (this.pm_arrCriticalErrorLines.length > 0) {
			var oCriticalErrorsTable = _GenerateTableWithErrors("Критические ошибки", this.pm_arrCriticalErrorLines);
		}
		// Формируем документ
		var sResult =	"";
		if ((oErrorsTable != null) || (oCriticalErrorsTable != null))
		{
			var sLogFileBlock = "";
			try {
				sLogFileBlock =
					"<p><big><center>Файл с логом: \"" + this.pm_oF1Server.GetLogFileObject().Path + "\"</center></big>";
			} catch(ex) {};
			var sStyles =
				((oCriticalErrorsTable != null) ? oCriticalErrorsTable.sTableStyles : "") + END_OF_LINE +
				((oErrorsTable != null) ? oErrorsTable.sTableStyles : "") + END_OF_LINE;
			var sHTMLBody =
				sLogFileBlock + END_OF_LINE +
				((oCriticalErrorsTable != null) ? "<hr>" + oCriticalErrorsTable.sTableBody : "") + END_OF_LINE +
				((oErrorsTable != null) ? "<hr>" + oErrorsTable.sTableBody : "") + END_OF_LINE;
			sResult= HTMLDoc("Ошибки в логе сервера", sHTMLBody, sStyles);
		}
		return sResult;
	}

	// метод сбрасывает состояния зависания, т.о. зависание будет детектится с чистого листа
	this.pm_ResetHangupState = function()
	{
		// отодвигаем момент проверки утилитой доступности сервера
		this.pm_tF1SCTimestamp = CurrTimeStamp() + this.pm_tF1SCCheckDelay - this.pm_tF1SCStartInterval;
		// сбрасываем флаги обнаружения зависания
		this.pm_bIsSCHangupDetected = false;
		this.pm_bIsLLHangupDetected	= false;
		this.pm_bIsF1BUDBSwitchHangupDetected = false;
		//
		@if(@DEBUG)
			DebugInfo("Сбросили флаги, связанные с зависанием");
		@end
	}

	// сбрасывает флаги связанные со статусом обновления и разрешает перезагрузку сервера другой перегружалке
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
			DebugInfo("Сбросили флаги, связанные с обновлением");
		@end
	}

	// Метод начинает обрабатывать статус обновления
	// Распилено на две части, т.к. может возникнуть ситуация:
	//	1) установлены флаги US_UPDATE_FINISHED | US_BASE_UPDATED 
	//  2) при этом произошла критическая ошибка, требующая перезагрузки сервера
	// в этом случае флаги связанные с обновлением будут сброшены до перезагрузки сервера
	this.pm_BeginProcessUpdateStatus = function()
	{
		if (this.pm_iUpdateStatus != US_NO_INFO)
		{
			// если начало обновления
			if ((this.pm_iUpdateStatus & US_UPDATE_STARTED) == US_UPDATE_STARTED) {
				// разрешаем перезагрузку сервера только себе, чтобы перезагружалка по-расписанию не снесла его посреди обновления
				this.pm_bIsSoSPermittedOnlyForMe = this.pm_oManageableProduct.PermitStartOrStopOnlyForMe();
				this.pm_bIsIgnoreCriticalErrorsWhileDBUpdate = true;								
				@if(@DEBUG)
					if (this.pm_bIsSoSPermittedOnlyForMe)
						DebugInfo("Успешно запрещена перезагрузка сервера всем кроме меня");
					else
						DebugError("Не удалось запретить перезагрузку сервера всем кроме меня");
				@end				

				// проверяем, не начато ли переключение баз с помощью F1BU
				var iF1BURunningTime = this.pm_GetF1BURunningTime();
				this.pm_bIsDBSwitchingWithF1BU = (iF1BURunningTime > 0) && (iF1BURunningTime < this.pm_ciF1BULimitationPeriod);
				if (this.pm_bIsDBSwitchingWithF1BU)
					Logger().Info("Считаем, что переключение баз начато с помощью F1BU");
				@if(@DEBUG)
					DebugInfo("iF1BURunningTime = " + iF1BURunningTime);
					DebugInfo("this.pm_bIsDBSwitchingWithF1BU = " + this.pm_bIsDBSwitchingWithF1BU);
				@end
			}

			// если база обновилась
			if ((this.pm_iUpdateStatus & US_BASE_UPDATED) == US_BASE_UPDATED)	{
				// выставляем флаг необходимости явного переключения баз при перезагрузке
				this.pm_bIsNeedManualDBSwitching = true;
				this.pm_bIsIgnoreCriticalErrorsWhileDBUpdate = false;
				@if(@DEBUG)
					DebugInfo("this.pm_bIsNeedManualDBSwitching = " + this.pm_bIsNeedManualDBSwitching);
					DebugInfo("this.pm_bIsIgnoreCriticalErrorsWhileDBUpdate = " + this.pm_bIsIgnoreCriticalErrorsWhileDBUpdate);
				@end
			}
			
			// если не удалось открыть новую базу
			if ((this.pm_iUpdateStatus & US_OPEN_NEW_DВ_FAILED) == US_OPEN_NEW_DВ_FAILED)	{
				// выставляем флаг о том что новая база не открылась
				this.pm_bIsDBSwitchingWithF1BU = false;
				this.pm_bIsOpenNewDBFailed = true;
				this.pm_bIsRestartProduct = true;
				this.pm_sRestartCause = "Новая база не открылась!";
				@if(@DEBUG)
					DebugInfo("this.pm_bIsOpenNewDBFailed = " + this.pm_bIsOpenNewDBFailed);
					DebugInfo("this.pm_bIsRestartProduct = " + this.pm_bIsRestartProduct);
				@end
			}
			
			// если не удалось открыть старую базу
			if ((this.pm_iUpdateStatus & US_OPEN_OLD_DB_FAILED) == US_OPEN_OLD_DB_FAILED)	{
				if (this.pm_bIsOpenNewDBFailed)	{
					// если и новая и старая база не открылись, то надо перезапускать сервер
					this.pm_bIsRestartProduct = true;
					this.pm_sRestartCause = "Ни новая ни старая база не открылись!";
				} else {
					Logger().Warning("Что-то странно - старая база не открылась, а про новую такой информации нет.");
				}
				@if(@DEBUG)
					DebugInfo("Решили перезапустить сервер, т.к. " + this.pm_sRestartCause);
				@end
			}

			// если база открылась
			if ((this.pm_iUpdateStatus & US_NEW_DB_OPENED) == US_NEW_DB_OPENED) {
				// сбрасываем флаг необходимости явного переключения баз				
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
	
	// Метод заканчивает обрабатывать статус обновления
	this.pm_FinishProcessUpdateStatus = function()
	{
		if (this.pm_iUpdateStatus != US_NO_INFO)
		{
			// если обновление завершилось
			if ((this.pm_iUpdateStatus & US_UPDATE_FINISHED) == US_UPDATE_FINISHED) {
				// сбрасываем все флаги
				this.pm_ResetUpdateRelatedFlags();
			}
		}
	}

	// Метод обрабатывает статус ошибки
	this.pm_ProcessErrorStatus = function()
	{
		if (this.pm_iErrorStatus != ES_OK)
		{ // не все в порядке в логе гарантском
			// === Здесь обработка ошибок не требующая перезапуска сервера ===
			// Если есть ошибки простые или критические - высылаем письмо
			if ( ((this.pm_iErrorStatus & ES_ERROR) == ES_ERROR) || ((this.pm_iErrorStatus & ES_CRITICAL_ERROR) == ES_CRITICAL_ERROR) )
			{
				Logger().Info("Найдены ошибки");
				// Посылаем письмо с ошибками
				var sHTMLDocWithErrors = this.pm_GenerateHTMLDocWithErrors();
				if ((this.pm_csToEmailErrors != "") && (sHTMLDocWithErrors != ""))
				{
					Logger().Info("Найденные ошибки будут высланы на адрес " + this.pm_csToEmailErrors);
					SendMail(this.pm_csFromEMail, this.pm_csToEmailErrors,
						"В логе " + this.pm_oF1Server.sNameForLog + " на машине " + CompName() + " обнаружены ошибки!",
						sHTMLDocWithErrors	);
				}
			}

			// === Здесь обработка ошибок требующая перезапуска сервера ===
			if ( (this.pm_iErrorStatus & ES_CRITICAL_ERROR) == ES_CRITICAL_ERROR)
			{			
				this.pm_DoVMMapLog();
				//
				if (!this.pm_bIsIgnoreCriticalErrorsWhileDBUpdate) {
					this.pm_bIsRestartProduct = true;
					this.pm_sRestartCause = "В логе сервера обнаружены критические ошибки!";
				} else {
					Logger().Info("Была критическая ошибка, но ее проигнорировали потому что в данный момент обновляется база.");
				}
			}
			if ((this.pm_iErrorStatus & ES_SERVER_HANGUP) == ES_SERVER_HANGUP) {
				this.pm_bIsRestartProduct = true;
				this.pm_sRestartCause = "Сервер, похоже, повис!";
			}
			if ((this.pm_iErrorStatus & ES_F1BU_DB_SWITCH_HANGUP) == ES_F1BU_DB_SWITCH_HANGUP) {
				this.pm_bIsRestartProduct = true;
				this.pm_sRestartCause = "Похоже что переключение баз, начатое с помощью F1BU не выполнилось за заданное время (" + Math.round(this.pm_ciF1BUDBSwitchTimeout/1000).toString() + " сек)!";
				@if(@DEBUG)
					DebugInfo("Обработка статуса ES_F1BU_DB_SWITCH_HANGUP");
					DebugInfo("this.pm_bIsRestartProduct = " + this.pm_bIsRestartProduct);
					DebugInfo("this.pm_sRestartCause = " + this.pm_sRestartCause);
				@end
			};
		}
	}
	
	// Метод перезапускает продукт при необходимости
	this.pm_ProcessRestartStatus = function()
	{
		if (this.pm_bIsRestartProduct)
		{
			Logger().Info(this.pm_sRestartCause);
			Logger().Info("Будем перегружать сервер");
			// Будем перегружать сервер
			try {			
				if (this.pm_bIsCanRestartServer) {
					// Закрываем логи, т.к. в процессе остановки могут возникнуть отдельные ошибки
					this.pm_CloseLogFile();
					// если его никто не перезапускает и удалось начать операцию
					if (!this.pm_oManageableProduct.IsStartingOrStopping() && this.pm_oManageableProduct.BeginStartOrStop()) {
						try {
							// делаем свой хэндлер, делаем здесь потому что мы используем приватные методы текущего класса (хотя технически они публичные, но мы их считаем приватными и использовать будем только внутри их класса)
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

						// делаем это здесь, т.к. если не было перезапуска, то и сбрасывать не надо
						this.pm_ResetUpdateRelatedFlags();
					} else {
						Logger().Info("Сервер должен быть перезапущен, но кто-то его уже перезапускает");
					}
					//
					this.pm_ResetHangupState();
				} else {
					Logger().Info("Обнаружена ситуация, требующая перезагрузки сервера, но она запрещена");
					if (this.pm_csToEmailServerRestart != "")
						SendMail(this.pm_csFromEMail, this.pm_csToEmailServerRestart,
							"Обнаружены проблемы с " + this.pm_oManageableProduct.sNameForLog + " на машине " + CompName(),
							HTMLDoc("Проблемы с сервером", "Утилита слежения за " + this.pm_oManageableProduct.sNameForLog + " на машине " + CompName() + " обнаружила следующие проблемы: " + this.pm_sRestartCause + "<div>Так как автоматическая перезагрузка отключена, возможно, требуется ручное вмешательство.")
						);
				}
			} catch (ex) {
				Logger().Error("Исключение при попытке перезапустить " + this.pm_oManageableProduct.sNameForLog);
				Logger().Exception(ex);
			}
		}	
	}
	
	// Метод устанавливает на файлах неактивной базы атрибут ReadOnly
	this.pm_ChangeROAttrOnInactiveDBFiles = function(
		isRO // true - устанавливает RO, false - сбрасывает RO
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
						Logger().Warning("Ошибка установки (или получения) атрибута файла " + oFile.Name);
						Logger().Exception(oEx);
					}				
			}
		} catch (oEx) {
			Logger().Error("Ошибка при изменении аттрибутов файлов неактивной базы.");
			Logger().Exception(oEx);
		}		
	}
	
	// Метод исполняется при перезапуске сервера, непосредственно перед запуском сервера
	this.pm_OnServerStart = function()
	{
		// открываем лог перед запуском сервера, чтобы не пропустить ошибки, который могут возникнуть при запуске
		this.pm_OpenLogFile();
		// если нужно, меняем в инишнике базы данных
		if (this.pm_bIsNeedManualDBSwitching) {
			Logger().Info("Переключаем базы данных в ini-файле сервера");
			this.pm_oF1Server.SwitchDataBaseInINIFile();
		}
		// прибиваем утилиты F1
		if (this.pm_bIsKillF1UtilitiesOnServerRestart) {
			KillF1Utilities();
		}
	}
	
	// Метод исполняется при перезапуске продукта, непосредственно перед началом остановки
	this.pm_OnServerStopBegin = function()
	{
		if (this.pm_bIsNeedManualDBSwitching) {
			Logger().Info("Устанавливаем атрибут RO на файлы неактивной базы");
			this.pm_ChangeROAttrOnInactiveDBFiles(true);
		}
	}
	
	// Метод исполняется при перезапуске продукта, непосредственно после остановки сервера
	this.pm_OnServerStopEnd = function()
	{
		if (this.pm_bIsNeedManualDBSwitching) {
			Logger().Info("Сбрасываем атрибут RO с файлов неактивной базы");
			this.pm_ChangeROAttrOnInactiveDBFiles(false);
		}	
	}
	
	
	// Метод проверяет, пора ли писать в лог сообщение о том что мы еще живы, и если пора то пишет
	this.pm_KeepAlive = function()
	{
		try {
			if ( (this.pm_tKeepAliveInterval > 0)
				&& (CurrTimeStamp() > this.pm_tKeepAliveLastTimestamp + this.pm_tKeepAliveInterval) )
			{
				Logger().Info("Утилита все еще жива. Последняя прочитанная строка лога: " + Trim(this.pm_sLastLine));
				this.pm_tKeepAliveLastTimestamp = CurrTimeStamp();
			}
		} catch(oEx) {
			Logger().Error("Ошибка при выполнении метода pm_KeepAlive");
			Logger().Info("typeof(this.pm_sLastLine): " + typeof(this.pm_sLastLine));
			Logger().Exception(oEx);
		}
	}

	// возвращает время в миллисекундах в течение которого работает переключалка баз F1BU, если не работает, то возвращает -1
	this.pm_GetF1BURunningTime = function()
	{
		var result = -1;
		var oF1BU = GetWMIObjectForProcess("F1BU.exe");
		if (oF1BU != null) {
			result =  CurrTimeStamp() - WMIDate2StandardDate(oF1BU.CreationDate);
		}		
		@if(@DEBUG)
			DebugInfo("this.pm_GetF1BURunningTime возвращает " + result);
		@end		
		return result;
	}
	
	this.pm_CheckForAsserts = function()
	{
		if (this.pm_bIsDetectAsserts) {			
			@if(@DEBUG)
				DebugInfo("Проверяем появились ли новые ассерты");			
			@end
			
			if (FSO().FileExists(this.pm_csAssertDetectorCmdFile))
				try {
					FSO().DeleteFile(this.pm_csAssertDetectorCmdFile);
				} catch (oEx) {
					Logger().Exception(oEx);
					Logger().Error("Не удалось удалить файл команды обнаружения ассертов!");
					return;
				}
				
			if (FSO().FileExists(this.pm_csAssertDetectorResFile))
				try {
					FSO().DeleteFile(this.pm_csAssertDetectorResFile);
				} catch (oEx) {
					Logger().Exception(oEx);
					Logger().Error("Не удалось удалить файл результата обнаружения ассертов!");
					return;
				}
				
			var iProcessID = this.pm_oF1Server.GetProcessID();
			
			// пишем в командный файл пид процесса сервера чтобы получить хэндлы окон с ассертами
			var sTempCmdFile = this.pm_csAssertDetectorCmdFile + ".tmp";
			var oTmpCmdFile = FSO().CreateTextFile(sTempCmdFile, true);
			oTmpCmdFile.Write(iProcessID.toString());
			oTmpCmdFile.Close();
			FSO().MoveFile(sTempCmdFile, this.pm_csAssertDetectorCmdFile);
			
			// ждем пока отработает
			var iDeadLine = CurrTimeStamp() + 3000;
			while (iDeadLine > CurrTimeStamp())
				if (FSO().FileExists(this.pm_csAssertDetectorResFile))
					break;
				else
					WScript.Sleep(100);
			if (!FSO().FileExists(this.pm_csAssertDetectorResFile)) {
				Logger().Error("Файл с результатом обнаружения ассерта не получен за отведенное время! Возможно, не запущен сервис поиска ассертов");
				return;
			}
			
			//парсим вывод пропуская пустые строки			
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
			
			// определяем есть ли новые ассерты
			var bHasNewAsserts = false;			
			if (arrHandles.length > 0) {
				if (iProcessID == this.pm_iProcessIDForAssertDetector) {
					// для этого процесса уже были ассерты, проверяем, что появились новые
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
								DebugInfo("Считаем новым хэндл окна ассерта " + sHandle);			
							@end							
							bHasNewAsserts = true;
							this.pm_arrAssertHandles.push(sHandle);
						}						
					}
				} else {
					// есть новые ассерты и для этого процесса они еще не обнаруживались
					this.pm_iProcessIDForAssertDetector = iProcessID;
					bHasNewAsserts = true;
					this.pm_arrAssertHandles = arrHandles;
				}
			}
			
			if (bHasNewAsserts) {
				Logger().Info("Обнаружены новые ассерты");				
				SendMail(this.pm_csFromEMail, this.pm_csToEmailErrors,
						"Сработал ассерт в сервере на машине " + CompName() + "!", "")
			} else {
				@if(@DEBUG)
					DebugInfo("Новые ассерты не обнаружены");			
				@end
			}
		}
	}
	
	this.pm_CheckForExceptionBreakpoints = function()
	{
		if (this.pm_bIsWatchForDebuggerBreakpoints)
		{
			@if(@DEBUG)
				DebugInfo("Проверяем сработал ли брейкпоинт");
			@end
						
			if (FSO().FileExists(this.pm_csBreakpointFilePath))
			{
				Logger().Info("Сработал брейкпоинт в отладчике");
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
					Logger().Info("Брейкпоинт: " + sBreakpointDescription);
					SendMail(
						this.pm_csFromEMail, this.pm_csToEmailErrors,
						"Сработал брейкпоинт в отладчике на машине " + CompName() + "!",
						sBreakpointDescription
					)
				} else {
					Logger().Error("Произошла какая-то ошибка при получении текста брейкпоинта");
				}
			} else {
				@if(@DEBUG)
					DebugInfo("Брейкпоинты не сработали");
				@end
			}
		}		
	}

	// Метод выполняющий основной поток
	this.Run = function()
	{		
		// проверяем, что это единственный работающий вотчер
		with (new CriticalSection("f1server.watcher.run.check_unique"))
			if (Enter(5000)) {
				try {
					if (this.pm_oUseGuard.IsUsing())
						throw "Уже запущен один экземпляр смотрелки!";
					else
						this.pm_oUseGuard.Use();
				} finally {
					Leave()
				}
			} else {
				throw "Не могу войти в критическую секцию при запуске!";
			}

		try {
			Logger().Info("Watcher начал работу");
			// проверяем что ORBDebugLevel отключен, а если включен, то отключаем использование лога
			if ( this.pm_bIsUseLogFile && this.pm_oF1Server.IsORBDebugLevelON() ) {
				Logger().Warning("ORBDebugLevel включен, поэтому запрещаем использование лог-файла!");
				this.pm_bIsUseLogFile = false;
			}

			// работаем пока не инициирован выход
			var bIsFirstAllowedCheck = true;
			while ( !this.pm_oNeedExitEvent.Wait(0) )
			{
				this.pm_KeepAlive();
				//
				if ( this.pm_IsCanDoNextCheck() )
				{
					// проверяем, это самая первая проверка, либо первая после перерыва, когда нельзя было проверять
					if (bIsFirstAllowedCheck) {
						bIsFirstAllowedCheck = false;
						this.pm_ResetHangupState();
						this.pm_ResetUpdateRelatedFlags();
					}

					// запоминаем время начало проверки
					var	iStartCheck = CurrTimeStamp();

					if (this.pm_bIsUseLogFile)	{
						// переоткрываем лог, если надо
						if ( this.pm_bIsLogOpened && this.pm_IsMustReOpenLogFile() ) {
							Logger().Info("Переоткрываем лог сервера");
							this.pm_CloseLogFile();
							this.pm_ResetUpdateRelatedFlags(); // после переоткрытия лога (которое может быть из-за обновления) может возникнуть ситуация что часть сообщений об обновлении останется непрочитанной, это может быть сообщение об окончании обновления и, таким образом, флаги не будут сброшены и не будет разрешена перезагрузка сервера
						}
						// открываем лог если надо
						if ( (!this.pm_bIsLogOpened) && (!this.pm_OpenLogFile()) ) {
							Logger().Warning("Странно, не смогли открыть лог файл...");
						}
					}

					this.pm_iErrorStatus = ES_OK;
					this.pm_iUpdateStatus = US_NO_INFO;
					this.pm_bIsRestartProduct = false;
					this.pm_sRestartCause = "";

					// Если лог открыт выполняем проверку с помощью лога
					if ( this.pm_bIsLogOpened ) {
						this.pm_DoNextCheckWithLog();
					}

					// Проверяем с помощью утилиты проверки сервера
					this.pm_DoNextCheckWithF1SC();
					
					// Проверяем не сработали ли ассерты
					this.pm_CheckForAsserts();
					// Проверяем не сработали ли брейкпоинты в отладчике
					this.pm_CheckForExceptionBreakpoints();
					
					
					// начинаем обработку статуса обновления
					if (this.pm_bIsWatchForDBUpdateInLog) {
						this.pm_BeginProcessUpdateStatus();
					}
					try {
						// Обрабатываем ошибки
						this.pm_ProcessErrorStatus();
						
						if ( this.pm_IsCanDoNextCheck() ) {						
							// Обрабатываем статус перезапуска, только если сервер еще работает
							this.pm_ProcessRestartStatus();
						} else {
							// если сервер упал после нормального обновления базы, но до переключения баз в инишнике,
							// то выполняем это переключение (без перезапуска)
							if (this.pm_bIsWatchForDBUpdateInLog && this.pm_bIsNeedManualDBSwitching) {
								Logger().Info("Выполняем переключение баз в ини-файле при упавшем сервере");
								this.pm_oF1Server.SwitchDataBaseInINIFile();
								this.pm_bIsNeedManualDBSwitching = false;
							}
						}
					} catch(oEx) {
						Logger().Error("Ошибка при обработке статуса ошибки");
						Logger().Exception(oEx);
						throw oEx;
					} finally {
						// заканчиваем обработку статуса обновления
						if (this.pm_bIsWatchForDBUpdateInLog) {
							this.pm_FinishProcessUpdateStatus();
						}
					}

					// если проверка выполнилась быстрее чем this.pm_ciMinTimeForOneCheck, то ждем разницу
					var iTimeToWait = this.pm_ciMinTimeForOneCheck - (CurrTimeStamp() - iStartCheck);
					if (iTimeToWait > 0) {
						WScript.Sleep(iTimeToWait);
					}
				} else {
					// закрываем лог, потому что его может быть хотят удалить
					this.pm_CloseLogFile();
					Logger().Info("Нельзя проверять...");
					WScript.Sleep(this.pm_ciWaitTimeIfCanNotCheck);
					bIsFirstAllowedCheck = true;
				}
			}
		} catch(oEx) {
			Logger().Error("Ошибка при выполнении метода Run");
			Logger().Exception(oEx);
		} finally {
			this.pm_oUseGuard.Free();
			Logger().Info("Watcher завершил работу");
		}
	}

	// Метод инициирует корректное завершение работы существующего экемпляра смотрелки
	this.Exit = function()
	{
		// проверяем, а может ничего и не запущено
		var bResult = !this.pm_oUseGuard.IsUsing();

		if (!bResult) {
			this.pm_oNeedExitEvent.Set()
			bResult = this.pm_oUseGuard.WaitForFree(this.pm_ciWaitTimeForExit);
			this.pm_oNeedExitEvent.Reset();
		}

		return bResult;
	}
}
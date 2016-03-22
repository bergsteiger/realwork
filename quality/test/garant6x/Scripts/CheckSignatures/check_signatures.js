var FSO = new ActiveXObject("Scripting.FileSystemObject");

function BuildSignatureCheckerBase(
	sBuildDir, bIsWarnOnVersionTxtAbsent
)
{
	var pm_sBuildDir = sBuildDir;
	//			
	// should be implemented !!!
	this.pm_reExcludeFiles = null;
	this.pm_arrProductDirs = null;
	this.pm_reInstallerPath = null;
	this.pm_reProductsPath = null; 
	
	var pm_iDaysToWarning = 240;
	var pm_reDateInCopyright = new RegExp(", \\d{4}-" + new Date().getFullYear() + "\\s*$");
		
	var pm_iMsecInDay = 1000*60*60*24;
	var pm_iNow = new Date().getTime();	
	var pm_oCurrFile;
	var pm_oFileErrors = new ActiveXObject("Scripting.Dictionary");
	
	var pm_arrErrors = new Array();
	
	
	// Выполняет проверку всей сборки
	this.Check = function()
	{
		// перебираем папки в папке со сборкой, проверяем папку инсталлятора и папки с заданными продуктами
		var oBuildFolder = FSO.GetFolder(sBuildDir);
		for (var oBFE = new Enumerator(oBuildFolder.SubFolders); !oBFE.atEnd(); oBFE.moveNext()) {
			var oFolder = oBFE.item();
			//
			if (this.pm_reInstallerPath.test(oFolder.Name))
				this.pm_CheckDir(oFolder);
			else
				if (this.pm_reProductsPath.test(oFolder.Name))
					for (var i in this.pm_arrProductDirs)
					{
						var sProductFolder = FSO.BuildPath(oFolder.Path, this.pm_arrProductDirs[i]);
						if (!FSO.FolderExists(sProductFolder))
							this.pm_Error("Не найдена папка " + sProductFolder + "! Возможно, сборка битая!");
						else
							this.pm_CheckDir(FSO.GetFolder(sProductFolder));
					}
		}		
	}
	
	// Проверяем папку инсталятора или папку продукта
	this.pm_CheckDir = function(
		oFolder
	)
	{	
		// на базе информации из version.txt строим регулярное выражение для проверки версии файла
		var reVersion = null;
		var sVersionTxt = FSO.BuildPath(oFolder.Path, "version.txt");
		if (FSO.FileExists(sVersionTxt))
		{
			var sVersion = FSO.OpenTextFile(sVersionTxt, 1, false).ReadLine();			
			var arrRes = sVersion.match(/(\d+)\.0*(\d+)\.0*(\d+)/);
			reVersion = new RegExp("^" + arrRes[1] + "(\.|,)0?" + arrRes[2] + "(\.|,)" + arrRes[3]);			
		}
		else if (bIsWarnOnVersionTxtAbsent)
		{
			this.pm_Error("На найден файл " + sVersionTxt + "! Версия файлов в папке " + oFolder.Path + " не проверена!");
		}
			
		// проверяем папку
		this.pm_CheckFolder(oFolder, reVersion);
	}
	
	// Проверяем конкретную папку
	this.pm_CheckFolder = function(
		oFolder,
		reVersion
	)
	{		
		for (var oFE = new Enumerator(oFolder.Files); !oFE.atEnd(); oFE.moveNext())
		{
			pm_oCurrFile = oFE.item();
			if (!this.pm_reExcludeFiles.test(pm_oCurrFile.Path))
				this.pm_CheckFile(reVersion);
		}
		
		for (var oSFE = new Enumerator(oFolder.SubFolders); !oSFE.atEnd(); oSFE.moveNext())
			this.pm_CheckFolder(oSFE.item(), reVersion);
	}
	
	this.pm_CheckFile = function(
		reVersion
	)
	{	
		// проверяем подпись
		var oFSC = new FileSignatureChecker(pm_oCurrFile.Path);				
		if (oFSC.m_isSignable)
			if(!oFSC.m_isSigned)
				this.pm_FileError(oFSC.m_sErr);
			else { 
				if (!/OOO NPP GARANT-SERVIS-UNIVERSITET/i.test(oFSC.m_sSignedBy))
					this.pm_FileError("Файл подписан не \"OOO NPP GARANT-SERVIS-UNIVERSITET\", а \"" + oFSC.m_sSignedBy + "\"");
				// проверяем что подпись не истекла
				var iDateDiffInDays = Math.floor((oFSC.m_oExpDate.getTime() - pm_iNow)/pm_iMsecInDay);
				if (iDateDiffInDays < 0)
					this.pm_FileError("Срок действия сертификата уже истек " + oFSC.m_oExpDate.toLocaleString() + "!");
				else if (iDateDiffInDays < pm_iDaysToWarning)
					this.pm_FileError("Срок действия сертификата истекает через " + iDateDiffInDays + " дней!");
			}
		
		// проверяем информацию о версии. Только для exe и dll файлов		
		if (/exe|dll/i.test(FSO.GetExtensionName(pm_oCurrFile.Path)))
		{
			var oFIG = new FileInfoGetter(pm_oCurrFile.Path);
			//
			var sFV = oFIG.Get("FileVersion");
			if (sFV == null)
				this.pm_FileError("У файла нет информации о версии!");
			else if (reVersion && !reVersion.test(sFV))
				this.pm_FileError("Некорректная версия файла: " + sFV);
			//
			var sLC = oFIG.Get("LegalCopyright");
			if (sLC == null)
				this.pm_FileError("У файла нет информации о авторских правах!");
			else if (!pm_reDateInCopyright.test(sLC))
				this.pm_FileError("Информация о годе не соответствует текущему: " + sLC);
		}
		
		// проверяем версию манифеста
		if (!/dll/i.test(FSO.GetExtensionName(pm_oCurrFile.Path))) // в dll-ках его точно не должно быть
		{
			var oMH = new ManifestHelper(pm_oCurrFile.Path);
			if (oMH.m_isCanHaveManifest)
				if (!oMH.m_isHaveValidManifest)
					this.pm_FileError("У файла нет манифеста или он не валидный!");
				else
					if (reVersion && !reVersion.test(oMH.m_sAssemblyVersion))
						this.pm_FileError("В манифесте содержится некорректная версия: " + oMH.m_sAssemblyVersion);
		}
	}
	
	this.pm_Error = function(
		sErr
	)
	{
		pm_arrErrors.push(sErr);
	}
	
	this.pm_FileError = function(
		sErr
	)
	{
		var sMsg = "\r\n      " + pm_oCurrFile.Path;
		
		if (pm_oFileErrors.Exists(sErr))
			pm_oFileErrors.Item(sErr) += sMsg;
		else	
			pm_oFileErrors.Add(sErr, sMsg);
	}
	
	this.HasErrors = function()
	{
		return (pm_arrErrors.length > 0) || (pm_oFileErrors.Count > 0);
	}
	
	this.GetErrors = function()
	{
		var sRes = pm_arrErrors.join("\r\n");
        if (sRes != "")
           	sRes += "\r\n\r\n";
		//
		var arrKeys = pm_oFileErrors.Keys().toArray();
		for (var i in arrKeys)
			sRes += arrKeys[i] + pm_oFileErrors.Item(arrKeys[i]) + "\r\n\r\n";
			
		return sRes;		
	}
}


function GarantF1BuildSignatureChecker(
	sBuildDir
)
{
	BuildSignatureCheckerBase.apply(this, [sBuildDir, true]);
	
	this.pm_reExcludeFiles = /(\.(txt|reg|s|k|ini|xml|bat)$)|eo\\setup.exe$|-installer\\setup\\support\\|F1SendMail\.dll$|Flash\.ocx$|unzdll\.dll$/i;
	this.pm_arrProductDirs = ["server", "client", "netware", "desktop", "cd_or_dvd\\garant"];
	this.pm_reInstallerPath = /daily-GARANTF1-.*-installer$/i;
	this.pm_reProductsPath = /daily-GARANTF1.*/i;
}


function Mini4BuildSignatureChecker(
	sBuildDir
)
{
	BuildSignatureCheckerBase.apply(this, [sBuildDir, false]);
	
	this.pm_reExcludeFiles = /(\.(txt|reg|s|k|ini|xml|bat)$)|eo\\setup.exe$|-installer\\support\\|mini4-setup\\iv-garantSetupRus_ru-ru.exe$/i;
	this.pm_arrProductDirs = ["mini4", "mini4-setup"];
	this.pm_reInstallerPath = /daily-GARANT_MINI4.*-installer$/i;
	this.pm_reProductsPath = /daily-GARANT_MINI4.*/i;
}


function BaseConsoleProgLauncher(
	sPathToProgram
)
{
	var pm_sPathToProgram = sPathToProgram;
	var pm_oWSH = WScript.CreateObject("WScript.Shell");
	
	this.m_sErr;
	this.m_sOut;
	this.m_iExitCode;
		
	this.Run = function(
		sArgs
	)
	{
		var oExec = pm_oWSH.Exec("\"" + pm_sPathToProgram + "\" " + sArgs);
		var iSleepTime = 0;
		while ((oExec.Status == 0) || !oExec.StdErr.atEndOfStream || !oExec.StdOut.atEndOfStream)
		{
			if (!oExec.StdErr.atEndOfStream)
				this.m_sErr += oExec.StdErr.ReadAll();
			if (!oExec.StdOut.atEndOfStream)
				this.m_sOut += oExec.StdOut.ReadAll();
			//
			WScript.Sleep(iSleepTime);
			if (iSleepTime <= 100)
				iSleepTime += 10;
		}
		this.m_iExitCode = oExec.ExitCode;
		//
		this.m_sOut = this.m_sOut.replace(/\s*$/, "");
		this.m_sErr = this.m_sErr.replace(/\s*$/, "");
		//
		return this.m_iExitCode;
	}
	
	this.pm_Clean = function()
	{	
		this.m_sErr = "";
		this.m_sOut = "";
		this.m_iExitCode = -1;
	}
	
	this.pm_Clean();
}

function FileSignatureChecker(
	sFilePath
)
{
	BaseConsoleProgLauncher.apply(this, [FSO.BuildPath(FSO.GetParentFolderName(WScript.ScriptFullName), "signtool.exe")]);
		
	var pm_sFilePath = sFilePath;
		
	this.m_isSigned = false;
	this.m_isSignable = false;
	this.m_sSignedBy = "";
	this.m_oExpDate;
	
	this.pm_Check = function()
	{
		this.Run("verify /pa /v \"" + pm_sFilePath + "\"");
		//
		this.m_isSignable = !/This file format cannot be verified/.test(this.m_sErr);
		this.m_isSigned = (this.m_iExitCode == 0);
		//
		if (this.m_isSigned)
		{			
			var arrRes = this.m_sOut.match(/Issued to:\s*(.*)\s*.*\s*Expires:\s*(.*)\s*.*\s*The signature is timestamped/mi);
			this.m_sSignedBy = arrRes[1];
			var sExpires = arrRes[2];
			this.m_oExpDate = new Date(Date.parse(sExpires));
		}

	}

	this.pm_Check();	
}

function FileInfoGetter(
	sFilePath
)
{
	BaseConsoleProgLauncher.apply(this, [FSO.BuildPath(FSO.GetParentFolderName(WScript.ScriptFullName), "GetVersionInfo.exe")]);
		
	var pm_sFilePath = sFilePath;
		
	this.Get = function(
		sInfoName
	)
	{
		this.pm_Clean();
		this.Run("\"" + pm_sFilePath + "\" " + sInfoName);
		//
		if (this.m_iExitCode == 0) 
			return this.m_sOut;
		else
			return null;
	}
}

function ManifestHelper(
	sFilePath
)
{
	BaseConsoleProgLauncher.apply(this, [FSO.BuildPath(FSO.GetParentFolderName(WScript.ScriptFullName), "mt.exe")]);
		
	var pm_sFilePath = sFilePath;
	
	var pm_sManifest = "";
	
	this.m_isCanHaveManifest = false;
	this.m_isHaveValidManifest = false;
	this.m_sAssemblyVersion = null;

	this.pm_Parse = function()
	{
		var sTempFile = FSO.BuildPath(FSO.GetSpecialFolder(2).Path, FSO.GetTempName());
		this.Run("-inputresource:\"" + pm_sFilePath + "\" -nologo -validate_manifest -out:\"" + sTempFile + "\"");
		//
		this.m_isCanHaveManifest = 
			!/The binary is not a valid Windows image/m.test(this.m_sOut) 
			&& (FSO.GetFile(pm_sFilePath).Size > 0);
		this.m_isHaveValidManifest = 
			(this.m_iExitCode == 0) 
			&& FSO.FileExists(sTempFile) 
			&& /Parsing of manifest successful\./.test(this.m_sOut);
		//
		if (this.m_isHaveValidManifest) {
			with (FSO.OpenTextFile(sTempFile, 1)) {
				pm_sManifest = ReadAll();
				Close();
			}
			FSO.DeleteFile(sTempFile);
			pm_sManifest = pm_sManifest.replace(/^.*?(?=<\?)/, ""); // убираем какой-то мусор в начале
			//
			this.pm_ParseManifest();
		};		
	}
	
	this.pm_ParseManifest = function()
	{
		var oDOM = new ActiveXObject("Msxml2.DOMDocument");
		oDOM.async = false;		
		oDOM.loadXML(pm_sManifest);
		oDOM.setProperty("SelectionLanguage", "XPath");
		oDOM.setProperty("SelectionNamespaces", "xmlns:a='urn:schemas-microsoft-com:asm.v1'");
		this.m_sAssemblyVersion = oDOM.selectSingleNode("//a:assemblyIdentity/@version").nodeValue;		
	}	
	
	this.pm_Parse();
}


function DoCheck(
	oCheckerClass,
	sBuildDir,
	sOutFile
)
{
	if (FSO.FileExists(sOutFile))
		FSO.DeleteFile(sOutFile);
	
	var oBSE = new oCheckerClass(sBuildDir);
	oBSE.Check();
	if (oBSE.HasErrors()) {
		with (FSO.CreateTextFile(sOutFile, true)) {
			  try {
				Write(oBSE.GetErrors());
			  } catch (oEx) {
			  }
			  Close();
			}
		FSO.CopyFile(	
			sOutFile,
			FSO.BuildPath(FSO.GetSpecialFolder(2).Path, FSO.GetFileName(sOutFile) + "." + new Date().getTime())
		);
	}
}
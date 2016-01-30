unit BaseTest;

// Модуль: "w:\common\components\rtl\Garant\DUnitTuning\BaseTest.pas"
// Стереотип: "SimpleClass"

{$Include tfwDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
uses
 l3IntfUses
 , TestFrameWork
 , l3EtalonsWorking
 , l3CardinalList
 , l3Filer
;

type
 ToLogProc = procedure(const aSt: AnsiString) of object;

 TimeToLogProc = procedure(aTime: Cardinal;
  const aSt: AnsiString;
  const aSubName: AnsiString) of object;

 TBaseTest = {abstract} class(TTestCase)
  private
   f_Starts: Tl3CardinalList;
    {* Начальные точки замеров }
  protected
   procedure ToLog(const aSt: AnsiString);
   function StartTimer: Longword;
   function StopTimer(const aSt: AnsiString = '';
    const aSubName: AnsiString = ''; aNeedTimeToLog : Boolean = true): Longword; overload;
   class function FileFromCurrent(const aStr: AnsiString;
    aFolderMode: Boolean = False): AnsiString;
    {* Файл из текущей директории }
   procedure TimeToLog(aTime: Cardinal;
    const aSt: AnsiString;
    const aSubName: AnsiString;
    aIgnoreTestName: Boolean = False);
    {* Выводит замер времени в лог }
   function FileForOutput: AnsiString; virtual;
    {* Стандартный файл для вывода, для текщего теста }
   function FilerForOutput: Tl3CustomDosFiler;
   function FilerForInput(const aSt: AnsiString): Tl3CustomDosFiler;
   procedure CheckTimeout(aNow: Cardinal;
    aTimeout: Cardinal);
   function StopTimer(const aSt: AnsiString;
    aNeedTimeToLog: Boolean): Longword; overload;
   function KPage: AnsiString;
    {* Страница в K }
   function IsGK: Boolean;
    {* Тесты запущены ГК }
   function EtalonSuffix: AnsiString;
    {* Суффикс имени эталонного файла }
   function EtalonNeedsComputerName: Boolean; virtual;
   class function OutputPath: AnsiString;
   function RaiseIfEtalonCreated: Boolean; virtual;
   function EtalonCanHaveDiff: Boolean; virtual;
    {* Эталон может иметь эталонную разницу для конкретного компьютера. Например как в [RequestLink:234362304] }
   function FileNameForOutput: AnsiString; virtual;
   function FolderFromCurrent(const aStr: AnsiString): AnsiString;
   function NeedCreateEtalonsWhileCheckingOutputWithInput: Boolean; virtual;
   {$If Defined(XE)}
   function EtalonNeedsXE: Boolean; virtual;
   {$IfEnd} // Defined(XE)
   function EtalonNeedsOSName: Boolean; virtual;
   function EtalonNeeds64: Boolean; virtual;
   function OutputFolderName: AnsiString; virtual;
    {* Папка, в которую пишутся выходные файлы. }
   function CheckExternalPicture(aMakeEtalon: Boolean;
    const aCVSPath: AnsiString;
    var aCompareImage: Boolean): AnsiString;
   procedure Cleanup; override;
   function GetEnabled: Boolean; override;
   procedure SetEnabled(Value: Boolean); override;
   procedure DoClearEtalon; override;
  public
   class function ComputerName: AnsiString;
   function AlwaysShowAFC: Boolean; virtual;
    {* Всегда показывать сравнивалку файлов, когда не пишем в К }
   class function TestSetFolderName(aNoSuffix: Boolean = False): AnsiString;
   procedure CheckEtalonInFolder(aHeaderBegin: AnsiChar);
   procedure ClearTestFolder;
   function OutputFolderNameWitEtalons: AnsiString;
    {* Директория для эталонов. }
   function GetFullPath2OutputFolderName: AnsiString;
   class function IsWritingToK: Boolean;
   class function HasTabs: Boolean;
   procedure CheckOutputWithInput(const aIn: AnsiString;
    const aOut: AnsiString;
    aHeaderBegin: AnsiChar;
    aEtalonNeedsComputerName: Boolean;
    aEtalonCanHaveDiff: Boolean;
    const anExtraFileName: AnsiString;
    aNeedsCheck: Boolean); overload;
   procedure CheckWithEtalon(const aFileName: AnsiString;
    aHeaderBegin: AnsiChar);
   procedure CheckOutputWithInput(const aSt: AnsiString;
    aHeaderBegin: AnsiChar = #0;
    const anExtraFileName: AnsiString = '';
    aNeedsCheck: Boolean = True); overload;
   procedure CheckPictureOnly;
 end;//TBaseTest

var f_ToLog: ToLogProc = nil;
var f_TimeToLog: TimeToLogProc = nil;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
 , SysUtils
 , KTestRunner
 , l3String
 , l3ImageUtils
 {$If Defined(MTDORB) AND Defined(NoKPageTool)}
 , KBridge
 {$IfEnd} // Defined(MTDORB) AND Defined(NoKPageTool)
 , l3Stream
 , l3FileUtils
 , JclSysInfo
 , l3SysUtils
 , ddPicturePathListner
 , l3TabService
 , l3Base
 , Windows
 , l3Types
 , StrUtils
;

procedure TBaseTest.ToLog(const aSt: AnsiString);
//#UC START# *4B2A121601E8_4B2A11BC0255_var*
//#UC END# *4B2A121601E8_4B2A11BC0255_var*
begin
//#UC START# *4B2A121601E8_4B2A11BC0255_impl*
 if Assigned(f_ToLog) then
  f_ToLog(aSt)
 else
  l3System.Msg2Log(ClassName + '.' + FTestName + ': ' + aSt);
//#UC END# *4B2A121601E8_4B2A11BC0255_impl*
end;//TBaseTest.ToLog

function TBaseTest.StartTimer: Longword;
//#UC START# *4B2A122D039A_4B2A11BC0255_var*
//#UC END# *4B2A122D039A_4B2A11BC0255_var*
begin
//#UC START# *4B2A122D039A_4B2A11BC0255_impl*
 if (f_Starts = nil) then
  f_Starts := Tl3CardinalList.Make;
 Result := GetTickCount;
 f_Starts.Add(Result);
//#UC END# *4B2A122D039A_4B2A11BC0255_impl*
end;//TBaseTest.StartTimer

function TBaseTest.StopTimer(const aSt: AnsiString = '';
 const aSubName: AnsiString = ''; aNeedTimeToLog : Boolean = true): Longword;
//#UC START# *4B2A123C0086_4B2A11BC0255_var*
//#UC END# *4B2A123C0086_4B2A11BC0255_var*
begin
//#UC START# *4B2A123C0086_4B2A11BC0255_impl*
 Assert(f_Starts <> nil);
 Assert(f_Starts.Count > 0);
 Result := GetTickCount - f_Starts.Last;
 f_Starts.Delete(f_Starts.Hi);
 if aNeedTimeToLog then
  TimeToLog(Result, aSt, aSubName);
//#UC END# *4B2A123C0086_4B2A11BC0255_impl*
end;//TBaseTest.StopTimer

class function TBaseTest.FileFromCurrent(const aStr: AnsiString;
 aFolderMode: Boolean = False): AnsiString;
 {* Файл из текущей директории }
//#UC START# *4B2B9C8001AA_4B2A11BC0255_var*
//#UC END# *4B2B9C8001AA_4B2A11BC0255_var*
begin
//#UC START# *4B2B9C8001AA_4B2A11BC0255_impl*
 Result := KTestRunner.FileFromCurrent(aStr, aFolderMode, false);
//#UC END# *4B2B9C8001AA_4B2A11BC0255_impl*
end;//TBaseTest.FileFromCurrent

procedure TBaseTest.TimeToLog(aTime: Cardinal;
 const aSt: AnsiString;
 const aSubName: AnsiString;
 aIgnoreTestName: Boolean = False);
 {* Выводит замер времени в лог }
//#UC START# *4B2F4C510248_4B2A11BC0255_var*
var
 l_S : AnsiString;
//#UC END# *4B2F4C510248_4B2A11BC0255_var*
begin
//#UC START# *4B2F4C510248_4B2A11BC0255_impl*
 if Assigned(f_TimeToLog) then
 begin
  if aIgnoreTestName then
   l_S := ''
  else
   l_S := ClassName + '.' + FTestName;
  if (aSt <> '') then
  begin
   if (l_S = '') then
    l_S := aSt
   else
    l_S := l_S + '.' + aSt;
  end;//aSt <> ''
  f_TimeToLog(aTime, l_S, aSubName);
 end//Assigned(f_TimeToLog)
 else
 begin
  l_S := 'time ' + IntToStr(aTime) + ' ms';
  if (aSubName <> '') then
   l_S := aSubName + ' ' + l_S;
  if (aSt <> '') then
   l_S := aSt + ' done: ' + l_S;
  ToLog(l_S);
 end;//Assigned(f_TimeToLog)
//#UC END# *4B2F4C510248_4B2A11BC0255_impl*
end;//TBaseTest.TimeToLog

function TBaseTest.FileForOutput: AnsiString;
 {* Стандартный файл для вывода, для текщего теста }
//#UC START# *4B4F588B0241_4B2A11BC0255_var*
var
 l_TestFolder: AnsiString;
//#UC END# *4B4F588B0241_4B2A11BC0255_var*
begin
//#UC START# *4B4F588B0241_4B2A11BC0255_impl*
 if FolderMode then
 begin
  l_TestFolder := OutputPath + DataSubFolder;
  if not DirectoryExists(l_TestFolder) then
   CreateDir(l_TestFolder);
  l_TestFolder := l_TestFolder + '\';
 end // if FolderMode then
 else
  l_TestFolder := OutputPath;
 Result := l_TestFolder + FileNameForOutput + '.out';
//#UC END# *4B4F588B0241_4B2A11BC0255_impl*
end;//TBaseTest.FileForOutput

function TBaseTest.FilerForOutput: Tl3CustomDosFiler;
//#UC START# *4B4F615700F9_4B2A11BC0255_var*
//#UC END# *4B4F615700F9_4B2A11BC0255_var*
begin
//#UC START# *4B4F615700F9_4B2A11BC0255_impl*
 Result := Tl3CustomDosFiler.Make(FileForOutput, l3_fmWrite, false);
//#UC END# *4B4F615700F9_4B2A11BC0255_impl*
end;//TBaseTest.FilerForOutput

function TBaseTest.FilerForInput(const aSt: AnsiString): Tl3CustomDosFiler;
//#UC START# *4B4F624A0116_4B2A11BC0255_var*
//#UC END# *4B4F624A0116_4B2A11BC0255_var*
begin
//#UC START# *4B4F624A0116_4B2A11BC0255_impl*
 Result := Tl3CustomDosFiler.Make(FileFromCurrent(aSt), l3_fmRead, false);
//#UC END# *4B4F624A0116_4B2A11BC0255_impl*
end;//TBaseTest.FilerForInput

procedure TBaseTest.CheckTimeout(aNow: Cardinal;
 aTimeout: Cardinal);
//#UC START# *4B56182A0029_4B2A11BC0255_var*
//#UC END# *4B56182A0029_4B2A11BC0255_var*
begin
//#UC START# *4B56182A0029_4B2A11BC0255_impl*
 Check(GetTickCount - aNow < aTimeout);
//#UC END# *4B56182A0029_4B2A11BC0255_impl*
end;//TBaseTest.CheckTimeout

function TBaseTest.StopTimer(const aSt: AnsiString;
 aNeedTimeToLog: Boolean): Longword;
//#UC START# *4B588FEF0363_4B2A11BC0255_var*
//#UC END# *4B588FEF0363_4B2A11BC0255_var*
begin
//#UC START# *4B588FEF0363_4B2A11BC0255_impl*
 Result := StopTimer(aSt, '', aNeedTimeToLog);
//#UC END# *4B588FEF0363_4B2A11BC0255_impl*
end;//TBaseTest.StopTimer

function TBaseTest.KPage: AnsiString;
 {* Страница в K }
//#UC START# *4B853B4603A9_4B2A11BC0255_var*
//#UC END# *4B853B4603A9_4B2A11BC0255_var*
begin
//#UC START# *4B853B4603A9_4B2A11BC0255_impl*
 if FolderMode then
  Result := Name
 else
 begin
  Result := ClassName;
  if IsScript then
   Result := CorrectScriptKPageName(Self)
  else
  begin
   Assert(AnsiStartsStr('TK', Result));
   Delete(Result, 1, 2);
  end; 
 end // if Self.DataSubFolder = '' then
//#UC END# *4B853B4603A9_4B2A11BC0255_impl*
end;//TBaseTest.KPage

function TBaseTest.IsGK: Boolean;
 {* Тесты запущены ГК }
//#UC START# *4BEA99EB006D_4B2A11BC0255_var*
//#UC END# *4BEA99EB006D_4B2A11BC0255_var*
begin
//#UC START# *4BEA99EB006D_4B2A11BC0255_impl*
 Result := KTestRunner.IsGK;
//#UC END# *4BEA99EB006D_4B2A11BC0255_impl*
end;//TBaseTest.IsGK

function TBaseTest.EtalonSuffix: AnsiString;
 {* Суффикс имени эталонного файла }
//#UC START# *4CA45CA90312_4B2A11BC0255_var*
//#UC END# *4CA45CA90312_4B2A11BC0255_var*
begin
//#UC START# *4CA45CA90312_4B2A11BC0255_impl*
 Result := '.etalon';
 if EtalonNeedsComputerName then
  Result := '.' + ComputerName + Result;
 if EtalonNeedsOSName then
  Result := '.' + GetWindowsVersionString + Result;
 if EtalonNeeds64 then
  if l3Is64System then
   Result := '.64' + Result;
 {$IfDef XE}
 if EtalonNeedsXE then
  Result := '.' + 'XE' + Result;
 {$EndIf XE}
//#UC END# *4CA45CA90312_4B2A11BC0255_impl*
end;//TBaseTest.EtalonSuffix

function TBaseTest.EtalonNeedsComputerName: Boolean;
//#UC START# *4CA45DAA01BA_4B2A11BC0255_var*
//#UC END# *4CA45DAA01BA_4B2A11BC0255_var*
begin
//#UC START# *4CA45DAA01BA_4B2A11BC0255_impl*
 Result := false;
//#UC END# *4CA45DAA01BA_4B2A11BC0255_impl*
end;//TBaseTest.EtalonNeedsComputerName

class function TBaseTest.ComputerName: AnsiString;
//#UC START# *4CA45DD902BD_4B2A11BC0255_var*
var
 l_CompSize : Integer;
//#UC END# *4CA45DD902BD_4B2A11BC0255_var*
begin
//#UC START# *4CA45DD902BD_4B2A11BC0255_impl*
 l_CompSize := MAX_COMPUTERNAME_LENGTH + 1;
 SetLength(Result, l_CompSize);

 Win32Check(GetComputerNameA(PAnsiChar(Result), LongWord(l_CompSize)));
 SetLength(Result, l_CompSize);
//#UC END# *4CA45DD902BD_4B2A11BC0255_impl*
end;//TBaseTest.ComputerName

class function TBaseTest.OutputPath: AnsiString;
//#UC START# *4CA5D9100014_4B2A11BC0255_var*
//#UC END# *4CA5D9100014_4B2A11BC0255_var*
begin
//#UC START# *4CA5D9100014_4B2A11BC0255_impl*
 Result := ExtractFilePath(ParamStr(0)) + TestSetFolderName + '\'
//#UC END# *4CA5D9100014_4B2A11BC0255_impl*
end;//TBaseTest.OutputPath

function TBaseTest.RaiseIfEtalonCreated: Boolean;
//#UC START# *4CA5DAD4014C_4B2A11BC0255_var*
//#UC END# *4CA5DAD4014C_4B2A11BC0255_var*
begin
//#UC START# *4CA5DAD4014C_4B2A11BC0255_impl*
 Result := true;
//#UC END# *4CA5DAD4014C_4B2A11BC0255_impl*
end;//TBaseTest.RaiseIfEtalonCreated

function TBaseTest.EtalonCanHaveDiff: Boolean;
 {* Эталон может иметь эталонную разницу для конкретного компьютера. Например как в [RequestLink:234362304] }
//#UC START# *4CAEE13D00E1_4B2A11BC0255_var*
//#UC END# *4CAEE13D00E1_4B2A11BC0255_var*
begin
//#UC START# *4CAEE13D00E1_4B2A11BC0255_impl*
 Result := false;
//#UC END# *4CAEE13D00E1_4B2A11BC0255_impl*
end;//TBaseTest.EtalonCanHaveDiff

function TBaseTest.FileNameForOutput: AnsiString;
//#UC START# *4DCA41A20364_4B2A11BC0255_var*
//#UC END# *4DCA41A20364_4B2A11BC0255_var*
begin
//#UC START# *4DCA41A20364_4B2A11BC0255_impl*
 if FolderMode then
  Result := FTestName
 else
  Result := ClassName + '_' + FTestName;
//#UC END# *4DCA41A20364_4B2A11BC0255_impl*
end;//TBaseTest.FileNameForOutput

function TBaseTest.AlwaysShowAFC: Boolean;
 {* Всегда показывать сравнивалку файлов, когда не пишем в К }
//#UC START# *4F5F28EB0242_4B2A11BC0255_var*
//#UC END# *4F5F28EB0242_4B2A11BC0255_var*
begin
//#UC START# *4F5F28EB0242_4B2A11BC0255_impl*
 Result := false;
//#UC END# *4F5F28EB0242_4B2A11BC0255_impl*
end;//TBaseTest.AlwaysShowAFC

function TBaseTest.FolderFromCurrent(const aStr: AnsiString): AnsiString;
//#UC START# *4FA152F5019C_4B2A11BC0255_var*
//#UC END# *4FA152F5019C_4B2A11BC0255_var*
begin
//#UC START# *4FA152F5019C_4B2A11BC0255_impl*
 Result := KTestRunner.FileFromCurrent(aStr, false, true);
//#UC END# *4FA152F5019C_4B2A11BC0255_impl*
end;//TBaseTest.FolderFromCurrent

function TBaseTest.NeedCreateEtalonsWhileCheckingOutputWithInput: Boolean;
//#UC START# *4FA164500031_4B2A11BC0255_var*
//#UC END# *4FA164500031_4B2A11BC0255_var*
begin
//#UC START# *4FA164500031_4B2A11BC0255_impl*
 Result := true;
//#UC END# *4FA164500031_4B2A11BC0255_impl*
end;//TBaseTest.NeedCreateEtalonsWhileCheckingOutputWithInput

class function TBaseTest.TestSetFolderName(aNoSuffix: Boolean = False): AnsiString;
//#UC START# *51237EAB00E9_4B2A11BC0255_var*
//#UC END# *51237EAB00E9_4B2A11BC0255_var*
begin
//#UC START# *51237EAB00E9_4B2A11BC0255_impl*
 Result := 'TestSet';
 {$IfDef Monitorings}
 if not aNoSuffix then
  Result := Result + '\Prime';
 {$Else  Monitorings}
 {$IfDef Admin}
 if not aNoSuffix then
  Result := Result + '\Admin';
 {$EndIf Admin}
 {$EndIf Monitorings}
 if not aNoSuffix then
  if Self.HasTabs then
   Result := Result + '\Tabs';
//#UC END# *51237EAB00E9_4B2A11BC0255_impl*
end;//TBaseTest.TestSetFolderName

{$If Defined(XE)}
function TBaseTest.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4B2A11BC0255_var*
//#UC END# *51AF49E5001B_4B2A11BC0255_var*
begin
//#UC START# *51AF49E5001B_4B2A11BC0255_impl*
 Result := false;
//#UC END# *51AF49E5001B_4B2A11BC0255_impl*
end;//TBaseTest.EtalonNeedsXE
{$IfEnd} // Defined(XE)

function TBaseTest.EtalonNeedsOSName: Boolean;
//#UC START# *51AF4A1C036E_4B2A11BC0255_var*
//#UC END# *51AF4A1C036E_4B2A11BC0255_var*
begin
//#UC START# *51AF4A1C036E_4B2A11BC0255_impl*
 Result := false;
//#UC END# *51AF4A1C036E_4B2A11BC0255_impl*
end;//TBaseTest.EtalonNeedsOSName

function TBaseTest.EtalonNeeds64: Boolean;
//#UC START# *51B0AF8E0378_4B2A11BC0255_var*
//#UC END# *51B0AF8E0378_4B2A11BC0255_var*
begin
//#UC START# *51B0AF8E0378_4B2A11BC0255_impl*
 Result := false;
//#UC END# *51B0AF8E0378_4B2A11BC0255_impl*
end;//TBaseTest.EtalonNeeds64

function TBaseTest.OutputFolderName: AnsiString;
 {* Папка, в которую пишутся выходные файлы. }
//#UC START# *51B1A75D0367_4B2A11BC0255_var*
//#UC END# *51B1A75D0367_4B2A11BC0255_var*
begin
//#UC START# *51B1A75D0367_4B2A11BC0255_impl*
 Result := '';
//#UC END# *51B1A75D0367_4B2A11BC0255_impl*
end;//TBaseTest.OutputFolderName

procedure TBaseTest.CheckEtalonInFolder(aHeaderBegin: AnsiChar);
//#UC START# *51B1D42C009C_4B2A11BC0255_var*
var
 l_EtalonDir   : AnsiString;
 l_FilesCount  : Integer;
 l_EtalonNames : AnsiString;

 function l_CheckFile(const aFileName: string): Boolean;
 var
  l_Exists            : Boolean;
  l_EtalonName        : AnsiString;
  l_EtalonNameWithDir : AnsiString;
 begin
  l_EtalonName := ExtractFileName(aFileName) + EtalonSuffix + ExtractFileExt(aFileName);
  l_EtalonNameWithDir := l_EtalonDir + '\' + l_EtalonName;
  l_Exists := FileExists(l_EtalonNameWithDir);
  try
   CheckOutputWithInput(l_EtalonNameWithDir, aFileName, aHeaderBegin, False, False, '', True);
   Inc(l_FilesCount);
  except
   on ETestFailure do
    if l_Exists then
     raise
    else
    begin
     l_EtalonNames := l_EtalonNames + ' ' + l_EtalonName;
     Inc(l_FilesCount);
    end;
  end;
  Result := True;
 end;

var
 l_EtalonFilesCount: Integer;

 function l_CalcEtalonFile(const aFileName: string): Boolean;
 begin
  Inc(l_EtalonFilesCount);
  Result := True;
 end;

var
 l_Dir     : AnsiString;
 l_CVSPath : AnsiString;
 l_FPStub  : Pointer;
 l_FPStub1 : Pointer;
//#UC END# *51B1D42C009C_4B2A11BC0255_var*
begin
//#UC START# *51B1D42C009C_4B2A11BC0255_impl*
 l_FilesCount := 0; l_EtalonFilesCount := 0;
 l_Dir := GetFullPath2OutputFolderName;
 Check(DirExists(l_Dir), 'Директория с выходными файлами не существует!');
 l_EtalonDir := FileFromCurrent(OutputFolderNameWitEtalons);
 ForceDirectories(l_EtalonDir); // Под ногами у приложения
 if not IgnoreCVSPath then // Для создания дирректории эталонов в CVS!
 begin
  l_CVSPath := g_CVSPath + '\' + TestSetFolderName + '\' + OutputFolderNameWitEtalons + '\';
  ForceDirectories(l_CVSPath);
 end; // if not g_IgnoreCVS then
 l_FPStub := l3LocalStub(@l_CheckFile);
 try
  ProcessFilesWithMask(l_Dir, '*.*', TFileProcessingFunc(l_FPStub));
  if l_EtalonNames <> '' then
   Check(False, 'Были созданы эталоны:' + l_EtalonNames);
  CheckFalse(l_FilesCount = 0, 'Нет файлов в папке!');
  l_FPStub1 := l3LocalStub(@l_CalcEtalonFile);
  try
   ProcessFilesWithMask(l_EtalonDir, '*.*', TFileProcessingFunc(l_FPStub1));
  finally
   l3FreeLocalStub(l_FPStub1);
  end;
  CheckTrue(l_FilesCount = l_EtalonFilesCount, 'Число файлов не совпадает с количеством файлов эталонов!');
 finally
  l3FreeLocalStub(l_FPStub);
 end;
//#UC END# *51B1D42C009C_4B2A11BC0255_impl*
end;//TBaseTest.CheckEtalonInFolder

procedure TBaseTest.ClearTestFolder;
//#UC START# *51B1DB35010A_4B2A11BC0255_var*
var
 l_Dir: AnsiString;
//#UC END# *51B1DB35010A_4B2A11BC0255_var*
begin
//#UC START# *51B1DB35010A_4B2A11BC0255_impl*
 l_Dir := GetFullPath2OutputFolderName;
 if DirExists(l_Dir) then
  DeleteFilesByMask(l_Dir, '*.*');
//#UC END# *51B1DB35010A_4B2A11BC0255_impl*
end;//TBaseTest.ClearTestFolder

function TBaseTest.OutputFolderNameWitEtalons: AnsiString;
 {* Директория для эталонов. }
//#UC START# *51B58D98028F_4B2A11BC0255_var*
//#UC END# *51B58D98028F_4B2A11BC0255_var*
begin
//#UC START# *51B58D98028F_4B2A11BC0255_impl*
 Result := OutputFolderName + '_Etalon';
//#UC END# *51B58D98028F_4B2A11BC0255_impl*
end;//TBaseTest.OutputFolderNameWitEtalons

function TBaseTest.GetFullPath2OutputFolderName: AnsiString;
//#UC START# *529C80A6019D_4B2A11BC0255_var*
//#UC END# *529C80A6019D_4B2A11BC0255_var*
begin
//#UC START# *529C80A6019D_4B2A11BC0255_impl*
 Result := GetAppTestSetPath + '\' + OutputFolderName;
//#UC END# *529C80A6019D_4B2A11BC0255_impl*
end;//TBaseTest.GetFullPath2OutputFolderName

function TBaseTest.CheckExternalPicture(aMakeEtalon: Boolean;
 const aCVSPath: AnsiString;
 var aCompareImage: Boolean): AnsiString;
//#UC START# *536A0DB9038B_4B2A11BC0255_var*
var
 i             : Integer;
 l_Ext         : AnsiString;
 l_CVS         : AnsiString;
 l_Path        : AnsiString;
 l_Count       : Integer;
 l_Extra       : AnsiString;
 l_CVSDir      : AnsiString;
 l_ExtraDiff   : AnsiString;
 l_ResultCode  : Tl3CompareImageResult;
 l_ExtraEtalon : AnsiString;
//#UC END# *536A0DB9038B_4B2A11BC0255_var*
begin
//#UC START# *536A0DB9038B_4B2A11BC0255_impl*
 if not TddPicturePathListner.Exists then Exit;
 l_Count := TddPicturePathListner.Instance.PathCount - 1;
 try
  if l_Count >= 0 then
  begin
   for i := 0 to l_Count do
   begin
    l_Path := TddPicturePathListner.Instance.GetPath(i);
    l_CVSDir := NormalDir(TddPicturePathListner.Instance.CorrectCVSPath(aCVSPath, l_Path));
    l_Extra := FileFromCurrent(l_Path);
    l_Ext := ExtractFileExt(l_Extra);
    l_ExtraEtalon := ChangeFileExt(l_Path, EtalonSuffix + l_Ext);
    l_CVS := NormalDir(l_CVSDir) + ExtractFileName(l_ExtraEtalon);
    if aMakeEtalon then
    begin
     CopyFile(l_Path, l_ExtraEtalon);
     if not FileExists(l_CVS) then
      CopyFile(l_Path, l_CVS)
    end // if aMakeEtalon then
    else
    begin
     l_ExtraEtalon := FileFromCurrent(l_ExtraEtalon);
     if GetFileSize(l_CVS) <= 0 then Continue;
     if FileExists(l_CVS) then
      CopyFile(l_CVS, l_ExtraEtalon, cmNoBakCopy);
     l_ExtraDiff := ChangeFileExt(l_Path, '.diff' + l_Ext);
     l_ResultCode := l3IsImageEqual(l_ExtraEtalon, l_Path, l_ExtraDiff);
     if l_ResultCode = l3_rImagesDissimilar then
     begin
      aCompareImage := False;
      Break;
     end; // if not l3IsImageEqual(l_ExtraEtalon, l_Path, l_ExtraDiff) then
    end;
   end; // for i := 0 to l_Count do
  end; // if l_Count > 0 then
  if not IsWritingToK and not aCompareImage then
   l3ShowDiffImage(l_ExtraDiff);
 finally
  if TddPicturePathListner.Exists then
   TddPicturePathListner.Instance.Clear;
 end;
 Result := l_ExtraDiff;
//#UC END# *536A0DB9038B_4B2A11BC0255_impl*
end;//TBaseTest.CheckExternalPicture

class function TBaseTest.IsWritingToK: Boolean;
//#UC START# *53BE80D30309_4B2A11BC0255_var*
//#UC END# *53BE80D30309_4B2A11BC0255_var*
begin
//#UC START# *53BE80D30309_4B2A11BC0255_impl*
 Result := KTestRunner.IsWritingToK;
//#UC END# *53BE80D30309_4B2A11BC0255_impl*
end;//TBaseTest.IsWritingToK

class function TBaseTest.HasTabs: Boolean;
//#UC START# *555EF1060354_4B2A11BC0255_var*
//#UC END# *555EF1060354_4B2A11BC0255_var*
begin
//#UC START# *555EF1060354_4B2A11BC0255_impl*
 Result := Tl3TabService.Instance.HasTabs;
//#UC END# *555EF1060354_4B2A11BC0255_impl*
end;//TBaseTest.HasTabs

procedure TBaseTest.CheckOutputWithInput(const aIn: AnsiString;
 const aOut: AnsiString;
 aHeaderBegin: AnsiChar;
 aEtalonNeedsComputerName: Boolean;
 aEtalonCanHaveDiff: Boolean;
 const anExtraFileName: AnsiString;
 aNeedsCheck: Boolean);
//#UC START# *4CAEDCF9006A_4B2A11BC0255_var*

 procedure ToUnicode(var aDiff : AnsiString);
 var
  l_In  : Text;
  l_Out : Tl3CustomFiler;
  l_S   : Tl3String;
  l_L   : AnsiString;
  l_Now : Cardinal;
 begin//ToUnicode
  l_Now := GetTickCount;
  while not FileExists(aDiff) do
  begin
   Sleep(300);
   CheckTimeout(l_Now, 20 * 60 * 1000);
  end;///while not FileExists(aDiff)
  l_S := Tl3String.Create;
  try
   AssignFile(l_In, aDiff);
   repeat
    try
     Reset(l_In);
    except
     continue;
    end;//try..except 
    break;
   until false;
   try
    aDiff := aDiff + '.uni';
    l_Out := Tl3CustomDosFiler.Make(aDiff, l3_fmWrite);
    try
     //l_Out.CodePage := CP_Unicode;
     l_Out.Open;
     try
      //l_Out.Write(#$FF#$FE);
      //l_Out.Write(#$FE#$FF);
      while not EOF(l_In) do
      begin
       System.ReadLn(l_In, l_L);
       l_S.AsString := l_L;
       l_S.CodePage := CP_Unicode;
       ConvertUTF16toUTF8(l_S.AsWideString, l_L, strictConversion, false);
       l_Out.Write(l_L);
       l_Out.OutEOL;
       l_S._CodePage := CP_ANSI;
      end;//while not EOF(l_In)
     finally
      l_Out.Close;
     end;//try..finally
    finally
     FreeAndNil(l_Out);
    end;//try..finally
   finally
    CloseFile(l_In);
   end;//try..finally
  finally
   FreeAndNil(l_S);
  end;//try..finally
 end;//ToUnicode

 procedure WaitDiff(const aDiff : AnsiString);
 var
  l_Counter : Integer;
 begin//WaitDiff
  Sleep(300);
  l_Counter := 10;
  while (l_Counter > 0) AND
        (not FileExists(aDiff) OR
         (l3FileUtils.GetFileSize(aDiff) <= 0)) do
  begin
   Sleep(300);
   Dec(l_Counter);
  end;///while not FileExists(aDiff)
 end;//WaitDiff

 procedure MakeDiff(const aIn, aOut : AnsiString; var aDiff : AnsiString);
 var
  l_Params : AnsiString;
  l_Bat    : AnsiString;
 begin//MakeDiff
  l_Bat := Format('%sd.cmd', [ExtractFilePath(ParamStr(0))]);
  Assert(FileExists(l_Bat), 'Не найдена утилита ' + l_Bat);
  l_Params := Format('%s "%s" "%s" "%s" "%s"', [l_Bat, aIn, aOut, aDiff, ExtractFilePath(ParamStr(0))]);
  WinExec(PAnsiChar(l_Params), SW_HIDE);
  WaitDiff(aDiff);
  ToUnicode(aDiff);
 end;//MakeDiff

 procedure MakeSDiff(const aIn, aOut : AnsiString; var aDiff : AnsiString);
 var
  l_Params : AnsiString;
  l_Bat    : AnsiString;
 begin//MakeSDiff
  l_Bat := Format('%ssd.cmd', [ExtractFilePath(ParamStr(0))]);
  Assert(FileExists(l_Bat), 'Не найдена утилита ' + l_Bat);
  l_Params := Format('%s "%s" "%s" "%s" %s', [l_Bat, aIn, aOut, aDiff, ExtractFilePath(ParamStr(0))]);
  WinExec(PAnsiChar(l_Params), SW_HIDE);
  WaitDiff(aDiff);
  ToUnicode(aDiff);
  if not IsWritingToK then
   if aNeedsCheck OR AlwaysShowAFC then
   begin
    l_Params := Format('afc.cmd "%s" "%s"', [aIn, aOut]);
    WinExec(PAnsiChar(l_Params), {SW_HIDE}SW_SHOWNORMAL);
 (*   l_Params := 'notepad ' + aDiff;
    WinExec(PAnsiChar(l_Params), {SW_HIDE}SW_SHOWNORMAL);*)
   end;//not IsWritingToK
 end;//MakeSDiff

 function MangleFileName(const aName : AnsiString): AnsiString;
 begin//MangleFileName
  Result := ExpandUNCFileName(l3Transliterate(aName));
  if (Result <> '') AND IsWritingToK then
  begin
   Result := Format('[[%s|^%s]]', [Result, ExtractFileName(Result)]);
  end;//IsWritingToK
 end;//MangleFileName

var
 l_Ext           : AnsiString;
 l_CVS           : AnsiString;
 l_Msg           : AnsiString;
 l_Diff          : AnsiString;
 l_UDiff         : AnsiString;
 l_SDiff         : AnsiString;
 l_Extra         : AnsiString;
 l_CVSPath       : AnsiString;
 l_Compared      : Boolean;
 l_ExtraDiff     : AnsiString;
 l_ExtraEtalon   : AnsiString;
 l_ComparedImage : Boolean;
//#UC END# *4CAEDCF9006A_4B2A11BC0255_var*
begin
//#UC START# *4CAEDCF9006A_4B2A11BC0255_impl*
 l_ComparedImage := True;
 if NeedCreateEtalonsWhileCheckingOutputWithInput then
 begin
  l_CVSPath := g_CVSPath + '\' + TestSetFolderName + '\';
  if not IsWritingToK OR aEtalonNeedsComputerName then
  begin
   if not FileExists(aIn) then
   begin
    CopyFile(aOut, aIn);
    if not IsFakeCVS then
    begin
     if OutputFolderName <> '' then
      l_CVSPath := l_CVSPath + OutputFolderNameWitEtalons + '\';
     if DirectoryExists(l_CVSPath) then
     begin
      l_CVS := l_CVSPath + ExtractFileName(aIn);
      if not FileExists(l_CVS) then
      begin
       CopyFile(aOut, l_CVS);
       ToLog(Format('Сделан эталон для помещения в CVS - "%s"', [l_CVS]));
      end;//not FileExists(l_CVS)
      CheckExternalPicture(True, l_CVSPath, l_ComparedImage);
     end;//DirectoryExists(l_CVSPath)
    end;//not IsFakeCVS
    l_Msg := Format('Эталон "%s" не существовал. Сделан новый на основе "%s"', [aIn, aOut]);
    if RaiseIfEtalonCreated AND not IsWritingToK then
     Check(false, l_Msg)
    else
     l3System.Msg2Log(l_Msg);
   end;//not FileExists(aIn)
  end;//not IsWritingToK
 end;//NeedCreateEtalonsWhileCheckingOutputWithInput 
 l_Compared := l3CompareFiles(aIn,
                              aOut,
                              aHeaderBegin);
 CheckExternalPicture(False, l_CVSPath, l_ComparedImage);
 if not l_Compared then
 begin
  if (ExtractFileExt(aOut) = '.png') OR (ExtractFileExt(aOut) = '.bmp') then
  begin
   if (ExtractFileExt(aOut) = '.png') then
    l3SetFuzzValueInPercent(5{17}{11})
   else
    l3SetFuzzValueInPercent(3);
   try
    l_Compared := l3IsImageEqual(aIn, aOut, ChangeFileExt(aOut, '.diff' + ExtractFileExt(aOut))) = l3_rImagesEqual;
   finally
    l3SetFuzzValueInPercent(-1);
   end;//try..finally 
  end;//ExtractFileExt(aOut) = '.png'
 end;//not l_Compared
 if not l_Compared or (not l_ComparedImage and IsWritingToK) then // Для К будем делать по старинке...
 begin
  if not l_ComparedImage and (anExtraFileName <> '') then
  begin
   l_Extra := FileFromCurrent(anExtraFileName);
   l_Ext := ExtractFileExt(l_Extra);
   l_ExtraEtalon := ChangeFileExt(anExtraFileName, EtalonSuffix + l_Ext);
   l_ExtraEtalon := FileFromCurrent(l_ExtraEtalon);
   if ANSISametext(l_Ext, '.png') then
   begin
    l_ExtraDiff := ChangeFileExt(anExtraFileName, '.diff' + l_Ext);
    l_ExtraDiff := OutputPath + l_ExtraDiff;
    l3BuildComparisonImage(l_ExtraEtalon, l_Extra, l_ExtraDiff);
   end//ANSISametext(l_Ext, '.png')
   else
    l_ExtraDiff := '';
  end//anExtraFileName <> ''
  else
   l_Extra := '';
  l_Diff := aOut + '.diff.log';
  l_UDiff := l_Diff;
  l_SDiff := aOut + '.sdiff.log';
  MakeDiff(aIn, aOut, l_UDiff);
  MakeSDiff(aIn, aOut, l_SDiff);
  if IsWritingToK then
  begin
   {$If defined(MTDORB) AND defined(NoKPageTool)}
   if TKBridge.Exists then
   {$IfEnd} //MTDORB AND NoKPageTool
   begin
    TKTestListener.AttachFile(TKTestListener.ResultsPage, aIn);
    TKTestListener.AttachFile(TKTestListener.ResultsPage, aOut);
    TKTestListener.AttachFile(TKTestListener.ResultsPage, l_UDiff);
    TKTestListener.AttachFile(TKTestListener.ResultsPage, l_SDiff);
    if (l_Extra <> '') then
    begin
     TKTestListener.AttachFile(TKTestListener.ResultsPage, l_Extra);
     TKTestListener.AttachFile(TKTestListener.ResultsPage, l_ExtraEtalon);
    end;//l_Extra <> ''
    if (l_ExtraDiff <> '') then
     TKTestListener.AttachFile(TKTestListener.ResultsPage, l_ExtraDiff);
   end;//TKBridge.Exists
  end;//IsWritingToK
  if aEtalonCanHaveDiff then
  begin
   l_Compared := true;
   CheckOutputWithInput(FileFromCurrent(ExtractFileName(l_Diff) + '.' + ComputerName + '.etalon'),
                        l_Diff,
                        #0,
                        true,
                        false,
                        '',
                        true);
  end;//aEtalonCanHaveDiff
 end;//not l_Compared
 if not l_Compared then
 begin
  l_Msg := Format('Не прошло сравнение: afc "%s" "%s".'+ #13#10 +
               'Результаты сравнения: "%s" "%s"',
               [MangleFileName(aIn),
                MangleFileName(aOut),
                MangleFileName(l_UDiff),
                MangleFileName(l_SDiff)
               ]);
  if (l_Extra <> '') then
   l_Msg := l_Msg + #13#10 +
            Format('Дополнительное сравнение: afc %s %s',
                   [MangleFileName(l_Extra),
                    MangleFileName(l_ExtraEtalon)
                   ]);
  if (l_ExtraDiff <> '') then
   l_Msg := l_Msg + #13#10 +
            Format('Разница: %s',
                   [MangleFileName(l_ExtraDiff)
                   ]);
  if aNeedsCheck then
   Check(l_Compared, l_Msg)
  else
  begin
(*   if IsWritingToK then
    TKTestListener.WriteMsg(l_Msg)
    // - это чтобы было нормальное wiki-оформление
   else*)
    l3System.Msg2Log(l_Msg);
   Exit; 
  end;//aNeedsCheck
 end;//not l_Compared
 ToLog('Compare done');
//#UC END# *4CAEDCF9006A_4B2A11BC0255_impl*
end;//TBaseTest.CheckOutputWithInput

procedure TBaseTest.CheckWithEtalon(const aFileName: AnsiString;
 aHeaderBegin: AnsiChar);
//#UC START# *4DD533BF023D_4B2A11BC0255_var*
var
 l_S : AnsiString;
//#UC END# *4DD533BF023D_4B2A11BC0255_var*
begin
//#UC START# *4DD533BF023D_4B2A11BC0255_impl*
 l_S := ExtractFileName(aFileName) + EtalonSuffix + ExtractFileExt(aFileName);
 CheckOutputWithInput(FileFromCurrent(l_S), aFileName, aHeaderBegin,
                      false, false, '', true);
//#UC END# *4DD533BF023D_4B2A11BC0255_impl*
end;//TBaseTest.CheckWithEtalon

procedure TBaseTest.CheckOutputWithInput(const aSt: AnsiString;
 aHeaderBegin: AnsiChar = #0;
 const anExtraFileName: AnsiString = '';
 aNeedsCheck: Boolean = True);
//#UC START# *4F5F3C61023E_4B2A11BC0255_var*
//#UC END# *4F5F3C61023E_4B2A11BC0255_var*
begin
//#UC START# *4F5F3C61023E_4B2A11BC0255_impl*
 CheckOutputWithInput(FileFromCurrent(aSt),
                      FileForOutput,
                      aHeaderBegin,
                      EtalonNeedsComputerName,
                      EtalonCanHaveDiff,
                      anExtraFileName,
                      aNeedsCheck);
//#UC END# *4F5F3C61023E_4B2A11BC0255_impl*
end;//TBaseTest.CheckOutputWithInput

procedure TBaseTest.CheckPictureOnly;
//#UC START# *536A15F901DA_4B2A11BC0255_var*
var
 l_CVSPath: AnsiString;

 function lp_FindEtalon: Boolean;
 var
  l_CVS        : AnsiString;
  l_Path       : AnsiString;
  l_CVSDir     : AnsiString;
  l_ExtraEtalon: AnsiString;
 begin
  Result := False;
  if not TddPicturePathListner.Exists then Exit;
  if TddPicturePathListner.Instance.PathCount > 0 then
  begin
   l_CVSDir := NormalDir(l_CVSPath) + TddPicturePathListner.Instance.TestName;
   if not DirectoryExists(l_CVSDir) then Exit;
   l_Path := TddPicturePathListner.Instance.GetPath(0);
   l_ExtraEtalon := ChangeFileExt(l_Path, EtalonSuffix + ExtractFileExt(l_Path));
   l_CVS := NormalDir(l_CVSDir) + ExtractFileName(l_ExtraEtalon);
   Result := FileExists(l_CVS)
  end; // if TddPicturePathListner.Instance.PathCount > 0 then
 end;

var
 l_ExtDiffName  : AnsiString;
 l_ComparedImage: Boolean;
//#UC END# *536A15F901DA_4B2A11BC0255_var*
begin
//#UC START# *536A15F901DA_4B2A11BC0255_impl*
 l_CVSPath := g_CVSPath + '\' + TestSetFolderName + '\';
 if not IsWritingToK then
 begin
  if not IsFakeCVS then
  begin
   if OutputFolderName <> '' then
    l_CVSPath := l_CVSPath + OutputFolderNameWitEtalons + '\';
   if DirectoryExists(l_CVSPath) and not lp_FindEtalon then
    CheckExternalPicture(True, l_CVSPath, l_ComparedImage);
  end; // if not IsFakeCVS then
 end; // if not IsWritingToK then
 l_ComparedImage := True;
 l_ExtDiffName := CheckExternalPicture(False, l_CVSPath, l_ComparedImage);
 if l_ComparedImage then
  ToLog('Compare done')
 else
 begin
  Check(False, Format('Не прошло сравнение картинок. Файл для сравнений: %s', [l_ExtDiffName]));
  if IsWritingToK then
  begin
   {$If defined(MTDORB) AND defined(NoKPageTool)}
   if TKBridge.Exists then
   {$IfEnd} //MTDORB AND NoKPageTool
   begin
    if (l_ExtDiffName <> '') then
     TKTestListener.AttachFile(TKTestListener.ResultsPage, l_ExtDiffName);
   end;//TKBridge.Exists
  end;//IsWritingToK
 end; // if not l_ComparedImage then
//#UC END# *536A15F901DA_4B2A11BC0255_impl*
end;//TBaseTest.CheckPictureOnly

procedure TBaseTest.Cleanup;
//#UC START# *4B2F40FD0088_4B2A11BC0255_var*
//#UC END# *4B2F40FD0088_4B2A11BC0255_var*
begin
//#UC START# *4B2F40FD0088_4B2A11BC0255_impl*
 FreeAndNil(f_Starts);
 inherited;
//#UC END# *4B2F40FD0088_4B2A11BC0255_impl*
end;//TBaseTest.Cleanup

function TBaseTest.GetEnabled: Boolean;
//#UC START# *4C07996901BE_4B2A11BC0255_var*
//#UC END# *4C07996901BE_4B2A11BC0255_var*
begin
//#UC START# *4C07996901BE_4B2A11BC0255_impl*
(* Result := (ClassName = 'TK235875079');
 Exit;*)
(* Result := (ClassName = 'TK259164768') OR
           (ClassName = 'TK235869064');
 Exit;*)
 if IsTestExcluded(Self) then
  Result := false
 else
  Result := inherited GetEnabled;
//#UC END# *4C07996901BE_4B2A11BC0255_impl*
end;//TBaseTest.GetEnabled

procedure TBaseTest.SetEnabled(Value: Boolean);
//#UC START# *4C446D7903B7_4B2A11BC0255_var*
//#UC END# *4C446D7903B7_4B2A11BC0255_var*
begin
//#UC START# *4C446D7903B7_4B2A11BC0255_impl*
 if Value then
  if IsTestExcluded(Self) then
   Value := false;
 inherited SetEnabled(Value);
//#UC END# *4C446D7903B7_4B2A11BC0255_impl*
end;//TBaseTest.SetEnabled

procedure TBaseTest.DoClearEtalon;
//#UC START# *51B1DD8E0018_4B2A11BC0255_var*
var
 l_Dir: AnsiString;
//#UC END# *51B1DD8E0018_4B2A11BC0255_var*
begin
//#UC START# *51B1DD8E0018_4B2A11BC0255_impl*
 l_Dir := FileFromCurrent(OutputFolderNameWitEtalons);
 DelDir(l_Dir);
 l_Dir := FileFromCurrent(OutputFolderNameWitEtalons);
 DelDir(l_Dir);
//#UC END# *51B1DD8E0018_4B2A11BC0255_impl*
end;//TBaseTest.DoClearEtalon
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

end.

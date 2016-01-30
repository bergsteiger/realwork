unit KTestRunner;

// Модуль: "w:\common\components\rtl\Garant\DUnitTuning\KTestRunner.pas"
// Стереотип: "UtilityPack"

{$Include tfwDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
uses
 l3IntfUses
 , BaseTest
 , TestNameList
 , TextTestRunner
 , l3Filer
 , l3Interfaces
 , TestFrameWork
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Core
 , l3Except
 , Classes
;

type
 TKFileOperation = (
  {* Операция с файлом в К }
  foGet
   {* Прочитать файл }
  , foSet
   {* Записать файл }
  , foGetLabel
   {* Получить метки }
  , foSetLabel
   {* Установить метки }
  , foAttach
 );//TKFileOperation

 TTimeInfoName = object
  public
   rSubName: AnsiString;
   rName: AnsiString;
  public
   function Compare(const aName: TTimeInfoName): Integer;
 end;//TTimeInfoName

 PTimeInfo = ^TTimeInfo;

 TTimeInfo = object
  {* Информация о замере времени }
  public
   rDate: TDateTime;
   rTime: Cardinal;
   rID: TTimeInfoName;
  public
   function Compare: Integer;
   function EQ: Boolean;
 end;//TTimeInfo

 {$Define l3Items_NeedsAssignItem}

 _ItemType_ = TTimeInfo;
 _l3RecordWithEQList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3RecordWithEQList.imp.pas}
 TTimeInfoList = class(_l3RecordWithEQList_)
  {* Список замеров времени }
  public
   procedure Compact(aCount: Integer);
    {* Минимизирует число замеров в графике до указанного числа }
   procedure DeleteOld(aDateDelta: Integer);
    {* Удаляет старые замеры }
 end;//TTimeInfoList

 TKTestListener = class(TTextTestListener)
  {* Тест, выводящий результаты в К }
  private
   f_TimeInfo: TTimeInfoList;
   f_FailedTests: TextFile;
   f_AllRunnedTests: TextFile;
    {* Список всех прошедших тестов }
   f_RunnedCount: Integer;
  private
   procedure ToLog(const aSt: AnsiString);
   procedure PutFileToK(aPageID: Integer;
    const aFileName: AnsiString);
   procedure TimeToLog(aTime: Cardinal;
    const aSt: AnsiString;
    const aSubName: AnsiString);
   procedure GetFileFromK(aPageID: Integer;
    const aFileName: AnsiString);
    {* Получает файл из К }
   procedure GetTimesFromK;
    {* Получает из К замеры времени }
   procedure CheckTimeInfo;
    {* Проверяет, что список времён создан }
   function TimesPage: Integer;
   function TimesFileName: AnsiString;
   function ResultsFileName: AnsiString;
   class function IsFakeK: Boolean;
   procedure PutTimesToK;
    {* Выводит в К замеры времени }
   {$If NOT Defined(NoKPageTool)}
   function GetLabelsFileName: AnsiString;
    {* Возвращает имя файла с метками страницы тестов }
   {$IfEnd} // NOT Defined(NoKPageTool)
   class function IsFakeCVS: Boolean;
    {* Не класть эталоны в CVS }
   function FailedTestsFileName: AnsiString;
   class function TestNameForOutputInTestLists(const aTest: ITest): AnsiString;
    {* Имя теста для вывода в список неудачных тестов и в полный список прогнанных тестов }
   function AllRunnedTestsFileName: AnsiString;
   procedure WriteTestToAllRunnedTests(const aTest: ITest);
   procedure AddMemoryStat(const aTestName: AnsiString);
  protected
   procedure PutResultsToK;
   function GetLabels: AnsiString;
    {* Возвращает метки страницы с тестами }
   class procedure write(const aStr: AnsiString); override;
   class procedure writeln(const aStr: AnsiString = ''); override;
   procedure Cleanup; override;
   procedure InitFields; override;
   function NeedsMilliseconds: Boolean; override;
    {* Выводить ли милисекунды }
   function PrintErrorItem(i: Integer;
    r: TTestFailure): AnsiString; override;
   procedure TestingStarts; override;
   procedure TestingEnds(testResult: TTestResult); override;
   procedure StartTest(test: ITest); override;
  public
   class procedure CommunicateWithK(aPageID: Integer;
    const aFileName: AnsiString;
    anOp: TKFileOperation);
   class function ResultsPage: Integer;
   class procedure WriteMsg(const aStr: AnsiString);
   class procedure AttachFile(aPage: Integer;
    const aFile: AnsiString);
   procedure AddSuccess(const test: ITest); override;
   procedure AddError(error: TTestFailure); override;
   procedure AddFailure(failure: TTestFailure); override;
 end;//TKTestListener

 RTestResultsPlace = class of TTestResultsPlace;

 TTestResultsPlaces = array of RTestResultsPlace;

 TTestResultsPlace = class
  {* Место для складывания результатов тестов }
  protected
   class function HasTabs: Boolean;
   class function CommandLineKey: AnsiString; virtual; abstract;
    {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
   class function TimesPage: Integer; virtual; abstract;
    {* Страница для вывода замеров времени }
   class function ResultsPage: Integer; virtual; abstract;
    {* Страница для вывода результатов тестов }
   class function IsGK: Boolean; virtual;
    {* Тесты запущены ГК }
   class function IsLAW: Boolean; virtual;
 end;//TTestResultsPlace

function TTimeInfo_C(aDate: TDateTime;
 const aName: AnsiString;
 aTime: Cardinal;
 const aSubName: AnsiString): TTimeInfo; overload;
function TTimeInfo_C: TTimeInfo; overload;
function TTimeInfo_C: TTimeInfo; overload;
function TTimeInfo_C: TTimeInfo; overload;
procedure RunRegisteredTests;
function NeedKTestRunner(const aPlaces: array of RTestResultsPlace): Boolean;
function IsWritingToK: Boolean;
 {* Пишем результаты тестов в К }
function IsGK: Boolean;
 {* Тесты запущены ГК }
function IsLAW: Boolean;
function IsTestExcluded(aTest: TBaseTest): Boolean;
 {* Ислючён ли тест из запуска }
function FileFromCurrent(const aStr: AnsiString;
 anFolderScript: Boolean;
 aCheckFolderOnly: Boolean): AnsiString;
 {* Файл из текущей директории с эталонами }
function IsFakeCVS: Boolean;
 {* Не класть эталоны в CVS }
function CheckTestExcluded(const aTestName: AnsiString;
 const aFolderName: AnsiString): Boolean;
 {* Проверяет находилтся ли тест в списках выключенных. }
function CheckFolderExcluded(const aFolderName: AnsiString): Boolean;
 {* Проверить папку на исключенные. }
procedure DeleteEtalons(const aTestName: AnsiString;
 const aSubFiler: AnsiString;
 anIsScript: Boolean);
 {* Удаляет эталоны для теста. }
procedure LoadExcludedFromFile(const aFileName: AnsiString);
 {* Загрузка исключенных тестов из файла. }
function GetCVSTestSetPath: AnsiString;
 {* Возвращает путь к хранилищу тестов из CVS }
function GetAppTestSetPath: AnsiString;
 {* Возвращает путь к хранилищу тестов приложения. }
procedure LoadTestNamesFromFile(const aFileName: AnsiString;
 anOperation: TLoadOperation);
 {* Загрузка имен тестов для выполнения из файла. }
function NeedRunTest(const aTestName: AnsiString): Boolean;
 {* Проверяет нужно ли запускать тест (наличие его названия в списке загруженных). }
procedure CheckFileParam;
 {* Проверяет есть ли параметр для загрузки непрошедших тестов. }
procedure CheckNeedRandom;
function NeedRandom: Boolean;
procedure CheckIgnoreCVS;
function IgnoreCVSPath: Boolean;
procedure ClearTestNamesList;
procedure LoadDocumentIDList;
 {* Загружает список тестов и номеров документов. }
function FindDocID(const aTestName: AnsiString): AnsiString;
 {* Ищет номер доукумента по номеру теста. }

var g_CVSPath: AnsiString;
 {* Путь к тестам в CVS }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
 , ExcludedTests
 , ExcludedTestsFolders
 , TestDocumentList
 , vtVerInf
 , l3VersionInfoService
 , l3Chars
 , SysUtils
 , JclSysInfo
 , l3FileUtils
 , l3DateSt
 , StrUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3SysUtils
 {$If Defined(MTDORB) AND Defined(NoKPageTool)}
 , KBridge
 {$IfEnd} // Defined(MTDORB) AND Defined(NoKPageTool)
 {$If Defined(MTDORB)}
 , Contents_int
 {$IfEnd} // Defined(MTDORB)
 , tfwKConst
 , l3Base
 , l3MinMax
 , RTLConsts
 , Windows
 , l3Stream
 , l3String
 , JwaWinBase
;

var f_File: TextFile;
var f_IsFakeK: Boolean = False;
var f_FakeKValid: Boolean = False;
var f_FakeCVSValid: Boolean = False;
var f_IsFakeCVS: Boolean = False;
var g_ResultsPlace: RTestResultsPlace;
 {* Информация о месте вывода результатов теста }
var g_CVSTestSetPath: AnsiString;
var g_AppTestSetPath: AnsiString;
var g_Random: Boolean;
var g_IgnoreCVS: Boolean;

const
 Header = 'h4. ';
 Chart = '{chart';
 Columns = '|| Day || ';
 Anchor = '{anchor:';
 Task = 'Запрос - ';

function TTimeInfo_C(aDate: TDateTime;
 const aName: AnsiString;
 aTime: Cardinal;
 const aSubName: AnsiString): TTimeInfo;
//#UC START# *4B6C40530304_4B2F565002FD_var*
//#UC END# *4B6C40530304_4B2F565002FD_var*
begin
//#UC START# *4B6C40530304_4B2F565002FD_impl*
 Result.rDate := aDate;
 Result.rID.rName := Trim(aName);
 Result.rTime := aTime;
 if (aSubName = '') then
  Result.rID.rSubName := 'Time'
 else
  Result.rID.rSubName := Trim(aSubName);
//#UC END# *4B6C40530304_4B2F565002FD_impl*
end;//TTimeInfo_C

function TTimeInfo_C: TTimeInfo;
//#UC START# *4B2F582A0382_4B2F565002FD_var*
//#UC END# *4B2F582A0382_4B2F565002FD_var*
begin
//#UC START# *4B2F582A0382_4B2F565002FD_impl*
 Result := TTimeInfo_C(Date, aName, aTime);
//#UC END# *4B2F582A0382_4B2F565002FD_impl*
end;//TTimeInfo_C

function TTimeInfo_C: TTimeInfo;
//#UC START# *4B588AFA0000_4B2F565002FD_var*
//#UC END# *4B588AFA0000_4B2F565002FD_var*
begin
//#UC START# *4B588AFA0000_4B2F565002FD_impl*
 Result := TTimeInfo_C(aDate, aName, aTime, '');
//#UC END# *4B588AFA0000_4B2F565002FD_impl*
end;//TTimeInfo_C

function TTimeInfo_C: TTimeInfo;
//#UC START# *4B58926401DE_4B2F565002FD_var*
//#UC END# *4B58926401DE_4B2F565002FD_var*
begin
//#UC START# *4B58926401DE_4B2F565002FD_impl*
 Result := TTimeInfo_C(Date, aName, aTime, aSubName);
//#UC END# *4B58926401DE_4B2F565002FD_impl*
end;//TTimeInfo_C

procedure CheckExcludedTests;
 {* Проверяет был ли загружен список исключенных тестов. }
//#UC START# *4D19A727015E_4B2A6D4303A9_var*
const
 csFileParam = '-ExcludedFile:';
 cnParamLen  = Length(csFileParam);
 csExcludeFileName = '!excluded.tests.txt';
 csExcludeFileNameMask = '!%s.excluded.tests.txt';
var
 i          : Integer;
 l_Param    : AnsiString;
 l_LenParam : Integer;
//#UC END# *4D19A727015E_4B2A6D4303A9_var*
begin
//#UC START# *4D19A727015E_4B2A6D4303A9_impl*
 if not TExcludedTests.Exists then
 begin
  for i := 1 to ParamCount do
  begin
   l_Param := ParamStr(i);
   l_LenParam := Length(l_Param);
   if (cnParamLen < l_LenParam) and AnsiStartsText(csFileParam, l_Param) then
   begin
    l_Param := Copy(l_Param, cnParamLen + 1, l_LenParam - cnParamLen);
    Break;
   end // if Pos(csFileParam, l_Param) > 0 then
   else
    l_Param := '';
  end; // for i := 1 to ParamCount do
  if l_Param = '' then
  begin
   l_Param := FileFromCurrent(csExcludeFileName, false, false);
   TExcludedTests.Instance.LoadFromFile(l_Param);
   l_Param := FileFromCurrent(Format(csExcludeFileNameMask, [TBaseTest.ComputerName]), false, false);
   TExcludedTests.Instance.LoadFromFile(l_Param);
  end; // if l_Param = '' then
 end;
//#UC END# *4D19A727015E_4B2A6D4303A9_impl*
end;//CheckExcludedTests

procedure RunRegisteredTests;
//#UC START# *4B2A6D840279_4B2A6D4303A9_var*
//#UC END# *4B2A6D840279_4B2A6D4303A9_var*
begin
//#UC START# *4B2A6D840279_4B2A6D4303A9_impl*
 CheckFileParam;
 CheckNeedRandom;
 CheckExcludedTests;
 TextTestListenerClass := TKTestListener;
 TextTestRunner.RunRegisteredTests;
//#UC END# *4B2A6D840279_4B2A6D4303A9_impl*
end;//RunRegisteredTests

function NeedKTestRunner(const aPlaces: array of RTestResultsPlace): Boolean;
//#UC START# *4B2A6DAE039F_4B2A6D4303A9_var*
var
 l_Index : Integer;
 l_J     : Integer;
//#UC END# *4B2A6DAE039F_4B2A6D4303A9_var*
begin
//#UC START# *4B2A6DAE039F_4B2A6D4303A9_impl*
 Result := false;
 g_ResultsPlace := nil;
 for l_Index := 1 to ParamCount do
 begin
  for l_J := Low(aPlaces) to High(aPlaces) do
   if (ParamStr(l_Index) = aPlaces[l_J].CommandLineKey) then
   begin
    g_ResultsPlace := aPlaces[l_J];
    Assert(g_ResultsPlace.TimesPage <> g_ResultsPlace.ResultsPage);
    Result := true;
    break;
   end;//ParamStr(l_Index) = aPlaces[l_J].CommandLineKey
  if Result then
   break; 
 end;//for l_Index
//#UC END# *4B2A6DAE039F_4B2A6D4303A9_impl*
end;//NeedKTestRunner

function IsWritingToK: Boolean;
 {* Пишем результаты тестов в К }
//#UC START# *4BB376F00348_4B2A6D4303A9_var*
//#UC END# *4BB376F00348_4B2A6D4303A9_var*
begin
//#UC START# *4BB376F00348_4B2A6D4303A9_impl*
 Result := (g_ResultsPlace <> nil);
//#UC END# *4BB376F00348_4B2A6D4303A9_impl*
end;//IsWritingToK

function IsGK: Boolean;
 {* Тесты запущены ГК }
//#UC START# *4BEA99B1033C_4B2A6D4303A9_var*
//#UC END# *4BEA99B1033C_4B2A6D4303A9_var*
begin
//#UC START# *4BEA99B1033C_4B2A6D4303A9_impl*
 if (g_ResultsPlace = nil) then
  Result := false
 else
  Result := g_ResultsPlace.IsGK;
//#UC END# *4BEA99B1033C_4B2A6D4303A9_impl*
end;//IsGK

function IsLAW: Boolean;
//#UC START# *4C35A6FB027C_4B2A6D4303A9_var*
//#UC END# *4C35A6FB027C_4B2A6D4303A9_var*
begin
//#UC START# *4C35A6FB027C_4B2A6D4303A9_impl*
 if (g_ResultsPlace = nil) then
  Result := false
 else
  Result := g_ResultsPlace.IsLAW;
//#UC END# *4C35A6FB027C_4B2A6D4303A9_impl*
end;//IsLAW

function IsTestExcluded(aTest: TBaseTest): Boolean;
 {* Ислючён ли тест из запуска }
//#UC START# *4C4467E300C2_4B2A6D4303A9_var*
var
 l_Name: AnsiString;
//#UC END# *4C4467E300C2_4B2A6D4303A9_var*
begin
//#UC START# *4C4467E300C2_4B2A6D4303A9_impl*
 if aTest.IsScript then
  l_Name := aTest.Name
 else
  l_Name := aTest.ClassName;
 if IsWritingToK then
 begin
  if not CheckTestExcluded(l_Name, aTest.Folder) then
  begin
   Result := false;
   if aTest.NotForTerminalSession then
   // - пытаемся не гонять заведомо падающие тесты
   begin
    if not SameText(SysUtils.GetEnvironmentVariable('SESSIONNAME'), 'Console') then
    // - не подключены к консоли
    begin
     if (WTSGetActiveConsoleSessionId = 0) then
     // - типа нет устройства вывода
      Result := true
     else
     if SameText(SysUtils.GetEnvironmentVariable('SESSIONNAME'), '') then
      Result := true;
     if Result then
     // - пишем диагностику в лог
      l3System.Msg2Log(aTest.ClassName + '.' + aTest.Name + ' disabled in disconnected session');
    end;//not SameText(GetEnvironmentVariable('SESSIONNAME'), 'Console')
   end;//aTest.NotForTerminalSession
  end//not CheckTestExcluded(aTest.ClassName, aTest.Folder)
  else
   Result := true;
  if not Result then
   //if IsWritingToK then
    if not NeedRunTest(l_Name) then
     Result := true; 
 end//IsWritingToK
 else
  Result := false;
//#UC END# *4C4467E300C2_4B2A6D4303A9_impl*
end;//IsTestExcluded

function FileFromCurrent(const aStr: AnsiString;
 anFolderScript: Boolean;
 aCheckFolderOnly: Boolean): AnsiString;
 {* Файл из текущей директории с эталонами }
//#UC START# *4C44691E00D2_4B2A6D4303A9_var*
var
 l_Path : AnsiString;
 l_NoSuffix : Boolean;
 l_Folder : AnsiString;
 l_IsDict : Boolean;
//#UC END# *4C44691E00D2_4B2A6D4303A9_var*
begin
//#UC START# *4C44691E00D2_4B2A6D4303A9_impl*
 try
  if aCheckFolderOnly then
  begin
   Assert(not anFolderScript);
   l_Path := g_CVSPath + '\' + TBaseTest.TestSetFolderName + '\' + aStr + '\';
   if not DirectoryExists(l_Path) or g_IgnoreCVS then
   begin
    l_Path := ExtractFilePath(ParamStr(0)) + TBaseTest.TestSetFolderName + '\' + aStr + '\';
    if not DirectoryExists(l_Path) then
     raise Exception.CreateFmt('Папка с эталонами %s не существует', [l_Path]);
   end;//not DirectoryExists(l_Path)
   Result := l_Path;
  end//aCheckFolderOnly
  else
  begin
   l_Path := ExtractFilePath(aStr);
   l_IsDict := ANSIStartsText('Dictionary\', l_Path) OR
               ANSIStartsText('Common\', l_Path) OR
               ANSIStartsText('Presets\', l_Path) OR
               ANSIStartsText('Macros\', l_Path)
               ;
   if (l_Path <> '') AND
      not anFolderScript AND
      not ANSIStartsText('Scripts\', l_Path) AND
      not ANSIStartsText('Auto\', l_Path) AND
      not l_IsDict then
    Result := aStr
   else
   begin
    l_NoSuffix := ANSIStartsText('Common\', l_Path);
    l_Folder := TBaseTest.TestSetFolderName(l_NoSuffix) + '\';
    if l_IsDict then
     l_Folder := ANSIReplaceStr(l_Folder, '\Tabs\', '\');
    l_Path := g_CVSPath + '\' + l_Folder + aStr;
    if DirectoryExists(ExtractFilePath(l_Path)) and not g_IgnoreCVS then
    begin
     Result := l_Path;
     if FileExists(Result) then
      Exit;
    end;//DirectoryExists(l_Path)
    Result := ExtractFilePath(ParamStr(0)) + l_Folder + aStr;
   end;//ExtractFilePath(aStr) <> ''
  end;//aCheckFolderOnly
 finally
  if (Length(Result) > 2) then
   if (Result[2] = ':') then
    l3MakeLowerCase(@Result[1], 1); 
 end;//try..finally
//#UC END# *4C44691E00D2_4B2A6D4303A9_impl*
end;//FileFromCurrent

function IsFakeCVS: Boolean;
 {* Не класть эталоны в CVS }
//#UC START# *4CA9DF26032E_4B2A6D4303A9_var*
//#UC END# *4CA9DF26032E_4B2A6D4303A9_var*
begin
//#UC START# *4CA9DF26032E_4B2A6D4303A9_impl*
 Result := TKTestListener.IsFakeCVS;
//#UC END# *4CA9DF26032E_4B2A6D4303A9_impl*
end;//IsFakeCVS

function CheckTestExcluded(const aTestName: AnsiString;
 const aFolderName: AnsiString): Boolean;
 {* Проверяет находилтся ли тест в списках выключенных. }
//#UC START# *4CFDD3FE01F7_4B2A6D4303A9_var*
var
 l_Index : Integer;
//#UC END# *4CFDD3FE01F7_4B2A6D4303A9_var*
begin
//#UC START# *4CFDD3FE01F7_4B2A6D4303A9_impl*
 CheckExcludedTests;
 Result := TExcludedTests.Instance.FindData(aTestName, l_Index);
 if not Result then
  Result := CheckFolderExcluded(aFolderName);
//#UC END# *4CFDD3FE01F7_4B2A6D4303A9_impl*
end;//CheckTestExcluded

function CheckFolderExcluded(const aFolderName: AnsiString): Boolean;
 {* Проверить папку на исключенные. }
//#UC START# *4CFDD9AA0156_4B2A6D4303A9_var*
var
 l_Index : Integer;
//#UC END# *4CFDD9AA0156_4B2A6D4303A9_var*
begin
//#UC START# *4CFDD9AA0156_4B2A6D4303A9_impl*
 if not TExcludedTestsFolders.Exists then
  TExcludedTestsFolders.Instance.LoadFromFile(FileFromCurrent('!excluded.tests.folders.txt', false, false));
 Result := TExcludedTestsFolders.Instance.FindData(aFolderName, l_Index);
//#UC END# *4CFDD9AA0156_4B2A6D4303A9_impl*
end;//CheckFolderExcluded

procedure DeleteEtalons(const aTestName: AnsiString;
 const aSubFiler: AnsiString;
 anIsScript: Boolean);
 {* Удаляет эталоны для теста. }
//#UC START# *4D189B760354_4B2A6D4303A9_var*

 procedure TryClearDir(const aTestName: AnsiString);
 var
  l_AppTestFolder : AnsiString;
  l_CVSTestFolder : AnsiString;

  procedure ClearPictures;
  var
   l_PicExists : Boolean;
  begin
   if DirectoryExists(l_CVSTestFolder) then
   begin
    l_PicExists := FileExists(l_CVSTestFolder + '\*.png');
    if not l_PicExists then
     l_PicExists := FileExists(l_CVSTestFolder + '\*.jpg');
    if not l_PicExists then
     l_PicExists := FileExists(l_CVSTestFolder + '\*.emf');
    if not l_PicExists then
     l_PicExists := FileExists(l_CVSTestFolder + '\*.wmf');
    if l_PicExists then
    begin
     PureDir(l_CVSTestFolder);
     if DirectoryExists(l_AppTestFolder) then
      PureDir(l_AppTestFolder);
    end; // if l_JpgExists or l_PngExists then
   end; // if DirectoryExists(l_TestFolder) then
  end;

 var
  l_SubFolder  : AnsiString;
 begin
  l_SubFolder := TryDeleteSrciptExtention(aTestName);
  l_AppTestFolder := GetAppTestSetPath + l_SubFolder;
  l_CVSTestFolder := GetCVSTestSetPath + '\' + l_SubFolder;
  ClearPictures;
  l_AppTestFolder := GetAppTestSetPath + 'ForPicture\' + l_SubFolder;
  l_CVSTestFolder := GetCVSTestSetPath + '\ForPicture\' + l_SubFolder;
  ClearPictures;
 end;

 procedure DoDel(const aTestMask : AnsiString);
 var
  l_SimpleMask         : AnsiString;
  l_ComplexMask        : AnsiString;
  l_ComplexComplexMask : AnsiString;
  l_TestFolder         : AnsiString;
 begin//DoDel
  l_ComplexMask := aTestMask + '.*.etalon.*';
  l_ComplexComplexMask := aTestMask + '.*.*.etalon.*';
  l_SimpleMask := aTestMask + '.etalon.*';
  l_TestFolder := GetCVSTestSetPath;
  if aSubFiler <> '' then
   l_TestFolder := l_TestFolder + '\' + aSubFiler;
  if DirectoryExists(l_TestFolder) then
  begin
   DeleteFilesByMask(l_TestFolder, l_ComplexComplexMask);
   DeleteFilesByMask(l_TestFolder, l_ComplexMask);
   DeleteFilesByMask(l_TestFolder, l_SimpleMask);
  end; // if DirectoryExists(l_TestFolder) then
  l_TestFolder := GetAppTestSetPath;
  if aSubFiler <> '' then
   l_TestFolder := l_TestFolder + '\' + aSubFiler;
  if DirectoryExists(l_TestFolder) then
  begin
   DeleteFilesByMask(l_TestFolder, l_ComplexComplexMask);
   DeleteFilesByMask(l_TestFolder, l_ComplexMask);
   DeleteFilesByMask(l_TestFolder, l_SimpleMask);
  end; // if DirectoryExists(l_TestFolder) then
 end;//DoDel

var
 l_TestMask : AnsiString;
//#UC END# *4D189B760354_4B2A6D4303A9_var*
begin
//#UC START# *4D189B760354_4B2A6D4303A9_impl*
 if anIsScript then
 begin
  l_TestMask := aTestName;
  DoDel(l_TestMask);
  if Pos('HLTC', aTestName) = 0 then
  begin
   l_TestMask := ev_psPrefix(aTestName, '.');
   DoDel(l_TestMask);
   DoDel(l_TestMask + '_*');
   l_TestMask := Copy(l_TestMask, 3, Length(aTestName) - 2);
   if not IsEmptyStr(l_TestMask, cc_Digits + [cc_Underline]) then Exit;
  end; // if not Pos('HLTC', )
  l_TestMask := l_TestMask + '_*';
  DoDel(l_TestMask);
  TryClearDir(aTestName);
 end//anIsScript
 else
 begin
  DoDel(aTestName);
  DoDel(aTestName + '_*');
  l_TestMask := Copy(aTestName, 3, Length(aTestName) - 2);
  if not IsEmptyStr(l_TestMask, cc_Digits) then Exit;
  DoDel(l_TestMask);
  DoDel(l_TestMask + '_*');
 end;//anIsScript
//#UC END# *4D189B760354_4B2A6D4303A9_impl*
end;//DeleteEtalons

procedure LoadExcludedFromFile(const aFileName: AnsiString);
 {* Загрузка исключенных тестов из файла. }
//#UC START# *4D1993F70157_4B2A6D4303A9_var*
//#UC END# *4D1993F70157_4B2A6D4303A9_var*
begin
//#UC START# *4D1993F70157_4B2A6D4303A9_impl*
 if TExcludedTests.Exists then
  TExcludedTests.Instance.Clear;
 TExcludedTests.Instance.LoadFromFile(aFileName);
//#UC END# *4D1993F70157_4B2A6D4303A9_impl*
end;//LoadExcludedFromFile

function GetCVSTestSetPath: AnsiString;
 {* Возвращает путь к хранилищу тестов из CVS }
//#UC START# *4D199AE40101_4B2A6D4303A9_var*
//#UC END# *4D199AE40101_4B2A6D4303A9_var*
begin
//#UC START# *4D199AE40101_4B2A6D4303A9_impl*
 if g_CVSTestSetPath = '' then
  g_CVSTestSetPath := g_CVSPath + '\' + TBaseTest.TestSetFolderName;
 Result := g_CVSTestSetPath; 
//#UC END# *4D199AE40101_4B2A6D4303A9_impl*
end;//GetCVSTestSetPath

function GetAppTestSetPath: AnsiString;
 {* Возвращает путь к хранилищу тестов приложения. }
//#UC START# *4D199B3302E4_4B2A6D4303A9_var*
//#UC END# *4D199B3302E4_4B2A6D4303A9_var*
begin
//#UC START# *4D199B3302E4_4B2A6D4303A9_impl*
 if g_AppTestSetPath = '' then
  g_AppTestSetPath := ExtractFilePath(ParamStr(0)) + TBaseTest.TestSetFolderName + '\';
 Result := g_AppTestSetPath; 
//#UC END# *4D199B3302E4_4B2A6D4303A9_impl*
end;//GetAppTestSetPath

procedure LoadTestNamesFromFile(const aFileName: AnsiString;
 anOperation: TLoadOperation);
 {* Загрузка имен тестов для выполнения из файла. }
//#UC START# *4D1AEDA90114_4B2A6D4303A9_var*
//#UC END# *4D1AEDA90114_4B2A6D4303A9_var*
begin
//#UC START# *4D1AEDA90114_4B2A6D4303A9_impl*
 TTestNameList.LoadFromFileEX(aFileName, anOperation);
//#UC END# *4D1AEDA90114_4B2A6D4303A9_impl*
end;//LoadTestNamesFromFile

function NeedRunTest(const aTestName: AnsiString): Boolean;
 {* Проверяет нужно ли запускать тест (наличие его названия в списке загруженных). }
//#UC START# *4D1AF4DC0002_4B2A6D4303A9_var*
var
 l_Index: Integer;
//#UC END# *4D1AF4DC0002_4B2A6D4303A9_var*
begin
//#UC START# *4D1AF4DC0002_4B2A6D4303A9_impl*
 if TTestNameList.Instance.Empty AND
    IsWritingToK then
  Result := true
 else
  Result := TTestNameList.Instance.FindData(aTestName, l_Index);
//#UC END# *4D1AF4DC0002_4B2A6D4303A9_impl*
end;//NeedRunTest

procedure CheckFileParam;
 {* Проверяет есть ли параметр для загрузки непрошедших тестов. }
//#UC START# *4D1AFEBF00A5_4B2A6D4303A9_var*
const
 csFileParam = '-File:';
 cnParamLen  = Length(csFileParam);
var
 i          : Integer;
 l_Param    : AnsiString;
 l_LenParam : Integer;
//#UC END# *4D1AFEBF00A5_4B2A6D4303A9_var*
begin
//#UC START# *4D1AFEBF00A5_4B2A6D4303A9_impl*
 for i := 1 to ParamCount do
 begin
  l_Param := ParamStr(i);
  l_LenParam := Length(l_Param);
  if (cnParamLen < l_LenParam) and AnsiStartsText(csFileParam, l_Param) then
  begin
   l_Param := Copy(l_Param, cnParamLen + 1, l_LenParam - cnParamLen);
   TTestNameList.Instance.LoadFromFile(l_Param);
   Break;
  end // if Pos(csFileParam, l_Param) > 0 then
  else
   l_Param := '';
 end; // for i := 1 to ParamCount do
//#UC END# *4D1AFEBF00A5_4B2A6D4303A9_impl*
end;//CheckFileParam

procedure CheckNeedRandom;
//#UC START# *4EFC531803DA_4B2A6D4303A9_var*
const
 csRandParam = '-Random';
var
 i       : Integer;
 l_Param : AnsiString;
//#UC END# *4EFC531803DA_4B2A6D4303A9_var*
begin
//#UC START# *4EFC531803DA_4B2A6D4303A9_impl*
 g_Random := False;
 for i := 1 to ParamCount do
 begin
  l_Param := ParamStr(i);
  if AnsiSameText(csRandParam, l_Param) then
  begin
   g_Random := True;
   Randomize;
   Break;
  end; // if Pos(csFileParam, l_Param) > 0 then
 end; // for i := 1 to ParamCount do
//#UC END# *4EFC531803DA_4B2A6D4303A9_impl*
end;//CheckNeedRandom

function NeedRandom: Boolean;
//#UC START# *4EFC533C020F_4B2A6D4303A9_var*
//#UC END# *4EFC533C020F_4B2A6D4303A9_var*
begin
//#UC START# *4EFC533C020F_4B2A6D4303A9_impl*
 Result := g_Random; 
//#UC END# *4EFC533C020F_4B2A6D4303A9_impl*
end;//NeedRandom

procedure CheckIgnoreCVS;
//#UC START# *506D62750048_4B2A6D4303A9_var*
const
 csIgnoreCVSParam = '-IgnoreCVS';
var
 i       : Integer;
 l_Param : AnsiString;
//#UC END# *506D62750048_4B2A6D4303A9_var*
begin
//#UC START# *506D62750048_4B2A6D4303A9_impl*
 g_IgnoreCVS := False;
 for i := 1 to ParamCount do
 begin
  l_Param := ParamStr(i);
  if AnsiSameText(csIgnoreCVSParam, l_Param) then
  begin
   g_IgnoreCVS := True;
   Break;
  end; // if Pos(csFileParam, l_Param) > 0 then
 end; // for i := 1 to ParamCount do
//#UC END# *506D62750048_4B2A6D4303A9_impl*
end;//CheckIgnoreCVS

function IgnoreCVSPath: Boolean;
//#UC START# *506D653C0185_4B2A6D4303A9_var*
//#UC END# *506D653C0185_4B2A6D4303A9_var*
begin
//#UC START# *506D653C0185_4B2A6D4303A9_impl*
 Result := g_IgnoreCVS;
//#UC END# *506D653C0185_4B2A6D4303A9_impl*
end;//IgnoreCVSPath

procedure ClearTestNamesList;
//#UC START# *525CFD5E010C_4B2A6D4303A9_var*
//#UC END# *525CFD5E010C_4B2A6D4303A9_var*
begin
//#UC START# *525CFD5E010C_4B2A6D4303A9_impl*
 TTestNameList.ClearList;
//#UC END# *525CFD5E010C_4B2A6D4303A9_impl*
end;//ClearTestNamesList

procedure LoadDocumentIDList;
 {* Загружает список тестов и номеров документов. }
//#UC START# *5279D73902C8_4B2A6D4303A9_var*
//#UC END# *5279D73902C8_4B2A6D4303A9_var*
begin
//#UC START# *5279D73902C8_4B2A6D4303A9_impl*
 TTestDocumentList.Instance.LoadFromFile(FileFromCurrent('!Test2DocID.txt', false, false));
//#UC END# *5279D73902C8_4B2A6D4303A9_impl*
end;//LoadDocumentIDList

function FindDocID(const aTestName: AnsiString): AnsiString;
 {* Ищет номер доукумента по номеру теста. }
//#UC START# *5279D7860187_4B2A6D4303A9_var*
var
 l_Index: Integer;
//#UC END# *5279D7860187_4B2A6D4303A9_var*
begin
//#UC START# *5279D7860187_4B2A6D4303A9_impl*
 Result := '';
 if TTestDocumentList.Exists and not TTestDocumentList.Instance.Empty then
  if TTestDocumentList.Instance.FindData(aTestName, l_Index) then
   Result := TTestDocumentList.Instance.Items[l_Index + 1].AsString;
//#UC END# *5279D7860187_4B2A6D4303A9_impl*
end;//FindDocID

function TTimeInfoName.Compare(const aName: TTimeInfoName): Integer;
//#UC START# *4B6C348B023F_4B6BF212005D_var*
//#UC END# *4B6C348B023F_4B6BF212005D_var*
begin
//#UC START# *4B6C348B023F_4B6BF212005D_impl*
 Result := CompareStr(rName, aName.rName);
 if (Result = 0) then
  Result := CompareStr(rSubName, aName.rSubName);
//#UC END# *4B6C348B023F_4B6BF212005D_impl*
end;//TTimeInfoName.Compare

function TTimeInfo.Compare: Integer;
//#UC START# *4B2F57280040_4B2F565002FD_var*
//#UC END# *4B2F57280040_4B2F565002FD_var*
begin
//#UC START# *4B2F57280040_4B2F565002FD_impl*
 Result := rID.Compare(aInfo.rID);
 if (Result = 0) then
 begin
  if (rDate < aInfo.rDate) then
   Result := -1
  else
  if (rDate > aInfo.rDate) then
   Result := +1;
 end;//Result = 0
//#UC END# *4B2F57280040_4B2F565002FD_impl*
end;//TTimeInfo.Compare

function TTimeInfo.EQ: Boolean;
//#UC START# *4B2FAB480293_4B2F565002FD_var*
//#UC END# *4B2FAB480293_4B2F565002FD_var*
begin
//#UC START# *4B2FAB480293_4B2F565002FD_impl*
 Result := (Compare(aInfo) = 0) AND (rTime = aInfo.rTime);
//#UC END# *4B2FAB480293_4B2F565002FD_impl*
end;//TTimeInfo.EQ

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4B2F5BB102A4_var*
var
 l_Time : Int64;
//#UC END# *47B2C42A0163_4B2F5BB102A4_var*
begin
//#UC START# *47B2C42A0163_4B2F5BB102A4_impl*
 l_Time := Int64(aTo.rTime) + Int64(aFrom.rTime);
 l_Time := l_Time div 2;
 PTimeInfo(@aTo)^ := aFrom;
 PTimeInfo(@aTo)^.rTime := l_Time;
//#UC END# *47B2C42A0163_4B2F5BB102A4_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4B2F5BB102A4_var*
//#UC END# *47B99D4503A2_4B2F5BB102A4_var*
begin
//#UC START# *47B99D4503A2_4B2F5BB102A4_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := CI.rA.Compare(CI.rB^);
//#UC END# *47B99D4503A2_4B2F5BB102A4_impl*
end;//CompareExistingItems

type _Instance_R_ = TTimeInfoList;

{$Include l3RecordWithEQList.imp.pas}

procedure TTimeInfoList.Compact(aCount: Integer);
 {* Минимизирует число замеров в графике до указанного числа }
//#UC START# *4B7A98A10031_4B2F5BB102A4_var*
//#UC END# *4B7A98A10031_4B2F5BB102A4_var*
begin
//#UC START# *4B7A98A10031_4B2F5BB102A4_impl*
 l_C := Pred(Count);
 l_i := 0;
 while (l_i <= l_C) do
 begin
  l_Name := Items[l_i].rID;
  l_SeriesCount := 1;
  for l_j := l_i + 1 to l_C do
  begin
   if (Items[l_j].rID.Compare(l_Name) = 0) then
    Inc(l_SeriesCount)
   else
    break; 
  end;//for l_j
  if (l_SeriesCount > aCount) then
  begin
   //l3System.Str2Log(Format('Before compacting %s : %s', [l_Name.rName, l_Name.rSubName]));
   //l3System.Str2Log(Format('Series count %d : requested count %d', [l_SeriesCount, aCount]));
   while (l_SeriesCount > aCount) do
   begin
    //l3System.Str2Log(Format('Compacting %s : %s', [l_Name.rName, l_Name.rSubName]));
    Delete(l_i);
    Dec(l_SeriesCount);
    Dec(l_C);
   end;//l_SeriesCount > aCount
   //l3System.Str2Log(Format('Series count %d', [l_SeriesCount]));
  end;//l_SeriesCount > aCount
  Inc(l_i, l_SeriesCount);
 end;//while (i <= l_C)
//#UC END# *4B7A98A10031_4B2F5BB102A4_impl*
end;//TTimeInfoList.Compact

procedure TTimeInfoList.DeleteOld(aDateDelta: Integer);
 {* Удаляет старые замеры }
//#UC START# *4B7AA321023D_4B2F5BB102A4_var*
//#UC END# *4B7AA321023D_4B2F5BB102A4_var*
begin
//#UC START# *4B7AA321023D_4B2F5BB102A4_impl*
 l_C := Pred(Count);
 l_i := 0;
 while (l_i <= l_C) do
 begin
  with Items[l_i] do
  begin
   l_Name := rID;
   l_MaxDate := rDate;
  end;//with Items[l_i]
  l_SeriesCount := 1;
  for l_j := l_i + 1 to l_C do
  begin
   with Items[l_j] do
   if (rID.Compare(l_Name) = 0) then
   begin
    Inc(l_SeriesCount);
    if (l_MaxDate < rDate) then
     l_MaxDate := rDate; 
   end//rID.Compare(l_Name) = 0
   else
    break; 
  end;//for l_j
  if (Date - l_MaxDate > aDateDelta) then
  begin
   while (l_SeriesCount > 0) do
   begin
    l3System.Str2Log(Format('Deleting old %s : %s', [l_Name.rName, l_Name.rSubName]));
    Delete(l_i);
    Dec(l_SeriesCount);
    Dec(l_C);
   end;//l_SeriesCount > aCount
  end;//Date - l_MaxDate > aDateDelta
  Inc(l_i, l_SeriesCount);
 end;//while (i <= l_C)
//#UC END# *4B7AA321023D_4B2F5BB102A4_impl*
end;//TTimeInfoList.DeleteOld

procedure TKTestListener.PutResultsToK;
//#UC START# *4B2B6F740014_4B2A6CEB0377_var*
var
 l_Log : AnsiString;
 l_Delete : Boolean;
 {$IfNDef NoKPageTool}
 l_Labels : TextFile;
 l_LabelsName : AnsiString;
 {$EndIf  NoKPageTool}
 l_LabelsString : AnsiString;
//#UC END# *4B2B6F740014_4B2A6CEB0377_var*
begin
//#UC START# *4B2B6F740014_4B2A6CEB0377_impl*
 l3System.CloseLog;
 l_Log := ChangeFileExt(ParamStr(0), '.log');
 if FileExists(l_Log) then
 begin
  l_Delete := true;
  try
   if not f_AllIsOk OR (FileDateTime(l_Log) >= Date) then
    l3CatFiles(ResultsFileName, l_Log,
               '{composition-setup}'#13#10 +
               'cloak.toggle.zone=true'#13#10 +
               'cloak.memory.duration=10'#13#10 +
               '{composition-setup}'#13#10 +
               #13#10 +
               '{toggle-cloak:id=log-174295160-757990} {_}Лог{_}'#13#10 +
               '{cloak:id=log-174295160-757990}'#13#10 +
               '{code}'
               ,
               '{code}'#13#10+
               '{cloak}');
  except
   on E : Exception do
   begin
    l_Delete := false;
    l3System.OpenLog;
    l3System.Exception2Log(E);
   end;//on E : Exception
  end;//try..except
 end//FileExists(l_Log)
 else
  l_Delete := false;
 l3System.OpenLog;
 try
  PutFileToK(ResultsPage, ResultsFileName);
 except
  on E : Exception do
  begin
   l_Delete := false;
   l3System.Exception2Log(E);
   if not IsFakeK then
    raise
   else
   if (TestsExitCode = 0) then
    TestsExitCode := 1; 
  end;//on E : Exception
 end;//try..except
 if l_Delete then
 begin
  l3System.CloseLog;
  SysUtils.DeleteFile(l_Log);
 end;//l_Delete
 l_LabelsString := GetLabels;
 l_LabelsString := AnsiReplaceStr(l_LabelsString, 'test_done', '');
 l_LabelsString := AnsiReplaceStr(l_LabelsString, 'test_failed', '');
 l_LabelsString := AnsiReplaceStr(l_LabelsString, ',,', ',');
 l_LabelsString := l3Str(l3Trim(l3CStr(l_LabelsString), [',']));
 if f_AllIsOk then
  l_LabelsString := l3ConcatText(l_LabelsString, 'test_done', ',')
 else
  l_LabelsString := l3ConcatText(l_LabelsString, 'test_failed', ',');
 {$IfDef NoKPageTool}
 if not IsFakeK then
  TKBridge.Instance.Page[ResultsPage].set_labels(l_LabelsString);
 {$Else  NoKPageTool}
 l_LabelsName := GetLabelsFileName;
 AssignFile(l_Labels, l_LabelsName);
 Rewrite(l_Labels);
 try
  System.Write(l_Labels, l_LabelsString);
 finally
  CloseFile(l_Labels);
 end;//try..finally 
 CommunicateWithK(ResultsPage, l_LabelsName, foSetLabel);
 {$EndIf  NoKPageTool}
 if not f_AllIsOk then
  if IsFakeK then
   if (TestsExitCode = 0) then
    TestsExitCode := 1;
//#UC END# *4B2B6F740014_4B2A6CEB0377_impl*
end;//TKTestListener.PutResultsToK

procedure TKTestListener.ToLog(const aSt: AnsiString);
//#UC START# *4B2B93A4002D_4B2A6CEB0377_var*
//#UC END# *4B2B93A4002D_4B2A6CEB0377_var*
begin
//#UC START# *4B2B93A4002D_4B2A6CEB0377_impl*
 // - ничего пока не делаем
//#UC END# *4B2B93A4002D_4B2A6CEB0377_impl*
end;//TKTestListener.ToLog

procedure TKTestListener.PutFileToK(aPageID: Integer;
 const aFileName: AnsiString);
//#UC START# *4B2B954502BE_4B2A6CEB0377_var*
var
 l_F : AnsiString;
//#UC END# *4B2B954502BE_4B2A6CEB0377_var*
begin
//#UC START# *4B2B954502BE_4B2A6CEB0377_impl*
 l_F := aFileName + '.tmp';
 CommunicateWithK(aPageID, l_F, foGet);
 if FileExists(l_F) then
 begin
  if not l3CompareFiles(l_F, aFileName) then
   CommunicateWithK(aPageID, aFileName, foSet);
  SysUtils.DeleteFile(l_F);
 end//FileExists(l_F)
 else
  CommunicateWithK(aPageID, aFileName, foSet);
//#UC END# *4B2B954502BE_4B2A6CEB0377_impl*
end;//TKTestListener.PutFileToK

procedure TKTestListener.TimeToLog(aTime: Cardinal;
 const aSt: AnsiString;
 const aSubName: AnsiString);
//#UC START# *4B2F51C3008F_4B2A6CEB0377_var*
//#UC END# *4B2F51C3008F_4B2A6CEB0377_var*
begin
//#UC START# *4B2F51C3008F_4B2A6CEB0377_impl*
 CheckTimeInfo;
 f_TimeInfo.Add(TTimeInfo_C(aSt, aTime, aSubName));
//#UC END# *4B2F51C3008F_4B2A6CEB0377_impl*
end;//TKTestListener.TimeToLog

class procedure TKTestListener.CommunicateWithK(aPageID: Integer;
 const aFileName: AnsiString;
 anOp: TKFileOperation);
//#UC START# *4B2F92D20307_4B2A6CEB0377_var*
{$IfDef NoKPageTool}
var
 l_File  : TextFile;
 l_Text  : AnsiString;
 l_Str   : AnsiString;
 l_First : Boolean;
{$Else  NoKPageTool}
const
 TargetName = 'KPageTool.exe';
 sErrorExec = 'Can''t execute %s %d';
 cOp : array [TKFileOperation] of AnsiString = ('PA_GET', 'PA_SET', 'PA_GET_LABEL', 'PA_SET_LABEL', 'PA_ATTACH');
var
 l_Params : AnsiString;
 ProcessInfo : TProcessInformation;
 StartupInfo : TStartupInfoA;
 l_Result : DWORD;
 l_KUser, l_KUserPassword : AnsiString;
 l_Continue : Boolean;
{$EndIf NoKPageTool}
//#UC END# *4B2F92D20307_4B2A6CEB0377_var*
begin
//#UC START# *4B2F92D20307_4B2A6CEB0377_impl*
 if IsFakeK then
  Exit;
 {$IfDef NoKPageTool}
 AssignFile(l_File, aFileName);
 try
  Case anOp of
   foGet :
   begin
    Rewrite(l_File);
    l_Text := TKBridge.Instance.Page[aPageID].get_wiki_text;
    System.Write(l_File, l_Text);
   end;//foGet
   foSet :
   begin
    Reset(l_File);
    l_Text := '';
    l_First := true;
    while not System.EOF(l_File) do
    begin
     System.ReadLn(l_File, l_Str);
     if l_First then
     begin
      l_Text := l_Str;
      l_First := false;
     end//l_First
     else
      l_Text := l_Text + #13#10 + l_Str;
    end;//while not System.EOF(l_File)
    TKBridge.Instance.Page[aPageID].set_wiki_text(l_Text);
   end;//foSet 
   else
    Assert(false);
  end;//Case anOp
 finally
  CloseFile(l_File);
 end;//try..finally
 {$Else  NoKPageTool}
 l_KUser := KUser;
 l_KUserPassword := KUserPassword;
 if (l_KUser = '') then
 begin
//  l_KUser := 'shdtester';
  l_KUser := 'f1performer';
  l_KUserPassword := l_KUser;
 end;//KUser = ''
 repeat
  l_Continue := false;
  l_Params := '-ORBInitRef NameService=corbaloc::1.2@mdp.garant.ru:5053/NameService -login '+
              l_KUser +
              ' -password ' + l_KUserPassword +
              ' -operation ' + cOp[anOp] +
              ' -page_id ' + IntToStr(aPageID) +
              ' -file ' + aFileName
              + ' -GCMConfigFile ' + ExtractFilePath(ParamStr(0)) + 'KPageTool.ini'
              ;
  l3FillChar(StartupInfo, SizeOf(StartupInfo));
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := SW_HIDE;
  if not CreateProcessA(TargetName, PAnsiChar(l_Params),
    nil, nil, true, NORMAL_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInfo) then
    raise Exception.CreateFmt(sErrorExec, [TargetName, GetLastError])
  else
  try
   WaitForSingleObject(ProcessInfo.hProcess, Infinite);
 (*   case WaitForInputIdle(ProcessInfo.hProcess, 4000) of
      0: ;
      WAIT_TIMEOUT:
        raise Exception.CreateFmt(sErrorExec, [TargetName, GetLastError]);
      WAIT_FAILED:
        raise Exception.CreateFmt(sErrorExec, [TargetName, GetLastError]);
    else
      Assert(False); // Unexpected value
    end;//case WaitForInputIdle(ProcessInfo.hProcess, 4000)*)
  finally
    { Always close the handles right away, since we don't use them }
    try
     CloseHandle(ProcessInfo.hThread);
    finally
     try
      Win32Check(GetExitCodeProcess(ProcessInfo.hProcess, l_Result));
      if (l_Result <> 0) then
      begin
       if (l_KUser = 'f1performer') then
       begin
        {$IfDef EverestLite}
        l_KUser := 'architester';
        l_KUserPassword := '6v2K3024';
        {$Else  EverestLite}
        l_KUser := 'shdtester';
        l_KUserPassword := l_KUser;
        {$EndIf EverestLite}
        l_Continue := true;
       end//l_KUser = 'f1performer'
       else
        raise Exception.Create('Что то не в порядке с коммуникацией с К');
      end;//
     finally
      CloseHandle(ProcessInfo.hProcess);
     end;//try..finally
    end;//try..finally
  end;//try..finally
 until not l_Continue;
 {$EndIf NoKPageTool}
//#UC END# *4B2F92D20307_4B2A6CEB0377_impl*
end;//TKTestListener.CommunicateWithK

procedure TKTestListener.GetFileFromK(aPageID: Integer;
 const aFileName: AnsiString);
 {* Получает файл из К }
//#UC START# *4B2F95810108_4B2A6CEB0377_var*
//#UC END# *4B2F95810108_4B2A6CEB0377_var*
begin
//#UC START# *4B2F95810108_4B2A6CEB0377_impl*
 CommunicateWithK(aPageID, aFileName, foGet);
//#UC END# *4B2F95810108_4B2A6CEB0377_impl*
end;//TKTestListener.GetFileFromK

procedure TKTestListener.GetTimesFromK;
 {* Получает из К замеры времени }
//#UC START# *4B2F9BAE023F_4B2A6CEB0377_var*

 function CutPrefix(const aPref : AnsiString; const aStr : Tl3WString): Tl3WString;
 var
  l_Len : Integer;
 begin
  l_Len := Length(aPref);
  Result.S := aStr.S + l_Len;
  Result.SLen := aStr.SLen - l_Len;
  Result.SCodePage := aStr.SCodePage;
 end;

 function CutSuffix(const aSuff : Tl3WString; const aStr : Tl3WString): Tl3WString;
 begin
  Result.S := aStr.S;
  Result.SLen := aSuff.S - aStr.S - 1;
  Result.SCodePage := aStr.SCodePage;
 end;

const
 VLine = '|';
var
 l_Suff : Tl3WString;
 l_Date : TDateTime;
 l_Time : Integer;
 l_SubName : AnsiString;
//#UC END# *4B2F9BAE023F_4B2A6CEB0377_var*
begin
//#UC START# *4B2F9BAE023F_4B2A6CEB0377_impl*
 try
  GetFileFromK(TimesPage, TimesFileName);
 except
  on E : Exception do
  begin
   l3System.Exception2Log(E);
   raise;
  end;//on E : Exception
 end;//try.except
 if not FileExists(TimesFileName) then
 begin
  if IsFakeK then
  // - не получили страницу, это видимо не повод плакать
   Exit
  else
  try
   raise Exception.Create('Страница из К не получена. Возможно проблемы с коммуникацией с К');
  except
   on E : Exception do
   begin
    l3System.Exception2Log(E);
    raise;
   end;//on E : Exception
  end;//try.except
 end;//not FileExists(TimesFileName)
 try
  l_F := Tl3CustomDOSFiler.Make(TimesFileName, l3_fmRead, false);
  try
   l_F.Open;
   try
    l_N := '';
    l_SubName := '';
    while not l_F.EOF do
    begin
     l_L := l_F.ReadLn;
     if l3Starts('{cache', l_L) then
      continue
     else
     if l3Starts(Task, l_L) then
      continue
     else
     if l3Starts(Anchor, l_L) then
      continue
     else 
     if l3Starts(Header, l_L) then
      l_N := l3PCharLen2String(CutPrefix(Header, l_L))
     else
     if l3Starts(Columns, l_L) then
     begin
      l_L := CutPrefix(Columns, l_L);
      l_L := l3RTrim(l_L, [#32, VLine]);
      l_SubName := l3PCharLen2String(l_L);
      continue;
     end//l3Starts(Columns, l_L)
     else
     if l3Starts(Chart, l_L) then
      continue
     else
     begin
      if not l3IsNil(l_L) then
      begin
       if (l_L.S^ = VLine) then
       begin
        l_L := CutPrefix(VLine, l_L);
        CheckTimeInfo;
        l_Suff := l3FindChar(VLine, l_L);
        Assert(not l3IsNil(l_Suff));
        l_Date := StrToDate(l3PCharLen2String(CutSuffix(l_Suff, l_L)));
        l_L := l_Suff;
        l_Suff := l3FindChar(VLine, l_L);
        if not l3IsNil(l_Suff) then
         l_L := CutSuffix(l_Suff, l_L)
        else
         l_L := l3RTrim(l_L, [VLine]);
        l_Time := StrToInt(l3PCharLen2String(l_L));
        f_TimeInfo.Add(TTimeInfo_C(l_Date, l_N, l_Time, l_SubName));
       end;//l_L.S^ = VLine
      end;//not l3IsNil(l_L)
     end;//else
    end;//while not l_F.EOF
   finally
    l_F.Close;
   end;//try..finally
  finally
   FreeAndNil(l_F);
  end;//try..finally
 except
  on E : Exception do
  begin
   l3System.Exception2Log(E);
   raise;
  end;//on E : Exception
 end;//try.except
//#UC END# *4B2F9BAE023F_4B2A6CEB0377_impl*
end;//TKTestListener.GetTimesFromK

procedure TKTestListener.CheckTimeInfo;
 {* Проверяет, что список времён создан }
//#UC START# *4B2FA99E03C3_4B2A6CEB0377_var*
//#UC END# *4B2FA99E03C3_4B2A6CEB0377_var*
begin
//#UC START# *4B2FA99E03C3_4B2A6CEB0377_impl*
 if (f_TimeInfo = nil) then
 begin
  f_TimeInfo := TTimeInfoList.Create;
  f_TimeInfo.Sorted := true;
  f_TimeInfo.Duplicates := l3_dupAssign;
 end;//f_TimeInfo = nil
//#UC END# *4B2FA99E03C3_4B2A6CEB0377_impl*
end;//TKTestListener.CheckTimeInfo

function TKTestListener.TimesPage: Integer;
//#UC START# *4B4DC8DD0087_4B2A6CEB0377_var*
//#UC END# *4B4DC8DD0087_4B2A6CEB0377_var*
begin
//#UC START# *4B4DC8DD0087_4B2A6CEB0377_impl*
 Result := g_ResultsPlace.TimesPage;
//#UC END# *4B4DC8DD0087_4B2A6CEB0377_impl*
end;//TKTestListener.TimesPage

class function TKTestListener.ResultsPage: Integer;
//#UC START# *4B4DC923001A_4B2A6CEB0377_var*
//#UC END# *4B4DC923001A_4B2A6CEB0377_var*
begin
//#UC START# *4B4DC923001A_4B2A6CEB0377_impl*
 Result := g_ResultsPlace.ResultsPage;
//#UC END# *4B4DC923001A_4B2A6CEB0377_impl*
end;//TKTestListener.ResultsPage

function TKTestListener.TimesFileName: AnsiString;
//#UC START# *4B58989D02ED_4B2A6CEB0377_var*
//#UC END# *4B58989D02ED_4B2A6CEB0377_var*
begin
//#UC START# *4B58989D02ED_4B2A6CEB0377_impl*
 Result := ChangeFileExt(ParamStr(0), '_' + IntToStr(TimesPage) + '.out');
//#UC END# *4B58989D02ED_4B2A6CEB0377_impl*
end;//TKTestListener.TimesFileName

function TKTestListener.ResultsFileName: AnsiString;
//#UC START# *4B589976028C_4B2A6CEB0377_var*
//#UC END# *4B589976028C_4B2A6CEB0377_var*
begin
//#UC START# *4B589976028C_4B2A6CEB0377_impl*
 Result := ChangeFileExt(ParamStr(0), '_' + IntToStr(ResultsPage) + '.out');
//#UC END# *4B589976028C_4B2A6CEB0377_impl*
end;//TKTestListener.ResultsFileName

class function TKTestListener.IsFakeK: Boolean;
//#UC START# *4B589ABD02C3_4B2A6CEB0377_var*
var
 l_Index : Integer;
//#UC END# *4B589ABD02C3_4B2A6CEB0377_var*
begin
//#UC START# *4B589ABD02C3_4B2A6CEB0377_impl*
 if not f_FakeKValid then
 begin
  f_IsFakeK := false;
  for l_Index := 1 to ParamCount do
   if (ParamStr(l_Index) = '-FakeK') then
   begin
    f_IsFakeK := true;
    break;
   end;//ParamStr(l_Index) = '-FakeK'
  f_FakeKValid := true; 
 end;//not f_FakeKValid
 Result := f_IsFakeK;
//#UC END# *4B589ABD02C3_4B2A6CEB0377_impl*
end;//TKTestListener.IsFakeK

procedure TKTestListener.PutTimesToK;
 {* Выводит в К замеры времени }
//#UC START# *4B2F60140143_4B2A6CEB0377_var*

{$OverflowChecks Off}
 function Mangle(const aStr: AnsiString): AnsiString;

   function SuperFastHash(AData:pointer; ADataLength: integer):longword;
  // Pascal translation of the SuperFastHash function by Paul Hsieh
  // more info: http://www.azillionmonkeys.com/qed/hash.html
  // Translation by: Davy Landman
  // No warranties, but have fun :)
  var
    TempPart: longword;
    RemainingBytes: integer;
  begin
    if not Assigned(AData) or (ADataLength <= 0) then
    begin
      Result := 0;
      Exit;
    end;
    Result := ADataLength;
    RemainingBytes := ADataLength and 3;
    ADataLength := ADataLength shr 2; // div 4, so var name is not correct anymore..
    // main loop
    while ADataLength > 0 do
    begin
      inc(Result, PWord(AData)^);
      TempPart := (PWord(Pointer(Cardinal(AData)+2))^ shl 11) xor Result;
      Result := (Result shl 16) xor TempPart;
      AData := Pointer(Cardinal(AData) + 4);
      inc(Result, Result shr 11);
      dec(ADataLength);
    end;
    // end case
    if RemainingBytes = 3 then
    begin
      inc(Result, PWord(AData)^);
      Result := Result xor (Result shl 16);
      Result := Result xor (PByte(Pointer(Cardinal(AData)+2))^ shl 18);
      inc(Result, Result shr 11);
    end
    else if RemainingBytes = 2 then
    begin
      inc(Result, PWord(AData)^);
      Result := Result xor (Result shl 11);
      inc(Result, Result shr 17);
    end
    else if RemainingBytes = 1 then
    begin
      inc(Result, PByte(AData)^);
      Result := Result xor (Result shl 10);
      inc(Result, Result shr 1);
    end;
    // avalance
    Result := Result xor (Result shl 3);
    inc(Result, Result shr 5);
    Result := Result xor (Result shl 4);
    inc(Result, Result shr 17);
    Result := Result xor (Result shl 25);
    inc(Result, Result shr 6);
  end;
{$OverflowChecks On}  

(*  function MurmurHash2 (key : PChar; len : Integer; seed : Integer) : Integer;
  var
   m : Int64;
   r : Int64;
   h : Int64;
   k : Int64;
  begin
          // 'm' and 'r' are mixing constants generated offline.
          // They're not really 'magic', they just happen to work well.

          m := $5bd1e995;
          r := 24;

          // Initialize the hash to a 'random' value

          h := seed XOR len;

          // Mix 4 bytes at a time into the hash

          while (len >= 4) do
          begin
                  k := PInteger(key)^;

                  k := k * m;
                  k := k XOR (k shr r);
                  k := k * m;

                  h := h * m;
                  h := h XOR k;

                  Inc(key, 4);
                  Dec(len, 4);
          end;

          // Handle the last few bytes of the input array

          case len of
           3:
            h := h XOR (Integer(key[2]) shl 16);
           2:
            h := h XOR (Integer(key[1]) shl 8);
           1:
            h := h XOR (Integer(key[0]));
           else
            h := h * m;
          end;//case

          // Do a few final mixes of the hash to ensure the last few
          // bytes are well-incorporated.

          h := h shl 13;
          h := h * m;
          h := h XOR (h shl 15);

          Result := h;
  end;*)
  
 const
  cLimit = 35;
 begin
  Result := l3Transliterate(aStr);
  l3Replace(Result, ' ', '_');
  l3Replace(Result, '''', '_');
  l3Replace(Result, '(', '_');
  l3Replace(Result, ')', '_');
  //l3Replace(Result, '.', '_');
  if (Length(Result) > cLimit) then
   Result := IntToHex(SuperFastHash(PChar(Result), Length(Result)), 8);
//   SetLength(Result, cLimit);
 end;

var
 j : Integer;
 l_SeriesCount : Integer;
 l_LocSeriesCount : Integer;
 l_MaxSeriesCount : Integer;
 l_GraphicsCount : Integer;
 l_Ave         : Int64;
 l_Cnt         : Integer;
 l_NextTime    : Cardinal;
 l_Min         : Cardinal;
 l_Max         : Cardinal;
 l_MaxDate     : TDateTime;
 l_SubName     : AnsiString;
 l_LocSubName  : AnsiString;
//#UC END# *4B2F60140143_4B2A6CEB0377_var*
begin
//#UC START# *4B2F60140143_4B2A6CEB0377_impl*
 f_TimeInfo.DeleteOld(15);
 f_TimeInfo.Compact(30);
 l_F := Tl3CustomDOSFiler.Make(TimesFileName, l3_fmWrite, false);
 try
  l_F.Open;
  try
   //l_F.WriteLn('{cache:checkAttachments=false|showRefresh=true|showDate=true|refresh=1h}');
   l_F.WriteLn('{cache:checkAttachments=false|showDate=true|refresh=9d}');
   try
    l_N := '';
    l_SubName := '';
    l_Cnt := f_TimeInfo.Count - 1;
    l_Index := 0;
    while l_Index <= l_Cnt do
    begin
     l_Info := f_TimeInfo[l_Index];
     if (l_N <> l_Info.rID.rName) then
     begin
      if (l_N <> '') then
      begin
       l_F.WriteLn(Chart + '}');
       l_F.WriteLn('');
      end;//l_N <> ''
      l_N := l_Info.rID.rName;
      l_LocSubName := l_Info.rID.rSubName;
      l_SubName := '';
      l_SeriesCount := 1;
      l_GraphicsCount := 1;
      l_LocSeriesCount := 1;
      l_MaxSeriesCount := 1;
      l_Ave := l_Info.rTime;
      l_Min := l_Ave;
      l_Max := l_Ave;
      l_MaxDate := l_Info.rDate;
      for j := l_Index + 1 to l_Cnt do
      begin
       with f_TimeInfo[j] do
       begin
        if (rID.rName <> l_N) then
         break;
        if (rID.rSubName <> l_LocSubName) then
        begin
         l_LocSubName := rID.rSubName;
         l_LocSeriesCount := 0;
         Inc(l_GraphicsCount);
        end;//rSubName <> l_LocSubName
        l_NextTime := rTime;
        if (rDate > l_MaxDate) then
         l_MaxDate := rDate;
       end;//with f_TimeInfo[j]
       Inc(l_SeriesCount);
       Inc(l_LocSeriesCount);
       if (l_LocSeriesCount > l_MaxSeriesCount) then
        l_MaxSeriesCount := l_LocSeriesCount;
       Inc(l_Ave, l_NextTime);
       if (l_NextTime < l_Min) then
        l_Min := l_NextTime;
       if (l_NextTime > l_Max) then
        l_Max := l_NextTime;
      end;//for j
      if {f_AllIsOk AND }((l_MaxDate < Date) OR (l_Max <= 300){((l_Min = 0) AND (l_Max = 0))}) then
      // - выкидываем старые замеры
      begin
       Inc(l_Index, l_SeriesCount);
       l_N := '';
       continue;
      end;//f_AllIsOk..
      l_Ave := l_Ave div l_SeriesCount;
      l_F.WriteLn(Anchor + Mangle(l_N) + '}');
      l_F.WriteLn(Header + l_N);
      OutTaskLink(l_N);
      l_F.Write{Ln}(Chart +
                  ':type=timeSeries|dateFormat=dd.MM.yyyy|timePeriod=Day|dataOrientation=vertical|colors=red,blue,green,gray,purple' +
                  '|rangeAxisLowerBound=' + IntToStr(Round(l_Min * 0.95)) +
                  '|rangeAxisUpperBound=' + IntToStr(Round(l_Max * 1.05)) +
                  '|width=' + IntToStr(Max(Max(400, Min(10, l_GraphicsCount) * 75), l_MaxSeriesCount * 80)) +
                  '|attachment=^' + Mangle(l_N) + '.png' +
                  '}');
     end;//l_N <> l_Info.rName
     Assert(l_Info.rID.rSubName <> '');
     if (l_SubName <> l_Info.rID.rSubName) then
     begin
      l_SubName := l_Info.rID.rSubName;
      l_F.WriteLn('');
      l_F.WriteLn(Columns + l_SubName + ' ||');
     end;//l_SubName <> l_Info.rSubName
     l_F.WriteLn('|' + {DateToStr(l_Info.rDate)}l3DateToStr(l_Info.rDate, 'dd.mm.yyyy') + '|' + IntToStr(l_Info.rTime) + '|');
     Inc(l_Index);
    end;//while l_Index
    if (l_N <> '') then
     l_F.WriteLn(Chart + '}');
   finally
    l_F.WriteLn('');
    l_F.WriteLn('{cache}');
   end;//try..finally
  finally
   l_F.Close;
  end;//try..finally
 finally
  FreeAndNil(l_F);
 end;//try..finally
 PutFileToK(TimesPage, TimesFileName);
//#UC END# *4B2F60140143_4B2A6CEB0377_impl*
end;//TKTestListener.PutTimesToK

function TKTestListener.GetLabels: AnsiString;
 {* Возвращает метки страницы с тестами }
//#UC START# *4C359E6E02F6_4B2A6CEB0377_var*
{$IfNDef NoKPageTool}
var
 l_Labels : TextFile;
 l_LabelsName : AnsiString;
{$EndIf NoKPageTool}
//#UC END# *4C359E6E02F6_4B2A6CEB0377_var*
begin
//#UC START# *4C359E6E02F6_4B2A6CEB0377_impl*
 {$IfDef NoKPageTool}
 try
  if IsFakeK then
   Result := ''
  else
   Result := TKBridge.Instance.Page[ResultsPage].get_labels;
 except
  Result := '';
(*
[17:07]  ЛА> может исключение лететь потому что меток скажем нету?
[17:07]  ЛА> или правов каких-то не хватает...
[17:08]  СЕ> непонятно, по идее не должно. Скажи ай-ди страницы.
[17:08]  ЛА> 260441921
[17:08]  ЛА> только не правь её
[17:08]  ЛА> она вновь созданная
[17:09]  ЛА> может быть в этом дело...
[17:11]  СЕ> Попробуй еще раз, плз.
[17:11]  ЛА> то же самое
[17:11]  ЛА> стою на исключении
[17:13]  СЕ> Ясно, тогда точно из-за лэйблов. Поправлю. Без задачи.
[17:13]  ЛА> try except поможет?
[17:14]  ЛА> в данный момент
[17:14]  СЕ> да
[17:14]  ЛА> ок
[17:15]  ЛА> сейчас у себя вставлю
[17:15]  ЛА> но и ты - не забудь
*)
 end;//try..except
 {$Else  NoKPageTool}
 l_LabelsName := GetLabelsFileName;
 try
  CommunicateWithK(ResultsPage, l_LabelsName, foGetLabel);
 except
  Result := '';
  Exit;
(*
[17:07]  ЛА> может исключение лететь потому что меток скажем нету?
[17:07]  ЛА> или правов каких-то не хватает...
[17:08]  СЕ> непонятно, по идее не должно. Скажи ай-ди страницы.
[17:08]  ЛА> 260441921
[17:08]  ЛА> только не правь её
[17:08]  ЛА> она вновь созданная
[17:09]  ЛА> может быть в этом дело...
[17:11]  СЕ> Попробуй еще раз, плз.
[17:11]  ЛА> то же самое
[17:11]  ЛА> стою на исключении
[17:13]  СЕ> Ясно, тогда точно из-за лэйблов. Поправлю. Без задачи.
[17:13]  ЛА> try except поможет?
[17:14]  ЛА> в данный момент
[17:14]  СЕ> да
[17:14]  ЛА> ок
[17:15]  ЛА> сейчас у себя вставлю
[17:15]  ЛА> но и ты - не забудь
*)
 end;//try..except
 AssignFile(l_Labels, l_LabelsName);
 Reset(l_Labels);
 try
  System.ReadLn(l_Labels, Result);
 finally
  CloseFile(l_Labels);
 end;//try..finally
 {$EndIf NoKPageTool}
//#UC END# *4C359E6E02F6_4B2A6CEB0377_impl*
end;//TKTestListener.GetLabels

{$If NOT Defined(NoKPageTool)}
function TKTestListener.GetLabelsFileName: AnsiString;
 {* Возвращает имя файла с метками страницы тестов }
//#UC START# *4C359EBF0304_4B2A6CEB0377_var*
//#UC END# *4C359EBF0304_4B2A6CEB0377_var*
begin
//#UC START# *4C359EBF0304_4B2A6CEB0377_impl*
 Result := ChangeFileExt(ParamStr(0), '_' + IntToStr(TimesPage) + '.labels.out');
//#UC END# *4C359EBF0304_4B2A6CEB0377_impl*
end;//TKTestListener.GetLabelsFileName
{$IfEnd} // NOT Defined(NoKPageTool)

class function TKTestListener.IsFakeCVS: Boolean;
 {* Не класть эталоны в CVS }
//#UC START# *4CA9DEBE020F_4B2A6CEB0377_var*
var
 l_Index : Integer;
//#UC END# *4CA9DEBE020F_4B2A6CEB0377_var*
begin
//#UC START# *4CA9DEBE020F_4B2A6CEB0377_impl*
 if not f_FakeCVSValid then
 begin
  f_IsFakeCVS := false;
  for l_Index := 1 to ParamCount do
   if (ParamStr(l_Index) = '-FakeCVS') then
   begin
    f_IsFakeCVS := true;
    break;
   end;//ParamStr(l_Index) = '-FakeCVS'
  f_FakeCVSValid := true;
 end;//not f_FakeKValid
 Result := f_IsFakeCVS;
//#UC END# *4CA9DEBE020F_4B2A6CEB0377_impl*
end;//TKTestListener.IsFakeCVS

function TKTestListener.FailedTestsFileName: AnsiString;
//#UC START# *4D0BA93103C6_4B2A6CEB0377_var*
//#UC END# *4D0BA93103C6_4B2A6CEB0377_var*
begin
//#UC START# *4D0BA93103C6_4B2A6CEB0377_impl*
 Result := ChangeFileExt(ResultsFileName, '.failed.txt');
//#UC END# *4D0BA93103C6_4B2A6CEB0377_impl*
end;//TKTestListener.FailedTestsFileName

class procedure TKTestListener.WriteMsg(const aStr: AnsiString);
//#UC START# *4DD65F780370_4B2A6CEB0377_var*
//#UC END# *4DD65F780370_4B2A6CEB0377_var*
begin
//#UC START# *4DD65F780370_4B2A6CEB0377_impl*
 if IsWritingToK then
  WriteLn(aStr);
//#UC END# *4DD65F780370_4B2A6CEB0377_impl*
end;//TKTestListener.WriteMsg

class procedure TKTestListener.AttachFile(aPage: Integer;
 const aFile: AnsiString);
//#UC START# *4EB2C81101FB_4B2A6CEB0377_var*
var
 l_NewName : AnsiString;
//#UC END# *4EB2C81101FB_4B2A6CEB0377_var*
begin
//#UC START# *4EB2C81101FB_4B2A6CEB0377_impl*
 l_NewName := l3Transliterate(aFile);
 if (aFile <> l_NewName) then
  l3FileUtils.CopyFile(aFile, l_NewName);
(*  if not RenameFile(aFile, l_NewName) then
   l3System.Msg2Log(Format('Не удалось переименовать %s в %s', [aFile, l_NewName]));*)
 {$If defined(MTDORB) AND defined(NoKPageTool)}
 if TKBridge.Exists then
  TKBridge.Instance.AttachFile(aPage, l_NewName);
 {$Else}
 CommunicateWithK(aPage, l_NewName, foAttach);
 {$IfEnd}
 if (aFile <> l_NewName) then
  SysUtils.DeleteFile(l_NewName);
//#UC END# *4EB2C81101FB_4B2A6CEB0377_impl*
end;//TKTestListener.AttachFile

class function TKTestListener.TestNameForOutputInTestLists(const aTest: ITest): AnsiString;
 {* Имя теста для вывода в список неудачных тестов и в полный список прогнанных тестов }
//#UC START# *4F16BFB0026E_4B2A6CEB0377_var*
//#UC END# *4F16BFB0026E_4B2A6CEB0377_var*
begin
//#UC START# *4F16BFB0026E_4B2A6CEB0377_impl*
 if ANSIEndsStr('Scripter', aTest.TestClassName) OR
    ANSIEndsStr('AutoTest', aTest.TestClassName) then
  Result := aTest.Name
 else
  Result := aTest.TestClassName;
//#UC END# *4F16BFB0026E_4B2A6CEB0377_impl*
end;//TKTestListener.TestNameForOutputInTestLists

function TKTestListener.AllRunnedTestsFileName: AnsiString;
//#UC START# *4F16C0470089_4B2A6CEB0377_var*
//#UC END# *4F16C0470089_4B2A6CEB0377_var*
begin
//#UC START# *4F16C0470089_4B2A6CEB0377_impl*
 Result := ChangeFileExt(ResultsFileName, '.runned.txt');
//#UC END# *4F16C0470089_4B2A6CEB0377_impl*
end;//TKTestListener.AllRunnedTestsFileName

procedure TKTestListener.WriteTestToAllRunnedTests(const aTest: ITest);
//#UC START# *4F16C8890222_4B2A6CEB0377_var*
//#UC END# *4F16C8890222_4B2A6CEB0377_var*
begin
//#UC START# *4F16C8890222_4B2A6CEB0377_impl*
 if not Supports(aTest, ITestSuite) then
 begin
 // - пишем только конечные тесты, а не наборы
  System.WriteLn(f_AllRunnedTests, TestNameForOutputInTestLists(aTest));
  System.Flush(f_AllRunnedTests);
 end;//not Supports(aTest, ITestSuite)
//#UC END# *4F16C8890222_4B2A6CEB0377_impl*
end;//TKTestListener.WriteTestToAllRunnedTests

procedure TKTestListener.AddMemoryStat(const aTestName: AnsiString);
//#UC START# *5374DB31018E_4B2A6CEB0377_var*

 function Norm(aSize : Cardinal): Cardinal;
 begin
  if (aSize < 700 * 1024) then
   Result := 0
  else
   Result := aSize; 
 end;

var
 l_Name : String;
 l_Suff : String;
 l_NameLeft : String;
 l_NameMax : String;

 l_SuffLeft : String;
 l_SuffMax : String;
//#UC END# *5374DB31018E_4B2A6CEB0377_var*
begin
//#UC START# *5374DB31018E_4B2A6CEB0377_impl*
 if (aTestName = '') then
 begin
  l_Name := '';
  l_Suff := '';
 end//aTestName = ''
 else
 begin
  l_Name := aTestName{ + ' '};
  l_Suff := 'Changes ';
 end;//aTestName = ''

 if (aTestName = '') then
 begin
  l_NameLeft := l_Name + 'Left';
  l_NameMax := l_Name + 'Max';

  l_SuffLeft := l_Suff;
  l_SuffMax := l_Suff;
 end//aTestName = ''
 else
 begin
  l_NameLeft := l_Name;
  l_NameMax := l_Name;

  l_SuffLeft := l_Suff + 'Left ';
  l_SuffMax := l_Suff + 'Max ';
 end;//aTestName = ''
 
 CheckTimeInfo;
 f_TimeInfo.Add(TTimeInfo_C('_ ' + l_SuffLeft + 'Sys Local Memory Used', Norm(l3System.AllLocalMemUsed), l_NameLeft));
 f_TimeInfo.Add(TTimeInfo_C('_ ' + l_SuffLeft + 'Local Memory Used', Norm(Max(l3System.LocalMemUsed, 0)), l_NameLeft));
 f_TimeInfo.Add(TTimeInfo_C('_ ' + l_SuffLeft + 'Global Memory Used', Norm(l3System.GlobalMemUsed), l_NameLeft));
 f_TimeInfo.Add(TTimeInfo_C('_ ' + l_SuffLeft + 'Object Memory Used', Norm(l3System.ObjectMemUsed), l_NameLeft));
 f_TimeInfo.Add(TTimeInfo_C('_ ' + l_SuffLeft + 'Objects Used', Norm(l3System.ObjectCount), l_NameLeft));

 f_TimeInfo.Add(TTimeInfo_C('_ ' + l_SuffMax + 'Sys Local Memory Used', Norm(l3System.MaxAllLocalMemUsed), l_NameMax));
 f_TimeInfo.Add(TTimeInfo_C('_ ' + l_SuffMax + 'Local Memory Used', Norm(l3System.MaxLocalMemUsed), l_NameMax));
 f_TimeInfo.Add(TTimeInfo_C('_ ' + l_SuffMax + 'Global Memory Used', Norm(l3System.MaxGlobalMemUsed), l_NameMax));
 f_TimeInfo.Add(TTimeInfo_C('_ ' + l_SuffMax + 'Object Memory Used', Norm(l3System.MaxObjectMemUsed), l_NameMax));
 f_TimeInfo.Add(TTimeInfo_C('_ ' + l_SuffMax + 'Objects Used', Norm(l3System.MaxObjectCount), l_NameMax));
//#UC END# *5374DB31018E_4B2A6CEB0377_impl*
end;//TKTestListener.AddMemoryStat

class procedure TKTestListener.write(const aStr: AnsiString);
//#UC START# *4B2A6CBC008B_4B2A6CEB0377_var*
var
 l_S : AnsiString;
//#UC END# *4B2A6CBC008B_4B2A6CEB0377_var*
begin
//#UC START# *4B2A6CBC008B_4B2A6CEB0377_impl*
 l_S := aStr;
 l3Replace(l_S, cc_NonReadable - [#10, #13], cc_HardSpace);
 l_S := AnsiReplaceStr(l_S, '[', '\[');
 l_S := AnsiReplaceStr(l_S, ']', '\]');
 l_S := AnsiReplaceStr(l_S, '\[\[', '[');
 l_S := AnsiReplaceStr(l_S, '\]\]', ']');
 System.Write(f_File, l_S);
//#UC END# *4B2A6CBC008B_4B2A6CEB0377_impl*
end;//TKTestListener.write

class procedure TKTestListener.writeln(const aStr: AnsiString = '');
//#UC START# *4B2A6CCF00BB_4B2A6CEB0377_var*
//#UC END# *4B2A6CCF00BB_4B2A6CEB0377_var*
begin
//#UC START# *4B2A6CCF00BB_4B2A6CEB0377_impl*
 Write(aStr + cc_EOL); 
//#UC END# *4B2A6CCF00BB_4B2A6CEB0377_impl*
end;//TKTestListener.writeln

procedure TKTestListener.Cleanup;
//#UC START# *4B2B6B800265_4B2A6CEB0377_var*

 function Norm(aSize : Cardinal): Cardinal;
 begin
  if (aSize < 700 * 1024) then
   Result := 0
  else
   Result := aSize;
 end;

var
 l_Failed : AnsiString;
 l_AllRunned : AnsiString;
 l_CLogToAttach : AnsiString;
//#UC END# *4B2B6B800265_4B2A6CEB0377_var*
begin
//#UC START# *4B2B6B800265_4B2A6CEB0377_impl*
 try
  CloseFile(f_FailedTests);
  CloseFile(f_AllRunnedTests);
  if not f_AllIsOk then
  begin
   if (Pos('draft', GetLabels) > 0) then
   begin
    if not IsLAW then
     System.WriteLn(f_File, '{notify:lulin|title=Один из ежедневных тестов не прошёл}');
   end//Pos('draft', GetLabels) > 0;
   else
    //System.WriteLn(f_File, '{notify:lulin,vkuprovich,dinishev,migel|title=Один из ежедневных тестов не прошёл}');
    System.WriteLn(f_File, '{notify:lulin,dinishev,migel|title=Один из ежедневных тестов не прошёл}');
   System.WriteLn(f_File);
   l_Failed := FailedTestsFileName;
   if (l3FileUtils.GetFileSize(l_Failed) > 0) then
   begin
    System.WriteLn(f_File, '----');
    System.WriteLn(f_File, Format('(!) *Список непрошедших тестов* - [%s|^%s]', [l_Failed, ExtractFileName(l_Failed)]));
    System.WriteLn(f_File);
   end;//l3FileUtils.GetFileSize(l_Failed) > 0
  end;//not f_AllIsOk

  l_AllRunned := AllRunnedTestsFileName;
  if (l3FileUtils.GetFileSize(l_AllRunned) > 0) then
  begin
   System.WriteLn(f_File);
   System.WriteLn(f_File, '----');
   System.WriteLn(f_File, Format('(!) *Список всех запущенных тестов* - [%s|^%s]', [l_AllRunned, ExtractFileName(l_AllRunned)]));
   System.WriteLn(f_File);
  end;//l3FileUtils.GetFileSize(l_Failed) > 0

  if not IsFakeK then
  begin
   l_Failed := FailedTestsFileName;
   if (l3FileUtils.GetFileSize(l_Failed) > 0) then
    AttachFile(ResultsPage, l_Failed);

   l_AllRunned := AllRunnedTestsFileName;
   if (l3FileUtils.GetFileSize(l_AllRunned) > 0) then
    AttachFile(ResultsPage, l_AllRunned);

   {$If defined(MTDORB) AND defined(NoKPageTool)}
   if not f_AllIsOk then
    TKBridge.Instance.Page[ResultsPage].simulate_viewpage_action(KUserPassword);
   {$IfEnd}
   l_Failed := ChangeFileExt(ParamStr(0), '.clog');
   if FileExists(l_Failed) then
    if (l3FileUtils.GetFileSize(l_Failed) > 0) then
    begin
     {$If defined(MTDORB) AND defined(NoKPageTool)}
     CloseFile(Output);
     {$IfEnd}
     l_CLogToAttach := ChangeFileExt(ParamStr(0), '.sav.clog');
     l3FileUtils.CopyFile(l_Failed, l_CLogToAttach);
     {$If defined(MTDORB) AND defined(NoKPageTool)}
     AssignFile(Output, l_Failed);
     if not f_AllIsOk then
      Append(Output)
     else
      Rewrite(Output);
     {$IfEnd}
     AttachFile(ResultsPage, l_CLogToAttach);
     System.WriteLn(f_File, '----');
     System.WriteLn(f_File, Format('(!) *Лог ORB* - [%s|^%s]', [l_CLogToAttach, ExtractFileName(l_CLogToAttach)]));
     System.WriteLn(f_File);
    end;//l3FileUtils.GetFileSize(l_Failed) > 0
  end;//not IsFakeK
  CloseFile(f_File);
  try
   AddMemoryStat('');
   if (f_TimeInfo <> nil) then
    PutTimesToK;
  except
   on E : Exception do
    l3System.Exception2Log(E);
  end;//try.except
  PutResultsToK;
 finally
  FreeAndNil(f_TimeInfo); // Есть примеры, когда течет...
 end;
 BaseTest.f_ToLog := nil;
 BaseTest.f_TimeToLog := nil;
 {$IfDef NoKPageTool}
 if not IsFakeK then
  if TKBridge.Exists then
   TKBridge.Instance.Logout;
 {$EndIf NoKPageTool}
 inherited;
//#UC END# *4B2B6B800265_4B2A6CEB0377_impl*
end;//TKTestListener.Cleanup

procedure TKTestListener.InitFields;
//#UC START# *4B2B6BA1037F_4B2A6CEB0377_var*
var
 l_CPU : TCpuInfo;
 l_Map : AnsiString;
 l_V : AnsiString;
//#UC END# *4B2B6BA1037F_4B2A6CEB0377_var*
begin
//#UC START# *4B2B6BA1037F_4B2A6CEB0377_impl*
 inherited;
 BaseTest.f_ToLog := ToLog;
 BaseTest.f_TimeToLog := TimeToLog;

 GetTimesFromK;

 AssignFile(f_File, ResultsFileName);
 Rewrite(f_File);

 AssignFile(f_FailedTests, FailedTestsFileName);
 Rewrite(f_FailedTests);

 AssignFile(f_AllRunnedTests, AllRunnedTestsFileName);
 Rewrite(f_AllRunnedTests);

 {$IfDef XE}
 WriteLn('XE');
 {$EndIf XE}
 WriteLn(TBaseTest.ComputerName);
 GetCpuInfo(l_CPU);
 with l_CPU do
 begin
  Write(CpuName);
(*  Write(#32);
  Write(IntToStr(FrequencyInfo.RawFreq));
  Write(#32);
  Write(IntToStr(FrequencyInfo.NormFreq));*)
  WriteLn;
  WriteLn(Format('%s %s', [GetWindowsVersionString, GetWindowsServicePackVersionString]));
  WriteLn('----');
  WriteLn(Format('SESSIONNAME = "%s"', [SysUtils.GetEnvironmentVariable('SESSIONNAME')]));
  WriteLn(Format('IsRemoteSession = %s', [BoolToStr(l3IsRemoteSession, true)]));
  if not SameText(SysUtils.GetEnvironmentVariable('SESSIONNAME'), 'Console') then
  // - не подключены к консоли
   WriteLn(Format('WTSGetActiveConsoleSessionId = %d', [Integer(WTSGetActiveConsoleSessionId)]));
  WriteLn('----');
  WriteLn(Format('Screen resolution: %dx%d', [Screen.Width, Screen.Height]));
  WriteLn(Format('Desktop resolution: %dx%d', [Screen.DesktopWidth, Screen.DesktopHeight]));
  WriteLn(Format('Desktop origin: %dx%d', [Screen.DesktopLeft, Screen.DesktopTop]));
  WriteLn(Format('WorkArea resolution: %dx%d', [Screen.WorkAreaWidth, Screen.WorkAreaHeight]));
  WriteLn(Format('WorkArea origin: %dx%d', [Screen.WorkAreaLeft, Screen.WorkAreaTop]));
  WriteLn(Format('MonitorCount: %d', [Screen.MonitorCount]));
  WriteLn('----');
 end;//with l_CPU

 WriteLn(ParamStr(0) + ' ' + l3DateTimeToStr(FileDateTime(ParamStr(0))));

 l_V := Tl3VersionInfoService.Instance.VersionInfo;
 if (l_V <> '') then
  WriteLn('Version: ' + l_V);

 l_Map := ChangeFileExt(ParamStr(0), '.map');
 WriteLn(l_Map + ' ' + l3DateTimeToStr(FileDateTime(l_Map)));
//#UC END# *4B2B6BA1037F_4B2A6CEB0377_impl*
end;//TKTestListener.InitFields

function TKTestListener.NeedsMilliseconds: Boolean;
 {* Выводить ли милисекунды }
//#UC START# *4B2FBFA903C9_4B2A6CEB0377_var*
//#UC END# *4B2FBFA903C9_4B2A6CEB0377_var*
begin
//#UC START# *4B2FBFA903C9_4B2A6CEB0377_impl*
 Result := false;
//#UC END# *4B2FBFA903C9_4B2A6CEB0377_impl*
end;//TKTestListener.NeedsMilliseconds

function TKTestListener.PrintErrorItem(i: Integer;
 r: TTestFailure): AnsiString;
//#UC START# *4CACA6980207_4B2A6CEB0377_var*

{$If defined(MTDORB) AND defined(NoKPageTool)}
 function MangleName(const aName: AnsiString): AnsiString;
 begin
  Result := aName;
  if ANSIStartsStr('TK', Result) then
   Delete(Result, 1, 1);
 end;

 function MangleName1(const aName: AnsiString): AnsiString;
 begin
  Result := aName;
  if ANSIStartsStr('K', Result) AND
     ANSIEndsStr('.script', Result) then
  begin
   Delete(Result, 1, 1);
   if (Result[1] in cc_Digits) then
   begin
    Delete(Result, Length(Result)-7+1, 7);
    Result := '[$' + Result + '] - ' + aName;
   end;//Result[1] in cc_Digits
  end//ANSIStartsStr('K', Result)
  else
  if ANSIStartsStr('TK', Result) AND
     ANSIEndsStr('.script', Result) then
  begin
   Delete(Result, 1, 1);
   if (Result[1] in cc_Digits) then
   begin
    Delete(Result, Length(Result)-7+1, 7);
    Result := '[$' + Result + '] - ' + aName;
   end;//Result[1] in cc_Digits
  end;//ANSIStartsStr('TK', Result)
 end;
 
var
 l_ReqName : AnsiString;
 l_Child   : IServerGate_Contents_KPage;
{$IfEnd} //MTDORB AND NoKPageTool

//#UC END# *4CACA6980207_4B2A6CEB0377_var*
begin
//#UC START# *4CACA6980207_4B2A6CEB0377_impl*
 Result := inherited PrintErrorItem(i, r);
 System.WriteLn(f_FailedTests, TestNameForOutputInTestLists(r.FailedTest));
 System.Flush(f_FailedTests);
 {$If defined(MTDORB) AND defined(NoKPageTool)}
 if IsWritingToK then
 begin
  l_ReqName := Format('Не проходит тест "%s" на машине "%s"',
                      [MangleName(r.FailedTest.TestClassName),
                       TBaseTest.ComputerName]);
  try
   //l_Child := TKBridge.Instance.Page[ResultsPage].create_child(l_ReqName);
   // - пока отключено, т.к. падает
  except
   Exit;
  end;//try..except
  if (l_Child <> nil) then
   try
    l_Child.set_wiki_text(Format('%s : [%s] : %s : %s',
                          [MangleName1(r.FailedTest.name),
                           MangleName(r.FailedTest.TestClassName),
                           r.FailedTest.GetSuffixName,
                           r.thrownExceptionName
                          ]));
   finally
    l_Child := nil;
   end;//try..finally
 end;//IsWritingToK
 {$IfEnd} //MTDORB AND NoKPageTool
//#UC END# *4CACA6980207_4B2A6CEB0377_impl*
end;//TKTestListener.PrintErrorItem

procedure TKTestListener.AddSuccess(const test: ITest);
//#UC START# *4F16BEF60233_4B2A6CEB0377_var*
//#UC END# *4F16BEF60233_4B2A6CEB0377_var*
begin
//#UC START# *4F16BEF60233_4B2A6CEB0377_impl*
 inherited;
 WriteTestToAllRunnedTests(test);
//#UC END# *4F16BEF60233_4B2A6CEB0377_impl*
end;//TKTestListener.AddSuccess

procedure TKTestListener.AddError(error: TTestFailure);
//#UC START# *4F16BF26031B_4B2A6CEB0377_var*
//#UC END# *4F16BF26031B_4B2A6CEB0377_var*
begin
//#UC START# *4F16BF26031B_4B2A6CEB0377_impl*
 inherited;
 WriteTestToAllRunnedTests(error.FailedTest);
//#UC END# *4F16BF26031B_4B2A6CEB0377_impl*
end;//TKTestListener.AddError

procedure TKTestListener.AddFailure(failure: TTestFailure);
//#UC START# *4F16BF430163_4B2A6CEB0377_var*
//#UC END# *4F16BF430163_4B2A6CEB0377_var*
begin
//#UC START# *4F16BF430163_4B2A6CEB0377_impl*
 inherited;
 WriteTestToAllRunnedTests(failure.FailedTest);
//#UC END# *4F16BF430163_4B2A6CEB0377_impl*
end;//TKTestListener.AddFailure

procedure TKTestListener.TestingStarts;
//#UC START# *5374DA8103BC_4B2A6CEB0377_var*
//#UC END# *5374DA8103BC_4B2A6CEB0377_var*
begin
//#UC START# *5374DA8103BC_4B2A6CEB0377_impl*
 inherited;
 f_RunnedCount := 0;
//#UC END# *5374DA8103BC_4B2A6CEB0377_impl*
end;//TKTestListener.TestingStarts

procedure TKTestListener.TestingEnds(testResult: TTestResult);
//#UC START# *5374DA9401BF_4B2A6CEB0377_var*
//#UC END# *5374DA9401BF_4B2A6CEB0377_var*
begin
//#UC START# *5374DA9401BF_4B2A6CEB0377_impl*
 inherited;
//#UC END# *5374DA9401BF_4B2A6CEB0377_impl*
end;//TKTestListener.TestingEnds

procedure TKTestListener.StartTest(test: ITest);
//#UC START# *5374DAC503BB_4B2A6CEB0377_var*
const
 cStep = 20;
var
 l_Name : String;
//#UC END# *5374DAC503BB_4B2A6CEB0377_var*
begin
//#UC START# *5374DAC503BB_4B2A6CEB0377_impl*
 inherited;
 if not Supports(test, ITestSuite) then
 begin
  Inc(f_RunnedCount);
  if (f_RunnedCount > 0) AND (f_RunnedCount mod cStep = 0) then
  begin
   l_Name := Format('%.4d. ', [f_RunnedCount div cStep]);
   l_Name := l_Name + TestNameForOutputInTestLists(test);
 (*  l_Name := l_Name + test.TestClassName;
   if (test.Name <> 'DoIt') then
    l_Name := l_Name + '.' + test.Name;*)
   AddMemoryStat(l_Name);
  end;//f_RunnedCount > 0..
 end;//not Supports(test, ITestSuite)
//#UC END# *5374DAC503BB_4B2A6CEB0377_impl*
end;//TKTestListener.StartTest

class function TTestResultsPlace.HasTabs: Boolean;
//#UC START# *555EF157016F_4B7AAC7A031D_var*
//#UC END# *555EF157016F_4B7AAC7A031D_var*
begin
//#UC START# *555EF157016F_4B7AAC7A031D_impl*
 Result := TBaseTest.HasTabs;
//#UC END# *555EF157016F_4B7AAC7A031D_impl*
end;//TTestResultsPlace.HasTabs

class function TTestResultsPlace.IsGK: Boolean;
 {* Тесты запущены ГК }
//#UC START# *4BEA9969001B_4B7AAC7A031D_var*
//#UC END# *4BEA9969001B_4B7AAC7A031D_var*
begin
//#UC START# *4BEA9969001B_4B7AAC7A031D_impl*
 Result := false;
//#UC END# *4BEA9969001B_4B7AAC7A031D_impl*
end;//TTestResultsPlace.IsGK

class function TTestResultsPlace.IsLAW: Boolean;
//#UC START# *4C35A6DA02E9_4B7AAC7A031D_var*
//#UC END# *4C35A6DA02E9_4B7AAC7A031D_var*
begin
//#UC START# *4C35A6DA02E9_4B7AAC7A031D_impl*
 Result := false;
//#UC END# *4C35A6DA02E9_4B7AAC7A031D_impl*
end;//TTestResultsPlace.IsLAW
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

end.

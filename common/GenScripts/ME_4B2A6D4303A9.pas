unit KTestRunner;

interface

uses
 l3IntfUses
 , BaseTest
 , TestNameList
 , TextTestRunner
 , l3Filer
 , l3Interfaces
 , TestFrameWork
 , l3ProtoDataContainer
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
 end;//TTimeInfoName
 
 PTimeInfo = ^TTimeInfo;
 
 TTimeInfo = object
  {* Информация о замере времени }
 end;//TTimeInfo
 
 {$Define l3Items_NeedsAssignItem}
 
 TTimeInfoList = class(Tl3ProtoDataContainer)
  {* Список замеров времени }
  procedure Compact(aCount: Integer);
   {* Минимизирует число замеров в графике до указанного числа }
  procedure DeleteOld(aDateDelta: Integer);
   {* Удаляет старые замеры }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TTimeInfoList
 
 TKTestListener = class(TTextTestListener)
  {* Тест, выводящий результаты в К }
  procedure PutResultsToK;
  procedure ToLog(const aSt: AnsiString);
  procedure PutFileToK(aPageID: Integer;
   const aFileName: AnsiString);
  procedure TimeToLog(aTime: Cardinal;
   const aSt: AnsiString;
   const aSubName: AnsiString);
  procedure CommunicateWithK(aPageID: Integer;
   const aFileName: AnsiString;
   anOp: TKFileOperation);
  procedure GetFileFromK(aPageID: Integer;
   const aFileName: AnsiString);
   {* Получает файл из К }
  procedure GetTimesFromK;
   {* Получает из К замеры времени }
  procedure CheckTimeInfo;
   {* Проверяет, что список времён создан }
  function TimesPage: Integer;
  function ResultsPage: Integer;
  function TimesFileName: AnsiString;
  function ResultsFileName: AnsiString;
  function IsFakeK: Boolean;
  procedure PutTimesToK;
   {* Выводит в К замеры времени }
  function GetLabels: AnsiString;
   {* Возвращает метки страницы с тестами }
  function GetLabelsFileName: AnsiString;
   {* Возвращает имя файла с метками страницы тестов }
  function IsFakeCVS: Boolean;
   {* Не класть эталоны в CVS }
  function FailedTestsFileName: AnsiString;
  procedure WriteMsg(const aStr: AnsiString);
  procedure AttachFile(aPage: Integer;
   const aFile: AnsiString);
  function TestNameForOutputInTestLists(const aTest: ITest): AnsiString;
   {* Имя теста для вывода в список неудачных тестов и в полный список прогнанных тестов }
  function AllRunnedTestsFileName: AnsiString;
  procedure WriteTestToAllRunnedTests(const aTest: ITest);
  procedure AddMemoryStat(const aTestName: AnsiString);
 end;//TKTestListener
 
 RTestResultsPlace = class of TTestResultsPlace;
 
 TTestResultsPlaces = array of RTestResultsPlace;
 
 TTestResultsPlace = class
  {* Место для складывания результатов тестов }
  function HasTabs: Boolean;
  function CommandLineKey: AnsiString;
   {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
  function TimesPage: Integer;
   {* Страница для вывода замеров времени }
  function ResultsPage: Integer;
   {* Страница для вывода результатов тестов }
  function IsGK: Boolean;
   {* Тесты запущены ГК }
  function IsLAW: Boolean;
 end;//TTestResultsPlace
 
implementation

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
 , Forms
 , l3SysUtils
 , KBridge
 , Contents_int
 , tfwKConst
 , l3Base
 , l3MinMax
 , RTLConsts
 , Windows
 , l3Stream
 , l3Types
 , l3String
 , JwaWinBase
;

end.

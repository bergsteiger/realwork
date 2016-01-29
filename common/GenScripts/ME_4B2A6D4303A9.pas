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
  {* �������� � ������ � � }
  foGet
   {* ��������� ���� }
  , foSet
   {* �������� ���� }
  , foGetLabel
   {* �������� ����� }
  , foSetLabel
   {* ���������� ����� }
  , foAttach
 );//TKFileOperation
 
 TTimeInfoName = object
 end;//TTimeInfoName
 
 PTimeInfo = ^TTimeInfo;
 
 TTimeInfo = object
  {* ���������� � ������ ������� }
 end;//TTimeInfo
 
 {$Define l3Items_NeedsAssignItem}
 
 TTimeInfoList = class(Tl3ProtoDataContainer)
  {* ������ ������� ������� }
  procedure Compact(aCount: Integer);
   {* ������������ ����� ������� � ������� �� ���������� ����� }
  procedure DeleteOld(aDateDelta: Integer);
   {* ������� ������ ������ }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* ���������� ��� ������������ ��������. }
 end;//TTimeInfoList
 
 TKTestListener = class(TTextTestListener)
  {* ����, ��������� ���������� � � }
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
   {* �������� ���� �� � }
  procedure GetTimesFromK;
   {* �������� �� � ������ ������� }
  procedure CheckTimeInfo;
   {* ���������, ��� ������ ����� ������ }
  function TimesPage: Integer;
  function ResultsPage: Integer;
  function TimesFileName: AnsiString;
  function ResultsFileName: AnsiString;
  function IsFakeK: Boolean;
  procedure PutTimesToK;
   {* ������� � � ������ ������� }
  function GetLabels: AnsiString;
   {* ���������� ����� �������� � ������� }
  function GetLabelsFileName: AnsiString;
   {* ���������� ��� ����� � ������� �������� ������ }
  function IsFakeCVS: Boolean;
   {* �� ������ ������� � CVS }
  function FailedTestsFileName: AnsiString;
  procedure WriteMsg(const aStr: AnsiString);
  procedure AttachFile(aPage: Integer;
   const aFile: AnsiString);
  function TestNameForOutputInTestLists(const aTest: ITest): AnsiString;
   {* ��� ����� ��� ������ � ������ ��������� ������ � � ������ ������ ���������� ������ }
  function AllRunnedTestsFileName: AnsiString;
  procedure WriteTestToAllRunnedTests(const aTest: ITest);
  procedure AddMemoryStat(const aTestName: AnsiString);
 end;//TKTestListener
 
 RTestResultsPlace = class of TTestResultsPlace;
 
 TTestResultsPlaces = array of RTestResultsPlace;
 
 TTestResultsPlace = class
  {* ����� ��� ����������� ����������� ������ }
  function HasTabs: Boolean;
  function CommandLineKey: AnsiString;
   {* ���� ��������� ������ ��� �������� �������� ����� ������� ������ ����� ������������ ����������� }
  function TimesPage: Integer;
   {* �������� ��� ������ ������� ������� }
  function ResultsPage: Integer;
   {* �������� ��� ������ ����������� ������ }
  function IsGK: Boolean;
   {* ����� �������� �� }
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

unit BaseTest;

interface

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
 
 TBaseTest = class(TTestCase)
  procedure ToLog(const aSt: AnsiString);
  function StartTimer: Longword;
  function StopTimer(const aSt: AnsiString;
   const aSubName: AnsiString): Longword; overload;
  function FileFromCurrent(const aStr: AnsiString;
   aFolderMode: Boolean): AnsiString;
   {* Файл из текущей директории }
  procedure TimeToLog(aTime: Cardinal;
   const aSt: AnsiString;
   const aSubName: AnsiString;
   aIgnoreTestName: Boolean);
   {* Выводит замер времени в лог }
  function FileForOutput: AnsiString;
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
  function EtalonNeedsComputerName: Boolean;
  function ComputerName: AnsiString;
  function OutputPath: AnsiString;
  function RaiseIfEtalonCreated: Boolean;
  function EtalonCanHaveDiff: Boolean;
   {* Эталон может иметь эталонную разницу для конкретного компьютера. Например как в [RequestLink:234362304] }
  function FileNameForOutput: AnsiString;
  function AlwaysShowAFC: Boolean;
   {* Всегда показывать сравнивалку файлов, когда не пишем в К }
  function FolderFromCurrent(const aStr: AnsiString): AnsiString;
  function NeedCreateEtalonsWhileCheckingOutputWithInput: Boolean;
  function TestSetFolderName(aNoSuffix: Boolean): AnsiString;
  function EtalonNeedsXE: Boolean;
  function EtalonNeedsOSName: Boolean;
  function EtalonNeeds64: Boolean;
  function OutputFolderName: AnsiString;
   {* Папка, в которую пишутся выходные файлы. }
  procedure CheckEtalonInFolder(aHeaderBegin: AnsiChar);
  procedure ClearTestFolder;
  function OutputFolderNameWitEtalons: AnsiString;
   {* Директория для эталонов. }
  function GetFullPath2OutputFolderName: AnsiString;
  function CheckExternalPicture(aMakeEtalon: Boolean;
   const aCVSPath: AnsiString;
   var aCompareImage: Boolean): AnsiString;
  function IsWritingToK: Boolean;
  function HasTabs: Boolean;
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
   aHeaderBegin: AnsiChar;
   const anExtraFileName: AnsiString;
   aNeedsCheck: Boolean); overload;
  procedure CheckPictureOnly;
 end;//TBaseTest
 
implementation

uses
 l3ImplUses
 , SysUtils
 , KTestRunner
 , l3String
 , l3ImageUtils
 , KBridge
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

end.

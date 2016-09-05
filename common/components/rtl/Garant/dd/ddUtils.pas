//..........................................................................................................................................................................................................................................................
unit ddUtils;
{ Различные процедуры и функции. В основном связанные с преобразованием
  времени и числа байт в строки }


{ $Id: ddUtils.pas,v 1.89 2016/06/17 12:46:03 fireton Exp $ }

// $Log: ddUtils.pas,v $
// Revision 1.89  2016/06/17 12:46:03  fireton
// - мелкая правка
//
// Revision 1.88  2016/06/17 11:17:59  dinishev
// {Requestlink:624709249}. Тест.
//
// Revision 1.87  2016/06/15 11:37:20  dinishev
// {Requestlink:624690924}. Отделил генерацию для Грунева.
//
// Revision 1.86  2015/10/26 06:55:41  dinishev
// Remove warnings.
//
// Revision 1.85  2015/07/28 12:44:11  fireton
// - запрещаем парню запускаться с сетевого пути
//
// Revision 1.84  2015/04/16 13:54:27  lulin
// - перерисовываем.
//
// Revision 1.83  2015/04/13 10:23:28  lulin
// - пытаемся собрать библиотекку.
//
// Revision 1.82  2015/04/08 12:25:00  dinishev
// Исправил хитрые зависимости между модулями.
//
// Revision 1.81  2014/10/15 10:59:16  lukyanets
// Отучаем ddAppCOnfig от dd
//
// Revision 1.80  2014/10/13 06:49:49  lukyanets
// Переносим функции на более низкий уровень
//
// Revision 1.79  2014/10/10 12:03:16  lukyanets
// Частичное вычитывание параметров
//
// Revision 1.78  2014/09/09 10:39:08  lulin
// - более по-человечески называем класс.
//
// Revision 1.77  2014/05/22 12:58:21  dinishev
// {Requestlink:534790284}
//
// Revision 1.76  2014/04/15 10:42:03  dinishev
// {Requestlink:528446913}
//
// Revision 1.75  2013/12/09 11:33:06  fireton
// - после Trim строка может оказаться пустой и получим Range Check Error (K 506703856)
//
// Revision 1.74  2013/04/11 16:46:29  lulin
// - отлаживаем под XE3.
//
// Revision 1.73  2013/04/05 12:04:30  lulin
// - портируем.
//
// Revision 1.72  2013/03/29 12:58:02  narry
// Помоломались тесты
//
// Revision 1.71  2013/03/28 10:19:14  narry
// UpperCaseFirstLetter пропускает все небуквы
//
// Revision 1.70  2012/11/19 06:45:20  narry
// Обновление
//
// Revision 1.69  2012/11/16 06:22:59  narry
// Не работают тесты
//
// Revision 1.66  2012/06/27 08:16:03  narry
// Избавляемся от ddZipUtils
//
// Revision 1.65  2012/06/27 07:43:25  narry
// Избавляемся от ddZipUtils
//
// Revision 1.64  2012/06/26 13:57:05  narry
// Функция упаковки собственного лога
//
// Revision 1.63  2012/03/31 07:39:18  migel
// - fix: не компилировалось.
//
// Revision 1.62  2012/03/30 05:07:40  narry
// Не собиралось
//
// Revision 1.61  2012/02/15 12:59:50  narry
// Обновление
//
// Revision 1.60  2012/01/11 10:37:59  narry
// функция Running32ON64
//
// Revision 1.59  2011/11/09 12:20:20  narry
// Пропускать захваченные файлы (281514104)
//
// Revision 1.58  2011/11/07 09:08:12  narry
// Не работает импорт документов (296632243)
//
// Revision 1.57  2011/10/17 10:08:47  narry
// Формирование списка документов для расстановки (293276752)
//
// Revision 1.56  2011/06/15 08:22:19  narry
// Не прошла ночная сборка (15.06.2011)
//
// Revision 1.55  2011/04/11 10:25:01  narry
// Названия для ФАС (259885290)
//
// Revision 1.54  2011/03/15 14:36:25  fireton
// - небольшая доработка CalcElapsedTime
//
// Revision 1.53  2010/10/14 04:49:07  narry
// - Удаление функции IsRemote
// - Мелкие исправления
//
// Revision 1.52  2010/03/11 14:00:28  narry
// - уничтожен "огородик" восстановления регистра
//
// Revision 1.51  2010/03/11 09:16:02  lulin
// - bug fix: не собирались утилиты F1.
//
// Revision 1.50  2010/03/10 13:57:24  narry
// - не собиралось
//
// Revision 1.49  2009/11/10 09:15:58  narry
// - обновление
//
// Revision 1.48  2009/04/16 11:48:20  fireton
// [$143396358]. Переносим base64 из DD в L3
//
// Revision 1.47  2008/10/15 09:04:09  fireton
// - функции для работы с base64
//
// Revision 1.46  2008/08/20 10:09:54  narry
// - процедура проверки запуска в RemoteDesktop
//
// Revision 1.45  2008/07/16 16:11:51  narry
// - более точное определение символа подстановки
//
// Revision 1.44  2008/05/14 10:43:35  narry
// - вспомогательная функция
//
// Revision 1.43  2008/03/13 14:46:40  narry
// - функция вычисления ближайшего дня недели
//
// Revision 1.42  2008/03/04 11:42:06  narry
// - исправление ошибок в ValidFolder
//
// Revision 1.41  2008/02/27 15:49:40  narry
// - не удалялся временный файл
//
// Revision 1.40  2007/11/16 09:28:16  narry
// - процедуры проверки папки на существование
//
// Revision 1.39  2007/09/28 05:37:16  narry
// - обновление
//
// Revision 1.38  2007/07/24 12:32:29  narry
// - рефакторинг системы сообщений
//
// Revision 1.37  2007/07/04 09:14:46  narry
// - базовые процедуры шифрования строки
//
// Revision 1.36  2007/04/18 11:35:46  narry
// - переход на Int64
//
// Revision 1.35  2007/01/29 12:20:24  narry
// - обновление
//
// Revision 1.34  2006/01/05 14:59:39  narry
// - новое: процедуры записи-чтения состояния визуальных элементов в файл
//
// Revision 1.33  2005/10/04 11:43:50  narry
// - исправление: Range Check
//
// Revision 1.32  2005/02/18 16:59:35  narry
// - bug fix: некорректный перевод секунд в строку
//
// Revision 1.31  2005/02/16 17:10:41  narry
// - update: Delphi 2005
//
// Revision 1.30  2004/10/06 16:11:29  narry
// - update: замена шила на мыло
//
// Revision 1.29  2004/09/14 15:58:03  lulin
// - удален модуль Str_Man - используйте вместо него - l3String.
//
// Revision 1.28  2004/07/28 14:15:22  narry
// - update: расширение функциональности функции Byte2Str
//
// Revision 1.27  2003/09/15 14:36:05  narry
// - update
//
// Revision 1.26  2003/07/18 14:00:14  narry
// - bug fix: нулевое значение размера размера, переданное в Byte2Str интерпретировалось как Гбайт
//
// Revision 1.25  2003/07/16 10:36:50  narry
// - update
//
// Revision 1.24  2003/07/14 13:25:39  narry
// - bug fix: неправильные константы множителей
//
// Revision 1.23  2003/04/19 12:30:38  law
// - new file: ddDefine.inc.
//
// Revision 1.22  2003/02/05 11:54:06  narry
// - cleanup
//
// Revision 1.21  2002/10/01 12:11:57  narry
// - update: Отказ от использования l3Date
//
// Revision 1.20  2002/09/19 13:09:16  narry
// - remove unit: ddHTML.
//
// Revision 1.19  2002/02/01 11:49:23  narry
// - update
//
// Revision 1.18  2001/08/29 15:36:27  law
// - cleanup: удалены ненужные зависимости от Orpheus и SysTools.
//
// Revision 1.17  2001/04/27 09:24:48  narry
// Bug fix - борьба с арифметическими ошибками
//
// Revision 1.16  2001/03/02 11:53:38  narry
// Update
//
// Revision 1.15  2000/12/15 15:29:55  law
// - вставлены директивы Log и Id.
//

{$I ddDefine.inc }

interface

uses
 Forms, Controls, StFileOp;

type
  TCharSet = Set of AnsiChar;

function CalcSpeed(Size: int64; Interval: TDateTime): ShortString;

function CalcSpeedEx(Size: Longint; StartDateTime: TDateTime;
                     StopDateTime: TDateTime): ShortString;

function CalcSpeedExSec(Size, TimeSec: Int64): ShortString;

function GetProgramVersion: ShortString;

function TimeSec2Str(TimeSec: Int64): ShortString;

function ElapsedSec(aStartDateTime: TDateTime; aStopDateTime: TDateTime): Int64;
{ Потраченное время  в секундах }

function CalcElapsedTime(aStartDateTime: TDateTime;
                         aStopDateTime: TDateTime = 0): ShortString;
{ Потраченное время в строковом виде }

function CalcEstimatedTime(aTotal, aCurrent: Int64; aStartDateTime, aStopDateTime: TDateTime): ShortString;
{ Полное время на процесс в строковом виде  }

function CalcLeftTime(aTotal, aCurrent: int64; aStartDateTime, aStopDateTime: TDateTime): ShortString;
{ Оставшееся время в строковом виде  }


type
  TddSizeType = (dd_stGiga, dd_stMega, dd_stKilo, dd_stSimple, dd_stAuto);

const
 dd_KiloByte = 1024;
 dd_SizeMulti : array[TddSizeType] of Longint = (dd_KiloByte*dd_KiloByte*dd_KiloByte,
                                            dd_KiloByte*dd_KiloByte,
                                            dd_KiloByte,
                                            1,
                                            0);
 dd_SizePrefix : array[TddSizeType] of AnsiString = ('Г',
                                             'М',
                                             'к',
                                             ' ',
                                             ' ');
function GetSizePrefix(const aSize: Int64): TddSizeType;
function Bytes2Str(const Size: Int64; const aSizeType: TddSizeType = dd_stAuto):
    ShortString;

procedure RestartApplication(const aParams: AnsiString = '');

procedure SaveSettings(theControl: TWinControl);

procedure LoadSettings(theControl: TWinControl);

function GetWindowsTempFolder: AnsiString;

procedure EnabledAsParent(container: TWinControl);

//returns True if the currently logged Windows user has Administrator rights
function IsWindowsAdmin: Boolean;

function GetSpecialFolderPath(folder : integer) : AnsiString;
// Возвращает специальный путь в зависимости от Folder:
(* Константы, определены в SHFolder
  CSIDL_PERSONAL = $0005; { My Documents }
  CSIDL_APPDATA = $001A; { Application Data, new for NT4 }
  CSIDL_LOCAL_APPDATA = $001C; { non roaming, user\Local Settings\Application Data }
  CSIDL_INTERNET_CACHE = $0020;
  CSIDL_COOKIES = $0021;
  CSIDL_HISTORY = $0022;
  CSIDL_COMMON_APPDATA = $0023; { All Users\Application Data }
  CSIDL_WINDOWS = $0024; { GetWindowsDirectory() }
  CSIDL_SYSTEM = $0025; { GetSystemDirectory() }
  CSIDL_PROGRAM_FILES = $0026; { C:\Program Files }
  CSIDL_MYPICTURES = $0027; { My Pictures, new for Win2K }
  CSIDL_PROGRAM_FILES_COMMON = $002b; { C:\Program Files\Common }
  CSIDL_COMMON_DOCUMENTS = $002e; { All Users\Documents }

  CSIDL_FLAG_CREATE = $8000; { new for Win2K, or this in to force creation of folder }

  CSIDL_COMMON_ADMINTOOLS = $002f; { All Users\Start Menu\Programs\Administrative Tools }
  CSIDL_ADMINTOOLS = $0030; { <user name>\Start Menu\Programs\Administrative Tools }
*)

function ValidFolder(aFolder: AnsiString; ForWrite: Boolean = True): Boolean;

function SafeValidFolder(aFolderName: AnsiString; ForWrite: Boolean = True): AnsiString;

function ExtractPattern(aText: AnsiString): AnsiString;

function GetNearestDay(aToday: TDateTime; aDayOfWeek: Word; const aNext: Boolean = True): TDateTime;

type
  TddTimeType = (dd_ttDay, dd_ttHour, dd_ttMin, dd_ttSec);

function CopyFolder(Source, Destination: AnsiString; FullStructure: Boolean =
    True): Boolean;

function CopyFiles(const aSourceFolder, aDestFolder: AnsiString; Operation: TStFileOp = fopCopy):
    Boolean;

procedure MoveFiles(const aSourceFolder, aDestinationFolder: AnsiString);

procedure UpperCaseFirstLetter(var aText: AnsiString);

function MakeUniqueFolderName(const aFolder: AnsiString; const aLast: Boolean =
    False): AnsiString;

function DateToString(aDate: TDateTime): AnsiString;

function EnableOpenFile(const aFileName: AnsiString): Boolean;

function Running32ON64: boolean;

function GetAppFolderFileName(const aFileName: AnsiString; aUnique: Boolean = False): AnsiString;

function ResetSelfLog(aSizeLimit: Integer): AnsiString;

function GetOutputDirName4Test(aDirName: AnsiString; aSubDir: AnsiString; aTestName: AnsiString): AnsiString;

function NumSuffix(const aNum: Integer; const aOneForm, aTwoForm, aPluralForm: AnsiString): AnsiString;
{ позволяет подставить к числительному слово в нужной форме, возвращает строку с числом и суффиксом }
{ использование: Msg2Log('%s', [NumSuffix(l_Num, 'лошадка', 'лошадки', 'лошадок')]); }

function IsNetworkPath(const aPath: AnsiString): Boolean;
{ проверка, находится ли указанный файл на сети }

procedure AssertRunningFromLocal(aQuietly: Boolean = False);
{ проверяет, что приложение запущено не с сетевого пути и если всё-таки да, то выводит сообщение и }
{ останавливает выполнение программы, используется при старте в файле проекта }

function ddStyleUndefined(aStyle: Integer): Boolean;
function ddUnicode2Char(aUnicodeID: Integer): AnsiChar;

const
  dd_TimeMulti : array[TddTimeType] of Longint =
             (24*60*60, 60*60, 60, 1);
  dd_TimeName : array[TddTimeType] of ShortString =
             ('день', 'час', 'мин', 'сек');
  dd_MaxTime = 30*24*60*60; // месяц

implementation

uses
  SysUtils,
  ShellApi,
  Windows,

  DateUtils,
  StdCtrls,
  Classes,
  Math,
  StrUtils,
  Types,
  CheckLst,
  ExtCtrls,
  ComCtrls,

  SHFolder,

  vtVerInf,

  ddTypes,
  
  l3IniFile,
  l3FileUtils,
  l3String,
  {$IFDEF InsiderTest}
  KTestRunner,
  {$ENDIF InsiderTest}
  L3Bits,
  l3ExceptionsLog,
  l3Base,
  l3Chars

  {$IfNDef NoScripts}
  ,
  CheckListBoxWordsPack
  {$EndIf NoScripts}
  ;

const
 c_100 = 100;

function GetSpecialFolderPath(folder : integer) : AnsiString;
const
  SHGFP_TYPE_CURRENT = 0;
var
  path: array [0..MAX_PATH] of AnsiChar;
begin
  if SUCCEEDED(SHGetFolderPath(0,folder,0,SHGFP_TYPE_CURRENT,@path[0])) then
    Result := path
  else
    Result := '';
end;


function GetOutputDirName4Test(aDirName: AnsiString; aSubDir: AnsiString; aTestName: AnsiString): AnsiString;
begin
 {$IFDEF InsiderTest}
 if aDirName = '' then
  Result := GetAppTestSetPath
 else
  Result := aDirName;
 if aSubDir <> '' then
  Result := NormalDir(Result) + aSubDir;
 Result := NormalDir(Result) + aTestName;
 ForceDirectories(Result);
 {$ENDIF InsiderTest}
end;

function CalcSpeed(Size: int64; Interval: TDateTime): ShortString;
var
 l_SizePrefix: TddSizeType;
  TimeSt: AnsiString;
  SizeRealHi, SizeRealLo: Integer;
  TimeRealHi, TimeRealLo: Integer;
  Hour, Min, Sec, MSec: Word;
begin
  DecodeTime(Interval, Hour, Min, Sec, MSec);
  if Hour > 0 then
  begin
    TimeSt:= 'часов';
    TimeRealHi:= Hour+Min div c_100;
    TimeRealLo:= Hour+Min mod c_100;
  end
  else
  if Min > 0 then
  begin
    TimeSt:= 'минут';
    TimeRealHi:= Min+Sec div c_100;
    TimeRealLo:= Min+Sec mod c_100;
  end
  else
  begin
    TimeSt:= 'секунд';
    TimeRealHi:= Sec+MSec div c_100;
    TimeRealLo:= Sec+MSec mod c_100;
  end;

 l_SizePrefix:= GetSizePrefix(Size);
 if l_SizePrefix > dd_stMega then
  l_SizePrefix:= dd_stMega;
 SizeRealHi:= Size div dd_SizeMulti[l_SizePrefix];
 SizeRealLo:= Size mod dd_SizeMulti[l_SizePrefix];

 Result:= Format('Обработано %4d.%3d %sбайт за %4d.%2d %s',
                  [SizeRealHi, SIzeREalLo div c_100, dd_SizePrefix[l_SizePrefix],
                   TimeRealHi, TimeRealLo div c_100, TimeSt]);
end;

function ElapsedSec(aStartDateTime: TDateTime; aStopDateTime: TDateTime): Int64;
begin
 Result:= SecondsBetween(aStopDateTime, aStartDateTime);
end;


function CalcSpeedEx(Size: Longint; StartDateTime: TDateTime;
                     StopDateTime: TDateTime): ShortString;
var
  TotTime: Longint;
  SpeedHi, SpeedLo: Longint;
begin
 TotTime:= SecondsBetween(StopDateTime, StartDateTime);
 try
  if TotTime > 0 then
  begin
   SpeedHi:= (Size div TotTime) div dd_KiloByte;
   SpeedLo:= (Size div TotTime) mod dd_KiloByte;
   Result:= Format('%3d.%2d кб/сек', [SpeedHi, SpeedLo]);
  end
  else
   Result:= '??? кб/сек';
 except
  Result:= '??? кб/сек'
 end;
end;

function CalcSpeedExSec(Size, TimeSec: Int64): ShortString;
var
  SpeedHi, SpeedLo: Longint;
begin
 if TimeSec <> 0 then
 try
  SpeedHi:= (Size div TimeSec) div dd_KiloByte;
  SpeedLo:= (Size div TimeSec) mod dd_KiloByte div c_100;
  Result:= Format('%3d.%2d кб/сек', [SpeedHi, SpeedLo]);
 except
  Result:= '??? кб/сек'
 end
 else
  Result:= '??? кб/сек';
end;

function GetProgramVersion: ShortString;
begin
 Result := vtGetProgramVersion;
end;

function TimeSec2Str(TimeSec: Int64): ShortString;
var
  Day, Hour, Min, Sec: Longint;
begin
 if InRange(TimeSec, 0, dd_MaxTime) then
 try
  Day:= TimeSec div dd_TimeMulti[dd_ttDay];
  Hour:= TimeSec div dd_TimeMulti[dd_ttHour];
  Min:=  TimeSec div dd_TimeMulti[dd_ttMin];
  Sec:=  TimeSec;
  if Day > 1 then
  begin
   Hour:= (TimeSec mod dd_TimeMulti[dd_ttDay]) div dd_TimeMulti[dd_ttHour];
   Result:= Format('%2d дня %2d час', [Day, Hour])
  end
  else
  if Hour > 0 then
  begin
   Min:=  TimeSec mod dd_TimeMulti[dd_ttHour] div dd_TimeMulti[dd_ttMin];
   Result:= Format('%2d час %2d мин', [Hour, Min])
  end
  else
  if  Min > 0 then
  begin
   Sec:=  TimeSec mod dd_TimeMulti[dd_ttMin];
   Result:= Format('%2d мин %2d сек', [Min, Sec])
  end
  else
  if Sec > 0 then
    Result:= Format('%2d сек', [Sec])
  else
    Result:= 'меньше секунды';
 except
  Result:= '??? мин';
 end
 else
   Result:= 'неизвестно';
end;

{$IFDEF NewDT}
{$ENDIF}

function GetSizePrefix(const aSize: Int64): TddSizeType;
var
 l_Index: TddSizeType;
begin
 Result:= dd_stSimple;
 for l_Index:= Low(TddSizeType) to High(TddSizeType) do
  if aSize >= dd_SizeMulti[l_Index] then
  begin
   Result:= l_Index;
   break;                                                                
  end;
end;

function Bytes2Str(const Size: Int64; const aSizeType: TddSizeType = dd_stAuto):
    ShortString;
var
 SizeTot: TddSizeType;
 i, j: Integer;
begin
 { TODO -oДмитрий Дудко -cОшибка : Что-то здесь сломалось }
 if Size > 0 then
 begin
  if aSizeType = dd_stAuto then
   SizeTot:= GetSizePrefix(size)
  else
   SizeTot:= aSizeType;
  Result:= Format('%3.2f %sбайт', [Size/dd_SizeMulti[SizeTot], dd_SizePrefix[SizeTot]]);
  i:= Pred(Pos(' ', Result));
  j:= i;
  while Result[j] = '0' do
   Dec(j);
  if i <> j then
  begin
   if Result[j] in [',','.'] then
    Dec(j);
   Delete(Result, Succ(j), i-j);
  end;
 end
 else
  Result:= '';
end;

function FormatTime(Sec: Int64): ShortString;
var
  H, M, S: Longint;
begin
 try
  H:= Sec div 3600;
  M:= (Sec mod 3600) div 60;
  S:= (Sec mod 3600) mod 60;
  if H > 0 then
    Result:= Format('%d час %d мин %d сек', [H, M, S])
  else
  if M > 0 then
    Result:= Format('%d мин %d сек', [M, S])
  else
    Result:= Format('%d сек', [S]);
 except
  Result:= '';
 end;
end;

function CalcElapsedTime(aStartDateTime: TDateTime; aStopDateTime: TDateTime = 0): ShortString;
begin
  if aStopDateTime = 0 then
   aStopDateTime := Now;
  Result:= FormatTime(SecondsBetween(aStopDateTime, aStartDateTime));
end;

function CalcEstimatedTime(aTotal, aCurrent: Int64; aStartDateTime, aStopDateTime: TDateTime): ShortString;
var
  TotTime: int64;
  EstTime: int64;
begin
 if aCurrent <> 0 then
 try
  TotTime:= SecondsBetween(aStopDateTime, aStartDateTime);
  EstTime:= (aTotal*TotTime) div aCurrent;
  Result:= FormatTime(EstTime);
 except
  Result:= '???';
 end
 else
  Result:= '???';
end;

function CalcLeftTime(aTotal, aCurrent: int64; aStartDateTime, aStopDateTime: TDateTime): ShortString;
var
  TotTime: int64;
  EstTime: int64;
begin
 if aCurrent <> 0 then
 try
  TotTime:= SecondsBetween(aStopDateTime, aStartDateTime);
  EstTime:= (aTotal*TotTime) div aCurrent;
  if TotTime > EstTime then
    Result:= 'неизвестно'
  else
    Result:= FormatTime(EstTime-TotTime);
 except
   Result:= '';
 end
 else
  Result:= '';
end;

procedure RestartApplication(const aParams: AnsiString = '');
var
 AppName: PAnsiChar;
begin
 AppName:= PAnsiChar(Application.ExeName);
 ShellExecuteA(Application.Handle, 'open', AppName, PAnsiChar(aParams), nil, sw_shownormal);
 Application.Terminate;
end;

procedure SaveSettings(theControl: TWinControl);
var
 i, j: Integer;
 l_Ini: TCfgList;
 l_C: TControl;
 l_Value: Longint;
begin
 with TCfgList.Create do
 try
  Section := 'Settings';
  for i:= 0 to Pred(theControl.ControlCount) do
  begin
   l_C := theControl.Controls[i];
   if l_C is TCustomEdit then
    writeParamStr(l_C.Name, TCustomEdit(l_C).Text)
   else
   if l_C is TCustomListControl then
   begin
    writeParamInt(l_C.Name, TCustomListControl(l_C).ItemIndex);
    if l_C is TCheckListBox then
    begin
     l_Value:= 0;
     for j:= 0 to Pred(TCheckListBox(l_C).Items.Count) do
      if TCheckListBox(l_C).Checked[j] then
       l3setBit(l_Value, j);
     WriteParamInt(l_C.Name+'.Checked', l_Value);
    end
   end
   else
   if l_C is TCheckBox then
    WriteParamBool(l_C.Name, TCheckBox(l_C).Checked)
   else
   if l_C is TRadioButton then
    WriteParamBool(l_C.Name, TRadioButton(l_C).Checked)
   else
   if l_C is TRadioGroup then
    WriteParamInt(l_C.Name, TRadioGroup(l_C).ItemIndex)
   else
   if (l_C is TGroupBox) or (l_C is TPanel) or (l_C is TPageControl) or (l_C is TTabSheet) then
    SaveSettings(l_C as TWinControl);
  end;
 finally
  Free;
 end;
end;

procedure LoadSettings(theControl: TWinControl);
var
 i, j: Integer;
 l_Ini: TCfgList;
 l_C: TControl;
 l_Value: Longint;
begin
 with TCfgList.Create do
 try
  Section := 'Settings';
  for i:= 0 to Pred(theControl.ControlCount) do
  begin
   l_C := theControl.Controls[i];
   if l_C is TCustomEdit then
    TCustomEdit(l_C).Text:= ReadParamStrDef(l_C.Name, TCustomEdit(l_C).Text)
   else
   if l_C is TCustomListControl then
   begin
    TCustomListControl(l_C).ItemIndex:= ReadParamIntDef(l_C.Name, TCustomListControl(l_C).ItemIndex);
    if l_C is TCheckListBox then
    begin
     l_Value:= ReadParamIntDef(l_C.Name+'.Checked', 0);
     for j:= 0 to Pred(TCheckListBox(l_C).Items.Count) do
      TCheckListBox(l_C).Checked[j]:= l3TestBit(l_Value, j);
    end;
   end
   else
   if l_C is TCheckBox then
    TCheckBox(l_C).Checked:= ReadParamBoolDef(l_C.Name, TCheckBox(l_C).Checked)
   else
   if l_C is TRadioButton then
    TRadioButton(l_C).Checked:= ReadParamBoolDef(l_C.Name, TRadioButton(l_C).Checked)
   else
   if l_C is TRadioGroup then
    TRadioGroup(l_C).ItemIndex:= ReadParamIntDef(l_C.Name, TRadioGroup(l_C).ItemIndex)
   else
   if (l_C is TGroupBox) or (l_C is TPanel) or (l_C is TPageControl) or (l_C is TTabSheet) then
    LoadSettings(l_C as TWinControl)
  end;
 finally
  Free;
 end;
end;

function GetWindowsTempFolder: AnsiString;
var
 lng: DWORD;
 thePath: AnsiString;
begin
 SetLength(thePath, MAX_PATH) ;
 lng := GetTempPathA(MAX_PATH, PAnsiChar(thePath)) ;
 SetLength(thePath, lng) ;
 Result:= thePath;
end;

procedure EnabledAsParent(container: TWinControl) ;
var
  index : integer;
  aControl : TControl;
  isContainer : boolean;
begin
  for index := 0 to -1 + container.ControlCount do
  begin
    aControl := container.Controls[index];

    aControl.Enabled := container.Enabled;

    isContainer := (csAcceptsControls in container.Controls[index].ControlStyle) ;

    if (isContainer) AND (aControl is TWinControl) then
    begin
      //recursive for child controls
      EnabledAsParent(TWinControl(container.Controls[index])) ;
    end;
  end;
end;

const
  SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority = (Value: (0, 0, 0, 0, 0, 5)) ;

const
  SECURITY_BUILTIN_DOMAIN_RID = $00000020;
  DOMAIN_ALIAS_RID_ADMINS = $00000220;


function IsWindowsAdmin: Boolean;
var
  hAccessToken: THandle;
  ptgGroups: PTokenGroups;
  dwInfoBufferSize: DWORD;
  psidAdministrators: PSID;
  g: Integer;
  bSuccess: BOOL;
begin
  Result := False;

  bSuccess := OpenThreadToken(GetCurrentThread, TOKEN_QUERY, True, hAccessToken) ;
  if not bSuccess then
  begin
    if GetLastError = ERROR_NO_TOKEN then
    bSuccess := OpenProcessToken(GetCurrentProcess, TOKEN_QUERY, hAccessToken) ;
  end;


  if bSuccess then
  begin
    GetMem(ptgGroups, 1024) ;

    bSuccess := GetTokenInformation(hAccessToken, TokenGroups, ptgGroups, 1024, dwInfoBufferSize) ;

    CloseHandle(hAccessToken) ;

    if bSuccess then
    begin
      AllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 2, SECURITY_BUILTIN_DOMAIN_RID,
                               DOMAIN_ALIAS_RID_ADMINS, 0, 0, 0, 0, 0, 0, psidAdministrators) ;

      for g := 0 to ptgGroups.GroupCount - 1 do
        if EqualSid(psidAdministrators, ptgGroups.Groups[g].Sid) then
        begin
          Result := True;
          Break;
        end;

      FreeSid(psidAdministrators) ;
    end;

    FreeMem(ptgGroups) ;
  end;
end;

function ValidFolder(aFolder: AnsiString; ForWrite: Boolean = True): Boolean;
var
 l_FileName: AnsiString;
 l_Handle: Integer;
begin
 Result:= False;
 if aFolder <> '' then
 begin
  if ForWrite and not DirectoryExists(aFolder) then
   Result:= ForceDirectories(aFolder)
  else
   Result := True;
  if Result and ForWrite then
  begin // Пытаемся создать файл
   l_FileName := GetUniqFileName(aFolder, 'test', 'test');
   l_Handle:= FileCreate(l_FileName);
   Result := l_Handle <> -1;
   if Result then
   begin
    FileClose(l_Handle);
    SysUtils.DeleteFile(l_FileName);
   end;
  end; // DirectoryExists(aFolder)
 end;// aFolder <> ''
end;

function SafeValidFolder(aFolderName: AnsiString; ForWrite: Boolean = True): AnsiString;
begin
 if ValidFolder(aFolderName, ForWrite) then
  Result:= aFolderName
 else
  Result := ExtractFileDir(Application.ExeName);
end;

function ExtractPattern(aText: AnsiString): AnsiString;
var
 l_Start, l_Finish: Integer;
begin
 Result:= '';
 // находит подстроку, заключенную в пару %
 l_Start:= Pos('%', aText);
 l_Finish:= PosEx('%', aText, Succ(l_Start));
 if l_Finish > 0 then
  Result := UpperCase(Copy(aText, l_Start, l_Finish-l_Start+1))
end;

function GetNearestDay(aToday: TDateTime; aDayOfWeek: Word; const aNext: Boolean = True): TDateTime;
var
 l_CurDay: Word;
 l_Delta: Integer;
begin
 l_Delta:= 0;
 if aDayOfWeek in [DayMonday..DaySunday] then
 begin
  l_CurDay:= DayOfTheWeek(aToday);
  case CompareValue(l_CurDay, aDayOfWeek) of
   LessThanValue   : l_Delta:= aDayOfWeek - l_CurDay;
   EqualsValue     : l_Delta:= 0;
   GreaterThanValue: l_Delta:= 7 - (l_CurDay - aDayOfWeek);
  end;
  if not aNext then
   Dec(l_Delta, 7);
 end;
 Result:= IncDay(aToday, l_Delta);
end;

function CopyFolder(Source, Destination: AnsiString; FullStructure: Boolean =
    True): Boolean;
var
 l_FileOp: TStFileOperation;
 l_SR: TSearchRec;
begin
 ForceDirectories(Destination); // создаем конечную папку

 l_FileOp  := TStFileOperation.Create(Application);
 try
  l_FileOp.ConfirmFiles:= False;
  l_FileOp.Options:= l_FileOp.Options+
                     [foNoConfirmMkDir, foNoConfirmation, foNoErrorUI]-
                     [foRenameCollision, foAllowUndo, foFilesOnly];
  l_FileOp.Destination:= Destination;
  if FullStructure then
  begin
   if FindFirst(ConcatDirName(Source, '*.*'), faAnyFile, l_SR) = 0 then
   begin
    repeat
     if (l_SR.Name[1] <> '.') then
      l_FileOp.SourceFiles.Add(ConcatDirName(Source, l_SR.Name));
    until FindNext(l_SR) <> 0;
    SysUtils.FindClose(l_SR);
   end // FindFirst(Folder, faAnyFile, l_SR) = 0
  end
  else
   l_FileOp.SourceFiles.Add(Source);

  Result:= l_FileOp.Execute;
 finally
  l_FileOp.Free;
 end; // try finally
end;

function CopyFiles(const aSourceFolder, aDestFolder: AnsiString; Operation: TStFileOp = fopCopy):
    Boolean;
var
 l_FileOp: TStFileOperation;
 l_SR: TSearchRec;
begin
 ForceDirectories(aDestFolder); // создаем конечную папку

 l_FileOp  := TStFileOperation.Create(Application);
 try
  l_FileOp.Operation:= Operation;
  l_FileOp.ConfirmFiles:= False;
  //l_FileOp.Options:= l_FileOp.Options+
  //                   [foNoConfirmMkDir, foNoConfirmation, foNoErrorUI]-
  //                   [foRenameCollision, foAllowUndo, foFilesOnly];
  l_FileOp.Destination:= aDestFolder;
  if FindFirst(ConcatDirName(aSourceFolder, '*.*'), faAnyFile, l_SR) = 0 then
  begin
   repeat
    if (l_SR.Name[1] <> '.') then
     l_FileOp.SourceFiles.Add(ConcatDirName(aSourceFolder, l_SR.Name));
   until FindNext(l_SR) <> 0;
   SysUtils.FindClose(l_SR);
  end; // FindFirst(Folder, faAnyFile, l_SR) = 0

  //l_FileOp.SourceFiles.Add(aSourceFolder);

  Result:= l_FileOp.Execute;
 finally
  l_FileOp.Free;
 end; // try finally
end;

procedure MoveFiles(const aSourceFolder, aDestinationFolder: AnsiString);
begin
 CopyFiles(aSourceFolder, aDestinationFolder, fopMove);
end;

procedure UpperCaseFirstLetter(var aText: AnsiString);
var
 i: Integer;
begin
 aText:= Trim(aText);
 if aText <> '' then
 begin
  i:= 1;
  while not (aText[i] in cc_AlphaNum) and (i < Length(aText)) do inc(i);
  if i < Length(aText) then
   l3MakeUpperCase(PAnsiChar(aText)+Pred(i), 1);
 end; // aText <> ''
end;

function MakeUniqueFolderName(const aFolder: AnsiString; const aLast: Boolean =
    False): AnsiString;
var
  l_Suffix: Integer;
begin
  l_Suffix:= 0;
  Result:= aFolder;
  while FileExists(Result) do
  begin
    Result:= SysUtils.Format('%s.%d', [aFolder, l_Suffix]);
    Inc(l_Suffix);
  end;
  if (l_Suffix > 0) then
   Dec(l_Suffix);
  if aLast then
   Result:= SysUtils.Format('%s.%d', [aFolder, Pred(l_Suffix)]);
end;

function DateToString(aDate: TDateTime): AnsiString;
var
 Y, M, D: Word;
begin
 DecodeDate(aDate, Y, M, D);
 Result := Format('%.4d%.2d%.2d', [Y, M, D]);
end;

function EnableOpenFile(const aFileName: AnsiString): Boolean;
var
 l_Handle: Integer;
begin
 Result := False;
 l_Handle:= FileOpen(aFileName, fmOpenRead);
 if l_Handle >= 0 then
 begin
  Result:= True;
  FileClose(l_Handle);
 end; // l_Handle >= 0
end;

function Running32ON64: boolean;
type
  TIsWow64Process = function(Handle:THandle; var IsWow64 : boolean) : boolean; stdcall;
var
  hDLL : cardinal;
  IsWow64Process : TIsWow64Process;
begin
  result := false;
  hDLL := LoadLibrary('kernel32.dll');
  if (hDLL = 0) then Exit;
  try
    @IsWow64Process := GetProcAddress(hDLL, 'IsWow64Process');
    if Assigned(IsWow64Process) then IsWow64Process(GetCurrentProcess, result);
  finally
    FreeLibrary(hDLL);
  end;
end;

function GetAppFolderFileName(const aFileName: AnsiString; aUnique: Boolean = False): AnsiString;
var
 l_Folder: AnsiString;
begin
 l_Folder:= ExtractFileDir(Application.ExeName);
 Result:= ConcatDirName(l_Folder, aFileName);
 if aUnique then
  Result:= MakeUniqueFileName(Result);
end;

function ResetSelfLog(aSizeLimit: Integer): AnsiString;
{$IFDEF _m0LOGSAV1}
var
 l_LogFileName, l_OldLogFileName, l_Folder: ShortString;
{$ENDIF}
begin
 {$IFDEF _m0LOGSAV1}
 {$If Decalred(Gm0EXCLibDefSrv)}
 l_LogFileName:= Gm0EXCLibDefSrv.LogFileName;
 FreeAndNil(Gm0EXCLibDefSrv);
 try
 if FileExists(l_LogFileName) and (SizeOfFile(l_LogFileName) > aSizeLimit) then
  begin
   l_Folder:= GetAppFolderFileName('Log Files');
   if ForceDirectories(l_Folder) then
   begin
    l_OldLogFileName:= ConcatDirName(l_Folder, ExtractFileName(l_LogFileName)+'.'+SysUtils.FormatDateTime('YYYY-MM-DD', Now));
    try
     Result:= MakeUniqueFileName(l_OldLogFileName);
     RenameFile(l_LogFileName, Result);
    except
     // Лога-то нет...
     // l3System.Msg2Log('Не удалось скопировать лог-файл');
    end;
   end; // ForceDirectories(l_Folder)
  end;
 finally
  Gm0EXCLibDefSrv:= Tl3ExceptionsLog.Create(l_LogFileName);
 end;
 {$IfEnd}
 {$ENDIF}
end;

function NumSuffix(const aNum: Integer; const aOneForm, aTwoForm, aPluralForm: AnsiString): AnsiString;
var
 l_Mod: Byte;
begin
 l_Mod := Abs(aNum mod 100);
 if l_Mod in [10..20] then
  Result := Format('%d %s', [aNum, aPluralForm])
 else
 begin
  l_Mod := Abs(aNum mod 10);
  case l_Mod of
   1     : Result := Format('%d %s', [aNum, aOneForm]);
   2,3,4 : Result := Format('%d %s', [aNum, aTwoForm]);
  else
   Result := Format('%d %s', [aNum, aPluralForm]);
  end;
 end;
end;

function IsNetworkPath(const aPath: AnsiString): Boolean;
var
 l_Expanded: AnsiString;
 l_Device  : array [1..3] of AnsiChar;
 l_Buffer  : array [0..MAX_PATH-1] of AnsiChar;
 l_Temp: AnsiString;
begin
 Result := False;
 if aPath <> '' then
 begin
  l_Expanded := ExpandFileName(aPath);
  if l_Expanded[1] in ['a'..'z', 'A'..'Z'] then
  begin
   // пытаемся развернуть subst (он тоже может указывать на сетевой путь)
   l_Device[1] := l_Expanded[1];
   l_Device[2] := ':';
   l_Device[3] := #0;
   SetString(l_Temp, l_Buffer, QueryDosDeviceA(@l_Device, @l_Buffer, SizeOf(l_Buffer))-2);
   if l_Temp <> '' then
   begin
    if (Copy(l_Temp, 1, 4) = '\??\') and (l_Temp[6] = ':') then
     l_Expanded := Copy(l_Temp, 5, MaxInt) + Copy(l_Expanded, 3, MaxInt);
   end;
  end;
  l_Expanded := ExpandUNCFileName(l_Expanded);
  Result := Copy(l_Expanded, 1, 2) = '\\';
 end;
end;

procedure AssertRunningFromLocal(aQuietly: Boolean = False);
begin
 if IsNetworkPath(ParamStr(0)) then
 begin
  if not aQuietly then
  begin
   //l3System.Msg2Log('ОШИБКА: Попытка запуска с сетевого ресурса! Выполнение прекращено.');
   if IsConsole then
    Writeln('This program can''t be run from network.')
   else
    MessageBox(0, 'Эту программу нельзя запускать с сетевого ресурса!', 'ОШИБКА', MB_ICONERROR);
  end;
  Halt(1);
 end;
end;

function ddStyleUndefined(aStyle: Integer): Boolean;
begin
 Result := (aStyle = 0) or (aStyle = propUndefined);
end;

function ddUnicode2Char(aUnicodeID: Integer): AnsiChar;
const
 // {$Requestlink:621056217}
 cnStartSkipChars1 = 11383;
 cnFinishSkipChars1 = 42775;
 // {$Requestlink:610504218}
 cnStartSkipChars = 57344;
 cnFinishSkipChars = 63743;
begin
 Result := #0;
 // напильник
 if ((aUnicodeID >= cnStartSkipChars1) and (aUnicodeID <= cnFinishSkipChars1)) or
    ((aUnicodeID >= cnStartSkipChars) and (aUnicodeID <= cnFinishSkipChars)) then
 begin
  case aUnicodeID of
   61485,
   61623,
   61656,
   61607,
   61692: Result := cc_Minus;
  else
   Result := cc_HardSpace;
  end;
 end // if (aUnicodeID >= cnStartIgnoreCode) and (aUnicodeID <= cnFinishIgnoreCode) then
 else
  case aUnicodeID of
   172: Result := cc_Minus; // http://mdp.garant.ru/pages/viewpage.action?pageId=624074743
   8194: Result := cc_SoftSpace;
   8722: Result := cc_LargeDash;
   8729: Result := cc_Minus;
   8242: Result := cc_SingleQuote;
   8243: Result := cc_DoubleQuote;
   9632: Result := cc_Minus;
  end;
end;

end.

unit DT_DbReformer;

{ $Id: DT_DbReformer.pas,v 1.17 2015/11/25 07:22:13 lukyanets Exp $ }
// $Log: DT_DbReformer.pas,v $
// Revision 1.17  2015/11/25 07:22:13  lukyanets
// Заготовки для выдачи номеров
//
// Revision 1.16  2015/07/09 14:17:41  voba
// -bf расчет приорити
//
// Revision 1.15  2015/07/02 07:36:07  lukyanets
// Описываем словари
//
// Revision 1.14  2015/04/07 07:37:09  lukyanets
// Изолируем HT
//
// Revision 1.13  2015/03/10 07:24:43  fireton
// - не учитывался ProjectDefine.inc
//
// Revision 1.12  2014/12/25 15:40:52  voba
// - функции восстановления Priority и SortDate
//
// Revision 1.11  2014/11/21 14:57:15  voba
// no message
//
// Revision 1.10  2014/07/21 07:25:11  fireton
// - корректируем таблицу FREE для USERS правильно
// - не забываем сохранять диапазоны для ААС и ФАС
//
// Revision 1.9  2014/04/17 13:04:31  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.8  2013/12/24 07:04:30  fireton
// - некошерный предок
//
// Revision 1.7  2013/10/01 09:26:25  fireton
// - немного исправлена процедура SetFieldValue
//
// Revision 1.6  2013/04/09 12:37:31  narry
// Не компилировалось
//
// Revision 1.5  2013/03/07 07:36:14  voba
// - функция для апкейса номеров документов
//
// Revision 1.4  2012/11/30 15:01:33  voba
// - добавил функции по лечению ошибки -92 (недопустимый символ в строке)
//
// Revision 1.3  2012/04/20 15:20:01  lulin
// {RequestLink:283610570}
//
// Revision 1.2  2011/12/14 09:42:16  narry
// Добавление поля в таблицу Sub001 (303171256)
//
// Revision 1.1  2011/12/12 13:58:35  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.55  2011/12/01 14:58:52  fireton
// - доработка реформера
//
// Revision 1.54  2011/06/09 13:42:00  fireton
// - не собиралось (DbUtil)
//
// Revision 1.53  2010/08/19 12:20:17  narry
// - Неправильно создавалась пустая база
//
// Revision 1.52  2009/06/02 09:37:23  narry
// - корректная работа с диапазонами номеров
//
// Revision 1.51  2009/05/04 13:53:29  voba
// - не работало
//
// Revision 1.50  2009/04/21 14:19:49  fireton
// - пересборка
//
// Revision 1.49  2009/04/09 08:36:36  fireton
// - расширение функционала
//
// Revision 1.48  2009/03/05 09:05:45  narry
// - рефакторинг
// - не собиралось
//
// Revision 1.47  2009/02/09 10:54:17  fireton
// - версия базы 131
//
// Revision 1.46  2008/09/16 10:07:26  narry
// - корректное исправление таблицы main\free
//
// Revision 1.45  2008/09/16 08:37:07  fireton
// - RestructTable, удален ненужный код
//
// Revision 1.44  2008/03/25 14:19:56  narry
// - добавлена процедура замены ссылок на элемент словаря
//
// Revision 1.43  2008/02/15 08:49:35  fireton
// - 130 версия базы (атрибут "срочность" у документа)
//
// Revision 1.42  2007/10/19 13:53:15  narry
// - исправление ошибок обновления с базы 113 на 129
//
// Revision 1.41  2007/08/21 14:05:28  fireton
// - upd 128
//
// Revision 1.40  2007/08/14 14:31:48  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.39  2007/05/11 10:39:27  narry
// - обновление
//
// Revision 1.38  2007/05/11 08:24:59  narry
// - исправление ряда ошибок
//
// Revision 1.37  2007/05/04 11:58:42  fireton
// - bugfix: последствия рефакторинга DT
//
// Revision 1.36  2007/04/18 11:39:42  narry
// - процедура создания произвольной пустой базы
//
// Revision 1.35  2007/03/12 11:18:06  fireton
// - bug fix: правильные call-back функции
//
// Revision 1.34  2007/02/22 15:00:58  fireton
// - переход на 64 бита в HyTech
//
// Revision 1.33  2006/06/08 15:55:56  fireton
// - подготовка к переходу на большой User ID
//
// Revision 1.32.4.1  2006/06/08 09:26:57  fireton
// - перевод User ID на Longword
//
// Revision 1.32  2005/12/09 14:05:44  step
// new: property DbInfo
//
// Revision 1.31  2005/10/17 09:20:12  step
// изменено имя файла-лога
//
// Revision 1.30  2005/09/26 14:23:20  step
// new: TDbReformer.VerifyReferences
//
// Revision 1.29  2005/02/09 17:36:38  step
// Убран показ сообщений об удалении файлов HLK
//
// Revision 1.28  2005/02/07 17:15:05  step
// new: TDbReformer.DeleteRecords, TDbReformer.UpdateRecords
//
// Revision 1.27  2005/01/19 11:27:28  step
// учтено наличие пароля при работе с таблицами
//
// Revision 1.26  2004/12/23 11:47:19  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.25  2004/12/03 18:15:03  step
// добавлен параметр в функции TStructChangeProc и TDbReformer.CopyTableStruct
//
// Revision 1.24  2004/12/02 15:55:23  step
// Приведение полей ID и DICT_ID в таблицах DT#* и LNK#* к типу DWRD (ver. 111)
//
// Revision 1.23  2004/10/25 16:11:14  step
// новая TDbReformer.Yield
//
// Revision 1.22  2004/10/07 12:16:28  step
// реализована переиндексация
//
// Revision 1.21  2004/08/03 17:06:22  step
// добавлены методы по ремонту БД
//
// Revision 1.20  2004/07/21 16:52:29  step
// добавлены методы для поиска "захватчиков"
//
// Revision 1.19  2004/07/21 13:00:56  step
// имя лога строится по имени приложения
//
// Revision 1.18  2004/07/21 12:50:33  step
// открытие-закрытие лога вынесены из конструтора-деструктора в public
//
// Revision 1.17  2004/06/21 15:37:34  step
// new: TDbReformer.DeleteHlkFiles
// вызовы RestoreHlkFile заменены на DeleteHlkFiles
//
// Revision 1.16  2004/05/26 09:59:06  step
// исправлено получение пути к папке с временными файлами
//
// Revision 1.15  2004/05/25 15:44:46  step
// изменен порядок нумерации версий
//
// Revision 1.14  2004/05/07 17:43:34  step
// куча мелких исправлений
//
// Revision 1.13  2004/05/07 17:37:47  step
// куча мелких исправлений
//
// Revision 1.12  2004/05/06 14:17:01  step
// добавление интервала в табл. FREE
//
// Revision 1.11  2004/05/05 16:07:03  step
// переделка TDbInfo
//
// Revision 1.10  2004/04/20 17:06:17  step
// добавлено восстанавление *.HLK файла
//
// Revision 1.9  2004/04/20 09:46:07  step
// изменение табл. FREE (ver. 106)
//
// Revision 1.8  2004/04/01 14:50:08  step
// чистка кода
//
// Revision 1.7  2004/04/01 08:19:40  step
// new: procedure ApplyJournalActions - добавление журнала
// new: function DeleteLinkDictDuplicates - удаление дубликатов типа LNK_DICT
// new: function DeleteBadLinkToDict - удаление "висячих" линков
//
// Revision 1.6  2004/03/10 14:32:49  step
// добавление TDbReformer.RecalcStrField
// изменен алгоритм "Сохранения-Восстановления"
//
// Revision 1.5  2004/03/09 18:40:03  step
// добавлен update № 104 (изменение полей табл. FILE)
//
// Revision 1.4  2004/03/05 09:08:50  step
// мелкие исправления
//
// Revision 1.3  2004/03/04 18:03:10  step
// исправлен алгоритм сохранения-восстановления
//
// Revision 1.2  2004/03/02 15:47:00  step
// куча мелких изменений
//
// Revision 1.1  2004/03/01 19:04:53  step
// Занесен в CVS
//

interface

{$I DtDefine.inc}

uses
 Classes, Contnrs,
 l3ProtoObject,
 l3Types,
 l3IniFile,
 Ht_Const,

 DT_DbInfo,
 dt_ATbl,
 Dt_Types,
 dt_Table,
 dt_Const,
 dt_AttrSchema,

 dt_FreeTable,

 l3RecList, l3FieldSortRecList,
 l3Stream;

const
 MAX_DWRD = $FFFFFFFF;

type
  TShowToUserProc = procedure(const aStr: string) of object;

  TElemArray = array of HT_Const.ThtElementInfo{ELEMENT};
  TFieldNums = array of Smallint;
  PFieldNums = ^TFieldNums;

  THandleArray = array[0..MAX_TAB_LINK - 1] of HT_Const.THANDLE;
  PHandleArray = ^THandleArray;

  TTableRecs = array of array of string;

  TTableStruct = class(Tl3ProtoObject)
   f_TableInfo: HT_Const.Table;
   f_TableElementList: TElemArray;
  private
    function GetFieldInfo(aFieldNum: Integer): HT_Const.ThtElementInfo{ELEMENT};
  protected
   procedure Cleanup; override;
  public
   constructor Create(aTableName: string);
   property TableInfo: HT_Const.Table read f_TableInfo;
   property TableElementList: TElemArray read f_TableElementList;
   property FieldInfos[aFieldNum: Integer]: HT_Const.ThtElementInfo{ELEMENT} read GetFieldInfo; // индексация от 1
  end;

  TStructChangeProc = procedure(var aStruct: TElemArray; aData: Pointer);

  TFamilyFolder = (ffMain, ffGarant);
  TRepairKind = (rkIgnore, rkDeleteLink, rkClearRef);

  TDbReformer = class(Tl3ProtoObject)
  private
   f_DbInfo: TDbInfo;
   f_DbRootFolder: string;
   f_FamilyFolder: string;
   f_MainFolder: string;
   f_DirBackup: string;
   f_DirLocks: string;
   f_DirTemp: string;
   f_FileStream: Tl3FileStream;
   f_ShowToUserProc : TShowToUserProc;
   f_ProgressProc   : Tl3ProgressProc;
   procedure AddAccessGroups;
   procedure AddUsers;
   procedure CorrectAdminFreeTable;
   procedure CorrectFamilyFreeTable;
   function GetCurFamilyVersion: Integer;
   procedure SetCurFamilyVersion(const Value: Integer);
   function FieldNo(aLinkedTables: PHandleArray;
                    aTablesAmount: Integer;
                    aParentTable: HT_Const.THANDLE;
                    aFieldNoInParentTable: Integer): Integer;
   function GetMainFolderVersion: Integer;
   procedure SetMainFolderVersion(const Value: Integer);

   function FullTableName(aTableFolder: TFamilyFolder; const aShortName: string): string; overload;
   function FullTableName(aFamily: TFamilyID; aTblID: Integer): string;                   overload;

   procedure CorrectMaxID(theFolder, theTableName: String; theIDField: Integer; theFree: TdbFreeTable; theMaxValue:
       Longword = MAX_DWRD; const theFreeName: String = '');
   function GetRealUserID(aUserID, aMaxID: longword): Integer;
  protected
   procedure LoadDiapasons(aFreeTable: TdbFreeTable; aList: Tl3RecList);
   procedure SaveDiapasons(aFreeTable: TdbFreeTable; aList: Tl3RecList);
   function  CreateOpenFamilyTable(aTbl : TFamTbls) : TdtTable;
  public
   constructor Create(aDbInfo: TDbInfo;
                      aShowToUserProc: TShowToUserProc = nil;
                      aProgressProc : Tl3ProgressProc = nil);
   procedure InitHt;
   procedure CloseHt;

   procedure InitLog;
   procedure CloseLog;
   procedure AddDefaultValues(aDicts: TDLTypeSet; aWithUsers: Boolean);

   // вспомогательные
   function FamilyTable(aTableName: string): string; // превращает короткое имя файла в полное (папка garant)
   function MainTable(aTableName: string): string; // превращает короткое имя файла в полное (папка MAIN)

   // для сохранения-восстановления-очистки бэкапных данных
   procedure SaveTable(const aFullTableName: string);
   procedure RestoreTable(const aFullTableName: string); // параметр - полное имя таблицы (ie полный путь)

   procedure Yield(Sender: TObject);
   procedure Log(const aStr: string; aShowTime: Boolean = False); virtual;
   procedure DoProgressProc(aState : Byte; aValue: Longint; const aMsg : String = '');
   procedure Info(const aStr: string); // Показывается диалог (!) + запись в лог-файл
   procedure Error(const aStr: string); // Показывается диалог (X) + запись в лог-файл

   // операции изменения БД
   procedure DeleteHlkFiles; // грубое удаление файлов *.HLK и грубая очистка папки SHARE
   procedure ClearBadLocks(aTable: string);
   procedure ClearAllBadLocks(aFolder: string);
   procedure ReindexTable(const aTable: string);
   procedure ReindexAllTables(const aFolder: string);
   procedure RepairTable(const aTable: string);
   procedure RepairAllTables(const aFolder: string);
    // снимает блокировки с тех таблиц, которые в настоящее время никем не используются.
    // Т.о. запускать эту процедуру можно на ИСПОЛЬЗУЕМОЙ в этот момент времени БД
   procedure DropTable(const aFullTableName: string);
   procedure CreateTable(aStruct: TElemArray;
                         aTableName: string;
                   const aFamily: TFamilyFolder;
                         aPassword: PChar = nil);
   procedure CopyTableStruct(aSrcTable,
                             aDstTable: string;
                             aStructChangeProc: TStructChangeProc = nil;
                             aData: Pointer = nil);
   procedure CopyData(aFromTable,
                      aToTable: string);
   procedure CopyUniqData(aSrcTable,
                          aDstTable: string;
                          aUniqFieldNums: TFieldNums);
   procedure RenumField(aTable: string;
                        aFieldNum: SmallInt);
   procedure DropIndices(const aTableName: string; aFieldNum: Word);
   procedure BuildIndices(const aTableName: string;
                          const aTableStruct: TTableStruct);
   procedure RecalcReferences(aTable: string;
                              aFieldNum: Smallint;
                              aEmptyValue: PChar;
                              aOldRefTable, aNewRefTable: string;
                              aRefFieldNum: Smallint;
                              aRefValueKeyNum: Smallint);
   procedure RecalcStrField(aTable: string;
                            aFieldNum: SmallInt;
                            aRecalcProc: LPMFUNC;
                            aFieldValueMask: PChar = nil); // шаблон, с учетом регистра

   procedure SetFieldValue(aTable: string;
                           aFieldNum: SmallInt;
                           var aValue); overload;

   procedure SetFieldValue(aTableName: string;
                           aFamilyFolder: TFamilyFolder;
                           aFieldNum: SmallInt;
                           var aValue); overload;

   procedure DeleteRecords(aTable: string;
                           aFieldNum: SmallInt;
                           const aValue);
   procedure UpdateRecords(aTable: string;
                           aFieldNum: SmallInt;
                           const aOldValue, aNewValue);
   procedure InsertRecords(aTable: string;
                           const aRecords: TTableRecs);
   procedure ApplyJournalActions(aSrcTable, aDstTable: string); // "добавление журнала"
   procedure JournalUnpack(const aTblName: string);
   procedure CorrectForbiddenValue(const aTblName: string);
   procedure UpcaseFieldValue(const aTblName: string; aFldNum : ThtField);
   procedure CorrectFreeTables;
   function DeleteLinkDictDuplicates(aLinkTable, aDictTable: string): Integer;
    // удаление дубликатов типа LNK_DICT (значение Dict.Id не учитывается)
    // возвращает кол-во удаленных линков (= кол-ву удаленных словарных статей)

   procedure DeleteBadLinkRec(aFamily: TFamilyID);

    // снимает блокировки с тех таблиц, которые в настоящее время никем не используются.
    // Т.о. запускать эту процедуру можно на ИСПОЛЬЗУЕМОЙ в этот момент времени БД
   procedure DropTableDirect(const aFullTableName: string);
    // удаление "висячих" линков (линков с такими Dict_ID, которых нет в соотв. словаре)
    // возвращает кол-во удаленных линков

   // информация о БД
   function TableLocked(const aTable: string; out aHolder: string): Boolean;
   function RecordsLocked(const aTable: string; out aHolder: string): Boolean;
   function IsTableCorrect(const aTable: string): Boolean;
    //
   class function TablePass(const aTable: string): PChar;

   procedure LockedTables(aFolder: string;
                          aResult: TStringList);
    // возвращает список строк, содержщий пары ТАБЛИЦА - ЗАХВАТИВШАЯ СТАНЦИЯ
   procedure LockedRecords(aFolder: string;
                           aResult: TStringList);
    // возвращает список строк, содержщий пары ТАБЛИЦА - ЗАХВАТИВШАЯ СТАНЦИЯ (не все, а только первая попавшаяся станция)

   function RenameTableDirect(aFullTableName, aNewName: string): Boolean;
   procedure ReplaceLinks(aTable: TFamTbls; aOldValue, aNewValue: Integer);
   procedure RestructTable(const aTableName: string; const aFamily: TFamilyFolder; aRestructProc: TStructChangeProc; aData: Pointer = nil);

   procedure RecoverSortDate;
   procedure RecoverPriority;

   class function TablePassS(const aTable: string): string;

   procedure VerifyReferences(aFolderFrom: TFamilyFolder; const aTableFrom: string; aFieldNumFrom: SmallInt;
                              aFolderTo: TFamilyFolder; const aTableTo: string; aFieldNumTo: SmallInt;
                              aRepairKind: TRepairKind = rkIgnore);
   //procedure RepairHLink;
   property CurFamilyVersion: Integer read GetCurFamilyVersion write SetCurFamilyVersion;
   property MainFolderVersion: Integer read GetMainFolderVersion write SetMainFolderVersion;
   property DirBackup: string read f_DirBackup;
   property DbInfo: TDbInfo read f_DbInfo;
   property MainFolder: string read f_MainFolder;
   property FamilyFolder: string read f_FamilyFolder;
  end;

  PFieldData = ^TFieldData;
  TFieldData = packed record
                Offset: Word;
                Length: Word;
                pData: Pointer;
               end;

function MakeReformer(aDbInfo: TDbInfo; aShowToUserProc: TShowToUserProc = nil; aProgressProc : Tl3ProgressProc = nil) : TDbReformer;

implementation

uses
 Ht_Dll,
 Windows,
 SysUtils, StrUtils,
 Dialogs,
 IniFiles,
 l3Base,
 l3Date,
 l3DateSt,
 l3Interfaces,
 l3FileUtils,
 l3LongintList,
 Math,
 Forms,
 l3Const,
 l3String,
 daInterfaces,
 daTypes,
 daSchemeConsts,
 DT_Misc,
 dt_FRee,
 dtIntf, dt_Sab,
 dt_User,
 dt_Link,
 dt_DictConst,
 dt_Doc,
 dt_err,
 dt_Prior,
 l3ProtoPtrRecListPrim, l3Filer;

const
 STATION_NAME = 'UPDATING';
 c_TablePass = 'corvax';
 c_Zero: LongWord = 0;
 c_MaxIntervalPerTable = 10; // Максимально-допустимое число интервалов на таблицу
 TEMP_TABLE = 'TEMP_TBL';

type
 PRecalcReferencesData = ^TRecalcReferencesData;
 TRecalcReferencesData = packed record
                          NewRefHandle: Ht_Const.THANDLE;
                          NewRefPhoto: LPSAB;
                          OldRefHandle: Ht_Const.THANDLE;
                          OldRefPhoto: LPSAB;

                          FieldOffset: Integer;
                          FieldSize: Integer;

                          pEmptyValue: PChar;

                          RefFieldNum: Smallint;
                          RefFieldOffset: Integer;

                          RefValueKeyNum: Smallint;
                          RefValueOffset: Integer;

                          pRefRecBuffer: PChar;
                          RefRecBufferSize: Integer;
                         end;

 PRenumFieldData = ^TRenumFieldData;
 TRenumFieldData = packed record
                    FieldOffset: Integer;
                    FieldValue: Longword;
                   end;

var
gReformer : TDbReformer = nil;

var
gStopErrRaise : boolean = false;

procedure fn_OnIOError(fpFileName: PChar;
                       nIoCode:    SmallInt;
                       nDosError:  SmallInt); {$IFDEF HT_MODE64} stdcall {$ELSE} pascal {$ENDIF};
var
 l_Buff220: array[0..220] of Char;
begin
 htIOMessage(@l_Buff220);
 gReformer.Log(StrPas(l_Buff220));
 if not gStopErrRaise then
  raise Exception.Create(StrPas(l_Buff220));
end;

procedure fn_OnHtError(nMessID: SmallInt);  {$IFDEF HT_MODE64} stdcall {$ELSE} pascal {$ENDIF};
var
 l_Buff220: array[0..220] of Char;
begin
 // игнорируемые ошибки
 if nMessID in [
  72, // "Таблица задействована в транзакциях" (это вовсе не ошибка)
  25  // "Unique key doublet value found" - возникает при изменении записи,
      //   при этом дубликаты удаляются автоматически, так что можно не беспокоиться

 ] then
  Exit;

 htMessage(nMessID, @l_Buff220);
 gReformer.Log(StrPas(l_Buff220) + ' Код ошибки: ' + IntToStr(nMessID));
 if not gStopErrRaise then
  raise Exception.Create(StrPas(l_Buff220) + ' Код ошибки: ' + IntToStr(nMessID));
end;

{TIntFieldChanger}
// объект принимает пары ключ - значение для конкретного поля, после чего проводит операцию группового исправления

type
 PKeyValRec = ^TKeyValRec;
 TKeyValRec = packed record
  rKey : integer;
  rValue : integer;
 end;

 {- накапливает в списке пары суррогатный ключ - значение поля aChangeFld, затем пакетом исправляет}
 TIntFieldChanger = class(Tl3ProtoObject)
  private
   fTable     : TdtTable;
   fKeyFld    : ThtField; // только суррогатный, по нему автосортируется
   fChangeFld : ThtField;
   fRecList    : Tl3RecList;

   function GetCount : Cardinal;
  protected
   procedure Cleanup; override;
  public
   constructor Create(aTable : TdtTable; {aKeyFld : ThtField; }aChangeFld : ThtField);
   procedure Add(aKey : integer; aValue : integer);
   procedure Apply;
   property Count : Cardinal read GetCount;
 end;


const
 cHandleSize = SizeOf(PKeyValRec(nil).rKey);

constructor TIntFieldChanger.Create(aTable : TdtTable; aChangeFld : ThtField);
begin
 Inherited Create;
 fTable     := aTable.Use;
 fKeyFld    := 0; // строго суррогатный
 fChangeFld := aChangeFld;
 Assert(SizeOf(TKeyValRec) = 8);
 fRecList   := Tl3FieldSortRecList.Create(SizeOf(TKeyValRec), [cHandleSize], [1]);

end;

procedure TIntFieldChanger.Cleanup;
begin
 l3Free(fTable);
 l3Free(fRecList);
 inherited;
end;

function TIntFieldChanger.GetCount : Cardinal;
begin
 Result := fRecList.Count;
end;

procedure TIntFieldChanger.Add(aKey : integer; aValue : integer);
var
 lRec : TKeyValRec;
begin
 lRec.rKey := aKey;
 lRec.rValue := aValue;
 fRecList.Add(lRec);
end;

procedure TIntFieldChanger.Apply;
var
 lListCursor : Integer;
 lCount : Integer;

 function lFillBufferProc(aBuffer: Pointer; aBufSize: Longint): Longint; register;
 var
  lRealSize : Longint;
  I : Integer;
 begin
  lRealSize := Min(aBufSize div cHandleSize, fRecList.Count - lListCursor);

  for I := lListCursor to lListCursor + pred(lRealSize) do
  begin
   PLongint(aBuffer)^ := PKeyValRec(fRecList.ItemSlot(I)).rKey;
   Inc(PChar(aBuffer), cHandleSize);
  end;

  Result := lRealSize * cHandleSize;
  Inc(lListCursor, lRealSize);
 end;

 function lModifyRec(gRecNo : LongInt; fpRecord : Pointer) : MFUNC_RET;
 var
  lKey : integer;
 begin
  //fTable.GetFieldFromRecord(fpRecord, fKeyFld, lKey);
  Assert(gRecNo = PKeyValRec(fRecList.ItemSlot(lListCursor)).rKey);
  fTable.PutFieldToRecord(fpRecord, fChangeFld, PKeyValRec(fRecList.ItemSlot(lListCursor)).rValue);
  Result := MFUNC_SUCCESS;
  Inc(lListCursor);
 end;

var
 lSab : ISab;
 lFillBufferProcStub : TFillBufferProc;
 lHTStub    : Pointer;
begin
 //набиваем sab
 if fRecList.Count = 0 then Exit;

 lListCursor := 0;
 lFillBufferProcStub := L2FillBufferProc(@lFillBufferProc);
 try
  lSab := MakeValueSet(fTable, fKeyFld, lFillBufferProcStub);
 finally
  FreeFillBufferProc(lFillBufferProcStub);
 end;

 lSab.RecordsByKey;
 fRecList.Sort;
 //lSab.Sort([fKeyFld]);

 lListCursor := 0;
 lHTStub := HTStub3(@lModifyRec);
 try
  lSab.ModifyRecs(lHTStub);
 finally
  HTStubFree(lHTStub);
 end;

 fRecList.Clear;
end;

{ TDbReformer }

procedure TDbReformer.CloseHt;
begin
try
 htShut;
 htGlobalShut;
except // после procedure TDbReformer.RecoverPriority; остается гавно в хоум каталоге и на выходе ругается.
       //Надеюсь что в новой версии hytech это полечено
end;
end;

constructor TDbReformer.Create(aDbInfo: TDbInfo;
                               aShowToUserProc: TShowToUserProc = nil;
                               aProgressProc: Tl3ProgressProc = nil);
const
 BACKUP_DIRNAME = 'cj74dp9h';
var
 l_TempPath: array[0 .. MAX_PATH] of Char;
 l_TempPathLen: Integer;
begin
 f_DbInfo := aDbInfo;

 f_ProgressProc := aProgressProc;
 f_ShowToUserProc := aShowToUserProc;
 f_DbRootFolder := f_DbInfo.RootFolder;
 f_FamilyFolder := f_DbInfo.FamilyFolder;
 f_MainFolder := f_DbInfo.MainFolder;
 f_DirLocks := f_DbInfo.ShareFolder;

 // папка TEMP
 l_TempPathLen := GetTempPath(MAX_PATH, @l_TempPath);
 l_TempPath[l_TempPathLen] := #0;
 f_DirTemp := StrPas(@l_TempPath);

 // папка BACKUP
 f_DirBackup := ConcatDirName(l_TempPath, BACKUP_DIRNAME);
end;

procedure TDbReformer.CreateTable(aStruct: TElemArray; aTableName: string; const aFamily: TFamilyFolder; aPassword: PChar = nil);
var
 l_TblName: string;
 l_DstHandle: HT_Const.THANDLE;
begin
 case aFamily of
  ffMain  : l_TblName := MainTable(aTableName);
  ffGarant: l_TblName := FamilyTable(aTableName);
 end;

 htTableCreate(PChar(l_TblName),
               HT_Const.LPELEMENT(aStruct),
               Length(aStruct),
               nil,
               aPassword,
               aPassword,
               TAB_CREATE or TAB_SHARE or TAB_ANSI,
               l_DstHandle);
 htTableClose(l_DstHandle);
end;

procedure TDbReformer.CopyTableStruct(aSrcTable, aDstTable: string;
                                      aStructChangeProc: TStructChangeProc = nil;
                                      aData: Pointer = nil);
var
 l_DstHandle: HT_Const.THANDLE;
 l_TableElementList: TElemArray;
 l_TableStruct: TTableStruct;
begin
 l_TableStruct := TTableStruct.Create(aSrcTable);
 try
  l_TableElementList := l_TableStruct.TableElementList;
 finally
  l_TableStruct.Free;
 end;
 try
  if Assigned(aStructChangeProc) then
   aStructChangeProc(l_TableElementList, aData);
  htTableCreate(PChar(aDstTable),
                HT_Const.LPELEMENT(l_TableElementList),
                Length(l_TableElementList),
                nil,
                TablePass(aSrcTable),
                TablePass(aSrcTable),
                TAB_CREATE or TAB_SHARE or TAB_ANSI,
                l_DstHandle);
  htTableClose(l_DstHandle);
 finally
  l_TableElementList := nil;
 end;
end;

procedure TDbReformer.CopyUniqData(aSrcTable,
                                   aDstTable: string;
                                   aUniqFieldNums: TFieldNums);
var
 l_DstTableHandle: Ht_Const.THANDLE;
 l_SrcTableHandle: Ht_Const.THANDLE;
 l_RecNo: LongWord;
 l_Records: Sab;
 l_UniqRecords: Sab;
begin
 // очистим
 htDropTableData(PChar(aDstTable), nil, nil);

 // основная обработка
 htTableOpen(PChar(aSrcTable),
             TablePass(aSrcTable),
             TablePass(aSrcTable),
             TAB_PRIVATE,
             l_SrcTableHandle);
 try
  l_RecNo := 0;
  htSearch(nil, l_Records, l_SrcTableHandle, 0, GREAT, @l_RecNo, nil);
  try
   // уникальные
   htDistinctResults(l_UniqRecords,
                     l_Records,
                     @aUniqFieldNums[0],
                     Length(aUniqFieldNums));
   try
    htTableOpen(PChar(aDstTable),
                TablePass(aDstTable),
                TablePass(aDstTable),
                TAB_PRIVATE,
                l_DstTableHandle);
    try
     htResultsToTable(l_UniqRecords,
                      l_DstTableHandle,
                      nil,
                      nil,
                      nil,
                      nil,
                      0,
                      False,
                      False);
    finally
     htTableClose(l_DstTableHandle);
     htUpdateTable(PChar(aDstTable),
                   TablePass(aDstTable),
                   TablePass(aDstTable),
                   True,
                   True);
    end; // htTableOpen
   finally
    htClearResults(l_UniqRecords);
   end; // htDistinctResults
  finally
   htClearResults(l_Records);
  end; // htSearch
 finally
  htTableClose(l_SrcTableHandle);
 end; // htTableOpen
end;

procedure TDbReformer.InitHt;
var
 l_Init :Init;
begin
 l3FillChar(l_Init, SizeOf(l_Init));
 with l_Init do
 begin
  nTableCnt      := 50;
  nTaskCnt       := 20;
  nHtCnt         := 4 + 20 * 6 + 1;
  nLockTimeOut   := 40;
  nPollDelay     := 40;
  nTransTimeOut  := 40;
  nTrsMode       := TRS_HARD;
  fpTmpPath      := PChar(f_DirTemp);
  fpNetPath      := PChar(f_DirLocks);
  fpTrtPath      := PChar(f_DirLocks);
  fpNetName      := PChar(STATION_NAME);
  fpfInfo        := Pointer(-1);
  fpfIoMess      := @fn_OnIOError;
  fpfErrMess     := @fn_OnHtError;
  fpfPiStart     := Pointer(-1);
  fpfPiDraw      := Pointer(-1);
  fpfPiStop      := Pointer(-1);
  fpfYield       := Pointer(-1);
  gHeapCtrl      := 10000000;
  gHeapTask      := 120000;
 end;
 htGlobalInit(HInstance);
 htInit(@l_Init, SizeOf(l_Init));
end;

procedure TDbReformer.DropIndices(const aTableName: string; aFieldNum: Word);
var
 l_TableStruct: TTableStruct;
 I: Integer;
begin
 l_TableStruct := TTableStruct.Create(aTableName);
 try
  for I := 0 to l_TableStruct.TableInfo.nFieldCnt +
                l_TableStruct.TableInfo.nGroupCnt +
                l_TableStruct.TableInfo.nSubstrCnt - 1 do
  begin
   // если индексированное поле
   if (I + 1 = aFieldNum)
   // или если поле входит в индексированную группу
    or ((l_TableStruct.TableElementList[I].cClass = EC_GROUP)
        and (aFieldNum >= l_TableStruct.TableElementList[I].wOffset)
        and (aFieldNum <  l_TableStruct.TableElementList[I].wOffset + l_TableStruct.TableElementList[I].wLength))
   then
    if l_TableStruct.TableElementList[I].cKey <> EK_NOTKEY then
     htChangeKeyType(PChar(aTableName), nil, nil, I + 1, EK_NOTKEY, False, False);
  end;
 finally
  l_TableStruct.Free;
 end;
end;

procedure TDbReformer.BuildIndices(const aTableName: string;
                                 const aTableStruct: TTableStruct);
var
 I: Integer;
 l_CurTableStruct: TTableStruct;
begin
 l_CurTableStruct := TTableStruct.Create(aTableName);
 try
  for I := 0 to aTableStruct.TableInfo.nFieldCnt +
                aTableStruct.TableInfo.nGroupCnt +
                aTableStruct.TableInfo.nSubstrCnt - 1 do
  begin
   if l_CurTableStruct.TableElementList[I].cKey <> aTableStruct.TableElementList[I].cKey then
    htChangeKeyType(PChar(aTableName),
                    nil,
                    nil,
                    I + 1,
                    aTableStruct.TableElementList[I].cKey,
                    False,
                    False);
  end;
 finally
  l_CurTableStruct.Free;
 end;
end;

function fn_RecalcReferences(gRecNo: LongInt;
                             fpRecord: Pointer;
                             fpUser: Pointer): MFUNC_RET;  {$IFDEF HT_MODE64} stdcall {$ELSE} pascal {$ENDIF};
var
 l_NewRefPhoto,
 l_OldRefPhoto: LPSAB;
 l_NewRefHandle,
 l_OldRefHandle: Ht_Const.THANDLE;
 l_RecNo: Integer;
 l_pData: PRecalcReferencesData;
begin
 l_pData := fpUser;

 l_NewRefHandle := l_pData^.NewRefHandle;
 l_NewRefPhoto  := l_pData^.NewRefPhoto;
 l_OldRefHandle := l_pData^.OldRefHandle;
 l_OldRefPhoto  := l_pData^.OldRefPhoto;

 l_RecNo := htRecordByUniq(l_OldRefPhoto,
                           l_OldRefHandle,
                           l_pData^.RefFieldNum,
                           PChar(fpRecord) + l_pData^.FieldOffset,
                           nil);
 if l_RecNo > 0 then
 begin
  l3FillChar(l_pData^.pRefRecBuffer^,
           l_pData^.RefRecBufferSize);
  if htReadRecord(l_OldRefPhoto,
                  l_OldRefHandle,
                  l_RecNo,
                  l_pData^.pRefRecBuffer) = 0 then
  begin
   l_RecNo := htRecordByUniq(l_NewRefPhoto,
                             l_NewRefHandle,
                             l_pData^.RefValueKeyNum, // номер поля - уникального ключа
                             l_pData^.pRefRecBuffer + l_pData^.RefValueOffset,
                             nil);
   if l_RecNo > 0 then
   begin
    l3FillChar(l_pData^.pRefRecBuffer^,
             l_pData^.RefRecBufferSize);
             
    if htReadRecord(l_NewRefPhoto,
                    l_NewRefHandle,
                    l_RecNo,
                    l_pData^.pRefRecBuffer) = 0 then
    begin
     l3Move((l_pData^.pRefRecBuffer + l_pData^.RefFieldOffset)^,
          (PChar(fpRecord) + l_pData^.FieldOffset)^,
          l_pData^.FieldSize);
    end; // htReadRecord
   end; // htRecordByUniq
  end; // htReadRecord
 end
 else // нет такого ==> запишем ПУСТОЕ_ЗНАЧЕНИЕ
 begin
  l3Move((l_pData^.pEmptyValue)^,
       (PChar(fpRecord) + l_pData^.FieldOffset)^,
       l_pData^.FieldSize);
 end; // htRecordByUniq
 Result := MFUNC_SUCCESS;
end;

procedure TDbReformer.RecalcReferences(aTable: string;
                                     aFieldNum: Smallint;
                                     aEmptyValue: PChar;
                                     aOldRefTable, aNewRefTable: string;
                                     aRefFieldNum: Smallint;
                                     aRefValueKeyNum: Smallint);
var
 l_Table: Ht_Const.THANDLE;
 l_OldRefTable,
 l_NewRefTable: Ht_Const.THANDLE;
 l_OldRefPhoto,
 l_NewRefPhoto: Sab;
 l_TableStruct,
 l_RefTableStruct: TTableStruct;
 l_Records: Sab;
 l_RecNo: LongWord;
 l_RecalcReferencesData: TRecalcReferencesData;
 l_RefRecBuffer: PChar;
begin
 htTableOpen(PChar(aOldRefTable),
             TablePass(aOldRefTable),
             TablePass(aOldRefTable),
             TAB_PRIVATE,
             l_OldRefTable);
 try
  l_RecNo := 0;
  htSearch(nil, l_OldRefPhoto, l_OldRefTable, 0, GREAT, @l_RecNo, nil);
  try
   htTableOpen(PChar(aNewRefTable),
               TablePass(aNewRefTable),
               TablePass(aNewRefTable),
               TAB_PRIVATE,
               l_NewRefTable);
   try
    l_RecNo := 0;
    htSearch(nil, l_NewRefPhoto, l_NewRefTable, 0, GREAT, @l_RecNo, nil);
    try
     l_TableStruct := TTableStruct.Create(aTable);
     try
      l_RefTableStruct := TTableStruct.Create(aNewRefTable);
      try
       // сбросим индексы
       DropIndices(aTable, aFieldNum);
       try
        htTableOpen(PChar(aTable),
                    TablePass(aTable),
                    TablePass(aTable),
                    TAB_PRIVATE,
                    l_Table);
        try
         l_RecNo := 0;
         htSearch(nil, l_Records, l_Table, 0, GREAT, @l_RecNo, nil);
         try
          GetMem(l_RefRecBuffer,
                 l_RefTableStruct.TableInfo.wRecordLen);
          try
           with l_RecalcReferencesData do
           begin
            NewRefHandle := l_NewRefTable;
            NewRefPhoto  := @l_NewRefPhoto;
            OldRefHandle := l_OldRefTable;
            OldRefPhoto  := @l_OldRefPhoto;

            FieldOffset := l_TableStruct.FieldInfos[aFieldNum].wOffset;
            FieldSize   := l_TableStruct.FieldInfos[aFieldNum].wLength;
            pEmptyValue := aEmptyValue;

            RefFieldNum := aRefFieldNum;
            RefFieldOffset := l_RefTableStruct.FieldInfos[aRefFieldNum].wOffset;

            RefValueKeyNum := aRefValueKeyNum;
            RefValueOffset := l_RefTableStruct.FieldInfos[
                               l_RefTableStruct.FieldInfos[aRefValueKeyNum].wOffset // номер первого поля
                              ].wOffset;


            RefRecBufferSize := l_RefTableStruct.TableInfo.wRecordLen;
            pRefRecBuffer := l_RefRecBuffer;
           end;

           htModifyRecords(l_Records,
                           @fn_RecalcReferences,
                           nil,
                           @l_RecalcReferencesData,
                           False);
          finally
           FreeMem(l_RefRecBuffer);
          end;
         finally
          htClearResults(l_Records);
         end;
        finally
         htTableClose(l_Table);
         htUpdateTable(PChar(aTable),
                       TablePass(aTable),
                       TablePass(aTable),
                       True,
                       True);
        end;
       finally
        BuildIndices(aTable, l_TableStruct);
       end;
      finally
       l_RefTableStruct.Free;
      end;
     finally
      l_TableStruct.Free;
     end;
    finally
     htClearResults(l_NewRefPhoto);
    end;
   finally
    htTableClose(l_NewRefTable);
   end;
  finally
   htClearResults(l_OldRefPhoto);
  end;
 finally
  htTableClose(l_OldRefTable);
 end;
end;

function TDbReformer.FamilyTable(aTableName: string): string;
begin
 Result := ConcatDirName(f_FamilyFolder, aTableName);
end;

procedure TDbReformer.CopyData(aFromTable, aToTable: string);
begin
 // очистим новую таблицу
 htDropTableData(PChar(aToTable),
                 TablePass(aToTable),
                 TablePass(aToTable));

 htOutTo(PChar(aFromTable),
         TablePass(aFromTable),
         TAB_PRIVATE,
         PChar(aToTable),
         TablePass(aToTable),
         TablePass(aToTable),
         nil,
         False,
         False);

 htUpdateTable(PChar(aToTable),
               TablePass(aToTable),
               TablePass(aToTable),
               True,
               True);
end;

function fn_RenumField(gRecNo: LongInt;
                       fpRecord: Pointer;
                       fpUser: Pointer): MFUNC_RET;  {$IFDEF HT_MODE64} stdcall {$ELSE} pascal {$ENDIF};
begin
 PLongword(PChar(fpRecord) + PRenumFieldData(fpUser)^.FieldOffset)^ := PRenumFieldData(fpUser)^.FieldValue;
 Inc(PRenumFieldData(fpUser)^.FieldValue);
 Result := MFUNC_SUCCESS;
end;

procedure TDbReformer.RenumField(aTable: string; aFieldNum: SmallInt);
var
 l_TableHandle: Ht_Const.THANDLE;
 l_RecNo: LongWord;
 l_Records: Sab;
 l_RenumFieldData: TRenumFieldData;
 l_TableStruct: TTableStruct;
begin
 l_RenumFieldData.FieldValue := 1;
 l_TableStruct := TTableStruct.Create(aTable);
 try
  l_RenumFieldData.FieldOffset := l_TableStruct.FieldInfos[aFieldNum].wOffset;
 finally
  l_TableStruct.Free;
 end;

 htTableOpen(PChar(aTable),
             TablePass(aTable),
             TablePass(aTable),
             TAB_PRIVATE,
             l_TableHandle);
 try
  l_RecNo := 0;
  htSearch(nil, l_Records, l_TableHandle, 0, GREAT, @l_RecNo, nil);
  try
   htModifyRecords(l_Records,
                   @fn_RenumField,
                   nil,
                   @l_RenumFieldData,
                   False);
  finally
   htClearResults(l_Records);
  end; // htSearch
 finally
  htTableClose(l_TableHandle);
 end; // htTableOpen
end;

function TDbReformer.GetCurFamilyVersion: Integer;
begin
 Result := f_DbInfo.FamilyFolderVersion;
end;

procedure TDbReformer.SetCurFamilyVersion(const Value: Integer);
begin
 f_DbInfo.FamilyFolderVersion := Value;
end;

procedure TDbReformer.RestoreTable(const aFullTableName: string);
begin
 CopyFilesByMask(DirBackup,
                 ExtractFilePath(aFullTableName),
                 ChangeFileExt(ExtractFileName(aFullTableName), '.h*'));
end;

procedure TDbReformer.SaveTable(const aFullTableName: string);
begin
 CopyFilesByMask(ExtractFilePath(aFullTableName),
                 DirBackup,
                 ChangeFileExt(ExtractFileName(aFullTableName), '.h*'));
end;


procedure TDbReformer.DropTable(const aFullTableName: string);
begin
 htDropTable(PAnsiChar(aFullTableName), nil, nil);
end;

procedure TDbReformer.DoProgressProc(aState : Byte; aValue: Longint; const aMsg : String = '');
begin
 if Assigned(f_ProgressProc) then
  f_ProgressProc(aState, aValue, aMsg);
end;

procedure TDbReformer.Log(const aStr: string; aShowTime: Boolean = False);
const
 EOL = #13#10;
var
 l_Str: string;
begin
 if Assigned(f_ShowToUserProc) or Assigned(f_FileStream) then
 begin
  l_Str := StringReplace(aStr, #10, ' ', [rfReplaceAll]);
  l_Str := StringReplace(l_Str, #13, ' ', [rfReplaceAll]);
  if aShowTime then
   l_Str := TimeToStr(Time) + '  ' + l_Str;

  if Assigned(f_ShowToUserProc) then
   f_ShowToUserProc(l_Str);

  if Assigned(f_FileStream) then
  begin
   f_FileStream.Write(l_Str[1], Length(l_Str));
   f_FileStream.Write(EOL[1], Length(EOL));
  end;
 end; 
end;

procedure TDbReformer.Error(const aStr: string);
begin
 Log('Ошибка: ' + aStr);
 MessageDlg(aStr, mtError, [mbOK], 0);
end;

procedure TDbReformer.Info(const aStr: string);
begin
 Log('Сведения: ' + aStr);
 MessageDlg(aStr, mtInformation, [mbOK], 0);
end;

procedure TDbReformer.RecalcStrField(aTable: string;
                                     aFieldNum: SmallInt;
                                     aRecalcProc: LPMFUNC;
                                     aFieldValueMask: PChar = nil);
var
 l_TableHandle: Ht_Const.THANDLE;
 l_RecNo: LongWord;
 l_Records: Sab;
 l_FieldData: TFieldData;
 l_TableStruct: TTableStruct;
begin
 l_TableStruct := TTableStruct.Create(aTable);
 try
  l_FieldData.Offset := l_TableStruct.FieldInfos[aFieldNum].wOffset;
  l_FieldData.Length := l_TableStruct.FieldInfos[aFieldNum].wLength;
  l_FieldData.pData := nil;
 finally
  l_TableStruct.Free;
 end;

 htTableOpen(PChar(aTable),
             TablePass(aTable),
             TablePass(aTable),
             TAB_PRIVATE,
             l_TableHandle);
 try
  l_RecNo := 0;
  if aFieldValueMask = nil then // обрабатываем все записи
   htSearch(nil,
            l_Records,
            l_TableHandle,
            aFieldNum,
            GREAT,
            @l_RecNo,
            nil)
  else // обрабатываем все записи, у которых поле aFieldNum удовлетворяет маске aFieldValueMask
   htSearch(nil,
            l_Records,
            l_TableHandle,
            aFieldNum,
            WILDCASE,
            aFieldValueMask,
            nil);
  try
   htModifyRecords(l_Records,
                   aRecalcProc,
                   nil,
                   @l_FieldData,
                   False);
  finally
   htClearResults(l_Records);
  end; // htSearch
 finally
  htTableClose(l_TableHandle);
 end; // htTableOpen

 htUpdateTable(PChar(aTable),
               TablePass(aTable),
               TablePass(aTable),
               True,
               True);
end;

procedure TDbReformer.JournalUnpack(const aTblName: string);
const
 cModifyType : array[0..2] of string =('ADD','DEL','MDF');
var
 l_TableHandle: HT_Const.THANDLE;
 l_Log: HT_Const.LOGON;
 l_pBuf: PChar;
 I: Integer;
 l_Rec: PChar;
 l_pRecNo: HT_Const.LPRHANDLE;

 l_Filer : Tl3DOSFiler;
 lFileTbl : TdtTable;
begin
 lFileTbl := TdtTable.CreateWithOpen(ExtractFileDir(aTblName), ''{TablePass}, ExtractOnlyFileName(aTblName), TAB_SHARE);
 lFileTbl.CloseTbl; //open-close для того что бы tableinfo набрать
 try
  l_Filer := Tl3DOSFiler.Make(ChangeFileExt(aTblName, '.jrnl.txt') ,l3_fmCreateReadWrite);
  l_Filer.Open;
  try
   htLogOpen(PChar(aTblName), nil, nil, nil, 0, l_Log); // все изменения
   try
    GetMem(l_pBuf, l_Log.wItemLen);
    // буфер = тип операции (1 байт) + физ. номер записи + собственно запись
    l_pRecNo := HT_Const.LPRHANDLE(l_pBuf + SizeOf(Byte));
    l_Rec := l_pBuf + SizeOf(Byte) + SizeOf(RHANDLE);
    try
     l_Filer.Writeln('OP'#9'RecNo'#9+lFileTbl.GenRecHeaderStr);
     for I := 0 to Pred(l_Log.gItemCnt) do
     begin
      htLogRead(l_Log, I, l_pBuf, l_Log.wItemLen);
      l_Filer.Write(cModifyType[PByte(l_pBuf)^]);
      l_Filer.Write(#9);
      l_Filer.Write(IntToStr(l_pRecNo^));
      l_Filer.Write(#9);
      l_Filer.Writeln(lFileTbl.GenRecStr(l_Rec));
     end;
    finally
     FreeMem(l_pBuf);
    end;
   finally
    htLogClose(l_Log);
   end;
  finally
   l_Filer.Close;
   FreeAndNil(l_Filer);
  end;
 finally
  l3Free(lFileTbl);
 end;
end;

(*function TSab.InternalGetMaskSab(aElemNum : ThtField; aMask : Integer) : ISab;
var
 lVSFiller : IValueSetFiller;

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 begin
  Result := True;
  if l3TestMask(PInteger(aItemPtr)^, aMask) then
   lVSFiller.AddValue(PInteger(aItemPtr)^);
 end;

var
 lValues     : ISab;
 lRAProcStub : TdtRecAccessProc;

begin
 lValues := MakeSabCopy(Self);
 lValues.ValuesOfKey(aElemNum);

 // фильтрация
 Result := MakeEmptySab(lValues);
 lVSFiller := Result.MakeValueSetFiller(aElemNum);

 lRAProcStub := L2RecAccessProc(@lRecAccessProc);
 try
  lValues.IterateRecords(lRAProcStub);
 finally
  FreeRecAccessProc(lRAProcStub);
 end;
 lVSFiller := nil;  // сброс кеша в SAB

 Result.RecordsByKey;
end;*)

procedure TDbReformer.UpcaseFieldValue(const aTblName: string; aFldNum : ThtField);
var
 lTbl : TdtTable;
 lSabAll : ISab;
 lFldOffset : word;
 lFldLen : word;
 lHTStub    : Pointer;
 lSabSelect : ISab;
 lRAProcStub : TdtRecAccessProc;
 lCnt       : Integer;

 procedure FindIncorrectRecs;
  var
   lSabSelectCursor : ISabCursor;

  function lRecAccessProc(aItemPtr : Pointer) : Boolean;
  var
   I : ThtField;
  begin
   Inc(lCnt);
   DoProgressProc(piCurrent, lCnt);

   Result := True;

   if l3CharSetPresent(PChar(aItemPtr) + 4 {Size of RecNo} + lFldOffset, lFldLen, ['a'..'z', 'а'..'я']) then
    lSabSelectCursor.AddItem(PCardinal(aItemPtr)^);
  end;

 begin  //procedure FindIncorrectRecs;
  lCnt := 0;
  DoProgressProc(piStart, lSabAll.Count, 'Поиск');

  lSabSelectCursor := lSabSelect.MakeSabCursor([]);

  lRAProcStub := L2RecAccessProc(@lRecAccessProc);
  try
   lSabAll.IterateRecords(lRAProcStub, [], ROPEN_READ);
  finally
   FreeRecAccessProc(lRAProcStub);
  end;
  //lSabSelectCursor := nil;
  DoProgressProc(piEnd, 0);
 end; //procedure FindIncorrectRecs;


 function lRecCorrectProc(gRecNo : LongInt; fpRecord : Pointer) : MFUNC_RET;
 var
  I : ThtField;
 begin
  Result := MFUNC_SUCCESS;
  ANSIUpperBuff(PChar(fpRecord)+lFldOffset, lFldLen);
 end;

begin
 lTbl := TdtTable.CreateWithOpen(ExtractFileDir(aTblName), ''{TablePass}, ExtractOnlyFileName(aTblName), TAB_SHARE);
 try
  with lTbl.Element[aFldNum] do
   if cType = ET_CHAR then
   begin
    lFldOffset := wOffset;
    lFldLen := wLength;
   end
   else
    raise Exception.Create('UpcaseFieldValue : поле не текстовое');

  lSabAll := MakeAllRecords(lTbl);
  lSabSelect := MakeEmptySab(lSabAll);

  FindIncorrectRecs;
  if lSabSelect.Count = 0 then
  begin
   Log('Номеров в нижнем регистре не обнаружено.');
   exit;
  end;
  Log(Format('Обнаружено %d некорректных записей.',[lSabSelect.Count]));

  lHTStub := HTStub3(@lRecCorrectProc);
  try
   DoProgressProc(piStart, lSabSelect.Count, 'Upcase');
   lSabSelect.ModifyRecs(lHTStub, false {aDupIgnore, вольное допущение, что коррекция строк не приведет к конфликтам уникальных ключей});
  finally
   DoProgressProc(piEnd, 0);
   HTStubFree(lHTStub);
  end;
 finally
  l3Free(lTbl);
 end;
end;

procedure TDbReformer.CorrectForbiddenValue(const aTblName: string);
type
 TTxtFld = record
  rNum  : ThtField;
  rOffs : Word;
  //rLen  : Word;
 end;
type
 PCardinal = ^Cardinal;
var
 lTxtFldArray : array of TTxtFld;
 lFileTbl : TdtTable;
 //lStream : Tl3TextStream;

 procedure LoadTxtFldArray;
 var
  I : ThtField;
  lCnt : word;
 begin
  SetLength(lTxtFldArray, 0);
  lCnt := 0;
  for I := 1 to lFileTbl.FldCount do
   if lFileTbl.Element[I].cType = ET_CHAR then
    inc(lCnt);

  if lCnt > 0 then
  begin
   SetLength(lTxtFldArray, lCnt);
   lCnt := 0;
   for I := 1 to lFileTbl.FldCount do
   if lFileTbl.Element[I].cType = ET_CHAR then
   begin
    with lTxtFldArray[lCnt] do
    begin
     rNum  := I;
     rOffs := lFileTbl.Element[I].wOffset;
    end;
    inc(lCnt);
   end;
  end;
 end;

var
 lSabAll : ISab;
 lSabSelect : ISab;
 lRAProcStub : TdtRecAccessProc;
 lHTStub    : Pointer;
 lCnt       : Integer;

 procedure FindIncorrectRecs;
  var
   lSabSelectCursor : ISabCursor;

  function lRecAccessProc(aItemPtr : Pointer) : Boolean;
  var
   I : ThtField;
  begin
   Inc(lCnt);
   DoProgressProc(piCurrent, lCnt);

   Result := True;
   for I := 0 to pred(Length(lTxtFldArray)) do
    if not lFileTbl.CheckHTStrWrongSymbols(PChar(aItemPtr)+lTxtFldArray[I].rOffs + 4 {Size of RecNo}) then
    begin
     lSabSelectCursor.AddItem(PCardinal(aItemPtr)^);
     //lStream.Writeln([PCardinal(aItemPtr)^, lFileTbl.GenRecStr(PChar(aItemPtr) + 4)]);
    end;
  end;

 begin
  lCnt := 0;
  DoProgressProc(piStart, lSabAll.Count, 'Поиск');

  lSabSelectCursor := lSabSelect.MakeSabCursor([]);

  lRAProcStub := L2RecAccessProc(@lRecAccessProc);
  try
   lSabAll.IterateRecords(lRAProcStub, [], ROPEN_READ);
  finally
   FreeRecAccessProc(lRAProcStub);
  end;
  //lSabSelectCursor := nil;
  DoProgressProc(piEnd, 0);
 end;

 function lRecCorrectProc(gRecNo : LongInt; fpRecord : Pointer) : MFUNC_RET;
 var
  I : ThtField;
 begin
  Result := MFUNC_SUCCESS;
  for I := 0 to pred(Length(lTxtFldArray)) do
   lFileTbl.ReplaceHTStrWrongSymbols(PChar(fpRecord)+lTxtFldArray[I].rOffs);
 end;

begin
 //lStream := Tl3TextStream.Create(ChangeFileExt(aTblName, '.badfld.txt') ,l3_fmCreateReadWrite);
 //try
  lFileTbl := TdtTable.CreateWithOpen(ExtractFileDir(aTblName), ''{TablePass}, ExtractOnlyFileName(aTblName), TAB_SHARE);
  try
   LoadTxtFldArray;
   if Length(lTxtFldArray) = 0 then Exit; // нет текcтовых полей в таблице

    lSabAll := MakeAllRecords(lFileTbl);
    lSabSelect := MakeEmptySab(lSabAll);

    FindIncorrectRecs;
    if lSabSelect.Count = 0 then
    begin
     Log('Запрещенных значений не обнаружено.');
     exit;
    end;
    Log(Format('Обнаружено %d некорректных записей.',[lSabSelect.Count]));

    lHTStub := HTStub3(@lRecCorrectProc);
    try
     DoProgressProc(piStart, lSabSelect.Count, 'Исправление');
     lSabSelect.ModifyRecs(lHTStub, false {aDupIgnore, вольное допущение, что коррекция строк не приведет к конфликтам уникальных ключей});
    finally
     DoProgressProc(piEnd, 0);
     HTStubFree(lHTStub);
    end;
  finally
   l3Free(lFileTbl);
  end;

// finally
//  lStream.Free;               
// end;
end;

procedure TDbReformer.ApplyJournalActions(aSrcTable, aDstTable: string);
var
 l_DstTableHandle: HT_Const.THANDLE;
 l_Log: HT_Const.LOGON;
 l_pBuf: PChar;
 I: Integer;
 l_Rec: PChar;
 l_pRecNo: HT_Const.LPRHANDLE;
begin
 htTableOpen(PChar(aDstTable),
             TablePass(aDstTable),
             TablePass(aDstTable),
             TAB_PRIVATE,
             l_DstTableHandle);
 try
  htLogOpen(PChar(aSrcTable), nil, nil, nil, 0, l_Log); // все изменения
  try
   GetMem(l_pBuf, l_Log.wItemLen);
   // буфер = тип операции (1 байт) + физ. номер записи + собственно запись
   l_pRecNo := HT_Const.LPRHANDLE(l_pBuf + SizeOf(Byte));
   l_Rec := l_pBuf + SizeOf(Byte) + SizeOf(RHANDLE);
   try
    for I := 0 to l_Log.gItemCnt - 1 do
    begin
     htLogRead(l_Log, I, l_pBuf, l_Log.wItemLen);
     case PByte(l_pBuf)^ of
      LOG_ADD: htRecordAdd(l_DstTableHandle, l_Rec);
      LOG_DEL: htRecordDelete(l_DstTableHandle, l_pRecNo^);
      LOG_MDF: htRecordModify(l_DstTableHandle, l_pRecNo^, l_Rec);
     end;
    end;
   finally
    FreeMem(l_pBuf);
   end;
  finally
   htLogClose(l_Log);
  end;
 finally
  htTableClose(l_DstTableHandle);
 end;
 htUpdateTable(PChar(aDstTable),
                     TablePass(aDstTable),
                     TablePass(aDstTable),
                     True,
                     True);
end;

function TDbReformer.DeleteLinkDictDuplicates(aLinkTable, aDictTable: string): Integer;
const
 l_Zero: Integer = 0;
var
 l_DictHandle,
 l_LinkHandle: HT_Const.THANDLE;
 l_DictRecs,
 l_LinkRecs,
 l_JoinedRecs,
 l_SortedRecs: Sab;

 l_DictFieldCount,
 l_SelectedFieldCount: Integer;

 l_TableStruct: TTableStruct;
 l_SortFields: array[0..20] of Smallint;
 l_TableHandels: THandleArray;

 I: Integer;
 l_RecLen: Cardinal;
 l_Rec,
 l_PrevRec: PChar;
 l_LnkRecNo,
 l_DtRecNo: Integer;
begin
 Result := 0;
 l_TableStruct := TTableStruct.Create(aDictTable);
 try
  l_DictFieldCount := l_TableStruct.TableInfo.nFieldCnt;
 finally
  l_TableStruct.Free;
 end;

 l_SelectedFieldCount := 1 + (l_DictFieldCount - 1); // LNK.Doc_ID + DT.* (кроме ID)

 htTableOpen(PChar(aDictTable),
             TablePass(aDictTable),
             TablePass(aDictTable),
             TAB_SHARE,
             l_DictHandle);
 try
  htTableOpen(PChar(aLinkTable),
              TablePass(aLinkTable),
              TablePass(aLinkTable),
              TAB_SHARE,
              l_LinkHandle);
  try
   htSearch(nil, l_DictRecs, l_DictHandle, 0, GREAT, @l_Zero, nil);
   try
    htSearch(nil, l_LinkRecs, l_LinkHandle, 0, GREAT, @l_Zero, nil);
    try
     htTablesJoin(l_JoinedRecs,
                  l_LinkRecs,
                  2, // "LinkTable".Dic_Id
                  EQUAL,
                  l_DictRecs,
                  1, // "_Dictionary".Id
                  nil,
                  False,
                  DRAFT_ZERO);
     try
      htTellJoinOrder(l_JoinedRecs, @l_TableHandels);

      // Заполнение: l_SortFields = LNK.Doc_ID  +  DT.* (кроме ID) + физ.номер LNK + физ.номер DT
      //  Всего: (l_SelectedFieldCount + 2) значений
      l3FillChar(l_SortFields, SizeOf(l_SortFields));
      l_SortFields[0] := FieldNo(@l_TableHandels, 2, l_LinkHandle, 1); // LNK.Doc_ID
      for I := 1 to l_SelectedFieldCount - 1 do
       l_SortFields[I] := FieldNo(@l_TableHandels, 2, l_DictHandle, I + 1); // DT.* (кроме ID)
      // добавление в конец физ. номеров записей
      l_SortFields[l_SelectedFieldCount]     := FieldNo(@l_TableHandels, 2, l_LinkHandle, 0); // физ.номер LNK
      l_SortFields[l_SelectedFieldCount + 1] := FieldNo(@l_TableHandels, 2, l_DictHandle, 0); // физ.номер DT

      htSortResults(l_SortedRecs,
                    l_JoinedRecs,
                    @l_SortFields,
                    l_SelectedFieldCount);
      try
       htOpenResults(l_SortedRecs,
                     ROPEN_READ,
                     @l_SortFields,
                     l_SelectedFieldCount + 2); // читаем вместе с физ. номерами записей
       try
        htResultsItemLen(l_SortedRecs, l_RecLen);
        GetMem(l_Rec, l_RecLen);
        GetMem(l_PrevRec, l_RecLen);
        l3FillChar(l_PrevRec^, l_RecLen);
        try
         while htReadResults(l_SortedRecs, l_Rec, l_RecLen) <> 0 do
         begin
          if CompareMem(l_Rec, l_PrevRec, l_RecLen - 2 * SizeOf(LongWord)) then // найден дубликат
          begin // удаление дубликата
           l_LnkRecNo := PLongWord(l_Rec + l_RecLen - 2 * SizeOf(LongWord))^; // предпоследн.
           l_DtRecNo  := PLongWord(l_Rec + l_RecLen - 1 * SizeOf(LongWord))^; // последн.

           htRecordDelete(l_LinkHandle, l_LnkRecNo);
           htRecordDelete(l_DictHandle, l_DtRecNo);

           Inc(Result);
          end
          else
           l3Move(l_Rec^, l_PrevRec^, l_RecLen);
         end; // while
        finally
         FreeMem(l_PrevRec);
         FreeMem(l_Rec);
        end;
       finally
        htCloseResults(l_SortedRecs);
       end;
      finally
       htClearResults(l_SortedRecs);
      end;
     finally
      htClearResults(l_JoinedRecs);
     end;
    finally
     htClearResults(l_LinkRecs);
    end;
   finally
    htClearResults(l_DictRecs);
   end;
  finally
   htTableClose(l_LinkHandle);
  end;
 finally
  htTableClose(l_DictHandle);
 end;
end;

function TDbReformer.FieldNo(aLinkedTables: PHandleArray;
                             aTablesAmount: Integer;
                             aParentTable: HT_Const.THANDLE;
                             aFieldNoInParentTable: Integer): Integer;
var
 I: Integer;
 l_TableInfo: HT_Const.TABLE;
begin
 Result := 0;
 for I := 0 to aTablesAmount do
 begin
  if I = aTablesAmount then
   raise Exception.Create('Ошибка в TDbReformer.FieldNo')
  else
   if aLinkedTables^[I] = aParentTable then
   begin
    Result := Result + aFieldNoInParentTable;
    Break;
   end
   else
   begin
    htTableInfo(aLinkedTables^[I], l_TableInfo);
    Result := Result + 1 + l_TableInfo.nFieldCnt;
   end;
 end; //for
end;

procedure TDbReformer.DeleteBadLinkRec(aFamily: TFamilyID);
const
 l_Zero: Integer = 0;
var
 lLinkTblName : string;
 lDictTblName : string;
 lTblPath     : string;
 lDictTbl : TdtTable;
 lLinkTbl : TdtTable;
 lFileTbl : TdtTable;

 lSab : ISab;
 l_Attr : TdtAttribute;
 lCnt : Integer;
begin
 {if aFamily = MainTblsFamily then
  lTblPath := f_MainFolder
 else}

 lTblPath := f_FamilyFolder;
 lFileTbl := TdtTable.CreateWithOpen(lTblPath, ''{TablePass}, TableName(aFamily, ord(ftFile)), TAB_SHARE);
 try
  for l_Attr := Low(TdtAttribute) to High(TdtAttribute) do
   with cAttrPassport[l_Attr] do
   begin
    if (l_Attr = atJurLogRecords) or // два журнала в одной таблице, вторую пропускаем
       (rLink = ftFile) or // атрибуты в основной таблице, ничо не делаем
       (rLink = ftRenum) or // в Renum могут быть записи от несуществующих доков, ничо не делаем
       (rLink = ftNone)  then
     Continue;

    Log(Format('Проверка атрибута %s', [rName]));

    try
     lLinkTblName := TableName(aFamily, Ord(rLink));
     //Log('Link= '+lLinkTblName);
     lLinkTbl := TdtTable.CreateWithOpen(lTblPath, TablePassS(ConcatDirName(lTblPath,lLinkTblName)), lLinkTblName, TAB_SHARE);
     try
      if rDict <> da_dlNone then
      begin
       lDictTblName := TableName(aFamily, Ord(cDLPassports[rDict].rDict));
       //Log('Dict= '+lDictTblName);
       lDictTbl := TdtTable.CreateWithOpen(lTblPath, TablePassS(ConcatDirName(lTblPath,lDictTblName)), lDictTblName, TAB_SHARE);
       try
        // удаление записей в Link, которым нет соответствующих в Dict
        lSab := MakeAllRecords(lDictTbl);
        lSab.ValuesOfKey(dtIDFld);
        lSab.TransferToPhoto(lnkDictIDFld, lLinkTbl);
        lSab.RecordsByKey;
        lSab.InvertSab;
        lCnt := lSab.Count;

        if lCnt = 0 then
         Log('Связка Link-Dict: Ошибок не обнаружено.')
        else
        begin
         lSab.DeleteFromTable;
         Log(Format('Связка Link-Dict: Удалено %d записей.', [lCnt]));
        end;
       finally
        l3Free(lDictTbl);
       end;
      end;

      // удаление записей в Link, которым нет соответствующих в File
      lSab := MakeAllRecords(lFileTbl);
      lSab.ValuesOfKey(docIdFld);
      lSab.TransferToPhoto(DocIDField(l_Attr), lLinkTbl);
      lSab.RecordsByKey;
      lSab.InvertSab;

      lCnt := lSab.Count;

      if lCnt = 0 then
       Log('Связка Doc-Link: Ошибок не обнаружено.')
      else
      begin
       lSab.DeleteFromTable;
       Log(Format('Связка Doc-Link: Удалено %d записей.', [lCnt]));
      end;

     finally
      l3Free(lLinkTbl);
     end;
    except
     on E : Exception do
      Log('!! '+E.Message);
    end;
  end; //with cAttrPassport[l_Attr] do
 finally
  l3Free(lFileTbl);
 end;
end;

function fn_SetFieldValue(gRecNo: LongInt;
                          fpRecord: Pointer;
                          fpUser: Pointer): MFUNC_RET; {$IFDEF HT_MODE64} stdcall {$ELSE} pascal {$ENDIF};
begin
 l3Move( PChar(PFieldData(fpUser)^.pData)^,
      (PChar(fpRecord) + PFieldData(fpUser)^.Offset)^,
      PFieldData(fpUser)^.Length);
 Result := MFUNC_SUCCESS;
end;

procedure TDbReformer.SetFieldValue(aTableName: string;
                           aFamilyFolder: TFamilyFolder;
                           aFieldNum: SmallInt;
                           var aValue);
begin
 SetFieldValue(FullTableName(aFamilyFolder, aTableName), aFieldNum, aValue);
end;


procedure TDbReformer.SetFieldValue(aTable: string;
                                    aFieldNum: SmallInt;
                                    var aValue);
const
 l_Zero: Integer = 0;
var
 l_TableStruct: TTableStruct;
 l_TableHandle: Ht_Const.THANDLE;
 l_Records: Sab;
 l_FieldData: TFieldData;
begin
 l_TableStruct := TTableStruct.Create(aTable);
 try
  l_FieldData.Offset := l_TableStruct.FieldInfos[aFieldNum].wOffset;
  l_FieldData.Length := l_TableStruct.FieldInfos[aFieldNum].wLength;
 finally
  l_TableStruct.Free;
 end;

 htTableOpen(PChar(aTable),
             TablePass(aTable),
             TablePass(aTable),
             TAB_PRIVATE,
             l_TableHandle);
 try
  htSearch(nil,
           l_Records,
           l_TableHandle,
           aFieldNum,
           NOT_EQUAL,
           @aValue,
           nil);
  try
   l_FieldData.pData := @aValue;
   htModifyRecords(l_Records,
                   @fn_SetFieldValue,
                   nil,
                   @l_FieldData,
                   False);
  finally
   htClearResults(l_Records);
  end; // htSearch
 finally
  htTableClose(l_TableHandle);
 end; // htTableOpen

 htUpdateTable(PChar(aTable),
               TablePass(aTable),
               TablePass(aTable),
               True,
               True);
end;

function TDbReformer.MainTable(aTableName: string): string;
begin
 Result := ConcatDirName(f_MainFolder, aTableName);
end;

function TDbReformer.GetMainFolderVersion: Integer;
begin
 Result := f_DbInfo.MainFolderVersion;
end;

procedure TDbReformer.SetMainFolderVersion(const Value: Integer);
begin
 f_DbInfo.MainFolderVersion := Value;
end;

procedure TDbReformer.DeleteHlkFiles;
begin
// Log('Удаление файлов ' + ConcatDirName(f_FamilyFolder, '*.HLK'));
 DeleteFilesByMask(f_FamilyFolder, '*.HLK');

// Log('Удаление файлов ' + ConcatDirName(f_MainFolder, '*.HLK'));
 DeleteFilesByMask(f_MainFolder, '*.HLK');

// Log('Очистка директории ' + f_DirLocks);
 PureDir(f_DirLocks);
end;

procedure TDbReformer.CloseLog;
begin
 FreeAndNil(f_FileStream);
end;

procedure TDbReformer.InitLog;
var
 l_LogFile: string;
 l_OpenLogOptions: Tl3FileMode;
begin
 // открытие лог-файла
 l_LogFile := ConcatDirName(f_DbRootFolder,
                            //ChangeFileExt(ExtractFileName(Application.ExeName), '.LOG'));
                            'DbUpdate.log');
 (*
 if FileExists(l_LogFile) then
  l_OpenLogOptions := l3_fmWrite
 else
  l_OpenLogOptions := l3_fmCreate;
 *)
 f_FileStream := Tl3FileStream.Create(l_LogFile,
                                      l3_fmWrite);
 // дописывание в конец
 f_FileStream.Seek(0, soEnd);
end;

procedure TDbReformer.LockedTables(aFolder: string;
                                   aResult: TStringList);
var
 l_SearchRec: TSearchRec;
 l_FindResult: Integer;
 l_Table: string;
 l_TableHolder: string;
begin
 if aResult = nil then
  Exit;
 aResult.Clear;

 l_FindResult := FindFirst(ConcatDirName(aFolder, '*.HTB'),
                           faAnyFile,
                           l_SearchRec);
 try
  while l_FindResult = 0 do
  begin
   if (l_SearchRec.Attr and (faDirectory or faVolumeID or faSymLink)) = 0 then
   begin
    l_Table := ChangeFileExt(ConcatDirName(aFolder, l_SearchRec.Name), '');
    if TableLocked(l_Table, l_TableHolder) then
     aResult.Add(l_Table + ' удерживается станцией ' + l_TableHolder);
   end;
   l_FindResult:=FindNext(l_SearchRec);
  end;
 finally
  FindClose(l_SearchRec);
 end;
end;


function TDbReformer.TableLocked(const aTable: string;
                                 out aHolder: string): Boolean;
var
 l_Holder: HT_Const.OWNER;
begin
 Result := htWhoLockTable(PChar(aTable), l_Holder) > 0;
 if Result then
  aHolder := l3ArrayToString(l_Holder.szUser, HT_Const.TNAME_LEN)
 else
  aHolder := '';
end;

function TDbReformer.RecordsLocked(const aTable: string;
                                   out aHolder: string): Boolean;
var
 l_Holder: HT_Const.OWNER;
 l_TableHandle: Ht_Const.THANDLE;
 l_Records: Sab;
begin
 htTableOpen(PChar(aTable),
             TablePass(aTable),
             TablePass(aTable),
             TAB_SHARE,
             l_TableHandle);
 try
  htSearch(nil, l_Records, l_TableHandle, 0, GREAT, @c_Zero, nil);
  try
   Result :=  htWhoLockSet(l_Records, l_Holder) > 0;
  finally
   htClearResults(l_Records);
  end;
 finally
  htTableClose(l_TableHandle);
 end;

 if Result then
  aHolder := l3ArrayToString(l_Holder.szUser, HT_Const.TNAME_LEN)
 else
  aHolder := '';
end;

class function TDbReformer.TablePass(const aTable: string): PChar;
var
 l_Mode: Integer;
 l_Success: Boolean;
 l_TableName: string;
begin
 try
  l_Success := htTableHeadPswd(PChar(aTable), l_Mode) = 0;
 except
  l_Success := false;
 end;
 if l_Success then
 begin
  if l_Mode > 0 then
   Result := PChar(c_TablePass+#0)
  else
   Result := nil;
 end
 else
 begin
  l_TableName := AnsiUpperCase(ChangeFileExt(ExtractFileName(aTable), ''));
  if (l_TableName = 'ACCESS') or (l_TableName = 'PASS') or (l_TableName = 'BB_LOG') then
   Result := PChar(c_TablePass+#0)
  else
   Result := nil;
 end;
end;

procedure TDbReformer.LockedRecords(aFolder: string; aResult: TStringList);
var
 l_SearchRec: TSearchRec;
 l_FindResult: Integer;
 l_Table: string;
 l_TableHolder: string;
begin
 if aResult = nil then
  Exit;
 aResult.Clear;

 l_FindResult := FindFirst(ConcatDirName(aFolder, '*.HTB'),
                           faAnyFile,
                           l_SearchRec);
 try
  while l_FindResult = 0 do
  begin
   if (l_SearchRec.Attr and (faDirectory or faVolumeID or faSymLink)) = 0 then
   begin
    l_Table := ChangeFileExt(ConcatDirName(aFolder, l_SearchRec.Name), '');
    if RecordsLocked(l_Table, l_TableHolder) then
     aResult.Add('Некоторые записи таблицы ' + l_Table + ' удерживаются станцией ' + l_TableHolder);
   end;
   l_FindResult:=FindNext(l_SearchRec);
  end;
 finally
  FindClose(l_SearchRec);
 end;
end;

 function fn_ClearBadLocks(const aFileName: string;
                           aData: Pointer): Boolean;
 begin
  TDbReformer(aData).ClearBadLocks(aFileName);
  Result := True;
 end;


procedure TDbReformer.ClearAllBadLocks(aFolder: string);
begin
 ProcessFilesWithMask(aFolder,
                      '*.HTB',
                      fn_ClearBadLocks,
                      Self);
end;

procedure TDbReformer.ClearBadLocks(aTable: string);

var
 l_Holder: string;
begin
 if not TableLocked(aTable, l_Holder) and not RecordsLocked(aTable, l_Holder) then
  DeleteFile(ChangeFileExt(aTable, '.HLK'));
end;

function TDbReformer.IsTableCorrect(const aTable: string): Boolean;
begin
 try
 gStopErrRaise := true;
  try
   Result := htTableVerify(PChar(aTable),
                          TablePass(aTable),
                          TablePass(aTable),
                          HTVF_INDEX or HTVF_DUPS or HTVF_NULL) = 0;
  finally
   gStopErrRaise := False;
  end;
 except
  Result:= False;
 end;
end;

procedure TDbReformer.RepairTable(const aTable: string);
var
 l_WrongRecords: Integer;
 l_Pass: PChar;
begin
 l_Pass := ''; //TablePass(aTable);
 htUpdateTable(PChar(aTable), l_Pass, l_Pass, True, False);
 htRepairTableLog(PChar(aTable), l_Pass, l_Pass, 0);
 htUpdateTable(PChar(aTable), l_Pass, l_Pass, True, False);
 l_WrongRecords := htRepairTable(PChar(aTable), l_Pass, l_Pass);
 htUpdateTable(PChar(aTable), l_Pass, l_Pass, True, False);
 if l_WrongRecords > 0 then
  Log(Format('Из таблицы %s вычищено %d поврежденных записей.', [aTable, l_WrongRecords]));
end;

 function fn_RepairTable(const aFileName: string;
                         aData: Pointer): Boolean;
 begin
  TDbReformer(aData).RepairTable(aFileName);
  Result := True;
 end;

procedure TDbReformer.RepairAllTables(const aFolder: string);
begin
 ProcessFilesWithMask(aFolder,
                      '*.HTB',
                      fn_RepairTable,
                      Self);
end;

procedure TDbReformer.ReindexTable(const aTable: string);
var
 l_Pass: PChar;
begin
 l_Pass := TablePass(aTable);
 htUpdateTable(PChar(aTable), l_Pass, l_Pass, True, True);
 Log(Format('Таблица %s переиндексирована.', [aTable]));
end;

 function fn_ReindexTable(const aFileName: string;
                          aData: Pointer): Boolean;
 begin
  TDbReformer(aData).ReindexTable(aFileName);
  Result := True;
 end;

procedure TDbReformer.ReindexAllTables(const aFolder: string);
begin
 ProcessFilesWithMask(aFolder,
                      '*.HTB',
                      fn_ReindexTable,
                      Self);
end;

procedure TDbReformer.Yield(Sender: TObject);
begin
 if Assigned(f_ShowToUserProc) then
  f_ShowToUserProc('');
end;

procedure TDbReformer.DeleteRecords(aTable: string;
                                    aFieldNum: SmallInt;
                                    const aValue);
const
 l_Zero: Integer = 0;
var
 l_TableHandle: Ht_Const.THANDLE;
 l_Records: Sab;
begin
 htTableOpen(PChar(aTable),
             TablePass(aTable),
             TablePass(aTable),
             TAB_PRIVATE,
             l_TableHandle);
 try
  htSearch(nil,
           l_Records,
           l_TableHandle,
           aFieldNum,
           EQUAL,
           @aValue,
           nil);
  try
   htDeleteRecords(l_Records);
  finally
   htClearResults(l_Records);
  end; // htSearch
 finally
  htTableClose(l_TableHandle);
 end; // htTableOpen
end;

function fn_UpdateField(gRecNo: LongInt;
                        fpRecord: Pointer;
                        fpUser: Pointer): MFUNC_RET; {$IFDEF HT_MODE64} stdcall {$ELSE} pascal {$ENDIF};
begin
 l3Move( PChar(PFieldData(fpUser)^.pData)^,
      (PChar(fpRecord) + PFieldData(fpUser)^.Offset)^,
      PFieldData(fpUser)^.Length);
 Result := MFUNC_SUCCESS;
end;

procedure TDbReformer.UpdateRecords(aTable: string;
                                    aFieldNum: SmallInt;
                                    const aOldValue, aNewValue);
var
 l_TableHandle: Ht_Const.THANDLE;
 l_TableStruct: TTableStruct;
 l_Records: Sab;
 l_FieldData: TFieldData;
begin
 htTableOpen(PChar(aTable),
             TablePass(aTable),
             TablePass(aTable),
             TAB_PRIVATE,
             l_TableHandle);
 try
  htSearch(nil,
           l_Records,
           l_TableHandle,
           aFieldNum,
           EQUAL,
           @aOldValue,
           nil);
  try
   l_TableStruct := TTableStruct.Create(aTable);
   try
    l_FieldData.Offset := l_TableStruct.FieldInfos[aFieldNum].wOffset;
    l_FieldData.Length := l_TableStruct.FieldInfos[aFieldNum].wLength;
   finally
    l_TableStruct.Free;
   end;
   l_FieldData.pData := @aNewValue;
   htModifyRecords(l_Records,
                   @fn_UpdateField,
                   nil,
                   @l_FieldData,
                   False);
  finally
   htClearResults(l_Records);
  end; // htSearch
 finally
  htTableClose(l_TableHandle);
 end; // htTableOpen
end;

procedure TDbReformer.InsertRecords(aTable: string;
                                    const aRecords: TTableRecs);
const
 c_Space = ' ';
var
 l_TableHandle: Ht_Const.THANDLE;
 l_TableStruct: TTableStruct;
 l_RecBuffer: array of Char;
// l_FieldData: TFieldData;
 R, F: Integer;
 l_TempLong: Longint;
 l_TempByte: Byte;
 l_TempSmall: Smallint;
 l_TempWord: Word;
 l_TempLongWord: LongWord;
 l_Code: Integer;
begin
 htTableOpen(PChar(aTable),
             TablePass(aTable),
             TablePass(aTable),
             TAB_PRIVATE,
             l_TableHandle);
 try
  l_TableStruct := TTableStruct.Create(aTable);
  try
   SetLength(l_RecBuffer, l_TableStruct.TableInfo.wRecordLen);
   for R := Low(aRecords) to High(aRecords) do
   begin
    l3FillChar(l_RecBuffer[0], Length(l_RecBuffer), Byte(c_Space));
    for F := 1 to l_TableStruct.TableInfo.nFieldCnt do
     if l_TableStruct.FieldInfos[F].cClass = EC_FIELD then
     begin
      case l_TableStruct.FieldInfos[F].cType of
       ET_CHAR:
        l3Move(aRecords[R][F - 1][1],
             l_RecBuffer[l_TableStruct.FieldInfos[F].wOffset],
             Length(aRecords[R][F - 1]));

       ET_LONG:
        begin
         l_TempLong := StrToIntDef(aRecords[R][F - 1], 0);
         l3Move(l_TempLong,
              l_RecBuffer[l_TableStruct.FieldInfos[F].wOffset],
              SizeOf(l_TempLong));
        end;
       ET_BYTE:
        begin
         l_TempByte := StrToIntDef(aRecords[R][F - 1], 0);
         l3Move(l_TempByte,
              l_RecBuffer[l_TableStruct.FieldInfos[F].wOffset],
              SizeOf(l_TempByte));
        end;

       ET_INTR:
        begin
         l_TempSmall := StrToIntDef(aRecords[R][F - 1], 0);
         l3Move(l_TempSmall,
              l_RecBuffer[l_TableStruct.FieldInfos[F].wOffset],
              SizeOf(l_TempSmall));
        end;

       ET_WORD,
       ET_DATE:
        begin
         l_TempWord := StrToIntDef(aRecords[R][F - 1], 0);
         l3Move(l_TempWord,
              l_RecBuffer[l_TableStruct.FieldInfos[F].wOffset],
              SizeOf(l_TempWord));
        end;

       ET_DWRD:
        begin
         Val(aRecords[R][F - 1], l_TempLongWord, l_Code);
         if l_Code <> 0 then
          l_TempLongWord := 0;
         //l_TempLongWord := StrToIntDef(aRecords[R][F - 1], 0);
         l3Move(l_TempLongWord,
              l_RecBuffer[l_TableStruct.FieldInfos[F].wOffset],
              SizeOf(l_TempLongWord));
        end;
      end; // case
     end; // for
     if htRecordAdd(l_TableHandle, l_RecBuffer) < 0 then
       Break;
   end; // for

  finally
   l_TableStruct.Free;
  end;

 finally
  htTableClose(l_TableHandle);
 end; // htTableOpen

 htUpdateTable(PChar(aTable),
               TablePass(aTable),
               TablePass(aTable),
               True,
               True);
end;

 function fn_SetNull(gRecNo: LongInt;
                     fpRecord: Pointer;
                     fpUser: Pointer): MFUNC_RET; {$IFDEF HT_MODE64} stdcall {$ELSE} pascal {$ENDIF};
 begin
 with PFieldData(fpUser)^ do
  l3Move(PChar(pData)^,
       (PChar(fpRecord) + Offset)^,
       Length);
  Result := MFUNC_SUCCESS;
 end;

procedure TDbReformer.AddAccessGroups;
var
 l_Table: TAbsHtTbl;
 l_ID: Integer;
 l_Name: String;
begin
 l_Table:= TAbsHtTbl.CreateWithOpen(FamilyFolder, TablePassword(CurrentFamily, ord(cDLPassports[da_dlAccGroups].rDict)), TableName(CurrentFamily, Ord(cDLPassports[da_dlAccGroups].rDict)), 0);
 try
  l_Table.ClearFullRec;
  l_ID:= 1;
  l_Table.PutToFullRec(1, l_ID);
  l_Name:= 'Неподключенные элементы';
  l_Table.PutToFullRec(2, l_Name);
  l_Name:= 'NOTINCL';
  l_Table.PutToFullRec(4, l_Name);
  l_Table.AddFRec;
  l_Table.ClearFullRec;
  l_ID:= 2;
  l_Table.PutToFullRec(1, l_ID);
  l_Name:= 'Подключенные элементы';
  l_Table.PutToFullRec(2, l_Name);
  l_Name:= 'INCL';
  l_Table.PutToFullRec(4, l_Name);
  l_Table.AddFRec;
  l_Table.ClearFullRec;
  l_ID:= 3;
  l_Table.PutToFullRec(1, l_ID);
  l_Name:= 'Словари';
  l_Table.PutToFullRec(2, l_Name);
  l_Name:= 'DICT';
  l_Table.PutToFullRec(4, l_Name);
  l_Table.AddFRec;
  l_Table.ClearFullRec;
  l_ID:= 4;
  l_Table.PutToFullRec(1, l_ID);
  l_Name:= 'Этапы';
  l_Table.PutToFullRec(2, l_Name);
  l_Name:= 'STAGE';
  l_Table.PutToFullRec(4, l_Name);
  l_Table.AddFRec;
 finally
  l3fRee(l_Table);
 end;
end;

procedure TDbReformer.AddDefaultValues(aDicts: TDLTypeSet; aWithUsers: Boolean);
begin
 if not (da_dlAccGroups in aDicts) then
  AddAccessGroups;
 if not aWithUsers then
  AddUsers;
end;

procedure TDbReformer.AddUsers;
var
 l_Users, l_Pass, l_GULink, l_GUDT: TAbsHtTbl;
 l_ID: Integer;
 l_Name: String;
 l_Password: String;
begin
 l_Password := TablePassS(ConcatDirName(MainFolder, 'users.htb'));
 l_Users:= TAbsHtTbl.CreateWithOpen(MainFolder, l_Password, 'users', 0);
 try
  l_Password := TablePassS(ConcatDirName(MainFolder, 'pass.htb'));
  l_Pass:= TAbsHtTbl.CreateWithOpen(MainFolder, l_Password, 'pass', 0);
  try
   l_Password := TablePassS(ConcatDirName(MainFolder, 'gulnk.htb'));
   l_GULink:= TAbsHtTbl.CreateWithOpen(MainFolder, l_Password, 'gulnk', 0);
   try
    l_Password := TablePassS(ConcatDirName(MainFolder, 'gudt.htb'));
    l_GUDT:= TAbsHtTbl.CreateWithOpen(MainFolder, l_Password, 'gudt', 0);
    try
     // Группы пользователей
     l_Gudt.ClearFullRec;
     l_ID:= 1;
     l_Gudt.PutToFullRec(1, l_ID);
     l_Name:= 'Административная';
     l_Gudt.PutToFullRec(2, l_Name);
     l_ID:= Length(l_Name);
     l_Gudt.PutToFullRec(3, l_ID);
     l_Gudt.AddFRec;
     { TODO 1 -oДмитрий Дудко -cНедоделка : Задать права доступа на псевдогруппы документов. }
     // Пользователи
     l_Users.ClearFullRec;
     l_ID:= usSupervisor;
     l_Users.PutToFullRec(1, l_ID);
     l_Name:= 'Супервизор';
     l_Users.PutToFullRec(2, l_Name);
     l_ID:= Length(l_Name);
     l_Users.PutToFullRec(3, l_ID);
     l_ID:= 1;
     l_Users.PutToFullRec(4, l_ID);
     l_Users.AddFRec;
     l_GULink.ClearFullRec;
     l_ID:= 1;
     l_GULink.PutToFullRec(1, l_ID);
     l_ID:= 1;
     l_GULink.PutToFullRec(2, l_ID);
     l_GULink.AddFRec;
     l_Pass.ClearFullRec;
     l_Name:= 'SUPERVISOR';
     l_PAss.PutToFullRec(1, l_Name);
     l_Name:= 'ADMIN';
     l_Pass.PutToFullRec(2, l_Name);
     l_ID:= 1;
     l_Pass.PutToFullRec(3, l_ID);
     l_Pass.AddFRec;

     l_Users.ClearFullRec;
     l_ID:= usServerService;
     l_Users.PutToFullRec(1, l_ID);
     l_Name:= 'Сервер автоматизации';
     l_Users.PutToFullRec(2, l_Name);
     l_ID:= Length(l_Name);
     l_Users.PutToFullRec(3, l_ID);
     l_ID:= 1;
     l_Users.PutToFullRec(4, l_ID);
     l_Users.AddFRec;
     l_GULink.ClearFullRec;
     l_ID:= usServerService;
     l_GULink.PutToFullRec(1, l_ID);
     l_ID:= 1;
     l_GULink.PutToFullRec(2, l_ID);
     l_GULink.AddFRec;
     l_Pass.ClearFullRec;
     l_Name:= 'AUTOLOAD';
     l_PAss.PutToFullRec(1, l_Name);
     l_Name:= 'AUTOLOAD';
     l_Pass.PutToFullRec(2, l_Name);
     l_ID:= usServerService;
     l_Pass.PutToFullRec(3, l_ID);
     l_Pass.AddFRec;
    finally
     l3Free(l_GUDt);
    end;
   finally
    l3Free(l_GULink);
   end;
  finally
   l3Free(l_Pass);
  end;
 finally
  l3Free(l_Users);
 end;
end;

procedure TDbReformer.CorrectFreeTables;
begin
 CorrectFamilyFreeTable;
 Log('Свободные номера в базе документов скорректированы');
 CorrectAdminFreeTable;
 Log('Свободные номера в административной базе скорректированы');
end;

procedure TDbReformer.CorrectFamilyFreeTable;
var
 l_Index: TdaDictionaryType;
 l_Free : TdbFreeTable;
 l_TableName: String;
 l_Password : PChar;
 l_List: Tl3RecList;
begin
 // Корректирует последний свободный номер в папках семейства и административной
 l_TableName := TableName(CurrentFamily, Ord(ftFree));
 l_Password := TablePass(FamilyFolder + l_TableName +'.htb');
 l_Free := TdbFreeTable.CreateWithOpen(FamilyFolder, IfThen(l_Password = nil, '', String(l_Password)), l_TableName, 0);
 try
  l_Free.TableFamily := CurrentFamily;
  l_List:= Tl3RecList.Create(SizeOf(TFreeRec));
  try
   LoadDiapasons(l_Free, l_List);
   l_Free.DropTblData;
   for l_Index:= Low(cDLPassports) to High(cDLPassports) do
   // if l_Index <> dlAutoClasses then
    if cDLPassports[l_Index].rDict <> ftNone then
     CorrectMaxID(FamilyFolder, TableName(CurrentFamily, Ord(cDLPassports[l_Index].rDict)), 1, l_Free);
   CorrectMaxID(FamilyFolder, TableName(CurrentFamily, Ord(ftRenum)), 1, l_Free, MAX_DWRD, TableName(CurrentFamily, Ord(ftFile)));
   CorrectMaxID(FamilyFolder, TableName(CurrentFamily, Ord(ftHLink)), 1, l_Free);
   SaveDiapasons(l_Free, l_List);
  finally
   l3Free(l_List);
  end;
 finally
  l3Free(l_Free);
 end;
end;

procedure TDbReformer.CorrectAdminFreeTable;
var
 l_Free : TdbFreeTable;
 l_TableName: String;
 l_Password : String;
 l_Index: TMainTbls;
begin
 l_TableName := 'free';
 l_Password := TablePassS(MainTable(l_TableName) +'.htb');
 l_Free := TdbFreeTable.CreateWithOpen(l3AddBackSlashL(MainFolder), l_Password, l_TableName, 0);
 try
  l_FRee.TableFamily:= MainTblsFamily;
  l_Free.DropTblData;
  CorrectMaxID(MainFolder, MainTblNames[mtGUDt], 1, l_Free);
  // USERS содержит номера с учетом кода региона, а FREE - без него!!!
  CorrectMaxID(MainFolder, MainTblNames[mtUsers], 1, l_Free, cMaxUserID);
  CorrectMaxID(MainFolder, MainTblNames[mtFamily], 1, l_Free);
 finally
  l3Free(l_Free);
 end;
end;

procedure TDbReformer.DropTableDirect(const aFullTableName: string);
begin
 DeleteFilesByMask(ExtractFilePath(aFullTableName), ExtractFileName(aFullTableName)+'.H*');
end;

procedure TDbReformer.VerifyReferences(aFolderFrom: TFamilyFolder; const aTableFrom: string; aFieldNumFrom: SmallInt;
                                       aFolderTo: TFamilyFolder; const aTableTo: string; aFieldNumTo: SmallInt;
                                       aRepairKind: TRepairKind = rkIgnore);
const
 l_Zero: Integer = 0;
 l_NullValue: LongWord = 0;
var
 l_TableFrom: string;
 l_TableTo: string;
 l_HandleTo,
 l_HandleFrom: HT_Const.THANDLE;
 l_RecsTo,
 l_RecsFrom,
 l_ValuesFrom,
 l_ValuesTo,
 l_Not_ValuesTo,
 l_Bad_ValuesFrom,
 l_BadRecsFrom: Sab;
 l_Buffer: LongWord;
 l_Value: Int64;
 l_ValueLen: Cardinal;
 l_FieldData: TFieldData;
 l_TableFrom_Struct: TTableStruct;
 l_TableFrom_Repaired: Boolean;
 l_TmpSab, l_NullValueSab: Sab;

 procedure TreatBadRecs;
 var
  l_FieldInfo: HT_Const.ThtElementInfo{ELEMENT};
 begin
  l_FieldInfo := l_TableFrom_Struct.FieldInfos[aFieldNumFrom];

  if l_Bad_ValuesFrom.nRetCode < 0 then
   raise Exception.Create('Проблема с проверкой ' + aTableFrom);

  htOpenResults(l_Bad_ValuesFrom, ROPEN_READ, nil, 0);
  try
   htResultsItemLen(l_Bad_ValuesFrom, l_ValueLen);
   l_Buffer := 0;
   Log('Неверные значения ' + aTableFrom + '.' + StrPas(@l_FieldInfo.mName[0]) + ' (' + IntToStr(l_Bad_ValuesFrom.gFoundCnt) + ' шт.) :', False);
   while htReadResults(l_Bad_ValuesFrom, @l_Buffer, l_ValueLen) <> 0 do
   begin
    case l_FieldInfo.cType of
      ET_BYTE: l_Value := PByte(@l_Buffer)^;
      ET_INTR: l_Value := PSmallint(@l_Buffer)^;
      ET_WORD: l_Value := PWord(@l_Buffer)^;
      ET_DWRD: l_Value := PLongWord(@l_Buffer)^;
    else
     l_Value := 0;
    end;
    Log(#9 + IntToStr(l_Value), False);
   end; // while
  finally
   htCloseResults(l_Bad_ValuesFrom);
  end;
 end;

begin
 l_TableFrom_Repaired := False;
 l_TableFrom := FullTableName(aFolderFrom, aTableFrom);
 l_TableTo := FullTableName(aFolderTo, aTableTo);
 htTableOpen(PChar(l_TableTo),
             TablePass(l_TableTo),
             TablePass(l_TableTo),
             TAB_PRIVATE,
             l_HandleTo);
 try
  if aTableFrom = aTableTo then
   l_HandleFrom := l_HandleTo
  else
  htTableOpen(PChar(l_TableFrom),
              TablePass(l_TableFrom),
              TablePass(l_TableFrom),
              TAB_PRIVATE,
              l_HandleFrom);
  try
   htSearch(nil, l_RecsTo, l_HandleTo, 0, GREAT, @l_Zero, nil);
   try
    htSearch(nil, l_RecsFrom, l_HandleFrom, 0, GREAT, @l_Zero, nil);
    try
     // Все значения FROM.RefId
     htValuesOfKey(l_ValuesFrom, aFieldNumFrom, l_RecsFrom);
     try
      // Все значения TO.Id
      htValuesOfKey(l_ValuesTo, aFieldNumTo, l_RecsTo);

      // Вставка пустого значения
      htCreateEmptySAB(@l_ValuesTo, l_NullValueSab, l_HandleTo, aFieldNumTo, RES_VALUE);
      try
       htOpenResults(l_NullValueSab, ROPEN_READ, nil, 0);
       try
        htIncludeResultsItem(l_NullValueSab, 0, @l_NullValue);
       finally
        htCloseResults(l_NullValueSab);
       end;
       htOrResults(l_TmpSab, l_NullValueSab, l_ValuesTo);
       htClearResults(l_ValuesTo);
       l_ValuesTo := l_TmpSab;
      finally
       htClearResults(l_NullValueSab);
      end;
      // ----
      try
       // NOT {TO.Id}
       htTransferToPhoto(l_ValuesTo, l_ValuesFrom, aFieldNumFrom);
       htNotResults(l_Not_ValuesTo, l_ValuesTo);
       try
        // FROM.RefId AND (NOT {DT.Id})
        htAndResults(l_Bad_ValuesFrom, l_ValuesFrom, l_Not_ValuesTo);
        try
         // найденные кривые записи
         htRecordsByKey(l_BadRecsFrom, l_Bad_ValuesFrom);
         try
          //////////////////////////////////////////////////////////////////////
          if (l_BadRecsFrom.gFoundCnt > 0) then
          begin
           l_TableFrom_Struct := TTableStruct.Create(aTableFrom);
           try
            TreatBadRecs;

            // удаление таких записей
            case aRepairKind of
             rkIgnore:
              begin
               {ничего не делаем};
               Log('Записи с неверными значениями (' + IntToStr(l_BadRecsFrom.gFoundCnt) + ' шт.) оставлены как есть.', False);
              end;
             rkDeleteLink:
              begin
               htDeleteRecords(l_BadRecsFrom);
               Log('Записи с неверными значениями (' + IntToStr(l_BadRecsFrom.gFoundCnt) + ' шт.) удалены.', False);
               l_TableFrom_Repaired := True;
              end;
             rkClearRef:
              begin
               l_FieldData.Offset := l_TableFrom_Struct.FieldInfos[aFieldNumFrom].wOffset;
               l_FieldData.Length := l_TableFrom_Struct.FieldInfos[aFieldNumFrom].wLength;
               l_FieldData.pData  := @l_NullValue;

               htModifyRecords(l_BadRecsFrom, @fn_SetNull, nil, @l_FieldData, False);
               Log('Записи с неверными значениями (' + IntToStr(l_BadRecsFrom.gFoundCnt) + ' шт.) исправлены.', False);
               l_TableFrom_Repaired := True;
              end;
            end;
            Log(' ', False);
           finally
            l_TableFrom_Struct.Free;
           end;
          end;
          //////////////////////////////////////////////////////////////////////
         finally
          htClearResults(l_BadRecsFrom);
         end;
        finally
         htClearResults(l_Bad_ValuesFrom);
        end;
       finally
        htClearResults(l_Not_ValuesTo);
       end;
      finally
       htClearResults(l_ValuesTo);
      end;
     finally
      htClearResults(l_ValuesFrom);
     end;
    finally
     htClearResults(l_RecsFrom);
    end;
   finally
    htClearResults(l_RecsTo);
   end;
  finally
   if aTableFrom <> aTableTo then
    htTableClose(l_HandleFrom);
  end;
 finally
  htTableClose(l_HandleTo);
 end;
 if l_TableFrom_Repaired then
  htUpdateTable(PChar(l_TableFrom), TablePass(l_TableFrom), TablePass(l_TableFrom), True, True);
end;

function TDbReformer.FullTableName(aTableFolder: TFamilyFolder;
                                   const aShortName: string): string;
begin
 case aTableFolder of
  ffMain:   Result := MainTable(aShortName);
  ffGarant: Result := FamilyTable(aShortName);
 end;
end;

function TDbReformer.FullTableName(aFamily: TFamilyID; aTblID: Integer): string;
begin
 if aFamily = MainTblsFamily then
  Result := MainTable(TableName(aFamily, aTblID))
 else
  Result := FamilyTable(TableName(aFamily, aTblID));
end;

procedure TDbReformer.CorrectMaxID(theFolder, theTableName: String; theIDField: Integer; theFree: TdbFreeTable;
    theMaxValue: Longword = MAX_DWRD; const theFreeName: String = '');
var
 l_Table: TAbsHtTbl;
 l_Password, l_TableName: String;
 l_SAB: TSAB;
 i, l_IntervalCount: Longint;
 l_Rec: TFreeRec;
 l_List: Tl3LongintList;
 l_From, l_To: longword;
 l_IsUsers: Boolean;
begin
 if theFolder <> '' then
 begin
  l_Password := TablePassS(l3AddBackSlashL(theFolder) + theTableName + '.htb');
  l_TableName:= IfThen(theFreeName = '', theTableName, theFreeName);
  Log('Вычисление максимального элемента в '+l_TableName);
  theFree.AddInterval(l_TableName, 1, theMaxValue);
  l_Table:= TAbsHtTbl.CreateWithOpen(l3AddBackSlashL(theFolder), l_Password, theTableName, 0);
  try
   l_IsUsers := theTableName = MainTblNames[mtUsers]; // для USERS особая обработка
   // Вычисляем максимум
   l_SAB := TSAB.Make(l_Table, nil);
   try
    l_SAB.SelectAll;
    l_SAB.ValuesOfKey(theIDField);
    l_List := Tl3LongintList.makeSorted;
    try
     dtCopyValuesSabToList(l_SAB.HTSab, l_List);

     if l_IsUsers then
     begin
      l_List.Sorted := False;
      for I := 0 to Pred(l_List.Count) do
      begin
       l_List.Items[i]:= GetRealUserID(LongWord(l_List.Items[i]), theMaxValue);
       Random;
      end; 
      l_List.Sorted := True;
     end;

     if l_List.Count > 0 then // Выкидываем все номера вне диапазона
     begin
      i:= 0;
      while i < l_List.Count do
      begin
       if (l_List.Items[i] > theMaxValue) then
        l_List.Delete(i)
       else
        Inc(i);
      end; // while i < l_List.Count
      // Формируем интервалы
      l_From:= 1; l_To:= 1; l_IntervalCount:= 0;
      for i:= 0 to l_List.Hi do
      begin
       if (l_List.Items[i] - l_To) > 1 then
       begin
        if l_IntervalCount > c_MaxIntervalPerTable then
        begin
         theFree.ExcludeFreeNumsFromTable(l_TableName, l_List);
         break;
        end;
        theFree.ExcludeFreeNumsFromTable(l_TableName, l_From, l_To);
        l_From:= l_List.Items[i];
        l_To:= l_List.Items[i];
        Inc(l_IntervalCount);
        Application.ProcessMessages;
       end
       else
        l_To:= l_List.Items[i]
      end; // for i
      if l_IntervalCount <= c_MaxIntervalPerTable then
       theFree.ExcludeFreeNumsFromTable(l_TableName, l_From, l_To);
     end;
    finally
     l3Free(l_List);
    end;
   finally
    l3FRee(l_SAB);
   end;
  finally
   l3Free(l_Table);
  end;
 end; // DictionTblNames[l_Index] <> '';
end;

function TDbReformer.GetRealUserID(aUserID, aMaxID: longword): Integer;
begin
 if aUserID > aMaxID then
  Result := aUserID and $00FFFFFF
 else
  Result:= aUserID;
end;

procedure TDbReformer.LoadDiapasons(aFreeTable: TdbFreeTable; aList: Tl3RecList);
begin
 aFreeTable.GetIntervalList(ftnDocIDExternal, aList);
 aFreeTable.GetIntervalList(ftnDocIDForLists, aList);
 aFreeTable.GetIntervalList(ftnDocIDLawCase, aList);
 aFreeTable.GetIntervalList(ftnDocIDVAS, aList);
 aFreeTable.GetIntervalList(ftnDocID1st, aList);
 aFreeTable.GetIntervalList(ftnDocIDFAS1, aList);
 aFreeTable.GetIntervalList(ftnDocIDFAS2, aList);
 aFreeTable.GetIntervalList(ftnDocIDFAS3, aList);
 aFreeTable.GetIntervalList(ftnDocIDFAS4, aList);
 aFreeTable.GetIntervalList(ftnDocIDFAS5, aList);
 aFreeTable.GetIntervalList(ftnDocIDFAS6, aList);
 aFreeTable.GetIntervalList(ftnDocIDFAS7, aList);
 aFreeTable.GetIntervalList(ftnDocIDFAS8, aList);
 aFreeTable.GetIntervalList(ftnDocIDFAS9, aList);
 aFreeTable.GetIntervalList(ftnDocIDFAS10, aList);
 aFreeTable.GetIntervalList(ftnImgHandle, aList);
end;

procedure TDbReformer.RestructTable(const aTableName: string; const aFamily: TFamilyFolder; aRestructProc:
    TStructChangeProc; aData: Pointer = nil);
var
 l_TblName: string;
 l_TempName: string;
begin
 case aFamily of
  ffMain:
   begin
    l_TblName := MainTable(aTableName);
    l_TempName := MainTable(TEMP_TABLE);
   end;
  ffGarant:
   begin
    l_TblName := FamilyTable(aTableName);
    l_TempName := FamilyTable(TEMP_TABLE);
   end;
 end;

 Log('Создание пустой таблицы ' + aTableName + ' с новой структурой.');
 CopyTableStruct(l_TblName, l_TempName, aRestructProc, aData);

 Log('Копирование данных из старой таблицы ' + aTableName + ' в новую.');
 CopyData(l_TblName, l_TempName);

 Log('Удаление старой таблицы ' + aTableName + ' .');
 htDropTable(PChar(l_TblName), TablePass(l_TblName), TablePass(l_TblName));

 Log('Переименование новой таблицы в ' + aTableName + ' .');
 htTableRename(PChar(l_TempName), TablePass(l_TempName), TablePass(l_TempName), PChar(l_TblName));
end;

function TDbReformer.RenameTableDirect(aFullTableName, aNewName: string): Boolean;
var
 l_OldNameMask: string;
 l_NewNamePig: string;
 l_SearchRec: TSearchRec;
 l_FindResult: Integer;
 l_OldDir: string;
begin
 Result := True;
 l_OldDir := ExtractFilePath(aFullTableName);
 l_OldNameMask := l_OldDir+ExtractFileName(aFullTableName)+'.H*';
 l_NewNamePig := ExtractFilePath(aNewName)+ExtractFileName(aNewName);
 l_FindResult := FindFirst(l_OldNameMask, faAnyFile, l_SearchRec);
 try
  while Result and (l_FindResult = 0) do
  begin
   if (l_SearchRec.Attr and (faDirectory or faVolumeID or faSymLink)) = 0 then
    Result := RenameFileSafe(l_OldDir + l_SearchRec.Name, l_NewNamePig + ExtractFileExt(l_SearchRec.Name));
   l_FindResult:=FindNext(l_SearchRec);
  end;
 finally
  FindClose(l_SearchRec);
 end;
end;

procedure TDbReformer.ReplaceLinks(aTable: TFamTbls; aOldValue, aNewValue: Integer);
var
 l_Table: TdtTable;
 l_Sab: ISab;
 l_Password: PChar;
 l_TableName: String;
begin
 // Замена ссылок на элементы словаря
 l_TableName:=  TableName(CurrentFamily, Ord(aTable));
 l_Password := TablePass(l_TableName);
 l_Table:= TdtTable.CreateWithOpen(FamilyFolder, IfThen(l_Password = nil, '', String(l_Password)), l_TableName, 0);
 try
  l_Sab:= MakeSab(l_Table);
  l_Sab.Select(lnkDictIDFld, aOldValue);
  l_Sab.ModifyRecs(lnkDictIDFld, aNewValue, True);
 finally
  l3Free(l_Table);
 end;
end;

function TDbReformer.CreateOpenFamilyTable(aTbl : TFamTbls) : TdtTable;
var
 l_Password: PChar;
 l_TableName: String;
begin
 l_TableName:=  TableName(CurrentFamily, Ord(aTbl));
 l_Password := TablePass(ConcatDirName(FamilyFolder, l_TableName));
 Result := TdtTable.CreateWithOpen(FamilyFolder, IfThen(l_Password = nil, '', String(l_Password)), l_TableName, TAB_SHARE);
end;

procedure TDbReformer.RecoverSortDate;

type
 pAccRec = ^TAccRec;
 TAccRec = packed record
  rSurrKey : Cardinal;
  rDoc   : Cardinal;
  rSDate : TstDate;
  rDate  : TstDate;
 end;


var
 l_Password: PChar;
 l_TableName: String;

 l_MainTable: TdtTable;
 l_lnkTable: TdtTable;
 l_DictTable: TdtTable;

 l_lnkSab: ISab;
 l_DictSab: ISab;
 l_MainSab: ISab;
 l_Lnk_DictSab: IJoinSab;
 l_Doc_lnkSab: IJoinSab;
 l_ResSab: IJoinSab;

 lSaveDocID : TstDate;
 lSaveRec : TAccRec;
 lCurRec : TAccRec;

 lFldChanger : TIntFieldChanger;


 procedure WriteRec(aPrefix : string; const aRec : TAccRec);
 begin
   if aRec.rDate <> aRec.rSDate then
    lFldChanger.Add(aRec.rSurrKey, aRec.rDate);
    //l3System.Msg2Log('%s %d: %s -> %s', [aPrefix, aRec.rDoc, l3DateToStr(aRec.rSDate), l3DateToStr(aRec.rDate)])
   {else
    l3System.Msg2Log('EQ %s %d: %s -> %s', [aPrefix, aRec.rDoc, l3DateToStr(aRec.rSDate), l3DateToStr(aRec.rDate)])
   }
 end;

function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 begin
  Result := True;
  lCurRec := pAccRec(aItemPtr)^;

  //if lSaveDocID = lCurRec.rDoc then // этот док уже обработан
  //begin
  // WriteRec('pass', lCurRec);
  // Exit;
  //end;

  if (lSaveDocID < lCurRec.rDoc)  then
  begin
  // if lCurRec.rDate = 0 then
  //  lSaveRec := lCurRec;

   if lSaveRec.rDoc > 0 then // есть сохраненная
   begin
    if lSaveRec.rDoc = lCurRec.rdoc then // от того же дока
    begin
     // стираем сохраненную
     lSaveRec.rDoc := 0;
    end
    else // от от другого дока
    begin
     // пишем сохраненную
     WriteRec('', lSaveRec);
     // стираем сохраненную
     lSaveRec.rDoc := 0;
    end
   end; // обработали сохраненную

   if lCurRec.rDate = 0 then
   begin
    lSaveRec := lCurRec; // сохраняем
   end
   else
   begin
    WriteRec('', lCurRec);
    // ставим флаг что этот док обработан
    lSaveDocID := lCurRec.rDoc;
   end;
  end; //if (lSaveDocID < lCurRec.rDoc)  then
 end;

 var
  lSab        : ISab;
  lRAProcStub : TdtRecAccessProc;
  lValue : DWORD;

begin
 lSaveDocID := 0;
 lSaveRec.rDoc := 0;

 l_MainTable:= CreateOpenFamilyTable(ftFile);
 try
  l_MainSab:= MakeSab(l_MainTable);
  l_MainSab.SelectAll;
  //l_MainSab.Sort([fId_Fld]);

  l_LnkTable:= CreateOpenFamilyTable(ftLnk7);
  try
   l_LnkSab:= MakeSab(l_LnkTable);
   l_LnkSab.SelectAll;
   //l_MainSab.Sort([fId_Fld]);

   l_Doc_LnkSab := MakeJoinSab(l_MainSab, fId_Fld,
                                l_LnkSab, lnkDocIDFld);

   l_DictTable:= CreateOpenFamilyTable(ftDt7);
   try
    l_DictSab:= MakeSab(l_DictTable);
    lValue := ord(dnPublish);
    l_DictSab.Select(dnTypFld, lValue);

    l_Lnk_DictSab := MakeJoinSab(l_LnkSab, lnkDictIDFld,
                                 l_DictSab, dnIDFld);

    l_ResSab := MakeJoinSab(l_Doc_LnkSab, l_Lnk_DictSab, True{aSkipLink});


    l_ResSab.SortJoin([JFRec(l_MainTable, fId_Fld), JFRec(l_DictTable, dnDateFld)]);

    lFldChanger := TIntFieldChanger.create(l_MainTable, fSDate_Fld);
    try
     lRAProcStub := L2RecAccessProc(@lRecAccessProc);
     try
      l_ResSab.IterateJoinRecords(lRAProcStub, [JFRec(l_MainTable, 0 {surrogate}), JFRec(l_MainTable, fId_Fld), JFRec(l_MainTable, fSDate_Fld), JFRec(l_DictTable, dnDateFld)]);
     finally
      FreeRecAccessProc(lRAProcStub);
     end;

     Log(format('Найдено %d записей', [lFldChanger.Count]));
     lFldChanger.Apply;
    finally
     l3Free(lFldChanger);
    end;
   finally
    l3Free(l_DictTable);
   end;
  finally
   l3Free(l_LnkTable);
  end;
 finally
  l3Free(l_MainTable);
 end;
end;

procedure OutJoinSabToTable(aNewTableName : string; aSab : IJoinSab; aElemNum : array of TJoinFieldRec);
var
 lStruct: TElemArray;
 lTable : TdtTable;
 lSabCursor : ISabCursor;
 I : integer;
 l_DstHandle: HT_Const.THANDLE;
 lOffset  : word;
begin
 lOffset := 0;
 SetLength(lStruct, Length(aElemNum));
 for I := 0 to pred(Length(aElemNum)) do
 begin
  lStruct[I] := aElemNum[I].rTable.GetElement(aElemNum[I].rField);
  lStruct[I].cKey := EK_NOTKEY;
  lStruct[I].wOffset := lOffset;
  Inc(lOffset, lStruct[I].wLength);

  //lStruct[I].mName := PAnsiChar(format('F%d'#0, [I]));
  l3StringToArray(lStruct[I].mName, Length(lStruct[I].mName), format('F%d'#0, [I]));

  //wLength: Word;              (* Длина элемента *)
  //wOffset: Word;              (* Смещение элемента в записи *)
  //cClass : Byte;              (* Класс элемента *)
  //cType  : Byte;              (* Тип элемента   *)
  //cKey   : Byte;              (* Пpизнак ключа  *)
  //mName  : Array[0..FNAME_LEN] of AnsiChar; (* Имя элемента (ASCIIZ строка) *)
 end;


 htTableCreate(PChar(aNewTableName),
               HT_Const.LPELEMENT(lStruct),
               Length(lStruct),
               nil,
               nil, //aPassword,
               nil, //aPassword,
               TAB_CREATE or TAB_SHARE or TAB_ANSI,
               l_DstHandle);

 htTableClose(l_DstHandle);

 SetLength(lStruct, 1);
 with lStruct[0] do
 begin
  wLength := 2;              (* Длина элемента *)
  wOffset := 2;              (* Смещение элемента в записи *)
  cClass  := EC_GROUP;       (* Класс элемента *)
  cType   := ET_LONG;        (* Тип элемента   *)
  cKey    := EK_COMMON;      (* Пpизнак ключа  *)
  mName   := 'keyGroup';     (* Имя элемента (ASCIIZ строка) *)
 end;

 HT(htTableAgregateAppend(
      PAnsiChar(aNewTableName),  (* Имя таблицы (можно без расширения) *)
      nil,                           //fpReadPswd:  PAnsiChar;    (* Пароль для доступа на чтение *)
      nil,                           //fpWritePswd: PAnsiChar;    (* Пароль для доступа на запись *)
      HT_Const.LPELEMENT(lStruct),   //HT_Const.LPELEMENT(lStruct),
      Length(lStruct)                //nAgreCnt:    SmallInt  (* Число элементов *)
  ));



 lTable := TdtTable.CreateWithOpen(ExtractFileDir(aNewTableName), ''{TablePass}, ExtractOnlyFileName(aNewTableName), TAB_SHARE);
 try
  lSabCursor := aSab.MakeJoinSabCursor(aElemNum);
  lTable.CopyRecs(lSabCursor, nil);
  lTable.CloseTbl;
 finally
  l3Free(lTable);
 end;

 htUpdateTable(PAnsiChar(aNewTableName),
               '', //TablePass(aTable),
               '', //TablePass(aTable),
               True,
               True);
end;

procedure TDbReformer.RecoverPriority;
type
 pAccRec = ^TAccRec;
 TAccRec = packed record
  rSurrKey   : Cardinal;
  rDoc       : Cardinal;
  rPrior     : Word;
  rPriorCalc : Word;
 end;

var
 l_Lnk1Table : TdtTable;
 l_Lnk2Table : TdtTable;
 l_Lnk12Table : TdtTable;

 l_Lnk1Sab   : ISab;
 l_Lnk2Sab   : ISab;
 l_Lnk12Sab  : IJoinSab;

 l_PriorTable : TdtTable;
 l_PriorSab   : ISab;

 l_DocTable : TdtTable;
 l_DocSab   : ISab;

 l_TempTable : TdtTable;
 l_TempSab   : ISab;


 lTempTableName : AnsiString;

 l_DocTempSab  : IJoinSab;
 l_TempPriorSab  : IJoinSab;
 l_DocPriorSab  : IJoinSab;

 lSaveDocID : Cardinal;
 lFldChanger : TIntFieldChanger;
 lRAProcStub : TdtRecAccessProc;
 lVal : integer;

 procedure WriteRec(aPrefix : string; const aRec : TAccRec);
 begin
   if aRec.rPrior <> aRec.rPriorCalc then
    lFldChanger.Add(aRec.rSurrKey, aRec.rPriorCalc);
    //l3System.Msg2Log('%s %d: %d -> %d', [aPrefix, aRec.rDoc, aRec.rPrior, aRec.rPriorCalc])
   //else
   // l3System.Msg2Log('EQ %s %d: %d -> %d', [aPrefix, aRec.rDoc, aRec.rPrior, aRec.rPriorCalc])

 end;

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 var
  lCurRec : TAccRec;
 begin
  Result := True;
  lCurRec := pAccRec(aItemPtr)^;

  {if lSaveDocID = lCurRec.rDoc then // этот док уже обработан
  begin
   WriteRec('pass', lCurRec);
   Exit;
  end;}

  if (lSaveDocID < lCurRec.rDoc)  then
  begin
   // пишем сохраненную
   WriteRec('', lCurRec);
   // ставим флаг что этот док обработан
   lSaveDocID := lCurRec.rDoc;
  end; //if (lSaveDocID < lCurRec.rDoc)  then
 end;


begin
 lTempTableName := ConcatDirName(f_DirTemp, 'tbl12');

 l_Lnk1Table:= CreateOpenFamilyTable(ftLnk1);
 try
  l_Lnk1Sab:= MakeSab(l_Lnk1Table);
  l_Lnk1Sab.SelectAll;
  //l_Lnk1Sab.Select(lnkDocIDFld, lSaveDocID);

  l_Lnk2Table:= CreateOpenFamilyTable(ftLnk2);
  try
   l_Lnk2Sab:= MakeSab(l_Lnk2Table);
   l_Lnk2Sab.SelectAll;
   //l_Lnk2Sab.Select(lnkDocIDFld, lSaveDocID);

   l_Lnk12Sab := MakeJoinSab(l_Lnk1Sab, lnkDocIDFld,
                             l_Lnk2Sab, lnkDocIDFld);

   OutJoinSabToTable(lTempTableName, l_Lnk12Sab, [JFRec(l_Lnk1Table, lnkDocIDFld), JFRec(l_Lnk1Table, lnkDictIDFld), JFRec(l_Lnk2Table, lnkDictIDFld)]);

   l_Lnk12Sab := nil;
   l_Lnk1Sab  := nil;
   l_Lnk2Sab  := nil;
  finally
   l3Free(l_Lnk2Table);
  end;
 finally
  l3Free(l_Lnk1Table);
 end;

 lSaveDocID := 0;
 l_TempTable := TdtTable.CreateWithOpen(ExtractFileDir(lTempTableName), ''{TablePass}, ExtractOnlyFileName(lTempTableName), TAB_PRIVATE);
 try
  l_TempSab := MakeSab(l_TempTable);
  l_TempSab.SelectAll;

  l_PriorTable:= CreateOpenFamilyTable(ftPriority);

  try
   l_PriorSab:= MakeSab(l_PriorTable);
   l_PriorSab.SelectAll;

   l_DocTable := CreateOpenFamilyTable(ftFile);
   try
    l_DocSab:= MakeSab(l_DocTable);
    //l_DocSab.SelectAll;
    lVal := 0;
    l_DocSab.Select(fPriorFlag_fld, lVal);

    l_DocTempSab := MakeJoinSab(l_DocSab, fId_Fld,
                                l_TempSab, 1);

    l_TempPriorSab := MakeJoinSab(l_TempSab, 4 {groupkey},
                                  l_PriorSab, prBoth_key);

    l_DocPriorSab := MakeJoinSab(l_DocTempSab, l_TempPriorSab, True{aSkipLink});

    l_DocPriorSab.SortJoin([JFRec(l_DocTable, fId_Fld), JFRec(l_PriorTable, prResult_fld)]);

    lFldChanger := TIntFieldChanger.Create(l_DocTable, fPriority_fld);
    try
     lRAProcStub := L2RecAccessProc(@lRecAccessProc);
     try
      l_DocPriorSab.IterateJoinRecords(lRAProcStub, [JFRec(l_DocTable, 0 {surrogate}), JFRec(l_DocTable, fId_Fld),
                                                     JFRec(l_DocTable, fPriority_fld), JFRec(l_PriorTable, prResult_fld)]);
     finally
      FreeRecAccessProc(lRAProcStub);
     end;

     Log(format('Найдено %d записей', [lFldChanger.Count]));
     lFldChanger.Apply;
    finally
     l3Free(lFldChanger);
    end;

    l_DocPriorSab  := nil;
    l_DocPriorSab  := nil;
    l_DocTempSab   := nil;
    l_TempSab      := nil;

    //l_TempTable.DropTable;
   finally
    l3Free(l_DocTable);
   end;
  finally
   l3Free(l_PriorTable);
  end;
 finally
  l3Free(l_TempTable);
  DropTable(lTempTableName);
 end;

end;

procedure TDbReformer.SaveDiapasons(aFreeTable: TdbFreeTable; aList: Tl3RecList);
var
 i: Integer;
 l_Rec: TFreeRec;
begin
 for i:= 0 to aList.Hi do
 begin
  l_Rec:= PFreeRec(aList.ItemSlot(i))^;
  aFreeTable.AddInterval(l_Rec.TblName, l_Rec.FreeNum, l_Rec.Limit);
 end;
end;

class function TDbReformer.TablePassS(const aTable: string): string;
var
 l_Mode: Integer;
 l_Success: Boolean;
 l_TableName: string;
begin
 l_Success := htTableHeadPswd(PChar(aTable), l_Mode) = 0;
 if l_Success then
 begin
  if l_Mode > 0 then
   Result := c_TablePass
  else
   Result := '';
 end
 else
 begin
  l_TableName := AnsiUpperCase(ChangeFileExt(ExtractFileName(aTable), ''));
  if (l_TableName = 'ACCESS') or (l_TableName = 'PASS') or (l_TableName = 'BB_LOG') then
   Result := c_TablePass
  else
   Result := '';
 end;
end;

{ TTableStruct }

constructor TTableStruct.Create(aTableName: string);
var
 l_TableHandle: HT_Const.THANDLE;
 l_ElementCount: Smallint;
 l_TableHasBeenOpen: Boolean;
 l_Res: Integer;
begin
 l_TableHasBeenOpen := False;
 l_Res := htTableHandleByName(PChar(aTableName), l_TableHandle);
 if l_Res < 0 then
 begin
  l_Res:= htTableOpen(PChar(aTableName),
              TDbReformer.TablePass(aTableName),
              TDbReformer.TablePass(aTableName),
              TAB_SHARE,
              l_TableHandle);
  l_TableHasBeenOpen := True;
 end ;

 try
  if htTableInfo(l_TableHandle, f_TableInfo) = 0 then
  begin
   l_ElementCount := f_TableInfo.nFieldCnt +
                     f_TableInfo.nGroupCnt +
                     f_TableInfo.nSubstrCnt;
   SetLength(f_TableElementList, l_ElementCount);
   htTableElementList(l_TableHandle,
                      HT_Const.LPELEMENT(f_TableElementList));
  end;
 finally
  if l_TableHasBeenOpen then
   htTableClose(l_TableHandle);
 end;
end;

procedure TTableStruct.Cleanup;
begin
 f_TableElementList := nil;
 inherited;
end;

function TTableStruct.GetFieldInfo(aFieldNum: Integer): HT_Const.ThtElementInfo{ELEMENT};
begin
 if (aFieldNum < 1) or (aFieldNum > Length(f_TableElementList)) then
  raise Exception.Create('Неверный номер поля.');
 Result := f_TableElementList[aFieldNum - 1];
end;


function MakeReformer(aDbInfo: TDbInfo; aShowToUserProc: TShowToUserProc = nil; aProgressProc : Tl3ProgressProc = nil) : TDbReformer;
begin
 FreeAndNil(gReformer);
 Result := TDbReformer.Create(aDbInfo, aShowToUserProc, aProgressProc);
 gReformer := Result.Use;
end;



(*
Это я подмешивал недостающие записи из старой копии HLINK
procedure fn_Addfld(var aStruct: TElemArray; aData: Pointer = nil);
var
 l_ElemNum: Integer;
begin
 SetLength(aStruct, Length(aStruct) + 1);

 l_ElemNum := Pred(Length(aStruct));
 with aStruct[l_ElemNum] do
 begin
  wLength := 2;
  wOffset := 1;
  cClass  := EC_Group;
  cType   := ET_CHAR;
  cKey    := EK_COMMON;
  mName   := 'key12';
 end;
end;

procedure fn_Delfld(var aStruct: TElemArray; aData: Pointer = nil);
var
 l_ElemNum: Integer;
begin
 SetLength(aStruct, Length(aStruct) - 1);
end;

procedure TDbReformer.RepairHLink;
var
 lFileTbl : TdtTable;
 lFileOldTbl : TdtTable;           //dt_Table
 lSab : ISab;
 lKeyID : Integer;
 lCnt : Integer;
 lHTSab : Sab;

begin
 RestructTable('HLINK001', ffGarant, @fn_Addfld);
 RestructTable('HLINK_', ffGarant, @fn_Addfld);

 lFileTbl := TdtTable.CreateWithOpen(f_FamilyFolder, ''{TablePass}, 'HLINK001', TAB_SHARE);
 try
  lKeyID := lFileTbl.ElemNumByName('key12');

  lSab := MakeAllRecords(lFileTbl);
  lSab.ValuesOfKey(lKeyID);

  lFileOldTbl := TdtTable.CreateWithOpen(f_FamilyFolder, ''{TablePass}, 'HLINK_', TAB_SHARE);
  try
   lSab.TransfertoPhoto(lKeyID, lFileOldTbl);
   lSab.RecordsByKey;
   lSab.InvertSab;
   lCnt := lSab.Count;


   lHTSab := lSab.HTSab;
   lCnt := htResultsToTable(lHTSab, lFileTbl.Handle, nil, nil, nil, nil, 0, True, True);
   lCnt := lSab.Count;
  finally
   lFileOldTbl.CloseTbl;
   l3Free(lFileTbl);
  end;
 finally
  lFileOldTbl.CloseTbl;
  l3Free(lFileTbl);
 end;

 RestructTable('HLINK001', ffGarant, @fn_Delfld);
end;
*)

initialization

finalization

FreeAndNil(gReformer);

end.


//..........................................................................................................................................................................................................................................................
unit ddImportPipe;
{ Верхний слой трубы для импорта - знает про входные форматы и цикл }
{ $Id: ddImportPipe.pas,v 1.103 2016/08/11 10:47:46 lukyanets Exp $ }

// $Log: ddImportPipe.pas,v $
// Revision 1.103  2016/08/11 10:47:46  lukyanets
// Полчищаем dt_user
//
// Revision 1.102  2016/07/26 09:26:04  fireton
// - переделка автолинкера
//
// Revision 1.101  2016/07/21 12:13:44  fireton
// - переделка автолинкера
//
// Revision 1.100  2016/06/16 05:40:08  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.99  2016/05/18 06:03:58  lukyanets
// Выключаем удаленную отладку
//
// Revision 1.98  2015/11/25 07:22:10  lukyanets
// Заготовки для выдачи номеров
//
// Revision 1.97  2015/07/02 07:36:08  lukyanets
// Описываем словари
//
// Revision 1.96  2015/04/17 11:21:45  lukyanets
// Подчищаем протухшие словари
//
// Revision 1.95  2015/04/10 08:27:32  lukyanets
// Убираем отмершее
//
// Revision 1.94  2015/04/07 13:57:56  lukyanets
// Изолируем события
//
// Revision 1.93  2015/04/06 09:38:44  lukyanets
// Изолируем язык базы
//
// Revision 1.92  2014/12/26 12:59:04  lukyanets
// Раскладываем по подкаталогам
//
// Revision 1.91  2014/10/08 13:25:25  voba
//  k:565492100
//
// Revision 1.90  2014/10/03 11:25:56  dinishev
// Прокинул параметр anExclusive до создания объекта хранилища.
//
// Revision 1.89  2014/09/17 08:14:18  lukyanets
// Cleanup
//
// Revision 1.88  2014/09/17 07:16:49  lukyanets
// Cleanup
//
// Revision 1.87  2014/05/14 13:11:49  lulin
// {RequestLink:517789752}.
//
// Revision 1.86  2014/05/13 17:46:58  lulin
// {RequestLink:517789752}.
//
// Revision 1.85  2014/04/21 11:09:49  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.84  2014/03/20 14:18:38  voba
//  k:236721575 (Атрибуты в EVD)
//
// Revision 1.83  2014/02/14 15:33:55  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.82  2013/05/21 12:12:04  fireton
// - const перед string-параметром
//
// Revision 1.81  2013/04/15 06:54:34  narry
// Не собиралось
//
// Revision 1.80  2013/04/11 16:46:46  lulin
// - отлаживаем под XE3.
//
// Revision 1.79  2013/02/01 08:23:10  narry
// Не предупреждать об обновлении словаря Префиксов (Видов информации)
//
// Revision 1.78  2012/10/26 07:27:30  narry
// Залить новую партию НСРов (406126937)
//
// Revision 1.77  2012/10/18 06:57:29  narry
// Обновление
//
// Revision 1.76  2012/10/10 10:14:53  narry
// Поддержка простановки ссылок, открытие АК и ключевых тем при импорте
//
// Revision 1.75  2012/10/02 08:12:13  narry
// Прерывание задачи
//
// Revision 1.74  2012/03/22 04:59:28  narry
// Не собирается куча проектов (349119808)
//
// Revision 1.73  2011/11/07 09:07:49  narry
// Не работает импорт документов (296632243)
//
// Revision 1.72  2011/10/13 08:43:35  narry
// Накопившиеся изменения
//
// Revision 1.71  2011/09/08 08:01:23  fireton
// - изменилось название метода
//
// Revision 1.70  2011/04/25 13:10:27  voba
// - k : 264902833
//
// Revision 1.69  2011/04/11 10:25:07  narry
// Названия для ФАС (259885290)
//
// Revision 1.68  2011/03/11 11:21:56  narry
// K255975299. Не импортируется дельта
//
// Revision 1.67  2010/09/24 12:10:50  voba
// - k : 235046326
//
// Revision 1.66  2010/09/23 12:16:32  fireton
// - все данные простановщика читаются из одного файла
//
// Revision 1.65  2010/04/05 06:26:13  narry
// - заточки под экспериметны с КТ
//
// Revision 1.64  2010/01/18 14:29:01  narry
// - заливка документов с расстановкой команды !CASECODE
//
// Revision 1.63  2010/01/13 13:40:25  fireton
// - возможность не использовать списки кодексов и ФЗ
// - возможность фильтровать по источнику
//
// Revision 1.62  2009/12/02 08:31:05  fireton
// - автоматическая линковка документов
//
// Revision 1.61  2009/11/16 10:11:43  narry
// - обновление
//
// Revision 1.60  2009/09/11 13:26:32  voba
// - не компилялось
//
// Revision 1.59  2009/08/27 16:16:50  fireton
// - простановка ссылок на законы
//
// Revision 1.58  2009/07/31 11:34:52  narry
// - промежуточное обновление
//
// Revision 1.57  2009/07/29 08:00:23  narry
// - вывод ссобщений об ошибках не только в лог
// - вспомогательные типы
//
// Revision 1.56  2009/06/15 06:31:15  fireton
// - не падаем с грохотом при ошибке импорта в очередном документе
//
// Revision 1.55  2009/06/01 11:28:32  fireton
// - [$146377261]
//
// Revision 1.54  2009/05/22 13:07:07  narry
// - имя файла для перевода источника
//
// Revision 1.53  2009/04/21 10:03:04  narry
// - чтение Поставлений Арбтражных судов
//
// Revision 1.52  2009/04/13 07:12:59  narry
// - разделение определения типов и реализации
//
// Revision 1.51  2009/03/23 16:59:50  lulin
// - убираем случайно покоммиченное.
//
// Revision 1.50  2009/03/23 15:48:42  lulin
// [$139441859].
//
// Revision 1.49  2009/02/05 10:27:46  narry
// - рефакторинг механизма получения языка базы
//
// Revision 1.48  2009/01/14 14:06:50  narry
// - татары
//
// Revision 1.47  2008/05/05 10:39:24  voba
// - избавлялся от старой автоклассификации
//
// Revision 1.46  2008/04/17 14:49:43  narry
// - в монопольном режиме пишем только в одно хранилище
//
// Revision 1.45  2008/02/19 16:01:03  narry
// - возможность не отмечать импорт в Журнале
//
// Revision 1.44  2007/11/16 08:54:37  narry
// - обновление
//
// Revision 1.43  2007/09/07 14:47:22  voba
// - bug fix
//
// Revision 1.42  2007/07/24 12:32:31  narry
// - рефакторинг системы сообщений
//
// Revision 1.41  2007/07/04 09:17:51  narry
// - поддержка масштабирования значения индикатора
//
// Revision 1.40  2007/04/26 10:26:51  fireton
// - Рефакторинг DT. Имена словарей переехали в cDLPassports.
//
// Revision 1.39  2006/12/04 07:59:20  voba
// - cc
//
// Revision 1.38  2006/12/01 11:40:39  voba
// - cc
//
// Revision 1.37  2006/11/07 11:20:10  voba
// - cc
//
// Revision 1.36  2006/10/04 08:22:05  voba
// - убрал режимы импорта
//
// Revision 1.35  2006/09/27 16:17:35  voba
// - cc
//
// Revision 1.34  2006/08/24 11:12:08  narry
// - чистка кода
//
// Revision 1.33  2006/08/24 09:59:38  narry
// - избавление от двухпроходного режима
//
// Revision 1.32  2006/08/24 08:41:07  voba
// - убрал двухпроходный режим
//
// Revision 1.31  2006/03/22 12:46:07  narry
// - исправление: корректное описание задачи
//
// Revision 1.30  2006/03/07 12:27:36  narry
// - изменение: новая технология передачи заданий
//
// Revision 1.29  2005/12/19 11:46:14  narry
// - новое: добавлена возможность атоопределения формата файла
//
// Revision 1.28  2005/12/02 14:34:38  narry
// - ошибка: сбрасывался флажок hasAnno
//
// Revision 1.27  2005/11/09 16:34:29  narry
// - обновление
//
// Revision 1.26  2005/10/18 09:06:47  lulin
// - исправлено, то что не компилировалось в связи с переездом модулей.
//
// Revision 1.25  2005/07/25 13:07:20  lulin
// - bug fix: не компилировался Архивариус.
//
// Revision 1.24  2005/05/24 08:38:59  lulin
// - bug fix: не компилировалось.
//
// Revision 1.23  2005/04/26 09:21:28  narry
// - update
//
// Revision 1.22  2005/04/19 15:41:44  lulin
// - переходим на "правильный" ProcessMessages.
//
// Revision 1.21  2005/03/16 14:44:59  narry
// - cleanup & update
//
// Revision 1.20  2005/03/14 14:01:40  narry
// - update: поддержка пользовательского импорта сторонних аннотаций
//
// Revision 1.19  2005/03/11 16:00:30  narry
// - update:
//
// Revision 1.18  2005/03/11 11:38:02  narry
// - update:
//
// Revision 1.17  2005/03/02 16:28:17  narry
// - исправление: поддержка аннотаций
//
// Revision 1.16  2005/02/16 17:11:12  narry
// - update: поддержка Аннотаций
//
// Revision 1.15  2004/12/23 11:42:11  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.14  2004/12/23 08:40:41  lulin
// - вычищен ненужный модуль.
//
// Revision 1.13  2004/12/16 16:06:15  narry
// - update
//
// Revision 1.12  2004/10/07 08:59:34  narry
// - update
//
// Revision 1.11  2004/09/01 13:33:51  narry
// - update
//
// Revision 1.10  2004/07/06 10:43:17  narry
// - update
//
// Revision 1.9  2004/06/30 10:59:25  narry
// - update: изменился тип причины пропуска документа
//
// Revision 1.8  2004/05/17 09:36:55  narry
// - update:
//
// Revision 1.7  2004/02/24 14:40:03  narry
// - update
//
// Revision 1.6  2004/01/05 15:15:58  narry
// - new : во время очистки импортированных файлов удаляются и evd-файлы
//
// Revision 1.5  2003/12/17 11:53:16  narry
// - add: расширение списка параметров сообщения на импорт - отслеживание Группы Доступа "Передано в регионы"
//
// Revision 1.4  2003/09/15 14:28:45  narry
// - update
//
// Revision 1.3  2003/09/03 07:25:48  narry
// - update: поддержка двуязычных словарей
//
// Revision 1.2  2003/08/29 13:15:17  narry
// - update
//
// Revision 1.1  2003/05/28 11:55:22  narry
// - Новое поколение трубы для импорта
//

interface

uses
  WinTypes, WinProcs, Messages, Classes, Graphics, Controls, SysUtils,
  Forms, Dialogs,
  l3Variant,
  ddNSRC_r, ddKW_r, ddProgressObj, ddImportPipeKernel, ddFileIterator,
  ddExtAnnoPipe,
  l3Filer, l3Base, l3Types,
  l3Date,
  k2Reader, k2TagGen,
  evHndFlt,
  daInterfaces,
  daTypes,
  DT_Const, DT_Types, dt_AttrSchema,
  DT_Fam, DT_Serv, dt_IFltr, ddPipeTypes,
  ddTypes,
  k2Interfaces,
  k2TagFilter, ddSpellCheckFilter;

type
  TddPipeStatus = (dd_psOk, dd_psError, dd_psDelDuplicate, dd_psNSRCImport,
                   dd_psKWImport);

  TddSkipTopicEvent = procedure (theTopicNo: Longint; const theMessage: AnsiString) of object;
  TddImportPipe = class(Tl3Base)
  private
   { Private declarations }
   f_Kernel: TddImportPipeFilter;
   f_FileIterator: TddFileIterator;
   f_Progressor : TddProgressObject;
   f_FileReader: Tk2CustomFileReader;
   f_Generator: Tk2TagGenerator;
   f_InFiler: TevDOSFiler;
    f_SafeCleanDirSuffix: AnsiString;
    function GetCheckRegion: Boolean;
    procedure SetCheckRegion(const Value: Boolean);
  private { Настройки трубы }
   FAutoDetectTypes: TddPipeInputFileTypeSet;
   f_Family: TdaFamilyID;
   f_PictDir: AnsiString;
   f_MoveFiles: Boolean;
   f_DoneDir: ShortString;
   f_UserDepend: Boolean;
   //f_CloseStages: Boolean;
   f_LoadDict: Boolean;
   f_FinalUpdate: Boolean;
   f_SameDocuments: TSameDocReact;
   f_DelConditions : TDeleteConditionSet;
   f_CheckDocuments: Boolean;
   f_NeedLockBase : Boolean;
   f_CheckNullDocs: Boolean;
   f_SafeCleanDir: AnsiString;
   f_CleanFiles: Boolean;
   f_UserID    : Long;
   f_InputFileType: TddPipeInputFileType;
   f_ClearLog   : Boolean;
   f_Abort: Boolean;
   f_AccGroup: string;
   f_AddGen: Tk2TagGenerator;
   f_AddKT: Boolean;
   f_AnnoFilter: TddExtAnnotationFilter;
   f_AutoInclude: Boolean;
   f_AutoLink: Boolean;
   f_AutoLinkFileName: AnsiString;
   f_CodexTableFilename: AnsiString;
   f_ErrorLog : TStrings;
   f_Status    : TddPipeStatus;
   f_TopicStart: TddTopicEvent;
   f_TopicSkip: TddTopicEvent;
   f_CommentWrite: TddCommentWriteEvent;
   f_kTFileName: AnsiString;
   f_MisspellFileName: AnsiString;
   f_NotUpdatableDicts: TDLTypeSet;
//   f_OnePartSize: Integer;
   f_OnWrongWordFound: TSpellCheckEvent;
   f_OpenClassStage: Boolean;
//   f_PartSize: Integer;
   f_SkippedCount: Integer;
//   f_SourceFileName: AnsiString;
   f_SpellCheck: Boolean;
   f_TopicNo: Longint;
   f_TopicCount : Longint;
  private
   procedure CreateFileReader(aFileType : TddPipeInputFileType);
   procedure DestroyFileReader;
   procedure FilerAbortLoad(Sender: TObject; var Aborted: Bool);
   procedure GenerateDocId(var DocID: TDocID; IsVAS: boolean);
   procedure SetIsEnglish(Value: Boolean);
   function  GetIsEnglish: Boolean;
   procedure SetProgressor(Value: TddProgressObject);
   procedure SetInputFileType(Value: TddPipeInputFileType);
   procedure SetWorkDir(Value: ShortString);
   function  GetWorkDir: ShortString;
   function  GetFileMask: AnsiString;
   function pm_GetAddNewToLog: Boolean;
   function pm_GetNeedFork: Boolean;
    procedure pm_SetAddNewToLog(const aValue: Boolean);
   procedure pm_SetNeedFork(const aValue: Boolean);
   procedure StartProgressor;
   procedure StopProgressor;
   procedure SetFileMask(aValue: AnsiString);
   procedure SetKernelParams;
   function _UpdateDicts(aDictType: TdaDictionaryType; aDocID, aSubID: TSubID;
                         aNameTag: Tl3Tag): Boolean;
   procedure _StartTopic(aTopicNo: Longint; const aMessage: AnsiString);
   procedure _Abort(Sender: TObject);
   procedure _SkipDocument(aDocID : TDocID; WhyFlag : TSkipDocReason; UserID : Longint);
   function  _ProcessOneFile(const aFileName: AnsiString): Boolean;
//   function _MoveDoneFile(const aFileName: AnsiString): Boolean;
   function RealSafeCleanDir: String;
  protected
    { Protected declarations }
   function  ImportDocuments: Boolean;
   procedure AddError(const Msg: AnsiString; Category: Integer=0);
   procedure DoCleanFiles;
   procedure AbortImport;
   procedure AddSize(Size: Longint);
   procedure Cleanup; override;
   procedure ClearDoneDir;
  public
   { Public declarations }
   constructor Create(aFamily: Integer; anExclusive: Boolean = False); overload; virtual;
   function Execute: Boolean;
   procedure AbortProcess;
   class function GetInputFileType(aFilename: AnsiString; aValidTypes:
       TddPipeInputFileTypeSet): TddPipeInputFileType;     
  public
   property Status : TddPipeStatus
    read f_Status;

   property Aborted: Boolean
    read f_Abort;
   property AccGroup: string read f_AccGroup write f_AccGroup;
   property AddKT: Boolean read f_AddKT write f_AddKT;
   property AddNewToLog: Boolean read pm_GetAddNewToLog write pm_SetAddNewToLog;
   property AutoDetectTypes: TddPipeInputFileTypeSet read FAutoDetectTypes write
       FAutoDetectTypes;
   property AutoInclude: Boolean read f_AutoInclude write f_AutoInclude;
   property AutoLink: Boolean read f_AutoLink write f_AutoLink;
   property AutoLinkFileName: AnsiString read f_AutoLinkFileName write
       f_AutoLinkFileName;

   property UserID: Long
    read f_UserID write f_UserID;

   property ErrorLog: TStrings
    read f_ErrorLog;

   property ClearLog: Boolean
    read f_ClearLog write f_ClearLog;
   property kTFileName: AnsiString read f_kTFileName write f_kTFileName;
   property MisspellFileName: AnsiString read f_MisspellFileName write
       f_MisspellFileName;
   property NeedFork: Boolean read pm_GetNeedFork write pm_SetNeedFork;
//   property OnePartSize: Integer read f_OnePartSize write f_OnePartSize;
   property OpenClassStage: Boolean read f_OpenClassStage write f_OpenClassStage;
//   property PartSize: Integer read f_PartSize write f_PartSize;
//   property SourceFileName: AnsiString read f_SourceFileName write f_SourceFileName;
   property SpellCheck: Boolean read f_SpellCheck write f_SpellCheck;
   property OnWrongWordFound: TSpellCheckEvent read f_OnWrongWordFound write
       f_OnWrongWordFound;

  published
    { Published declarations }
   property Reader: Tk2CustomFileReader read f_FileReader write f_FileReader;

   property Family : TdaFamilyID
    read f_Family
    write f_Family
    default 1;

   property InputFileType: TddPipeInputFileType
    read f_InputFileType
    write SetInputFileType;

   property FileMask: AnsiString
    read GetFileMask
    write SetFileMask;

   property IsEnglish: Boolean
    read GetIsEnglish
    write SetIsEnglish;

   property WorkDir: ShortString
    read GetWorkDir
    write SetWorkDir;

   property PictureDir: AnsiString
    read f_PictDir
    write f_PictDir;

   property MoveFiles: Boolean
    read f_MoveFiles
    write f_MoveFiles;

   property DoneDir: ShortString
    read f_DoneDir
    write f_DoneDir;

   property UserDepend: Boolean
   {* Создание папки для импортированных файлов в домашней папке пользователя}
    read f_UserDepend
    write f_UserDepend;

   property CheckDocuments: Boolean
    read f_CheckDocuments
    write f_CheckDocuments;

   property NeedLockBase: Boolean
    read f_NeedLockBase
    write f_NeedLockBase;

   property CheckNullDocs: Boolean
    read f_CheckNullDocs
    write f_CheckNullDocs;

   property SameDocuments: TSameDocReact
    read f_SameDocuments
    write f_SameDocuments;

   property DeleteConditions : TDeleteConditionSet
    read f_DelConditions
    write f_DelConditions;

   property LoadDict: Boolean
    read f_LoadDict
    write f_LoadDict;

   property FinalUpdate: Boolean      { Обновление базы по окончании }
    read f_FinalUpdate
    write f_FinalUpdate;

   property NotUpdatableDicts : TDLTypeSet
    read f_NotUpdatableDicts
    write f_NotUpdatableDicts;

    property CleanFiles: Boolean
      read f_CleanFiles write f_CleanFiles;

    property SafeCleanDir: AnsiString
      read f_SafeCleandir write f_SafeCleanDir;

    property SafeCleanDirSuffix: AnsiString
      read f_SafeCleanDirSuffix write f_SafeCleanDirSuffix;

    //property CloseStages: Boolean {* Закрывать этапы в Гардоке}
    // read f_CloseStages
    // write f_CloseStages;
    property CheckRegion: Boolean
     read GetCheckRegion
     write SetCheckRegion;
   published
    property OnTopicStart: TddTopicEvent
     read f_TopicStart
     write f_TopicStart;

    property OnTopicSkip: TddTopicEvent
    { вызывается в момент пропуска топика }
      read f_TopicSkip
      write f_TopicSkip;

    property OnCommentWrite: TddCommentWriteEvent
      read f_CommentWrite write f_CommentWrite;

    property Progressor : TddProgressObject
     read f_Progressor
     write SetProgressor;
  end;//TddImportPipe

const
 ddAllDicts = [da_dlSources, da_dlTypes, da_dlClasses, da_dlKeyWords, da_dlBases,
               da_dlDateNums, da_dlWarnings, da_dlCorrects, da_dlCorSources, da_dlPublisheds,
               da_dlPrefixes, da_dlTerritories, da_dlNorms, da_dlAccGroups, da_dlAnnoClasses];


implementation

uses
 StrUtils,
 l3IniFile, l3String, l3FileUtils,

 afwFacade,

 daDataProvider,

 DT_DOC, ComCtrls, evEvdRd, ddUtils, daSchemeConsts,
 ddNSRCUtils, k2Tags, k2Base, l3Except, evTxtRd,
 ddDocReader, l3languages, BAse_CFG, {ddArbitralCourtReader,} Document_Const,
 dd_lcClassOpenerFilter, ddKTExtractor, ddAutoLinkFilter, ddAutoIncludeFilter,
 dd_lcMisspellFilter, ddAccGroupGenerator, ddGeneralLawsLinkFinder;

constructor TddImportPipe.Create(aFamily: Integer; anExclusive: Boolean = False);
begin
 inherited Create;
 f_Kernel:= TddImportPipeFilter.Create(aFamily, nil, anExclusive);
 f_FileIterator:= TddFileIterator.Create;
 f_InFiler:= TevDOSFiler.Create(nil);
 f_InFiler.OnCheckAbortedLoad := FilerAbortLoad;
 f_ErrorLog:= TStringList.Create;
 f_MoveFiles:= False;
 f_DoneDir:= '';
 f_CleanFiles:= False;
 f_SafeCleanDir:= '';
 f_SafeCleanDirSuffix := '';
 f_UserID:= 0;
 f_InputFileType:= dd_itUnknown;
 f_CheckNullDocs:= True;
 f_ClearLog:= True;
 f_UserDepend:= False;
 //f_CloseStages:= False;
 f_Family:= aFamily;
 f_NotUpdatableDicts:= ddAllDicts;
 FAutoDetectTypes := [dd_itGarant, dd_itEverest, dd_itEverestInternal];
// f_PartSize:= 0;
end;


procedure TddImportPipe.Cleanup;
begin
 FreeAndNil(f_ErrorLog);
 FreeAndNil(f_Kernel);
 FreeAndNil(f_FileIterator);
 FreeAndNil(f_InFiler);
 inherited;
end;

function TddImportPipe._ProcessOneFile(const aFileName: AnsiString): Boolean;
var
 l_FileType : TddPipeInputFileType;
begin
 Result:= False;
 if f_Abort then
   exit;
 if InputFileType = dd_itAutoDetect then
  l_FileType := getInputFileType(aFileName, AutoDetectTypes)
 else
  l_FileType := InputFileType;
 if l_FileType <> dd_itUnknown then
 begin
  CreateFileReader(l_FileType);
  try
   if f_FileReader <> nil then
   begin
    f_InFiler.FileName:= aFileName;
    f_Status:= dd_psNSRCImport;
    try
     f_FileReader.Start;
     try
      l3System.Msg2Log('Обработка %s начата', [aFileName]);
      f_FileReader.Execute;
      l3System.Msg2Log('Обработка %s закончена', [aFileName]);
     finally
      f_FileReader.Finish;
     end; 
     if MoveFiles then
      CopyFile(aFileName, ConcatDirName(DoneDir, ExtractFileName(aFileName)),
               cmDeleteSource);
     f_Status:= dd_psOk;
     Result:= True;
    except
     on E: Exception do
     begin
      if not (E Is El3AbortLoad) then
      begin
       f_Status:= dd_psError;
       l3System.Msg2Log(Format('CRITICAL ERROR : Ошибка импорта файла %s (%s)', [aFileName, E.Message]));
       Result := True;
       //f_FileReader.Generator:= nil;
       //raise;
      end
      else
       l3System.Msg2Log('Загрузка документа прервана');
     end; //on E: Exception
    end; // try..finally
   end // l_FileType <> dd_itUnknown
   else
    Result := True;
  finally
   DestroyFileReader;
  end;
 end;
end;



function TddImportPipe.Execute: Boolean;
var
  aUserName,aLoginName : String;
  aActFlag    : Byte;
begin
 Result := False;
 if f_ClearLog then
  f_ErrorLog.Clear;
 if UserID > 0 then
 begin
  GlobalDataProvider.UserManager.GetUserInfo(UserID, aUserName, aLoginName, aActFlag);
  l3System.Msg2Log(Format('Начало выполнения импорта от имени %s (ID %d)', [aUserName, UserID]));
 end // UserID > 0
 else
  l3System.Msg2Log('Начало импорта');
 if ImportDocuments then
 begin
  DoCleanFiles;
  if UserID > 0 then
   l3System.Msg2Log(Format('Импорт от имени %s (ID %d) завершен.', [aUserName, UserID]))
  else
   l3System.Msg2Log('Импорт завершен.');
  Result := True;
 end
 else
  {$IfDef nsTest}
  raise Exception.Create('Импорт завершился с ошибками');
  {$Else  nsTest}
  l3System.Msg2Log('Импорт завершился с ошибками');
  {$EndIf nsTest}
end;


function TddImportPipe.ImportDocuments: Boolean;
var
 l_StartTime: TDateTime;
 l_Msg: AnsiString;
// l_PassCount, l_PassFinish: Integer;
// l_PassIndex, l_PassStart: Integer;
begin
 Result := False;
 (*
 if (InputFileType = dd_itLawCase) and not GlobalHTServer.FreeTbl[CurrentFamily].AnyRangesPresent(ftnDocIDLawCase) then
 begin
  f_Abort:= True;
  l_Msg:= 'Не задан диапазон номеров для Постановлений Арбитражных судов. Импорт невозможен.';
  l3System.Msg2Log(l_Msg);
  ErrorLog.Add(l_Msg);
 end; // (InputFileType = dd_itLawCase) and not GlobalHTServer.FreeTbl[CurrentFamily].AnyRangesPresent(ftnDocIDLawCase)
 *)
 if Aborted then
  exit;
 l_StartTime:= Now;
 f_FileIterator.LoadFiles;
 f_TopicCount := 0;
 f_SkippedCount:= 0;
 if f_FileIterator.TotalSize > 0 then
 begin
   SetKernelParams;
   if MoveFiles then
    ClearDoneDir;
//    if PartSize > 0 then
//     l_PassCount:= f_FileIterator.Count div PartSize + 1
//    else
//     l_PassCount:= 1;
    StartProgressor;
    try
     f_Kernel.Start;
     try
      f_FileIterator.IterateFiles(_ProcessOneFile, 0, -1);
(*      for l_PassIndex:= 0 to Pred(l_PassCount) do
      begin
       l_PassStart:= l_PassIndex*PartSize;
       if l_PassIndex = Pred(l_PassCount) then
        l_PassFinish:= -1
       else
        l_PassFinish:= Pred(Succ(l_PassIndex)*PartSize);
       f_FileIterator.IterateFiles(_ProcessOneFile, l_PassStart, l_PassFinish);
       //f_FileIterator.IterateFiles(_MoveDoneFile, l_PassIndex*PartSize, Pred(Succ(l_PassIndex)*PartSize));
       // Можно сделать еще что-нибудь
      end; // for l_PassIndex*)
     finally
      f_Kernel.Finish;
     end;
    finally
     StopProgressor;
    end;
  if f_Progressor <> nil then
   l3System.Msg2Log('Обработано %s (%d документов импортировано, %d документов пропущено) за %s',
                      [Bytes2Str(f_Progressor.TotalCur),
                       f_TopicCount-f_SkippedCount, f_SkippedCount,
                       CalcElapsedTime(l_StartTime, Now)])
  else
   l3System.Msg2Log('Импортировано %d документов за %s',
                      [f_TopicCount,
                       CalcElapsedTime(l_StartTime, Now)]);
  Result := True;
 end; // f_FileIterator.TotalSize > 0
end;

function TddImportPipe.RealSafeCleanDir: String;
begin
 if UserDepend then
  Result := ConcatDirName(SafeCleanDir, Format('User_#%d', [UserID]));
 if SafeCleanDirSuffix <> '' then
  Result := ConcatDirName(Result, SafeCleanDirSuffix);
end;

procedure TddImportPipe.DoCleanFiles;
var
 i: Integer;
begin
 if CleanFiles then
 begin
  if f_Progressor <> nil then
   f_Progressor.ProcessUpdate(0, f_FileIterator.FileList.Count, 'Удаление ненужных файлов');
  try
   for i:= 0 to Pred(f_FileIterator.FileList.Count) do
   begin
     if SafeCleanDir <> '' then
     begin
      CopyNSRCFile(f_FileIterator.FileList.Strings[i], ConcatDirName(RealSafeCleanDir, ExtractFileName(f_FileIterator.FileList.Strings[i])));
      DeleteFile(f_FileIterator.FileList.Strings[i]);
     end
     else
       DeleteFile(f_FileIterator.FileList.Strings[i]);
      if f_Progressor <> nil then
        f_Progressor.ProcessUpdate(1, i, '');
   end; // for i
   DelDir(WorkDir);

   if f_Progressor <> nil then
     f_Progressor.ProcessUpdate(2, Pred(f_FileIterator.FileList.Count), '');
  except
    l3System.Msg2Log('Ошибка удаления обработанных файлов');
  end;
 end; { CleanFiles }
end;

procedure TddImportPipe._SkipDocument(aDocID : TDocID; WhyFlag : TSkipDocReason;
    UserID: Longint);
var
 aUserName,aLoginName : String;
 aActFlag             : Byte;
 l_Msg: AnsiString;
begin
 if UserID > -1 then
  GlobalDataProvider.UserManager.GetUserInfo(UserID, aUserName, aLoginName, aActFlag);
  { Накапливаем сообщения о пропущенных документах }
 case WhyFlag of
  srUnknown       : l_Msg:= 'Причина неизвестна';
  srAlreadyExists : l_Msg:= Format('   #%d - существует в базе', [aDocID]);
  srBusy          : l_Msg:= Format('   #%d - занят пользователем %s', [aDocID, aUserName]);
  srCantBeDeleted : l_Msg:= Format('   #%d - не прошел проверку условий удаления', [aDocID]);
  srAccessDenied  : l_Msg:= 'Не удалось удалить исходный документ';
  srNoHandle      : l_Msg:= 'Не задан номер документа';
 end; // case WhyFlag
 if WhyFlag = srNoHandle then  // если Handle не задан, procedure TddImportPipe._StartTopic не вызовется и количество обработанных топиков не увеличится
  Inc(f_TopicCount); // поэтому увеличим "вручную"

 Inc(f_SkippedCount);
 if f_Progressor <> nil then
  f_Progressor.AddToDialog(l_Msg);
 if Assigned(f_TopicSkip) then
  f_TopicSkip(aDocID, l_Msg);
end;


procedure TddImportPipe.ClearDoneDir;
 procedure _DelFiles(const aMask: AnsiString);
 var
   SR: TSearchRec;
   H, D: Integer;
   D2: TDateTime;
   Year, Month, Day: Word;
   S: AnsiString;
 begin
   if FindFirst(ConcatDirName(DoneDir, aMask), faAnyFile, SR) = 0 then
   repeat
     S:= ConcatDirName(DoneDir, SR.Name);
     H:= FileOpen(S, fmOpenWrite or fmShareDenyNone);
     Year:= 0; Month:= 0; Day:= 0;
     try
       D:= FileGetDate(H);
       D2:= FileDateToDateTime(D);
       D2:= Date-D2;
       DecodeDate(D2, Year, Month, Day);
     finally
       FileClose(H);
     end;
     if (Year*365+Month*30+Day) > 7 then
       DeleteFile(S);
   until FindNext(SR) <> 0;
   FindClose(SR);
 end;
begin
 _DelFiles('*.nsr');
 _DelFiles('*.evd');
end;

procedure TddImportPipe.AbortImport;
begin
  f_Abort:= True;

  case InputFileType of
    dd_itGarant: TCustomNSRCReader(f_FileReader).StopLoading:= True;
    dd_itEverest: ;
  end; {}

end;

procedure TddImportPipe.AddSize(Size: Longint);
begin
 try
  if Assigned(f_Progressor) then
   f_Progressor.IncSize(Size);
 except

 end;
end;

procedure TddImportPipe.AddError(const Msg: AnsiString; Category: Integer = 0);
begin
 try
  f_ErrorLog.Add(Msg);
 except
  l3System.Msg2Log('Ошибка лога импорта');
 end;
end;

procedure TddImportPipe._StartTopic(aTopicNo: Longint; const aMessage: AnsiString);
var
 l_Msg : AnsiString;
begin
 if Assigned(f_TopicStart) then
  f_TopicStart(aTopicNo, '');
 f_TopicNo:= aTopicNo;
 l_Msg := Format('Начался документ № %d', [f_TopicNo]);
 if f_Progressor <> nil then
  f_Progressor.AddToDialog(l_Msg);
 l3System.Msg2Log(l_Msg);
 Inc(f_TopicCount);
end;

procedure TddImportPipe._Abort(Sender: TObject);
begin
 AbortImport;
end;

procedure TddImportPipe.SetWorkDir(Value: ShortString);
begin
 if f_FileIterator = nil then
  f_FileIterator:= TddFileIterator.Create;
 f_FileIterator.Directory:= Value;
end;

function TddImportPipe.GetWorkDir: ShortString;
begin
 if f_FileIterator = nil then
  f_FileIterator:= TddFileIterator.Create;
 Result:= f_FileIterator.Directory;
end;

procedure TddImportPipe.SetFileMask(aValue: AnsiString);
begin
 if f_FileIterator = nil then
  f_FileIterator:= TddFileIterator.Create;
 f_FileIterator.FileMask:= aValue;
end;

function TddImportPipe.GetFileMask: AnsiString;
begin
 if f_FileIterator = nil then
  f_FileIterator:= TddFileIterator.Create;
 Result:= f_FileIterator.FileMask;
end;

function TddImportPipe._UpdateDicts(aDictType: TdaDictionaryType; aDocID, aSubID: TSubID;
                                 aNameTag: Tl3Tag): Boolean;
var
 l_S: AnsiString;
begin
 if aDictType in f_NotUpdatableDicts then
 begin
  Result:= False;
  if aDictType <> da_dlPrefixes then
  begin
   if aDictType <> da_dlNone then
    l_S:= cDLPassports[aDictType].rName
   else
    l_S:= 'Название неизвестно';
   if aSubID > 0 then
    l_S:= Format('#%d (метка #%d) - неизвестный элемент "%s" в словаре %s',
                   [aDocID, aSubID, aNameTag.AsString, l_S])
   else
    l_S:= Format('#%d - неизвестный элемент "%s" в словаре %s',
                   [aDocID, aNameTag.AsString, l_S]);
   AddError(l_S, 0);
  end;
 end
 else
  Result:= True;
end;



procedure TddImportPipe.AbortProcess;
begin
 AbortImport
end;


procedure TddImportPipe.CreateFileReader(aFileType : TddPipeInputFileType);
begin
 if f_FileReader = nil then
 begin
  case aFileType of
   dd_itGarant,
   dd_itKT:
    begin
     f_FileReader:= TCustomNSRCReader.Create(nil);
     TCustomNSRCReader(f_FileReader).OnAddSize:= AddSize;
     TCustomNSRCReader(f_FileReader).OnError:= AddError;
     if Assigned(f_CommentWrite) then
      TCustomNSRCReader(f_FileReader).OnCommentWrite:= f_CommentWrite;
     TCustomNSRCReader(f_FileReader).WorkDir:= WorkDir;
     TCustomNSRCReader(f_FileReader).PictureDir:= PictureDir;
     TCustomNSRCReader(f_FileReader).CodePage:= GlobalDataProvider.BaseLanguage[CurrentFamily].OEMCodePage;
     TCustomNSRCReader(f_FileReader).AnsiCodePage:= GlobalDataProvider.BaseLanguage[CurrentFamily].AnsiCodePage;
    end;
   dd_itEverest,
   dd_itEverestInternal:
     f_FileReader:= TevEvdReader.Create(nil);
   dd_itRTFAnnotation,
   dd_itTXTAnnotation:
    begin
     if f_InputFileType = dd_itRTFAnnotation then
      f_FileReader := TddDocReader.Create(nil)
     else
      f_FileReader := TevTxtReader.Create(nil);
     f_AnnoFilter:= TddExtAnnotationFilter.Create(nil);
     f_FileReader.Generator := f_AnnoFilter;
    end;
  end; // case f_InputFileType;
  f_InFiler.CodePage := cp_ANSI; //сбросим CodePage, которая могла быть изменена предыдущим использованием
  f_FileReader.Filer:= f_InFiler;
  f_Generator:= f_FileReader;

  if f_InputFileType in [dd_itRTFAnnotation, dd_itTXTAnnotation] then
   f_AnnoFilter.Generator := f_Kernel
  else
  begin
   // Сюда можно встроить доп фильтры
   if AutoLink or OpenClassStage or AddKT or (f_AccGroup <> '') then
   begin
    f_AddGen:= nil;
    if AutoLink then
    begin
     TddAutoLinkFilter.SetTo(f_AddGen);
     TddAutoLinkFilter(f_AddGen).AddLinkFinder(ddGetGeneralLawsLinkFinder(nil, AutoLinkFileName));
    end;
    if OpenClassStage then
     Tdd_lcClassOpenerFilter.SetTo(f_AddGen);
    if AddKT then
     TddKTExtractorFilter.SetTo(f_AddGen, f_KTFileName);
    if AutoInclude then
     TddAutoIncludeFilter.SetTo(f_AddGen);
    if SpellCheck then
    begin
     TddSpellCheckFilter.SetTo(f_AddGen, OnWrongWordFound);
     Tdd_lcMisspellFilter.SetTo(f_AddGen, MisspellFileName);
    end;// SpellCheck
    if f_AccGroup <> '' then
     TddAccGroupGenerator.SetTo(f_AddGen, f_AccGroup);
    f_AddGen.Link(f_Kernel);
    f_FileReader.Generator:= f_AddGen;
   end
   else
    f_FileReader.Generator:= f_Kernel;
  end;
 end; // f_FileReader = nil
end;

procedure TddImportPipe.DestroyFileReader;
begin
 FreeAndNil(f_FileReader);
 if f_InputFileType in [dd_itRTFAnnotation, dd_itTXTAnnotation] then
   l3Free(f_AnnoFilter);
 if AutoLink or OpenClassStage or AddKT then
  FreeAndNil(f_AddGen);
end;

procedure TddImportPipe.FilerAbortLoad(Sender: TObject; var Aborted: Bool);
begin
 Aborted := f_Abort;
end;

procedure TddImportPipe.GenerateDocId(var DocID: TDocID; IsVAS: boolean);
begin
 DocID:= GlobalHTServer.FreeTbl[CurrentFamily].GetFree(ftnDocIDLawCase);
end;

procedure TddImportPipe.SetInputFileType(Value: TddPipeInputFileType);
begin
 if f_InputFileType <> Value then
 begin
  f_InputFileType:= Value;
  FileMask := ImportFileMask[f_InputFileType];
 end; // f_InputFileType <> Value
end;

procedure TddImportPipe.SetProgressor(Value: TddProgressObject);
begin
 if f_Progressor <> Value then
  f_Progressor:= Value;
 if f_Progressor <> nil then
 begin
  f_InFiler.Indicator.NeedProgressProc:= True;
  f_InFiler.Indicator.OnProgressProc:= f_Progressor.ProcessUpdate;
 end; // f_Progressor <> nil
end;

function TddImportPipe.GetIsEnglish: Boolean;
begin
 Result:= f_Kernel.IsEnglish;
end;

procedure TddImportPipe.SetIsEnglish(Value: Boolean);
begin
 f_Kernel.IsEnglish:= Value;
end;

function TddImportPipe.GetCheckRegion: Boolean;
begin
 Result:= f_Kernel.CheckRegion;
end;

class function TddImportPipe.GetInputFileType(aFilename: AnsiString; aValidTypes:
    TddPipeInputFileTypeSet): TddPipeInputFileType;
var
 l_Ext: AnsiString;
 i: TddPipeInputFileType;
begin
 Result := dd_itUnknown;
 l_Ext := ExtractFileExt(aFileName);
 for i:= dd_itGarant to dd_itTXTAnnotation do
  if AnsiContainsText(ImportFileMask[i], l_Ext) and (i in aValidTypes) then
  begin
   Result := i;
   break
  end;
end;

function TddImportPipe.pm_GetAddNewToLog: Boolean;
begin
 Result := f_Kernel.AddNewToLog;
end;

function TddImportPipe.pm_GetNeedFork: Boolean;
begin
 Result := f_Kernel.NeedFork;
end;

procedure TddImportPipe.pm_SetAddNewToLog(const aValue: Boolean);
begin
 f_Kernel.AddNewToLog := aValue;
end;

procedure TddImportPipe.pm_SetNeedFork(const aValue: Boolean);
begin
 f_Kernel.NeedFork:= aValue;
end;

procedure TddImportPipe.StartProgressor;
begin
 afw.ProcessMessages;
 if Assigned(f_Progressor) then
 begin
  f_Progressor.Start(f_FileIterator.TotalSize, 'Импорт документов');
  f_Progressor.OnAbort:= _Abort;
 end; // Assigned(f_Progressor);
end;

procedure TddImportPipe.StopProgressor;
begin
  if Assigned(f_Progressor) then
   f_Progressor.Stop;
end;

procedure TddImportPipe.SetCheckRegion(const Value: Boolean);
begin
 f_Kernel.CheckRegion:= Value;
end;

procedure TddImportPipe.SetKernelParams;
begin
  f_Kernel.Family:= Family;
  f_Kernel.UpdateTables:= FinalUpdate;
  f_Kernel.CheckDocuments:= CheckDocuments;
  f_Kernel.NeedLockBase:= NeedLockBase;
  f_Kernel.DocumentReaction:= SameDocuments;
  f_Kernel.DeleteConditions := DeleteConditions;
  f_Kernel.InternalFormat:= f_InputFileType = dd_itEverestInternal;
  f_Kernel.UserID:= UserID;
  //f_Kernel.CloseStages:= CloseStages;
  f_Kernel.OnTopicStart:= _StartTopic;
  f_Kernel.OnSkipDocument:= _SkipDocument;
  f_Kernel.OnDictionaryUpdate:= _UpdateDicts;
end;

(*
function TddImportPipe._MoveDoneFile(const aFileName: AnsiString): Boolean;
begin
 Result:= True;
 // переместить обработанный файл, чтобы избежать повторной заливки
end;
*)

end.


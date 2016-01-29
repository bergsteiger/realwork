Unit Dt_CFltr;

{ $Id: DT_CFltr.pas,v 1.125 2015/07/02 11:41:29 lukyanets Exp $ }

// $Log: DT_CFltr.pas,v $
// Revision 1.125  2015/07/02 11:41:29  lukyanets
// Описываем словари
//
// Revision 1.124  2015/07/02 07:36:07  lukyanets
// Описываем словари
//
// Revision 1.123  2014/10/22 06:11:32  lukyanets
// Не собиралось
//
// Revision 1.122  2014/10/21 14:02:12  voba
//  k:569221072
//
// Revision 1.120  2014/04/22 14:29:52  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.119  2014/04/11 15:30:43  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.118  2014/04/10 15:40:18  voba
// - add  THLinkAddrToInternal
//
// Revision 1.117  2014/04/07 08:08:08  dinishev
// Bug fix: не компилировались проекты.
//
// Revision 1.116  2014/03/28 06:13:29  dinishev
// Bug fix: не собиралось почити ничего.
//
// Revision 1.115  2014/03/25 07:19:35  dinishev
// Bug fix: не компилировалось.
//
// Revision 1.114  2014/03/03 16:07:48  lulin
// - избавляемся от странностей.
//
// Revision 1.113  2014/02/28 14:54:23  lulin
// - перетряхиваем генераторы.
//
// Revision 1.112  2014/02/27 14:04:26  voba
// - bugfix
//
// Revision 1.111  2013/10/30 10:36:40  voba
// - отказ от fSrchList
//
// Revision 1.110  2013/10/23 12:25:58  lulin
// - автоматически определяемые типы тоже генерируем с модели.
//
// Revision 1.109  2013/10/21 15:43:09  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.108  2013/10/21 10:30:56  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.107  2013/10/18 15:38:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.106  2013/04/19 13:07:39  lulin
// - портируем.
//
// Revision 1.105  2013/03/26 12:19:23  fireton
// - удаляем поле Comment из дат/номеров
//
// Revision 1.104  2013/01/17 10:11:56  voba
// - перенес интерфейсы в отдельный модуль
//
// Revision 1.103  2011/06/20 09:56:12  voba
// - k : 236721575
//
// Revision 1.102  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.101  2010/09/21 11:06:54  fireton
// - переводим деревья с PAnsiChar на Tl3WString
//
// Revision 1.100  2009/07/22 11:27:26  narry
// - изменение доступа к DictServer
//
// Revision 1.99  2009/07/20 12:38:47  voba
// - Засунул renum в атрибуты
//
// Revision 1.98  2009/07/03 16:24:07  lulin
// - шаг к переходу от интерфейсов к объектам.
//
// Revision 1.97  2009/06/23 07:32:59  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.96  2009/04/13 07:10:58  narry
// - разделение определения типов и реализации
//
// Revision 1.95  2009/03/04 16:26:03  lulin
// - <K>: 137470629. Bug fix: не собирался Архивариус.
//
// Revision 1.94  2009/02/25 11:43:22  voba
// - перетащил const ifFiltredTags из dt_IFltr
//
// Revision 1.93  2009/02/16 09:19:45  voba
// - cc
//
// Revision 1.92  2008/06/16 14:58:16  voba
// - bug fix
//
// Revision 1.91  2008/06/09 07:04:17  voba
// - bug fix
//
// Revision 1.90  2008/06/07 11:57:20  voba
// - enh. При сохранении адресов гиперссылок меняем 0 на ID текущего
//
// Revision 1.89  2008/05/08 14:04:12  fireton
// - перенос объектов в потоках из ветки
//
// Revision 1.88  2008/03/13 12:54:45  voba
// - rename TCacheAttrData -> TCacheDiffAttrData
//
// Revision 1.87  2008/02/04 13:30:21  lulin
// - базовые списки выделены в отдельные файлы.
//
// Revision 1.86  2007/12/07 09:54:32  voba
// - bug fix
//
// Revision 1.85  2007/11/22 07:35:49  voba
// - enh. фильтруем _k2_idBookmark
// - убили  TSaveDocFilter
//
// Revision 1.84  2007/11/12 13:50:28  voba
// - add attr ServiceInfo
//
// Revision 1.83  2007/10/10 07:00:33  narry
// - добавлен новый класс TUltraLiteSaveFilter - сохраняет только метки
//
// Revision 1.82  2007/08/14 20:25:14  lulin
// - bug fix: не собиралася Архивариус.
//
// Revision 1.81  2007/08/14 19:31:55  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.80  2007/08/09 17:17:09  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.79  2007/08/09 11:19:23  lulin
// - cleanup.
//
// Revision 1.78  2007/02/12 16:10:59  voba
// - заменил использование htModifyRecs на вызов TAbsHtTbl.ModifyRecs
// - выделил TdtTable в модуль dt_Table (обертка вокруг функций HyTech по работе с таблицей целиком)
// - выделил функции HyTech по работе с Sab в dt_Sab, потом объект сделаю
//
// Revision 1.77  2006/12/21 15:17:30  voba
// - new class  TSaveDocFilter2  (замена TSaveDocFilter) Полностью синхронизирует все метки и ссылки при записи. Использует TCacheDiffAttrData для оптимизации записи в базу
//
// Revision 1.76  2006/10/09 12:11:39  voba
// - del SavingType
//
// Revision 1.75  2006/08/23 14:49:13  voba
// - bug fix
//
// Revision 1.74  2005/06/09 16:36:06  voba
// - bug fix вставка классов из клипборда
//
// Revision 1.73  2005/04/08 08:09:02  step
// исправлена TSaveDocFilter.Cleanup (включено игнорирование дубликатов при сливе кэша)
//
// Revision 1.72  2005/03/28 14:30:06  lulin
// - от класса генераторов переходим к интерфейсу.
//
// Revision 1.71  2005/03/28 11:32:25  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.70  2005/03/21 10:05:03  lulin
// - new interface: _Ik2Type.
//
// Revision 1.69  2004/11/26 16:56:59  step
// переименование поля
//
// Revision 1.68  2004/11/26 15:20:13  step
// убраны ловушки
//
// Revision 1.67  2004/11/24 14:25:49  narry
// - add: Ловушка для восстанавливаемых ссылок
//
// Revision 1.66  2004/11/23 15:54:02  step
// вставлена сортировка fSList и fHList
//
// Revision 1.65  2004/11/12 15:05:25  voba
// -bug fix: глючила вставка из клипборда
//
// Revision 1.64  2004/09/21 12:04:19  lulin
// - Release заменил на Cleanup.
//
// Revision 1.63  2004/09/13 13:31:18  voba
// - убрал вывод в лог удаление ссылок/меток из таблиц, это делается в процедурах удаления
//
// Revision 1.62  2004/09/10 16:37:00  voba
// - add вывод в лог удаление ссылок/меток из таблиц
//
// Revision 1.61  2004/09/09 16:15:48  narry
// - bug fix: пропадали ссылки при добавлении текста из файла
//
// Revision 1.60  2004/09/09 12:53:57  voba
// - new behavior : fCacheTblData инициализируются по запросу
//
// Revision 1.59  2004/09/07 09:31:52  voba
// - new behaviour
//        - изменил метод работы с кешом в Clipbord фильтре (стало sctAddOnce)
//        -  получение свободных номеров меток/ссылок теперь из текста
//        - отключил вывод в лог информации о восстановленныз метках/ссылках
//
// Revision 1.58  2004/08/27 12:36:19  voba
// - code clean
//
// Revision 1.57  2004/08/03 08:52:48  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.56  2004/07/07 15:39:11  step
// использование TAbsHtTbl.IgnoreDuplicates
//
// Revision 1.55  2004/07/01 15:29:44  step
// добавлено кеширование HLServer.HLinkTbl;
// из TSaveDocFilter.AddAtomEx убраны сильно тормозящие проверки уникальности ID гиперссылки (по табл. FREE и HLINK)
//
// Revision 1.54  2004/07/01 14:14:26  voba
// - merge newCashe
//
// Revision 1.53  2004/06/28 14:46:30  step
// убрано то, что "через неделю стереть"
//
// Revision 1.52.2.3  2004/06/25 09:08:32  step
// убрано property TSaveDocFilter.Family
//
// Revision 1.52.2.2  2004/06/21 16:38:02  step
// добавлено кеширование на добавление Sub'ов
//
// Revision 1.52.2.1  2004/06/17 18:03:48  step
// В методах TAbsHtTbl.AddRec и TAbsHtTbl.UpdRec убран параметр AbsNum.
//
// Revision 1.52  2004/06/04 12:55:34  voba
// no message
//
// Revision 1.51  2004/05/14 16:58:47  law
// - new units: k2TagTerminator, k2TagFilter.
//
// Revision 1.50  2004/05/14 14:48:59  law
// - исправлены префиксы у констант.
//
// Revision 1.49  2004/05/14 14:29:05  law
// - change: TevVariant переименован в Tk2Variant и переехал в k2Types.
//
// Revision 1.48  2004/03/05 16:50:37  step
// чистка кода
//
// Revision 1.47  2003/08/21 10:19:01  step
// переименование NameFld в NameRFld
//
// Revision 1.46  2003/03/13 14:50:11  demon
// - new: добавлена фильтрация данных ActiveInterval и Alarm при
// работе с Clipboard
//
// Revision 1.45  2003/03/13 09:49:16  demon
// - new: добавлена обработка нового поля в данных документа - VerLink
//
// Revision 1.44  2003/01/17 12:35:52  demon
// - cleanup: удален класс TPutClipboardFilter (его функциональность полностью перекрывается объектом TGetDocumentFilter)
//
// Revision 1.43  2002/10/31 15:39:56  voba
// - bug fix: некорректно обрабатывался тип k2_idDocumentSub.
//
// Revision 1.42  2002/09/18 08:06:11  voba
// - cleanup: удален параметр IsDefault.
//
// Revision 1.41  2002/06/18 15:58:50  voba
// -new behavior : некорректная работа фильтра добавляющего метки в пакетном режиме
//
// Revision 1.40  2002/05/30 11:20:58  demon
// - swap checking Subs in tables and in text
//
// Revision 1.39  2002/05/30 10:28:30  demon
// - bug fix
//
// Revision 1.38  2002/05/30 10:22:33  demon
// - bug fix
//
// Revision 1.37  2002/05/30 09:57:45  demon
// - new behavior: now TGetClipboardFilter is buffered
//
// Revision 1.36  2002/05/10 12:25:22  voba
// no message
//
// Revision 1.35  2002/03/12 15:18:52  demon
// - spellchecking
//
// Revision 1.34  2002/01/16 10:22:10  voba
// -bug fix
//
// Revision 1.33  2002/01/15 16:02:11  demon
// - new behavior: TGetClipboardFilter now filtred all table-tags, that don't need in text
//
// Revision 1.32  2001/12/03 14:10:14  demon
// - bug fix: in TConvertorToInternalFormat.AddAtomEx (adding DictRec)
//
// Revision 1.31  2001/12/03 12:58:05  demon
// - new behavior: now from clipboard may insert "dead" Hyperlinks.
//
// Revision 1.30  2001/11/29 11:40:39  demon
// - new behavior: class TGetClipboardFilter has new property ExpandedFormat
// if its true, from clibboard may get Classes, Types, Suorces and other Dict attr.
//
// Revision 1.29  2001/11/27 13:05:10  demon
// - new class: TConvertorToInternalFormat
//
// Revision 1.28  2001/10/25 14:00:09  law
// - new behavior: уменьшено число обращений к свойству TopType.
//
// Revision 1.27  2001/08/01 12:27:43  demon
// - bug fix: savefilter now checked valid of HLList and SUBList
//
// Revision 1.26.2.1  2001/08/01 12:26:08  demon
// - bug fix: savefilter now checked valid of HLList and SUBList
//
// Revision 1.26  2001/03/21 13:00:12  demon
// - spelling bug fix
//
// Revision 1.25  2001/03/20 15:40:34  demon
// - add checking repaired HLinks in Free Tbl & messages to log
//
// Revision 1.24  2001/03/14 17:38:28  voba
// bug fix
//
// Revision 1.23  2001/03/14 17:22:32  voba
// bug fix
//
// Revision 1.22  2001/03/14 13:57:37  demon
// - some changes in evTag Generators & Filtres
//
// Revision 1.21  2001/03/13 16:16:55  demon
// - fix bug with clearing Hlink and Sub if raise exception
//
// Revision 1.20  2001/03/13 13:29:19  demon
// - in save filtr add checking of HL_ID if repairing
//
// Revision 1.19  2001/02/13 15:35:21  demon
// - bug fix
//
// Revision 1.18  2001/02/13 15:12:20  demon
// - add filtration of HLinkID from clipboard
//
// Revision 1.17  2001/02/07 13:52:43  demon
// - fixed getting HLink Addresses from clipboard
//
// Revision 1.16  2001/01/25 12:50:53  demon
// - in Save Filtr add diagnostic of Equal ID of SUB & HLINK (raise exception)
//
// Revision 1.15  2001/01/23 13:26:32  demon
// - now HyperLink Addres saved in document text too
//
// Revision 1.14  2000/12/19 16:05:18  law
// - убраны ненужные директивы компиляции.
//
// Revision 1.13  2000/12/15 15:36:15  law
// - вставлены директивы Log.
//

{$Include DtDefine.inc}

Interface

uses
  Classes,

  k2TagTerminator,
  k2TagFilter,
  k2Interfaces,

  l3InternalInterfaces, l3Types,
  l3Variant,
  k2Types,l3Base,
  l3DatLst,k2TagGen,
  evdBufferedFilter,

  Dt_Const, Dt_Types, dt_AttrSchema, dt_ImpExpTypes,
  Dt_aTbl, Dt_TblCache, DT_TblCacheDef,
  Dt_Dict, Dt_Renum,
  Dt_IFltr,

  l3ObjectRefArray,

  PIRec_Const,
  Check_Const,
  Stage_const,
  LogRecord_Const,
  Document_Const,
  Hyperlink_Const,
  Address_Const,
  Sub_Const,
  DocumentSub_Const,
  Block_Const,
  DictRec_Const,
  ActiveInterval_Const,
  Alarm_Const,
  NumAndDate_Const,
  AnnoTopic_Const,
  DictEntry_Const
  ;
type
 TClipSubRec = record
  ID       : TSubID;
  Name     : Tl3CustomString;
  RealFl   : Boolean;
  EditFlag : Boolean;
 end;

  TCacheTyp       = (ctxSour,ctxType,ctxBase,ctxKW,ctxClass,ctxHLink,ctxSub,
                     ctxDN_Dt,ctxDN_Lnk,ctxDoc,ctxWarning,ctxStage,ctxActive,ctxAlarm,
                     ctxCh_Dt,ctxCh_Lnk,ctxPubl_Dt,ctxPubl_Lnk,ctxPrefix,ctxTerritory,
                     ctxNorm,ctxAccGroup,ctxAnnoClasses,ctxServiceInfo);

  TCacheTblDataArr = Array[Low(TCacheTyp) .. High(TCacheTyp)] of TCacheTblData;

 TInsertedSubCount = procedure(aCount : LongInt) of object;

 TdtInsertDocAttribute = procedure (aAttr : TCacheType) of object;

(* TGetClipboardFilter = class(Tk2TagTerminator, Il3ObjectWrap)
  { - Вставляет из Clipboard Sub & HLink,
     Так же применяется при вставке текста из файлов
     ExpandedFormat - также вставляет Classes, Types, Sources and other Dict attr}
  protected
   fFamily          : TFamilyID;
   fTargetDocID     : TDocID;
   fExpandedFormat  : Boolean;

   fCurHLAddress    : TGlobalCoordinateRec;
   fCurLinkID       : LongInt;
   fCurSubRec       : TClipSubRec;
   fCurDictType     : TdaDictionaryType;
   fCurDictID       : TDictID;
   fSubItemInserted : TInsertedSubCount;
   //fCheckSubInText  : TCheckSubInText;
   fGetNewHandleID  : TdtGetNewHandleID;

   fDateNumRec      : TImpDateNumRec;
   fPublishRec      : TImpPublishRec;

   fFiltredTag      : LongInt;
   fCurInsSubCount  : LongInt;

   fCacheTblData    : TCacheTblDataArr;
   fCurCacheType    : TCacheTyp;

   function  GetObject: TObject;
        {* - получить объект из обертки. }
   procedure   SetFamily(aValue : TFamilyID);
   procedure   SetTDocID(aValue : TDocID);

   Procedure   ClearIterationData;

   //procedure   InitCacheTblDataArr;
   procedure   DoneCacheTblDataArr;
   procedure   ClearCacheTblDataArr;

   procedure   AddSubRec(NeedUndo : Bool);
   Procedure   AddImpHLRec(NeedUndo : Bool);
   procedure   AddDictRec(NeedUndo : Bool);
   procedure   AddDateNumRec(NeedUndo : Bool);
   procedure   AddPublishRec(NeedUndo : Bool);

   function    DoGetNewHandleID(aType : TdtHandleIDType; var aHandleID : Integer) : boolean;

   procedure   AddAtomEx(AtomIndex : Long; const Value : Tk2Variant); override;

   procedure   BeforeRelease; override;

   function    GetCacheTblData(aIndex : TCacheTyp) : TCacheTblData;
  public
   procedure   StartChild(TypeID : Tl3VariantDef); override;
   procedure   StartTag(TagID : Long); override;

   procedure   CloseStructure(NeedUndo : Bool); override;

   procedure   OpenStream; override;
   procedure   CloseStream(NeedUndo : Boolean); override;

   property    Family : TFamilyID read fFamily write SetFamily;
   property    TargetDocID : TDocID read fTargetDocID write SetTDocID;
   property    ExpandedFormat : Boolean read fExpandedFormat write fExpandedFormat;
    {* - if its true, from clibboard may get Classes, Types, Sources and other Dict attr.}

   property    OnSubItemInserted : TInsertedSubCount read fSubItemInserted write fSubItemInserted;
   property    OnGetNewHandleID : TdtGetNewHandleID read fGetNewHandleID write fGetNewHandleID;

   property    CacheTblData[aIndex : TCacheTyp] : TCacheTblData read GetCacheTblData;
 end;
*)

 TGetClipboardLightFilter = class(TevdBufferedFilter, Il3ObjectWrap)
  { - Light версия
     Вставляет из Clipboard Sub & HLink,
     Так же применяется при вставке текста из файлов
     ExpandedFormat - также вставляет Classes, Types, Sources and other Dict attr}
  protected
   fFamily : TFamilyID;
   fExternalDocData : Boolean;
   fOnGetNewHandleID  : TdtGetNewHandleID;
   fOnInsertDocAttribute : TdtInsertDocAttribute;

   fFiltredTag      : LongInt;
   fDictDecoder     : TDictItemDecoder;
   fExpandedFormat  : Boolean;

   function  GetObject: TObject;
        {* - получить объект из обертки. }

   function    DoGetNewHandleID(aType : TdtHandleIDType; var aHandleID : Integer) : boolean;
   procedure   DoInsertDocAttribute(aAttr : TCacheType);

   procedure   AddAtomEx(AtomIndex : Long; const Value : Tk2Variant); override;

   procedure   BeforeRelease; override;

   function  NeedStartBuffering(aID : Integer): Boolean; override;
    {* - Функция, определяющая тип Тегов, для которых будет выполняться буферизация.}
   function  NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean; override;
    {* - Определяет нужно ли сбрасывать Тег в трубу.  }

   function DictDecoder  : TDictItemDecoder;
  public
   property    Family : TFamilyID read fFamily write fFamily;

   property    ExternalDocData : Boolean read fExternalDocData write fExternalDocData;
    {* - Данные идут из внешнего источника, DictID не правильный}

   property    OnGetNewHandleID : TdtGetNewHandleID read fOnGetNewHandleID write fOnGetNewHandleID;
   property    OnInsertDocAttribute : TdtInsertDocAttribute {read fInsertDocAttribute} write fOnInsertDocAttribute;
   property    ExpandedFormat : Boolean read fExpandedFormat write fExpandedFormat;

 end;

(* TConvertorToInternalFormat = class(Tk2TagTerminator)
  protected
   fFamily        : TFamilyID;
   fLevelSlash    : AnsiString;

   fBasesList,
   fWarningsList,
   fNormsList,
   fAccGroupsList : Tl3StringDataList;
   fDictTrees     : array [da_dlSources..da_dlAccGroups] of TDictRootNode;

   fReNumTbl      : TReNumTbl;

   fCurDocID      : TDocID;
   fImpDictRec    : TImpDictRec;

   procedure   SetFamily(aValue : TFamilyID);
   procedure   SetLevelSlash(aValue : AnsiString);

   procedure   ClearDataStorage;

   procedure   InitLists;
   procedure   DoneLists;

   function    ConvertDictRec : TDictID;

   procedure   AddAtomEx(AtomIndex : Long; const Value : Tk2Variant); override;
  public
   constructor Create(aOwner : Tk2TagGeneratorOwner); override;

   {Main Data Initialization}
   procedure   OpenStream; override;
   procedure   CloseStream(NeedUndo : Boolean); override;

   procedure   StartChild(TypeID : Tl3VariantDef); override;
   procedure   StartTag(TagID : Long); override;

   procedure   CloseStructure(NeedUndo : Bool); override;

   property    Family : TFamilyID read fFamily write SetFamily;
   property    LevelSlash : AnsiString read fLevelSlash write SetLevelSlash;
 end;
*)

 THLinkAddrToInternal = class(Tk2TagFilter)
 { - заменяет в гиперссылках внешние номера на внутренние}
  protected
   fFamily        : TFamilyID;
   fReNumTbl      : TReNumTbl;

   procedure   SetFamily(aValue : TFamilyID);
   procedure   AddAtomEx(AtomIndex : Long; const Value : Tk2Variant); override;
  public
   property    Family : TFamilyID read fFamily write SetFamily;
 end;


(* TSaveDocFilter2 = class(TevdTagKeeperFilter)
  {* - Восстанавливает недостающие Sub & HLink, при сохранении документа
       Если HLink с неким ID уже был записан в таблицу, а в тексте адреса поменялись - синхронизации НЕ будет. }

  function  NeedKeepThisTag(aID : Integer) : Boolean;
   override;
  procedure DoKeepComplete;
   override;

 protected
  fFamily        : TFamilyID;
  fCurDocID      : TDocID;
  fCacheAttrData : Tl3ObjectRefArray;

  function AttrData(aAttrType : TCacheType): TCacheDiffAttrData;
  procedure SetFamily(aValue : TFamilyID);
  procedure SetCurDocID(aValue : TDocID);
 public
  constructor Create(anOwner : TComponent; aFamily : TFamilyID);
  procedure   CloseStream(NeedUndo : Boolean);
   override;
  procedure   CloseStructure(NeedUndo: Bool);
   override;
         {-}
  procedure StartChild(TypeID: Tl3VariantDef); override;
  class function SetTo(var aGenerator: Tk2TagGenerator; aFamily: TFamilyID; aDocID: TDocID): Tk2TagGenerator; overload;
  property    CurDocID : TDocID read fCurDocID write SetCurDocID;
 end;
 *)

 // Нужен alcuDocument
 TUltraLiteSaveDocFilter = class(TevdTagKeeperFilter)

  function  NeedKeepThisTag(aID : Integer) : Boolean;
   override;
  procedure DoKeepComplete;
   override;

 protected
  fFamily        : TFamilyID;
  fCurDocID      : TDocID;
  fCacheAttrData : Tl3ObjectRefArray;

  function AttrData(aAttrType : TCacheType): TCacheDiffAttrData;
  procedure SetFamily(aValue : TFamilyID);
  procedure SetCurDocID(aValue : TDocID);
 public
  constructor Create(anOwner : TComponent; aFamily : TFamilyID);
  procedure CloseStream(NeedUndo : Boolean);
   override;
  procedure CloseStructure(NeedUndo: Bool);
   override;
         {-}
  procedure StartChild(TypeID: Tl3VariantDef); override;
  property  CurDocID : TDocID read fCurDocID write SetCurDocID;
 end;

implementation

uses
  SysUtils,

  l3Interfaces,
  l3String,
  l3Chars,
  l3Tree_TLB,
  l3Nodes,
  l3Date,

  k2Tags,
  k2Base,
  k2Facade,

  daTypes,

  Dt_Serv,
  Dt_Hyper,
  Dt_Err,
  Dt_Link,
  Dt_LinkServ,

  Bookmark_Const,
  LeafPara_Const
  , dt_DictConst, dt_DictIntf, l3PrimString,

  k2VariantImpl
  ;


const
 ifFiltredTags : set of Tk2TagID = [_k2_tiGroups,           {-группы}
                                    _k2_tiSources,          {-источники}
                                    _k2_tiTypes,            {-типы}
                                    _k2_tiClasses,          {-классы}
                                    _k2_tiKeyWords,         {-ключевые слова}
                                    _k2_tiWarnings,         {-предупреждения}
                                    _k2_tiNumANDDates,      {-записи ДатаНомер}
                                    _k2_tiLogRecords,       {-записи Журнала изменений}
                                    _k2_tiStages,           {-этапы}
                                    _k2_tiActiveIntervals,  {-интервалы действия}
                                    _k2_tiAlarms,           {-"звоночки"}
                                    _k2_tiChecks,           {-вычитка}
                                    _k2_tiPublishedIn,      {-публикации}
                                    _k2_tiPrefix,           {-}
                                    _k2_tiTerritory,        {-}
                                    _k2_tiNorm,             {-нормы права}
                                    _k2_tiAccGroups         {-группы доступа}
                                   ];

(*
//****************************** TGetClipboardFilter **************************************

{Protected methods}
procedure TGetClipboardFilter.BeforeRelease;
begin
 try
  ClearIterationData;
  ClearCacheTblDataArr;
 finally
  inherited;
 end;
end;

function TGetClipboardFilter.GetObject: TObject;
  {* - получить объект из обертки. }
begin
 Result := Self;
end;

procedure TGetClipboardFilter.SetFamily(aValue : TFamilyID);
begin
 if fFamily <> aValue then
 begin
  if StreamOpened then // in Process
   raise EHtErrors.CreateInt(ecNotEnable)
  else
   fFamily:=aValue;
 end;
 fCurHLAddress.Family:=fFamily;
end;

procedure TGetClipboardFilter.SetTDocID(aValue : TDocID);
begin
 if fTargetDocID <> aValue then
 begin
  if StreamOpened then // in Process
   raise EHtErrors.CreateInt(ecNotEnable)
  else
   fTargetDocID:=aValue;
 end;
end;

procedure TGetClipboardFilter.ClearIterationData;
begin
 L3Free(fDateNumRec.Number);
 l3FillChar(fDateNumRec,SizeOf(fDateNumRec));
 L3Free(fPublishRec.Number);
 L3Free(fPublishRec.Comment);
 l3FillChar(fPublishRec,SizeOf(fPublishRec));
 fCurLinkID:=0;
 fCurDictID:=0;
 fCurDictType:=da_dlNone;
 l3Free(fCurSubRec.Name);
 l3FillChar(fCurSubRec,SizeOf(fCurSubRec));
 fCurHLAddress.Doc:=0;
 fCurHLAddress.Sub:=0;
 fFiltredTag:=-1;
 fCurInsSubCount:=0;
end;

function  TGetClipboardFilter.GetCacheTblData(aIndex : TCacheTyp) : TCacheTblData;
begin
 if not Assigned(fCacheTblData[aIndex]) then
  case aIndex of
   ctxSour      : fCacheTblData[aIndex] := TCacheTblData.Create(LinkServer(fFamily)[atSources].Table);
   ctxType      : fCacheTblData[aIndex] := TCacheTblData.Create(LinkServer(fFamily)[atTypes].Table);
   ctxBase      : fCacheTblData[aIndex] := TCacheTblData.Create(LinkServer(fFamily)[atBases].Table);
   ctxKW        : fCacheTblData[aIndex] := TCacheTblData.Create(LinkServer(fFamily)[atKeyWords].Table);
   ctxClass     : fCacheTblData[aIndex] := TCacheTblData.Create(LinkServer(fFamily)[atClasses].Table);
   ctxHLink     : fCacheTblData[aIndex] := TCacheTblData.Create(LinkServer(fFamily)[atHLink].Table);
   ctxSub       : fCacheTblData[aIndex] := TCacheTblData.Create(LinkServer(fFamily)[atSub].Table);
   ctxDN_Dt     : fCacheTblData[aIndex] := TCacheTblData.Create(DictServer(Family).GroupTbl[da_dlDateNums]);
   ctxDN_Lnk    : fCacheTblData[aIndex] := TCacheTblData.Create(LinkServer(fFamily)[atDateNums].Table);
   ctxWarning   : fCacheTblData[aIndex] := TCacheTblData.Create(LinkServer(fFamily)[atWarnings].Table);
   ctxPubl_Dt   : fCacheTblData[aIndex] := TCacheTblData.Create(DictServer(Family).GroupTbl[da_dlPublisheds]);
   ctxPubl_Lnk  : fCacheTblData[aIndex] := TCacheTblData.Create(LinkServer(fFamily)[atPublisheds].Table);
   ctxPrefix    : fCacheTblData[aIndex] := TCacheTblData.Create(LinkServer(fFamily)[atPrefixes].Table);
   ctxTerritory : fCacheTblData[aIndex] := TCacheTblData.Create(LinkServer(fFamily)[atTerritories].Table);
   ctxNorm      : fCacheTblData[aIndex] := TCacheTblData.Create(LinkServer(fFamily)[atNorms].Table);
   ctxAccGroup  : fCacheTblData[aIndex] := TCacheTblData.Create(LinkServer(fFamily)[atAccGroups].Table);
   ctxServiceInfo: fCacheTblData[aIndex] := TCacheTblData.Create(LinkServer(fFamily)[atServiceInfo].Table);
  else
   fCacheTblData[aIndex] := nil;
  end;

 Result := fCacheTblData[aIndex];
end;

{
procedure TGetClipboardFilter.InitCacheTblDataArr;
var
 I : TCacheTyp;
begin
 for I:=Low(TCacheTyp) to High(TCacheTyp) do
 begin
  if Assigned(fCacheTblData[I]) then
   fCacheTblData[I].Clear
  else // TODO -ovoba -cПодозрение : !! А что если были предыдущие данные и их почистили инициировать уже не надо
   Case I of
    ctSour      : fCacheTblData[I]:=TCacheTblData.Create(LinkServer(fFamily)[da_dlSources]);
    ctType      : fCacheTblData[I]:=TCacheTblData.Create(LinkServer(fFamily)[da_dlTypes]);
    ctBase      : fCacheTblData[I]:=TCacheTblData.Create(LinkServer(fFamily)[da_dlBases]);
    ctKW        : fCacheTblData[I]:=TCacheTblData.Create(LinkServer(fFamily)[da_dlKeyWords]);
    ctClass     : fCacheTblData[I]:=TCacheTblData.Create(LinkServer(fFamily)[da_dlClasses]);
    ctHLink     : fCacheTblData[I]:=TCacheTblData.Create(HLServer.HLinkTbl);
    ctSub       : fCacheTblData[I]:=TCacheTblData.Create(HLServer.SubTbl);
    ctDN_Dt     : fCacheTblData[I]:=TCacheTblData.Create(DictServer(Family).GroupTbl[da_dlDateNums]);
    ctDN_Lnk    : fCacheTblData[I]:=TCacheTblData.Create(LinkServer(fFamily)[da_dlDateNums]);
    ctWarning   : fCacheTblData[I]:=TCacheTblData.Create(LinkServer(fFamily)[da_dlWarnings]);
    ctPubl_Dt   : fCacheTblData[I]:=TCacheTblData.Create(DictServer(Family).GroupTbl[da_dlPublisheds]);
    ctPubl_Lnk  : fCacheTblData[I]:=TCacheTblData.Create(LinkServer(fFamily)[da_dlPublisheds]);
    ctPrefix    : fCacheTblData[I]:=TCacheTblData.Create(LinkServer(fFamily)[da_dlPrefixes]);
    ctTerritory : fCacheTblData[I]:=TCacheTblData.Create(LinkServer(fFamily)[da_dlTerritories]);
    ctNorm      : fCacheTblData[I]:=TCacheTblData.Create(LinkServer(fFamily)[da_dlNorms]);
    ctAccGroup  : fCacheTblData[I]:=TCacheTblData.Create(LinkServer(fFamily)[da_dlAccGroups]);
   else
    fCacheTblData[I]:=nil;
   end;

  if Assigned(fCacheTblData[I]) then
   fCacheTblData[I].SavingType := sctAddOnce;
 end;
end;
}

procedure TGetClipboardFilter.DoneCacheTblDataArr;
var
 aCT : TCacheTyp;
begin
 for aCT:=Low(TCacheTyp) to High(TCacheTyp) do
  if Assigned(fCacheTblData[aCT]) then
   fCacheTblData[aCT].Save;
end;

procedure TGetClipboardFilter.ClearCacheTblDataArr;
var
 aCT : TCacheTyp;
begin
 for aCT:=Low(TCacheTyp) to High(TCacheTyp) do
  l3Free(fCacheTblData[aCT]);
 l3FillChar(fCacheTblData,SizeOf(TCacheTblDataArr));
end;

procedure TGetClipboardFilter.AddSubRec(NeedUndo : Bool);
var
 TmpPChar  : PAnsiChar;
begin
 if not NeedUndo then
 begin
  if fCurSubRec.EditFlag then
  begin
   if Assigned(fCurSubRec.Name) then
    LinkServer(fFamily).SubTbl.PureEditSubName(fTargetDocID, fCurSubRec.ID,fCurSubRec.Name.St,fCurSubRec.RealFl)
   else
    LinkServer(fFamily).SubTbl.PureEditSubName(fTargetDocID, fCurSubRec.ID,nil,False);
  end
  else
  begin
   CacheTblData[ctxSub].TblObj.ClearFullRec;
   try
    CacheTblData[ctxSub].TblObj.PutToFullRec(subDID_fld,fTargetDocID);
    CacheTblData[ctxSub].TblObj.PutToFullRec(subSID_fld,fCurSubRec.ID);
    if Assigned(fCurSubRec.Name) then
    begin
     TmpPChar:=fCurSubRec.Name.St;
     CacheTblData[ctxSub].TblObj.PutToFullRec(subRFlag_fld,fCurSubRec.RealFl);
     CacheTblData[ctxSub].TblObj.PutToFullRec(subName_fld,TmpPChar);
    end;
   finally
    CacheTblData[ctxSub].AddCurDataToCache;
   end;
  end;
 end;

 L3Free(fCurSubRec.Name);
 l3FillChar(fCurSubRec,SizeOf(fCurSubRec));
 Inc(fCurInsSubCount);
end;

procedure TGetClipboardFilter.AddImpHLRec(NeedUndo : Bool);
begin

 // отключили запись в таблицы в борьбе за скорость,
 // в таблицы должно попасть при сохранении
 {
 if not NeedUndo then
 begin
  if fCurLinkID = 0 then
   fCurLinkID:=CacheTblData[ctHLink].TblObj.GetFreeNum;
  CacheTblData[ctHLink].TblObj.ClearFullRec;
  try
   CacheTblData[ctHLink].TblObj.PutToFullRec(hlID_fld,fCurLinkID);
   CacheTblData[ctHLink].TblObj.PutToFullRec(hlSourD_fld,fTargetDocID);
   CacheTblData[ctHLink].TblObj.PutToFullRec(hlDestD_fld,fCurHLAddress.Doc);
   CacheTblData[ctHLink].TblObj.PutToFullRec(hlDestS_fld,fCurHLAddress.Sub);
  finally
   CacheTblData[ctHLink].AddCurDataToCache;
  end;
 end;
 }
 fCurHLAddress.Doc:=0;
 fCurHLAddress.Sub:=0;
end;

procedure TGetClipboardFilter.AddDictRec(NeedUndo : Bool);
var
 CurTblObj : TPrometTbl;
begin
 if not NeedUndo then
 begin
  if (fCurDictType <> da_dlNone) and
     (fCurDictID <> 0) then
  begin
   case fCurDictType of
    da_dlBases,
    da_dlAccGroups,
    da_dlSources,
    da_dlTerritories,
    da_dlWarnings,
    da_dlNorms:
    begin
     CurTblObj:=CacheTblData[fCurCacheType].TblObj;
     CurTblObj.ClearFullRec;
     try
      CurTblObj.PutToFullRec(lnkDocIDFld,fTargetDocID);
      CurTblObj.PutToFullRec(lnkDictIDFld,fCurDictID);
     finally
      CacheTblData[fCurCacheType].AddCurDataToCache;
     end;
    end;
    da_dlTypes,
    da_dlClasses,
    da_dlKeyWords,
    da_dlPrefixes,
    da_dlServiceInfo:
    begin
     CurTblObj:=CacheTblData[fCurCacheType].TblObj;
     CurTblObj.ClearFullRec;
     try
      CurTblObj.PutToFullRec(lnkDocIDFld,fTargetDocID);
      CurTblObj.PutToFullRec(lnkDictIDFld,fCurDictID);
      CurTblObj.PutToFullRec(lnkSubIDfld,fCurSubRec.ID);
     finally
      CacheTblData[fCurCacheType].AddCurDataToCache;
     end;
    end;
    da_dlCorSources:
     if TopType[1].IsKindOf(k2_typPIRec) then fPublishRec.Sour:=fCurDictID;
   end;
  end;
 end;
 fCurDictType:=da_dlNone;
 fCurDictID:=0;
end;

procedure TGetClipboardFilter.AddDateNumRec(NeedUndo : Bool);
var
 HaveSomeData : Boolean;
 CurDN_ID     : LongInt;
 TmpPChar     : PAnsiChar;
begin
 if not NeedUndo then
 begin
  HaveSomeData:=False;
  CurDN_ID:=CacheTblData[ctxDN_Dt].TblObj.GetFreeNum;
  CacheTblData[ctxDN_Dt].TblObj.ClearFullRec;
  try
   CacheTblData[ctxDN_Dt].TblObj.PutToFullRec(dnIDFld,CurDN_ID);
   CacheTblData[ctxDN_Dt].TblObj.PutToFullRec(dnTypFld,fDateNumRec.DNType);
   if fDateNumRec.DNType = dnMU then
    HaveSomeData:=True;
   if fDateNumRec.Date<>0 then
   begin
    CacheTblData[ctxDN_Dt].TblObj.PutToFullRec(dnDateFld,fDateNumRec.Date);
    HaveSomeData:=True;
   end;
   if Assigned(fDateNumRec.Number) then
   begin
    TmpPChar:=fDateNumRec.Number.St;
    CacheTblData[ctxDN_Dt].TblObj.PutToFullRec(dnNumFld,TmpPChar);
    HaveSomeData:=True;
   end;
  finally
   if HaveSomeData then
   begin
    CacheTblData[ctxDN_Dt].AddCurDataToCache;

    CacheTblData[ctxDN_Lnk].TblObj.ClearFullRec;
    try
     CacheTblData[ctxDN_Lnk].TblObj.PutToFullRec(lnkDocIDFld,fTargetDocID);
     CacheTblData[ctxDN_Lnk].TblObj.PutToFullRec(lnkDictIDFld,CurDN_ID);
    finally
     CacheTblData[ctxDN_Lnk].AddCurDataToCache;
    end;
   end;
  end;
 end;

 L3Free(fDateNumRec.Number);
 l3FillChar(fDateNumRec,SizeOf(fDateNumRec));
end;

procedure TGetClipboardFilter.AddPublishRec(NeedUndo : Bool);
var
 TmpPChar      : PAnsiChar;
 CurPub_ID     : LongInt;
 HaveSomeData  : Boolean;
begin
 if not NeedUndo then
 begin
  HaveSomeData:=False;
  CurPub_ID:=CacheTblData[ctxPubl_Dt].TblObj.GetFreeNum;
  CacheTblData[ctxPubl_Dt].TblObj.ClearFullRec;
  try
   CacheTblData[ctxPubl_Dt].TblObj.PutToFullRec(piIDFld,CurPub_ID);
   if (fPublishRec.Sour<>0) and (fPublishRec.SDate<>0) then
   begin
    CacheTblData[ctxPubl_Dt].TblObj.PutToFullRec(piSourFld,fPublishRec.Sour);
    CacheTblData[ctxPubl_Dt].TblObj.PutToFullRec(piSDateFld,fPublishRec.SDate);
    HaveSomeData:=True;
   end;
   if HaveSomeData then
   begin
    if fPublishRec.EDate<>0 then
     CacheTblData[ctxPubl_Dt].TblObj.PutToFullRec(piEDateFld,fPublishRec.EDate)
    else
     CacheTblData[ctxPubl_Dt].TblObj.PutToFullRec(piEDateFld,fPublishRec.SDate);

    if Assigned(fPublishRec.Number) then
    begin
     TmpPChar:=fPublishRec.Number.St;
     CacheTblData[ctxPubl_Dt].TblObj.PutToFullRec(piNumberFld,TmpPChar);
    end;

    if Assigned(fPublishRec.Comment) then
    begin
     TmpPChar:=fPublishRec.Comment.St;
     CacheTblData[ctxPubl_Dt].TblObj.PutToFullRec(piCommentFld,TmpPChar);
    end;
   end;
  finally
   if HaveSomeData then
   begin
    CacheTblData[ctxPubl_Dt].AddCurDataToCache;

    CacheTblData[ctxPubl_Lnk].TblObj.ClearFullRec;
    try
     CacheTblData[ctxPubl_Lnk].TblObj.PutToFullRec(lnkDocIDFld,fTargetDocID);
     CacheTblData[ctxPubl_Lnk].TblObj.PutToFullRec(lnkDictIDFld,CurPub_ID);
    finally
     CacheTblData[ctxPubl_Lnk].AddCurDataToCache;
    end;
   end;
  end;
 end;

 L3Free(fPublishRec.Number);
 L3Free(fPublishRec.Comment);
 l3FillChar(fPublishRec,SizeOf(fPublishRec));
end;

function TGetClipboardFilter.DoGetNewHandleID(aType : TdtHandleIDType; var aHandleID : Integer) : boolean;
begin
 Result := False;
 if Assigned(fGetNewHandleID) then
 begin
  fGetNewHandleID(aType, aHandleID);
  Result := aHandleID > 0;
 end;
end;

procedure TGetClipboardFilter.AddAtomEx(AtomIndex : Long; const Value : Tk2Variant);
var
 lSubID      : TSubID;
 lHLinkID    : Integer;
 //TmpLI       : LongInt;
 CT          : Tk2Type;
begin
 CT := CurrentType;
 if CT.IsKindOf(k2_typDocument) then // фильтрация элементарных полей документа
 begin
  if (AtomIndex in [k2_tiInternalHandle,k2_tiExternalHandle,k2_tiType,k2_tiShortName,
                   k2_tiName,k2_tiUserType,k2_tiPriceLevel,k2_tiSortDate,
                   k2_tiPriority,k2_tiRelInternalHandle,k2_tiRelExternalHandle,
                   k2_tiInternalVerLink,k2_tiExternalVerLink]) then
   exit;
 end
 else
  if CT.IsKindOf(k2_typHyperLink) then // заполнение записи: гипертекстовая ссылка
  begin
   if (AtomIndex = k2_tiHandle) then
   begin
    if DoGetNewHandleID(dt_hidHyperlink, lHLinkID) then
    begin
     Generator.AddIntegerAtom(AtomIndex, lHLinkID);
     fCurLinkID := lHLinkID;
    end;
    exit;
   end
  end
  else
   if CT.IsKindOf(k2_typAddress) and // заполнение записи: адрес (гипертекстовая ссылка)
      TopType[1].IsKindOf(k2_typHyperLink) then
   begin
    if (AtomIndex = k2_tiDocID) then
    begin
     if (Value.Kind=k2_vkInteger) then
      fCurHLAddress.Doc:=TDocID(Value.AsInteger)
     else
      ConvertErrorEx(Value.Kind);
    end
    else
     if (AtomIndex = k2_tiSubID) then
     begin
      if (Value.Kind=k2_vkInteger) then
       fCurHLAddress.Sub:=TSubID(Value.AsInteger)
      else
       ConvertErrorEx(Value.Kind);
     end;
   end
   else
   if CT.IsKindOf(k2_typDocumentSub) or
      CT.IsKindOf(k2_typBookmark) then
   begin
    // - здесь специально ничего не делаем !!!
   end
   else
    if CT.IsKindOf(k2_typSub) and // заполнение записи: точка входа (Sub)
       not CT.IsKindOf(k2_typDocument) then
    begin
     if (AtomIndex = k2_tiHandle) then
     begin
      if (Value.Kind = k2_vkInteger) then
      begin
       lSubID := TSubID(Value.AsInteger);
       if DoGetNewHandleID(dt_hidSub, lSubID) then
       begin
        fCurSubRec.ID := lSubID;
        fCurSubRec.EditFlag := False;
        Generator.AddIntegerAtom(AtomIndex, lSubID);
        exit;
       end
       else
        if LinkServer(fFamily).SubTbl.CheckDocSub(fTargetDocID, lSubID) then
        begin
         //TmpLI:=HLServer.GetNewDocSub;
         fCurSubRec.ID := lSubID; //TSubID(TmpLI);
         fCurSubRec.EditFlag:=True;
        end
        else
        begin
         fCurSubRec.ID:=lSubID;
         fCurSubRec.EditFlag:=False;
        end;
      end
      else
       ConvertErrorEx(Value.Kind)
     end
     else
      if (AtomIndex = k2_tiShortName) then
      begin
       if (Value.Kind=k2_vkString) then
       begin
        l3Set(fCurSubRec.Name,Value.AsString);
        fCurSubRec.RealFl:=True;
       end
       else
        ConvertErrorEx(Value.Kind)
      end
      else
       if (AtomIndex = k2_tiName) then
       begin
        if (Value.Kind=k2_vkString) then
        begin
         l3Set(fCurSubRec.Name,Value.AsString);
         fCurSubRec.RealFl:=False;
        end
        else
         ConvertErrorEx(Value.Kind);
       end;
    end
    else
     if fExpandedFormat then
     begin
      if CT.IsKindOf(k2_typDictRec) then // заполнение записи: элемент словаря
      begin
       if (AtomIndex = k2_tiHandle) then
       begin
        if (Value.Kind=k2_vkInteger) then
         fCurDictID:=TDictID(Value.AsInteger)
        else
         ConvertErrorEx(Value.Kind);
       end;
       exit;
      end
      else
       if CT.IsKindOf(k2_typStage) then // фильтрация записи: этап обработки
        exit
       else
        if CT.IsKindOf(k2_typActiveInterval) then // фильтрация записи: интервал действия
         exit
        else
         if CT.IsKindOf(k2_typAlarm) then // фильтрация записи: "звоночек"
          exit
         else
          if CT.IsKindOf(k2_typNumAndDate) then // заполнение записи: дата-номер
          begin
           if (AtomIndex = k2_tiType) then
           begin
            if (Value.Kind=k2_vkInteger) then
             fDateNumRec.DNType:=TDNType(Value.AsInteger)
            else
             ConvertErrorEx(Value.Kind);
           end
           else
            if (AtomIndex = k2_tiStart) then
            begin
             if (Value.Kind=k2_vkInteger) then
              fDateNumRec.Date:=TStDate(Value.AsInteger)
             else
              ConvertErrorEx(Value.Kind);
            end
            else
             if (AtomIndex = k2_tiNumber) then
             begin
              if (Value.Kind=k2_vkString) then
              begin
               l3Set(fDateNumRec.Number,Value.AsString);
               fDateNumRec.Number.CodePage:=cp_ANSI;
              end
              else
               ConvertErrorEx(Value.Kind);
             end
             else
              if (AtomIndex = k2_tiComment) then
              begin
               if (Value.Kind=k2_vkString) then
               begin
                // поле Comment удалено из дат/номеров
                //l3Set(fDateNumRec.Comment,Value.AsString);
                //fDateNumRec.Comment.CodePage:=cp_ANSI;
               end
               else
                ConvertErrorEx(Value.Kind);
              end;
           exit;
          end
          else
           if CT.IsKindOf(k2_typCheck) then // фильтрация записи: элемент вычитки
            exit
           else
            if CT.IsKindOf(k2_typPIRec) then // заполнение записи: элемент публикации
            begin
             if (AtomIndex = k2_tiStart) then
             begin
              if (Value.Kind=k2_vkInteger) then
               fPublishRec.SDate:=TStDate(Value.AsInteger)
              else
               ConvertErrorEx(Value.Kind);
             end
             else
              if (AtomIndex = k2_tiFinish) then
              begin
               if (Value.Kind=k2_vkInteger) then
                fPublishRec.EDate:=TStDate(Value.AsInteger)
               else
                ConvertErrorEx(Value.Kind);
              end
              else
               if (AtomIndex = k2_tiNumber) then
               begin
                if (Value.Kind=k2_vkString) then
                begin
                 l3Set(fPublishRec.Number,Value.AsString);
                 fPublishRec.Number.CodePage:=cp_ANSI;
                end
                else
                 ConvertErrorEx(Value.Kind)
               end
               else
                if (AtomIndex = k2_tiComment) then
                begin
                 if (Value.Kind=k2_vkString) then
                 begin
                  l3Set(fPublishRec.Comment,Value.AsString);
                  fPublishRec.Comment.CodePage:=cp_ANSI;
                 end
                 else
                  ConvertErrorEx(Value.Kind);
                end;
             exit;
            end
            else
             If CT.IsKindOf(k2_typLogRecord) then // фильтрация записи: элемент журнала
              exit;
     end
     else
      if CT.IsKindOf(k2_typDictRec) or
         CT.IsKindOf(k2_typStage) or
         CT.IsKindOf(k2_typActiveInterval) or
         CT.IsKindOf(k2_typAlarm) or
         CT.IsKindOf(k2_typNumAndDate) or
         CT.IsKindOf(k2_typCheck) or
         CT.IsKindOf(k2_typPIRec) or
         CT.IsKindOf(k2_typLogRecord) then
       exit;

 if (fFiltredTag <> -1) then
  if TopObject[0].IsProp AND
     (TopObject[0].AsProp.TagIndex = fFiltredTag) then
   Exit;

 Generator.AddAtomEx(AtomIndex,Value);
end;
{End Protected methods}

{Public methods}
procedure TGetClipboardFilter.StartChild(TypeID : Tl3VariantDef);
var
 CT     : Tk2Type;
 curObj : Tk2CustomPropertyPrim;
begin
 inherited;
 CT := CurrentType;
 if CT.IsKindOf(k2_typHyperLink) then
 begin
  fCurLinkID:=0;
  fCurHLAddress.Doc:=0;
  fCurHLAddress.Sub:=0;
 end
 else
  if (CT.IsKindOf(k2_typSub) and
     not CT.IsKindOf(k2_typDocumentSub) and
     not CT.IsKindOf(k2_typDocument) and
     not CT.IsKindOf(k2_typBookmark)) then
  begin
   if (fFamily<>0) and (fTargetDocID<>0) and (fCurSubRec.ID<>0) then
    AddSubRec(False)
   else
    fCurSubRec.ID:=0;
  end
  else
   if fExpandedFormat then
   begin
    if CT.IsKindOf(k2_typDictRec) and
       (TopObject[1].isProp) then
    begin
     fCurDictID:=0;
     curObj:=TopObject[1].AsProp;
     case CurObj.TagIndex of
      k2_tiGroups:
       begin
        fCurDictType:=da_dlBases;
        fCurCacheType:=ctxBase;
       end;
      k2_tiSources:
       begin
        fCurDictType:=da_dlSources;
        fCurCacheType:=ctxSour;
       end;
      k2_tiTypes:
       begin
        fCurDictType:=da_dlTypes;
        fCurCacheType:=ctxType;
       end;
      k2_tiClasses:
       begin
        fCurDictType:=da_dlClasses;
        fCurCacheType:=ctxClass;
       end;
      k2_tiKeyWords:
       begin
        fCurDictType:=da_dlKeyWords;
        fCurCacheType:=ctxKW;
       end;
      k2_tiWarnings:
       begin
        fCurDictType:=da_dlWarnings;
        fCurCacheType:=ctxWarning;
       end;
      k2_tiPrefix:
       begin
        fCurDictType:=da_dlPrefixes;
        fCurCacheType:=ctxPrefix;
       end;
      k2_tiTerritory:
       begin
        fCurDictType:=da_dlTerritories;
        fCurCacheType:=ctxTerritory;
       end;
      k2_tiNorm:
       begin
        fCurDictType:=da_dlNorms;
        fCurCacheType:=ctxNorm;
       end;
      k2_tiAccGroups:
       begin
        fCurDictType:=da_dlAccGroups;
        fCurCacheType:=ctxAccGroup;
       end;
      k2_tiServiceInfo:
       begin
        fCurDictType:=da_dlServiceInfo;
        fCurCacheType:=ctxServiceInfo;
       end;
     end;
    end;
   end;

 if (fFiltredTag = -1) then
  Generator.StartChild(TypeID);
end;

procedure TGetClipboardFilter.StartTag(TagID : Long);
begin
 inherited;
 if fExpandedFormat then
 begin
  if TopType[0].IsKindOf(k2_typDictRec) and
     (TopObject[0].isProp) then
  begin
   fCurDictID := 0;
   if (TopObject[0].AsProp.TagIndex = k2_tiSource) then
    fCurDictType := da_dlCorSources;
  end;
 end
 else
  if (Tk2TagID(TagID) in ifFiltredTags) then
   fFiltredTag := TagID;

 if (fFiltredTag = -1) then
  Generator.StartTag(TagID);
end;

procedure TGetClipboardFilter.CloseStructure(NeedUndo : Bool);
var
 CT : Tk2Type;
begin
 if not NeedUndo then
 begin
  CT := CurrentType;
  if CT.IsKindOf(k2_typHyperLink) then
  begin
   if (fCurLinkID = 0) and DoGetNewHandleID(dt_hidHyperlink, fCurLinkID) then
     Generator.AddIntegerAtom(k2_tiHandle, fCurLinkID);
   {
   if fCurLinkID <> 0 then
    Generator.AddIntegerAtom(k2_tiHandle,fCurLinkID);
   Generator.Finish(fCurLinkID = 0);
   }
   Generator.Finish;
  end
  else
   if CT.IsKindOf(k2_typAddress) and TopType[1].IsKindOf(k2_typHyperLink) then
   begin
    if (fFamily<>0) and (fTargetDocID<>0) and (fCurHLAddress.Doc<>0) then
     AddImpHLRec(NeedUndo);
    Generator.Finish;
   end
   else
    if CT.IsKindOf(k2_typSub) and
       not CT.IsKindOf(k2_typDocumentSub) and
       not CT.IsKindOf(k2_typDocument) and
       not CT.IsKindOf(k2_typBookmark) then
    begin
     if (fFamily<>0) and (fTargetDocID<>0) and (fCurSubRec.ID<>0) then
      AddSubRec(NeedUndo)
     else
      fCurSubRec.ID:=0;
     Generator.Finish;
    end
    else
     begin
      if fExpandedFormat then
      begin
       if CT.IsKindOf(k2_typDictRec) then
        AddDictRec(NeedUndo)
       else
        if CT.IsKindOf(k2_typNumAndDate) then
         AddDateNumRec(NeedUndo)
        else
         if CT.IsKindOf(k2_typPIRec) then
          AddPublishRec(NeedUndo);
      end;

      if (fFiltredTag = -1) then
       Generator.Finish;
     end;
 end;

 if (TopObject[0].isProp) and
    (Ord(TopObject[0].AsProp.TagIndex) = fFiltredTag) then
 begin
  fFiltredTag := -1;
 end;

 inherited;
end;

procedure TGetClipboardFilter.OpenStream;
begin
 inherited;

 if (fFamily = 0) then {Family not Assigned}
  raise EHtErrors.CreateInt(ecNotAssigned);

 ClearIterationData;
 //InitCacheTblDataArr;
end;

procedure TGetClipboardFilter.CloseStream(NeedUndo : Boolean);
begin
 if Assigned(fSubItemInserted) then
  fSubItemInserted(fCurInsSubCount);
 DoneCacheTblDataArr;
 ClearIterationData;
 inherited;
end;
*)

(*
//************************ TConvertorToInternalFormat **************************

{Protected methods}
procedure TConvertorToInternalFormat.SetFamily(aValue : TFamilyID);
begin
 if fFamily <> aValue then
 begin
  if StreamOpened then // in Process
   raise EHtErrors.CreateInt(ecNotEnable)
  else
   fFamily:=aValue;

  // Initialize External objects

  fReNumTbl:=LinkServer(CurrentFamily).ReNum;
 end;
end;

procedure TConvertorToInternalFormat.SetLevelSlash(aValue : AnsiString);
begin
 if fLevelSlash = aValue then
  Exit;
 fLevelSlash:=aValue;
end;

procedure TConvertorToInternalFormat.ClearDataStorage;
Begin
 L3Free(fImpDictRec.ShortName);
 L3Free(fImpDictRec.Name);
 l3FillChar(fImpDictRec,SizeOf(fImpDictRec));
 fCurDocID:=0;
end;

procedure TConvertorToInternalFormat.InitLists;
var
 I : TdaDictionaryType;
begin
 fBasesList:=Tl3StringDataList.CreateSize(DictServer(Family).DictTbl[da_dlBases].IDSize);
 fBasesList.Sorted:=True;
 DictServer(Family).DictTbl[da_dlBases].NameFld:=dtShNameFld;
 DictServer(Family).DictTbl[da_dlBases].GetDictList(fBasesList,True);
 DictServer(Family).DictTbl[da_dlBases].NameFld:=dtNameRFld;
 fBasesList.NeedAllocStr:=True;

 fWarningsList:=Tl3StringDataList.CreateSize(DictServer(Family).DictTbl[da_dlWarnings].IDSize);
 fWarningsList.Sorted:=True;
 DictServer(Family).DictTbl[da_dlWarnings].GetDictList(fWarningsList,True);
 fWarningsList.NeedAllocStr:=True;

 fNormsList:=Tl3StringDataList.CreateSize(DictServer(Family).DictTbl[da_dlNorms].IDSize);
 fNormsList.Sorted:=True;
 DictServer(Family).DictTbl[da_dlNorms].GetDictList(fNormsList,True);
 fNormsList.NeedAllocStr:=True;

 fAccGroupsList:=Tl3StringDataList.CreateSize(DictServer(Family).DictTbl[da_dlAccGroups].IDSize);
 fAccGroupsList.Sorted:=True;
 DictServer(Family).DictTbl[da_dlAccGroups].NameFld:=dtShNameFld;
 DictServer(Family).DictTbl[da_dlAccGroups].GetDictList(fAccGroupsList,True);
 DictServer(Family).DictTbl[da_dlAccGroups].NameFld:=dtNameRFld;
 fAccGroupsList.NeedAllocStr:=True;

 l3FillChar(fDictTrees,SizeOf(fDictTrees));
 for I:=da_dlSources to da_dlBases do
  fDictTrees[I]:=DictServer(Family).DictRootNode[I].Use;

 fDictTrees[da_dlCorSources]:=DictServer(Family).DictRootNode[da_dlCorSources].Use;

 fDictTrees[da_dlPrefixes]:=DictServer(Family).DictRootNode[da_dlPrefixes].Use;

 fDictTrees[da_dlTerritories]:=DictServer(Family).DictRootNode[da_dlTerritories].Use;

 fDictTrees[da_dlAccGroups]:=DictServer(Family).DictRootNode[da_dlAccGroups].Use;
end;

procedure TConvertorToInternalFormat.DoneLists;
var
 I : TdaDictionaryType;
begin
 L3Free(fBasesList);
 L3Free(fWarningsList);
 L3Free(fNormsList);
 L3Free(fAccGroupsList);
 for I:=da_dlSources to da_dlBases do
  L3Free(fDictTrees[I]);
 L3Free(fDictTrees[da_dlCorSources]);
 L3Free(fDictTrees[da_dlPrefixes]);
 L3Free(fDictTrees[da_dlTerritories]);
 L3Free(fDictTrees[da_dlAccGroups]);
end;

function TConvertorToInternalFormat.ConvertDictRec : TDictID;
var
 TmpLI    : LongInt;
 CurList  : Tl3StringDataList;
 lNode    : Il3Node;
 lName    : Tl3WString;

Begin
 Result:=0;
 if fImpDictRec.DictID <> da_dlNone then
 begin
  case fImpDictRec.DictID of
   da_dlSources,
   da_dlTerritories,
   da_dlTypes,
   da_dlClasses,
   da_dlKeyWords,
   da_dlPrefixes,
   da_dlCorSources,
   da_dlServiceInfo:
   begin
    if (fImpDictRec.Handle=0) and Assigned(fImpDictRec.Name) then
    begin
     lName := fImpDictRec.Name.AsWStr;
     lNode := l3GetPartPath(fDictTrees[fImpDictRec.DictID], lName, fLevelSlash);
     if l3IsNil(lName) then
      Result:=(lNode as IDictItem).Handle;
    end;
   end;
   da_dlBases,
   da_dlAccGroups:
   begin
    case fImpDictRec.DictID of
     da_dlBases:
      CurList:=fBasesList;
     da_dlAccGroups:
      CurList:=fAccGroupsList;
    end;
    if (fImpDictRec.Handle=0) and Assigned(fImpDictRec.ShortName) and
       CurList.FindStr(fImpDictRec.ShortName.St,TmpLI) then
     Result:=PDictID(CurList.Data[TmpLI])^
   end;
   da_dlWarnings,
   da_dlNorms:
   begin
    case fImpDictRec.DictID of
     da_dlWarnings:
      CurList:=fWarningsList;
     da_dlNorms:
      CurList:=fNormsList;
    end;
    if (fImpDictRec.Handle=0) and Assigned(fImpDictRec.Name) and
       CurList.FindStr(fImpDictRec.Name.St,TmpLI) then
     Result:=PDictID(CurList.Data[TmpLI])^
   end;
  end;
 end;
 L3Free(fImpDictRec.ShortName);
 L3Free(fImpDictRec.Name);
 l3FillChar(fImpDictRec,SizeOf(fImpDictRec));
end;

procedure TConvertorToInternalFormat.AddAtomEx(AtomIndex : Long;
                                               const Value : Tk2Variant);
var
 CT          : Tk2Type;
 TmpID       : TDocID;
 FiltredAtom : Boolean;
begin
 CT:=CurrentType;
 FiltredAtom:=False;
 try
  if CT.IsKindOf(k2_typDocument) then // конвертация элементарных полей документа
  begin
   if (AtomIndex = k2_tiInternalHandle) then
   begin
    if (Value.Kind=k2_vkInteger) then
     fCurDocID:=TDocID(Value.AsInteger)
    else
     ConvertErrorEx(Value.Kind);
   end // if (AtomIndex = k2_tiInternalHandle)
   else
    if (AtomIndex = k2_tiExternalHandle) then
    begin
     if (Value.Kind=k2_vkInteger) then
      TmpID:=TDocID(Value.AsInteger)
     else
      ConvertErrorEx(Value.Kind);

     if (fCurDocID = 0) then
     begin
      fReNumTbl.GetRNumber(TmpID);
      fCurDocID:=TmpID;
      Generator.AddIntegerAtom(k2_tiInternalHandle,fCurDocID);
     end; // if (fCurDocID = 0)
     FiltredAtom:=True;
    end // if (AtomIndex = k2_tiExternalHandle)
    else
     if (AtomIndex = k2_tiRelExternalHandle) then
     begin
      if (Value.Kind=k2_vkInteger) then
       TmpID:=TDocID(Value.AsInteger)
      else
       ConvertErrorEx(Value.Kind);

      fReNumTbl.GetRNumber(TmpID);
      Generator.AddIntegerAtom(k2_tiRelInternalHandle,TmpID);
      FiltredAtom:=True;
     end; // if (AtomIndex = k2_tiRelExternalHandle)
  end // if CT.IsKindOf(k2_typDocument)
  else
   if CT.IsKindOf(k2_typAddress) and // конвертация записи: гипертекстовая ссылка
      TopType[1].IsKindOf(k2_typHyperLink) and
      (AtomIndex = k2_tiDocID) then
   begin
    if (Value.Kind=k2_vkInteger) then
     TmpID:=TDocID(Value.AsInteger)
    else
     ConvertErrorEx(Value.Kind);

    fReNumTbl.GetRNumber(TmpID);
    Generator.AddIntegerAtom(k2_tiDocID,TmpID);

    FiltredAtom:=True;
   end // if CT.IsKindOf(k2_typAddress) and ...
   else
    if CT.IsKindOf(k2_typDictRec) and // конвертация записи: элемент словаря
       not CT.IsKindOf(k2_typSub) then
    begin
     if (AtomIndex = k2_tiHandle) then
     begin
      if (Value.Kind=k2_vkInteger) then
       fImpDictRec.Handle:=TDictID(Value.AsInteger)
      else
       ConvertErrorEx(Value.Kind);
     end // if (AtomIndex = k2_tiHandle)
     else
      if (AtomIndex = k2_tiName) then
      begin
       if (Value.Kind=k2_vkString) then
       begin
        l3Set(fImpDictRec.Name,Value.AsString);
        fImpDictRec.Name.CodePage:=cp_ANSI;
       end // if (Value.Kind=k2_vkString)
       else
        ConvertErrorEx(Value.Kind)
      end // if (AtomIndex = k2_tiName)
      else
       if (AtomIndex = k2_tiShortName) then
       begin
        if (Value.Kind=k2_vkString) then
        begin
         l3Set(fImpDictRec.ShortName,Value.AsString);
         fImpDictRec.ShortName.CodePage:=cp_ANSI;
        end // if (Value.Kind=k2_vkString)
        else
         ConvertErrorEx(Value.Kind);
       end; //if (AtomIndex = k2_tiShortName)
    end; // if CT.IsKindOf(k2_typDictRec)
  finally
   if not FiltredAtom then
    Generator.AddAtomEx(AtomIndex,Value);
  end;
end;

{End Protected methods}
{Public methods}

constructor TConvertorToInternalFormat.Create(aOwner : Tk2TagGeneratorOwner);
begin
 inherited;
 LevelSlash:='\';
end;

procedure TConvertorToInternalFormat.OpenStream;
begin
 inherited;
 if (fFamily = 0) then {Family not Assigned}
 begin
  msg2log('Не задано семейство таблиц для работы');
  raise EHtErrors.CreateInt(ecNotAssigned);
 end;

 InitLists;
 ClearDataStorage;
end;

procedure TConvertorToInternalFormat.CloseStream(NeedUndo : Boolean);
begin
 DoneLists;
 inherited;
end;

procedure TConvertorToInternalFormat.StartChild(TypeID : Tl3VariantDef);
var
 curObj : Tk2CustomPropertyPrim;
begin
 inherited StartChild(TypeID);

 if TopType[0].IsKindOf(k2_typDictRec) and
    (TopObject[1].isProp) then
 begin
  curObj:=TopObject[1].AsProp;
  case CurObj.TagIndex of
   k2_tiGroups:
    fImpDictRec.DictID:=da_dlBases;
   k2_tiSources:
    fImpDictRec.DictID:=da_dlSources;
   k2_tiTypes:
    fImpDictRec.DictID:=da_dlTypes;
   k2_tiClasses:
    fImpDictRec.DictID:=da_dlClasses;
   k2_tiKeyWords:
    fImpDictRec.DictID:=da_dlKeyWords;
   k2_tiWarnings:
    fImpDictRec.DictID:=da_dlWarnings;
   k2_tiPrefix:
    fImpDictRec.DictID:=da_dlPrefixes;
   k2_tiTerritory:
    fImpDictRec.DictID:=da_dlTerritories;
   k2_tiNorm:
    fImpDictRec.DictID:=da_dlNorms;
   k2_tiAccGroups:
    fImpDictRec.DictID:=da_dlAccGroups;
   k2_tiServiceInfo:
    fImpDictRec.DictID:=da_dlServiceInfo;
  end;
 end;

 Generator.StartChild(TypeID);
end;

procedure TConvertorToInternalFormat.StartTag(TagID : Long);
begin
 inherited StartTag(TagID);

 if TopType[0].IsKindOf(k2_typDictRec) and
    (TopObject[0].isProp) then
 begin
  if (TopObject[0].AsProp.TagIndex = k2_tiSource) then
   fImpDictRec.DictID:=da_dlCorSources;
  if (TopObject[0].AsProp.TagIndex = k2_tiUser) then
   fImpDictRec.UserDict:=True;
 end;

 Generator.StartTag(TagID)
end;

Procedure TConvertorToInternalFormat.CloseStructure(NeedUndo : Bool);
var
 CT    : Tk2Type;
 tmpID : TDictID;
begin
 CT:=CurrentType;
 try
  if CT.IsKindOf(k2_typDocument) then
   ClearDataStorage
  else
   if CT.IsKindOf(k2_typDictRec) then
   begin
    tmpID:=ConvertDictRec;
    if tmpID<>0 then
     Generator.AddIntegerAtom(k2_tiHandle,tmpID);
   end;
 finally
  Generator.Finish;
  Inherited CloseStructure(NeedUndo);
 end;
end;

*)

//************************ THLinkAddrToInternal **************************

{Protected methods}
procedure THLinkAddrToInternal.SetFamily(aValue : TFamilyID);
begin
 if fFamily <> aValue then
 begin
  if StreamOpened then // in Process
   raise EHtErrors.CreateInt(ecNotEnable)
  else
   fFamily:=aValue;

  // Initialize External objects

  fReNumTbl := LinkServer(fFamily).ReNum;
 end;
end;

procedure THLinkAddrToInternal.AddAtomEx(AtomIndex : Long; const Value : Tk2Variant);
var
 lID       : TDocID;
begin
 if CurrentType.IsKindOf(k2_typAddress) and // конвертация записи: гипертекстовая ссылка
    TopType[1].IsKindOf(k2_typHyperLink) and
    (AtomIndex = k2_tiDocID) then
 begin
  if (Value.Kind=k2_vkInteger) then
   lID:=TDocID(Value.AsInteger)
  else
   ConvertErrorEx(Value.Kind);

  fReNumTbl.GetRNumber(lID);
  Generator.AddIntegerAtom(k2_tiDocID, lID);
 end // if CT.IsKindOf(k2_typAddress) and ...
 else
  Generator.AddAtomEx(AtomIndex,Value);
end;

(*
{TSaveDocFilter2}
constructor TSaveDocFilter2.Create(anOwner : TComponent; aFamily : TFamilyID);
begin
 Inherited Create(anOwner);
 SetFamily(aFamily);
end;

procedure TSaveDocFilter2.SetFamily(aValue : TFamilyID);
begin
 if fFamily <> aValue then
 begin
  if StreamOpened then {in Process}
   raise EHtErrors.CreateInt(ecNotEnable)
  else
   fFamily := aValue;
 end;
end;

procedure TSaveDocFilter2.SetCurDocID(aValue : TDocID);
begin
 if fCurDocID <> aValue then
 begin
  if StreamOpened then {in Process}
   raise EHtErrors.CreateInt(ecNotEnable)
  else
   fCurDocID := aValue;
 end;
end;

function TSaveDocFilter2.AttrData(aAttrType : TCacheType): TCacheDiffAttrData;
var
 lAttrData : TCacheDiffAttrData;
begin
 if fCacheAttrData = nil then
  fCacheAttrData := Tl3ObjectRefArray.Create;

 if fCacheAttrData[Ord(aAttrType)] = nil then
 begin
  lAttrData := TCacheDiffAttrData.Create(fFamily, aAttrType);
  try
   fCacheAttrData[Ord(aAttrType)] := lAttrData;
  finally
   l3Free(lAttrData);
  end;
 end;

 Result := fCacheAttrData[Ord(aAttrType)] as TCacheDiffAttrData;
end;

procedure TSaveDocFilter2.CloseStream(NeedUndo : Boolean);
begin
 inherited;
 l3Free(fCacheAttrData);
end;

procedure TSaveDocFilter2.CloseStructure(NeedUndo: Bool);
var
 lCT : TCacheType;
 lDict : TdaDictionaryType;
begin
 if TopType[0].IsKindOf(k2_typDocument) then
 begin
  if (fCurDocID > 0) then
  for lCT := Low(TCacheType) to High(TCacheType) do
  if lCT in [ctSub, ctHLink] then
   AttrData(lCT).CloseDoc(fCurDocID);
 end;
 inherited;
end;

function TSaveDocFilter2.NeedKeepThisTag(aID : Integer) : Boolean;
begin
 if aID < 0 then
 begin
  aID := -aID;
  Result := (aID = k2_idSub) or (aID = k2_idBlock) or (aID = k2_idHyperLink);
 end
 else
  Result := False;
end;

procedure TSaveDocFilter2.DoKeepComplete;
var
 lID : TSubID;
 lName : Tl3Tag;
 lRealFl : Boolean;
 I : Integer;
 lDestDocID : TDocID;
begin
 with f_Buffer.Root do
 begin
  case Tk2Type(TagType).ID of
   k2_idSub,
   k2_idBlock :
   begin
    lID := IntA[k2_tiHandle];
    lName := Attr[k2_tiShortName];
    lRealFl := lName.IsValid;
    if not lRealFl then
     lName := Attr[k2_tiName];
    AttrData(ctSub).AddRecord([fCurDocID, lID, lRealFl, lName]);
   end;

   k2_idHyperLink :
   begin
    lID := IntA[k2_tiHandle];
    for I := 0 to Pred(ChildrenCount) do
     with Child[I] do
     begin
      lDestDocID := IntA[k2_tiDocID];
      if lDestDocID = 0 then
       lDestDocID := fCurDocID;

      AttrData(ctHLink).AddRecord([lID,
                                  fCurDocID,
                                  lDestDocID,
                                  IntA[k2_tiSubID]]);
     end;
   end;
  end; //case f_Buffer.Root.TagType.ID of
 end;
end;

procedure TSaveDocFilter2.StartChild(TypeID: Tl3VariantDef);
begin
 if TypeID.IsKindOf(k2_typLeafPara) then
  KeepComplete;
 inherited;
end;

class function TSaveDocFilter2.SetTo(var aGenerator: Tk2TagGenerator; aFamily: TFamilyID; aDocID: TDocID): Tk2TagGenerator;
begin
 Result := inherited SetTo(aGenerator);
 with TSaveDocFilter2(aGenerator) do
 begin
  SetFamily(aFamily);
  SetCurDocID(aDocID);
 end;
end;
*)

constructor TUltraLiteSaveDocFilter.Create(anOwner : TComponent; aFamily : TFamilyID);
begin
 Inherited Create(anOwner);
 SetFamily(aFamily);
end;

function TUltraLiteSaveDocFilter.AttrData(aAttrType : TCacheType): TCacheDiffAttrData;
var
 lAttrData : TCacheDiffAttrData;
begin
 if fCacheAttrData = nil then
  fCacheAttrData := Tl3ObjectRefArray.Create;

 if fCacheAttrData[Ord(aAttrType)] = nil then
 begin
  lAttrData := TCacheDiffAttrData.Create(fFamily, aAttrType);
  try
   fCacheAttrData[Ord(aAttrType)] := lAttrData;
  finally
   l3Free(lAttrData);
  end;
 end;

 Result := fCacheAttrData[Ord(aAttrType)] as TCacheDiffAttrData;
end;

procedure TUltraLiteSaveDocFilter.CloseStream(NeedUndo : Boolean);
begin
 inherited;
 l3Free(fCacheAttrData);
end;

procedure TUltraLiteSaveDocFilter.CloseStructure(NeedUndo: Bool);
var
 lCT : TCacheType;
 lDict : TdaDictionaryType;
begin
 if TopType[0].IsKindOf(k2_typDocument) then
 begin
  if (fCurDocID > 0) then
  for lCT := Low(TCacheType) to High(TCacheType) do
  if lCT in [ctSub] then
   AttrData(lCT).CloseDoc(fCurDocID);
 end;
 inherited;
end;

procedure TUltraLiteSaveDocFilter.DoKeepComplete;
var
 lID : TSubID;
 lName : Tl3Tag;
 lRealFl : Boolean;
 I : Integer;
 lDestDocID : TDocID;
begin
 with f_Buffer.Root do
 begin
  case Tk2Type(TagType).ID of
   k2_idSub,
   k2_idBlock :
   begin
    lID := IntA[k2_tiHandle];
    lName := Attr[k2_tiShortName];
    lRealFl := lName.IsValid;
    if not lRealFl then
     lName := Attr[k2_tiName];
    AttrData(ctSub).AddRecord([fCurDocID, lID, lRealFl, lName]);
   end;

   k2_idHyperLink :
   begin
    lID := IntA[k2_tiHandle];
    for I := 0 to Pred(ChildrenCount) do
     with Child[I] do
     begin
      lDestDocID := IntA[k2_tiDocID];
      if lDestDocID = 0 then
       lDestDocID := fCurDocID;

      AttrData(ctHLink).AddRecord([lID,
                                   fCurDocID,
                                   lDestDocID,
                                   IntA[k2_tiSubID]]);
     end;
   end;
  end; //case f_Buffer.Root.TagType.ID of
 end;
end;

function TUltraLiteSaveDocFilter.NeedKeepThisTag(aID : Integer): Boolean;
begin
 if aID < 0 then
 begin
  aID := -aID;
  Result := (aID = k2_idSub) or (aID = k2_idBlock);
 end
 else
  Result := False;
end;

procedure TUltraLiteSaveDocFilter.SetCurDocID(aValue : TDocID);
begin
 if fCurDocID <> aValue then
 begin
  if StreamOpened then {in Process}
   raise EHtErrors.CreateInt(ecNotEnable)
  else
   fCurDocID := aValue;
 end;
end;

procedure TUltraLiteSaveDocFilter.SetFamily(aValue : TFamilyID);
begin
 if fFamily <> aValue then
 begin
  if StreamOpened then {in Process}
   raise EHtErrors.CreateInt(ecNotEnable)
  else
   fFamily := aValue;
 end;
end;

procedure TUltraLiteSaveDocFilter.StartChild(TypeID: Tl3VariantDef);
begin
 if TypeID.IsKindOf(k2_typLeafPara) then
  KeepComplete;
 inherited;
end;


(****************************** TGetClipboardLightFilter **************************************)

{Protected methods}
procedure TGetClipboardLightFilter.BeforeRelease;
begin
 l3Free(fDictDecoder);
 inherited;
end;

function TGetClipboardLightFilter.DictDecoder  : TDictItemDecoder;
begin
 if fDictDecoder = nil then
  fDictDecoder := TDictItemDecoder.Create(Family);
 Result := fDictDecoder;
end;

function TGetClipboardLightFilter.GetObject: TObject;
  {* - получить объект из обертки. }
begin
 Result := Self;
end;

function TGetClipboardLightFilter.DoGetNewHandleID(aType : TdtHandleIDType; var aHandleID : Integer) : boolean;
begin
 Result := False;
 if Assigned(fOnGetNewHandleID) then
 begin
  fOnGetNewHandleID(aType, aHandleID);
  Result := aHandleID > 0;
 end;
end;

procedure TGetClipboardLightFilter.DoInsertDocAttribute(aAttr : TCacheType);
begin
 if Assigned(fOnInsertDocAttribute) then
  fOnInsertDocAttribute(aAttr);
end;

function  TGetClipboardLightFilter.NeedStartBuffering(aID : Integer): Boolean;
begin
 Result := aID in [k2_tiNumANDDates,
                   k2_tiSources, k2_tiTypes, k2_tiPrefix, k2_tiClasses, k2_tiKeyWords, k2_tiGroups,
                   k2_tiWarnings, k2_tiPublishedIn, k2_tiTerritory, k2_tiNorm,
                   k2_tiAccGroups, k2_tiAnnoClasses, k2_tiServiceInfo,
                   k2_tiChecks, k2_tiAlarms, k2_tiActiveIntervals, k2_tiStages, k2_tiLogRecords, k2_tiSysLogRecords,
                   k2_tiLinkedDocuments];


 Result := Result or ((aID < 0) and k2.TypeTable.TypeByHandle[-aID].IsKindOf(k2_typHyperlink));

 (*cAttr2k2Tag : array[TdtAttribute] of Longint =
                    (0{atNothing},
                     0{atShortName}, 0{atFullName}, 0{atPriceLevel}, 0{atNotTM}, 0{atPriority}, 0{atSortDate},
                     0{atRelated}, {k2_tiInternalVerLink}k2_tiExternalVerLink{atVerLink}, 0{atUrgency}, 0{atComment},
                     k2_tiNumANDDates,
                     k2_tiSources, k2_tiTypes, k2_tiPrefix, k2_tiClasses, k2_tiKeyWords, k2_tiGroups,
                     k2_tiWarnings, k2_tiPublishedIn,k2_tiTerritory, k2_tiNorm,
                     k2_tiAccGroups, k2_tiAnnoClasses, k2_tiServiceInfo,
                     k2_tiChecks, k2_tiAlarms, k2_tiActiveIntervals, k2_tiStages, k2_tiLogRecords, k2_tiSysLogRecords,
                     k2_tiLinkedDocuments {atDoc2DocLink},
                     0{atHLink}, 0{atSub},
                     0{atRenum},
                     0{atVersions}
                     );

 *)
end;

function  TGetClipboardLightFilter.NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean;
var
 I : Integer;
 lHandle : integer;

begin
 Result := False;

 // если шапка то сфильтровываем
 if CurrentType.IsKindOf(k2_typDocument) then
  Exit;

 // не шапка
 if fExpandedFormat and (aTagId in [k2_tiTypes, k2_tiPrefix, k2_tiClasses, k2_tiKeyWords]) then
  //восстановим Handle у кого нет
  with aLeaf do
  begin
   for I := pred(ChildrenCount) downto 0 do
    if Child[I].IntA[k2_tiHandle] = 0 then
    begin
     if not DictDecoder.AddHandle(Child[I], AttrID2DLType(TagID2AttrID(aTagID))) then
      // не нашли элемент, грохнем его
      DeleteChild(I)
     else
      // нашли, грохнем имя, т к оно в другом формате (слеши)
      AttrW[k2_tiName, nil] := nil;
    end;
   Result := ChildrenCount > 0; // еще остались
   if Result then
    DoInsertDocAttribute(TagIDToCacheType(aTagID));
  end
 else
 if aLeaf.IsKindOf(k2_typHyperlink) then
 begin
  lHandle := aLeaf.IntA[k2_tiHandle];
  if (lHandle = 0) and DoGetNewHandleID(dt_hidHyperlink, lHandle) then
   aLeaf.IntA[k2_tiHandle] := lHandle;
  Result := True;
 end
end;

procedure TGetClipboardLightFilter.AddAtomEx(AtomIndex : Long; const Value : Tk2Variant);
var
 lSubID      : TSubID;
 //lHLinkID    : Integer;
 //TmpLI       : LongInt;
 CT          : Tk2Type;
 lValue      : Tk2Variant;

begin
 CT := CurrentType;
 if CT.IsKindOf(k2_typDocument) then // фильтрация элементарных полей документа
 begin
  if (AtomIndex in [k2_tiInternalHandle,k2_tiExternalHandle,k2_tiType,k2_tiShortName,
                   k2_tiName,k2_tiUserType,k2_tiPriceLevel,k2_tiSortDate,
                   k2_tiPriority,k2_tiRelInternalHandle,k2_tiRelExternalHandle,
                   k2_tiInternalVerLink,k2_tiExternalVerLink]) then

   exit;
 end
 else
  if CT.IsKindOf(k2_typHyperLink) and (AtomIndex = k2_tiHandle) then // гипертекстовая ссылка
   exit //чужой хендл гиперссылки нам не нужен
  else
  if CT.IsKindOf(k2_typDocumentSub) or
     CT.IsKindOf(k2_typBookmark) then
   begin
    // - здесь специально ничего не делаем !!!
   end
  else
  if CT.IsKindOf(k2_typSub) // Sub
     {and not CT.IsKindOf(k2_typDocument)} then
   begin
    if (AtomIndex = k2_tiHandle) then
    begin
     if (Value.Kind = k2_vkInteger) then
     begin
      lSubID := TSubID(Value.AsInteger);
      if DoGetNewHandleID(dt_hidSub, lSubID) then
      begin
       lValue := Tk2VariantImpl.Make(lSubID);
       inherited AddAtomEx(AtomIndex, lValue);
       exit;
      end;
     end;
    end;
   end
  else
  if CT.IsKindOf(k2_typDictRec) then // заполнение записи: элемент словаря
   begin
    if (AtomIndex = k2_tiHandle) and ExternalDocData then
     exit; // вырезаем хендл словаря
   end;


 {if (fFiltredTag <> -1) then
  if TopObject[0].IsProp AND
     (TopObject[0].AsProp.TagIndex = fFiltredTag) then
   Exit;}

 Inherited;
 //Generator.AddAtomEx(AtomIndex, Value);
end;

end.

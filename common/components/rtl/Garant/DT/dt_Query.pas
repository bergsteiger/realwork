unit dt_Query;

{ $Id: dt_Query.pas,v 1.29 2015/10/15 10:36:32 lukyanets Exp $ }

// $Log: dt_Query.pas,v $
// Revision 1.29  2015/10/15 10:36:32  lukyanets
// Обработка параметров
//
// Revision 1.28  2015/10/14 12:57:19  lukyanets
// Итератор
//
// Revision 1.27  2015/07/02 11:41:29  lukyanets
// Описываем словари
//
// Revision 1.26  2015/07/02 07:36:07  lukyanets
// Описываем словари
//
// Revision 1.25  2015/06/04 13:20:58  voba
// - k:580708782
//
// Revision 1.24  2015/05/28 11:11:41  fireton
// - новый класс: TdtExpandEditionsQuery
//
// Revision 1.23  2015/04/30 11:14:54  lukyanets
// Заготовки Большого Брата
//
// Revision 1.22  2014/11/28 12:03:58  voba
// k:ловушка для hterr -42
//
// Revision 1.21  2014/11/17 13:45:55  voba
// -bf лечим HtError: 42; Too old operand (table updated)
//
// Revision 1.20  2014/10/15 14:16:41  voba
// -bf в логах была ошибка -42 (снимки таблиц разные)
//
// Revision 1.19  2014/09/03 13:36:06  lukyanets
// Отлаживаем одновременный экспорт в разные регионы
//
// Revision 1.18  2014/04/17 13:04:31  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.17  2013/07/15 13:19:44  voba
// - bug fix. В Ульяновске поиск по номеру не работал
//
// Revision 1.16  2013/04/17 11:03:51  voba
// - вернул поиск по номерам как было (wildcase)
//
// Revision 1.15  2013/04/11 11:56:37  voba
// -bug fix
//
// Revision 1.14  2012/11/01 09:42:41  lulin
// - забыл точку с запятой.
//
// Revision 1.13  2012/11/01 07:44:35  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.12  2012/09/07 14:22:08  voba
// - add TdtRespQuery
//
// Revision 1.11  2012/03/06 13:00:34  fireton
// - Слияние с веткой B_archi_base132
//
// Revision 1.10.2.1  2012/02/14 09:21:44  fireton
// - поиск по пометке "клон" для источников опубликования
//
// Revision 1.10  2011/12/22 14:53:31  fireton
// - внятное сообщение об ошибке если query не зарегистрирована
//
// Revision 1.9  2011/12/22 13:50:16  fireton
// - TdtStatusMaskQuery (К 321986435)
//
// Revision 1.8  2011/10/19 14:00:12  voba
// - k : 250089317
//
// Revision 1.7  2011/06/10 12:49:03  voba
// - DocumentServer сделал функцией function DocumentServer(aFamily : TFamilyID), что бы отдельно Family не присваивать
//
// Revision 1.6  2010/12/23 11:47:25  voba
// no message
//
// Revision 1.5  2010/12/08 14:59:25  voba
// - k:77235690
//
// Revision 1.4  2010/12/06 14:49:45  voba
// - k:245204105
//
// Revision 1.3  2010/10/13 14:17:36  fireton
// - получаем список редакций конкретного документа
//
// Revision 1.2  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.1  2010/08/04 07:19:41  voba
// - k: 229672814
//
// Revision 1.46  2010/07/23 10:26:59  voba
// - k:228688243
//
// Revision 1.45  2010/05/18 10:42:45  voba
// - Merge отвалилось из-за предыдущего исправления 2
//
// Revision 1.44  2010/05/17 12:50:32  voba
// - Merge отвалилось из-за предыдущего исправления
//
// Revision 1.43  2010/04/19 12:15:27  narry
// - в пустую выборку не добавлялись выборки
//
// Revision 1.42  2010/03/30 10:19:52  fireton
// - новый тип поиска - док-ты, которые будут действовать
//
// Revision 1.41  2010/02/26 08:38:24  voba
// - bug fix : иногда не работала фильтрация выборки
//
// Revision 1.40  2010/02/17 07:24:02  voba
// - K:190679769
//
// Revision 1.39  2010/02/05 14:17:53  fireton
// - bugfix: AV, если все значения в TdtDateNumQuery пустые
//
// Revision 1.38  2009/12/11 15:56:09  lulin
// {RequestLink:172984520}.
//
// Revision 1.37  2009/12/11 14:14:49  lulin
// {RequestLink:172984520}.
//
// Revision 1.36  2009/10/19 11:46:47  voba
// - избавляемся от старой библиотеки регулярных выражений
//
// Revision 1.35  2009/10/13 14:59:08  fireton
// - работа над ошибками в простановке ссылок в БРАС
//
// Revision 1.34  2009/10/13 08:55:37  fireton
// - простановка ссылок с помощью нового сканера
//
// Revision 1.33  2009/09/28 08:54:08  voba
// - избавляемся от старого анализатора фраз
//
// Revision 1.32  2009/09/25 10:35:59  voba
// - [$163065584]
//
// Revision 1.31  2009/08/28 14:34:24  voba
// - Поиск с незаданной начальной датой интервала неправильно искал
//
// Revision 1.30  2009/07/23 07:43:13  voba
// - bug fix
//
// Revision 1.29  2009/07/22 11:27:26  narry
// - изменение доступа к DictServer
//
// Revision 1.28  2009/06/23 07:32:59  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.27  2009/06/08 13:23:25  voba
// - enh. унификация атрибутов. Избавился от псевдоатрибутов atDateNumsChDate, atRelHLink,
//
// Revision 1.26  2009/06/02 12:51:59  voba
// - заменил TdtUrgencyQuery на TdtMainAttrQuery - умеет работать с любым полем main таблицы
//
// Revision 1.25  2009/05/29 08:17:38  voba
// - bug fix
//
// Revision 1.24  2009/04/28 15:16:49  lulin
// - перегенерация документации и работа над ошибками за Вованом.
//
// Revision 1.23  2009/04/14 15:37:48  voba
// - bu fix: HTErr=-42
//
// Revision 1.22  2009/04/13 07:10:58  narry
// - разделение определения типов и реализации
//
// Revision 1.21  2009/04/08 11:02:03  voba
// - bu fix: HTErr=-37
//
// Revision 1.20  2009/04/07 13:03:04  voba
// - bug fix TdtDocTypeFilterQuery.DoQuery
//
// Revision 1.19  2009/04/03 13:27:03  voba
// -bug fix: k:142607306
//
// Revision 1.18  2009/04/02 14:05:50  voba
// - bug fix HtErr= -42
//
// Revision 1.17  2009/04/01 11:35:23  fireton
// - [$141264339]. Выборка "Все документы" не умела сохраняться и загружаться.
//
// Revision 1.16  2009/03/12 14:45:26  voba
// - bug fix procedure TdtDateNumQuery.DoQuery при одновременном поиске по дате и номеру находил только если они были в одной записи
//
// Revision 1.15  2009/03/05 15:00:03  voba
// - поиск по папкам в PublishedIn
//
// Revision 1.14  2009/03/02 12:59:44  voba
// -- bug fix TdtDocListQuery в хитрых случаях не удалялись доки
//
// Revision 1.13  2009/02/20 13:27:58  fireton
// - команда !CHANGE (K 77235676)
// - 131 версия базы
//
// Revision 1.12  2009/02/18 13:49:25  voba
// - function TdtDocListQuery.MergeWith
//
// Revision 1.11  2009/02/10 14:24:56  voba
// - убрал Il3Notify
//
// Revision 1.10  2009/01/30 13:54:19  voba
// - bug fix
//
// Revision 1.9  2009/01/29 17:02:35  voba
// - bug fix procedure TdtDocListQuery.Load(aDataStream : TStream);
//
// Revision 1.8  2009/01/28 14:13:42  narry
// - неправильное вычисление TdtCustomLogQuery.DoQuery
//
// Revision 1.7  2009/01/28 13:01:09  fireton
// - создаем пустые сабы значений правильно
//
// Revision 1.6  2009/01/28 12:14:13  fireton
// - bugfix: ошибка при поиске в логах при нулевых датах
//
// Revision 1.5  2009/01/26 14:18:42  fireton
// - поиск документов: если ничего не выбрано, то находим все документы
//
// Revision 1.4  2009/01/26 08:06:17  fireton
// - слияние с веткой b_archi_NewSrch2 (поиск по-новому)
//
// Revision 1.3.2.6.2.16  2009/01/23 14:06:30  fireton
// - перенос Парня на Query
//
// Revision 1.3.2.6.2.15  2009/01/13 08:04:30  voba
// - bug fix
//
// Revision 1.3.2.6.2.14  2008/12/25 10:17:44  fireton
// - перевод спецпоисков на TdtQuery
//
// Revision 1.3.2.6.2.13  2008/12/22 11:09:25  fireton
// - перевод поисков на TdtQuery
//
// Revision 1.3.2.6.2.12  2008/12/03 07:59:07  fireton
// - перевод поисков на TdtQuery
//
// Revision 1.3.2.6.2.11  2008/11/25 14:55:46  voba
// - дописал procedure TdtLogQuery.DoQuery;
//
// Revision 1.3.2.6.2.10  2008/11/24 11:58:46  voba
// no message
//
// Revision 1.3.2.6.2.9  2008/11/21 12:31:39  voba
// no message
//
// Revision 1.3.2.6.2.8  2008/11/21 11:52:18  fireton
// - конвертация старых сохраненных выборок  в новый формат
//
// Revision 1.3.2.6.2.7  2008/11/19 14:18:05  voba
// no message
//
// Revision 1.3.2.6.2.6  2008/11/17 07:42:41  voba
// no message
//
// Revision 1.3.2.6.2.5  2008/11/13 11:09:58  voba
// no message
//
// Revision 1.3.2.6.2.4  2008/11/12 15:00:20  voba
// no message
//
// Revision 1.3.2.6.2.3  2008/11/06 11:45:21  voba
// no message
//
// Revision 1.3.2.6.2.2  2008/11/01 14:15:45  voba
// no message
//
// Revision 1.3.2.6.2.1  2008/10/31 09:57:20  voba
// no message
//
// Revision 1.3.2.6  2008/10/27 08:20:26  voba
// - move TdtQueryProvider to  DT_QueryProvider
//
// Revision 1.3.2.5  2008/10/20 13:54:20  voba
// no message
//
// Revision 1.3.2.4  2008/10/16 07:53:54  voba
// no message
//
// Revision 1.3.2.3  2008/10/10 06:43:38  voba
// no message
//
// Revision 1.3.2.2  2008/10/06 07:20:24  voba
// no message
//
// Revision 1.3.2.1  2008/10/01 13:36:21  voba
// no message
//
// Revision 1.3  2008/09/25 12:14:41  voba
// no message
//
// Revision 1.2  2008/09/23 08:47:52  voba
// no message
//
// Revision 1.1  2008/09/18 07:12:39  voba
// no message
//

{$I DtDefine.inc}

interface

uses
  Classes, SysUtils,
  daTypes,
  HT_Const,
  DT_Table, dtIntf, DT_Sab,
  DT_Types, DT_Const, dt_AttrSchema,
  DT_List, DT_Doc,
  DT_aTbl, DT_ReNum, DT_Stage, DT_IndexSupport,
  l3IniFile,
  l3Types, l3DatLst, l3Date, l3Base, l3SimpleObject,
  l3Interfaces, l3ChangeNotifier,
  l3LongintList, l3ObjectRefArray,
  l3NotifyPtrList,
  l3ClassList,
  m4DocumentAddress;

type

 TdtCustomQuery = class;
 TdtQuery = TdtCustomQuery;

 TdtQueryAction = function (const aQuery: TdtCustomQuery): Boolean;

  _l3ChangingChangedNotifier_Parent_ = Tl3Base;
  {$Include l3ChangingChangedNotifier.imp.pas}
  _l3LockedChange_Parent_ = _l3ChangingChangedNotifier_;
  {$Include l3LockedChange.imp.pas}
 TdtCustomQuery = class(_l3LockedChange_, Il3ChangeRecipient)
  protected
   fMainTblPhoto : ISab;
   fSab          : ISab;
   fPreventDropRes : integer;

   function  GetFoundList : ISab;
   procedure SetMainTblPhoto(const aPhoto : ISab);  virtual;
   function  GetMainTblPhoto : ISab;

   procedure FireChanged; override;

   class function GetRegNumber : Integer; virtual; abstract;
   procedure Load(aDataStream : TStream); virtual;
   procedure Save(aDataStream : TStream); virtual;
   function DoIterate(Action: TdtQueryAction): Boolean; virtual;
  public
   constructor Create(const aPhoto : ISab = nil);
   constructor CreateAndLoad(aDataStream : TStream; const aPhoto : ISab = nil);
   function  IsEmpty : Boolean; virtual;

   procedure DoQuery; virtual; abstract;
   procedure DropResult;
   procedure RefreshMainTblPhoto;

   procedure Iterate(Action: TdtQueryAction);
   procedure IterateF(Action: TdtQueryAction);

   function GetDocIdList: ISab;

   function  HasResult : Boolean;

   function  MergeWith(aQuery : TdtQuery; aMergeMode : Tl3BoolOp) : Boolean; virtual;

   property  MainTblPhoto : ISab
    read GetMainTblPhoto
    write SetMainTblPhoto;

   property  FoundList : ISab
    read GetFoundList;
 end;

 TdtUnitorCustomQuery = class(TdtCustomQuery)
  protected
   fQueryList   : Tl3ObjectRefArray;
   function GetQueryList : Tl3ObjectRefArray;
   function DoIterate(Action: TdtQueryAction): Boolean; override;

   procedure Cleanup; override;
  public
   procedure AddQuery(aQuery : TdtQuery);
   procedure AddQueryF(var theQuery: TdtQuery);
   procedure DropData;
   procedure Load(aDataStream : TStream); override;
   procedure Save(aDataStream : TStream); override;

   procedure GetFoundDocSubList(aDocID : TDocID; var aDSList : Tl3LongintList); virtual; abstract;

   property QueryList : Tl3ObjectRefArray read GetQueryList;
 end;

 TdtAndQuery = class(TdtUnitorCustomQuery)
  protected
   class function GetRegNumber : Integer; override;
  public
   procedure DoQuery; override;
   procedure GetFoundDocSubList(aDocID : TDocID; var aDSList : Tl3LongintList); override;
 end;

 TdtOrQuery = class(TdtUnitorCustomQuery)
  protected
   class function GetRegNumber : Integer; override;
  public
   procedure DoQuery; override;
   procedure GetFoundDocSubList(aDocID : TDocID; var aDSList : Tl3LongintList); override;
 end;

 TdtDictQuery = class(TdtCustomQuery)
  private
   fDictType    : TdaDictionaryType;

   fWithEquals  : Boolean;
   fWithSubTree : Boolean;

   fDictIDList  : Tl3LongintList;
   fWholeDocOnly: Boolean;
  private
   function MakeDictIDValueSab : ISab;
  protected
   class function GetRegNumber : Integer; override;

   procedure Cleanup; override;
  public
   constructor Create(aDictType    : TdaDictionaryType;
                      aDictIDList  : Tl3LongintList;
                      aWithEquals  : Boolean = False;
                      aWithSubTree : Boolean = False;
                      aWholeDocOnly: Boolean = False;
                      const aPhoto : ISab = nil); overload;
   constructor Create(aDictType    : TdaDictionaryType;
                      aDictID      : TDictID;
                      aWithEquals  : Boolean = False;
                      aWithSubTree : Boolean = False;
                      aWholeDocOnly: Boolean = False;
                      const aPhoto : ISab = nil); overload;


   procedure Load(aDataStream : TStream); override;
   procedure Save(aDataStream : TStream); override;

   procedure DoQuery; override;
   procedure GetFoundDocSubList(aDocID : TDocID; var aDSList : Tl3LongintList);

   property DictType    : TdaDictionaryType        read fDictType;
   property WithEquals  : Boolean        read fWithEquals;
   property WithSubTree : Boolean        read fWithSubTree;
   property DictIDList  : Tl3LongintList read fDictIDList;
 end;

 TdtIDListQuery = class(TdtCustomQuery)
  protected
   fIDList : Tl3LongintList;

   class function GetRegNumber : Integer; override;
   function GetIDList : Tl3LongintList;

   procedure Cleanup; override;
  public
   constructor CreateFrom(const aDocIDList : ISab; const aPhoto : ISab = nil);
   procedure DoQuery; override;

   procedure Load(aDataStream : TStream); override;
   procedure Save(aDataStream : TStream); override;

   procedure AddID(aDocID : TDocID);
   procedure DelID(aDocID : TDocID);

   function  MergeWith(aQuery : TdtQuery; aMergeMode : Tl3BoolOp) : Boolean; override;

   function  IsEmpty : Boolean; override;

   property IDList : Tl3LongintList read GetIDList;
 end;

 TdtTextQuery = class(TdtCustomQuery)
  private
   fFormula   : String;
   fIndexType : TIndexType;
   fAddresses : Tm4Addresses;
  protected
   class function GetRegNumber : Integer; override;
   procedure Cleanup; override;
  public
   constructor Create(const aTextFormula : AnsiString; aIndexType : TIndexType; const aPhoto : ISab = nil);
   procedure DoQuery; override;

   procedure Load(aDataStream : TStream); override;
   procedure Save(aDataStream : TStream); override;

   property  TextFormula : String read fFormula;
   property  IndexType : TIndexType read fIndexType;

   property  AddressList : Tm4Addresses read fAddresses;
 end;

 TdtDateNumQuery = class(TdtCustomQuery)
  private
   fFromDate   : TStDate;
   fToDate     : TStDate;
   fNumberMask : String;
   fDNType     : TDNType;
  protected
   class function GetRegNumber : Integer; override;
  public
   constructor Create(aFromDate : TStDate; aToDate : TStDate;const aNumberMask : AnsiString; aDNType : TDNType; const aPhoto : ISab = nil);
   procedure DoQuery; override;

   procedure Load(aDataStream : TStream); override;
   procedure Save(aDataStream : TStream); override;

   property FromDate   : TStDate read fFromDate;
   property ToDate     : TStDate read fToDate;
   property NumberMask : String  read fNumberMask;
   property DNType     : TDNType read fDNType;
 end;

 TdtActiveQuery = class(TdtCustomQuery)
  private
   fActiveStatus : TActiveStatusSet;
   fDate         : TStDate;
  protected
   class function GetRegNumber : Integer; override;

  public
   constructor Create(aActiveStatus : TActiveStatusSet; aDate : TStDate = cBlankDate; const aPhoto : ISab = nil);
   procedure DoQuery; override;

   procedure Load(aDataStream : TStream); override;
   procedure Save(aDataStream : TStream); override;

   property Status : TActiveStatusSet read fActiveStatus;
   property Date : TStDate read fDate;
 end;

 TdtActiveBorderQuery = class(TdtCustomQuery)
  {- Ищет документы с интервалом активности начинающимся или заканчивающимся на заданную дату}
  private
   fStart  : TStDate;
   fFinish : TStDate;
  protected
   class function GetRegNumber : Integer; override;

  public
   constructor Create(aStartDate : TStDate; aFinishDate : TStDate; const aPhoto : ISab = nil);
   procedure DoQuery; override;

   procedure Load(aDataStream : TStream); override;
   procedure Save(aDataStream : TStream); override;

 end;

 TdtCustomLogQuery = class(TdtCustomQuery)
 private
  fFromDate: TStDate;
  fToDate: TStDate;
  fUserGr: Boolean;
  fUserID: TDictID;
  f_LogRecType: TLogActionFlags;
 public
  constructor Create(aFromDate : TStDate; aToDate : TStDate; aUserID : TDictID = 0; aUserGr : Boolean = false;
      aLogRecType : TLogActionFlags = acfNone; const aPhoto : ISab = nil);
  procedure DoQuery; override;
  procedure Load(aDataStream : TStream); override;
  procedure Save(aDataStream : TStream); override;
  property FromDate: TStDate read fFromDate write fFromDate;
  property LogRecType: TLogActionFlags read f_LogRecType;
  property ToDate: TStDate read fToDate write fToDate;
  property UserGr: Boolean read fUserGr;
  property UserID: TDictID read fUserID;
 end;

 TdtSimpleLogQuery = class(TdtCustomLogQuery)
 protected
  class function GetRegNumber: Integer; override;
 public
  procedure DoQuery; override;
  procedure Load(aDataStream : TStream); override;
  procedure Save(aDataStream : TStream); override;
 end;

 TdtLogByActionQuery = class(TdtCustomLogQuery)
  private
   fAction   : TLogActionType;
  protected
   class function GetRegNumber : Integer; override;

  public
   constructor Create(aAction      : TLogActionType;
                      aFromDate    : TStDate; aToDate : TStDate;
                      aUserID      : TDictID = 0; aUserGr : Boolean = false;
                      aLogRecType  : TLogActionFlags = acfNone;
                      const aPhoto : ISab = nil);

   procedure DoQuery; override;

   procedure Load(aDataStream : TStream); override;
   procedure Save(aDataStream : TStream); override;

   property Action   : TLogActionType read fAction;
 end;

 TdtStageQuery = class(TdtCustomQuery)
  private
   fBeginDate     : TStDate;
   fEndDate       : TStDate;
   f_Stage: TStageType;
   f_StageFlag: TStageFlag;
   f_UserID: TUserID;
  protected
   class function GetRegNumber : Integer; override;
  public
   constructor Create(aBeginDate : TStDate = 0; aEndDate : TStDate = 0;
                      aStage: TStageType = stNone; aStageFlag: TStageFlag = stfNone;
                      aUserID: TUserID = 0; const aPhoto : ISab = nil);

   procedure DoQuery; override;

   procedure Load(aDataStream : TStream); override;
   procedure Save(aDataStream : TStream); override;

   property BeginDate     : TStDate   read fBeginDate;
   property EndDate       : TStDate   read fEndDate;
   property Stage: TStageType read f_Stage;
   property StageFlag: TStageFlag read f_StageFlag;
   property UserID: TUserID read f_UserID;
 end;

 TdtMainAttrQuery = class(TdtCustomQuery)
  private
   fField  : ThtField;
   fValue  : Integer;
   fIsMask : Boolean;
  protected
   class function GetRegNumber : Integer; override;

  public
   constructor Create(aField : ThtField; var aValue; const aPhoto : ISab = nil); overload;
   constructor Create(aField : ThtField; var aValue; aIsMask : Boolean; const aPhoto : ISab = nil); overload;

   procedure DoQuery; override;

   procedure Load(aDataStream : TStream); override;
   procedure Save(aDataStream : TStream); override;

   property Field : ThtField read fField;
   property Value  : Integer  read fValue;
   property IsMask : Boolean  read fIsMask;

 end;

 {!! deprecated Use TdtMainAttrQuery}
 //TdtUrgencyQuery = class(TdtMainAttrQuery)
 // public
 //  constructor Create(aUrgency : Integer; const aPhoto : ISab = nil);
 //end;

 TdtDocTypeFilterQuery = class(TdtCustomQuery)
  protected
   fUserTypeFilter : TUserTypeSet;
   fDocTypeFilter  : TDocTypeSet;

   class function GetRegNumber : Integer; override;
   procedure SetUserTypeFilter(aValue : TUserTypeSet);
   procedure SetDocTypeFilter(aValue : TDocTypeSet);

  public
   constructor Create(const aPhoto : ISab = nil); overload;

   procedure Load(aDataStream : TStream); override;
   procedure Save(aDataStream : TStream); override;
   procedure DoQuery; override;

   property UserTypeFilter : TUserTypeSet read fUserTypeFilter write SetUserTypeFilter;
   property DocTypeFilter  : TDocTypeSet  read fDocTypeFilter write SetDocTypeFilter;
 end;

 TdtDocListQuery = class(TdtCustomQuery)
  {* - интегральный контейнер для манипуляций со списком документов}
  fQuery   : TdtQuery;
  fFilter  : TdtDocTypeFilterQuery;
  fAddList : TdtIDListQuery;
  fDelList : TdtIDListQuery;
  protected
   class function GetRegNumber : Integer; override;

   procedure Cleanup; override;

   procedure SetMainTblPhoto(const aPhoto : ISab); override;
   procedure MakeUQueryAsIDList;
  public
   procedure Load(aDataStream : TStream); override;
   procedure Save(aDataStream : TStream); override;

   procedure DropData;
   procedure ClearAddLists;
   { * - чистит списки ID (fAddList и fDelList)}

   procedure DoQuery; override;

   function  MergeWith(aQuery : TdtQuery; aMergeMode : Tl3BoolOp) : Boolean; override;
   procedure SetUQuery(aQuery : TdtQuery);
   procedure SetFilterQuery(aQuery : TdtDocTypeFilterQuery);
   procedure AddID(aDocID : TDocID);
   procedure DelID(aDocID : TDocID);
   //procedure LoadFrom(const aDocIDList : ISab);

   property UQuery : TdtQuery read fQuery write SetUQuery;
   property Filter : TdtDocTypeFilterQuery read fFilter write SetFilterQuery;
 end;

 TdtAlarmQuery = class(TdtCustomQuery)
 private
  f_Finish: TStDate;
  f_Start: TStDate;
  f_Msg : String;
 protected
  class function GetRegNumber: Integer; override;
 public
  constructor Create(aStart, aFinish : TStDate; aMsg : String; const aPhoto : ISab = nil);
  procedure DoQuery; override;

  procedure Load(aDataStream : TStream); override;
  procedure Save(aDataStream : TStream); override;
  property Finish: TStDate read f_Finish write f_Finish;
  property Start: TStDate read f_Start write f_Start;
 end;

 TdtTransformQuery = class(TdtCustomQuery)
  {* - абстрактный контейнер для  преобразования результата вложенного Query}
  f_SubQuery: TdtQuery;
 protected
  procedure Cleanup; override;
 public
  procedure Load(aDataStream : TStream); override;
  procedure pm_SetSubQuery(aQuery : TdtQuery);
  procedure Save(aDataStream : TStream); override;
  property  SubQuery: TdtQuery read f_SubQuery write pm_SetSubQuery;
 end;

 TdtNOTQuery = class(TdtTransformQuery)
  {* - интегральный контейнер для инвертирования найденной выборки}
 protected
  class function GetRegNumber: Integer; override;
 public
  procedure DoQuery; override;
 end;

 TdtXorQuery = class(TdtUnitorCustomQuery)
  protected
   class function GetRegNumber : Integer; override;
  public
   procedure DoQuery; override;
   procedure GetFoundDocSubList(aDocID : TDocID; var aDSList : Tl3LongintList); override;
 end;

 TdtComplexStageQuery = class(TdtCustomQuery)
 private
  fBeginDate     : TStDate;
  fEndDate       : TStDate;
  fBeginStage    : TStageSet;
  fEndStage      : TStageSet;
  fNotEndStage   : TStageSet;
  fNotBeginStage : TStageSet;
  fDocFlag       : LongInt;
 protected
  class function GetRegNumber : Integer; override;
 public
  constructor Create(aBeginDate : TStDate; aEndDate : TStDate;
                     aBeginStage : TStageSet; aEndStage : TStageSet;
                     aNotEndStage : TStageSet; aNotBeginStage : TStageSet;
                     aDocFlag : Longint;
                     const aPhoto : ISab = nil);

  procedure DoQuery; override;

  procedure Load(aDataStream : TStream); override;
  procedure Save(aDataStream : TStream); override;

  property BeginDate     : TStDate   read fBeginDate;
  property EndDate       : TStDate   read fEndDate;
  property BeginStage    : TStageSet read fBeginStage;
  property EndStage      : TStageSet read fEndStage;
  property NotEndStage   : TStageSet read fNotEndStage;
  property NotBeginStage : TStageSet read fNotBeginStage;
  property DocFlag       : Longint   read fDocFlag;
 end;

 TdtAllDocsQuery = class(TdtCustomQuery)
 protected
  class function GetRegNumber: Integer; override;
  procedure Load(aDataStream : TStream); override;
  procedure Save(aDataStream : TStream); override;
 public
  procedure DoQuery; override;
 end;

 TdtDocLinkQuerySearchType = (stFindMasters, stFindSlaves);
 TdtDocLinkQuery = class(TdtCustomQuery)
 private
  f_LinkType: Integer;
  f_SearchType: TdtDocLinkQuerySearchType;
 protected
  class function GetRegNumber: Integer; override;
 public
  constructor Create(aSearchType: TdtDocLinkQuerySearchType; aLinkType: Integer = -1; const aPhoto : ISab = nil);
  procedure DoQuery; override;

  procedure Load(aDataStream : TStream); override;
  procedure Save(aDataStream : TStream); override;
  property LinkType: Integer read f_LinkType write f_LinkType;
  property SearchType: TdtDocLinkQuerySearchType read f_SearchType write f_SearchType;
 end;

 TdtWillBeActiveQuery = class(TdtCustomQuery)
 protected
  class function GetRegNumber: Integer; override;
  procedure Load(aDataStream : TStream); override;
  procedure Save(aDataStream : TStream); override;
 public
  procedure DoQuery; override;
 end;

 TdtDocVersionsQuery = class(TdtCustomQuery)
 private
  f_IncludeMaster: Boolean;
  f_MasterDoc: TDocID;
 protected
  class function GetRegNumber: Integer; override;
  procedure Load(aDataStream : TStream); override;
  procedure Save(aDataStream : TStream); override;
 public
  constructor Create(aDocID         : TDocID;          // документ, редакции которого мы ищем
                     aIncludeMaster : Boolean = False; // включать ли вышеупомянутый документ в список
                     const aPhoto   : ISab = nil);
  procedure DoQuery; override;
 end;

 TdtCorrespQuery = class(TdtTransformQuery)
  {* - поиск корреспондентов найденной выборки}
 protected
  class function GetRegNumber: Integer; override;
 public
  procedure DoQuery; override;
 end;

 TdtRespQuery = class(TdtTransformQuery)
  {* - поиск респондентов найденной выборки}
 protected
  class function GetRegNumber: Integer; override;
 public
  procedure DoQuery; override;
 end;

type
 TdtStatusMaskQuery = class(TdtCustomQuery)
  {- Ищет документы с заданной маской поля Status}
  private
   f_StatusMask: Word;
  protected
   class function GetRegNumber : Integer; override;
  public
   constructor Create(aStatusMask : Word; const aPhoto : ISab = nil);
   procedure DoQuery; override;
   procedure Load(aDataStream : TStream); override;
   procedure Save(aDataStream : TStream); override;
   property StatusMask: Word read f_StatusMask write f_StatusMask;

 end;

 TdtPubInFlagsQuery = class(TdtCustomQuery)
 {- Ищет документы с заданной маской поля Flags в PublishedIn-атрибуте документа}
 private
  f_Mask: Byte;

 protected
  class function GetRegNumber: Integer; override;
 public
  constructor Create(aMask : Byte; const aPhoto : ISab = nil);
  procedure DoQuery; override;
  procedure Load(aDataStream : TStream); override;
  procedure Save(aDataStream : TStream); override;
 end;

 TdtExpandEditionsQuery = class(TdtTransformQuery)
  {* - дополнение выборки всеми редакциями сключённых в неё документов}
 protected
  class function GetRegNumber: Integer; override;
 public
  procedure DoQuery; override;
 end;

function  g_dtLoadQuery(aDataStream : TStream) : TdtQuery;
procedure g_dtSaveQuery(aQuery: TdtQuery; aDataStream : TStream);

const
 c_rnUnDef                = 0;
 c_rnIDListQuery          = 1;
 c_rnAndQuery             = 2;
 c_rnOrQuery              = 3;
 c_rnDictQuery            = 4;
 c_rntextQuery            = 5;
 c_rnDateNumQuery         = 6;
 c_rnActiveQuery          = 7;
 c_rnStageQuery           = 8;
 c_rnDocListQuery         = 9;
 c_rnDocTypeFilterQuery   = 10;
 c_rnMainAttrQuery        = 11;
 c_rnLogByActionQuery     = 12;
 c_rnAlarmQuery           = 13;
 c_rnNOTQuery             = 14;
 c_rnSimpleLogQuery       = 15;
 c_rnXorQuery             = 16;
 c_rnComplexStageQuery    = 17;
 c_rnDocLinkQuery         = 18;
 c_rnAllDocsQuery         = 19;
 c_rnWillBeActiveQuery    = 20;
 c_rnDocVersionsQuery     = 21;
 c_rnActiveBorderQuery    = 22;
 c_rnCorrespQuery         = 23;
 c_rnStatusMaskQuery      = 24;
 c_rnPubInFlagsQuery      = 25;
 c_rnRespQuery            = 26;
 c_rnExpandEditionsQuery  = 27;

const
 MaxDoneType = 2;

 cDone      = 1;
 cNotDone   = 2;

function dtL2QA(Action: Pointer): TdtQueryAction;
{* - делает заглушку для локальной процедуры (как l3L2FA). }

implementation

uses
  WinTypes,
  HT_Dll,
  Dt_Serv, Dt_Err, Dt_Link, Dt_Dict, Dt_Misc,
  Dt_Hyper, Dt_User,
  DT_Active, Dt_Log, DT_Alarm, DT_SrchQueries,
  dt_LinkServ,
  m4Search, m4SearchExEx,
  StDateSt,
  l3MinMax, l3Bits, l3String, l3DateSt,
  l3TreeInterfaces, l3Tree, l3Tree_TLB, l3Nodes,
  l3TreeSupport,l3FileUtils
  , l3LongintListPrim, dt_DictConst;

const
 cQueryIDNotRegistered = 'aQueryID не зарегистрирована';

{$Include l3ChangingChangedNotifier.imp.pas}

{$Include l3LockedChange.imp.pas}

function dtL2QA(Action: Pointer): TdtQueryAction;
asm
 jmp  l3LocalStub
end;{asm}

class function TdtIDListQuery.GetRegNumber : Integer;
begin
 Result := c_rnIDListQuery;
end;

class function TdtDocTypeFilterQuery.GetRegNumber : Integer;
begin
 Result := c_rnDocTypeFilterQuery;
end;

class function TdtDocListQuery.GetRegNumber : Integer;
begin
 Result := c_rnDocListQuery;
end;

class function TdtAndQuery.GetRegNumber : Integer;
begin
 Result := c_rnAndQuery;
end;

class function TdtOrQuery.GetRegNumber : Integer;
begin
 Result := c_rnOrQuery;
end;

class function TdtDictQuery.GetRegNumber : Integer;
begin
 Result := c_rnDictQuery;
end;

class function TdttextQuery.GetRegNumber : Integer;
begin
 Result := c_rntextQuery;
end;

class function TdtDateNumQuery.GetRegNumber : Integer;
begin
 Result := c_rnDateNumQuery;
end;

class function TdtActiveQuery.GetRegNumber : Integer;
begin
 Result := c_rnActiveQuery;
end;

class function TdtStageQuery.GetRegNumber : Integer;
begin
 Result := c_rnStageQuery;
end;

class function TdtMainAttrQuery.GetRegNumber : Integer;
begin
 Result := c_rnMainAttrQuery;
end;

class function TdtLogByActionQuery.GetRegNumber : Integer;
begin
 Result := c_rnLogByActionQuery;
end;

class function TdtActiveBorderQuery.GetRegNumber : Integer;
begin
 Result := c_rnActiveBorderQuery;
end;

class function TdtNOTQuery.GetRegNumber: Integer;
begin
 Result := c_rnNOTQuery;
end;

class function TdtCorrespQuery.GetRegNumber: Integer;
begin
 Result := c_rnCorrespQuery;
end;

class function TdtRespQuery.GetRegNumber: Integer;
begin
 Result := c_rnRespQuery;
end;

{TdtCustomQuery}
constructor TdtCustomQuery.Create(const aPhoto : ISab = nil);
begin
 inherited Create;
 MainTblPhoto := aPhoto;
end;

constructor TdtCustomQuery.CreateAndLoad(aDataStream : TStream; const aPhoto : ISab = nil);
begin
 Create(aPhoto);
 Load(aDataStream);
end;

procedure TdtCustomQuery.Load(aDataStream : TStream);
begin
 Assert(False, 'TdtCustomQuery.Load');
end;

procedure TdtCustomQuery.Save(aDataStream : TStream);
begin
 Assert(False, 'TdtCustomQuery.Save');
end;

function  TdtCustomQuery.IsEmpty : Boolean;
begin
 Result := (FoundList = nil) or (FoundList.Count = 0);
end;

procedure TdtCustomQuery.SetMainTblPhoto(const aPhoto : ISab);
begin
 if SamePhoto(fMainTblPhoto, aPhoto) then Exit;
 fMainTblPhoto := aPhoto;
 Inc(fPreventDropRes);
 try
  Changing;
  try
   if fSab <> nil then
   fSab.SyncWith(fMainTblPhoto);
  finally
   Changed;
  end;
 finally
  Dec(fPreventDropRes);
 end;
end;

function TdtCustomQuery.GetMainTblPhoto : ISab;
begin
 if fMainTblPhoto = nil then
  fMainTblPhoto := MakePhoto(GlobalHtServer.GetTblObjectEx(CurrentFamily, Ord(ftFile)));
 Result := fMainTblPhoto;
end;

procedure TdtCustomQuery.RefreshMainTblPhoto;
begin
 if fMainTblPhoto = nil then Exit;
 MainTblPhoto := MakePhoto(fMainTblPhoto.Table);
end;

function TdtCustomQuery.GetFoundList : ISab;
begin
 if fSab = nil then
  DoQuery;
 Result := fSab;
end;

procedure TdtCustomQuery.DropResult;
begin
 if fPreventDropRes = 0 then
  fSab := nil;
end;

function TdtCustomQuery.HasResult : Boolean;
begin
 Result := (fSab <> nil);
end;

procedure TdtCustomQuery.FireChanged;
begin
 DropResult;
 inherited;
end;

function TdtCustomQuery.GetDocIdList: ISab;
begin
 if IsEmpty then
  Result := MakeEmptyValueSab(MainTblPhoto, fId_Fld)
 else
 begin
  Result := MakeSabCopy(FoundList);
  Result.ValuesOfKey(fId_Fld);
 end;
end;

function TdtCustomQuery.MergeWith(aQuery : TdtQuery; aMergeMode : Tl3BoolOp) : Boolean;
begin
 Result := false;
end;

procedure TdtCustomQuery.Iterate(Action: TdtQueryAction);
begin
  DoIterate(Action);
end;

procedure TdtCustomQuery.IterateF(Action: TdtQueryAction);
begin
 try
  Iterate(Action);
 finally
  l3FreeFA(Tl3FreeAction(Action));
 end;{try..finally}
end;

function TdtCustomQuery.DoIterate(Action: TdtQueryAction): Boolean;
begin
  Result := Action(Self);
end;

{TdtDictQuery}
constructor TdtDictQuery.Create(aDictType    : TdaDictionaryType;
                                aDictIDList  : Tl3LongintList;
                                aWithEquals  : Boolean = False;
                                aWithSubTree : Boolean = False;
                                aWholeDocOnly: Boolean = False;
                                const aPhoto : ISab = nil);
begin
 inherited Create(aPhoto);

 fDictType := aDictType;
 //fSab  : ISab;

 fWithEquals  := aWithEquals;
 fWithSubTree := aWithSubTree;
 fWholeDocOnly := aWholeDocOnly;

 fDictIDList  := aDictIDList.Use;
end;

constructor TdtDictQuery.Create(aDictType    : TdaDictionaryType;
                                aDictID      : TDictID;
                                aWithEquals  : Boolean = False;
                                aWithSubTree : Boolean = False;
                                aWholeDocOnly: Boolean = False;
                                const aPhoto : ISab = nil);
var
 l_List: Tl3LongintList;
begin
 l_List := Tl3LongintList.Make;
 try
  l_List.Add(aDictID);
  Create(aDictType, l_List, aWithEquals, aWithSubTree, aWholeDocOnly, aPhoto);
 finally
  l3Free(l_List);
 end;
end;

procedure TdtDictQuery.Cleanup;
begin
 l3Free(fDictIDList);
 inherited;
end;

procedure TdtDictQuery.Load(aDataStream : TStream);
var
 lValue : Longint;
 lVersion : Longint;
begin
 aDataStream.Read(lVersion, SizeOf(Longint));
 //
 aDataStream.Read(lValue, SizeOf(Longint));
 fDictType := TdaDictionaryType(lValue);

 aDataStream.Read(lValue, SizeOf(Longint));
 fWithEquals := Boolean(lValue);

 aDataStream.Read(lValue, SizeOf(Longint));
 fWithSubTree := Boolean(lValue);

 if fDictIDList = nil then
  fDictIDList := Tl3LongintList.Create;
 fDictIDList.Load(aDataStream);
end;

procedure TdtDictQuery.Save(aDataStream : TStream);
var
 lValue : Longint;
 lVersion : Longint;
begin
 lVersion := 0;
 aDataStream.Write(lVersion, SizeOf(Longint));

 lValue := Longint(fDictType);
 aDataStream.Write(lValue, SizeOf(Longint));

 lValue := Byte(fWithEquals);
 aDataStream.Write(lValue, SizeOf(Longint));

 lValue := Byte(fWithSubTree);
 aDataStream.Write(lValue, SizeOf(Longint));

 fDictIDList.Save(aDataStream);
end;

function TdtDictQuery.MakeDictIDValueSab : ISab;
begin
 Result := GetExpandDictIDValueSab(fDictType, fDictIDList);
end;

procedure TdtDictQuery.DoQuery;
var
 lValue : ISab;
 lExtValue : ISab;
 lLinkDictType : TdaDictionaryType;
 lHasDefItem : boolean;
 l_SubID: TSubID;

begin
 //WriteResHeader(Format('Поиск по словарю "%s"', [cDLPassports[lDictType].rName]));
 if (fDictIDList <> nil) and (fDictIDList.Count > 0) then
 begin
  if fWithSubTree then
   lValue := MakeDictIDValueSab
  else
  begin
   lLinkDictType := cDLPassports[fDictType].rDepDictID;
   if lLinkDictType = da_dlNone then lLinkDictType := fDictType;

   lValue := MakeValueSet(LinkServer(CurrentFamily).Links[lLinkDictType].Table, lnkDictIDFld, fDictIDList);
  end;

  if cDLPassports[fDictType].rDefValue = cNoDefValue then
   lHasDefItem := false
  else
   lHasDefItem := fDictIDList.IndexOf(cDLPassports[fDictType].rDefValue) >= 0;

  lValue.RecordsByKey;
  if lHasDefItem then
   lValue.InvertSab;

  if (fDictType in sSubLinkDicts) and fWholeDocOnly then
  begin
   l_SubID := 0;
   lValue.SubSelect(lnkSubIDFld, l_SubID);
  end; 

  lValue.ValuesOfKey(lnkDocIDFld);
  lValue.TransferToPhoto(fID_Fld, MainTblPhoto);
  lValue.RecordsByKey;
  if lHasDefItem then
   lValue.InvertSab;

  fSab := lValue;
 end
 else
  fSab := MakeEmptySab(MainTblPhoto);
 //WriteResCount('', fSrchData[aSrchAtom].FList.gFoundCnt);
end;

procedure TdtDictQuery.GetFoundDocSubList(aDocID : TDocID; var aDSList : Tl3LongintList);
var
 lValue : ISab;
 lExtValue : ISab;
 lLinkDictType : TdaDictionaryType;

begin
 aDSList := nil;
 if not (cDLType2Attributes[fDictType] in cSubDictExpData) then
  Exit;

 if fDictIDList <> nil then
  if fWithSubTree then
   lValue := MakeDictIDValueSab
  else
  begin
   lLinkDictType := cDLPassports[fDictType].rDepDictID;
   if lLinkDictType = da_dlNone then lLinkDictType := fDictType;

   lValue := MakeValueSet(LinkServer(CurrentFamily).Links[lLinkDictType].Table, lnkDictIDFld, fDictIDList);
  end;

 lValue.RecordsByKey;
 lValue.SubSelect(lnkDocIDFld, aDocID);
 if lValue.Count = 0 then Exit;
 lValue.ValuesOfKey(lnkSubIDFld);

 aDSList := dtMakeSortedIDListBySab(lValue);
end;

{TdtUnitorCustomQuery}
function TdtUnitorCustomQuery.GetQueryList : Tl3ObjectRefArray;
begin
 if fQueryList = nil then
  fQueryList := Tl3ObjectRefArray.Create;
 Result := fQueryList;
end;

procedure TdtUnitorCustomQuery.AddQuery(aQuery : TdtQuery);
begin
 Changing;
 QueryList.Add(aQuery);
 Changed;
end;

procedure TdtUnitorCustomQuery.AddQueryF(var theQuery: TdtQuery);
begin
 Assert(Assigned(theQuery));
 AddQuery(theQuery);
 l3Free(theQuery);
end;

procedure TdtUnitorCustomQuery.Cleanup;
begin
 l3Free(fQueryList);
 inherited;
end;

procedure TdtUnitorCustomQuery.DropData;
begin
 if fQueryList <> nil then
  fQueryList.Clear;
end;

procedure TdtUnitorCustomQuery.Load(aDataStream : TStream);
var
 lValue   : Longint;
 lVersion : Longint;
 lCount   : Longint;
 lQuery   : TdtQuery;
 I        : Integer;
begin
 aDataStream.Read(lVersion, SizeOf(Longint));
 aDataStream.Read(lCount, SizeOf(Longint));
 for I := 0 to Pred(lCount) do
 begin
  lQuery := g_dtLoadQuery(aDataStream);
  try
   AddQuery(lQuery);
  finally
   l3Free(lQuery);
  end;
 end;
end;

procedure TdtUnitorCustomQuery.Save(aDataStream : TStream);
var
 lValue   : Longint;
 lVersion : Longint;
 lCount   : Longint;
 lQuery   : TdtQuery;

 I        : Integer;
begin
 lVersion := 0;
 aDataStream.Write(lVersion, SizeOf(Longint));

 if fQueryList = nil then
  lCount := 0
 else
  lCount := fQueryList.Count;
 aDataStream.Write(lCount, SizeOf(Longint));

 for I := 0 to Pred(lCount) do
  g_dtSaveQuery(TdtCustomQuery(fQueryList[I]), aDataStream);
end;

function TdtUnitorCustomQuery.DoIterate(Action: TdtQueryAction): Boolean;
var
 I: Integer;
begin
 Result := inherited DoIterate(Action);
 if Result and (fQueryList <> nil) then
  for I := 0 to Pred(fQueryList.Count) do
  begin
   Result := TdtCustomQuery(fQueryList[I]).DoIterate(Action);
   if not Result then
    Break;
  end;
end;

{TdtAndQuery}

procedure TdtAndQuery.DoQuery;
var
 I : Integer;
 l_Query: TdtCustomQuery;
begin
 if QueryList.Count = 0 then
  fSab := MakeEmptySab(MainTblPhoto)
 else
 begin
  TdtCustomQuery(fQueryList[0]).MainTblPhoto := MainTblPhoto;
  fSab := MakeSabCopy(TdtCustomQuery(fQueryList[0]).FoundList);
  TdtCustomQuery(fQueryList[0]).DropResult;
  for I := 1 to Pred(QueryList.Count) do
  begin
   if fSab.IsEmpty then // если у нас пустой результат,
    Break; // то дальнейшие вычисления не нужны
   TdtCustomQuery(fQueryList[I]).MainTblPhoto := MainTblPhoto;
   l_Query := TdtCustomQuery(fQueryList[I]);
   fSab.AndSab(l_Query.FoundList);
   l_Query.DropResult;
  end;
 end;
end;

procedure TdtAndQuery.GetFoundDocSubList(aDocID : TDocID; var aDSList : Tl3LongintList);
var
 I : Integer;
 lDSList : Tl3LongintList;
begin
 aDSList := nil;
 for I := 0 to Pred(QueryList.Count) do
  if fQueryList[I] is TdtDictQuery then
  begin
   TdtDictQuery(fQueryList[I]).GetFoundDocSubList(aDocID, lDSList);
   if (lDSList <> nil) then
   begin
    if aDSList = nil then
     aDSList := lDSList.Use
    else
     aDSList.IntersectList(lDSList);
    l3Free(lDSList);
   end;
  end;
end;


{TdtOrQuery}
procedure TdtOrQuery.DoQuery;
var
 I : Integer;
 l_Query: TdtCustomQuery;
begin
 fSab := MakeEmptySab(MainTblPhoto);
 for I := 0 to Pred(QueryList.Count) do
 begin
  TdtCustomQuery(fQueryList[I]).MainTblPhoto := MainTblPhoto;
  l_Query := TdtCustomQuery(fQueryList[I]);
  fSab.OrSab(l_Query.FoundList);
  l_Query.DropResult;
 end;
end;

procedure TdtOrQuery.GetFoundDocSubList(aDocID : TDocID; var aDSList : Tl3LongintList);
var
 I : Integer;
 lDSList : Tl3LongintList;
begin
 aDSList := nil;
 for I := 0 to Pred(QueryList.Count) do
  if fQueryList[I] is TdtDictQuery then
  begin
   TdtDictQuery(fQueryList[I]).GetFoundDocSubList(aDocID, lDSList);
   if (lDSList <> nil) then
   begin
    if aDSList = nil then
     aDSList := lDSList.Use
    else
     aDSList.InsertList(lDSList);
    l3Free(lDSList);
   end;
  end;
end;

{TdtIDListQuery}
constructor TdtIDListQuery.CreateFrom(const aDocIDList : ISab; const aPhoto : ISab = nil);
begin
 Create(aPhoto);
 if (aDocIDList <> nil) and (aDocIDList.Count > 0) then
 begin
  fIDList := dtMakeSortedIDListBySab(aDocIDList);
  fSab := MakeSabCopy(aDocIDList);
  fSab.TransferToPhoto(fID_Fld, MainTblPhoto);
  fSab.RecordsByKey;
 end
 else
  fSab := MakeEmptySab(MainTblPhoto);
end;

procedure TdtIDListQuery.Cleanup;
begin
 l3Free(fIDList);
 inherited;
end;

procedure TdtIDListQuery.DoQuery;
begin
 if IDList.Count > 0 then
 begin
  fSab := MakeValueSet(MainTblPhoto.Table, fID_Fld, IDList);
  fSab.TransferToPhoto(fID_Fld, MainTblPhoto);
  fSab.RecordsByKey;
 end
 else
  fSab := MakeEmptySab(MainTblPhoto);
end;

function TdtIDListQuery.MergeWith(aQuery : TdtQuery; aMergeMode : Tl3BoolOp) : Boolean;
var
 lSab : ISab;
 lList : Tl3LongintList;
begin
 Result := True;

 if aQuery is TdtIDListQuery then
  lList := TdtIDListQuery(aQuery).IDList.Use
 else
 begin
  lSab := MakeSabCopy(aQuery.FoundList);
  lSab.ValuesOfKey(fID_Fld);
  lList := dtMakeSortedIDListBySab(lSab);
 end;
 try
  Case aMergeMode of
   l3_boAnd    : IDList.IntersectList(lList);
   l3_boOr     : IDList.InsertList(lList);
   l3_boAndNot : IDList.DeleteList(lList);
  end; // case

  DropResult;
  finally
   l3Free(lList);
  end;
end;

function TdtIDListQuery.GetIDList : Tl3LongintList;
begin
 if fIDList = nil then
 begin
  fIDList := Tl3LongintList.Create;
  fIDList.Sorted := True;
 end;
 Result := fIDList;
end;

procedure TdtIDListQuery.Load(aDataStream : TStream);
var
 lVersion : Longint;
begin
 aDataStream.Read(lVersion, SizeOf(Longint));

 Changing;
 IDList.Load(aDataStream);
 Changed;
end;

procedure TdtIDListQuery.Save(aDataStream : TStream);
var
 lVersion : Longint;
begin
 lVersion := 0;
 aDataStream.Write(lVersion, SizeOf(Longint));

 IDList.Save(aDataStream);
end;

procedure TdtIDListQuery.AddID(aDocID : TDocID);
begin
 Changing;
 IDList.Add(aDocID);
 Changed;
end;

procedure TdtIDListQuery.DelID(aDocID : TDocID);
var
 lIndex : TListIndex;
begin
 lIndex := IDList.IndexOf(aDocID);
 if lIndex >= 0 then
 begin
  Changing;
  IDList.Delete(lIndex);
  Changed;
 end;
end;

function  TdtIDListQuery.IsEmpty : Boolean;
begin
 Result := (fIDList = nil) or (fIDList.Count = 0);
end;

{TDocTypeFilterQuery}
constructor TdtDocTypeFilterQuery.Create(const aPhoto : ISab = nil);
begin
 inherited Create(aPhoto);
 fUserTypeFilter := cAllUserTypeSet;
 fDocTypeFilter  := cAllDocTypeSet;
end;

procedure TdtDocTypeFilterQuery.SetUserTypeFilter(aValue : TUserTypeSet);
begin
 Changing;
 fUserTypeFilter := aValue;
 changed;
end;

procedure TdtDocTypeFilterQuery.SetDocTypeFilter(aValue : TDocTypeSet);
begin
 Changing;
 fDocTypeFilter := aValue;
 DropResult;
 Changed;
end;

procedure TdtDocTypeFilterQuery.DoQuery;

 function lMakeDocTypesFilterSab : ISab;
 var
  I : TDocType;
  lValueSetFiller : IValueSetFiller;
 begin
  Result := MakeSab(MainTblPhoto.Table);

  lValueSetFiller := Result.MakeValueSetFiller(fType_Fld, MainTblPhoto);
  try
   for I := Low(TDocType) to High(TDocType) do
    if I in fDocTypeFilter then
     lValueSetFiller.AddValue(I);
  finally
   lValueSetFiller := nil;
  end;
  Result.RecordsByKey;
 end;

 function lMakeUserDocTypesSab : ISab;
 var
  I : TUserType;
  lValueSetFiller : IValueSetFiller;
 begin
  Result := MakeSab(MainTblPhoto.Table);
  lValueSetFiller := Result.MakeValueSetFiller(fUserType_Fld, MainTblPhoto);
  try
   for I := Low(TUserType) to High(TUserType) do
    if I in fUserTypeFilter then
     lValueSetFiller.AddValue(I);
  finally
   lValueSetFiller := nil;
  end;

  Result.RecordsByKey;
 end;

begin
 if (fUserTypeFilter = cAllUserTypeSet) and (fDocTypeFilter = cAllDocTypeSet) then
 begin
  fSab := MakeAllRecords(MainTblPhoto);
  Exit;
 end;

 if (fUserTypeFilter <> cAllUserTypeSet) and (fDocTypeFilter = cAllDocTypeSet) then
 begin
  fSab := lMakeUserDocTypesSab;
  Exit;
 end;

 if (fUserTypeFilter = cAllUserTypeSet) and (fDocTypeFilter <> cAllDocTypeSet) then
 begin
  fSab := lMakeDocTypesFilterSab;
  Exit;
 end;

 if (fUserTypeFilter <> cAllUserTypeSet) and (fDocTypeFilter <> cAllDocTypeSet) then
 begin
  fSab := lMakeUserDocTypesSab;
  fSab.AndSab(lMakeDocTypesFilterSab);
 end;
end;

procedure TdtDocTypeFilterQuery.Load(aDataStream : TStream);
var
 lVersion : Longint;
begin
 aDataStream.Read(lVersion, SizeOf(Longint));

 Changing;
 {fUserTypeFilter}
 aDataStream.Read(fUserTypeFilter, SizeOf(fUserTypeFilter));

 {fDocTypeFilter}
 aDataStream.Read(fDocTypeFilter, SizeOf(fDocTypeFilter));
 Changed;
end;

procedure TdtDocTypeFilterQuery.Save(aDataStream : TStream);
var
 lVersion : Longint;

begin
 lVersion := 0;
 aDataStream.Write(lVersion, SizeOf(Longint));

 {fUserTypeFilter}
 aDataStream.Write(fUserTypeFilter, SizeOf(fUserTypeFilter));

 {fDocTypeFilter}
 aDataStream.Write(fDocTypeFilter, SizeOf(fDocTypeFilter));
end;

{TdtDocListQuery}
procedure TdtDocListQuery.Cleanup;
begin
 DropData;
 inherited;
end;

procedure TdtDocListQuery.DropData;
begin
 UQuery := nil;
 Filter  := nil;
 l3Free(fAddList);
 l3Free(fDelList);
end;

procedure TdtDocListQuery.ClearAddLists;
begin
 l3Free(fAddList);
 l3Free(fDelList);
end;

(*
procedure TdtDocListQuery.LoadFrom(const aDocIDList : ISab);
begin
 Changing;
 DropData;
 DropResult;
 fAddList := TdtIDListQuery.CreateFrom(aDocIDList);
 Changed;
end;
*)

const
 pmbQuery   = 1;
 pmbAddList = 2;
 pmbDelList = 3;
 pmbFilter  = 4;

 procedure TdtDocListQuery.Load(aDataStream : TStream);
var
 lVersion : Longint;
 lPartMap : longint;
 lQuery   : TdtQuery;
 lFilter  :TdtDocTypeFilterQuery;
begin
 aDataStream.Read(lVersion, SizeOf(Longint));

 aDataStream.Read(lPartMap, SizeOf(Longint));
 if l3TestBit(lPartMap, pmbQuery) then
 begin
  lQuery := g_dtLoadQuery(aDataStream);
  try
   UQuery := lQuery;
  finally
   l3Free(lQuery);
  end;
 end;

 if l3TestBit(lPartMap, pmbAddList) then
 begin
  fAddList := TdtIDListQuery(g_dtLoadQuery(aDataStream));
  fAddList.MainTblPhoto := fMainTblPhoto;

  //если UQuery is TdtIDListQuery, смерджим сразу с листом добавок
  if (UQuery <> nil) and (UQuery is TdtIDListQuery) then
  begin
   UQuery.MergeWith(fAddList, l3_boOr);
   l3Free(fAddList);
  end;
 end;

 if l3TestBit(lPartMap, pmbDelList) then
 begin
  fDelList := TdtIDListQuery(g_dtLoadQuery(aDataStream));
  fDelList.MainTblPhoto := fMainTblPhoto;

  //если UQuery is TdtIDListQuery, смерджим сразу с листом добавок
  if (UQuery <> nil) and (UQuery is TdtIDListQuery) then
  begin
   UQuery.MergeWith(fDelList, l3_boAndNot);
   l3Free(fDelList);
  end;

 end;

 if l3TestBit(lPartMap, pmbFilter) then
 begin
  lFilter := TdtDocTypeFilterQuery(g_dtLoadQuery(aDataStream));
  try
   lFilter.MainTblPhoto := fMainTblPhoto;
   Filter := lFilter;
  finally
   l3Free(lFilter);
  end;
 end;
end;

procedure TdtDocListQuery.Save(aDataStream : TStream);
var
 lVersion : Longint;
 lPartMap : longint;
begin
 lVersion := 0;
 aDataStream.Write(lVersion, SizeOf(Longint));

 lPartMap := 0;
 if fQuery <> nil then
  l3SetBit(lPartMap, pmbQuery);
 if fAddList <> nil then
  l3SetBit(lPartMap, pmbAddList);
 if fDelList <> nil then
  l3SetBit(lPartMap, pmbDelList);
 if fFilter <> nil then
  l3SetBit(lPartMap, pmbFilter);

 aDataStream.Write(lPartMap, SizeOf(Longint));

 if fQuery <> nil then
  g_dtSaveQuery(fQuery, aDataStream);
 if fAddList <> nil then
  g_dtSaveQuery(fAddList, aDataStream);
 if fDelList <> nil then
  g_dtSaveQuery(fDelList, aDataStream);
 if fFilter <> nil then
  g_dtSaveQuery(fFilter, aDataStream);
end;

procedure TdtDocListQuery.SetMainTblPhoto(const aPhoto : ISab);
begin
 if SamePhoto(fMainTblPhoto, aPhoto) then Exit;
 fMainTblPhoto := MakeSabCopy(aPhoto);

 Inc(fPreventDropRes);
 try
  Changing;
  try
   if fSab <> nil then
    fSab.SyncWith(fMainTblPhoto);

   if fQuery <> nil then
    fQuery.MainTblPhoto := fMainTblPhoto;

   if (fAddList <> nil) then
    fAddList.MainTblPhoto := fMainTblPhoto;

   if (fDelList <> nil) then
    fDelList.MainTblPhoto := fMainTblPhoto;

   if fFilter <> nil then
    fFilter.MainTblPhoto := fMainTblPhoto;
   finally
    Changed;
   end;
 finally
  Dec(fPreventDropRes);
 end;

end;

procedure TdtDocListQuery.DoQuery;
var
 lPhoto : ISab;
begin
cNeedTrace42err := true;
try
 lPhoto := MakeSabCopy(MainTblPhoto);
 if fQuery <> nil then
 begin
  fQuery.MainTblPhoto := lPhoto;
  fSab := MakeSabCopy(fQuery.FoundList);
  fQuery.DropResult;
 end;

 if (fAddList <> nil) then
 begin
  fAddList.MainTblPhoto := lPhoto;
  if not fAddList.IsEmpty then
  begin
   if (fSab <> nil) and not fSab.IsEmpty then
    fSab.OrSab(fAddList.FoundList)
   else
    fSab := MakeSabCopy(fAddList.FoundList);
   fAddList.DropResult;
  end;
 end;

 if (fDelList <> nil) then
 begin
  fDelList.MainTblPhoto := lPhoto;
  if not fDelList.IsEmpty and
    (fSab <> nil) and not fSab.IsEmpty then
  begin
   fSab.SubtractSab(fDelList.FoundList);
   fDelList.DropResult;
  end;
 end;

 if fFilter <> nil then
  if (fSab <> nil) and not fSab.IsEmpty then
 begin
  fFilter.MainTblPhoto := lPhoto;
  fSab.AndSab(fFilter.FoundList);
  fFilter.DropResult;
 end;
finally
 cNeedTrace42err := false;
end;
end;

procedure TdtDocListQuery.MakeUQueryAsIDList;
var
 lSab : ISab;
 lTdtIDListQuery : TdtIDListQuery;
begin
 if FoundList = nil then
  lTdtIDListQuery := TdtIDListQuery.Create
 else
 begin
  lSab := MakeSabCopy(FoundList);
  lSab.ValuesOfKey(fId_Fld);
  lTdtIDListQuery := TdtIDListQuery.CreateFrom(lSab);
 end;
 try
  UQuery := lTdtIDListQuery;
 finally
  l3Free(lTdtIDListQuery);
 end;
 ClearAddLists;
end;

procedure TdtDocListQuery.AddID(aDocID : TDocID);
begin
 Changing;
 try
  if UQuery = nil then
   MakeUQueryAsIDList;

  if (UQuery is TdtIDListQuery) then
   TdtIDListQuery(UQuery).AddID(aDocID)
  else
  begin
   if fAddList = nil then
    fAddList := TdtIDListQuery.Create(MainTblPhoto);
   fAddList.AddID(aDocID);
   if fDelList <> nil then
    fDelList.DelID(aDocID);
   RefreshMainTblPhoto;
  end;
 finally
  Changed;
 end;
end;

procedure TdtDocListQuery.DelID(aDocID : TDocID);
begin
 Changing;
 try
  if UQuery = nil then
   MakeUQueryAsIDList;

  if (UQuery is TdtIDListQuery) then
   TdtIDListQuery(UQuery).DelID(aDocID)
  else
  begin
   if fDelList = nil then
    fDelList := TdtIDListQuery.Create(MainTblPhoto);
   fDelList.AddID(aDocID);

   if fAddList <> nil then
    fAddList.DelID(aDocID);
  end;
 finally
  Changed;
 end;
end;

function TdtDocListQuery.MergeWith(aQuery : TdtQuery; aMergeMode : Tl3BoolOp) : Boolean;
begin
 Result := True;
 Changing;

 if not (UQuery is TdtIDListQuery) then // трансформируем Query в IDList
  MakeUQueryAsIDList;

 UQuery.MergeWith(aQuery, aMergeMode);
 Changed;
end;

procedure TdtDocListQuery.SetUQuery(aQuery : TdtQuery);
begin
 if fQuery = aQuery then Exit;

 Changing;

 if fQuery <> nil then
  (fQuery as Il3ChangeNotifier).Unsubscribe(Il3ChangeRecipient(Self));

 l3Set(fQuery, aQuery);

 if aQuery <> nil then
 begin
  if aQuery.HasResult then // результат подсчитан, проще синхронизировать с его Photo что бы не пересчитывать
   MainTblPhoto := aQuery.MainTblPhoto
  else
   aQuery.MainTblPhoto := MainTblPhoto;
  (aQuery as Il3ChangeNotifier).Subscribe(Il3ChangeRecipient(Self));
 end;

 Changed;
end;

procedure TdtDocListQuery.SetFilterQuery(aQuery : TdtDocTypeFilterQuery);
begin
 if fFilter = aQuery then Exit;
 if fFilter <> nil then
  (fFilter as Il3ChangeNotifier).Unsubscribe(Il3ChangeRecipient(Self));
 l3Set(fFilter, aQuery);
 if fFilter <> nil then
 begin                          
  fFilter.MainTblPhoto := MainTblPhoto;
  (fFilter as Il3ChangeNotifier).Subscribe(Il3ChangeRecipient(Self));
 end;
 Changing;
 Changed;
end;

{TdtTextQuery}
constructor TdtTextQuery.Create(const aTextFormula : AnsiString; aIndexType : TIndexType; const aPhoto : ISab = nil);
begin
 inherited Create(aPhoto);
 fFormula := aTextFormula;
 fIndexType := aIndexType;
end;

procedure TdtTextQuery.Cleanup;
begin
 l3Free(fAddresses);
 Inherited;
end;

procedure TdtTextQuery.DoQuery;
var
 lIDList : Tl3LongintList;
begin
 l3Free(fAddresses);
 lIDList := m4SearchByFormula(GetTextIndexPath(CurrentFamily, fIndexType), l3PCharLen(fFormula), @fAddresses);
 try
  fSab := MakeValueSet(MainTblPhoto.Table, fID_Fld, lIDList);
  fSab.RecordsByKey;
 finally
  l3Free(lIDList);
 end;
end;

procedure TdtTextQuery.Load(aDataStream : TStream);
var
 lVersion : Longint;
 lValue   : Longint;
begin
 aDataStream.Read(lVersion, SizeOf(Longint));

 Changing;
 {fFormula}
 aDataStream.Read(lValue, SizeOf(Longint));
 SetLength(fFormula, lValue);
 if lValue > 0 then
  aDataStream.Read(fFormula[1], lValue);

 {fIndexType}
 aDataStream.Read(lValue, SizeOf(Longint));
 fIndexType := TIndexType(lValue);

 Changed;
end;

procedure TdtTextQuery.Save(aDataStream : TStream);
var
 lValue   : Longint;
 lVersion : Longint;
begin
 lVersion := 0;
 aDataStream.Write(lVersion, SizeOf(Longint));

 {fFormula}
 lValue := Length(fFormula);
 aDataStream.Write(lValue, SizeOf(Longint));
 if lValue > 0 then
  aDataStream.Write(fFormula[1], lValue);

 {fIndexType}
 lValue := Ord(fIndexType);
 aDataStream.Write(lValue, SizeOf(Longint));
end;

{TdtDateNumQuery}
constructor TdtDateNumQuery.Create(aFromDate : TStDate; aToDate : TStDate;const aNumberMask : AnsiString; aDNType : TDNType; const aPhoto : ISab = nil);
begin
 inherited Create(aPhoto);
 fFromDate   := aFromDate;
 fToDate     := aToDate;
 fNumberMask := aNumberMask;
 fDNType     := aDNType;
end;

procedure TdtDateNumQuery.DoQuery;

 function NormNumberMask(const aNumberMask : String) : String;
 var
  lLen : Integer;
  lFldSize : Integer;
  I : Integer;
 begin
  lLen := Length(aNumberMask);
  // если последний символ звездочка, то так и оставляем
  if aNumberMask[lLen] = '*' then
   Result := aNumberMask
  else
   //если есть звездочка в середине, то и в конце нужна
   if Pos('*', aNumberMask) > 0 then
    Result := aNumberMask + ' *'
   else
   //иначе добиваем пробелы до длины
   begin
    Result := aNumberMask;
    lFldSize := DictServer(CurrentFamily).GroupTbl[da_dlDateNums].FldLength[dnNumFld];
    if lFldSize > lLen then
    SetLength(Result, lFldSize);
    Result[lFldSize] := '*';
    for I := Succ(lLen) to Pred(lFldSize) do
     Result[I] := ' ';
   end;
 end;

var
 lNormNumberMask : String;
 lSabDate : ISab;
 lSabNum  : ISab;
 lSabSum  : ISab;
begin
 if (fFromDate <> 0) or (fToDate <> 0) then
 begin
  lSabDate := MakeSab(DictServer(CurrentFamily).GroupTbl[da_dlDateNums]);
  if (fToDate <> 0) then
  begin
   if fFromDate = 0 then fFromDate := 1; // не ищем записи с пустой датой
   lSabDate.Select(dnDateFld, fFromDate, fToDate)
  end
  else
  //if (fFromDate <> 0) then // это следует из предыдущих if
   lSabDate.Select(dnDateFld, fFromDate, GREAT_EQUAL);

  if (fDNType <> dnDoc) then
   lSabDate.SubSelect(dnTypFld, fDNType);

  { //сделаем это попозже (**), т к lSabDate понадобится в качестве Photo для lSabNum
  lSabDate.ValuesOfKey(dnIDFld);
  LinkServer.Family := CurrentFamily;
  lSabDate.TransferToPhoto(lnkDictIDFld, LinkServer[da_dlDateNums]);
  lSabDate.ValuesOfKey(lnkDocIDFld);
  }
 end;

 if fNumberMask <> '' then
 begin
  lSabNum := MakeSab(DictServer(CurrentFamily).GroupTbl[da_dlDateNums]);
  lNormNumberMask := NormNumberMask(fNumberMask);
  lSabNum.Select(dnNumFld, lNormNumberMask[1], WILDCASE, lSabDate {as Photo});

  if (fDNType <> dnDoc) then
   lSabNum.SubSelect(dnTypFld, fDNType);

  lSabNum.ValuesOfKey(dnIDFld);
  lSabNum.TransferToPhoto(lnkDictIDFld, LinkServer(CurrentFamily)[atDateNums]);
  lSabNum.ValuesOfKey(lnkDocIDFld);
 end;

 if lSabDate <> nil then
 begin
  //(**) делаем это попозже
  lSabDate.ValuesOfKey(dnIDFld);
  if lSabNum <> nil then
   // синхронизируем с lSabNum
   lSabDate.TransferToPhoto(lnkDictIDFld, lSabNum {as Photo})
  else
   lSabDate.TransferToPhoto(lnkDictIDFld, LinkServer(CurrentFamily)[atDateNums]);

  lSabDate.ValuesOfKey(lnkDocIDFld);

  lSabSum := lSabDate;
  if lSabNum <> nil then
   lSabSum.AndSab(lSabNum);
 end
 else
  lSabSum := lSabNum;

 if lSabSum <> nil then
 begin
  lSabSum.TransferToPhoto(fID_Fld, MainTblPhoto);
  lSabSum.RecordsByKey;
  fSab := lSabSum;
 end
 else
  fSab := MakeEmptySab(MainTblPhoto);
end;

procedure TdtDateNumQuery.Load(aDataStream : TStream);
var
 lVersion : Longint;
 lValue   : Longint;
begin
 aDataStream.Read(lVersion, SizeOf(Longint));

 Changing;

 {fFromDate}
 aDataStream.Read(fFromDate, SizeOf(fFromDate));

 {fToDate}
 aDataStream.Read(fToDate, SizeOf(fToDate));

 {fNumberMask}
 aDataStream.Read(lValue, SizeOf(Longint));
 SetLength(fNumberMask, lValue);
 if lValue > 0 then
  aDataStream.Read(fNumberMask[1], lValue);

 {fDNType}
 aDataStream.Read(lValue, SizeOf(Longint));
 fDNType := TDNType(lValue);

 Changed;
end;

procedure TdtDateNumQuery.Save(aDataStream : TStream);
var
 lValue   : Longint;
 lVersion : Longint;
begin
 lVersion := 0;
 aDataStream.Write(lVersion, SizeOf(Longint));

 {fFromDate}
 aDataStream.Write(fFromDate, SizeOf(fFromDate));

 {fToDate}
 aDataStream.Write(fToDate, SizeOf(fToDate));

 {fNumberMask}
 lValue := Length(fNumberMask);
 aDataStream.Write(lValue, SizeOf(Longint));
 if lValue > 0 then
  aDataStream.Write(fNumberMask[1], lValue);

 {fDNType}
 lValue := Ord(fDNType);
 aDataStream.Write(lValue, SizeOf(Longint));
end;

{TdtActiveQuery}
constructor TdtActiveQuery.Create(aActiveStatus : TActiveStatusSet; aDate : TStDate = cBlankDate; const aPhoto : ISab = nil);
begin
 inherited Create(aPhoto);
 fActiveStatus := aActiveStatus;
 fDate := aDate;
end;

procedure TdtActiveQuery.DoQuery;
var
 lDate : TStDate;
const
 lActType : longint = 0;

 function AllActiveDocRec: ISab;
 begin
  Result := MakeSab(LinkServer(CurrentFamily)[atActiveIntervals]);
  Result.Select(actTyp, lActType);
  Result.SubSelect(actStart, lDate, LESS_EQUAL);
  Result.SubSelect(actFinish, lDate, GREAT_EQUAL);
 end;

 function AllActiveDocIds: ISab;
 begin
  Result := AllActiveDocRec;
  Result.ValuesOfKey(actDocID);
 end;

 function AllNotActiveDocIds: ISab;
 begin
  Result := AllActiveDocRec;
  Result.ValuesOfKey(actDocID);
  Result.InvertSab;
 end;

 function NotActiveDocIds(aStatus: TActiveStatus): ISab;
 var
  lSab : ISab;
 begin
  Assert(aStatus in [asNoActive, asPreActive]);

  // записи, у кот-х FieldValue l_CondGood Today
  Result := MakeSab(LinkServer(CurrentFamily)[atActiveIntervals]);
  Result.Select(actTyp, lActType);

  case aStatus of
   asPreActive:
    Result.SubSelect(actStart, lDate, GREAT);
   asNoActive:
    Result.SubSelect(actFinish, lDate, LESS);
  end;
  Result.ValuesOfKey(actDocID); // документы Д1, имеющие хоть один интервал с FieldValue l_CondGood

  lSab := MakeSab(LinkServer(CurrentFamily)[atActiveIntervals]);
  lSab.Select(actTyp, lActType);
  case aStatus of
   asPreActive:
    lSab.SubSelect(actStart, lDate, LESS_EQUAL);
   asNoActive:
    lSab.SubSelect(actFinish, lDate, GREAT_EQUAL);
  end;
  // документы Д2, имеющие хоть один интервал с FieldValue l_CondBad Today
  lSab.ValuesOfKey(actDocID);

  Result.SubtractSab(lSab);
 end;

var
  lSab : ISab;
begin
 if fDate = cBlankDate then
  lDate := CurrentDate
 else
  lDate := fDate;

 if fActiveStatus = [] then  // Пустая выборка.
 begin
   fSab := MakeEmptySab(MainTblPhoto);
 end
 else
 if fActiveStatus = [asActive, asNoActive, asPreActive] then  // Все документы.
  fSab := MakeAllRecords(MainTblPhoto)
 else
 begin
  if fActiveStatus = [asActive] then  // Только действующие документы
   lSab := AllActiveDocIds
  else
  if fActiveStatus = [asNoActive, asPreActive] then  // Все НЕдействующие документы.
   lSab := AllNotActiveDocIds
  else
  if fActiveStatus = [asPreActive] then  // Недействующие документы PreActive
   lSab := NotActiveDocIds(asPreActive)
  else
  if fActiveStatus = [asNoActive] then  // Недействующие документы NoActive
   lSab := NotActiveDocIds(asNoActive)
  else
  if fActiveStatus = [asActive, asPreActive] then  // Действующие документы + недействующие PreActive
   raise Exception.Create('Поиск по критерию "Действующие документы + недействующие PreActive" не реализован.')
  else
  if fActiveStatus = [asActive, asNoActive] then  // Действующие документы + недействующие NoActive
   raise Exception.Create('Поиск по критерию "Действующие документы + недействующие NoActive" не реализован.');

  lSab.TransferToPhoto(fID_Fld, MainTblPhoto);
  lSab.RecordsByKey;
  fSab := lSab;
 end;
end;

procedure TdtActiveQuery.Load(aDataStream : TStream);
var
 lVersion : Longint;
 //lValue   : Longint;
begin
 aDataStream.Read(lVersion, SizeOf(Longint));

 Changing;

 {fActiveStatus}
 aDataStream.Read(fActiveStatus, SizeOf(fActiveStatus));

 {fDate}
 aDataStream.Read(fDate, SizeOf(fDate));

 Changed;
end;

procedure TdtActiveQuery.Save(aDataStream : TStream);
var
 lVersion : Longint;
begin
 lVersion := 0;
 aDataStream.Write(lVersion, SizeOf(Longint));

 {fActiveStatus}
 aDataStream.Write(fActiveStatus, SizeOf(fActiveStatus));

 {fDate}
 aDataStream.Write(fDate, SizeOf(fDate));
end;

{TdtActiveBorderQuery}
constructor TdtActiveBorderQuery.Create(aStartDate : TStDate; aFinishDate : TStDate; const aPhoto : ISab = nil);
begin
 inherited Create(aPhoto);
 fStart := aStartDate;
 fFinish := aFinishDate;
end;

procedure TdtActiveBorderQuery.DoQuery;
const
 lActType : longint = 0;

var
  lDate : TStDate;
  lSab : ISab;

begin
 lSab := MakeSab(LinkServer(CurrentFamily)[atActiveIntervals]);
 lSab.Select(actTyp, lActType);

 if (fStart <> cBlankDate) and (fStart <> 1) and
    (fFinish <> cBlankDate) and (fFinish <> MaxDate) then
  lSab.SubSelect(actStart, fStart, fFinish)
 else
 begin
  if (fStart <> cBlankDate) and (fStart <> 1) then
   lSab.SubSelect(actStart, fStart);
  if (fFinish <> cBlankDate) and (fFinish <> MaxDate) then
   lSab.SubSelect(actFinish, fFinish);
 end;

 lSab.ValuesOfKey(actDocID);
 lSab.TransferToPhoto(fID_Fld, MainTblPhoto);
 lSab.RecordsByKey;
 fSab := lSab;
end;

procedure TdtActiveBorderQuery.Load(aDataStream : TStream);
var
 lVersion : Longint;
 //lValue   : Longint;
begin
 aDataStream.Read(lVersion, SizeOf(Longint));

 Changing;

 {fStart}
 aDataStream.Read(fStart, SizeOf(fStart));

 {fFinish}
 aDataStream.Read(fFinish, SizeOf(fFinish));
 Changed;
end;

procedure TdtActiveBorderQuery.Save(aDataStream : TStream);
var
 lVersion : Longint;
begin
 lVersion := 0;
 aDataStream.Write(lVersion, SizeOf(Longint));

 {fStart}
 aDataStream.Write(fStart, SizeOf(fStart));

 {fFinish}
 aDataStream.Write(fFinish, SizeOf(fFinish));
end;

{TdtLogQuery}
constructor TdtLogByActionQuery.Create(aAction   : TLogActionType;
                               aFromDate : TStDate; aToDate : TStDate;
                               aUserID   : TDictID = 0; aUserGr : Boolean = false;
                               aLogRecType : TLogActionFlags = acfNone;
                               const aPhoto : ISab = nil);
begin
 inherited Create(aFromDate, aToDate, aUserID, aUserGr, aLogRecType, aPhoto);
 fAction   := aAction;
end;

procedure TdtLogByActionQuery.DoQuery;
var
 lFromDate : TStDate;
 lToDate : TStDate;
 lUserSab : ISab;
begin
 inherited;
 fSab.SubSelect(lgAction_key,fAction);

 fSab.ValuesOfKey(lgDocID_Key);
 fSab.TransferToPhoto(fID_Fld, MainTblPhoto);
 fSab.RecordsByKey;
end;

procedure TdtLogByActionQuery.Load(aDataStream : TStream);
var
 lVersion : Longint;
 lValue   : Longint;
begin
 aDataStream.Read(lVersion, SizeOf(Longint));

 Changing;

 inherited;

 {fAction}
 aDataStream.Read(lValue, SizeOf(lValue));
 fAction := TLogActionType(lValue);

 Changed;
end;

procedure TdtLogByActionQuery.Save(aDataStream : TStream);
var
 lVersion : Longint;
 lValue   : Longint;
begin
 lVersion := 0;
 aDataStream.Write(lVersion, SizeOf(Longint));

 inherited;

 {fAction}
 lValue := ord(fAction);
 aDataStream.Write(lValue, SizeOf(lValue));

end;

{TdtStageQuery}
constructor TdtStageQuery.Create(aBeginDate : TStDate; aEndDate : TStDate;
                                 aStage: TStageType; aStageFlag: TStageFlag;
                                 aUserID: TUserID; const aPhoto : ISab);
begin
 inherited Create(aPhoto);
 fBeginDate  := aBeginDate;
 fEndDate    := aEndDate;
 f_Stage     := aStage;
 f_StageFlag := aStageFlag;
 f_UserID    := aUserID;
end;

procedure TdtStageQuery.DoQuery;
var
 l_FromDate, l_ToDate: TStDate;
 l_Res: ISab;
 l_Temp1, l_Temp2: ISab;
begin
 if fBeginDate = 0 then
  l_FromDate := MinSrchDate
 else
  l_FromDate := fBeginDate;
 if fEndDate = 0 then
  l_ToDate := CurrentDate
 else
  l_ToDate := fEndDate;

 l_Res := MakeSab(LinkServer(CurrentFamily)[atStages]);

 case f_StageFlag of
  stfNone: // попавшие хоть каким-то образом в интервал
   begin
    l_Res.Select(stBDate_Key, l_ToDate, LESS_EQUAL); // начавшиеся до конца периода
    try
     l_Temp1 := MakeSab(LinkServer(CurrentFamily)[atStages]);
     l_Temp1.Select(stEDate_Key, l_FromDate, GREAT_EQUAL); // закончившиеся после начала периода
     l_Temp2 := MakeSab(LinkServer(CurrentFamily)[atStages]);
     l_Temp2.Select(stEDate_Key, BlankDate); // незакончившиеся
     l_Temp1.OrSab(l_Temp2);

     l_Res.AndSab(l_Temp1);
    finally
     l_Temp1 := nil;
     l_Temp2 := nil;
    end;
   end;

  stfBegined: // начавшиеся в интервале
   l_Res.Select(stBDate_Key, l_FromDate, l_ToDate);

  stfFinished: // закончившиеся в интервале
   l_Res.Select(stEDate_Key, l_FromDate, l_ToDate);

  stfUnfinished: // не закончившиеся в интервале
   begin
    l_Res.Select(stEDate_Key, l_ToDate, GREAT);
    try
     l_Temp1 := MakeSab(LinkServer(CurrentFamily)[atStages]);
     l_Temp1.Select(stEDate_Key, BlankDate);
     l_Res.OrSab(l_Temp1);
    finally
     l_Temp1 := nil;
    end;
   end;
 end;

 if f_Stage <> stNone then
  l_Res.SubSelect(stType_Key, f_Stage);

 if f_UserID <> 0 then
  l_Res.SubSelect(stAuthor_Key, f_UserID);

 l_Res.ValuesOfKey(stDocID_Key);
 l_Res.TransferToPhoto(fID_Fld, MainTblPhoto);
 l_Res.RecordsByKey;
 fSab := l_Res;
end;



(*
procedure TdtStageQuery.DoQuery;
var
 lHTSab        : sab;
 lStageDocs    : ISab;
 lNotBeginDocs : ISab;
 lNeedDocs     : ISab;

const
 lAction : TLogActionType = acIncluded;
begin

 DocumentServer.Family := CurrentFamily;
 if (fBeginStage <> []) or (fEndStage <> []) or (fNotEndStage <> []) then
 begin
  // !! оставил в старых Sab'ах что бы не переделывать сложную логику. Когда перейдем на облегченные этапы нужно переделать
  lHTSab := DocumentServer.StageTbl.GetDocOnStages(fBeginDate, fEndDate, fBeginStage, fEndStage, fNotEndStage);
  try
   lStageDocs := MakeSab(DocumentServer.StageTbl, lHTSab);
  finally
   htClearResults(lHTSab);
  end;
 end;

 if fNotBeginStage <> [] then
 begin
  lHTSab := DocumentServer.StageTbl.GetDocOnStages(fBeginDate, fEndDate, fNotBeginStage, [], []);
  try
   lNotBeginDocs := MakeSab(DocumentServer.StageTbl, lHTSab);
  finally
   htClearResults(lHTSab);
  end;

  if lNotBeginDocs.IsValid and
   (lStageDocs <> nil) and lStageDocs.IsValid then
   lStageDocs.AndSab(lNotBeginDocs);
 end;

 if (lStageDocs <> nil) and lStageDocs.IsValid then
  lStageDocs.TransferToPhoto(fID_Fld, MainTblPhoto);

 if fDocFlag in [cDone, cNotDone] then
 begin
  lNeedDocs := MakeSab(GlobalHtServer.LogBook[CurrentFamily]);
  lNeedDocs.Select(lgAction_key,lAction);
  lNeedDocs.ValuesOfKey(lgDocID_Key);
  lNeedDocs.TransferToPhoto(fID_Fld, MainTblPhoto);
  if fDocFlag = cNotDone then
   lNeedDocs.InvertSab;

  lStageDocs.AndSab(lNeedDocs);
 end;

 if (lStageDocs <> nil) and lStageDocs.IsValid then
  lStageDocs.RecordsByKey
 else
  lStageDocs := MakeEmptySab(MainTblPhoto);

 fSab := lStageDocs;


 //fSrchData[Parametr].FList:=StageDocs;
 //WriteResCount('',fSrchData[Parametr].FList.gFoundCnt);
end;
*)

procedure TdtStageQuery.Load(aDataStream : TStream);
var
 lVersion : Longint;
 lValue   : Longint;
begin
 aDataStream.Read(lVersion, SizeOf(Longint));

 Changing;

 {fBeginDate}
 aDataStream.Read(fBeginDate, SizeOf(fBeginDate));
 {fEndDate}
 aDataStream.Read(fEndDate, SizeOf(fEndDate));
 {f_Stage}
 aDataStream.Read(f_Stage, SizeOf(f_Stage));
 {f_StageFlag}
 aDataStream.Read(f_StageFlag, SizeOf(f_StageFlag));
 {f_UserID}
 aDataStream.Read(f_UserID, SizeOf(f_UserID));

 Changed;
end;

procedure TdtStageQuery.Save(aDataStream : TStream);
var
 lVersion : Longint;
begin
 lVersion := 0;
 aDataStream.Write(lVersion, SizeOf(Longint));

 {fBeginDate}
 aDataStream.Write(fBeginDate, SizeOf(fBeginDate));
 {fEndDate}
 aDataStream.Write(fEndDate, SizeOf(fEndDate));
 {f_Stage}
 aDataStream.Write(f_Stage, SizeOf(f_Stage));
 {f_StageFlag}
 aDataStream.Write(f_StageFlag, SizeOf(f_StageFlag));
 {f_UserID}
 aDataStream.Write(f_UserID, SizeOf(f_UserID));
end;

{TdtMainAttrQuery}
constructor TdtMainAttrQuery.Create(aField : ThtField; var aValue; const aPhoto : ISab = nil);
var
 lLen : word;
begin
 inherited Create(aPhoto);
 lLen := MainTblPhoto.Table.FldLength[aField];
 Assert(lLen <= SizeOf(fValue), 'TdtMainAttrQuery Строки не поддерживаюся');

 fField := aField;
 l3Move(aValue, fValue, lLen);
end;

constructor TdtMainAttrQuery.Create(aField : ThtField; var aValue; aIsMask : Boolean; const aPhoto : ISab = nil);
begin
 Create(aField, aValue, aPhoto);
 fIsMask := aIsMask;
end;

procedure TdtMainAttrQuery.DoQuery;
begin
 fSab := MakeEmptySab(MainTblPhoto);
 if IsMask then
  fSab.SelectByMask(fField, fValue)
 else
  fSab.Select(fField, fValue);
end;

procedure TdtMainAttrQuery.Load(aDataStream : TStream);
var
 lVersion : Longint;
begin
 aDataStream.Read(lVersion, SizeOf(Longint));

 Changing;
 if lVersion = 0 then
 begin
  fField := fUrgency_fld;
  fValue := 0;
  aDataStream.Read(fValue, SizeOf(MainTblPhoto.Table.FldLength[fField]));
 end
 else
 begin
  aDataStream.Read(fField, SizeOf(fField));
  aDataStream.Read(fValue, SizeOf(fValue));
  if lVersion > 1 then
   aDataStream.Read(fIsMask, SizeOf(fIsMask));
 end;
 Changed;
end;

procedure TdtMainAttrQuery.Save(aDataStream : TStream);
var
 lVersion : Longint;
begin
 lVersion := 2;
 aDataStream.Write(lVersion, SizeOf(Longint));

 aDataStream.Write(fField, SizeOf(fField));
 aDataStream.Write(fValue, SizeOf(fValue));
 aDataStream.Write(fIsMask, SizeOf(fIsMask));
end;

{TdtUrgencyQuery}
//constructor TdtUrgencyQuery.Create(aUrgency : Integer; const aPhoto : ISab = nil);
//begin
// inherited Create(fUrgency_fld, aUrgency, aPhoto);
//end;

{TQueryRegList}
type
 TQueryClass = class of TdtCustomQuery;

 TQueryRegList = class(Tl3ClassList)
  procedure Enroll(aQueryClass : TQueryClass);
 end;

 procedure TQueryRegList.Enroll(aQueryClass : TQueryClass);
 var
  lRegNum : Integer;
 begin
  lRegNum := aQueryClass.GetRegNumber;
  Assert(lRegNum > 0, 'GetRegNumber не объявлена');
  if Count <= lRegNum then
   Count := lRegNum + 1;
  Assert(Items[lRegNum] = nil, 'Повторная регистрация в тот же слот');

  Items[lRegNum] := aQueryClass;
 end;

var
 gQueryRegister : TQueryRegList;

function g_dtLoadQuery(aDataStream : TStream) : TdtQuery;
var
 lQueryID : Longint;
 lQueryClass : TQueryClass;
begin
 aDataStream.Read(lQueryID, SizeOf(Longint));
 Assert((lQueryID >= 0) and (lQueryID < gQueryRegister.Count), cQueryIDNotRegistered);
 lQueryClass := TQueryClass(gQueryRegister.Items[lQueryID]);
 Assert(lQueryClass <> nil, cQueryIDNotRegistered);

 Result := lQueryClass.CreateAndLoad(aDataStream);
end;

procedure g_dtSaveQuery(aQuery: TdtQuery; aDataStream : TStream);
var
 lValue   : Longint;
begin
 lValue := aQuery.GetRegNumber;
 aDataStream.Write(lValue, SizeOf(Longint));
 aQuery.Save(aDataStream);
end;

constructor TdtAlarmQuery.Create(aStart, aFinish : TStDate; aMsg : String; const aPhoto : ISab = nil);
begin
 inherited Create(aPhoto);
 f_Start := aStart;
 f_Finish := aFinish;
 f_Msg := aMsg;
end;

procedure TdtAlarmQuery.DoQuery;
var
 l_Sab: ISab;
 lMsg : String[255];
begin
 l_Sab := MakeSab(LinkServer(CurrentFamily)[atAlarms]);

 //if (f_Start <> 0) or (f_Finish <> 0) then
 with MakeDemonDateBounds(f_Start, f_Finish) do
  l_Sab.Select(alStart, Low, High);

 if f_Msg <> '' then
 begin
  lMsg := '*' + f_Msg + '*'#0;
  l_Sab.SubSelect(alComment, lMsg[1], WILDCASE);
 end;

 l_Sab.ValuesOfKey(alDocID);
 l_Sab.TransferToPhoto(fID_Fld, MainTblPhoto);
 l_Sab.RecordsByKey;
 fSab := l_Sab;
end;

class function TdtAlarmQuery.GetRegNumber: Integer;
begin
 Result := c_rnAlarmQuery;
end;

procedure TdtAlarmQuery.Load(aDataStream : TStream);
var
 lVersion : Longint;
 lSize : Longint;
begin
 aDataStream.Read(lVersion, SizeOf(Longint));

 Changing;

 aDataStream.Read(f_Start , SizeOf(TStDate));
 aDataStream.Read(f_Finish, SizeOf(TStDate));

 if lVersion > 0 then
 begin
 {f_Msg}
  aDataStream.Read(lSize, SizeOf(Longint));
  SetLength(f_Msg, lSize);
  if lSize > 0 then
   aDataStream.Read(f_Msg[1], lSize);
 end;
 Changed;
end;

procedure TdtAlarmQuery.Save(aDataStream : TStream);
var
 lVersion : Longint;
 lSize : Longint;
begin
 lVersion := 1;
 aDataStream.Write(lVersion, SizeOf(Longint));

 aDataStream.Write(f_Start, SizeOf(TStDate));
 aDataStream.Write(f_Finish, SizeOf(TStDate));

 {f_Msg}
 lSize := Length(f_Msg);
 aDataStream.Write(lSize, SizeOf(Longint));
 if lSize > 0 then
  aDataStream.Write(f_Msg[1], lSize);

end;

{TdtTransformQuery}
procedure TdtTransformQuery.Cleanup;
begin
 SubQuery := nil;
 inherited;
end;

procedure TdtTransformQuery.Load(aDataStream : TStream);
var
 lVersion : Longint;
 l_NotNull: Boolean;
begin
 aDataStream.Read(lVersion, SizeOf(Longint));

 Changing;

 aDataStream.Read(l_NotNull, SizeOf(Boolean));
 if l_NotNull then
  f_SubQuery := g_dtLoadQuery(aDataStream)
 else
  f_SubQuery := nil;

 Changed;
end;

procedure TdtTransformQuery.pm_SetSubQuery(aQuery : TdtQuery);
begin
 if f_SubQuery = aQuery then Exit;

 Changing;

 if f_SubQuery <> nil then
  (f_SubQuery as Il3ChangeNotifier).Unsubscribe(Il3ChangeRecipient(Self));

 l3Set(f_SubQuery, aQuery);

 if aQuery <> nil then
 begin
  if aQuery.HasResult then // результат подсчитан, проще синхронизировать с его Photo что бы не пересчитывать
   MainTblPhoto := aQuery.MainTblPhoto
  else
   aQuery.MainTblPhoto := MainTblPhoto;
  (aQuery as Il3ChangeNotifier).Subscribe(Il3ChangeRecipient(Self));
 end;

 Changed;
end;

procedure TdtTransformQuery.Save(aDataStream : TStream);
var
 lVersion : Longint;
 l_NotNull: Boolean;
begin
 lVersion := 0;
 aDataStream.Write(lVersion, SizeOf(Longint));

 l_NotNull := f_SubQuery <> nil;
 aDataStream.Write(l_NotNull, SizeOf(Boolean));

 if l_NotNull then
  g_dtSaveQuery(f_SubQuery, aDataStream);
end;

{TdtNOTQuery}
procedure TdtNOTQuery.DoQuery;
begin
 if f_SubQuery <> nil then
 begin
  if f_SubQuery.FoundList.IsEmpty then
   fSab := MakeAllRecords(MainTblPhoto)
  else
  begin
   fSab := MakeSabCopy(f_SubQuery.FoundList);
   fSab.InvertSab;
  end;
  f_SubQuery.DropResult;
 end
 else
  fSab := MakeEmptySab(MainTblPhoto);
end;

{TdtLogQuery}
constructor TdtCustomLogQuery.Create(aFromDate : TStDate; aToDate : TStDate; aUserID : TDictID = 0; aUserGr : Boolean =
    false; aLogRecType : TLogActionFlags = acfNone; const aPhoto : ISab = nil);
begin
 inherited Create(aPhoto);
 fFromDate := aFromDate;
 fToDate   := aToDate;
 fUserID   := aUserID;
 fUserGr   := aUserGr;
 f_LogRecType := aLogRecType;
end;

procedure TdtCustomLogQuery.DoQuery;
var
 lFromDate : TStDate;
 lToDate : TStDate;
 lUserSab : ISab;
begin
 fSab := MakeSab(LinkServer(CurrentFamily)[atOrdLogRecords]);

 if (fFromDate <> 0) or (fToDate <> 0) then
 begin
  if fFromDate = fToDate then
   fSab.Select(lgDate_Key, fFromDate)
  else
  begin
   lFromDate := fFromDate;
   lToDate   := fToDate;

   if lFromDate = 0 then
    lFromDate := 1;
   if lToDate = 0 then
    lToDate := MaxDate;

   fSab.Select(lgDate_Key, lFromDate, lToDate);
  end;
 end
 else
  fSab.SelectAll; 

 if fUserID <> 0 then
  if fUserGr then
  begin
   lUserSab := UserManager.MakeUserIDSabOnGroup(fUserID);
   lUserSab.TransferToPhoto(lgAuthor_Key, fSab);
   lUserSab.RecordsByKey;
   fSab.AndSab(lUserSab);
   lUserSab := nil;
  end
  else
   fSab.SubSelect(lgAuthor_Key, fUserID);

 if f_LogRecType <> acfNone then
  fSab.SubSelect(lgActionFlag_Key, f_LogRecType);
end;

procedure TdtCustomLogQuery.Load(aDataStream : TStream);
begin
 {fFromDate}
 aDataStream.Read(fFromDate, SizeOf(fFromDate));

 {fToDate}
 aDataStream.Read(fToDate, SizeOf(fToDate));

 {fUserID}
 aDataStream.Read(fUserID, SizeOf(fUserID));

 {fUserGr}
 aDataStream.Read(fUserGr, SizeOf(fUserGr));

 {f_LogRecType}
 aDataStream.Read(f_LogRecType, SizeOf(f_LogRecType));
end;

procedure TdtCustomLogQuery.Save(aDataStream : TStream);
begin
 {fFromDate}
 aDataStream.Write(fFromDate, SizeOf(fFromDate));

 {fToDate}
 aDataStream.Write(fToDate, SizeOf(fToDate));

 {fUserID}
 aDataStream.Write(fUserID, SizeOf(fUserID));

 {fUserGr}
 aDataStream.Write(fUserGr, SizeOf(fUserGr));

 {f_LogRecType}
 aDataStream.Write(f_LogRecType, SizeOf(f_LogRecType));
end;

procedure TdtSimpleLogQuery.DoQuery;
begin
 inherited;
 fSab.ValuesOfKey(lgDocID_Key);
 fSab.TransferToPhoto(fID_Fld, MainTblPhoto);
 fSab.RecordsByKey;
end;

class function TdtSimpleLogQuery.GetRegNumber: Integer;
begin
 Result := c_rnSimpleLogQuery;
end;

procedure TdtSimpleLogQuery.Load(aDataStream : TStream);
var
 lVersion : Longint;
begin
 aDataStream.Read(lVersion, SizeOf(Longint));
 Changing;
 inherited;
 Changed;
end;

procedure TdtSimpleLogQuery.Save(aDataStream : TStream);
var
 lVersion : Longint;
begin
 lVersion := 0;
 aDataStream.Write(lVersion, SizeOf(Longint));
 inherited;
end;

{TdtAndQuery}

procedure TdtXorQuery.DoQuery;
var
 I : Integer;
 l_Query: TdtCustomQuery;
begin
 if QueryList.Count = 0 then
  fSab := MakeEmptySab(MainTblPhoto)
 else
 begin
  TdtCustomQuery(fQueryList[0]).MainTblPhoto := MainTblPhoto;
  fSab := MakeSabCopy(TdtCustomQuery(fQueryList[0]).FoundList);
  TdtCustomQuery(fQueryList[0]).DropResult;
  for I := 1 to Pred(QueryList.Count) do
  begin
   TdtCustomQuery(fQueryList[I]).MainTblPhoto := MainTblPhoto;
   l_Query := TdtCustomQuery(fQueryList[I]);
   fSab.XorSab(l_Query.FoundList);
   l_Query.DropResult;
  end;
 end;
end;

procedure TdtXorQuery.GetFoundDocSubList(aDocID : TDocID; var aDSList : Tl3LongintList);
var
 I : Integer;
 lDSList : Tl3LongintList;
begin
 { TODO : Доделать }
 Assert(False, 'Не реализовано');
 aDSList := nil;
 for I := 0 to Pred(QueryList.Count) do
  if fQueryList[I] is TdtDictQuery then
  begin
   TdtDictQuery(fQueryList[I]).GetFoundDocSubList(aDocID, lDSList);
   if (lDSList <> nil) then
   begin
    if aDSList = nil then
     aDSList := lDSList.Use
    else
     aDSList.IntersectList(lDSList); // здесь нужно XOR !!!
    l3Free(lDSList);
   end;
  end;
end;

class function TdtXorQuery.GetRegNumber: Integer;
begin
 Result := c_rnXorQuery;
end;

class function TdtComplexStageQuery.GetRegNumber: Integer;
begin
 Result := c_rnComplexStageQuery;
end;

constructor TdtComplexStageQuery.Create(aBeginDate : TStDate; aEndDate : TStDate;
                                        aBeginStage : TStageSet; aEndStage : TStageSet;
                                        aNotEndStage : TStageSet; aNotBeginStage : TStageSet;
                                        aDocFlag : Longint;
                                        const aPhoto : ISab = nil);
begin
 inherited Create(aPhoto);
 fBeginDate     := aBeginDate;
 fEndDate       := aEndDate;
 fBeginStage    := aBeginStage;
 fEndStage      := aEndStage;
 fNotEndStage   := aNotEndStage;
 fNotBeginStage := aNotBeginStage;
 fDocFlag       := aDocFlag;
end;

procedure TdtComplexStageQuery.DoQuery;
var
 l_Q : TdtQuery;
begin
 l_Q := SQComplexStageQuery(fBeginDate, fEndDate, fBeginStage, fEndStage, fNotEndStage, fNotBeginStage, fDocFlag);
 try
  fSab := l_Q.FoundList;
 finally
  l3Free(l_Q);
 end;
end;

procedure TdtComplexStageQuery.Load(aDataStream : TStream);
var
 lVersion : Longint;
 lValue   : Longint;
begin
 aDataStream.Read(lVersion, SizeOf(Longint));

 Changing;

 {fBeginDate}
 aDataStream.Read(fBeginDate, SizeOf(fBeginDate));
 {fEndDate}
 aDataStream.Read(fEndDate, SizeOf(fEndDate));
 {fBeginStage}
 aDataStream.Read(fBeginStage, SizeOf(fBeginStage));
 {fEndStage}
 aDataStream.Read(fEndStage, SizeOf(fEndStage));
 {fNotEndStage}
 aDataStream.Read(fNotEndStage, SizeOf(fNotEndStage));
 {fNotBeginStage}
 aDataStream.Read(fNotBeginStage, SizeOf(fNotBeginStage));
 {fDocFlag}
 aDataStream.Read(fDocFlag, SizeOf(fDocFlag));

 Changed;
end;

procedure TdtComplexStageQuery.Save(aDataStream : TStream);
var
 lVersion : Longint;
begin
 lVersion := 0;
 aDataStream.Write(lVersion, SizeOf(Longint));

 {fBeginDate}
 aDataStream.Write(fBeginDate, SizeOf(fBeginDate));
 {fEndDate}
 aDataStream.Write(fEndDate, SizeOf(fEndDate));
 {fBeginStage}
 aDataStream.Write(fBeginStage, SizeOf(fBeginStage));
 {fEndStage}
 aDataStream.Write(fEndStage, SizeOf(fEndStage));
 {fNotEndStage}
 aDataStream.Write(fNotEndStage, SizeOf(fNotEndStage));
 {fNotBeginStage}
 aDataStream.Write(fNotBeginStage, SizeOf(fNotBeginStage));
 {fDocFlag}
 aDataStream.Write(fDocFlag, SizeOf(fDocFlag));
end;

procedure TdtAllDocsQuery.DoQuery;
begin
 fSab := MakeAllRecords(MainTblPhoto);
end;

class function TdtAllDocsQuery.GetRegNumber: Integer;
begin
 Result := c_rnAllDocsQuery;
end;

procedure TdtAllDocsQuery.Load(aDataStream : TStream);
var
 lVersion : Longint;
begin
 aDataStream.Read(lVersion, SizeOf(Longint));
end;

procedure TdtAllDocsQuery.Save(aDataStream : TStream);
var
 lVersion : Longint;
begin
 lVersion := 0;
 aDataStream.Write(lVersion, SizeOf(Longint));
end;

constructor TdtDocLinkQuery.Create(aSearchType: TdtDocLinkQuerySearchType;
                                   aLinkType  : Integer = -1;
                             const aPhoto     : ISab    = nil);
begin
 inherited Create(aPhoto);
 f_SearchType := aSearchType;
 f_LinkType := aLinkType;
end;

procedure TdtDocLinkQuery.DoQuery;
var
 l_Sab: ISab;
begin
 l_Sab := MakeSab(LinkServer(CurrentFamily)[atDoc2DocLink]);
 if f_LinkType > -1 then
  l_Sab.Select(lddLinkTypeFld, f_LinkType)
 else
  l_Sab.SelectAll;
 case f_SearchType of
  stFindMasters : l_Sab.ValuesOfKey(lnkDocIDFld);
  stFindSlaves  : l_Sab.ValuesOfKey(lddLinkedDocFld);
 end;
 l_Sab.TransferToPhoto(fID_Fld, MainTblPhoto);
 l_Sab.RecordsByKey;
 fSab := l_Sab;
end;

class function TdtDocLinkQuery.GetRegNumber: Integer;
begin
 Result := c_rnDocLinkQuery;
end;

procedure TdtDocLinkQuery.Load(aDataStream : TStream);
var
 lVersion : Longint;
begin
 aDataStream.Read(lVersion, SizeOf(Longint));

 Changing;

 aDataStream.Read(f_SearchType , SizeOf(TdtDocLinkQuerySearchType));
 aDataStream.Read(f_LinkType, SizeOf(Integer));

 Changed;
end;

procedure TdtDocLinkQuery.Save(aDataStream : TStream);
var
 lVersion : Longint;
begin
 lVersion := 0;
 aDataStream.Write(lVersion, SizeOf(Longint));

 aDataStream.Write(f_SearchType , SizeOf(TdtDocLinkQuerySearchType));
 aDataStream.Write(f_LinkType, SizeOf(Integer));
end;

procedure TdtWillBeActiveQuery.DoQuery;
var
 lSab : ISab;
const
 c_Norm: Byte = actt_Normal;
begin
 lSab := MakeSab(LinkServer(CurrentFamily)[atActiveIntervals]);
 lSab.Select(actTyp, c_Norm);
 lSab.SubSelect(actStart, maxActiveDate);
 lSab.SubSelect(actFinish, maxActiveDate);
 lSab.ValuesOfKey(actDocID);
 lSab.TransferToPhoto(fID_Fld, MainTblPhoto);
 lSab.RecordsByKey;
 fSab := lSab;
end;

class function TdtWillBeActiveQuery.GetRegNumber: Integer;
begin
 Result := c_rnWillBeActiveQuery;
end;

procedure TdtWillBeActiveQuery.Load(aDataStream : TStream);
var
 lVersion : Longint;
begin
 aDataStream.Read(lVersion, SizeOf(Longint));
end;

procedure TdtWillBeActiveQuery.Save(aDataStream : TStream);
var
 lVersion : Longint;
begin
 lVersion := 0;
 aDataStream.Write(lVersion, SizeOf(Longint));
end;

procedure TdtDocVersionsQuery.DoQuery;
var
 l_IDList: Tl3LongintList;
begin
 l_IDList := Tl3LongintList.MakeSorted;
 try
  DocumentServer(CurrentFamily).FileTbl.GetAllVerLinkOrder(f_MasterDoc, l_IDList);
  if f_IncludeMaster then
   l_IDList.Add(f_MasterDoc);
  if l_IDList.Count > 0 then
  begin
   fSab := MakeValueSet(MainTblPhoto.Table, fID_Fld, l_IDList);
   fSab.TransferToPhoto(fID_Fld, MainTblPhoto);
   fSab.RecordsByKey;
  end
  else
   fSab := MakeEmptySab(MainTblPhoto);
 finally
  FreeAndNil(l_IDList);
 end;
end;

class function TdtDocVersionsQuery.GetRegNumber: Integer;
begin
 Result := c_rnDocVersionsQuery;
end;

procedure TdtDocVersionsQuery.Load(aDataStream : TStream);
var
 lVersion : Longint;
begin
 aDataStream.Read(lVersion, SizeOf(Longint));
 aDataStream.Read(lVersion, SizeOf(Longint));
 aDataStream.Read(f_MasterDoc, SizeOf(TDocID));
end;

procedure TdtDocVersionsQuery.Save(aDataStream : TStream);
var
 lVersion : Longint;
begin
 lVersion := 0;
 aDataStream.Write(lVersion, SizeOf(Longint));
 aDataStream.Write(f_MasterDoc, SizeOf(TDocID));
end;

constructor TdtDocVersionsQuery.Create(aDocID         : TDocID;          // документ, редакции которого мы ищем
                                       aIncludeMaster : Boolean = False; // включать ли вышеупомянутый документ в список
                                       const aPhoto   : ISab = nil);
begin
 inherited Create(aPhoto);
 f_MasterDoc := aDocID;
 f_IncludeMaster := aIncludeMaster;
end;

{TdtCorrespQuery}
procedure TdtCorrespQuery.DoQuery;
begin
 if (f_SubQuery <> nil) and not f_SubQuery.FoundList.IsEmpty then
 begin
  fSab := MakeSabCopy(f_SubQuery.FoundList);
  fSab.ValuesOfKey(fId_Fld);
  fSab.TransferToPhoto(hlDestD_fld, LinkServer(CurrentFamily)[atHLink]);
  fSab.ValuesOfKey(hlSourD_fld);
  fSab.TransferToPhoto(fId_Fld, MainTblPhoto);
  fSab.RecordsByKey;
  fSab.SubtractSab(f_SubQuery.FoundList);
 end
 else
  fSab := MakeEmptySab(MainTblPhoto);
end;

{TdtRespQuery}
procedure TdtRespQuery.DoQuery;
begin
 if (f_SubQuery <> nil) and not f_SubQuery.FoundList.IsEmpty then
 begin
  fSab := MakeSabCopy(f_SubQuery.FoundList);
  fSab.ValuesOfKey(fId_Fld);
  fSab.TransferToPhoto(hlSourD_fld, LinkServer(CurrentFamily)[atHLink]);
  fSab.ValuesOfKey(hlDestD_fld);
  fSab.TransferToPhoto(fId_Fld, MainTblPhoto);
  fSab.RecordsByKey;
  fSab.SubtractSab(f_SubQuery.FoundList);
 end
 else
  fSab := MakeEmptySab(MainTblPhoto);
end;


class function TdtStatusMaskQuery.GetRegNumber : Integer;
begin
 Result := c_rnStatusMaskQuery;
end;

constructor TdtStatusMaskQuery.Create(aStatusMask : Word; const aPhoto : ISab = nil);
begin
 inherited Create(aPhoto);
 f_StatusMask := aStatusMask;
end;

procedure TdtStatusMaskQuery.DoQuery;
var
  l_Sab : ISab;
begin
 fSab := MakeSab(MainTblPhoto.Table);
 fSab.SelectByMask(fStatus_Fld, f_StatusMask);
end;

procedure TdtStatusMaskQuery.Load(aDataStream : TStream);
var
 lVersion : Longint;
begin
 aDataStream.Read(lVersion, SizeOf(Longint));

 Changing;

 {f_StatusMask}
 aDataStream.Read(f_StatusMask, SizeOf(f_StatusMask));

 Changed;
end;

procedure TdtStatusMaskQuery.Save(aDataStream : TStream);
var
 lVersion : Longint;
begin
 lVersion := 0;
 aDataStream.Write(lVersion, SizeOf(Longint));
 {f_StatusMask}
 aDataStream.Write(f_StatusMask, SizeOf(f_StatusMask));
end;

constructor TdtPubInFlagsQuery.Create(aMask : Byte; const aPhoto : ISab = nil);
begin
 inherited Create(aPhoto);
 f_Mask := aMask;
end;

procedure TdtPubInFlagsQuery.DoQuery;
begin
 fSab := MakeSab(LinkServer(CurrentFamily)[atPublisheds]);
 fSab.SelectByMask(lnkPublihedsFlags, f_Mask);
 fSab.ValuesOfKey(lnkDocIDFld);
 fSab.TransferToPhoto(fID_Fld, MainTblPhoto);
 fSab.RecordsByKey;
end;

class function TdtPubInFlagsQuery.GetRegNumber: Integer;
begin
 Result := c_rnPubInFlagsQuery;
end;

procedure TdtPubInFlagsQuery.Load(aDataStream : TStream);
var
 lVersion : Longint;
begin
 aDataStream.Read(lVersion, SizeOf(Longint));

 Changing;

 {f_StatusMask}
 aDataStream.Read(f_Mask, SizeOf(f_Mask));

 Changed;
end;

procedure TdtPubInFlagsQuery.Save(aDataStream : TStream);
var
 lVersion : Longint;
begin
 lVersion := 0;
 aDataStream.Write(lVersion, SizeOf(Longint));
 {f_StatusMask}
 aDataStream.Write(f_Mask, SizeOf(f_Mask));
end;


{TdtExpandEditionsQuery}
class function TdtExpandEditionsQuery.GetRegNumber: Integer;
begin
 Result := c_rnExpandEditionsQuery;
end;

procedure TdtExpandEditionsQuery.DoQuery;
begin
 if (f_SubQuery <> nil) and (not f_SubQuery.FoundList.IsEmpty) then
 begin
  fSab := MakeSabCopy(f_SubQuery.FoundList);
  DocumentServer(CurrentFamily).FileTbl.ExpandAllEdition(fSab);
 end
 else
  fSab := MakeEmptySab(MainTblPhoto);
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\DT\dt_Query.pas initialization enter'); {$EndIf}
 gQueryRegister := TQueryRegList.Create;

 with gQueryRegister do
 begin
  Enroll(TdtIDListQuery);
  Enroll(TdtAndQuery);
  Enroll(TdtOrQuery);
  Enroll(TdtDictQuery);
  Enroll(TdttextQuery);
  Enroll(TdtDateNumQuery);
  Enroll(TdtActiveQuery);
  Enroll(TdtStageQuery);
  Enroll(TdtDocTypeFilterQuery);
  Enroll(TdtDocListQuery);
  Enroll(TdtAlarmQuery);
  Enroll(TdtLogByActionQuery);
  Enroll(TdtNOTQuery);
  Enroll(TdtSimpleLogQuery);
  Enroll(TdtXorQuery);
  Enroll(TdtComplexStageQuery);
  Enroll(TdtAllDocsQuery);
  Enroll(TdtMainAttrQuery);
  Enroll(TdtWillBeActiveQuery);
  Enroll(TdtDocVersionsQuery);
  Enroll(TdtActiveBorderQuery);
  Enroll(TdtCorrespQuery);
  Enroll(TdtStatusMaskQuery);
  Enroll(TdtPubInFlagsQuery);
  Enroll(TdtRespQuery);
 end;

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\DT\dt_Query.pas initialization leave'); {$EndIf}
finalization
 l3Free(gQueryRegister);
end.

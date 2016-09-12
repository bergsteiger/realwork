unit daTypes;

// Модуль: "w:\common\components\rtl\Garant\DA\daTypes.pas"
// Стереотип: "Interfaces"
// Элемент модели: "daTypes" MUID: (5432448401BC)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3Types
 , dt_Types
 , SysUtils
;

const
 c_UnknownLogin = 'UNKNOWN USER';
 c_UnknownUserName = 'Пользователь %s.%d';

type
 PdaDocEditRec = ^TdaDocEditRec;

 PdaDictEditRec = ^TdaDictEditRec;

 PLargeInt = ^LargeInt;

 PdaUserID = ^TdaUserID;

 PdaFamilyID = ^TdaFamilyID;

 PdaUserGroupID = ^TdaUserGroupID;

 PdaGlobalCoordinateRec = ^TdaGlobalCoordinateRec;

 PdaUserGroupAccessMask = ^TdaUserGroupAccessMask;

 TdaUserID = LongWord;

 TGetLoginPasswordProc = function(var aLogin: AnsiString;
  var aPassword: AnsiString): Boolean;

 TdaBaseFlag = (
  bfAAC
  , bfAutoLink
 );//TdaBaseFlag

 TdaBaseFlags = set of TdaBaseFlag;

 TdaRegionID = Byte;

 TdaLoginError = (
  da_leOk
  , da_leInsufficientRights
  , da_leUserParamsWrong
  , da_leConnectionError
  , da_leSQLError
 );//TdaLoginError

 TdaDocID = TDocID;

 TdaFamilyID = Word;

 TdaPathStr = TPathStr;

 TdaProcessState = (
  da_psStart
  , da_psCurrent
  , da_psEnd
 );//TdaProcessState

 TdaOnLongProcessEvent = function(aState: TdaProcessState): Boolean of object;

 TdaDataType = (
  {* Типы данных полей }
  da_dtChar
  , da_dtByte
  , da_dtDate
  , da_dtTime
  , da_dtDWord
  , da_dtWord
  , da_dtInteger
  , da_dtBoolean
  , da_dtQWord
 );//TdaDataType

 TdaTables = (
  da_mtAccess
   {* Права доступа к документам }
  , da_mtPassword
   {* Пароли пользователей }
  , da_mtUsers
   {* Пользователи }
  , da_mtGroups
   {* Группы (mtGUDt) }
  , da_mtGroupMembers
   {* Члены группы (mtGULnk) }
  , da_mtFamily
   {* Семейства (не прижилось) }
  , da_mtFree
   {* Список диапазонов для ID }
  , da_mtJournal
   {* Журнал работы (mtBBLog) }
  , da_mtControl
   {* Флажок эксклюзивного доступа (mtCtrl) }
  , da_mtRegions
   {* Словарь регионов }
  , da_ftNone
   {* Фэйковая таблица }
  , da_ftDocuments
   {* Документы (ftFile) }
  , da_ftHyperlinks
   {* Гиперссылки (ftHLink) }
  , da_ftSubs
   {* Сабы (ftSub) }
  , da_ftFree
   {* Список диапазонов для ID }
  , da_ftSources
   {* Словарь Исходящие органы (ftDt1) }
  , da_ftTypes
   {* Словарь Типы (ftDt2) }
  , da_ftClasses
   {* Словарь Классы (ftDt3) }
  , da_ftKeywords
   {* Словарь Ключевые слова (ftDt5) }
  , da_ftBelongs
   {* Словарь Группы (ftDt6) }
  , da_ftDateCodes
   {* Словарь Номеров и Дат (ftDt7) }
  , da_ftWarnings
   {* Словарь Предупреждений (ftDt8) }
  , da_ftCorrections
   {* Словарь Вычитка (ftDt9) }
  , da_ftCoSources
   {* Словарь Изданий (ftDtA) }
  , da_ftPiblishedIn
   {* Словарь Источников опубликования (ftDtB) }
  , da_ftPrefixes
   {* Словарь Видов информации (ftDtC) }
  , da_ftTerritories
   {* Словарь Территорий (ftDtD) }
  , da_ftNorms
   {* Словарь Нормы права (ftDtE) }
  , da_ftExtClasses
   {* Дополнение Словаря Классов (ftDt3E) }
  , da_ftAccessGroups
   {* Словарь Группы доступа (ftDtF) }
  , da_ftAnnoClasses
   {* Словарь Классы аннотаций (ftDtI) }
  , da_ftServiceInfo
   {* Словарь Вид справочной информации (ftDtJ) }
  , da_ftDocSources
   {* Исходящие органы документа (ftLnk1) }
  , da_ftDocTypes
   {* Типы документа (ftLnk2) }
  , da_ftDocClasses
   {* Классы документа (ftLnk3) }
  , da_ftDocKeywords
   {* Ключевые слова документа (ftLnk5) }
  , da_ftDocBelongs
   {* Группы документа (ftLnk6) }
  , da_ftDocDateCodes
   {* Номера и даты документа (ftLnk7) - не нужен }
  , da_ftDocWarnings
   {* Предупреждения документа (ftLnk8) }
  , da_ftDocCorrections
   {* Вычитка документа (ftLnk9) - не нужен }
  , da_ftDocPublishedIn
   {* Источники опубликования документа (ftLnkB) }
  , da_ftDocPrefixes
   {* Виды информации документа (ftLnkC) }
  , da_ftDocTerritories
   {* Территория документа (ftLnkD) }
  , da_ftDocNorms
   {* Нормы права документа (ftLnkE) }
  , da_ftDocAccessGroups
   {* Группы доступа документа (ftLnkF) }
  , da_ftDocAnnoClasses
   {* Классы аннотации документа (ftLnkI) }
  , da_ftDocServiceInfo
   {* Вид справочной информации документа (ftLnkJ) }
  , da_ftDoc2DocLink
   {* Связи между документами (ftLnkK) }
  , da_ftPriority
   {* Словарь приоритетов (ftPriority) }
  , da_ftRenum
   {* Соответствие внешних и внутренних номеров (ftRenum) }
  , da_ftDocStages
   {* Этапы обработки документа (ftStage) }
  , da_ftDocLog
   {* Журнал изменения документа (ftLog) }
  , da_ftDocActivity
   {* Интервалы действия документа (ftActiv) }
  , da_ftDocAlarm
   {* Служебные предупреждения к документу (ftAlarm) }
  , da_ftControl
   {* Флажок эксклюзивного доступа (ftCtrl) }
  , da_ftDocumentsDub1
   {* Дубликат таблицы документов - для связывания в запросах (ftFileDup1) }
  , da_ftDocumentsDub2
   {* Дубликат таблицы документов - для связывания в запросах (ftFileDup2) }
  , da_ftAutolinkDocumentsLocal
  , da_ftAutolinkEditionsLocal
  , da_ftAutolinkDocumentsRemote
  , da_ftAutolinkEditionsRemote
 );//TdaTables

 TdaJournalOperation = (
  da_oobNone
  , da_oobPause
   {* Длина паузы в Additional }
  , da_oobSessionBegin
   {* ID Пользователя в ID_Ext }
  , da_oobSessionEnd
  , da_oobOpenDoc
   {* ID документа в ID_Ext }
  , da_oobCreateDoc
   {* ID Документа в ID_Ext }
  , da_oobDeleteDoc
   {* ID Документа в ID_Ext }
  , da_oobEditDoc
   {* ID Документа в ID_Ext, TdaDocEditRec в Additional }
  , da_oobPrintDoc
   {* ID Документа в ID_Ext }
  , da_oobSaveDoc
   {* ID Документа в ID_Ext }
  , da_oobEditDictionary
   {* TdaDictEditRec в Additional }
  , da_oobExport
   {* Количество документов в Additional }
  , da_oobImport
  , da_oobSearch_Deprecated
  , da_oobAutoClass
   {* Количество документов в Additional }
 );//TdaJournalOperation

 TdaDocEditType = (
  da_detText
  , da_detAttribute
  , da_detHyperLink
  , da_detSub
  , da_detDiction
 );//TdaDocEditType

 TdaEditOperation = (
  da_eoNone
  , da_eoAdd
  , da_eoEdit
  , da_eoDelete
 );//TdaEditOperation

 TdaDictionaryType = (
  da_dlNone
  , da_dlSources
  , da_dlTypes
  , da_dlClasses
  , da_dlKeyWords
  , da_dlBases
  , da_dlDateNums
  , da_dlWarnings
  , da_dlCorrects
  , da_dlCorSources
  , da_dlPublisheds
  , da_dlPrefixes
  , da_dlTerritories
  , da_dlNorms
  , da_dlAccGroups
  , da_dlNewClasses_Deprecated
  , da_dlAnnoClasses
  , da_dlServiceInfo
  , da_dlTextInsert
 );//TdaDictionaryType

 TdaJoinKind = (
  {* Тип соединения таблиц в запросах }
  da_jkInner
  , da_jkLeftOuter
  , da_jkRightOuter
  , da_jkFullOuter
 );//TdaJoinKind

 TdaSessionID = LongInt;

 TdaCompareOperation = (
  da_copEqual
  , da_copGreaterOrEqual
  , da_copLessOrEqual
  , da_copNotEqual
 );//TdaCompareOperation

 EdaError = class(Exception)
 end;//EdaError

 TdaTablesSet = set of TdaTables;

 LargeInt = Int64;

 TdaDictionaryTypeSet = set of TdaDictionaryType;

 TdaDocEditRecUnion = record
  Case Byte of
   1: (Operation: TdaEditOperation);
   2: (DictType: TdaDictionaryType);
 end;//TdaDocEditRecUnion

 TdaDocEditRec = record
  EditType: TdaDocEditType;
  Details: TdaDocEditRecUnion;
 end;//TdaDocEditRec

 TdaDictEditRec = record
  DictType: TdaDictionaryType;
  Operation: TdaEditOperation;
 end;//TdaDictEditRec

 TdaLogicOperation = (
  da_loAnd
  , da_loOr
 );//TdaLogicOperation

 TdaDictID = TDictID;

 TdaParamType = (
  da_ptInput
  , da_ptOutput
  , da_ptInOut
 );//TdaParamType

 TdaSortOrder = (
  da_soAscending
  , da_soDescending
 );//TdaSortOrder

 TdaPriority = (
  prLowest = -2
  , prLow = -1
  , prNormal = 0
  , prHigh = 1
  , prHighest = 2
 );//TdaPriority

 TdaAggregateOperation = (
  da_aopCount
  , da_aopMin
  , da_aopMax
  , da_aopAverage
  , da_aopSum
 );//TdaAggregateOperation

 TdaUserGroupID = Word;

 TdaUserIDArray = array of TdaUserID;

 TdaUserGroupIDArray = array of TdaUserGroupID;

 TdaSubID = TSubID;

 TdaGlobalCoordinateRec = record
  Family: TdaFamilyID;
  Doc: TdaDocID;
  Sub: TdaSubID;
 end;//TdaGlobalCoordinateRec

 TdaUserEditMask = record
  LoginName: Boolean;
  Name: Boolean;
  ActivFlag: Boolean;
 end;//TdaUserEditMask

 TdaBitwiseOperator = (
  da_bwAnd
  , da_bwOr
 );//TdaBitwiseOperator

 TdaDataTypesSet = set of TdaDataType;

 TdaUserGroupAccessMask = record
 //#UC START# *57AC49D002F2publ*
  ID   : TdaUserID;
  Case Byte of
   0 : (Mask : TTblMask);
   1 : (MaskRec : TTblMaskRec);
 //#UC END# *57AC49D002F2publ*
 end;//TdaUserGroupAccessMask

 TdaDocType = TDocType;

const
 cDeprecatedDicts: TdaDictionaryTypeSet = [da_dlNewClasses_Deprecated];
 da_dtIntegers: TdaDataTypesSet = [da_dtByte, da_dtDWord, da_dtWord, da_dtInteger, da_dtQWord];

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(EdaError));
 {* Регистрация типа EdaError }
{$IfEnd} // NOT Defined(NoScripts)

end.

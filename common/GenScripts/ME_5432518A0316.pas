unit daInterfaces;

interface

uses
 l3IntfUses
 , evdTaskTypes
 , daTypes
 , ddAppConfig
 , l3Tree_TLB
 , l3Date
 , l3Languages
 , l3DatLst
;

type
 IdaLongProcessSubscriber = interface
  function DoLongProcessNotify(aState: TdaProcessState): Boolean;
 end;//IdaLongProcessSubscriber
 
 IdaParamsStorage = interface
  {* Абстрагирует откуда именно надо читать параметры }
  procedure InitStorage;
  function OuterConfigEdit: Boolean;
  procedure BuildConfig(aConfig: TddAppConfiguration;
   const aProviderKey: AnsiString); overload;
 end;//IdaParamsStorage
 
 IdaProgressSubscriber = interface
  procedure DoProgressNotify(aState: Byte;
   aValue: Integer;
   const aMsg: AnsiString);
 end;//IdaProgressSubscriber
 
 daTableDescriptionIterator_IterateFieldsF_Action = function(const anItem: IdaFieldDescription): Boolean;
  {* Тип подитеративной функции для daTableDescriptionIterator.IterateFieldsF }
 
 IdaFieldDescription = interface;
 
 (*
 daTableDescriptionIterator = interface
  procedure IterateFieldsF;
 end;//daTableDescriptionIterator
 *)
 
 IdaTableDescription = interface
  procedure IterateFieldsF;
 end;//IdaTableDescription
 
 IdaJournal = interface
  procedure CalcStatistics(FromDate: TStDate;
   ToDate: TStDate;
   aDocID: TdaDocID;
   UserOrGroupID: TdaUserID;
   UserGr: Boolean);
  procedure LogExport(aFamilyID: TdaFamilyID;
   aCount: LongInt);
  procedure LogImport(aFamilyID: TdaFamilyID);
  procedure LogPause(aLength: LongInt);
  procedure LogPrintDoc(aFamilyID: TdaFamilyID;
   aDocID: TdaDocID);
  procedure LogSaveDoc(aFamilyID: TdaFamilyID;
   aDocID: TdaDocID);
  procedure LogEditDoc(aFamilyID: TdaFamilyID;
   aDocID: TdaDocID;
   aEditType: TdaDocEditType;
   anOperation: TdaEditOperation); overload;
  procedure LogEditDoc(aFamilyID: TdaFamilyID;
   aDocID: TdaDocID;
   aEditType: TdaDocEditType;
   aDictType: TdaDictionaryType); overload;
  procedure LogDeleteDoc(aFamilyID: TdaFamilyID;
   aDocID: TdaDocID);
  procedure LogEditDict(aFamilyID: TdaFamilyID;
   aDictType: TdaDictionaryType;
   anOperation: TdaEditOperation);
  procedure LogCreateDoc(aFamilyID: TdaFamilyID;
   aDocID: TdaDocID);
  procedure LogAutoClass(aFamilyID: TdaFamilyID;
   aCount: LongInt);
  procedure LogOpenDoc(aFamilyID: TdaFamilyID;
   aDocID: TdaDocID);
  procedure StartCaching;
  procedure StopCaching;
  procedure SessionDone;
 end;//IdaJournal
 
 IdaSelectField = interface
  function BuildSQLValue: AnsiString;
 end;//IdaSelectField
 
 IdaParamListHelper = interface
  function GetParamCode(const aParamName: AnsiString): AnsiString;
 end;//IdaParamListHelper
 
 IdaRelationDescription = interface
  function IsEmpty: Boolean;
 end;//IdaRelationDescription
 
 IdaFieldDescription = interface
  procedure BindToTable(const aTable: IdaTableDescription;
   anIndex: Integer);
 end;//IdaFieldDescription
 
 IdaParamDescription = interface
 end;//IdaParamDescription
 
 IdaFromTable = interface
  function BuildSQLValue: AnsiString;
 end;//IdaFromTable
 
 IdaParam = interface
  function IsSameType(const aDesc: IdaParamDescription): Boolean;
 end;//IdaParam
 
 IdaField = interface
 end;//IdaField
 
 IdaDataConverter = interface
  function AllocateParamBuffer(const aDescription: IdaParamDescription): Pointer;
  procedure ParamToDataBase(const aDescription: IdaParamDescription;
   ClientBufferFormat: TdaDataType;
   aClientBuffer: Pointer;
   aServerBuffer: Pointer);
  procedure ParamFromDataBase(const aDescription: IdaParamDescription;
   ClientBufferFormat: TdaDataType;
   aServerBuffer: Pointer;
   aClientBuffer: Pointer);
  procedure FreeParamBuffer(const aDescription: IdaParamDescription;
   aBuffer: Pointer);
 end;//IdaDataConverter
 
 IdaResultSet = interface
  function EOF: Boolean;
  procedure Next;
  function IsEmpty: Boolean;
 end;//IdaResultSet
 
 daConditionIterator_Iterate_Action = function(const anItem: IdaCondition): Boolean;
  {* Тип подитеративной функции для daConditionIterator.Iterate }
 
 IdaCondition = interface;
 
 (*
 daConditionIterator = interface
  procedure Iterate;
 end;//daConditionIterator
 *)
 
 IdaCondition = interface
  function BuildSQLValue(const aHelper: IdaParamListHelper): AnsiString;
  procedure Iterate;
 end;//IdaCondition
 
 IdaQuery = interface
  function OpenResultSet(Unidirectional: Boolean): IdaResultSet;
  procedure Prepare;
  procedure UnPrepare;
  function BuildSQLValue(const aHelper: IdaParamListHelper): AnsiString;
 end;//IdaQuery
 
 IdaResultBuffer = interface
  procedure RegisterField(const aField: IdaField);
  procedure UnregisterField(const aField: IdaField);
  function FieldBufferPtr(FieldIndex: Integer): Pointer;
 end;//IdaResultBuffer
 
 IdaFieldFromTable = interface
 end;//IdaFieldFromTable
 
 IdaUserManager = interface
  function CheckPassword(const aLogin: AnsiString;
   const aPassword: AnsiString;
   RequireAdminRights: Boolean;
   out theUserID: TdaUserID): TdaLoginError;
 end;//IdaUserManager
 
 IdaTabledQuery = interface(IdaQuery)
  procedure AddSelectField(const aField: IdaSelectField);
 end;//IdaTabledQuery
 
 IdaAtomicCondition = interface
 end;//IdaAtomicCondition
 
 IdaTableQueryFactory = interface
  function MakeTabledQuery(const aTable: IdaTableDescription;
   const anAlias: AnsiString): IdaTabledQuery;
  function MakeSelectField(const aTableAlias: AnsiString;
   const aField: IdaFieldDescription;
   const anAlias: AnsiString): IdaSelectField;
  function MakeParamsCondition(const aTableAlias: AnsiString;
   const aField: IdaFieldDescription;
   anOperation: TdaCompareOperation;
   const aParamName: AnsiString): IdaCondition;
  function GetUserNameStr(anUserID: LargeInt): AnsiString;
  function MakeLogicCondition(const aLeft: IdaCondition;
   anOperation: TdaLogicOperation;
   const aRight: IdaCondition): IdaCondition;
  function MakeSubQueryCondition(const aTableAlias: AnsiString;
   const aField: IdaFieldDescription;
   const aQuery: IdaTabledQuery): IdaCondition;
 end;//IdaTableQueryFactory
 
 PIdaLongProcessSubscriber = ^IdaLongProcessSubscriber;
 
 IdaDataProvider = interface
  procedure InitRegionFromIni(aDefaultRegion: TdaRegionID);
  function IsRegionExists(anID: TdaRegionID): Boolean;
  function GetRegionName(anID: TdaRegionID): AnsiString;
  procedure FillRegionDataList(aList: Tl3StringDataList;
   Caps: Boolean);
  procedure Start;
  procedure Stop;
  function CheckLogin(const aLogin: AnsiString;
   const aPassword: AnsiString;
   IsRequireAdminRights: Boolean): TdaLoginError;
  procedure LoginAsServer;
  function GetFreeExtObjID(aFamily: TdaFamilyID): TdaDocID;
  function GetFreeExtDocID(aFamily: TdaFamilyID): TdaDocID;
  function LockAll: Boolean;
  procedure UnlockAll;
  function GetHomePathName(aUserID: TdaUserID): TdaPathStr;
  function GetHomePath(aUserID: TdaUserID): TdaPathStr;
  function ConvertAliasPath(const CurPath: TdaPathStr): TdaPathStr;
  procedure SubscribeLongProcess(const aSubscriber: IdaLongProcessSubscriber);
  procedure UnSubscribeLongProcess(const aSubscriber: IdaLongProcessSubscriber);
  procedure SubscribeProgress(const aSubscriber: IdaProgressSubscriber);
  procedure UnSubscribeProgress(const aSubscriber: IdaProgressSubscriber);
  procedure BeginImpersonate(anUserID: TdaUserID);
  procedure EndImpersonate;
 end;//IdaDataProvider
 
 IdaFunction = interface(IdaQuery)
  procedure Execute;
 end;//IdaFunction
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.

unit daInterfaces;

// Модуль: "w:\common\components\rtl\Garant\DA\daInterfaces.pas"
// Стереотип: "Interfaces"

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

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

const
 c_BadVersion = 0;
 c_DocBaseVersion = {$ifDef DBVer134} 134 {$ELSE} 133 {$ENDIF};
 c_AdminBaseVersion = c_DocBaseVersion;
 usSupervisor = 1;
 usAdminReservedHard = $FFFFFFFE;
 usFirstWorkUser = usAdminReservedHard - 1;
 usAdminReserved = $FF000000;
 usServerService = evdTaskTypes.usServerService;
 usNotDefined = usServerService + 1;
 usWrongClient = MaxInt;
  {* говорит об отказе в регистрации }
 usDuplicateClient = Pred(usWrongClient);
  {* попытка войти повторно }
 usDeadClient = Pred(usDuplicateClient);
  {* не отвечает на запросы }
 usNone = 0;
 c_SupervisorUserName = 'supervisor';
 usActive = 1;
 usAdmin = 2;
 usDeleted = 4;
 cUndefDocID: TdaDocID = -1;

type
 PIdaLongProcessSubscriber = ^IdaLongProcessSubscriber;

 IdaLongProcessSubscriber = interface
  ['{5450DF32-F7B8-4889-B03B-B1B4E5BA5C40}']
  function DoLongProcessNotify(aState: TdaProcessState): Boolean;
 end;//IdaLongProcessSubscriber

 IdaParamsStorage = interface
  {* Абстрагирует откуда именно надо читать параметры }
  ['{FD33F800-DD7F-4513-8AD1-777C79BC0487}']
  function Get_ProviderKey: AnsiString;
  procedure Set_ProviderKey(const aValue: AnsiString);
  function Get_Login: AnsiString;
  procedure Set_Login(const aValue: AnsiString);
  function Get_Password: AnsiString;
  procedure Set_Password(const aValue: AnsiString);
  function Get_DocStoragePath: AnsiString;
  procedure Set_DocStoragePath(const aValue: AnsiString);
  function Get_DocImagePath: AnsiString;
  procedure Set_DocImagePath(const aValue: AnsiString);
  function Get_HomeDirPath: AnsiString;
  procedure Set_HomeDirPath(const aValue: AnsiString);
  procedure InitStorage;
  function OuterConfigEdit: Boolean;
  procedure BuildConfig(aConfig: TddAppConfiguration;
   const aProviderKey: AnsiString); overload;
  property ProviderKey: AnsiString
   read Get_ProviderKey
   write Set_ProviderKey;
  property Login: AnsiString
   read Get_Login
   write Set_Login;
  property Password: AnsiString
   read Get_Password
   write Set_Password;
  property DocStoragePath: AnsiString
   read Get_DocStoragePath
   write Set_DocStoragePath;
  property DocImagePath: AnsiString
   read Get_DocImagePath
   write Set_DocImagePath;
  property HomeDirPath: AnsiString
   read Get_HomeDirPath
   write Set_HomeDirPath;
 end;//IdaParamsStorage

 IdaProgressSubscriber = interface
  ['{236542E0-5839-4DF9-8D69-5065DF15D108}']
  procedure DoProgressNotify(aState: Byte;
   aValue: Integer;
   const aMsg: AnsiString = '');
 end;//IdaProgressSubscriber

 daTableDescriptionIterator_IterateFieldsF_Action = function(const anItem: IdaFieldDescription): Boolean;
  {* Тип подитеративной функции для daTableDescriptionIterator.IterateFieldsF }

 IdaFieldDescription = interface;

 (*
 daTableDescriptionIterator = interface
  procedure IterateFieldsF(anAction: daTableDescriptionIterator_IterateFieldsF_Action);
 end;//daTableDescriptionIterator
 *)

 IdaTableDescription = interface
  ['{F831FE3E-019C-4F77-84D3-4006DE7D9F13}']
  function Get_Description: AnsiString;
  function Get_IsDublicate: Boolean;
  function Get_IsFake: Boolean;
  function Get_Kind: TdaTables;
  function Get_SQLName: AnsiString;
  function Get_Scheme: AnsiString;
  function Get_FieldsCount: Integer;
  function Get_FieldsCountWithoutTree: Integer;
  function Get_IsTree: Boolean;
  function Get_Field(const FIeldName: AnsiString): IdaFieldDescription;
  function FieldByIndex(anIndex: Integer): IdaFieldDescription;
  procedure IterateFieldsF(anAction: daTableDescriptionIterator_IterateFieldsF_Action);
  property Description: AnsiString
   read Get_Description;
  property IsDublicate: Boolean
   read Get_IsDublicate;
   {* Дубликат таблицы для связки в запросах (HT по другому не умеет) }
  property IsFake: Boolean
   read Get_IsFake;
   {* Совсем виртуальная таблица }
  property Kind: TdaTables
   read Get_Kind;
  property SQLName: AnsiString
   read Get_SQLName;
  property Scheme: AnsiString
   read Get_Scheme;
  property FieldsCount: Integer
   read Get_FieldsCount;
  property FieldsCountWithoutTree: Integer
   read Get_FieldsCountWithoutTree;
  property IsTree: Boolean
   read Get_IsTree;
  property Field[const FIeldName: AnsiString]: IdaFieldDescription
   read Get_Field;
   default;
 end;//IdaTableDescription

 IdaJournal = interface
  ['{8628085D-2AA4-4174-BE8D-7E55B9B71B8F}']
  function Get_CurStatisticTreeRoot: Il3RootNode;
  function Get_UserID: TdaUserID;
  procedure Set_UserID(aValue: TdaUserID);
  procedure CalcStatistics(const FromDate: TStDate;
   const ToDate: TStDate;
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
   anOperation: TdaEditOperation = da_eoNone); overload;
  procedure LogEditDoc(aFamilyID: TdaFamilyID;
   aDocID: TdaDocID;
   aEditType: TdaDocEditType;
   aDictType: TdaDictionaryType); overload;
  procedure LogDeleteDoc(aFamilyID: TdaFamilyID;
   aDocID: TdaDocID);
  procedure LogEditDict(aFamilyID: TdaFamilyID;
   aDictType: TdaDictionaryType;
   anOperation: TdaEditOperation = da_eoNone);
  procedure LogCreateDoc(aFamilyID: TdaFamilyID;
   aDocID: TdaDocID);
  procedure LogAutoClass(aFamilyID: TdaFamilyID;
   aCount: LongInt);
  procedure LogOpenDoc(aFamilyID: TdaFamilyID;
   aDocID: TdaDocID);
  procedure StartCaching;
  procedure StopCaching;
  procedure SessionDone;
  property CurStatisticTreeRoot: Il3RootNode
   read Get_CurStatisticTreeRoot;
  property UserID: TdaUserID
   read Get_UserID
   write Set_UserID;
 end;//IdaJournal

 IdaSelectField = interface
  ['{10F9D403-0EFE-4752-B316-E83193F6792D}']
  function Get_Alias: AnsiString;
  function BuildSQLValue: AnsiString;
  property Alias: AnsiString
   read Get_Alias;
 end;//IdaSelectField

 IdaParamListHelper = interface
  ['{B30E6B3C-EC79-47D8-A092-2B8590EAF266}']
  function GetParamCode(const aParamName: AnsiString): AnsiString;
 end;//IdaParamListHelper

 IdaRelationDescription = interface
  ['{EF6E11EB-A011-4D88-A539-5128D54981EF}']
  function IsEmpty: Boolean;
 end;//IdaRelationDescription

 IdaFieldDescription = interface
  ['{D2CE49CF-F261-47FA-8E38-C372CB79783E}']
  function Get_SQLName: AnsiString;
  function Get_Description: AnsiString;
  function Get_DataType: TdaDataType;
  function Get_Required: Boolean;
  function Get_Table: IdaTableDescription;
  function Get_Index: Integer;
  function Get_Size: Integer;
  procedure BindToTable(const aTable: IdaTableDescription = nil;
   anIndex: Integer = -1);
  property SQLName: AnsiString
   read Get_SQLName;
  property Description: AnsiString
   read Get_Description;
  property DataType: TdaDataType
   read Get_DataType;
  property Required: Boolean
   read Get_Required;
  property Table: IdaTableDescription
   read Get_Table;
   {* Должно быть Weak }
  property Index: Integer
   read Get_Index;
  property Size: Integer
   read Get_Size;
 end;//IdaFieldDescription

 IdaParamDescription = interface
  ['{231DAF16-AC76-4EB8-90CF-185538155226}']
  function Get_Name: AnsiString;
  function Get_DataType: TdaDataType;
  function Get_Size: Integer;
  function Get_ParamType: TdaParamType;
  property Name: AnsiString
   read Get_Name;
  property DataType: TdaDataType
   read Get_DataType;
  property Size: Integer
   read Get_Size;
  property ParamType: TdaParamType
   read Get_ParamType;
 end;//IdaParamDescription

 IdaFromTable = interface
  ['{43C2BCC3-6B05-40F7-AEB8-4792C30B5F11}']
  function Get_TableAlias: AnsiString;
  function Get_Table: IdaTableDescription;
  function BuildSQLValue: AnsiString;
  property TableAlias: AnsiString
   read Get_TableAlias;
  property Table: IdaTableDescription
   read Get_Table;
 end;//IdaFromTable

 IdaParam = interface
  ['{8253B891-A037-4ED1-831B-7C5C6E20A82E}']
  function Get_Name: AnsiString;
  function Get_AsInteger: LongInt;
  procedure Set_AsInteger(aValue: LongInt);
  function Get_DataBuffer: Pointer;
  function Get_AsLargeInt: LargeInt;
  procedure Set_AsLargeInt(aValue: LargeInt);
  function Get_AsString: AnsiString;
  procedure Set_AsString(const aValue: AnsiString);
  function Get_AsStDate: TStDate;
  procedure Set_AsStDate(const aValue: TStDate);
  function Get_AsStTime: TStTime;
  procedure Set_AsStTime(const aValue: TStTime);
  function Get_ParamType: TdaParamType;
  function IsSameType(const aDesc: IdaParamDescription): Boolean;
  property Name: AnsiString
   read Get_Name;
  property AsInteger: LongInt
   read Get_AsInteger
   write Set_AsInteger;
  property DataBuffer: Pointer
   read Get_DataBuffer;
  property AsLargeInt: LargeInt
   read Get_AsLargeInt
   write Set_AsLargeInt;
  property AsString: AnsiString
   read Get_AsString
   write Set_AsString;
  property AsStDate: TStDate
   read Get_AsStDate
   write Set_AsStDate;
  property AsStTime: TStTime
   read Get_AsStTime
   write Set_AsStTime;
  property ParamType: TdaParamType
   read Get_ParamType;
 end;//IdaParam

 IdaField = interface
  ['{F7FBEDDB-CE98-48E9-921A-EC17FE5FFB30}']
  function Get_AsLargeInt: LargeInt;
  function Get_AsInteger: Integer;
  function Get_AsStDate: TStDate;
  function Get_AsStTime: TStTime;
  function Get_AsString: AnsiString;
  function Get_AsByte: Byte;
  function Get_Alias: AnsiString;
  property AsLargeInt: LargeInt
   read Get_AsLargeInt;
  property AsInteger: Integer
   read Get_AsInteger;
  property AsStDate: TStDate
   read Get_AsStDate;
  property AsStTime: TStTime
   read Get_AsStTime;
  property AsString: AnsiString
   read Get_AsString;
  property AsByte: Byte
   read Get_AsByte;
  property Alias: AnsiString
   read Get_Alias;
 end;//IdaField

 IdaDataConverter = interface
  ['{CBE05A0B-B4D6-4E62-B08F-DA5E06DA5B10}']
  function AllocateParamBuffer(const aDescription: IdaParamDescription): Pointer;
  procedure ParamToDataBase(const aDescription: IdaParamDescription;
   ClientBufferFormat: TdaDataType;
   aClientBuffer: Pointer;
   var aServerBuffer: Pointer);
  procedure ParamFromDataBase(const aDescription: IdaParamDescription;
   ClientBufferFormat: TdaDataType;
   aServerBuffer: Pointer;
   aClientBuffer: Pointer);
  procedure FreeParamBuffer(const aDescription: IdaParamDescription;
   aBuffer: Pointer);
 end;//IdaDataConverter

 IdaResultSet = interface
  ['{946A7C8B-C5DF-4ACE-891F-838154BA6752}']
  function Get_Field(const anAlias: AnsiString): IdaField;
  function EOF: Boolean;
  procedure Next;
  function IsEmpty: Boolean;
  property Field[const anAlias: AnsiString]: IdaField
   read Get_Field;
 end;//IdaResultSet

 daConditionIterator_Iterate_Action = function(const anItem: IdaCondition): Boolean;
  {* Тип подитеративной функции для daConditionIterator.Iterate }

 IdaCondition = interface;

 (*
 daConditionIterator = interface
  procedure Iterate(anAction: daConditionIterator_Iterate_Action);
  procedure IterateF(anAction: daConditionIterator_Iterate_Action);
 end;//daConditionIterator
 *)

 IdaCondition = interface
  ['{EC607AF4-F1DA-4322-8BD3-6932EE2BB0EE}']
  function BuildSQLValue(const aHelper: IdaParamListHelper): AnsiString;
  procedure Iterate(anAction: daConditionIterator_Iterate_Action);
  procedure IterateF(anAction: daConditionIterator_Iterate_Action);
 end;//IdaCondition

 IdaQuery = interface
  ['{B09183CF-00DE-48AC-B7F6-0E440637550C}']
  function Get_Param(const aName: AnsiString): IdaParam;
  function OpenResultSet(Unidirectional: Boolean = True): IdaResultSet;
  procedure Prepare;
  procedure UnPrepare;
  function BuildSQLValue(const aHelper: IdaParamListHelper): AnsiString;
  property Param[const aName: AnsiString]: IdaParam
   read Get_Param;
 end;//IdaQuery

 IdaResultBuffer = interface
  ['{5E8352D2-D847-437E-8BD8-EAF59267A5C6}']
  procedure RegisterField(const aField: IdaField);
  procedure UnregisterField(const aField: IdaField);
  function FieldBufferPtr(FieldIndex: Integer): Pointer;
 end;//IdaResultBuffer

 IdaFieldFromTable = interface
  ['{421A6E68-E79A-4BC9-BCAA-79BBBE6CD80D}']
  function Get_TableAlias: AnsiString;
  function Get_Field: IdaFieldDescription;
  property TableAlias: AnsiString
   read Get_TableAlias;
  property Field: IdaFieldDescription
   read Get_Field;
 end;//IdaFieldFromTable

 IdaUserManager = interface
  ['{43BA4AB7-F7E0-4020-AD1B-A6807EBDFCE3}']
  function CheckPassword(const aLogin: AnsiString;
   const aPassword: AnsiString;
   RequireAdminRights: Boolean;
   out theUserID: TdaUserID): TdaLoginError;
 end;//IdaUserManager

 IdaSortField = interface
  ['{9416DE56-ABBE-4945-B6C7-BBBBC4584860}']
  function Get_SelectField: IdaSelectField;
  function Get_SortOrder: TdaSortOrder;
  property SelectField: IdaSelectField
   read Get_SelectField;
  property SortOrder: TdaSortOrder
   read Get_SortOrder;
 end;//IdaSortField

 IdaAtomicCondition = interface
  ['{3EDD2B55-9527-4684-A646-45D8953FA44A}']
  function Get_Operation: TdaCompareOperation;
  property Operation: TdaCompareOperation
   read Get_Operation;
 end;//IdaAtomicCondition

 IdaTabledQuery = interface(IdaQuery)
  ['{F3159211-0A1B-4F31-8BD5-17E6B8443F61}']
  function Get_WhereCondition: IdaCondition;
  procedure Set_WhereCondition(const aValue: IdaCondition);
  function Get_Table: IdaFromTable;
  procedure AddSelectField(const aField: IdaSelectField);
  procedure AddOrderBy(const aSortField: IdaSortField);
  property WhereCondition: IdaCondition
   read Get_WhereCondition
   write Set_WhereCondition;
  property Table: IdaFromTable
   read Get_Table;
 end;//IdaTabledQuery

 IdaTableQueryFactory = interface
  ['{158601ED-CBAB-4A68-975A-8A6590602F42}']
  function Get_DataConverter: IdaDataConverter;
  function MakeTabledQuery(const aTable: IdaTableDescription;
   const anAlias: AnsiString = ''): IdaTabledQuery;
  function MakeSelectField(const aTableAlias: AnsiString;
   const aField: IdaFieldDescription;
   const anAlias: AnsiString = ''): IdaSelectField;
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
  function MakeSortField(const aSelectField: IdaSelectField;
   aSortOrder: TdaSortOrder = da_soAscending): IdaSortField;
  property DataConverter: IdaDataConverter
   read Get_DataConverter;
 end;//IdaTableQueryFactory

 IdaFunction = interface(IdaQuery)
  ['{6EA115C8-7CB5-491C-B44C-F9D45EE48050}']
  procedure Execute;
 end;//IdaFunction

 IdaDataProvider = interface
  ['{CB4A320D-C320-42C5-AD66-8C45A9DD91AC}']
  function Get_UserID: TdaUserID;
  function Get_RegionID: TdaRegionID;
  function Get_BaseName: AnsiString;
  function Get_AdminRights: Boolean;
  function Get_CurUserIsServer: Boolean;
  function Get_CurHomePath: TdaPathStr;
  function Get_GlobalHomePath: TdaPathStr;
  function Get_Journal: IdaJournal;
  function Get_TableQueryFactory: IdaTableQueryFactory;
  function Get_DataConverter: IdaDataConverter;
  function Get_ImpersonatedUserID: TdaUserID;
  function Get_UserManager: IdaUserManager;
  function Get_BaseLanguage(aFamily: TdaFamilyID): TLanguageObj;
  function Get_TextBase(aFamily: TdaFamilyID): AnsiString;
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
  property UserID: TdaUserID
   read Get_UserID;
  property RegionID: TdaRegionID
   read Get_RegionID;
  property BaseName: AnsiString
   read Get_BaseName;
  property AdminRights: Boolean
   read Get_AdminRights;
  property CurUserIsServer: Boolean
   read Get_CurUserIsServer;
  property CurHomePath: TdaPathStr
   read Get_CurHomePath;
  property GlobalHomePath: TdaPathStr
   read Get_GlobalHomePath;
  property Journal: IdaJournal
   read Get_Journal;
  property TableQueryFactory: IdaTableQueryFactory
   read Get_TableQueryFactory;
  property DataConverter: IdaDataConverter
   read Get_DataConverter;
  property ImpersonatedUserID: TdaUserID
   read Get_ImpersonatedUserID;
  property UserManager: IdaUserManager
   read Get_UserManager;
  property BaseLanguage[aFamily: TdaFamilyID]: TLanguageObj
   read Get_BaseLanguage;
  property TextBase[aFamily: TdaFamilyID]: AnsiString
   read Get_TextBase;
 end;//IdaDataProvider

 IdaComboAccessDataProviderHelper = interface
  ['{603EDD09-200D-48A3-A7AC-E58665C5439E}']
  procedure RegisterFreeExtObjID(anID: TdaDocID);
  procedure RegisterFreeExtDocID(anID: TdaDocID);
 end;//IdaComboAccessDataProviderHelper

 IdaComboAccessJournalHelper = interface
  ['{9C5AF6B0-E3D5-419F-9136-E0280619B32D}']
 end;//IdaComboAccessJournalHelper

function L2daTableDescriptionIteratorIterateFieldsFAction(anAction: pointer): daTableDescriptionIterator_IterateFieldsF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для daTableDescriptionIterator.IterateFieldsF }
function L2daConditionIteratorIterateAction(anAction: pointer): daConditionIterator_Iterate_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для daConditionIterator.Iterate }

implementation

uses
 l3ImplUses
 , l3Base
;

function L2daTableDescriptionIteratorIterateFieldsFAction(anAction: pointer): daTableDescriptionIterator_IterateFieldsF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для daTableDescriptionIterator.IterateFieldsF }
asm
 jmp l3LocalStub
end;//L2daTableDescriptionIteratorIterateFieldsFAction

function L2daConditionIteratorIterateAction(anAction: pointer): daConditionIterator_Iterate_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для daConditionIterator.Iterate }
asm
 jmp l3LocalStub
end;//L2daConditionIteratorIterateAction

end.

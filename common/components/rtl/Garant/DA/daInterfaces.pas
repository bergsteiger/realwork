unit daInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DA"
// Модуль: "w:/common/components/rtl/Garant/DA/daInterfaces.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi For Archi::DA::daInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DA\daDefine.inc}

interface

uses
  l3Types,
  l3Tree_TLB,
  daTypes,
  l3Date,
  ddAppConfig,
  l3DatLst,
  evdTaskTypes,
  l3Languages
  ;

type
 IdaLongProcessSubscriber = interface(IUnknown)
   ['{5450DF32-F7B8-4889-B03B-B1B4E5BA5C40}']
   function DoLongProcessNotify(aState: TdaProcessState): Boolean;
 end;//IdaLongProcessSubscriber

 IdaParamsStorage = interface(IUnknown)
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

const
  { DBVersion }
 c_BadVersion = 0;
 c_DocBaseVersion = {$ifDef DBVer134} 134 {$ELSE} 133 {$ENDIF};
 c_AdminBaseVersion = c_DocBaseVersion;
  { UserConsts }
 usSupervisor = 1;
 usAdminReservedHard = $FFFFFFFE;
 usFirstWorkUser = usAdminReservedHard - 1;
 usAdminReserved = $FF000000;
 usServerService = evdTaskTypes.usServerService;
 usNotDefined = usServerService + 1;
 usWrongClient = MaxInt;
  { говорит об отказе в регистрации }
 usDuplicateClient = Pred(usWrongClient);
  { попытка войти повторно }
 usDeadClient = Pred(usDuplicateClient);
  { не отвечает на запросы }
 usNone = 0;
 c_SupervisorUserName = 'supervisor';

type
 IdaProgressSubscriber = interface(IUnknown)
   ['{236542E0-5839-4DF9-8D69-5065DF15D108}']
   procedure DoProgressNotify(aState: Byte;
     aValue: Integer;
     const aMsg: AnsiString = '');
 end;//IdaProgressSubscriber
 IdaFieldDescription = interface;
 { - предварительное описание IdaFieldDescription. }


  daTableDescriptionIterator_IterateFieldsF_Action = function (const anItem: IdaFieldDescription): Boolean;
   {* Тип подитеративной функции для daTableDescriptionIterator.IterateFieldsF }

(*
 daTableDescriptionIterator = PureMixIn
   {iterator} procedure IterateFieldsF(anAction: daTableDescriptionIterator_IterateFieldsF_Action);
 end;//daTableDescriptionIterator
*)

 IdaTableDescription = interface(IUnknown)
   ['{F831FE3E-019C-4F77-84D3-4006DE7D9F13}']
   function Get_Description: AnsiString;
   function Get_IsDublicate: Boolean;
   function Get_IsFake: Boolean;
   function Get_Kind: TdaTables;
   function Get_Code: AnsiString;
   function Get_Name: AnsiString;
   function Get_Field(const FIeldName: AnsiString): IdaFieldDescription;
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
   property Code: AnsiString
     read Get_Code;
   property Name: AnsiString
     read Get_Name;
   property Field[const FIeldName: AnsiString]: IdaFieldDescription
     read Get_Field;
     default;
  // daTableDescriptionIterator
   {iterator} procedure IterateFieldsF(anAction: daTableDescriptionIterator_IterateFieldsF_Action);
 end;//IdaTableDescription

 IdaJournal = interface(IUnknown)
   ['{8628085D-2AA4-4174-BE8D-7E55B9B71B8F}']
   function Get_CurStatisticTreeRoot: Il3RootNode;
   function Get_UserID: TdaUserID;
   procedure Set_UserID(aValue: TdaUserID);
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

 IdaSelectField = interface(IUnknown)
   ['{10F9D403-0EFE-4752-B316-E83193F6792D}']
   function Get_Alias: AnsiString;
   function BuildSQLValue: AnsiString;
   property Alias: AnsiString
     read Get_Alias;
 end;//IdaSelectField

 IdaParamListHelper = interface(IUnknown)
   ['{B30E6B3C-EC79-47D8-A092-2B8590EAF266}']
   function GetParamCode(const aParamName: AnsiString): AnsiString;
 end;//IdaParamListHelper

 IdaRelationDescription = interface(IUnknown)
   ['{EF6E11EB-A011-4D88-A539-5128D54981EF}']
   function IsEmpty: Boolean;
 end;//IdaRelationDescription

 IdaFieldDescription = interface(IUnknown)
   ['{D2CE49CF-F261-47FA-8E38-C372CB79783E}']
   function Get_Name: AnsiString;
   function Get_Description: AnsiString;
   function Get_DataType: TdaDataType;
   function Get_Required: Boolean;
   function Get_Table: IdaTableDescription;
   function Get_Index: Integer;
   function Get_SIze: Integer;
   procedure BindToTable(const aTable: IdaTableDescription = nil;
    anIndex: Integer = -1);
   property Name: AnsiString
     read Get_Name;
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
   property SIze: Integer
     read Get_SIze;
 end;//IdaFieldDescription

 IdaParamDescription = interface(IUnknown)
   ['{231DAF16-AC76-4EB8-90CF-185538155226}']
   function Get_Name: AnsiString;
   function Get_DataType: TdaDataType;
   function Get_Size: Integer;
   property Name: AnsiString
     read Get_Name;
   property DataType: TdaDataType
     read Get_DataType;
   property Size: Integer
     read Get_Size;
 end;//IdaParamDescription

 IdaFromTable = interface(IUnknown)
   ['{43C2BCC3-6B05-40F7-AEB8-4792C30B5F11}']
   function Get_TableAlias: AnsiString;
   function Get_Table: IdaTableDescription;
   function BuildSQLValue: AnsiString;
   property TableAlias: AnsiString
     read Get_TableAlias;
   property Table: IdaTableDescription
     read Get_Table;
 end;//IdaFromTable

 IdaParam = interface(IUnknown)
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
   procedure Set_AsStDate(aValue: TStDate);
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
 end;//IdaParam

 IdaField = interface(IUnknown)
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

 IdaDataConverter = interface(IUnknown)
   ['{CBE05A0B-B4D6-4E62-B08F-DA5E06DA5B10}']
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

 IdaResultSet = interface(IUnknown)
   ['{946A7C8B-C5DF-4ACE-891F-838154BA6752}']
   function Get_Field(const anAlias: AnsiString): IdaField;
   function EOF: Boolean;
   procedure Next;
   function IsEmpty: Boolean;
   property Field[const anAlias: AnsiString]: IdaField
     read Get_Field;
 end;//IdaResultSet

 IdaCondition = interface(IUnknown)
   ['{EC607AF4-F1DA-4322-8BD3-6932EE2BB0EE}']
   function BuildSQLValue(const aHelper: IdaParamListHelper): AnsiString;
 end;//IdaCondition

 IdaQuery = interface(IUnknown)
   ['{F3159211-0A1B-4F31-8BD5-17E6B8443F61}']
   function Get_WhereCondition: IdaCondition;
   procedure Set_WhereCondition(const aValue: IdaCondition);
   function Get_Param(const aName: AnsiString): IdaParam;
   function OpenResultSet(Unidirectional: Boolean = True): IdaResultSet;
   procedure Prepare;
   procedure AddSelectField(const aField: IdaSelectField);
   procedure AddFromTable(const aTable: IdaFromTable);
   procedure UnPrepare;
   property WhereCondition: IdaCondition
     read Get_WhereCondition
     write Set_WhereCondition;
   property Param[const aName: AnsiString]: IdaParam
     read Get_Param;
 end;//IdaQuery

 IdaTableQueryFactory = interface(IUnknown)
   ['{158601ED-CBAB-4A68-975A-8A6590602F42}']
   function Get_DataConverter: IdaDataConverter;
   function MakeTabledQuery(const aTable: IdaTableDescription;
    const anAlias: AnsiString = ''): IdaQuery;
   function MakeSelectField(const aTableAlias: AnsiString;
    const aField: IdaFieldDescription;
    const anAlias: AnsiString = ''): IdaSelectField;
   function MakeParamsCondition(const aTableAlias: AnsiString;
    const aField: IdaFieldDescription;
    anOperation: TdaCompareOperation;
    const aParamName: AnsiString): IdaCondition;
   function GetUserNameStr(anUserID: LargeInt): AnsiString;
   property DataConverter: IdaDataConverter
     read Get_DataConverter;
 end;//IdaTableQueryFactory

 IdaResultBuffer = interface(IUnknown)
   ['{5E8352D2-D847-437E-8BD8-EAF59267A5C6}']
   procedure RegisterField(const aField: IdaField);
   procedure UnregisterField(const aField: IdaField);
   function FieldBufferPtr(FieldIndex: Integer): Pointer;
 end;//IdaResultBuffer

 IdaFieldFromTable = interface(IUnknown)
   ['{421A6E68-E79A-4BC9-BCAA-79BBBE6CD80D}']
   function Get_TableAlias: AnsiString;
   function Get_Field: IdaFieldDescription;
   property TableAlias: AnsiString
     read Get_TableAlias;
   property Field: IdaFieldDescription
     read Get_Field;
 end;//IdaFieldFromTable

 IdaUserManager = interface(IUnknown)
   ['{43BA4AB7-F7E0-4020-AD1B-A6807EBDFCE3}']
   function CheckPassword(const aLogin: AnsiString;
    const aPassword: AnsiString;
    RequireAdminRights: Boolean;
    out theUserID: TdaUserID): TdaLoginError;
 end;//IdaUserManager

 IdaDataProvider = interface(IUnknown)
   ['{CB4A320D-C320-42C5-AD66-8C45A9DD91AC}']
   procedure InitRegionFromIni(aDefaultRegion: TdaRegionID);
   function IsRegionExists(aID: TdaRegionID): Boolean;
   function GetRegionName(aID: TdaRegionID): AnsiString;
   procedure FillRegionDataList(aList: Tl3StringDataList;
     Caps: Boolean);
   procedure Start;
     {* Сигнатура метода Start }
   procedure Stop;
     {* Сигнатура метода Stop }
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

const
  { UserFlagConst }
 usActive = 1;
 usAdmin = 2;
 usDeleted = 4;

type
 IdaAtomicCondition = interface(IUnknown)
   ['{3EDD2B55-9527-4684-A646-45D8953FA44A}']
   function Get_Operation: TdaCompareOperation;
   property Operation: TdaCompareOperation
     read Get_Operation;
 end;//IdaAtomicCondition

function L2DaTableDescriptionIteratorIterateFieldsFAction(anAction: pointer): daTableDescriptionIterator_IterateFieldsF_Action;
   {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для daTableDescriptionIterator.IterateFieldsF }

implementation

uses
  l3Base
  ;

// start class daTableDescriptionIterator

function L2DaTableDescriptionIteratorIterateFieldsFAction(anAction: pointer): daTableDescriptionIterator_IterateFieldsF_Action;
 {-}
asm
 jmp l3LocalStub
end;//L2DaTableDescriptionIteratorIterateFieldsFAction

end.
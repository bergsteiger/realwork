unit pgDataProvider;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , pgDataProviderParams
 , pgInterfaces
 , daLongProcessSubscriberList
 , daProgressSubscriberList
 , pgConnection
 , daTypes
 , l3Languages
 , pgFamilyHelper
 , pgRenumerator
 , pgFreeIDHelper
 , pgFunctionFactory
 , l3DatLst
;

type
 TpgDataProvider = class(Tl3ProtoObject, IdaDataProvider)
  procedure Create(aParams: TpgDataProviderParams;
   ForCheckLogin: Boolean;
   AllowClearLocks: Boolean);
  function Make(aParams: TpgDataProviderParams;
   ForCheckLogin: Boolean;
   AllowClearLocks: Boolean): IdaDataProvider;
  procedure ReadIniFile;
  function RegionQuery: IdaTabledQuery;
  function RegionResultSet(anID: TdaRegionID): IdaResultSet;
  function FamilyHelper: TpgFamilyHelper;
  function GetAliasValue(const aAlias: AnsiString): AnsiString;
  function Renum: TpgRenumerator;
  function ExtDocIDsFromRange: Boolean;
  function CheckFreeResource(aFamilyID: TdaFamilyID;
   const aKey: AnsiString): Boolean;
  function UserID: TdaUserID;
  function RegionID: TdaRegionID;
  function CheckLogin(const aLogin: AnsiString;
   const aPassword: AnsiString;
   IsRequireAdminRights: Boolean): TdaLoginError;
  procedure InitRegionFromIni(aDefaultRegion: TdaRegionID);
  function IsRegionExists(anID: TdaRegionID): Boolean;
  function GetRegionName(anID: TdaRegionID): AnsiString;
  procedure FillRegionDataList(aList: Tl3StringDataList;
   Caps: Boolean);
  function BaseName: AnsiString;
  function AdminRights: Boolean;
  function CurUserIsServer: Boolean;
  procedure LoginAsServer;
  function GetFreeExtObjID(aFamily: TdaFamilyID): TdaDocID;
  function GetFreeExtDocID(aFamily: TdaFamilyID): TdaDocID;
  function LockAll: Boolean;
  procedure UnlockAll;
  function BaseLanguage: TLanguageObj;
  function TextBase: AnsiString;
  function GetHomePathName(aUserID: TdaUserID): TdaPathStr;
  function GetHomePath(aUserID: TdaUserID): TdaPathStr;
  function CurHomePath: TdaPathStr;
  function GlobalHomePath: TdaPathStr;
  function ConvertAliasPath(const CurPath: TdaPathStr): TdaPathStr;
  procedure SubscribeLongProcess(const aSubscriber: IdaLongProcessSubscriber);
  procedure UnSubscribeLongProcess(const aSubscriber: IdaLongProcessSubscriber);
  procedure SubscribeProgress(const aSubscriber: IdaProgressSubscriber);
  procedure UnSubscribeProgress(const aSubscriber: IdaProgressSubscriber);
  procedure Start;
  procedure Stop;
  function Journal: IdaJournal;
  function TableQueryFactory: IdaTableQueryFactory;
  function DataConverter: IdaDataConverter;
  function ImpersonatedUserID: TdaUserID;
  procedure BeginImpersonate(anUserID: TdaUserID);
  procedure EndImpersonate;
  function UserManager: IdaUserManager;
 end;//TpgDataProvider
 
implementation

uses
 l3ImplUses
 , SysUtils
 , pgDataConverter
 , daDataProvider
 , daUtils
 , l3IniFile
 , pgTableQueryFactory
 , pgJournal
 , l3Base
 , pgUserManager
 , daScheme
 , m2XLtLib
 , l3FileUtils
 , StrUtils
 , daSchemeConsts
;

end.

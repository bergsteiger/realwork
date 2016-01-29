unit htDataProvider;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , htDataProviderParams
 , daLongProcessSubscriberList
 , daProgressSubscriberList
 , htInterfaces
 , daTypes
 , l3Languages
 , l3DatLst
;

type
 ThtDataProvider = class(Tl3ProtoObject, IdaDataProvider)
  procedure Create(aParams: ThtDataProviderParams;
   ForCheckLogin: Boolean;
   AllowClearLocks: Boolean);
  function Make(aParams: ThtDataProviderParams;
   ForCheckLogin: Boolean;
   AllowClearLocks: Boolean): IdaDataProvider;
  function DoLongProcessNotify(aState: TdaProcessState): Boolean;
  procedure DoProgressNotify(aState: Byte;
   aValue: Integer;
   const aMsg: AnsiString);
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
 end;//ThtDataProvider
 
implementation

uses
 l3ImplUses
 , SysUtils
 , dt_Serv
 , daDataProvider
 , htJournal
 , htTableQueryFactory
 , htDataConverter
 , htDataSchemeHelper
 , l3Base
 , htUserManager
;

end.

unit pgDataProvider;

// Модуль: "w:\common\components\rtl\Garant\PG\pgDataProvider.pas"
// Стереотип: "SimpleClass"

{$Include pgDefine.inc}

interface

{$If Defined(UsePostgres)}
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
 TpgDataProvider = class(Tl3ProtoObject, IdaDataProvider, IdaComboAccessDataProviderHelper)
  private
   f_Params: TpgDataProviderParams;
   f_DataConverter: IpgDataConverter;
   f_NeedClearGlobalDataProvider: Boolean;
   f_LongProcessList: TdaLongProcessSubscriberList;
   f_ProgressList: TdaProgressSubscriberList;
   f_ForCheckLogin: Boolean;
   f_AllowClearLocks: Boolean;
   f_RequireAdminRights: Boolean;
   f_Connection: TpgConnection;
   f_RegionID: TdaRegionID;
   f_BaseName: AnsiString;
   f_BaseLang: TLanguageObj;
   f_Factory: IdaTableQueryFactory;
   f_Journal: IdaJournal;
   f_ImpersonatedUserID: TdaUserID;
   f_UserManager: IdaUserManager;
   f_IsStarted: Boolean;
   f_RegionQuery: IdaTabledQuery;
   f_FamilyHelper: TpgFamilyHelper;
   f_CurHomePath: AnsiString;
   f_LockCounter: Integer;
   f_Renum: TpgRenumerator;
   f_MainFreeIDHelper: TpgFreeIDHelper;
   f_CurrentFreeIDHelper: TpgFreeIDHelper;
   f_FunctionFactory: TpgFunctionFactory;
   f_SetGlobalDataProvider: Boolean;
  private
   procedure ReadIniFile;
   function RegionQuery: IdaTabledQuery;
   function RegionResultSet(anID: TdaRegionID): IdaResultSet;
   function FamilyHelper: TpgFamilyHelper;
   function GetAliasValue(const aAlias: AnsiString): AnsiString;
   function Renum: TpgRenumerator;
   function ExtDocIDsFromRange: Boolean;
   function CheckFreeResource(aFamilyID: TdaFamilyID;
    const aKey: AnsiString): Boolean;
  protected
   function pm_GetFreeIDHelper(aFamilyID: TdaFamilyID): TpgFreeIDHelper;
   function Get_UserID: TdaUserID;
   function Get_RegionID: TdaRegionID;
   function CheckLogin(const aLogin: AnsiString;
    const aPassword: AnsiString;
    IsRequireAdminRights: Boolean): TdaLoginError;
   procedure InitRegionFromIni(aDefaultRegion: TdaRegionID);
   function IsRegionExists(anID: TdaRegionID): Boolean;
   function GetRegionName(anID: TdaRegionID): AnsiString;
   procedure FillRegionDataList(aList: Tl3StringDataList;
    Caps: Boolean);
   function Get_BaseName: AnsiString;
   function Get_AdminRights: Boolean;
   function Get_CurUserIsServer: Boolean;
   procedure LoginAsServer;
   function GetFreeExtObjID(aFamily: TdaFamilyID): TdaDocID;
   function GetFreeExtDocID(aFamily: TdaFamilyID): TdaDocID;
   function LockAll: Boolean;
   procedure UnlockAll;
   function Get_BaseLanguage(aFamily: TdaFamilyID): TLanguageObj;
   function Get_TextBase(aFamily: TdaFamilyID): AnsiString;
   function GetHomePathName(aUserID: TdaUserID): TdaPathStr;
   function GetHomePath(aUserID: TdaUserID): TdaPathStr;
   function Get_CurHomePath: TdaPathStr;
   function Get_GlobalHomePath: TdaPathStr;
   function ConvertAliasPath(const CurPath: TdaPathStr): TdaPathStr;
   procedure SubscribeLongProcess(const aSubscriber: IdaLongProcessSubscriber);
   procedure UnSubscribeLongProcess(const aSubscriber: IdaLongProcessSubscriber);
   procedure SubscribeProgress(const aSubscriber: IdaProgressSubscriber);
   procedure UnSubscribeProgress(const aSubscriber: IdaProgressSubscriber);
   procedure Start;
   procedure Stop;
   function Get_Journal: IdaJournal;
   function Get_TableQueryFactory: IdaTableQueryFactory;
   function Get_DataConverter: IdaDataConverter;
   function Get_ImpersonatedUserID: TdaUserID;
   procedure BeginImpersonate(anUserID: TdaUserID);
   procedure EndImpersonate;
   function Get_UserManager: IdaUserManager;
   procedure RegisterFreeExtObjID(anID: TdaDocID);
   procedure RegisterFreeExtDocID(anID: TdaDocID);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aParams: TpgDataProviderParams;
    ForCheckLogin: Boolean;
    AllowClearLocks: Boolean;
    SetGlobalDataProvider: Boolean = True); reintroduce;
   class function Make(aParams: TpgDataProviderParams;
    ForCheckLogin: Boolean;
    AllowClearLocks: Boolean;
    SetGlobalDataProvider: Boolean = True): IdaDataProvider; reintroduce;
  private
   property FreeIDHelper[aFamilyID: TdaFamilyID]: TpgFreeIDHelper
    read pm_GetFreeIDHelper;
 end;//TpgDataProvider
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
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
 {$If Defined(l3Requires_m0)}
 , m2XLtLib
 {$IfEnd} // Defined(l3Requires_m0)
 , l3FileUtils
 , StrUtils
 , daSchemeConsts
;

function TpgDataProvider.pm_GetFreeIDHelper(aFamilyID: TdaFamilyID): TpgFreeIDHelper;
//#UC START# *56556F42021A_55D6DA9E00BFget_var*
//#UC END# *56556F42021A_55D6DA9E00BFget_var*
begin
//#UC START# *56556F42021A_55D6DA9E00BFget_impl*
 case aFamilyID of
  MainTblsFamily:
   begin
    if f_MainFreeIDHelper = nil then
     f_MainFreeIDHelper := TpgFreeIDHelper.Create(f_Connection, f_Factory, f_FunctionFactory, aFamilyID);
    Result := f_MainFreeIDHelper;
   end;
  CurrentFamily:
   begin
    if f_CurrentFreeIDHelper = nil then
     f_CurrentFreeIDHelper := TpgFreeIDHelper.Create(f_Connection, f_Factory, f_FunctionFactory, aFamilyID);
    Result := f_CurrentFreeIDHelper;
   end;
  else
  begin
   Result := nil;
   Assert(False);
  end; 
 end;
//#UC END# *56556F42021A_55D6DA9E00BFget_impl*
end;//TpgDataProvider.pm_GetFreeIDHelper

constructor TpgDataProvider.Create(aParams: TpgDataProviderParams;
 ForCheckLogin: Boolean;
 AllowClearLocks: Boolean;
 SetGlobalDataProvider: Boolean = True);
//#UC START# *55E00D5A0297_55D6DA9E00BF_var*
//#UC END# *55E00D5A0297_55D6DA9E00BF_var*
begin
//#UC START# *55E00D5A0297_55D6DA9E00BF_impl*
 inherited Create;
 f_Connection := TpgConnection.Create;
 f_DataConverter := TpgDataConverter.Make;
 f_ForCheckLogin := ForCheckLogin;
 f_LongProcessList := TdaLongProcessSubscriberList.Make;
 f_ProgressList := TdaProgressSubscriberList.Make;
 aParams.SetRefTo(f_Params);
// f_Helper := ThtDataSchemeHelper.Make(f_Params);
 f_AllowClearLocks := AllowClearLocks;
 f_ImpersonatedUserID := 0;
//#UC END# *55E00D5A0297_55D6DA9E00BF_impl*
end;//TpgDataProvider.Create

class function TpgDataProvider.Make(aParams: TpgDataProviderParams;
 ForCheckLogin: Boolean;
 AllowClearLocks: Boolean;
 SetGlobalDataProvider: Boolean = True): IdaDataProvider;
var
 l_Inst : TpgDataProvider;
begin
 l_Inst := Create(aParams, ForCheckLogin, AllowClearLocks, SetGlobalDataProvider);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TpgDataProvider.Make

procedure TpgDataProvider.ReadIniFile;
//#UC START# *55F7F8080115_55D6DA9E00BF_var*
var
 l_BaseIni: TCfgList;
//#UC END# *55F7F8080115_55D6DA9E00BF_var*
begin
//#UC START# *55F7F8080115_55D6DA9E00BF_impl*
 if f_RegionID = 0 then
  InitRegionFromIni(0);

 l_BaseIni := f_Params.MakeBaseIni;
 try
  l_BaseIni.Section:= 'Base';
  f_BaseName := l_BaseIni.ReadParamStrDef('Name', '');
 finally
  FreeAndNil(l_BaseIni);
 end;
//#UC END# *55F7F8080115_55D6DA9E00BF_impl*
end;//TpgDataProvider.ReadIniFile

function TpgDataProvider.RegionQuery: IdaTabledQuery;
//#UC START# *56448A910213_55D6DA9E00BF_var*
//#UC END# *56448A910213_55D6DA9E00BF_var*
begin
//#UC START# *56448A910213_55D6DA9E00BF_impl*
 if f_RegionQuery = nil then
 begin
  f_RegionQuery := f_Factory.MakeTabledQuery(TdaScheme.Instance.Table(da_mtRegions));
  f_RegionQuery.AddSelectField(f_Factory.MakeSelectField('', TdaScheme.Instance.Table(da_mtRegions).Field['Name']));
  f_RegionQuery.WhereCondition := f_Factory.MakeParamsCondition('', TdaScheme.Instance.Table(da_mtRegions).Field['ID'], da_copEqual, 'p_RegionID');
  f_RegionQuery.Prepare;
 end;
 Result := f_RegionQuery;
//#UC END# *56448A910213_55D6DA9E00BF_impl*
end;//TpgDataProvider.RegionQuery

function TpgDataProvider.RegionResultSet(anID: TdaRegionID): IdaResultSet;
//#UC START# *56448ABA03B4_55D6DA9E00BF_var*
//#UC END# *56448ABA03B4_55D6DA9E00BF_var*
begin
//#UC START# *56448ABA03B4_55D6DA9E00BF_impl*
 RegionQuery.Param['p_RegionID'].AsInteger := anID;
 Result := RegionQuery.OpenResultSet;
//#UC END# *56448ABA03B4_55D6DA9E00BF_impl*
end;//TpgDataProvider.RegionResultSet

function TpgDataProvider.FamilyHelper: TpgFamilyHelper;
//#UC START# *5645BD9C0153_55D6DA9E00BF_var*
//#UC END# *5645BD9C0153_55D6DA9E00BF_var*
begin
//#UC START# *5645BD9C0153_55D6DA9E00BF_impl*
 if f_FamilyHelper = nil then
  f_FamilyHelper := TpgFamilyHelper.Create(f_Factory);
 Result := f_FamilyHelper;
//#UC END# *5645BD9C0153_55D6DA9E00BF_impl*
end;//TpgDataProvider.FamilyHelper

function TpgDataProvider.GetAliasValue(const aAlias: AnsiString): AnsiString;
//#UC START# *56499CBF03D2_55D6DA9E00BF_var*
//#UC END# *56499CBF03D2_55D6DA9E00BF_var*
begin
//#UC START# *56499CBF03D2_55D6DA9E00BF_impl*
 Result := '';
 if f_Params.AliasesList.Count > 0 then
  Result := f_Params.AliasesList.Values[aAlias];

 if (Result = '') and  (aAlias = 'FamilyPath') then
  Result := f_Params.DocStoragePath;

 if (Result = '') then
  raise EPgError.Create('Путь не найден');
//#UC END# *56499CBF03D2_55D6DA9E00BF_impl*
end;//TpgDataProvider.GetAliasValue

function TpgDataProvider.Renum: TpgRenumerator;
//#UC START# *5652B5DD02FA_55D6DA9E00BF_var*
//#UC END# *5652B5DD02FA_55D6DA9E00BF_var*
begin
//#UC START# *5652B5DD02FA_55D6DA9E00BF_impl*
 if f_Renum = nil then
  f_Renum := TpgRenumerator.Create(f_Factory);
 Result := f_Renum;
//#UC END# *5652B5DD02FA_55D6DA9E00BF_impl*
end;//TpgDataProvider.Renum

function TpgDataProvider.ExtDocIDsFromRange: Boolean;
//#UC START# *56558A1600EA_55D6DA9E00BF_var*
//#UC END# *56558A1600EA_55D6DA9E00BF_var*
begin
//#UC START# *56558A1600EA_55D6DA9E00BF_impl*
 Result := CheckFreeResource(CurrentFamily, ftnDocIDExternal);
//#UC END# *56558A1600EA_55D6DA9E00BF_impl*
end;//TpgDataProvider.ExtDocIDsFromRange

function TpgDataProvider.CheckFreeResource(aFamilyID: TdaFamilyID;
 const aKey: AnsiString): Boolean;
//#UC START# *56558A4A01D1_55D6DA9E00BF_var*
//#UC END# *56558A4A01D1_55D6DA9E00BF_var*
begin
//#UC START# *56558A4A01D1_55D6DA9E00BF_impl*
 Result := FreeIDHelper[aFamilyID].AnyRangesPresent(aKey);
//#UC END# *56558A4A01D1_55D6DA9E00BF_impl*
end;//TpgDataProvider.CheckFreeResource

function TpgDataProvider.Get_UserID: TdaUserID;
//#UC START# *551A929E02D5_55D6DA9E00BFget_var*
//#UC END# *551A929E02D5_55D6DA9E00BFget_var*
begin
//#UC START# *551A929E02D5_55D6DA9E00BFget_impl*
 Result := f_Params.UserID;
//#UC END# *551A929E02D5_55D6DA9E00BFget_impl*
end;//TpgDataProvider.Get_UserID

function TpgDataProvider.Get_RegionID: TdaRegionID;
//#UC START# *551A933F02AE_55D6DA9E00BFget_var*
//#UC END# *551A933F02AE_55D6DA9E00BFget_var*
begin
//#UC START# *551A933F02AE_55D6DA9E00BFget_impl*
 Result := f_RegionID;
//#UC END# *551A933F02AE_55D6DA9E00BFget_impl*
end;//TpgDataProvider.Get_RegionID

function TpgDataProvider.CheckLogin(const aLogin: AnsiString;
 const aPassword: AnsiString;
 IsRequireAdminRights: Boolean): TdaLoginError;
//#UC START# *551BE2D701DE_55D6DA9E00BF_var*
var
 l_UserID: TdaUserID;
//#UC END# *551BE2D701DE_55D6DA9E00BF_var*
begin
//#UC START# *551BE2D701DE_55D6DA9E00BF_impl*
 try
  Result := Get_UserManager.CheckPassword(aLogin, aPassword, IsRequireAdminRights, l_UserID);
  if Result = da_leOk then
   f_Params.UserID := l_UserID;
 except
  on E: Exception do
  begin
   l3System.Exception2Log(E);
   Result := da_leSQLError;
  end;
 end;

 (* l_Result:= GlobalHtServer.xxxCheckArchivariusPassword(aLogin, aPassword, IsRequireAdminRights);
 f_Params.UserID := GlobalHTServer.xxxUserID;
 if l_Result then
  Result := da_leOk
 else
 begin
  if IsRequireAdminRights and GlobalHtServer.xxxCheckArchivariusPassword(aLogin, aPassword, False) then
   Result := da_leInsufficientRights
  else
   Result := da_leUserParamsWrong;
 end;*)
//#UC END# *551BE2D701DE_55D6DA9E00BF_impl*
end;//TpgDataProvider.CheckLogin

procedure TpgDataProvider.InitRegionFromIni(aDefaultRegion: TdaRegionID);
//#UC START# *551D25D00024_55D6DA9E00BF_var*
var
 l_BaseIni: TCfgList;
//#UC END# *551D25D00024_55D6DA9E00BF_var*
begin
//#UC START# *551D25D00024_55D6DA9E00BF_impl*
 Assert(Assigned(f_Params));
 l_BaseIni := f_Params.MakeBaseIni;
 try
  l_BaseIni.Section:= 'Tables';
  f_RegionID := l_BaseIni.ReadParamIntDef('Region', aDefaultRegion);
 finally
  FreeAndNil(l_BaseIni);
 end;
//#UC END# *551D25D00024_55D6DA9E00BF_impl*
end;//TpgDataProvider.InitRegionFromIni

function TpgDataProvider.IsRegionExists(anID: TdaRegionID): Boolean;
//#UC START# *551D2C300060_55D6DA9E00BF_var*
//#UC END# *551D2C300060_55D6DA9E00BF_var*
begin
//#UC START# *551D2C300060_55D6DA9E00BF_impl*
 Result := False;
 Assert(False);
// !!! Needs to be implemented !!!
//#UC END# *551D2C300060_55D6DA9E00BF_impl*
end;//TpgDataProvider.IsRegionExists

function TpgDataProvider.GetRegionName(anID: TdaRegionID): AnsiString;
//#UC START# *551D2C3603E0_55D6DA9E00BF_var*
//#UC END# *551D2C3603E0_55D6DA9E00BF_var*
begin
//#UC START# *551D2C3603E0_55D6DA9E00BF_impl*
 Result := '';
 Assert(False);
// !!! Needs to be implemented !!!
//#UC END# *551D2C3603E0_55D6DA9E00BF_impl*
end;//TpgDataProvider.GetRegionName

procedure TpgDataProvider.FillRegionDataList(aList: Tl3StringDataList;
 Caps: Boolean);
//#UC START# *551D35040362_55D6DA9E00BF_var*
//#UC END# *551D35040362_55D6DA9E00BF_var*
begin
//#UC START# *551D35040362_55D6DA9E00BF_impl*
 Assert(False);
// !!! Needs to be implemented !!!
//#UC END# *551D35040362_55D6DA9E00BF_impl*
end;//TpgDataProvider.FillRegionDataList

function TpgDataProvider.Get_BaseName: AnsiString;
//#UC START# *551E636F0314_55D6DA9E00BFget_var*
//#UC END# *551E636F0314_55D6DA9E00BFget_var*
begin
//#UC START# *551E636F0314_55D6DA9E00BFget_impl*
 Result := f_BaseName;
//#UC END# *551E636F0314_55D6DA9E00BFget_impl*
end;//TpgDataProvider.Get_BaseName

function TpgDataProvider.Get_AdminRights: Boolean;
//#UC START# *551E6389027F_55D6DA9E00BFget_var*
//#UC END# *551E6389027F_55D6DA9E00BFget_var*
begin
//#UC START# *551E6389027F_55D6DA9E00BFget_impl*
 Result := f_RequireAdminRights;
//#UC END# *551E6389027F_55D6DA9E00BFget_impl*
end;//TpgDataProvider.Get_AdminRights

function TpgDataProvider.Get_CurUserIsServer: Boolean;
//#UC START# *551E63A1025A_55D6DA9E00BFget_var*
//#UC END# *551E63A1025A_55D6DA9E00BFget_var*
begin
//#UC START# *551E63A1025A_55D6DA9E00BFget_impl*
 Result := UserIsService(Get_UserID);
//#UC END# *551E63A1025A_55D6DA9E00BFget_impl*
end;//TpgDataProvider.Get_CurUserIsServer

procedure TpgDataProvider.LoginAsServer;
//#UC START# *551E63B5008C_55D6DA9E00BF_var*
//#UC END# *551E63B5008C_55D6DA9E00BF_var*
begin
//#UC START# *551E63B5008C_55D6DA9E00BF_impl*
 f_RequireAdminRights := True;
 f_Params.UserID := usServerService;
//#UC END# *551E63B5008C_55D6DA9E00BF_impl*
end;//TpgDataProvider.LoginAsServer

function TpgDataProvider.GetFreeExtObjID(aFamily: TdaFamilyID): TdaDocID;
//#UC START# *551E7E1501D8_55D6DA9E00BF_var*
//#UC END# *551E7E1501D8_55D6DA9E00BF_var*
begin
//#UC START# *551E7E1501D8_55D6DA9E00BF_impl*
 Result := 0;
 Assert(False);
// !!! Needs to be implemented !!!
//#UC END# *551E7E1501D8_55D6DA9E00BF_impl*
end;//TpgDataProvider.GetFreeExtObjID

function TpgDataProvider.GetFreeExtDocID(aFamily: TdaFamilyID): TdaDocID;
//#UC START# *551E7E35030B_55D6DA9E00BF_var*
//#UC END# *551E7E35030B_55D6DA9E00BF_var*
begin
//#UC START# *551E7E35030B_55D6DA9E00BF_impl*
 Result := 0;
 Assert(False);
// !!! Needs to be implemented !!!
//#UC END# *551E7E35030B_55D6DA9E00BF_impl*
end;//TpgDataProvider.GetFreeExtDocID

function TpgDataProvider.LockAll: Boolean;
//#UC START# *5522326E0355_55D6DA9E00BF_var*
//#UC END# *5522326E0355_55D6DA9E00BF_var*
begin
//#UC START# *5522326E0355_55D6DA9E00BF_impl*
 Result := False;
 Assert(False);
// !!! Needs to be implemented !!!
//#UC END# *5522326E0355_55D6DA9E00BF_impl*
end;//TpgDataProvider.LockAll

procedure TpgDataProvider.UnlockAll;
//#UC START# *5522327B01D9_55D6DA9E00BF_var*
//#UC END# *5522327B01D9_55D6DA9E00BF_var*
begin
//#UC START# *5522327B01D9_55D6DA9E00BF_impl*
 Assert(False);
// !!! Needs to be implemented !!!
//#UC END# *5522327B01D9_55D6DA9E00BF_impl*
end;//TpgDataProvider.UnlockAll

function TpgDataProvider.Get_BaseLanguage(aFamily: TdaFamilyID): TLanguageObj;
//#UC START# *5522496C00CD_55D6DA9E00BFget_var*
var
 l_BaseIni: TCfgList;
//#UC END# *5522496C00CD_55D6DA9E00BFget_var*
begin
//#UC START# *5522496C00CD_55D6DA9E00BFget_impl*

 if f_BaseLang = nil then
 begin
  f_BaseLang:= TLanguageObj.Create;
  l_BaseIni := f_Params.MakeBaseIni;
  try
   l_BaseIni.Section:= 'Settings';
   f_BaseLang.LanguageID := l_BaseIni.ReadParamIntDef('Language', -1);
  finally
   FreeAndNil(l_BaseIni);
  end;
 end;
 Result:= f_BaseLang;
//#UC END# *5522496C00CD_55D6DA9E00BFget_impl*
end;//TpgDataProvider.Get_BaseLanguage

function TpgDataProvider.Get_TextBase(aFamily: TdaFamilyID): AnsiString;
//#UC START# *55226E4B01E0_55D6DA9E00BFget_var*
//#UC END# *55226E4B01E0_55D6DA9E00BFget_var*
begin
//#UC START# *55226E4B01E0_55D6DA9E00BFget_impl*
 Result := '';
 Assert(False);
// !!! Needs to be implemented !!!
//#UC END# *55226E4B01E0_55D6DA9E00BFget_impl*
end;//TpgDataProvider.Get_TextBase

function TpgDataProvider.GetHomePathName(aUserID: TdaUserID): TdaPathStr;
//#UC START# *552391490184_55D6DA9E00BF_var*
//#UC END# *552391490184_55D6DA9E00BF_var*
begin
//#UC START# *552391490184_55D6DA9E00BF_impl*
 Result := '';
 Assert(False);
// !!! Needs to be implemented !!!
//#UC END# *552391490184_55D6DA9E00BF_impl*
end;//TpgDataProvider.GetHomePathName

function TpgDataProvider.GetHomePath(aUserID: TdaUserID): TdaPathStr;
//#UC START# *552391830231_55D6DA9E00BF_var*
//#UC END# *552391830231_55D6DA9E00BF_var*
begin
//#UC START# *552391830231_55D6DA9E00BF_impl*
 Result := '';
 Assert(False);
// !!! Needs to be implemented !!!
//#UC END# *552391830231_55D6DA9E00BF_impl*
end;//TpgDataProvider.GetHomePath

function TpgDataProvider.Get_CurHomePath: TdaPathStr;
//#UC START# *5523983D0254_55D6DA9E00BFget_var*
//#UC END# *5523983D0254_55D6DA9E00BFget_var*
begin
//#UC START# *5523983D0254_55D6DA9E00BFget_impl*
 Result := '';
 Assert(False);
// !!! Needs to be implemented !!!
//#UC END# *5523983D0254_55D6DA9E00BFget_impl*
end;//TpgDataProvider.Get_CurHomePath

function TpgDataProvider.Get_GlobalHomePath: TdaPathStr;
//#UC START# *5523984A0349_55D6DA9E00BFget_var*
//#UC END# *5523984A0349_55D6DA9E00BFget_var*
begin
//#UC START# *5523984A0349_55D6DA9E00BFget_impl*
 Result := '';
 Assert(False);
// !!! Needs to be implemented !!!
//#UC END# *5523984A0349_55D6DA9E00BFget_impl*
end;//TpgDataProvider.Get_GlobalHomePath

function TpgDataProvider.ConvertAliasPath(const CurPath: TdaPathStr): TdaPathStr;
//#UC START# *5523BD100174_55D6DA9E00BF_var*
//#UC END# *5523BD100174_55D6DA9E00BF_var*
begin
//#UC START# *5523BD100174_55D6DA9E00BF_impl*
 Result := '';
 Assert(False);
// !!! Needs to be implemented !!!
//#UC END# *5523BD100174_55D6DA9E00BF_impl*
end;//TpgDataProvider.ConvertAliasPath

procedure TpgDataProvider.SubscribeLongProcess(const aSubscriber: IdaLongProcessSubscriber);
//#UC START# *5524D30D007F_55D6DA9E00BF_var*
//#UC END# *5524D30D007F_55D6DA9E00BF_var*
begin
//#UC START# *5524D30D007F_55D6DA9E00BF_impl*
 if f_LongProcessList.IndexOf(aSubscriber) = -1 then
  f_LongProcessList.Add(aSubscriber);
//#UC END# *5524D30D007F_55D6DA9E00BF_impl*
end;//TpgDataProvider.SubscribeLongProcess

procedure TpgDataProvider.UnSubscribeLongProcess(const aSubscriber: IdaLongProcessSubscriber);
//#UC START# *5524D33101AC_55D6DA9E00BF_var*
//#UC END# *5524D33101AC_55D6DA9E00BF_var*
begin
//#UC START# *5524D33101AC_55D6DA9E00BF_impl*
 if Self <> nil then
  f_LongProcessList.Remove(aSubscriber);
//#UC END# *5524D33101AC_55D6DA9E00BF_impl*
end;//TpgDataProvider.UnSubscribeLongProcess

procedure TpgDataProvider.SubscribeProgress(const aSubscriber: IdaProgressSubscriber);
//#UC START# *552514320149_55D6DA9E00BF_var*
//#UC END# *552514320149_55D6DA9E00BF_var*
begin
//#UC START# *552514320149_55D6DA9E00BF_impl*
 if f_ProgressList.IndexOf(aSubscriber) = -1 then
  f_ProgressList.Add(aSubscriber);
//#UC END# *552514320149_55D6DA9E00BF_impl*
end;//TpgDataProvider.SubscribeProgress

procedure TpgDataProvider.UnSubscribeProgress(const aSubscriber: IdaProgressSubscriber);
//#UC START# *5525144701F3_55D6DA9E00BF_var*
//#UC END# *5525144701F3_55D6DA9E00BF_var*
begin
//#UC START# *5525144701F3_55D6DA9E00BF_impl*
 if Self <> nil then
  f_ProgressList.Remove(aSubscriber);
//#UC END# *5525144701F3_55D6DA9E00BF_impl*
end;//TpgDataProvider.UnSubscribeProgress

procedure TpgDataProvider.Start;
//#UC START# *5526537A00CE_55D6DA9E00BF_var*
//#UC END# *5526537A00CE_55D6DA9E00BF_var*
begin
//#UC START# *5526537A00CE_55D6DA9E00BF_impl*
 if f_IsStarted then
  Exit;
 Assert(GlobalDataProvider = nil);
 if GlobalDataProvider = nil then
 begin
  SetGlobalDataProvider(Self);
  f_NeedClearGlobalDataProvider := True;
 end;
 try
  f_Connection.Connect(f_Params);
 except
  Stop;
  raise;
 end;
 ReadIniFile;
 if not f_ForCheckLogin then
  Get_Journal.UserID := f_Params.UserID;
 f_IsStarted := True;
//#UC END# *5526537A00CE_55D6DA9E00BF_impl*
end;//TpgDataProvider.Start

procedure TpgDataProvider.Stop;
//#UC START# *5526538202A5_55D6DA9E00BF_var*
//#UC END# *5526538202A5_55D6DA9E00BF_var*
begin
//#UC START# *5526538202A5_55D6DA9E00BF_impl*
 if not f_IsStarted then
  Exit;
 if f_NeedClearGlobalDataProvider then
  SetGlobalDataProvider(nil);
 if Assigned(f_Journal) then
  f_Journal.SessionDone;
 f_Journal := nil;
 if f_Connection.Connected then
  f_Connection.Disconnect;
 FreeAndNil(f_BaseLang);
//#UC END# *5526538202A5_55D6DA9E00BF_impl*
end;//TpgDataProvider.Stop

function TpgDataProvider.Get_Journal: IdaJournal;
//#UC START# *55409258013F_55D6DA9E00BFget_var*
//#UC END# *55409258013F_55D6DA9E00BFget_var*
begin
//#UC START# *55409258013F_55D6DA9E00BFget_impl*
 if f_Journal = nil then
 begin
  f_Journal := TpgJournal.Make(Get_TableQueryFactory);
  f_Journal.UserID := Get_UserID;
  f_UserManager := nil; // ???
 end;
 Result := f_Journal;
//#UC END# *55409258013F_55D6DA9E00BFget_impl*
end;//TpgDataProvider.Get_Journal

function TpgDataProvider.Get_TableQueryFactory: IdaTableQueryFactory;
//#UC START# *554C7A3002BF_55D6DA9E00BFget_var*
//#UC END# *554C7A3002BF_55D6DA9E00BFget_var*
begin
//#UC START# *554C7A3002BF_55D6DA9E00BFget_impl*
 if f_Factory = nil then
  f_Factory := TpgTableQueryFactory.Make(f_DataConverter, f_Connection);
 Result := f_Factory;
//#UC END# *554C7A3002BF_55D6DA9E00BFget_impl*
end;//TpgDataProvider.Get_TableQueryFactory

function TpgDataProvider.Get_DataConverter: IdaDataConverter;
//#UC START# *555995CF0292_55D6DA9E00BFget_var*
//#UC END# *555995CF0292_55D6DA9E00BFget_var*
begin
//#UC START# *555995CF0292_55D6DA9E00BFget_impl*
 Result := f_DataConverter;
//#UC END# *555995CF0292_55D6DA9E00BFget_impl*
end;//TpgDataProvider.Get_DataConverter

function TpgDataProvider.Get_ImpersonatedUserID: TdaUserID;
//#UC START# *561795EA02BF_55D6DA9E00BFget_var*
//#UC END# *561795EA02BF_55D6DA9E00BFget_var*
begin
//#UC START# *561795EA02BF_55D6DA9E00BFget_impl*
 if f_ImpersonatedUserID = usNone then
  Result := Get_UserID
 else
  Result := f_ImpersonatedUserID;
//#UC END# *561795EA02BF_55D6DA9E00BFget_impl*
end;//TpgDataProvider.Get_ImpersonatedUserID

procedure TpgDataProvider.BeginImpersonate(anUserID: TdaUserID);
//#UC START# *561796070253_55D6DA9E00BF_var*
//#UC END# *561796070253_55D6DA9E00BF_var*
begin
//#UC START# *561796070253_55D6DA9E00BF_impl*
 if f_ImpersonatedUserID <> usNone then
  l3System.Msg2Log('ALERT ImpersonateUser');
 f_ImpersonatedUserID := anUserID;
//#UC END# *561796070253_55D6DA9E00BF_impl*
end;//TpgDataProvider.BeginImpersonate

procedure TpgDataProvider.EndImpersonate;
//#UC START# *5617961F0105_55D6DA9E00BF_var*
//#UC END# *5617961F0105_55D6DA9E00BF_var*
begin
//#UC START# *5617961F0105_55D6DA9E00BF_impl*
 f_ImpersonatedUserID := usNone;
//#UC END# *5617961F0105_55D6DA9E00BF_impl*
end;//TpgDataProvider.EndImpersonate

function TpgDataProvider.Get_UserManager: IdaUserManager;
//#UC START# *5628D25600E6_55D6DA9E00BFget_var*
//#UC END# *5628D25600E6_55D6DA9E00BFget_var*
begin
//#UC START# *5628D25600E6_55D6DA9E00BFget_impl*
 if f_UserManager = nil then
  f_UserManager := TpgUserManager.Make(Get_TableQueryFactory);
 Result := f_UserManager;
//#UC END# *5628D25600E6_55D6DA9E00BFget_impl*
end;//TpgDataProvider.Get_UserManager

procedure TpgDataProvider.RegisterFreeExtObjID(anID: TdaDocID);
//#UC START# *56BC642200D0_55D6DA9E00BF_var*
//#UC END# *56BC642200D0_55D6DA9E00BF_var*
begin
//#UC START# *56BC642200D0_55D6DA9E00BF_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *56BC642200D0_55D6DA9E00BF_impl*
end;//TpgDataProvider.RegisterFreeExtObjID

procedure TpgDataProvider.RegisterFreeExtDocID(anID: TdaDocID);
//#UC START# *56BC6437030F_55D6DA9E00BF_var*
//#UC END# *56BC6437030F_55D6DA9E00BF_var*
begin
//#UC START# *56BC6437030F_55D6DA9E00BF_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *56BC6437030F_55D6DA9E00BF_impl*
end;//TpgDataProvider.RegisterFreeExtDocID

procedure TpgDataProvider.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55D6DA9E00BF_var*
//#UC END# *479731C50290_55D6DA9E00BF_var*
begin
//#UC START# *479731C50290_55D6DA9E00BF_impl*
 Assert(not f_Connection.Connected);

 FreeAndNil(f_BaseLang);
 FreeAndNil(f_Params);
 FreeAndNil(f_LongProcessList);
 FreeAndNil(f_ProgressList);
 f_Factory := nil;
 f_UserManager := nil;
 f_Journal := nil;
 f_DataConverter := nil;
// f_Helper := nil;
// !!! Needs to be implemented !!!
 FreeANdNil(f_Connection);
 inherited;
//#UC END# *479731C50290_55D6DA9E00BF_impl*
end;//TpgDataProvider.Cleanup
{$IfEnd} // Defined(UsePostgres)

end.

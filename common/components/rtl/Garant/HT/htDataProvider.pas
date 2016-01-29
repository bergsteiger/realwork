unit htDataProvider;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "HT"
// Модуль: "w:/common/components/rtl/Garant/HT/htDataProvider.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::HT::Provider::ThtDataProvider
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\HT\htDefineDA.inc}

interface

uses
  l3Types,
  l3ProtoObject,
  daTypes,
  daInterfaces,
  htDataProviderParams,
  htInterfaces,
  daLongProcessSubscriberList,
  daProgressSubscriberList,
  l3DatLst,
  l3Languages
  ;

type
 ThtDataProvider = class(Tl3ProtoObject, IdaDataProvider)
 private
 // private fields
   f_Params : ThtDataProviderParams;
   f_NeedClearGlobalDataProvider : Boolean;
   f_LongProcessList : TdaLongProcessSubscriberList;
   f_ProgressList : TdaProgressSubscriberList;
   f_IsStarted : Boolean;
   f_ForCheckLogin : Boolean;
   f_Journal : IdaJournal;
   f_Factory : IdaTableQueryFactory;
   f_DataConverter : IhtDataConverter;
   f_Helper : IhtDataSchemeHelper;
   f_AllowClearLocks : Boolean;
   f_ImpersonatedUserID : TdaUserID;
   f_UserManager : IdaUserManager;
 private
 // private methods
   function DoLongProcessNotify(aState: TdaProcessState): Boolean;
   procedure DoProgressNotify(aState: Byte;
     aValue: Integer;
     const aMsg: AnsiString = '');
 protected
 // realized methods
   function Get_UserID: TdaUserID;
   function Get_RegionID: TdaRegionID;
   function CheckLogin(const aLogin: AnsiString;
    const aPassword: AnsiString;
    IsRequireAdminRights: Boolean): TdaLoginError;
   procedure InitRegionFromIni(aDefaultRegion: TdaRegionID);
   function IsRegionExists(aID: TdaRegionID): Boolean;
   function GetRegionName(aID: TdaRegionID): AnsiString;
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
     {* Сигнатура метода Start }
   procedure Stop;
     {* Сигнатура метода Stop }
   function Get_Journal: IdaJournal;
   function Get_TableQueryFactory: IdaTableQueryFactory;
   function Get_DataConverter: IdaDataConverter;
   function Get_ImpersonatedUserID: TdaUserID;
   procedure BeginImpersonate(anUserID: TdaUserID);
   procedure EndImpersonate;
   function Get_UserManager: IdaUserManager;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(aParams: ThtDataProviderParams;
     ForCheckLogin: Boolean;
     AllowClearLocks: Boolean); reintroduce;
   class function Make(aParams: ThtDataProviderParams;
     ForCheckLogin: Boolean;
     AllowClearLocks: Boolean): IdaDataProvider; reintroduce;
     {* Сигнатура фабрики ThtDataProvider.Make }
 end;//ThtDataProvider

implementation

uses
  SysUtils
  {$If not defined(Nemesis)}
  ,
  dt_Serv
  {$IfEnd} //not Nemesis
  ,
  daDataProvider,
  htJournal,
  htTableQueryFactory,
  htDataConverter,
  htDataSchemeHelper,
  l3Base,
  htUserManager
  ;

// start class ThtDataProvider

function ThtDataProvider.DoLongProcessNotify(aState: TdaProcessState): Boolean;
//#UC START# *5524D2E200C4_5519351D01BE_var*
var
 l_IDX: Integer;
//#UC END# *5524D2E200C4_5519351D01BE_var*
begin
//#UC START# *5524D2E200C4_5519351D01BE_impl*
 for l_IDX := 0 to f_LongProcessList.Count - 1 do
  f_LongProcessList[l_IDX].DoLongProcessNotify(aState);
//#UC END# *5524D2E200C4_5519351D01BE_impl*
end;//ThtDataProvider.DoLongProcessNotify

procedure ThtDataProvider.DoProgressNotify(aState: Byte;
  aValue: Integer;
  const aMsg: AnsiString = '');
//#UC START# *552514C803BB_5519351D01BE_var*
var
 l_IDX: Integer;
//#UC END# *552514C803BB_5519351D01BE_var*
begin
//#UC START# *552514C803BB_5519351D01BE_impl*
 for l_IDX := 0 to f_ProgressList.Count - 1 do
  f_ProgressList[l_IDX].DoProgressNotify(aState, aValue, aMsg);
//#UC END# *552514C803BB_5519351D01BE_impl*
end;//ThtDataProvider.DoProgressNotify

constructor ThtDataProvider.Create(aParams: ThtDataProviderParams;
  ForCheckLogin: Boolean;
  AllowClearLocks: Boolean);
//#UC START# *551938260196_5519351D01BE_var*
//#UC END# *551938260196_5519351D01BE_var*
begin
//#UC START# *551938260196_5519351D01BE_impl*
 inherited Create;
 f_DataConverter := ThtDataConverter.Make;
 f_ForCheckLogin := ForCheckLogin;
 f_LongProcessList := TdaLongProcessSubscriberList.Make;
 f_ProgressList := TdaProgressSubscriberList.Make;
 aParams.SetRefTo(f_Params);
 f_Helper := ThtDataSchemeHelper.Make(f_Params);
 f_AllowClearLocks := AllowClearLocks;
 f_ImpersonatedUserID := 0;
//#UC END# *551938260196_5519351D01BE_impl*
end;//ThtDataProvider.Create

class function ThtDataProvider.Make(aParams: ThtDataProviderParams;
  ForCheckLogin: Boolean;
  AllowClearLocks: Boolean): IdaDataProvider;
var
 l_Inst : ThtDataProvider;
begin
 l_Inst := Create(aParams, ForCheckLogin, AllowClearLocks);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function ThtDataProvider.Get_UserID: TdaUserID;
//#UC START# *551A929E02D5_5519351D01BEget_var*
//#UC END# *551A929E02D5_5519351D01BEget_var*
begin
//#UC START# *551A929E02D5_5519351D01BEget_impl*
 Result := GlobalHTServer.xxxUserID;
//#UC END# *551A929E02D5_5519351D01BEget_impl*
end;//ThtDataProvider.Get_UserID

function ThtDataProvider.Get_RegionID: TdaRegionID;
//#UC START# *551A933F02AE_5519351D01BEget_var*
//#UC END# *551A933F02AE_5519351D01BEget_var*
begin
//#UC START# *551A933F02AE_5519351D01BEget_impl*
 Result := GlobalHTServer.xxxRegionID;
//#UC END# *551A933F02AE_5519351D01BEget_impl*
end;//ThtDataProvider.Get_RegionID

function ThtDataProvider.CheckLogin(const aLogin: AnsiString;
  const aPassword: AnsiString;
  IsRequireAdminRights: Boolean): TdaLoginError;
//#UC START# *551BE2D701DE_5519351D01BE_var*
var
 l_UserID: TdaUserID;
//#UC END# *551BE2D701DE_5519351D01BE_var*
begin
//#UC START# *551BE2D701DE_5519351D01BE_impl*
 Result := Get_UserManager.CheckPassword(aLogin, aPassword, IsRequireAdminRights, l_UserID);
 if Result = da_leOk then
  f_Params.UserID := l_UserID;
//#UC END# *551BE2D701DE_5519351D01BE_impl*
end;//ThtDataProvider.CheckLogin

procedure ThtDataProvider.InitRegionFromIni(aDefaultRegion: TdaRegionID);
//#UC START# *551D25D00024_5519351D01BE_var*
//#UC END# *551D25D00024_5519351D01BE_var*
begin
//#UC START# *551D25D00024_5519351D01BE_impl*
 GlobalHTServer.xxxReadRegionFromIni(aDefaultRegion);
//#UC END# *551D25D00024_5519351D01BE_impl*
end;//ThtDataProvider.InitRegionFromIni

function ThtDataProvider.IsRegionExists(aID: TdaRegionID): Boolean;
//#UC START# *551D2C300060_5519351D01BE_var*
//#UC END# *551D2C300060_5519351D01BE_var*
begin
//#UC START# *551D2C300060_5519351D01BE_impl*
 Result := GlobalHTServer.xxxIsRegionExists(aID);
//#UC END# *551D2C300060_5519351D01BE_impl*
end;//ThtDataProvider.IsRegionExists

function ThtDataProvider.GetRegionName(aID: TdaRegionID): AnsiString;
//#UC START# *551D2C3603E0_5519351D01BE_var*
//#UC END# *551D2C3603E0_5519351D01BE_var*
begin
//#UC START# *551D2C3603E0_5519351D01BE_impl*
 Result := GlobalHTServer.xxxGetRegionName(aID);
//#UC END# *551D2C3603E0_5519351D01BE_impl*
end;//ThtDataProvider.GetRegionName

procedure ThtDataProvider.FillRegionDataList(aList: Tl3StringDataList;
  Caps: Boolean);
//#UC START# *551D35040362_5519351D01BE_var*
//#UC END# *551D35040362_5519351D01BE_var*
begin
//#UC START# *551D35040362_5519351D01BE_impl*
 GlobalHTServer.xxxRegionTbl.GetDictList(aList, Caps);
//#UC END# *551D35040362_5519351D01BE_impl*
end;//ThtDataProvider.FillRegionDataList

function ThtDataProvider.Get_BaseName: AnsiString;
//#UC START# *551E636F0314_5519351D01BEget_var*
//#UC END# *551E636F0314_5519351D01BEget_var*
begin
//#UC START# *551E636F0314_5519351D01BEget_impl*
 Result := GlobalHTServer.xxxBaseName;
//#UC END# *551E636F0314_5519351D01BEget_impl*
end;//ThtDataProvider.Get_BaseName

function ThtDataProvider.Get_AdminRights: Boolean;
//#UC START# *551E6389027F_5519351D01BEget_var*
//#UC END# *551E6389027F_5519351D01BEget_var*
begin
//#UC START# *551E6389027F_5519351D01BEget_impl*
 Result := GlobalHTServer.xxxAdminRights;
//#UC END# *551E6389027F_5519351D01BEget_impl*
end;//ThtDataProvider.Get_AdminRights

function ThtDataProvider.Get_CurUserIsServer: Boolean;
//#UC START# *551E63A1025A_5519351D01BEget_var*
//#UC END# *551E63A1025A_5519351D01BEget_var*
begin
//#UC START# *551E63A1025A_5519351D01BEget_impl*
 Result := GlobalHTServer.xxxCurUserIsServer;
//#UC END# *551E63A1025A_5519351D01BEget_impl*
end;//ThtDataProvider.Get_CurUserIsServer

procedure ThtDataProvider.LoginAsServer;
//#UC START# *551E63B5008C_5519351D01BE_var*
//#UC END# *551E63B5008C_5519351D01BE_var*
begin
//#UC START# *551E63B5008C_5519351D01BE_impl*
 GlobalHTServer.xxxLoginAsServer;
//#UC END# *551E63B5008C_5519351D01BE_impl*
end;//ThtDataProvider.LoginAsServer

function ThtDataProvider.GetFreeExtObjID(aFamily: TdaFamilyID): TdaDocID;
//#UC START# *551E7E1501D8_5519351D01BE_var*
//#UC END# *551E7E1501D8_5519351D01BE_var*
begin
//#UC START# *551E7E1501D8_5519351D01BE_impl*
 Result := GlobalHTServer.xxxGetFreeExtObjID(aFamily);
//#UC END# *551E7E1501D8_5519351D01BE_impl*
end;//ThtDataProvider.GetFreeExtObjID

function ThtDataProvider.GetFreeExtDocID(aFamily: TdaFamilyID): TdaDocID;
//#UC START# *551E7E35030B_5519351D01BE_var*
//#UC END# *551E7E35030B_5519351D01BE_var*
begin
//#UC START# *551E7E35030B_5519351D01BE_impl*
 Result := GlobalHTServer.xxxGetFreeExtDocID(aFamily);
//#UC END# *551E7E35030B_5519351D01BE_impl*
end;//ThtDataProvider.GetFreeExtDocID

function ThtDataProvider.LockAll: Boolean;
//#UC START# *5522326E0355_5519351D01BE_var*
//#UC END# *5522326E0355_5519351D01BE_var*
begin
//#UC START# *5522326E0355_5519351D01BE_impl*
 Result := GlobalHTServer.xxxLockAll;
//#UC END# *5522326E0355_5519351D01BE_impl*
end;//ThtDataProvider.LockAll

procedure ThtDataProvider.UnlockAll;
//#UC START# *5522327B01D9_5519351D01BE_var*
//#UC END# *5522327B01D9_5519351D01BE_var*
begin
//#UC START# *5522327B01D9_5519351D01BE_impl*
 GlobalHTServer.xxxUnlockAll;
//#UC END# *5522327B01D9_5519351D01BE_impl*
end;//ThtDataProvider.UnlockAll

function ThtDataProvider.Get_BaseLanguage(aFamily: TdaFamilyID): TLanguageObj;
//#UC START# *5522496C00CD_5519351D01BEget_var*
//#UC END# *5522496C00CD_5519351D01BEget_var*
begin
//#UC START# *5522496C00CD_5519351D01BEget_impl*
 Result := GlobalHTServer.xxxBaseLanguage[aFamily];
//#UC END# *5522496C00CD_5519351D01BEget_impl*
end;//ThtDataProvider.Get_BaseLanguage

function ThtDataProvider.Get_TextBase(aFamily: TdaFamilyID): AnsiString;
//#UC START# *55226E4B01E0_5519351D01BEget_var*
//#UC END# *55226E4B01E0_5519351D01BEget_var*
begin
//#UC START# *55226E4B01E0_5519351D01BEget_impl*
 Result := GlobalHTServer.xxxTextBase[aFamily];
//#UC END# *55226E4B01E0_5519351D01BEget_impl*
end;//ThtDataProvider.Get_TextBase

function ThtDataProvider.GetHomePathName(aUserID: TdaUserID): TdaPathStr;
//#UC START# *552391490184_5519351D01BE_var*
//#UC END# *552391490184_5519351D01BE_var*
begin
//#UC START# *552391490184_5519351D01BE_impl*
 Result := GlobalHTServer.xxxGetHomePathName(aUserID);
//#UC END# *552391490184_5519351D01BE_impl*
end;//ThtDataProvider.GetHomePathName

function ThtDataProvider.GetHomePath(aUserID: TdaUserID): TdaPathStr;
//#UC START# *552391830231_5519351D01BE_var*
//#UC END# *552391830231_5519351D01BE_var*
begin
//#UC START# *552391830231_5519351D01BE_impl*
 Result := GlobalHTServer.xxxGetHomePath(aUserID);
//#UC END# *552391830231_5519351D01BE_impl*
end;//ThtDataProvider.GetHomePath

function ThtDataProvider.Get_CurHomePath: TdaPathStr;
//#UC START# *5523983D0254_5519351D01BEget_var*
//#UC END# *5523983D0254_5519351D01BEget_var*
begin
//#UC START# *5523983D0254_5519351D01BEget_impl*
 Result := GlobalHTServer.xxxCurHomePath;
//#UC END# *5523983D0254_5519351D01BEget_impl*
end;//ThtDataProvider.Get_CurHomePath

function ThtDataProvider.Get_GlobalHomePath: TdaPathStr;
//#UC START# *5523984A0349_5519351D01BEget_var*
//#UC END# *5523984A0349_5519351D01BEget_var*
begin
//#UC START# *5523984A0349_5519351D01BEget_impl*
 Result := GlobalHTServer.xxxGlobalHomePath;
//#UC END# *5523984A0349_5519351D01BEget_impl*
end;//ThtDataProvider.Get_GlobalHomePath

function ThtDataProvider.ConvertAliasPath(const CurPath: TdaPathStr): TdaPathStr;
//#UC START# *5523BD100174_5519351D01BE_var*
//#UC END# *5523BD100174_5519351D01BE_var*
begin
//#UC START# *5523BD100174_5519351D01BE_impl*
 Result := GlobalHTServer.xxxConvertAliasPath(CurPath);
//#UC END# *5523BD100174_5519351D01BE_impl*
end;//ThtDataProvider.ConvertAliasPath

procedure ThtDataProvider.SubscribeLongProcess(const aSubscriber: IdaLongProcessSubscriber);
//#UC START# *5524D30D007F_5519351D01BE_var*
//#UC END# *5524D30D007F_5519351D01BE_var*
begin
//#UC START# *5524D30D007F_5519351D01BE_impl*
 if f_LongProcessList.IndexOf(aSubscriber) = -1 then
  f_LongProcessList.Add(aSubscriber);
//#UC END# *5524D30D007F_5519351D01BE_impl*
end;//ThtDataProvider.SubscribeLongProcess

procedure ThtDataProvider.UnSubscribeLongProcess(const aSubscriber: IdaLongProcessSubscriber);
//#UC START# *5524D33101AC_5519351D01BE_var*
//#UC END# *5524D33101AC_5519351D01BE_var*
begin
//#UC START# *5524D33101AC_5519351D01BE_impl*
 if Self <> nil then
  f_LongProcessList.Remove(aSubscriber);
//#UC END# *5524D33101AC_5519351D01BE_impl*
end;//ThtDataProvider.UnSubscribeLongProcess

procedure ThtDataProvider.SubscribeProgress(const aSubscriber: IdaProgressSubscriber);
//#UC START# *552514320149_5519351D01BE_var*
//#UC END# *552514320149_5519351D01BE_var*
begin
//#UC START# *552514320149_5519351D01BE_impl*
 if f_ProgressList.IndexOf(aSubscriber) = -1 then
  f_ProgressList.Add(aSubscriber);
//#UC END# *552514320149_5519351D01BE_impl*
end;//ThtDataProvider.SubscribeProgress

procedure ThtDataProvider.UnSubscribeProgress(const aSubscriber: IdaProgressSubscriber);
//#UC START# *5525144701F3_5519351D01BE_var*
//#UC END# *5525144701F3_5519351D01BE_var*
begin
//#UC START# *5525144701F3_5519351D01BE_impl*
 if Self <> nil then
  f_ProgressList.Remove(aSubscriber);
//#UC END# *5525144701F3_5519351D01BE_impl*
end;//ThtDataProvider.UnSubscribeProgress

procedure ThtDataProvider.Start;
//#UC START# *5526537A00CE_5519351D01BE_var*
//#UC END# *5526537A00CE_5519351D01BE_var*
begin
//#UC START# *5526537A00CE_5519351D01BE_impl*
 if f_IsStarted then
  Exit;
 Assert(GlobalDataProvider = nil);
 if GlobalDataProvider = nil then
 begin
  SetGlobalDataProvider(Self);
  f_NeedClearGlobalDataProvider := True;
 end;
 CreateHtEx(f_Params.StationName, f_Params.MakePathRec, f_Params.DocBaseVersion, f_Params.AdminBaseVersion, f_Params.AliasesList, f_ForCheckLogin, f_AllowClearLocks);
 GlobalHTServer.xxxUserID := f_Params.UserID;
 if not f_ForCheckLogin then
  Get_Journal.UserID := f_Params.UserID;
 GlobalHTServer.xxxOnLongProcess := DoLongProcessNotify;
 GlobalHTServer.xxxOnProgress := DoProgressNotify;
 f_IsStarted := True;
//#UC END# *5526537A00CE_5519351D01BE_impl*
end;//ThtDataProvider.Start

procedure ThtDataProvider.Stop;
//#UC START# *5526538202A5_5519351D01BE_var*
//#UC END# *5526538202A5_5519351D01BE_var*
begin
//#UC START# *5526538202A5_5519351D01BE_impl*
 if not f_IsStarted then
  Exit;
 if f_NeedClearGlobalDataProvider then
  SetGlobalDataProvider(nil);
 if Assigned(f_Journal) then
  f_Journal.SessionDone;
 f_Journal := nil;
 if GlobalHTServer <> nil then
  DestroyHt;
 f_IsStarted := False; 
//#UC END# *5526538202A5_5519351D01BE_impl*
end;//ThtDataProvider.Stop

function ThtDataProvider.Get_Journal: IdaJournal;
//#UC START# *55409258013F_5519351D01BEget_var*
//#UC END# *55409258013F_5519351D01BEget_var*
begin
//#UC START# *55409258013F_5519351D01BEget_impl*
 if f_Journal = nil then
 begin
  f_Journal := ThtJournal.Make(Get_TableQueryFactory);
  f_Journal.UserID := Get_UserID;
 end;
 Result := f_Journal;
//#UC END# *55409258013F_5519351D01BEget_impl*
end;//ThtDataProvider.Get_Journal

function ThtDataProvider.Get_TableQueryFactory: IdaTableQueryFactory;
//#UC START# *554C7A3002BF_5519351D01BEget_var*
//#UC END# *554C7A3002BF_5519351D01BEget_var*
begin
//#UC START# *554C7A3002BF_5519351D01BEget_impl*
 if f_Factory = nil then
  f_Factory := ThtTableQueryFactory.Make(f_DataConverter, f_Helper);
 Result := f_Factory;
//#UC END# *554C7A3002BF_5519351D01BEget_impl*
end;//ThtDataProvider.Get_TableQueryFactory

function ThtDataProvider.Get_DataConverter: IdaDataConverter;
//#UC START# *555995CF0292_5519351D01BEget_var*
//#UC END# *555995CF0292_5519351D01BEget_var*
begin
//#UC START# *555995CF0292_5519351D01BEget_impl*
 Result := f_DataConverter;
//#UC END# *555995CF0292_5519351D01BEget_impl*
end;//ThtDataProvider.Get_DataConverter

function ThtDataProvider.Get_ImpersonatedUserID: TdaUserID;
//#UC START# *561795EA02BF_5519351D01BEget_var*
//#UC END# *561795EA02BF_5519351D01BEget_var*
begin
//#UC START# *561795EA02BF_5519351D01BEget_impl*
 if f_ImpersonatedUserID = usNone then
  Result := Get_UserID
 else
  Result := f_ImpersonatedUserID;
//#UC END# *561795EA02BF_5519351D01BEget_impl*
end;//ThtDataProvider.Get_ImpersonatedUserID

procedure ThtDataProvider.BeginImpersonate(anUserID: TdaUserID);
//#UC START# *561796070253_5519351D01BE_var*
//#UC END# *561796070253_5519351D01BE_var*
begin
//#UC START# *561796070253_5519351D01BE_impl*
 if f_ImpersonatedUserID <> usNone then
  l3System.Msg2Log('ALERT ImpersonateUser');
 f_ImpersonatedUserID := anUserID;
//#UC END# *561796070253_5519351D01BE_impl*
end;//ThtDataProvider.BeginImpersonate

procedure ThtDataProvider.EndImpersonate;
//#UC START# *5617961F0105_5519351D01BE_var*
//#UC END# *5617961F0105_5519351D01BE_var*
begin
//#UC START# *5617961F0105_5519351D01BE_impl*
 f_ImpersonatedUserID := usNone;
//#UC END# *5617961F0105_5519351D01BE_impl*
end;//ThtDataProvider.EndImpersonate

function ThtDataProvider.Get_UserManager: IdaUserManager;
//#UC START# *5628D25600E6_5519351D01BEget_var*
//#UC END# *5628D25600E6_5519351D01BEget_var*
begin
//#UC START# *5628D25600E6_5519351D01BEget_impl*
 if f_UserManager = nil then
  f_UserManager := ThtUserManager.Make;
 Result := f_UserManager;
//#UC END# *5628D25600E6_5519351D01BEget_impl*
end;//ThtDataProvider.Get_UserManager

procedure ThtDataProvider.Cleanup;
//#UC START# *479731C50290_5519351D01BE_var*
//#UC END# *479731C50290_5519351D01BE_var*
begin
//#UC START# *479731C50290_5519351D01BE_impl*
 FreeAndNil(f_Params);
 FreeAndNil(f_LongProcessList);
 FreeAndNil(f_ProgressList);
 f_Factory := nil;
 f_Journal := nil;
 f_UserManager := nil;
 f_DataConverter := nil;
 f_Helper := nil;
 inherited;
//#UC END# *479731C50290_5519351D01BE_impl*
end;//ThtDataProvider.Cleanup

end.
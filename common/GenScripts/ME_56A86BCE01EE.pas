unit caDataProvider;

// Модуль: "w:\common\components\rtl\Garant\ComboAccess\caDataProvider.pas"
// Стереотип: "SimpleClass"

{$Include caDefine.inc}

interface

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , caDataProviderParams
 , daTypes
 , l3Languages
 , l3DatLst
;

type
 TcaDataProvider = class(Tl3ProtoObject, IdaDataProvider)
  private
   f_Params: TcaDataProviderParams;
   f_HTProvider: IdaDataProvider;
   f_PGProvider: IdaDataProvider;
  protected
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
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aParams: TcaDataProviderParams;
    ForCheckLogin: Boolean;
    AllowClearLocks: Boolean;
    const aHTProvider: IdaDataProvider;
    const aPGProvider: IdaDataProvider); reintroduce;
   class function Make(aParams: TcaDataProviderParams;
    ForCheckLogin: Boolean;
    AllowClearLocks: Boolean;
    const aHTProvider: IdaDataProvider;
    const aPGProvider: IdaDataProvider): IdaDataProvider; reintroduce;
 end;//TcaDataProvider
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

implementation

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3ImplUses
 , SysUtils
;

constructor TcaDataProvider.Create(aParams: TcaDataProviderParams;
 ForCheckLogin: Boolean;
 AllowClearLocks: Boolean;
 const aHTProvider: IdaDataProvider;
 const aPGProvider: IdaDataProvider);
//#UC START# *56BB1FC50359_56A86BCE01EE_var*
//#UC END# *56BB1FC50359_56A86BCE01EE_var*
begin
//#UC START# *56BB1FC50359_56A86BCE01EE_impl*
 !!! Needs to be implemented !!!
//#UC END# *56BB1FC50359_56A86BCE01EE_impl*
end;//TcaDataProvider.Create

class function TcaDataProvider.Make(aParams: TcaDataProviderParams;
 ForCheckLogin: Boolean;
 AllowClearLocks: Boolean;
 const aHTProvider: IdaDataProvider;
 const aPGProvider: IdaDataProvider): IdaDataProvider;
var
 l_Inst : TcaDataProvider;
begin
 l_Inst := Create(aParams, ForCheckLogin, AllowClearLocks, aHTProvider, aPGProvider);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TcaDataProvider.Make

function TcaDataProvider.Get_UserID: TdaUserID;
//#UC START# *551A929E02D5_56A86BCE01EEget_var*
//#UC END# *551A929E02D5_56A86BCE01EEget_var*
begin
//#UC START# *551A929E02D5_56A86BCE01EEget_impl*
 Result := 0;
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *551A929E02D5_56A86BCE01EEget_impl*
end;//TcaDataProvider.Get_UserID

function TcaDataProvider.Get_RegionID: TdaRegionID;
//#UC START# *551A933F02AE_56A86BCE01EEget_var*
//#UC END# *551A933F02AE_56A86BCE01EEget_var*
begin
//#UC START# *551A933F02AE_56A86BCE01EEget_impl*
 Result := 0;
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *551A933F02AE_56A86BCE01EEget_impl*
end;//TcaDataProvider.Get_RegionID

function TcaDataProvider.CheckLogin(const aLogin: AnsiString;
 const aPassword: AnsiString;
 IsRequireAdminRights: Boolean): TdaLoginError;
//#UC START# *551BE2D701DE_56A86BCE01EE_var*
//#UC END# *551BE2D701DE_56A86BCE01EE_var*
begin
//#UC START# *551BE2D701DE_56A86BCE01EE_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *551BE2D701DE_56A86BCE01EE_impl*
end;//TcaDataProvider.CheckLogin

procedure TcaDataProvider.InitRegionFromIni(aDefaultRegion: TdaRegionID);
//#UC START# *551D25D00024_56A86BCE01EE_var*
//#UC END# *551D25D00024_56A86BCE01EE_var*
begin
//#UC START# *551D25D00024_56A86BCE01EE_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *551D25D00024_56A86BCE01EE_impl*
end;//TcaDataProvider.InitRegionFromIni

function TcaDataProvider.IsRegionExists(anID: TdaRegionID): Boolean;
//#UC START# *551D2C300060_56A86BCE01EE_var*
//#UC END# *551D2C300060_56A86BCE01EE_var*
begin
//#UC START# *551D2C300060_56A86BCE01EE_impl*
 Result := False;
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *551D2C300060_56A86BCE01EE_impl*
end;//TcaDataProvider.IsRegionExists

function TcaDataProvider.GetRegionName(anID: TdaRegionID): AnsiString;
//#UC START# *551D2C3603E0_56A86BCE01EE_var*
//#UC END# *551D2C3603E0_56A86BCE01EE_var*
begin
//#UC START# *551D2C3603E0_56A86BCE01EE_impl*
 Result := '';
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *551D2C3603E0_56A86BCE01EE_impl*
end;//TcaDataProvider.GetRegionName

procedure TcaDataProvider.FillRegionDataList(aList: Tl3StringDataList;
 Caps: Boolean);
//#UC START# *551D35040362_56A86BCE01EE_var*
//#UC END# *551D35040362_56A86BCE01EE_var*
begin
//#UC START# *551D35040362_56A86BCE01EE_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *551D35040362_56A86BCE01EE_impl*
end;//TcaDataProvider.FillRegionDataList

function TcaDataProvider.Get_BaseName: AnsiString;
//#UC START# *551E636F0314_56A86BCE01EEget_var*
//#UC END# *551E636F0314_56A86BCE01EEget_var*
begin
//#UC START# *551E636F0314_56A86BCE01EEget_impl*
 Result := '';
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *551E636F0314_56A86BCE01EEget_impl*
end;//TcaDataProvider.Get_BaseName

function TcaDataProvider.Get_AdminRights: Boolean;
//#UC START# *551E6389027F_56A86BCE01EEget_var*
//#UC END# *551E6389027F_56A86BCE01EEget_var*
begin
//#UC START# *551E6389027F_56A86BCE01EEget_impl*
 Result := False;
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *551E6389027F_56A86BCE01EEget_impl*
end;//TcaDataProvider.Get_AdminRights

function TcaDataProvider.Get_CurUserIsServer: Boolean;
//#UC START# *551E63A1025A_56A86BCE01EEget_var*
//#UC END# *551E63A1025A_56A86BCE01EEget_var*
begin
//#UC START# *551E63A1025A_56A86BCE01EEget_impl*
 Result := False;
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *551E63A1025A_56A86BCE01EEget_impl*
end;//TcaDataProvider.Get_CurUserIsServer

procedure TcaDataProvider.LoginAsServer;
//#UC START# *551E63B5008C_56A86BCE01EE_var*
//#UC END# *551E63B5008C_56A86BCE01EE_var*
begin
//#UC START# *551E63B5008C_56A86BCE01EE_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *551E63B5008C_56A86BCE01EE_impl*
end;//TcaDataProvider.LoginAsServer

function TcaDataProvider.GetFreeExtObjID(aFamily: TdaFamilyID): TdaDocID;
//#UC START# *551E7E1501D8_56A86BCE01EE_var*
//#UC END# *551E7E1501D8_56A86BCE01EE_var*
begin
//#UC START# *551E7E1501D8_56A86BCE01EE_impl*
 Result := 0;
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *551E7E1501D8_56A86BCE01EE_impl*
end;//TcaDataProvider.GetFreeExtObjID

function TcaDataProvider.GetFreeExtDocID(aFamily: TdaFamilyID): TdaDocID;
//#UC START# *551E7E35030B_56A86BCE01EE_var*
//#UC END# *551E7E35030B_56A86BCE01EE_var*
begin
//#UC START# *551E7E35030B_56A86BCE01EE_impl*
 Result := 0;
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *551E7E35030B_56A86BCE01EE_impl*
end;//TcaDataProvider.GetFreeExtDocID

function TcaDataProvider.LockAll: Boolean;
//#UC START# *5522326E0355_56A86BCE01EE_var*
//#UC END# *5522326E0355_56A86BCE01EE_var*
begin
//#UC START# *5522326E0355_56A86BCE01EE_impl*
 Result := False;
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *5522326E0355_56A86BCE01EE_impl*
end;//TcaDataProvider.LockAll

procedure TcaDataProvider.UnlockAll;
//#UC START# *5522327B01D9_56A86BCE01EE_var*
//#UC END# *5522327B01D9_56A86BCE01EE_var*
begin
//#UC START# *5522327B01D9_56A86BCE01EE_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *5522327B01D9_56A86BCE01EE_impl*
end;//TcaDataProvider.UnlockAll

function TcaDataProvider.Get_BaseLanguage(aFamily: TdaFamilyID): TLanguageObj;
//#UC START# *5522496C00CD_56A86BCE01EEget_var*
//#UC END# *5522496C00CD_56A86BCE01EEget_var*
begin
//#UC START# *5522496C00CD_56A86BCE01EEget_impl*
 Result := nil;
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *5522496C00CD_56A86BCE01EEget_impl*
end;//TcaDataProvider.Get_BaseLanguage

function TcaDataProvider.Get_TextBase(aFamily: TdaFamilyID): AnsiString;
//#UC START# *55226E4B01E0_56A86BCE01EEget_var*
//#UC END# *55226E4B01E0_56A86BCE01EEget_var*
begin
//#UC START# *55226E4B01E0_56A86BCE01EEget_impl*
 Result := '';
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *55226E4B01E0_56A86BCE01EEget_impl*
end;//TcaDataProvider.Get_TextBase

function TcaDataProvider.GetHomePathName(aUserID: TdaUserID): TdaPathStr;
//#UC START# *552391490184_56A86BCE01EE_var*
//#UC END# *552391490184_56A86BCE01EE_var*
begin
//#UC START# *552391490184_56A86BCE01EE_impl*
 Result := '';
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *552391490184_56A86BCE01EE_impl*
end;//TcaDataProvider.GetHomePathName

function TcaDataProvider.GetHomePath(aUserID: TdaUserID): TdaPathStr;
//#UC START# *552391830231_56A86BCE01EE_var*
//#UC END# *552391830231_56A86BCE01EE_var*
begin
//#UC START# *552391830231_56A86BCE01EE_impl*
 Result := '';
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *552391830231_56A86BCE01EE_impl*
end;//TcaDataProvider.GetHomePath

function TcaDataProvider.Get_CurHomePath: TdaPathStr;
//#UC START# *5523983D0254_56A86BCE01EEget_var*
//#UC END# *5523983D0254_56A86BCE01EEget_var*
begin
//#UC START# *5523983D0254_56A86BCE01EEget_impl*
 Result := '';
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *5523983D0254_56A86BCE01EEget_impl*
end;//TcaDataProvider.Get_CurHomePath

function TcaDataProvider.Get_GlobalHomePath: TdaPathStr;
//#UC START# *5523984A0349_56A86BCE01EEget_var*
//#UC END# *5523984A0349_56A86BCE01EEget_var*
begin
//#UC START# *5523984A0349_56A86BCE01EEget_impl*
 Result := '';
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *5523984A0349_56A86BCE01EEget_impl*
end;//TcaDataProvider.Get_GlobalHomePath

function TcaDataProvider.ConvertAliasPath(const CurPath: TdaPathStr): TdaPathStr;
//#UC START# *5523BD100174_56A86BCE01EE_var*
//#UC END# *5523BD100174_56A86BCE01EE_var*
begin
//#UC START# *5523BD100174_56A86BCE01EE_impl*
 Result := '';
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *5523BD100174_56A86BCE01EE_impl*
end;//TcaDataProvider.ConvertAliasPath

procedure TcaDataProvider.SubscribeLongProcess(const aSubscriber: IdaLongProcessSubscriber);
//#UC START# *5524D30D007F_56A86BCE01EE_var*
//#UC END# *5524D30D007F_56A86BCE01EE_var*
begin
//#UC START# *5524D30D007F_56A86BCE01EE_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *5524D30D007F_56A86BCE01EE_impl*
end;//TcaDataProvider.SubscribeLongProcess

procedure TcaDataProvider.UnSubscribeLongProcess(const aSubscriber: IdaLongProcessSubscriber);
//#UC START# *5524D33101AC_56A86BCE01EE_var*
//#UC END# *5524D33101AC_56A86BCE01EE_var*
begin
//#UC START# *5524D33101AC_56A86BCE01EE_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *5524D33101AC_56A86BCE01EE_impl*
end;//TcaDataProvider.UnSubscribeLongProcess

procedure TcaDataProvider.SubscribeProgress(const aSubscriber: IdaProgressSubscriber);
//#UC START# *552514320149_56A86BCE01EE_var*
//#UC END# *552514320149_56A86BCE01EE_var*
begin
//#UC START# *552514320149_56A86BCE01EE_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *552514320149_56A86BCE01EE_impl*
end;//TcaDataProvider.SubscribeProgress

procedure TcaDataProvider.UnSubscribeProgress(const aSubscriber: IdaProgressSubscriber);
//#UC START# *5525144701F3_56A86BCE01EE_var*
//#UC END# *5525144701F3_56A86BCE01EE_var*
begin
//#UC START# *5525144701F3_56A86BCE01EE_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *5525144701F3_56A86BCE01EE_impl*
end;//TcaDataProvider.UnSubscribeProgress

procedure TcaDataProvider.Start;
//#UC START# *5526537A00CE_56A86BCE01EE_var*
//#UC END# *5526537A00CE_56A86BCE01EE_var*
begin
//#UC START# *5526537A00CE_56A86BCE01EE_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *5526537A00CE_56A86BCE01EE_impl*
end;//TcaDataProvider.Start

procedure TcaDataProvider.Stop;
//#UC START# *5526538202A5_56A86BCE01EE_var*
//#UC END# *5526538202A5_56A86BCE01EE_var*
begin
//#UC START# *5526538202A5_56A86BCE01EE_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *5526538202A5_56A86BCE01EE_impl*
end;//TcaDataProvider.Stop

function TcaDataProvider.Get_Journal: IdaJournal;
//#UC START# *55409258013F_56A86BCE01EEget_var*
//#UC END# *55409258013F_56A86BCE01EEget_var*
begin
//#UC START# *55409258013F_56A86BCE01EEget_impl*
 Result := nil;
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *55409258013F_56A86BCE01EEget_impl*
end;//TcaDataProvider.Get_Journal

function TcaDataProvider.Get_TableQueryFactory: IdaTableQueryFactory;
//#UC START# *554C7A3002BF_56A86BCE01EEget_var*
//#UC END# *554C7A3002BF_56A86BCE01EEget_var*
begin
//#UC START# *554C7A3002BF_56A86BCE01EEget_impl*
 Result := nil;
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *554C7A3002BF_56A86BCE01EEget_impl*
end;//TcaDataProvider.Get_TableQueryFactory

function TcaDataProvider.Get_DataConverter: IdaDataConverter;
//#UC START# *555995CF0292_56A86BCE01EEget_var*
//#UC END# *555995CF0292_56A86BCE01EEget_var*
begin
//#UC START# *555995CF0292_56A86BCE01EEget_impl*
 Result := nil;
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *555995CF0292_56A86BCE01EEget_impl*
end;//TcaDataProvider.Get_DataConverter

function TcaDataProvider.Get_ImpersonatedUserID: TdaUserID;
//#UC START# *561795EA02BF_56A86BCE01EEget_var*
//#UC END# *561795EA02BF_56A86BCE01EEget_var*
begin
//#UC START# *561795EA02BF_56A86BCE01EEget_impl*
 Result := 0;
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *561795EA02BF_56A86BCE01EEget_impl*
end;//TcaDataProvider.Get_ImpersonatedUserID

procedure TcaDataProvider.BeginImpersonate(anUserID: TdaUserID);
//#UC START# *561796070253_56A86BCE01EE_var*
//#UC END# *561796070253_56A86BCE01EE_var*
begin
//#UC START# *561796070253_56A86BCE01EE_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *561796070253_56A86BCE01EE_impl*
end;//TcaDataProvider.BeginImpersonate

procedure TcaDataProvider.EndImpersonate;
//#UC START# *5617961F0105_56A86BCE01EE_var*
//#UC END# *5617961F0105_56A86BCE01EE_var*
begin
//#UC START# *5617961F0105_56A86BCE01EE_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *5617961F0105_56A86BCE01EE_impl*
end;//TcaDataProvider.EndImpersonate

function TcaDataProvider.Get_UserManager: IdaUserManager;
//#UC START# *5628D25600E6_56A86BCE01EEget_var*
//#UC END# *5628D25600E6_56A86BCE01EEget_var*
begin
//#UC START# *5628D25600E6_56A86BCE01EEget_impl*
 Result := nil;
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *5628D25600E6_56A86BCE01EEget_impl*
end;//TcaDataProvider.Get_UserManager

procedure TcaDataProvider.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_56A86BCE01EE_var*
//#UC END# *479731C50290_56A86BCE01EE_var*
begin
//#UC START# *479731C50290_56A86BCE01EE_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_56A86BCE01EE_impl*
end;//TcaDataProvider.Cleanup
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

end.

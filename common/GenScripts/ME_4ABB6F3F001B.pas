unit About_Form;
 {* О программе }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\About_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "About" MUID: (4ABB6F3F001B)
// Имя типа: "TefAbout"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , vtLabel
 , vtGroupBox
 , vtButton
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_efAbout: TvcmFormDescriptor = (rFormID : (rName : 'efAbout'; rID : 0); rFactory : nil);
  {* Идентификатор формы TefAbout }

type
 TefAbout = class;

 AboutFormDef = interface
  {* Идентификатор формы About }
  ['{F678B4F8-60D5-4B4F-AE77-F61D6A29D2F9}']
 end;//AboutFormDef

 TefAbout = {final} class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , AboutFormDef)
  {* О программе }
   Entities : TvcmEntities;
  private
   f_pbLogo: TPaintBox;
    {* Поле для свойства pbLogo }
   f_ShellInfoLabel: TvtLabel;
    {* Поле для свойства ShellInfoLabel }
   f_AdapterInfoLabel: TvtLabel;
    {* Поле для свойства AdapterInfoLabel }
   f_UserCountLabel: TvtLabel;
    {* Поле для свойства UserCountLabel }
   f_OwnerLabel: TvtLabel;
    {* Поле для свойства OwnerLabel }
   f_ShellCaptionLabel: TvtLabel;
    {* Поле для свойства ShellCaptionLabel }
   f_OwnerCaptionLabel: TvtLabel;
    {* Поле для свойства OwnerCaptionLabel }
   f_UserInfoGroupBox: TvtGroupBox;
    {* Поле для свойства UserInfoGroupBox }
   f_EMailCaptionLabel: TvtLabel;
    {* Поле для свойства EMailCaptionLabel }
   f_EMailLabel: TvtLabel;
    {* Поле для свойства EMailLabel }
   f_LoginCaptionLabel: TvtLabel;
    {* Поле для свойства LoginCaptionLabel }
   f_UserCaptionLabel: TvtLabel;
    {* Поле для свойства UserCaptionLabel }
   f_UserNameLabel: TvtLabel;
    {* Поле для свойства UserNameLabel }
   f_LoginLabel: TvtLabel;
    {* Поле для свойства LoginLabel }
   f_CopyrightCaptionLabel: TvtLabel;
    {* Поле для свойства CopyrightCaptionLabel }
   f_OkButton: TvtButton;
    {* Поле для свойства OkButton }
   f_UserCountCaptionLabel: TvtLabel;
    {* Поле для свойства UserCountCaptionLabel }
   f_AdapterCaptionLabel: TvtLabel;
    {* Поле для свойства AdapterCaptionLabel }
  private
   procedure UpdateInfoOnForm;
   procedure GetCurrentUserInfo;
   procedure GetCurrentOwnerInfo;
   procedure pbLogoPaint(Sender: TObject);
  protected
   procedure FinishDataUpdate; override;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property pbLogo: TPaintBox
    read f_pbLogo;
   property ShellInfoLabel: TvtLabel
    read f_ShellInfoLabel;
   property AdapterInfoLabel: TvtLabel
    read f_AdapterInfoLabel;
   property UserCountLabel: TvtLabel
    read f_UserCountLabel;
   property OwnerLabel: TvtLabel
    read f_OwnerLabel;
   property ShellCaptionLabel: TvtLabel
    read f_ShellCaptionLabel;
    {* Версия }
   property OwnerCaptionLabel: TvtLabel
    read f_OwnerCaptionLabel;
    {* Зарегистрированный пользователь копии }
   property UserInfoGroupBox: TvtGroupBox
    read f_UserInfoGroupBox;
    {* Учетная запись }
   property CopyrightCaptionLabel: TvtLabel
    read f_CopyrightCaptionLabel;
    {* (C) ООО НПП "ГАРАНТ-СЕРВИС-УНИВЕРСИТЕТ", 1990-2016 }
   property OkButton: TvtButton
    read f_OkButton;
   property UserCountCaptionLabel: TvtLabel
    read f_UserCountCaptionLabel;
   property AdapterCaptionLabel: TvtLabel
    read f_AdapterCaptionLabel;
 end;//TefAbout
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , StartUnit
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , l3String
 , vtVerInf
 , DataAdapter
 , ComplectUnit
 , IOUnit
 , nsTypes
 , nsUtils
 , l3MinMax
 , vtDialogsRes
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , SecurityUnit
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 , About_ut_About_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , AboutKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$If NOT Defined(NoVCM)}
const
 {* Локализуемые строки ut_AboutLocalConstants }
 str_ut_AboutCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_AboutCaption'; rValue : 'О программе');
  {* Заголовок пользовательского типа "О программе" }

{$R *.DFM}

procedure TefAbout.UpdateInfoOnForm;
//#UC START# *5006D2A60192_4ABB6F3F001B_var*
const
 cInternalVersionKindTitle: array[Boolean, TProductType] of PvcmStringID = (
   (
  @str_cvkInternalNonDebugUnknown, // PT_UNKNOWN
  @str_cvkInternalNonDebugDVD, // PT_DVD
  @str_cvkInternalNonDebugMobile, // PT_MOBILE
  @str_cvkInternalNonDebugFileServer, // PT_FILESERVER
  @str_cvkInternalNonDebugDesktop, // PT_DESKTOP
  @str_cvkInternalNonDebugClientServer, // PT_CLIENTSERVER
                @str_cvkInternalNonDebugSupermobile // TODO: PT_SUPERMOBILE
   ),
  // DefDataAdapter.AssemblyInfo.GetIsDebug = true
   (
  @str_cvkInternalDebugUnknown, // PT_UNKNOWN
  @str_cvkInternalDebugDVD, // PT_DVD
  @str_cvkInternalDebugMobile, // PT_Mobile
  @str_cvkInternalDebugFileServer, // PT_FILESERVER
  @str_cvkInternalDebugDesktop, // PT_DESKTOP
  @str_cvkInternalDebugClientServer, // PT_CLIENTSERVER
                @str_cvkInternalDebugSuperMobile // PT_SUPERMOBILE
   )
 );

 cVersionKindTitle: array [TBaseType, boolean, TProductType] of PvcmStringID = (
  // DefDataAdapter.AssemblyInfo.GetBaseType = BT_UNKNOWN
  (
  // DefDataAdapter.AssemblyInfo.GetIsDebug = false
   (
  @str_Empty, // PT_UNKNOWN
  @str_Empty, // PT_DVD
  @str_Empty, // PT_MOBILE
  @str_Empty, // PT_FILESERVER
  @str_Empty, // PT_DESKTOP
  @str_Empty, // PT_CLIENTSERVER
  @str_Empty // PT_CLIENTSERVER
   ),
  // DefDataAdapter.AssemblyInfo.GetIsDebug = true
   (
  @str_Empty, // PT_UNKNOWN
  @str_Empty, // PT_DVD
  @str_Empty, // PT_Mobile
  @str_Empty, // PT_FILESERVER
  @str_Empty, // PT_DESKTOP
  @str_Empty, // PT_CLIENTSERVER
  @str_Empty // PT_CLIENTSERVER
   )
  ),
  // DefDataAdapter.AssemblyInfo.GetBaseType = BT_TRIAL
  (
  // DefDataAdapter.AssemblyInfo.GetIsDebug = false
   (
  @str_cvkTrialNonDebugUnknown, // PT_UNKNOWN
  @str_cvkTrialNonDebugDVD, // PT_DVD
  @str_cvkTrialNonDebugMobile, // PT_MOBILE
  @str_cvkTrialNonDebugFileServer, // PT_FILESERVER
  @str_cvkTrialNonDebugDesktop, // PT_DESKTOP
  @str_cvkTrialNonDebugClientServer, // PT_CLIENTSERVER
  @str_cvkTrialNonDebugSuperMobile // PT_SUPERMOBILE
   ),
  // DefDataAdapter.AssemblyInfo.GetIsDebug = true
   (
  @str_cvkTrialDebugUnknown, // PT_UNKNOWN
  @str_cvkTrialDebugDVD, // PT_DVD
  @str_cvkTrialDebugMobile, // PT_MOBILE
  @str_cvkTrialDebugFileServer, // PT_FILESERVER
  @str_cvkTrialDebugDesktop, // PT_DESKTOP
  @str_cvkTrialDebugClientServer, // PT_CLIENTSERVER
  @str_cvkTrialDebugSuperMobile // PT_SUPERMOBILE
   )
  ),
  // DefDataAdapter.AssemblyInfo.GetBaseType = BT_COMMERCIAL
  (
  // DefDataAdapter.AssemblyInfo.GetIsDebug = false
   (
  @str_cvkCommerceNonDebugUnknown, // PT_UNKNOWN
  @str_cvkCommerceNonDebugDVD, // PT_DVD
  @str_cvkCommerceNonDebugMobile, // PT_MOBILE
  @str_cvkCommerceNonDebugFileServer, // PT_FILESERVER
  @str_cvkCommerceNonDebugDesktop, // PT_DESKTOP
  @str_cvkCommerceNonDebugClientServer, // PT_CLIENTSERVER
  @str_cvkCommerceNonDebugSuperMobile // PT_SUPERMOBILE
   ),
  // DefDataAdapter.AssemblyInfo.GetIsDebug = true
   (
  @str_cvkCommerceDebugUnknown, // PT_UNKNOWN
  @str_cvkCommerceDebugDVD, // PT_DVD
  @str_cvkCommerceDebugMobile, // PT_MOBILE
  @str_cvkCommerceDebugFileServer, // PT_FILESERVER
  @str_cvkCommerceDebugDesktop, // PT_DESKTOP
  @str_cvkCommerceDebugClientServer, // PT_CLIENTSERVER
  @str_cvkCommerceDebugSuperMobile // PT_SUPERMOBILE
   )
  ),
  // DefDataAdapter.AssemblyInfo.GetBaseType = BT_NON_COMMERCIAL
  (
  // DefDataAdapter.AssemblyInfo.GetIsDebug = false
   (
  @str_cvkNonCommerceNonDebugUnknown, // PT_UNKNOWN
  @str_cvkNonCommerceNonDebugDVD, // PT_DVD
  @str_cvkNonCommerceNonDebugMobile, // PT_MOBILE
  @str_cvkNonCommerceNonDebugFileServer, // PT_FILESERVER
  @str_cvkNonCommerceNonDebugDesktop, // PT_DESKTOP
  @str_cvkNonCommerceNonDebugClientServer, // PT_CLIENTSERVER
  @str_cvkNonCommerceNonDebugSuperMobile // PT_SUPERMOBILE
   ),
  // DefDataAdapter.AssemblyInfo.GetIsDebug = true
   (
  @str_cvkNonCommerceDebugUnknown, // PT_UNKNOWN
  @str_cvkNonCommerceDebugDVD, // PT_DVD
  @str_cvkNonCommerceDebugMobile, // PT_MOBILE
  @str_cvkNonCommerceDebugFileServer, // PT_FILESERVER
  @str_cvkNonCommerceDebugDesktop, // PT_DESKTOP
  @str_cvkNonCommerceDebugClientServer, // PT_CLIENTSERVER
  @str_cvkNonCommerceDebugSuperMobile // PT_SUPERMOBILE
   )
  ),
  // DefDataAdapter.AssemblyInfo.GetBaseType = BT_DEMO
  (
  // DefDataAdapter.AssemblyInfo.GetIsDebug = false
   (
  @str_cvkDemoNonDebugUnknown, // PT_UNKNOWN
  @str_cvkDemoNonDebugDVD, // PT_DVD
  @str_cvkDemoNonDebugMobile, // PT_MOBILE
  @str_cvkDemoNonDebugFileServer, // PT_FILESERVER
  @str_cvkDemoNonDebugDesktop, // PT_DESKTOP
  @str_cvkDemoNonDebugClientServer, // PT_CLIENTSERVER
  @str_cvkDemoNonDebugSuperMobile // PT_SUPERMOBILE
   ),
  // DefDataAdapter.AssemblyInfo.GetIsDebug = true
   (
  @str_cvkDemoDebugUnknown, // PT_UNKNOWN
  @str_cvkDemoDebugDVD, // PT_DVD
  @str_cvkDemoDebugMobile, // PT_MOBILE
  @str_cvkDemoDebugFileServer, // PT_FILESERVER
  @str_cvkDemoDebugDesktop, // PT_DESKTOP
  @str_cvkDemoDebugClientServer, // PT_CLIENTSERVER
  @str_cvkDemoDebugSuperMobile // PT_SUPERMOBILE
   )
  )
 );

 cServerMap: array [TCapacity] of PvcmStringID = (
  @str_EmptyStr, // C_32
  @str_x64Server // C_64
 );

 {$I nsBuildVersion.inc}
var
 l_UserCount: TLicenseRestrictions;


 function lp_ShowCount(aUserCount: TLicenseRestrictions): Boolean;
 const
  cUsersCountHack = 2000;
  cPermanentUsersCountHack = 0;
 begin
  if (aUserCount.rUsers = cUsersCountHack) and (aUserCount.rPermanentUsers = cPermanentUsersCountHack) then
   Result := False
  else
   Result := aUserCount.rUsers > 1;
 end;
//#UC END# *5006D2A60192_4ABB6F3F001B_var*
begin
//#UC START# *5006D2A60192_4ABB6F3F001B_impl*
 if (c_BuildVersion <> 'X.XX.X.XXX') then
 begin
  ShellInfoLabel.CCaption := vcmFmt(str_Version_Message, [c_BuildVersion]);
 end
 else
  with TVersionInfo.Create, FileLongVersion do
  try
   ShellInfoLabel.CCaption := vcmFmt(str_Version_Message, [vcmFmt('%d.%d.%d.%d', [All[2], All[1], All[4], All[3]])]);
  finally
   Free;
  end;
 //
 ShellInfoLabel.CCaption := l3Cat([ShellInfoLabel.CCaption, vcmCStr(cServerMap[DefDataAdapter.AssemblyInfo.GetServerCapacity]^)]);

 if not DefDataAdapter.AssemblyInfo.GetIsCommerce then
  AdapterInfoLabel.CCaption := vcmCStr(cInternalVersionKindTitle[DefDataAdapter.AssemblyInfo.GetIsDebug,
                                                                 DefDataAdapter.CommonInterfaces.GetProductType]^)
 else
  AdapterInfoLabel.CCaption := vcmCStr(cVersionKindTitle[DefDataAdapter.CommonInterfaces.GetBaseType,
                                                         DefDataAdapter.AssemblyInfo.GetIsDebug,
                                                         DefDataAdapter.CommonInterfaces.GetProductType]^);


 DefDataAdapter.CommonInterfaces.GetLicenseRestrictions(l_UserCount);
 if lp_ShowCount(l_UserCount) then
 begin
  if l_UserCount.rPermanentUsers > 0 then
   UserCountLabel.CCaption := vcmFmt(str_AboutFullUserCountCaption, [l_UserCount.rUsers, l_UserCount.rPermanentUsers])
  else
   UserCountLabel.CCaption := vcmFmt(str_AboutUserCountCaption, [l_UserCount.rUsers]);
  UserCountLabel.Visible := True;
  UserCountCaptionLabel.Visible := True;
 end
 else
 begin
  UserCountLabel.Visible := False;
  UserCountCaptionLabel.Visible := False;
 end;

 GetCurrentOwnerInfo;
 GetCurrentUserInfo;
//#UC END# *5006D2A60192_4ABB6F3F001B_impl*
end;//TefAbout.UpdateInfoOnForm

procedure TefAbout.GetCurrentUserInfo;
//#UC START# *5006D2BC03C1_4ABB6F3F001B_var*
var
 l_UserManager : IUserManager;
 l_Profile     : IUserProfile;
 l_Name        : IString;
//#UC END# *5006D2BC03C1_4ABB6F3F001B_var*
begin
//#UC START# *5006D2BC03C1_4ABB6F3F001B_impl*
 UserNameLabel.CCaption := nil;
 LoginLabel.CCaption := nil;
 EMailLabel.CCaption := nil;

 l_UserManager := defDataAdapter.NativeAdapter.MakeUserManager;
 try
  l_UserManager.GetSelfProfile(l_Profile);
  try
   // Имя пользователя
   l_Profile.GetName(l_Name);
   try
    UserNameLabel.CCaption := nsCStr(l_Name);
   finally
    l_Name := nil;
   end;
   // Login
   l_Profile.GetLogin(l_Name);
   try
    LoginLabel.CCaption := nsCStr(l_Name);
   finally
    l_Name := nil;
   end;
   // E-Mail
   l_Profile.GetMail(l_Name);
   try
    EMailLabel.CCaption := nsCStr(l_Name);
   finally
    l_Name := nil;
   end;
  finally
   l_Profile := nil;
  end;
 finally
  l_UserManager := nil;
 end;
//#UC END# *5006D2BC03C1_4ABB6F3F001B_impl*
end;//TefAbout.GetCurrentUserInfo

procedure TefAbout.GetCurrentOwnerInfo;
//#UC START# *5006D2D20048_4ABB6F3F001B_var*
var
 l_ComplectInfo : IComplectInfo;
 l_Name         : IString;
//#UC END# *5006D2D20048_4ABB6F3F001B_var*
begin
//#UC START# *5006D2D20048_4ABB6F3F001B_impl*
 OwnerLabel.CCaption := nil;
 l_ComplectInfo := defDataAdapter.NativeAdapter.MakeComplectInfo;
 try
  l_ComplectInfo.GetOwner(l_Name);
  try
   OwnerLabel.CCaption := nsCStr(l_Name);
  finally
   l_Name := nil;
  end;
 finally
  l_ComplectInfo := nil;
 end;
//#UC END# *5006D2D20048_4ABB6F3F001B_impl*
end;//TefAbout.GetCurrentOwnerInfo

procedure TefAbout.pbLogoPaint(Sender: TObject);
//#UC START# *5006D77F038F_4ABB6F3F001B_var*
//#UC END# *5006D77F038F_4ABB6F3F001B_var*
begin
//#UC START# *5006D77F038F_4ABB6F3F001B_impl*
 nsPaintImage(dmStdRes.ilLogo, pbLogo);
//#UC END# *5006D77F038F_4ABB6F3F001B_impl*
end;//TefAbout.pbLogoPaint

procedure TefAbout.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4ABB6F3F001B_var*
//#UC END# *47EA4E9002C6_4ABB6F3F001B_var*
begin
//#UC START# *47EA4E9002C6_4ABB6F3F001B_impl*
 inherited;
 InitControls;
//#UC END# *47EA4E9002C6_4ABB6F3F001B_impl*
end;//TefAbout.FinishDataUpdate

procedure TefAbout.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4ABB6F3F001B_var*
const
 c_Delta = 6;
var
 l_RightInfoBorder: Integer;
 l_LeftInfoBorder: Integer;
 l_LeftLabelBorder: Integer;
 l_RightLabelBorder: Integer;
 l_Tops: Integer;
 l_WhiteHeight: Integer;

 function lp_GetDelta: Integer;
 begin
  Result := (c_Delta * Screen.PixelsPerInch) div 96;
 end;

 function AdjustInfo(aCaptionLabel, aLabel: TvtLabel; aTop: Integer; aGBShift: Integer = 0): Integer;
 begin
  with aCaptionLabel do
  begin
   WordWrap := True;

   AutoSize := True;
   Width := ((178 + aGBShift) * Screen.PixelsPerInch) div 96;
   AutoSize := False;
   Width := ((178 + aGBShift) * Screen.PixelsPerInch) div 96;

   Left := ((10 - aGBShift) * Screen.PixelsPerInch) div 96;
   Top := aTop;
   Transparent := True;
   Alignment := taRightJustify;
  end;
  with aLabel do
  begin
   AutoSize := True;
   WordWrap := True;
   Left := aCaptionLabel.Left + aCaptionLabel.Width + lp_GetDelta;
   Width := Parent.ClientWidth - Left - lp_GetDelta;
   Top := aTop;
   Transparent := True;
   Alignment := taLeftJustify;
   Anchors := [akLeft, akRight, akTop];
  end;      
  Result := Max(aCaptionLabel.Top + aCaptionLabel.Height, aLabel.Top + aLabel.Height) + lp_GetDelta;
 end;                       
//#UC END# *4A8E8F2E0195_4ABB6F3F001B_var*
begin
//#UC START# *4A8E8F2E0195_4ABB6F3F001B_impl*
 UpdateInfoOnForm;

 Width := (550 * Screen.PixelsPerInch) div 96;


 BorderStyle := bsSingle;
 BorderIcons := [biSystemMenu];

 with pbLogo do
 begin
  SetBounds(12, 6, 200, 58);
  OnPaint := PbLogoPaint;
 end;

 l_Tops := pbLogo.Top + pbLogo.Height + lp_GetDelta;
 l_Tops := AdjustInfo(ShellCaptionLabel, ShellInfoLabel, l_Tops);
 l_Tops := AdjustInfo(AdapterCaptionLabel, AdapterInfoLabel, l_Tops);
 l_Tops := AdjustInfo(UserCountCaptionLabel, UserCountLabel, l_Tops);
 l_Tops := AdjustInfo(OwnerCaptionLabel, OwnerLabel, l_Tops);

 with UserInfoGroupBox do
 begin
  Top := l_Tops;
  Left := lp_GetDelta;
  Width := Self.ClientWidth - lp_GetDelta * 2;
  Anchors := [akLeft, akRight, akTop];
 end;

 l_Tops := AdjustInfo(LoginCaptionLabel, LoginLabel, 16, lp_GetDelta);
 l_Tops := AdjustInfo(UserCaptionLabel, UserNameLabel, l_Tops, lp_GetDelta);
 l_Tops := AdjustInfo(EMailCaptionLabel, EMailLabel, l_Tops, lp_GetDelta);

 UserInfoGroupBox.Height := l_Tops + c_Delta;

 with OkButton do
 begin
  Top := UserInfoGroupBox.Top + UserInfoGroupBox.Height + lp_GetDelta * 2;
  Left := Self.ClientWidth - Width - lp_GetDelta;
  Self.ClientHeight := Top + Height + lp_GetDelta;
  Default := True;
  Cancel := True;
  ModalResult := mrOk;

  Caption := str_vtMsgDlgOK.AsStr;
 end;

 with CopyrightCaptionLabel do
 begin
  AutoSize := True;
  Left := 10;
  Top := OkButton.Top + (OkButton.Height - Height) div 2;
  Transparent := True;
  Alignment := taRightJustify;
  WordWrap := False;
 end;

//#UC END# *4A8E8F2E0195_4ABB6F3F001B_impl*
end;//TefAbout.InitControls

procedure TefAbout.MakeControls;
begin
 inherited;
 with AddUsertype(ut_AboutName,
  str_ut_AboutCaption,
  str_ut_AboutCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_AboutName
 f_pbLogo := TPaintBox.Create(Self);
 f_pbLogo.Name := 'pbLogo';
 f_pbLogo.Parent := Self;
 f_ShellInfoLabel := TvtLabel.Create(Self);
 f_ShellInfoLabel.Name := 'ShellInfoLabel';
 f_ShellInfoLabel.Parent := Self;
 f_AdapterInfoLabel := TvtLabel.Create(Self);
 f_AdapterInfoLabel.Name := 'AdapterInfoLabel';
 f_AdapterInfoLabel.Parent := Self;
 f_UserCountLabel := TvtLabel.Create(Self);
 f_UserCountLabel.Name := 'UserCountLabel';
 f_UserCountLabel.Parent := Self;
 f_OwnerLabel := TvtLabel.Create(Self);
 f_OwnerLabel.Name := 'OwnerLabel';
 f_OwnerLabel.Parent := Self;
 f_ShellCaptionLabel := TvtLabel.Create(Self);
 f_ShellCaptionLabel.Name := 'ShellCaptionLabel';
 f_ShellCaptionLabel.Parent := Self;
 f_OwnerCaptionLabel := TvtLabel.Create(Self);
 f_OwnerCaptionLabel.Name := 'OwnerCaptionLabel';
 f_OwnerCaptionLabel.Parent := Self;
 f_UserInfoGroupBox := TvtGroupBox.Create(Self);
 f_UserInfoGroupBox.Name := 'UserInfoGroupBox';
 f_UserInfoGroupBox.Parent := Self;
 f_EMailCaptionLabel := TvtLabel.Create(Self);
 f_EMailCaptionLabel.Name := 'EMailCaptionLabel';
 f_EMailCaptionLabel.Parent := UserInfoGroupBox;
 f_EMailLabel := TvtLabel.Create(Self);
 f_EMailLabel.Name := 'EMailLabel';
 f_EMailLabel.Parent := UserInfoGroupBox;
 f_LoginCaptionLabel := TvtLabel.Create(Self);
 f_LoginCaptionLabel.Name := 'LoginCaptionLabel';
 f_LoginCaptionLabel.Parent := UserInfoGroupBox;
 f_UserCaptionLabel := TvtLabel.Create(Self);
 f_UserCaptionLabel.Name := 'UserCaptionLabel';
 f_UserCaptionLabel.Parent := UserInfoGroupBox;
 f_UserNameLabel := TvtLabel.Create(Self);
 f_UserNameLabel.Name := 'UserNameLabel';
 f_UserNameLabel.Parent := UserInfoGroupBox;
 f_LoginLabel := TvtLabel.Create(Self);
 f_LoginLabel.Name := 'LoginLabel';
 f_LoginLabel.Parent := UserInfoGroupBox;
 f_CopyrightCaptionLabel := TvtLabel.Create(Self);
 f_CopyrightCaptionLabel.Name := 'CopyrightCaptionLabel';
 f_CopyrightCaptionLabel.Parent := Self;
 f_OkButton := TvtButton.Create(Self);
 f_OkButton.Name := 'OkButton';
 f_OkButton.Parent := Self;
 f_UserCountCaptionLabel := TvtLabel.Create(Self);
 f_UserCountCaptionLabel.Name := 'UserCountCaptionLabel';
 f_UserCountCaptionLabel.Parent := Self;
 f_AdapterCaptionLabel := TvtLabel.Create(Self);
 f_AdapterCaptionLabel.Name := 'AdapterCaptionLabel';
 f_AdapterCaptionLabel.Parent := Self;
end;//TefAbout.MakeControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefAbout);
 {* Регистрация About }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efAbout.SetFactory(TefAbout.Make);
 {* Регистрация фабрики формы About }
 str_ut_AboutCaption.Init;
 {* Инициализация str_ut_AboutCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.

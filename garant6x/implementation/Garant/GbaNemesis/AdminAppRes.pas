unit AdminAppRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/AdminAppRes.pas"
// �����: 07.09.2009 18:25
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMApplication::Class>> F1 �������������::Admin$Shell::AdminApp
//
// �������� Admin
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If defined(Nemesis)}
  ,
  nscNavigator
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel,
  PrimF1Res,
  PrimAdminMain_Form,
  l3StringIDEx,
  PrimMainOptions_Form
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  
  {$If defined(Nemesis)}
  ,
  nscStatusBar
  {$IfEnd} //Nemesis
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  AdminMain_Form
  {$If not defined(NoScripts)}
  ,
  tfwControlString
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwPropertyLike
  {$IfEnd} //not NoScripts
  
  {$If defined(Admin) AND not defined(NoScripts)}
  ,
  AdminMainKeywordsPack
  {$IfEnd} //Admin AND not NoScripts
  ,
  vcmExternalInterfaces {a}
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactory
  {$IfEnd} //not NoVCM
  ,
  AdminInterfaces,
  PrimUserProperty_admUseProperties_UserType,
  PrimGroupList_admGroupList_UserType,
  PrimUserList_admUserList_UserType,
  PrimAdmin_utAdmin_UserType,
  Admin_FormDefinitions_Controls
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtLabel,
  vtGroupBox,
  eeTreeView
  {$If defined(Nemesis)}
  ,
  nscContextFilter
  {$IfEnd} //Nemesis
  ,
  vtComboBoxQS,
  vtCheckBox,
  vcmMainForm {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
var
 { ������������ ������ AdminTitle }
str_AdminTitle : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AdminTitle'; rValue : '������ ����');
 { '������ ����' }

type
TAdminAppRes = {final} class(TPrimF1Res)
 {* �������� Admin }
protected
   procedure RegisterFormSetFactories; override;
   class procedure RegisterModules(aMain: TvcmMainForm); override;
   procedure Loaded; override;
protected
// overridden protected methods
   class procedure DoRun(var theSplash: IUnknown); override;
 public
 // modules operations
   class procedure OpenUserList(const aContainer: IvcmContainer);
   class function ShowRenameGroupDialog(const aData: IbsEditGroupName): Integer;
 public
 // operations codes
   class function opcode_Result_Cancel : TvcmOpID;
     { ��������� ������� -> ������ }
   class function opcode_Result_Ok : TvcmOpID;
     { ��������� ������� -> OK }
   class function opcode_Result_Save : TvcmOpID;
     {  -> ��������� }
   class function opcode_Switcher_BecomeActive : TvcmOpID;
     { �������� ��� ���������� ���������� �����-���������� ->  }
   class function opcode_Switcher_SetFirstPageActive : TvcmOpID;
     { �������� ��� ���������� ���������� �����-���������� ->  }
   class function opcode_Result_OkExt : TvcmOpID;
     { ��������� ������� -> OK }
end;//TAdminAppRes
TvcmApplicationRef = TAdminAppRes;
 {* ������ �� ���������� ��� DesignTime ���������� }

{$IfEnd} //Admin

implementation

{$If defined(Admin)}
uses
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmSettings
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  moAdmin,
  nsStartupSupport
  {$If not defined(NoScripts)}
  ,
  tfwScriptingTypes
  {$IfEnd} //not NoScripts
  ,
  TypInfo,
  SysUtils
  {$If not defined(NoScripts)}
  ,
  tfwTypeRegistrator
  {$IfEnd} //not NoScripts
  ,
  evExtFormat,
  Admin_Module
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  ,
  Admin_Users_Controls,
  F1Like_InternalOperations_Controls
  {$If not defined(NoVCM)}
  ,
  OfficeLike_ResultEx_Controls
  {$IfEnd} //not NoVCM
  ,
  fsAdmin
  ;
{$IfEnd} //Admin

{$If defined(Admin)}

// start class TAdminAppRes

class procedure TAdminAppRes.DoRun(var theSplash: IUnknown);
//#UC START# *4AA7E4DC0047_4AA517B5037A_var*
var
 l_Main : TAdminMainForm;
//#UC END# *4AA7E4DC0047_4AA517B5037A_var*
begin
//#UC START# *4AA7E4DC0047_4AA517B5037A_impl*
 inherited;
 Application.CreateForm(TAdminMainForm, l_Main);
//#UC END# *4AA7E4DC0047_4AA517B5037A_impl*
end;//TAdminAppRes.DoRun

procedure TAdminAppRes.RegisterFormSetFactories;
begin
 inherited;
 RegisterFormSetFactory(Tfs_Admin);
end;

class procedure TAdminAppRes.RegisterModules(aMain: TvcmMainForm);
begin
 inherited;
 aMain.RegisterModule(Tmo_Admin);
end;

var
 g_opcode_Result_Cancel : TvcmOpID;
 g_opcode_Result_Ok : TvcmOpID;
 g_opcode_Result_Save : TvcmOpID;
 g_opcode_Switcher_BecomeActive : TvcmOpID;
 g_opcode_Switcher_SetFirstPageActive : TvcmOpID;
 g_opcode_Result_OkExt : TvcmOpID;

procedure TAdminAppRes.Loaded;
begin
 inherited;
 PublishModule(Tmo_Admin, '����������������� �������������');
 g_opcode_Result_Cancel :=
  PublishOperation(en_Result,
                    op_Cancel,
                    en_capResult,
                    op_capCancel);
 g_opcode_Result_Ok :=
  PublishOperation(en_Result,
                    op_Ok,
                    en_capResult,
                    op_capOk);
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'Search') do
  begin
   st_user_Result_Ok_Search := StateIndex;
   Caption := '������';
   Hint := '�������� ����� �� ��������� ����������';
  end;//with PublishOperationState(en_Result, op_Ok, 'Search')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'Print') do
  begin
   st_user_Result_Ok_Print := StateIndex;
   Caption := '������';
   ImageIndex := 3;
  end;//with PublishOperationState(en_Result, op_Ok, 'Print')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'AttributesSelect') do
  begin
   st_user_Result_Ok_AttributesSelect := StateIndex;
   Caption := '����������� ����� ���������';
  end;//with PublishOperationState(en_Result, op_Ok, 'AttributesSelect')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'ConsultationMark') do
  begin
   st_user_Result_Ok_ConsultationMark := StateIndex;
   Caption := '�������';
  end;//with PublishOperationState(en_Result, op_Ok, 'ConsultationMark')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'Analize') do
  begin
   st_user_Result_Ok_Analize := StateIndex;
   Caption := '���������';
  end;//with PublishOperationState(en_Result, op_Ok, 'Analize')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Cancel, 'Close') do
  begin
   st_user_Result_Cancel_Close := StateIndex;
   Caption := '�������';
  end;//with PublishOperationState(en_Result, op_Cancel, 'Close')
 {$IfEnd} //not NoVCM
 PublishOperation(en_Edit,
                    op_Delete,
                    en_capEdit,
                    op_capDelete);
 {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoVCM)}
  with PublishOperationState(en_Edit, op_Delete, 'Controlled') do
  begin
   st_user_Edit_Delete_Controlled := StateIndex;
   Caption := '����� � ��������';
  end;//with PublishOperationState(en_Edit, op_Delete, 'Controlled')
 {$IfEnd} //not Admin AND not Monitorings AND not NoVCM
 {$If defined(Admin) AND not defined(NoVCM)}
  with PublishOperationState(en_Edit, op_Delete, 'User') do
  begin
   st_user_Edit_Delete_User := StateIndex;
   Caption := '������� ������������';
   ImageIndex := 149;
  end;//with PublishOperationState(en_Edit, op_Delete, 'User')
 {$IfEnd} //Admin AND not NoVCM
 {$If defined(Admin) AND not defined(NoVCM)}
  with PublishOperationState(en_Edit, op_Delete, 'MultiUsers') do
  begin
   st_user_Edit_Delete_MultiUsers := StateIndex;
   Caption := '������� ���������� �������������';
   ImageIndex := 149;
  end;//with PublishOperationState(en_Edit, op_Delete, 'MultiUsers')
 {$IfEnd} //Admin AND not NoVCM
 {$If defined(Admin) AND not defined(NoVCM)}
  with PublishOperationState(en_Edit, op_Delete, 'Group') do
  begin
   st_user_Edit_Delete_Group := StateIndex;
   Caption := '������� ������';
   ImageIndex := 193;
  end;//with PublishOperationState(en_Edit, op_Delete, 'Group')
 {$IfEnd} //Admin AND not NoVCM
 {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoVCM)}
  with PublishOperationState(en_Edit, op_Delete, 'Contact') do
  begin
   st_user_Edit_Delete_Contact := StateIndex;
   Caption := '������� ������������';
  end;//with PublishOperationState(en_Edit, op_Delete, 'Contact')
 {$IfEnd} //not Admin AND not Monitorings AND not NoVCM
 PublishOperation(en_Users,
                    op_LogoutUser,
                    en_capUsers,
                    op_capLogoutUser);
  with PublishOperationState(en_Users, op_LogoutUser, 'SingleUser') do
  begin
   st_user_Users_LogoutUser_SingleUser := StateIndex;
  end;//with PublishOperationState(en_Users, op_LogoutUser, 'SingleUser')
  with PublishOperationState(en_Users, op_LogoutUser, 'MultiUsers') do
  begin
   st_user_Users_LogoutUser_MultiUsers := StateIndex;
   Caption := '��������� ���������� �������������';
  end;//with PublishOperationState(en_Users, op_LogoutUser, 'MultiUsers')
 PublishOperation(en_Users,
                    op_ConsultingStateForNewbie,
                    en_capUsers,
                    op_capConsultingStateForNewbie);
  with PublishOperationState(en_Users, op_ConsultingStateForNewbie, 'Enabled') do
  begin
   st_user_Users_ConsultingStateForNewbie_Enabled := StateIndex;
   Caption := '��������� ����� ��������� ������������� ������������� ������ ��������� �����������';
   ImageIndex := 163;
  end;//with PublishOperationState(en_Users, op_ConsultingStateForNewbie, 'Enabled')
  with PublishOperationState(en_Users, op_ConsultingStateForNewbie, 'Disabled') do
  begin
   st_user_Users_ConsultingStateForNewbie_Disabled := StateIndex;
   Caption := '��������� ����� ��������� ������������� ������������� ������ ��������� �����������';
   Checked := true;
  end;//with PublishOperationState(en_Users, op_ConsultingStateForNewbie, 'Disabled')
 PublishOperation(en_Users,
                    op_Autoregistration,
                    en_capUsers,
                    op_capAutoregistration);
  with PublishOperationState(en_Users, op_Autoregistration, 'Enabled') do
  begin
   st_user_Users_Autoregistration_Enabled := StateIndex;
   Caption := '��������� ��������������� ����� �������������';
   ImageIndex := 171;
  end;//with PublishOperationState(en_Users, op_Autoregistration, 'Enabled')
  with PublishOperationState(en_Users, op_Autoregistration, 'Disabled') do
  begin
   st_user_Users_Autoregistration_Disabled := StateIndex;
   Caption := '��������� ��������������� ����� �������������';
   Checked := true;
  end;//with PublishOperationState(en_Users, op_Autoregistration, 'Disabled')
 PublishOperation(en_Users,
                    op_AddPrivelegedRight,
                    en_capUsers,
                    op_capAddPrivelegedRight);
  with PublishOperationState(en_Users, op_AddPrivelegedRight, 'MultiUsers') do
  begin
   st_user_Users_AddPrivelegedRight_MultiUsers := StateIndex;
  end;//with PublishOperationState(en_Users, op_AddPrivelegedRight, 'MultiUsers')
  with PublishOperationState(en_Users, op_AddPrivelegedRight, 'SingleUser') do
  begin
   st_user_Users_AddPrivelegedRight_SingleUser := StateIndex;
   Caption := '������� �����������������';
  end;//with PublishOperationState(en_Users, op_AddPrivelegedRight, 'SingleUser')
 PublishOperation(en_Users,
                    op_RemovePrivelegedRight,
                    en_capUsers,
                    op_capRemovePrivelegedRight);
  with PublishOperationState(en_Users, op_RemovePrivelegedRight, 'MultiUsers') do
  begin
   st_user_Users_RemovePrivelegedRight_MultiUsers := StateIndex;
  end;//with PublishOperationState(en_Users, op_RemovePrivelegedRight, 'MultiUsers')
  with PublishOperationState(en_Users, op_RemovePrivelegedRight, 'SingleUser') do
  begin
   st_user_Users_RemovePrivelegedRight_SingleUser := StateIndex;
   Caption := '�������� ����� ����������';
  end;//with PublishOperationState(en_Users, op_RemovePrivelegedRight, 'SingleUser')
 PublishOperation(en_Users,
                    op_UserFilter,
                    en_capUsers,
                    op_capUserFilter);
 PublishOperation(en_Users,
                    op_DisableConsulting,
                    en_capUsers,
                    op_capDisableConsulting);
 PublishOperation(en_Users,
                    op_EnableConsulting,
                    en_capUsers,
                    op_capEnableConsulting);
 PublishOperation(en_Users,
                    op_MakeFiltersShared,
                    en_capUsers,
                    op_capMakeFiltersShared);
 PublishOperation(en_Users,
                    op_DenyDeleteIdle,
                    en_capUsers,
                    op_capDenyDeleteIdle);
 PublishOperation(en_Users,
                    op_Add,
                    en_capUsers,
                    op_capAdd);
 g_opcode_Result_Save :=
  PublishOperation(en_Result,
                    op_Save,
                    en_capResult,
                    op_capSave);
  with PublishOperationState(en_Result, op_Save, 'Create') do
  begin
   st_user_Result_Save_Create := StateIndex;
   Caption := '�������';
  end;//with PublishOperationState(en_Result, op_Save, 'Create')
 PublishOperation(en_Groups,
                    op_Add,
                    en_capGroups,
                    op_capAdd);
 PublishOperation(en_Groups,
                    op_ChangeBaseAccess,
                    en_capGroups,
                    op_capChangeBaseAccess);
 PublishOperation(en_Groups,
                    op_Rename,
                    en_capGroups,
                    op_capRename);
 g_opcode_Switcher_BecomeActive :=
  PublishInternalOperation(en_Switcher,
                    op_BecomeActive,
                    en_capSwitcher,
                    op_capBecomeActive);
 g_opcode_Switcher_SetFirstPageActive :=
  PublishInternalOperation(en_Switcher,
                    op_SetFirstPageActive,
                    en_capSwitcher,
                    op_capSetFirstPageActive);
 g_opcode_Result_OkExt :=
  PublishOperation(en_Result,
                    op_OkExt,
                    en_capResult,
                    op_capOkExt);
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_OkExt, 'Search') do
  begin
   st_user_Result_OkExt_Search := StateIndex;
   Caption := '������';
   Hint := '�������� ����� �� ��������� ����������';
  end;//with PublishOperationState(en_Result, op_OkExt, 'Search')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_OkExt, 'Save') do
  begin
   st_user_Result_OkExt_Save := StateIndex;
   Caption := '���������';
   Hint := '���������';
  end;//with PublishOperationState(en_Result, op_OkExt, 'Save')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_OkExt, 'AttributesSelect') do
  begin
   st_user_Result_OkExt_AttributesSelect := StateIndex;
  end;//with PublishOperationState(en_Result, op_OkExt, 'AttributesSelect')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_OkExt, 'Consult') do
  begin
   st_user_Result_OkExt_Consult := StateIndex;
   Caption := '��������� ������';
   ImageIndex := 154;
  end;//with PublishOperationState(en_Result, op_OkExt, 'Consult')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_OkExt, 'Chat') do
  begin
   st_user_Result_OkExt_Chat := StateIndex;
   Caption := '��������� (Ctrl+Enter)';
  end;//with PublishOperationState(en_Result, op_OkExt, 'Chat')
 {$IfEnd} //not NoVCM
 {$If not defined(Monitorings) AND not defined(NoVCM)}
  with PublishOperationState(en_Result, op_OkExt, 'SaveAndSend') do
  begin
   st_user_Result_OkExt_SaveAndSend := StateIndex;
   Caption := '��������� � ���������';
   Hint := '��������� � ���������';
  end;//with PublishOperationState(en_Result, op_OkExt, 'SaveAndSend')
 {$IfEnd} //not Monitorings AND not NoVCM
end;

// modules operations

class procedure TAdminAppRes.OpenUserList(const aContainer: IvcmContainer);
begin
 TAdminModule.OpenUserList(aContainer);
end;

class function TAdminAppRes.ShowRenameGroupDialog(const aData: IbsEditGroupName): Integer;
begin
 Result := TAdminModule.ShowRenameGroupDialog(aData);
end;

// operations codes

class function TAdminAppRes.opcode_Result_Cancel : TvcmOpID;
begin
 Result := g_opcode_Result_Cancel;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TAdminAppRes.opcode_Result_Ok : TvcmOpID;
begin
 Result := g_opcode_Result_Ok;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TAdminAppRes.opcode_Result_Save : TvcmOpID;
begin
 Result := g_opcode_Result_Save;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TAdminAppRes.opcode_Switcher_BecomeActive : TvcmOpID;
begin
 Result := g_opcode_Switcher_BecomeActive;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TAdminAppRes.opcode_Switcher_SetFirstPageActive : TvcmOpID;
begin
 Result := g_opcode_Switcher_SetFirstPageActive;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TAdminAppRes.opcode_Result_OkExt : TvcmOpID;
begin
 Result := g_opcode_Result_OkExt;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

{$IfEnd} //Admin

initialization
{$If defined(Admin)}
// ������������� str_AdminTitle
 str_AdminTitle.Init;
{$IfEnd} //Admin

end.
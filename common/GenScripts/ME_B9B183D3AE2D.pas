unit SelfInfoKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� SelfInfo }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\SelfInfoKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Settings_Module
 , vtPanel
 , vtLabel
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 , ElPopBtn
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , vtFocusLabel
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_SelfInfo = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� SelfInfo
----
*������ �������������*:
[code]
'aControl' �����::SelfInfo TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_SelfInfo

 Tkw_SelfInfo_Control_pnMainData = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnMainData
----
*������ �������������*:
[code]
�������::pnMainData TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_pnMainData

 Tkw_SelfInfo_Control_pnMainData_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnMainData
----
*������ �������������*:
[code]
�������::pnMainData:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_pnMainData_Push

 Tkw_SelfInfo_Control_UserNameLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� UserNameLabel
----
*������ �������������*:
[code]
�������::UserNameLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_UserNameLabel

 Tkw_SelfInfo_Control_UserNameLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� UserNameLabel
----
*������ �������������*:
[code]
�������::UserNameLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_UserNameLabel_Push

 Tkw_SelfInfo_Control_PasswordLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� PasswordLabel
----
*������ �������������*:
[code]
�������::PasswordLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_PasswordLabel

 Tkw_SelfInfo_Control_PasswordLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� PasswordLabel
----
*������ �������������*:
[code]
�������::PasswordLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_PasswordLabel_Push

 Tkw_SelfInfo_Control_LoginLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� LoginLabel
----
*������ �������������*:
[code]
�������::LoginLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_LoginLabel

 Tkw_SelfInfo_Control_LoginLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� LoginLabel
----
*������ �������������*:
[code]
�������::LoginLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_LoginLabel_Push

 Tkw_SelfInfo_Control_InfoLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� InfoLabel
----
*������ �������������*:
[code]
�������::InfoLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_InfoLabel

 Tkw_SelfInfo_Control_InfoLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� InfoLabel
----
*������ �������������*:
[code]
�������::InfoLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_InfoLabel_Push

 Tkw_SelfInfo_Control_EMailLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� EMailLabel
----
*������ �������������*:
[code]
�������::EMailLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_EMailLabel

 Tkw_SelfInfo_Control_EMailLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� EMailLabel
----
*������ �������������*:
[code]
�������::EMailLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_EMailLabel_Push

 Tkw_SelfInfo_Control_ConfirmPasswordLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ConfirmPasswordLabel
----
*������ �������������*:
[code]
�������::ConfirmPasswordLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel

 Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ConfirmPasswordLabel
----
*������ �������������*:
[code]
�������::ConfirmPasswordLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push

 Tkw_SelfInfo_Control_vtAsteriskLabelLogin = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� vtAsteriskLabelLogin
----
*������ �������������*:
[code]
�������::vtAsteriskLabelLogin TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin

 Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� vtAsteriskLabelLogin
----
*������ �������������*:
[code]
�������::vtAsteriskLabelLogin:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push

 Tkw_SelfInfo_Control_vtAsteriskLabelFIO = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� vtAsteriskLabelFIO
----
*������ �������������*:
[code]
�������::vtAsteriskLabelFIO TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO

 Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� vtAsteriskLabelFIO
----
*������ �������������*:
[code]
�������::vtAsteriskLabelFIO:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push

 Tkw_SelfInfo_Control_edPassword = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� edPassword
----
*������ �������������*:
[code]
�������::edPassword TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_edPassword

 Tkw_SelfInfo_Control_edPassword_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edPassword
----
*������ �������������*:
[code]
�������::edPassword:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_edPassword_Push

 Tkw_SelfInfo_Control_edUserName = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� edUserName
----
*������ �������������*:
[code]
�������::edUserName TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_edUserName

 Tkw_SelfInfo_Control_edUserName_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edUserName
----
*������ �������������*:
[code]
�������::edUserName:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_edUserName_Push

 Tkw_SelfInfo_Control_edLogin = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� edLogin
----
*������ �������������*:
[code]
�������::edLogin TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_edLogin

 Tkw_SelfInfo_Control_edLogin_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edLogin
----
*������ �������������*:
[code]
�������::edLogin:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_edLogin_Push

 Tkw_SelfInfo_Control_edEmail = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� edEmail
----
*������ �������������*:
[code]
�������::edEmail TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_edEmail

 Tkw_SelfInfo_Control_edEmail_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edEmail
----
*������ �������������*:
[code]
�������::edEmail:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_edEmail_Push

 Tkw_SelfInfo_Control_edConfirm = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� edConfirm
----
*������ �������������*:
[code]
�������::edConfirm TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_edConfirm

 Tkw_SelfInfo_Control_edConfirm_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edConfirm
----
*������ �������������*:
[code]
�������::edConfirm:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_edConfirm_Push

 Tkw_SelfInfo_Control_BottomPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BottomPanel
----
*������ �������������*:
[code]
�������::BottomPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_BottomPanel

 Tkw_SelfInfo_Control_BottomPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� BottomPanel
----
*������ �������������*:
[code]
�������::BottomPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_BottomPanel_Push

 Tkw_SelfInfo_Control_RegisterButton = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� RegisterButton
----
*������ �������������*:
[code]
�������::RegisterButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_RegisterButton

 Tkw_SelfInfo_Control_RegisterButton_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� RegisterButton
----
*������ �������������*:
[code]
�������::RegisterButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_RegisterButton_Push

 Tkw_SelfInfo_Control_HelpPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� HelpPanel
----
*������ �������������*:
[code]
�������::HelpPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_HelpPanel

 Tkw_SelfInfo_Control_HelpPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� HelpPanel
----
*������ �������������*:
[code]
�������::HelpPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_HelpPanel_Push

 Tkw_SelfInfo_Control_HelpPaintBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� HelpPaintBox
----
*������ �������������*:
[code]
�������::HelpPaintBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_HelpPaintBox

 Tkw_SelfInfo_Control_HelpPaintBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� HelpPaintBox
----
*������ �������������*:
[code]
�������::HelpPaintBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_HelpPaintBox_Push

 Tkw_SelfInfo_Control_HelpLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� HelpLabel
----
*������ �������������*:
[code]
�������::HelpLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SelfInfo_Control_HelpLabel

 Tkw_SelfInfo_Control_HelpLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� HelpLabel
----
*������ �������������*:
[code]
�������::HelpLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_HelpLabel_Push

 TkwSelfInfoFormPnMainData = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.pnMainData
[panel]������� pnMainData ����� TSelfInfoForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aSelfInfoForm .TSelfInfoForm.pnMainData >>> l_TvtPanel
[code]  }
  private
   function pnMainData(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtPanel;
    {* ���������� ����� ������� .TSelfInfoForm.pnMainData }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormPnMainData

 TkwSelfInfoFormUserNameLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.UserNameLabel
[panel]������� UserNameLabel ����� TSelfInfoForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aSelfInfoForm .TSelfInfoForm.UserNameLabel >>> l_TvtLabel
[code]  }
  private
   function UserNameLabel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtLabel;
    {* ���������� ����� ������� .TSelfInfoForm.UserNameLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormUserNameLabel

 TkwSelfInfoFormPasswordLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.PasswordLabel
[panel]������� PasswordLabel ����� TSelfInfoForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aSelfInfoForm .TSelfInfoForm.PasswordLabel >>> l_TvtLabel
[code]  }
  private
   function PasswordLabel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtLabel;
    {* ���������� ����� ������� .TSelfInfoForm.PasswordLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormPasswordLabel

 TkwSelfInfoFormLoginLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.LoginLabel
[panel]������� LoginLabel ����� TSelfInfoForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aSelfInfoForm .TSelfInfoForm.LoginLabel >>> l_TvtLabel
[code]  }
  private
   function LoginLabel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtLabel;
    {* ���������� ����� ������� .TSelfInfoForm.LoginLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormLoginLabel

 TkwSelfInfoFormInfoLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.InfoLabel
[panel]������� InfoLabel ����� TSelfInfoForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aSelfInfoForm .TSelfInfoForm.InfoLabel >>> l_TvtLabel
[code]  }
  private
   function InfoLabel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtLabel;
    {* ���������� ����� ������� .TSelfInfoForm.InfoLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormInfoLabel

 TkwSelfInfoFormEMailLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.EMailLabel
[panel]������� EMailLabel ����� TSelfInfoForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aSelfInfoForm .TSelfInfoForm.EMailLabel >>> l_TvtLabel
[code]  }
  private
   function EMailLabel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtLabel;
    {* ���������� ����� ������� .TSelfInfoForm.EMailLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormEMailLabel

 TkwSelfInfoFormConfirmPasswordLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.ConfirmPasswordLabel
[panel]������� ConfirmPasswordLabel ����� TSelfInfoForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aSelfInfoForm .TSelfInfoForm.ConfirmPasswordLabel >>> l_TvtLabel
[code]  }
  private
   function ConfirmPasswordLabel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtLabel;
    {* ���������� ����� ������� .TSelfInfoForm.ConfirmPasswordLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormConfirmPasswordLabel

 TkwSelfInfoFormVtAsteriskLabelLogin = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.vtAsteriskLabelLogin
[panel]������� vtAsteriskLabelLogin ����� TSelfInfoForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aSelfInfoForm .TSelfInfoForm.vtAsteriskLabelLogin >>> l_TvtLabel
[code]  }
  private
   function vtAsteriskLabelLogin(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtLabel;
    {* ���������� ����� ������� .TSelfInfoForm.vtAsteriskLabelLogin }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormVtAsteriskLabelLogin

 TkwSelfInfoFormVtAsteriskLabelFIO = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.vtAsteriskLabelFIO
[panel]������� vtAsteriskLabelFIO ����� TSelfInfoForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aSelfInfoForm .TSelfInfoForm.vtAsteriskLabelFIO >>> l_TvtLabel
[code]  }
  private
   function vtAsteriskLabelFIO(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtLabel;
    {* ���������� ����� ������� .TSelfInfoForm.vtAsteriskLabelFIO }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormVtAsteriskLabelFIO

 TkwSelfInfoFormEdPassword = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.edPassword
[panel]������� edPassword ����� TSelfInfoForm[panel]
*��� ����������:* TnscComboBoxWithPwdChar
*������:*
[code]
OBJECT VAR l_TnscComboBoxWithPwdChar
 aSelfInfoForm .TSelfInfoForm.edPassword >>> l_TnscComboBoxWithPwdChar
[code]  }
  private
   function edPassword(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TnscComboBoxWithPwdChar;
    {* ���������� ����� ������� .TSelfInfoForm.edPassword }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormEdPassword

 TkwSelfInfoFormEdUserName = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.edUserName
[panel]������� edUserName ����� TSelfInfoForm[panel]
*��� ����������:* TnscEdit
*������:*
[code]
OBJECT VAR l_TnscEdit
 aSelfInfoForm .TSelfInfoForm.edUserName >>> l_TnscEdit
[code]  }
  private
   function edUserName(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TnscEdit;
    {* ���������� ����� ������� .TSelfInfoForm.edUserName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormEdUserName

 TkwSelfInfoFormEdLogin = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.edLogin
[panel]������� edLogin ����� TSelfInfoForm[panel]
*��� ����������:* TnscEdit
*������:*
[code]
OBJECT VAR l_TnscEdit
 aSelfInfoForm .TSelfInfoForm.edLogin >>> l_TnscEdit
[code]  }
  private
   function edLogin(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TnscEdit;
    {* ���������� ����� ������� .TSelfInfoForm.edLogin }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormEdLogin

 TkwSelfInfoFormEdEmail = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.edEmail
[panel]������� edEmail ����� TSelfInfoForm[panel]
*��� ����������:* TnscEdit
*������:*
[code]
OBJECT VAR l_TnscEdit
 aSelfInfoForm .TSelfInfoForm.edEmail >>> l_TnscEdit
[code]  }
  private
   function edEmail(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TnscEdit;
    {* ���������� ����� ������� .TSelfInfoForm.edEmail }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormEdEmail

 TkwSelfInfoFormEdConfirm = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.edConfirm
[panel]������� edConfirm ����� TSelfInfoForm[panel]
*��� ����������:* TnscComboBoxWithPwdChar
*������:*
[code]
OBJECT VAR l_TnscComboBoxWithPwdChar
 aSelfInfoForm .TSelfInfoForm.edConfirm >>> l_TnscComboBoxWithPwdChar
[code]  }
  private
   function edConfirm(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TnscComboBoxWithPwdChar;
    {* ���������� ����� ������� .TSelfInfoForm.edConfirm }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormEdConfirm

 TkwSelfInfoFormBottomPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.BottomPanel
[panel]������� BottomPanel ����� TSelfInfoForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aSelfInfoForm .TSelfInfoForm.BottomPanel >>> l_TvtPanel
[code]  }
  private
   function BottomPanel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtPanel;
    {* ���������� ����� ������� .TSelfInfoForm.BottomPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormBottomPanel

 TkwSelfInfoFormRegisterButton = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.RegisterButton
[panel]������� RegisterButton ����� TSelfInfoForm[panel]
*��� ����������:* TElPopupButton
*������:*
[code]
OBJECT VAR l_TElPopupButton
 aSelfInfoForm .TSelfInfoForm.RegisterButton >>> l_TElPopupButton
[code]  }
  private
   function RegisterButton(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TElPopupButton;
    {* ���������� ����� ������� .TSelfInfoForm.RegisterButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormRegisterButton

 TkwSelfInfoFormHelpPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.HelpPanel
[panel]������� HelpPanel ����� TSelfInfoForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aSelfInfoForm .TSelfInfoForm.HelpPanel >>> l_TvtPanel
[code]  }
  private
   function HelpPanel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtPanel;
    {* ���������� ����� ������� .TSelfInfoForm.HelpPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormHelpPanel

 TkwSelfInfoFormHelpPaintBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.HelpPaintBox
[panel]������� HelpPaintBox ����� TSelfInfoForm[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aSelfInfoForm .TSelfInfoForm.HelpPaintBox >>> l_TPaintBox
[code]  }
  private
   function HelpPaintBox(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TPaintBox;
    {* ���������� ����� ������� .TSelfInfoForm.HelpPaintBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormHelpPaintBox

 TkwSelfInfoFormHelpLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.HelpLabel
[panel]������� HelpLabel ����� TSelfInfoForm[panel]
*��� ����������:* TvtFocusLabel
*������:*
[code]
OBJECT VAR l_TvtFocusLabel
 aSelfInfoForm .TSelfInfoForm.HelpLabel >>> l_TvtFocusLabel
[code]  }
  private
   function HelpLabel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtFocusLabel;
    {* ���������� ����� ������� .TSelfInfoForm.HelpLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSelfInfoFormHelpLabel

class function Tkw_Form_SelfInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::SelfInfo';
end;//Tkw_Form_SelfInfo.GetWordNameForRegister

function Tkw_Form_SelfInfo.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_BCC0E231ADA3_var*
//#UC END# *4DDFD2EA0116_BCC0E231ADA3_var*
begin
//#UC START# *4DDFD2EA0116_BCC0E231ADA3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_BCC0E231ADA3_impl*
end;//Tkw_Form_SelfInfo.GetString

class function Tkw_SelfInfo_Control_pnMainData.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnMainData';
end;//Tkw_SelfInfo_Control_pnMainData.GetWordNameForRegister

function Tkw_SelfInfo_Control_pnMainData.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_8C0F71C5C616_var*
//#UC END# *4DDFD2EA0116_8C0F71C5C616_var*
begin
//#UC START# *4DDFD2EA0116_8C0F71C5C616_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_8C0F71C5C616_impl*
end;//Tkw_SelfInfo_Control_pnMainData.GetString

class procedure Tkw_SelfInfo_Control_pnMainData.RegisterInEngine;
//#UC START# *52A086150180_8C0F71C5C616_var*
//#UC END# *52A086150180_8C0F71C5C616_var*
begin
//#UC START# *52A086150180_8C0F71C5C616_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_8C0F71C5C616_impl*
end;//Tkw_SelfInfo_Control_pnMainData.RegisterInEngine

procedure Tkw_SelfInfo_Control_pnMainData_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C089789CD212_var*
//#UC END# *4DAEEDE10285_C089789CD212_var*
begin
//#UC START# *4DAEEDE10285_C089789CD212_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C089789CD212_impl*
end;//Tkw_SelfInfo_Control_pnMainData_Push.DoDoIt

class function Tkw_SelfInfo_Control_pnMainData_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnMainData:push';
end;//Tkw_SelfInfo_Control_pnMainData_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_UserNameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserNameLabel';
end;//Tkw_SelfInfo_Control_UserNameLabel.GetWordNameForRegister

function Tkw_SelfInfo_Control_UserNameLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_832C5468A954_var*
//#UC END# *4DDFD2EA0116_832C5468A954_var*
begin
//#UC START# *4DDFD2EA0116_832C5468A954_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_832C5468A954_impl*
end;//Tkw_SelfInfo_Control_UserNameLabel.GetString

class procedure Tkw_SelfInfo_Control_UserNameLabel.RegisterInEngine;
//#UC START# *52A086150180_832C5468A954_var*
//#UC END# *52A086150180_832C5468A954_var*
begin
//#UC START# *52A086150180_832C5468A954_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_832C5468A954_impl*
end;//Tkw_SelfInfo_Control_UserNameLabel.RegisterInEngine

procedure Tkw_SelfInfo_Control_UserNameLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A45767E00A39_var*
//#UC END# *4DAEEDE10285_A45767E00A39_var*
begin
//#UC START# *4DAEEDE10285_A45767E00A39_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A45767E00A39_impl*
end;//Tkw_SelfInfo_Control_UserNameLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_UserNameLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserNameLabel:push';
end;//Tkw_SelfInfo_Control_UserNameLabel_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_PasswordLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::PasswordLabel';
end;//Tkw_SelfInfo_Control_PasswordLabel.GetWordNameForRegister

function Tkw_SelfInfo_Control_PasswordLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_1D1DFA744C9A_var*
//#UC END# *4DDFD2EA0116_1D1DFA744C9A_var*
begin
//#UC START# *4DDFD2EA0116_1D1DFA744C9A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_1D1DFA744C9A_impl*
end;//Tkw_SelfInfo_Control_PasswordLabel.GetString

class procedure Tkw_SelfInfo_Control_PasswordLabel.RegisterInEngine;
//#UC START# *52A086150180_1D1DFA744C9A_var*
//#UC END# *52A086150180_1D1DFA744C9A_var*
begin
//#UC START# *52A086150180_1D1DFA744C9A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_1D1DFA744C9A_impl*
end;//Tkw_SelfInfo_Control_PasswordLabel.RegisterInEngine

procedure Tkw_SelfInfo_Control_PasswordLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BB2DEC5221CE_var*
//#UC END# *4DAEEDE10285_BB2DEC5221CE_var*
begin
//#UC START# *4DAEEDE10285_BB2DEC5221CE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BB2DEC5221CE_impl*
end;//Tkw_SelfInfo_Control_PasswordLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_PasswordLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::PasswordLabel:push';
end;//Tkw_SelfInfo_Control_PasswordLabel_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_LoginLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LoginLabel';
end;//Tkw_SelfInfo_Control_LoginLabel.GetWordNameForRegister

function Tkw_SelfInfo_Control_LoginLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_DA16FF2F43F9_var*
//#UC END# *4DDFD2EA0116_DA16FF2F43F9_var*
begin
//#UC START# *4DDFD2EA0116_DA16FF2F43F9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_DA16FF2F43F9_impl*
end;//Tkw_SelfInfo_Control_LoginLabel.GetString

class procedure Tkw_SelfInfo_Control_LoginLabel.RegisterInEngine;
//#UC START# *52A086150180_DA16FF2F43F9_var*
//#UC END# *52A086150180_DA16FF2F43F9_var*
begin
//#UC START# *52A086150180_DA16FF2F43F9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_DA16FF2F43F9_impl*
end;//Tkw_SelfInfo_Control_LoginLabel.RegisterInEngine

procedure Tkw_SelfInfo_Control_LoginLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_20C6EAA4E31E_var*
//#UC END# *4DAEEDE10285_20C6EAA4E31E_var*
begin
//#UC START# *4DAEEDE10285_20C6EAA4E31E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_20C6EAA4E31E_impl*
end;//Tkw_SelfInfo_Control_LoginLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_LoginLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LoginLabel:push';
end;//Tkw_SelfInfo_Control_LoginLabel_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_InfoLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::InfoLabel';
end;//Tkw_SelfInfo_Control_InfoLabel.GetWordNameForRegister

function Tkw_SelfInfo_Control_InfoLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_A9E603804883_var*
//#UC END# *4DDFD2EA0116_A9E603804883_var*
begin
//#UC START# *4DDFD2EA0116_A9E603804883_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_A9E603804883_impl*
end;//Tkw_SelfInfo_Control_InfoLabel.GetString

class procedure Tkw_SelfInfo_Control_InfoLabel.RegisterInEngine;
//#UC START# *52A086150180_A9E603804883_var*
//#UC END# *52A086150180_A9E603804883_var*
begin
//#UC START# *52A086150180_A9E603804883_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_A9E603804883_impl*
end;//Tkw_SelfInfo_Control_InfoLabel.RegisterInEngine

procedure Tkw_SelfInfo_Control_InfoLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A42455EA21A2_var*
//#UC END# *4DAEEDE10285_A42455EA21A2_var*
begin
//#UC START# *4DAEEDE10285_A42455EA21A2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A42455EA21A2_impl*
end;//Tkw_SelfInfo_Control_InfoLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_InfoLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::InfoLabel:push';
end;//Tkw_SelfInfo_Control_InfoLabel_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_EMailLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EMailLabel';
end;//Tkw_SelfInfo_Control_EMailLabel.GetWordNameForRegister

function Tkw_SelfInfo_Control_EMailLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C2402D53B366_var*
//#UC END# *4DDFD2EA0116_C2402D53B366_var*
begin
//#UC START# *4DDFD2EA0116_C2402D53B366_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C2402D53B366_impl*
end;//Tkw_SelfInfo_Control_EMailLabel.GetString

class procedure Tkw_SelfInfo_Control_EMailLabel.RegisterInEngine;
//#UC START# *52A086150180_C2402D53B366_var*
//#UC END# *52A086150180_C2402D53B366_var*
begin
//#UC START# *52A086150180_C2402D53B366_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_C2402D53B366_impl*
end;//Tkw_SelfInfo_Control_EMailLabel.RegisterInEngine

procedure Tkw_SelfInfo_Control_EMailLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4A4259920AE8_var*
//#UC END# *4DAEEDE10285_4A4259920AE8_var*
begin
//#UC START# *4DAEEDE10285_4A4259920AE8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4A4259920AE8_impl*
end;//Tkw_SelfInfo_Control_EMailLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_EMailLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EMailLabel:push';
end;//Tkw_SelfInfo_Control_EMailLabel_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_ConfirmPasswordLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ConfirmPasswordLabel';
end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel.GetWordNameForRegister

function Tkw_SelfInfo_Control_ConfirmPasswordLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_78E0A7B74076_var*
//#UC END# *4DDFD2EA0116_78E0A7B74076_var*
begin
//#UC START# *4DDFD2EA0116_78E0A7B74076_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_78E0A7B74076_impl*
end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel.GetString

class procedure Tkw_SelfInfo_Control_ConfirmPasswordLabel.RegisterInEngine;
//#UC START# *52A086150180_78E0A7B74076_var*
//#UC END# *52A086150180_78E0A7B74076_var*
begin
//#UC START# *52A086150180_78E0A7B74076_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_78E0A7B74076_impl*
end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel.RegisterInEngine

procedure Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_399D4AFC6437_var*
//#UC END# *4DAEEDE10285_399D4AFC6437_var*
begin
//#UC START# *4DAEEDE10285_399D4AFC6437_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_399D4AFC6437_impl*
end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ConfirmPasswordLabel:push';
end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_vtAsteriskLabelLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::vtAsteriskLabelLogin';
end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin.GetWordNameForRegister

function Tkw_SelfInfo_Control_vtAsteriskLabelLogin.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_6E6A5E595E1D_var*
//#UC END# *4DDFD2EA0116_6E6A5E595E1D_var*
begin
//#UC START# *4DDFD2EA0116_6E6A5E595E1D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_6E6A5E595E1D_impl*
end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin.GetString

class procedure Tkw_SelfInfo_Control_vtAsteriskLabelLogin.RegisterInEngine;
//#UC START# *52A086150180_6E6A5E595E1D_var*
//#UC END# *52A086150180_6E6A5E595E1D_var*
begin
//#UC START# *52A086150180_6E6A5E595E1D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_6E6A5E595E1D_impl*
end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin.RegisterInEngine

procedure Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2FBD106D7FA3_var*
//#UC END# *4DAEEDE10285_2FBD106D7FA3_var*
begin
//#UC START# *4DAEEDE10285_2FBD106D7FA3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2FBD106D7FA3_impl*
end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push.DoDoIt

class function Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::vtAsteriskLabelLogin:push';
end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_vtAsteriskLabelFIO.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::vtAsteriskLabelFIO';
end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO.GetWordNameForRegister

function Tkw_SelfInfo_Control_vtAsteriskLabelFIO.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_9E1242F8430B_var*
//#UC END# *4DDFD2EA0116_9E1242F8430B_var*
begin
//#UC START# *4DDFD2EA0116_9E1242F8430B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_9E1242F8430B_impl*
end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO.GetString

class procedure Tkw_SelfInfo_Control_vtAsteriskLabelFIO.RegisterInEngine;
//#UC START# *52A086150180_9E1242F8430B_var*
//#UC END# *52A086150180_9E1242F8430B_var*
begin
//#UC START# *52A086150180_9E1242F8430B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_9E1242F8430B_impl*
end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO.RegisterInEngine

procedure Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BBCEDF7EC7E9_var*
//#UC END# *4DAEEDE10285_BBCEDF7EC7E9_var*
begin
//#UC START# *4DAEEDE10285_BBCEDF7EC7E9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BBCEDF7EC7E9_impl*
end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push.DoDoIt

class function Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::vtAsteriskLabelFIO:push';
end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_edPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edPassword';
end;//Tkw_SelfInfo_Control_edPassword.GetWordNameForRegister

function Tkw_SelfInfo_Control_edPassword.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_1AEE19CD4A0D_var*
//#UC END# *4DDFD2EA0116_1AEE19CD4A0D_var*
begin
//#UC START# *4DDFD2EA0116_1AEE19CD4A0D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_1AEE19CD4A0D_impl*
end;//Tkw_SelfInfo_Control_edPassword.GetString

class procedure Tkw_SelfInfo_Control_edPassword.RegisterInEngine;
//#UC START# *52A086150180_1AEE19CD4A0D_var*
//#UC END# *52A086150180_1AEE19CD4A0D_var*
begin
//#UC START# *52A086150180_1AEE19CD4A0D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_1AEE19CD4A0D_impl*
end;//Tkw_SelfInfo_Control_edPassword.RegisterInEngine

procedure Tkw_SelfInfo_Control_edPassword_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C02A141C444B_var*
//#UC END# *4DAEEDE10285_C02A141C444B_var*
begin
//#UC START# *4DAEEDE10285_C02A141C444B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C02A141C444B_impl*
end;//Tkw_SelfInfo_Control_edPassword_Push.DoDoIt

class function Tkw_SelfInfo_Control_edPassword_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edPassword:push';
end;//Tkw_SelfInfo_Control_edPassword_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_edUserName.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edUserName';
end;//Tkw_SelfInfo_Control_edUserName.GetWordNameForRegister

function Tkw_SelfInfo_Control_edUserName.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7519082F9E88_var*
//#UC END# *4DDFD2EA0116_7519082F9E88_var*
begin
//#UC START# *4DDFD2EA0116_7519082F9E88_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7519082F9E88_impl*
end;//Tkw_SelfInfo_Control_edUserName.GetString

class procedure Tkw_SelfInfo_Control_edUserName.RegisterInEngine;
//#UC START# *52A086150180_7519082F9E88_var*
//#UC END# *52A086150180_7519082F9E88_var*
begin
//#UC START# *52A086150180_7519082F9E88_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_7519082F9E88_impl*
end;//Tkw_SelfInfo_Control_edUserName.RegisterInEngine

procedure Tkw_SelfInfo_Control_edUserName_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A283F94B6C80_var*
//#UC END# *4DAEEDE10285_A283F94B6C80_var*
begin
//#UC START# *4DAEEDE10285_A283F94B6C80_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A283F94B6C80_impl*
end;//Tkw_SelfInfo_Control_edUserName_Push.DoDoIt

class function Tkw_SelfInfo_Control_edUserName_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edUserName:push';
end;//Tkw_SelfInfo_Control_edUserName_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_edLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edLogin';
end;//Tkw_SelfInfo_Control_edLogin.GetWordNameForRegister

function Tkw_SelfInfo_Control_edLogin.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_60E34F78DD2F_var*
//#UC END# *4DDFD2EA0116_60E34F78DD2F_var*
begin
//#UC START# *4DDFD2EA0116_60E34F78DD2F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_60E34F78DD2F_impl*
end;//Tkw_SelfInfo_Control_edLogin.GetString

class procedure Tkw_SelfInfo_Control_edLogin.RegisterInEngine;
//#UC START# *52A086150180_60E34F78DD2F_var*
//#UC END# *52A086150180_60E34F78DD2F_var*
begin
//#UC START# *52A086150180_60E34F78DD2F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_60E34F78DD2F_impl*
end;//Tkw_SelfInfo_Control_edLogin.RegisterInEngine

procedure Tkw_SelfInfo_Control_edLogin_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_42E54DD42D91_var*
//#UC END# *4DAEEDE10285_42E54DD42D91_var*
begin
//#UC START# *4DAEEDE10285_42E54DD42D91_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_42E54DD42D91_impl*
end;//Tkw_SelfInfo_Control_edLogin_Push.DoDoIt

class function Tkw_SelfInfo_Control_edLogin_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edLogin:push';
end;//Tkw_SelfInfo_Control_edLogin_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_edEmail.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edEmail';
end;//Tkw_SelfInfo_Control_edEmail.GetWordNameForRegister

function Tkw_SelfInfo_Control_edEmail.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B025C927FA7D_var*
//#UC END# *4DDFD2EA0116_B025C927FA7D_var*
begin
//#UC START# *4DDFD2EA0116_B025C927FA7D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B025C927FA7D_impl*
end;//Tkw_SelfInfo_Control_edEmail.GetString

class procedure Tkw_SelfInfo_Control_edEmail.RegisterInEngine;
//#UC START# *52A086150180_B025C927FA7D_var*
//#UC END# *52A086150180_B025C927FA7D_var*
begin
//#UC START# *52A086150180_B025C927FA7D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_B025C927FA7D_impl*
end;//Tkw_SelfInfo_Control_edEmail.RegisterInEngine

procedure Tkw_SelfInfo_Control_edEmail_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_202CBA4BE920_var*
//#UC END# *4DAEEDE10285_202CBA4BE920_var*
begin
//#UC START# *4DAEEDE10285_202CBA4BE920_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_202CBA4BE920_impl*
end;//Tkw_SelfInfo_Control_edEmail_Push.DoDoIt

class function Tkw_SelfInfo_Control_edEmail_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edEmail:push';
end;//Tkw_SelfInfo_Control_edEmail_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_edConfirm.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edConfirm';
end;//Tkw_SelfInfo_Control_edConfirm.GetWordNameForRegister

function Tkw_SelfInfo_Control_edConfirm.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C0B6FA62032E_var*
//#UC END# *4DDFD2EA0116_C0B6FA62032E_var*
begin
//#UC START# *4DDFD2EA0116_C0B6FA62032E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C0B6FA62032E_impl*
end;//Tkw_SelfInfo_Control_edConfirm.GetString

class procedure Tkw_SelfInfo_Control_edConfirm.RegisterInEngine;
//#UC START# *52A086150180_C0B6FA62032E_var*
//#UC END# *52A086150180_C0B6FA62032E_var*
begin
//#UC START# *52A086150180_C0B6FA62032E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_C0B6FA62032E_impl*
end;//Tkw_SelfInfo_Control_edConfirm.RegisterInEngine

procedure Tkw_SelfInfo_Control_edConfirm_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7FA8973A6045_var*
//#UC END# *4DAEEDE10285_7FA8973A6045_var*
begin
//#UC START# *4DAEEDE10285_7FA8973A6045_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7FA8973A6045_impl*
end;//Tkw_SelfInfo_Control_edConfirm_Push.DoDoIt

class function Tkw_SelfInfo_Control_edConfirm_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edConfirm:push';
end;//Tkw_SelfInfo_Control_edConfirm_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_BottomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BottomPanel';
end;//Tkw_SelfInfo_Control_BottomPanel.GetWordNameForRegister

function Tkw_SelfInfo_Control_BottomPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_53708590CE95_var*
//#UC END# *4DDFD2EA0116_53708590CE95_var*
begin
//#UC START# *4DDFD2EA0116_53708590CE95_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_53708590CE95_impl*
end;//Tkw_SelfInfo_Control_BottomPanel.GetString

class procedure Tkw_SelfInfo_Control_BottomPanel.RegisterInEngine;
//#UC START# *52A086150180_53708590CE95_var*
//#UC END# *52A086150180_53708590CE95_var*
begin
//#UC START# *52A086150180_53708590CE95_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_53708590CE95_impl*
end;//Tkw_SelfInfo_Control_BottomPanel.RegisterInEngine

procedure Tkw_SelfInfo_Control_BottomPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FFAC829037BF_var*
//#UC END# *4DAEEDE10285_FFAC829037BF_var*
begin
//#UC START# *4DAEEDE10285_FFAC829037BF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FFAC829037BF_impl*
end;//Tkw_SelfInfo_Control_BottomPanel_Push.DoDoIt

class function Tkw_SelfInfo_Control_BottomPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BottomPanel:push';
end;//Tkw_SelfInfo_Control_BottomPanel_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_RegisterButton.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RegisterButton';
end;//Tkw_SelfInfo_Control_RegisterButton.GetWordNameForRegister

function Tkw_SelfInfo_Control_RegisterButton.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_73CA1DFEA986_var*
//#UC END# *4DDFD2EA0116_73CA1DFEA986_var*
begin
//#UC START# *4DDFD2EA0116_73CA1DFEA986_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_73CA1DFEA986_impl*
end;//Tkw_SelfInfo_Control_RegisterButton.GetString

class procedure Tkw_SelfInfo_Control_RegisterButton.RegisterInEngine;
//#UC START# *52A086150180_73CA1DFEA986_var*
//#UC END# *52A086150180_73CA1DFEA986_var*
begin
//#UC START# *52A086150180_73CA1DFEA986_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_73CA1DFEA986_impl*
end;//Tkw_SelfInfo_Control_RegisterButton.RegisterInEngine

procedure Tkw_SelfInfo_Control_RegisterButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1363FB711486_var*
//#UC END# *4DAEEDE10285_1363FB711486_var*
begin
//#UC START# *4DAEEDE10285_1363FB711486_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1363FB711486_impl*
end;//Tkw_SelfInfo_Control_RegisterButton_Push.DoDoIt

class function Tkw_SelfInfo_Control_RegisterButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RegisterButton:push';
end;//Tkw_SelfInfo_Control_RegisterButton_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_HelpPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HelpPanel';
end;//Tkw_SelfInfo_Control_HelpPanel.GetWordNameForRegister

function Tkw_SelfInfo_Control_HelpPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_0EDDFBB0D72B_var*
//#UC END# *4DDFD2EA0116_0EDDFBB0D72B_var*
begin
//#UC START# *4DDFD2EA0116_0EDDFBB0D72B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_0EDDFBB0D72B_impl*
end;//Tkw_SelfInfo_Control_HelpPanel.GetString

class procedure Tkw_SelfInfo_Control_HelpPanel.RegisterInEngine;
//#UC START# *52A086150180_0EDDFBB0D72B_var*
//#UC END# *52A086150180_0EDDFBB0D72B_var*
begin
//#UC START# *52A086150180_0EDDFBB0D72B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_0EDDFBB0D72B_impl*
end;//Tkw_SelfInfo_Control_HelpPanel.RegisterInEngine

procedure Tkw_SelfInfo_Control_HelpPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_37E99AAB5D4E_var*
//#UC END# *4DAEEDE10285_37E99AAB5D4E_var*
begin
//#UC START# *4DAEEDE10285_37E99AAB5D4E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_37E99AAB5D4E_impl*
end;//Tkw_SelfInfo_Control_HelpPanel_Push.DoDoIt

class function Tkw_SelfInfo_Control_HelpPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HelpPanel:push';
end;//Tkw_SelfInfo_Control_HelpPanel_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_HelpPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HelpPaintBox';
end;//Tkw_SelfInfo_Control_HelpPaintBox.GetWordNameForRegister

function Tkw_SelfInfo_Control_HelpPaintBox.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B118D62976BC_var*
//#UC END# *4DDFD2EA0116_B118D62976BC_var*
begin
//#UC START# *4DDFD2EA0116_B118D62976BC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B118D62976BC_impl*
end;//Tkw_SelfInfo_Control_HelpPaintBox.GetString

class procedure Tkw_SelfInfo_Control_HelpPaintBox.RegisterInEngine;
//#UC START# *52A086150180_B118D62976BC_var*
//#UC END# *52A086150180_B118D62976BC_var*
begin
//#UC START# *52A086150180_B118D62976BC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_B118D62976BC_impl*
end;//Tkw_SelfInfo_Control_HelpPaintBox.RegisterInEngine

procedure Tkw_SelfInfo_Control_HelpPaintBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_920548FFC8D2_var*
//#UC END# *4DAEEDE10285_920548FFC8D2_var*
begin
//#UC START# *4DAEEDE10285_920548FFC8D2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_920548FFC8D2_impl*
end;//Tkw_SelfInfo_Control_HelpPaintBox_Push.DoDoIt

class function Tkw_SelfInfo_Control_HelpPaintBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HelpPaintBox:push';
end;//Tkw_SelfInfo_Control_HelpPaintBox_Push.GetWordNameForRegister

class function Tkw_SelfInfo_Control_HelpLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HelpLabel';
end;//Tkw_SelfInfo_Control_HelpLabel.GetWordNameForRegister

function Tkw_SelfInfo_Control_HelpLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_3926FF905AD3_var*
//#UC END# *4DDFD2EA0116_3926FF905AD3_var*
begin
//#UC START# *4DDFD2EA0116_3926FF905AD3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_3926FF905AD3_impl*
end;//Tkw_SelfInfo_Control_HelpLabel.GetString

class procedure Tkw_SelfInfo_Control_HelpLabel.RegisterInEngine;
//#UC START# *52A086150180_3926FF905AD3_var*
//#UC END# *52A086150180_3926FF905AD3_var*
begin
//#UC START# *52A086150180_3926FF905AD3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_3926FF905AD3_impl*
end;//Tkw_SelfInfo_Control_HelpLabel.RegisterInEngine

procedure Tkw_SelfInfo_Control_HelpLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8EB4AFB31C07_var*
//#UC END# *4DAEEDE10285_8EB4AFB31C07_var*
begin
//#UC START# *4DAEEDE10285_8EB4AFB31C07_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8EB4AFB31C07_impl*
end;//Tkw_SelfInfo_Control_HelpLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_HelpLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HelpLabel:push';
end;//Tkw_SelfInfo_Control_HelpLabel_Push.GetWordNameForRegister

function TkwSelfInfoFormPnMainData.pnMainData(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtPanel;
 {* ���������� ����� ������� .TSelfInfoForm.pnMainData }
//#UC START# *F2A47E6040DA_228FEAAB7987_var*
//#UC END# *F2A47E6040DA_228FEAAB7987_var*
begin
//#UC START# *F2A47E6040DA_228FEAAB7987_impl*
 !!! Needs to be implemented !!!
//#UC END# *F2A47E6040DA_228FEAAB7987_impl*
end;//TkwSelfInfoFormPnMainData.pnMainData

procedure TkwSelfInfoFormPnMainData.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_228FEAAB7987_var*
//#UC END# *4DAEEDE10285_228FEAAB7987_var*
begin
//#UC START# *4DAEEDE10285_228FEAAB7987_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_228FEAAB7987_impl*
end;//TkwSelfInfoFormPnMainData.DoDoIt

class function TkwSelfInfoFormPnMainData.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.pnMainData';
end;//TkwSelfInfoFormPnMainData.GetWordNameForRegister

procedure TkwSelfInfoFormPnMainData.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_228FEAAB7987_var*
//#UC END# *52D00B00031A_228FEAAB7987_var*
begin
//#UC START# *52D00B00031A_228FEAAB7987_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_228FEAAB7987_impl*
end;//TkwSelfInfoFormPnMainData.SetValuePrim

function TkwSelfInfoFormPnMainData.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_228FEAAB7987_var*
//#UC END# *551544E2001A_228FEAAB7987_var*
begin
//#UC START# *551544E2001A_228FEAAB7987_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_228FEAAB7987_impl*
end;//TkwSelfInfoFormPnMainData.GetResultTypeInfo

function TkwSelfInfoFormPnMainData.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormPnMainData.GetAllParamsCount

function TkwSelfInfoFormPnMainData.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_228FEAAB7987_var*
//#UC END# *5617F4D00243_228FEAAB7987_var*
begin
//#UC START# *5617F4D00243_228FEAAB7987_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_228FEAAB7987_impl*
end;//TkwSelfInfoFormPnMainData.ParamsTypes

function TkwSelfInfoFormUserNameLabel.UserNameLabel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {* ���������� ����� ������� .TSelfInfoForm.UserNameLabel }
//#UC START# *F2D9EA9AAD2B_EA0500776D1E_var*
//#UC END# *F2D9EA9AAD2B_EA0500776D1E_var*
begin
//#UC START# *F2D9EA9AAD2B_EA0500776D1E_impl*
 !!! Needs to be implemented !!!
//#UC END# *F2D9EA9AAD2B_EA0500776D1E_impl*
end;//TkwSelfInfoFormUserNameLabel.UserNameLabel

procedure TkwSelfInfoFormUserNameLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_EA0500776D1E_var*
//#UC END# *4DAEEDE10285_EA0500776D1E_var*
begin
//#UC START# *4DAEEDE10285_EA0500776D1E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_EA0500776D1E_impl*
end;//TkwSelfInfoFormUserNameLabel.DoDoIt

class function TkwSelfInfoFormUserNameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.UserNameLabel';
end;//TkwSelfInfoFormUserNameLabel.GetWordNameForRegister

procedure TkwSelfInfoFormUserNameLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_EA0500776D1E_var*
//#UC END# *52D00B00031A_EA0500776D1E_var*
begin
//#UC START# *52D00B00031A_EA0500776D1E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_EA0500776D1E_impl*
end;//TkwSelfInfoFormUserNameLabel.SetValuePrim

function TkwSelfInfoFormUserNameLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_EA0500776D1E_var*
//#UC END# *551544E2001A_EA0500776D1E_var*
begin
//#UC START# *551544E2001A_EA0500776D1E_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_EA0500776D1E_impl*
end;//TkwSelfInfoFormUserNameLabel.GetResultTypeInfo

function TkwSelfInfoFormUserNameLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormUserNameLabel.GetAllParamsCount

function TkwSelfInfoFormUserNameLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_EA0500776D1E_var*
//#UC END# *5617F4D00243_EA0500776D1E_var*
begin
//#UC START# *5617F4D00243_EA0500776D1E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_EA0500776D1E_impl*
end;//TkwSelfInfoFormUserNameLabel.ParamsTypes

function TkwSelfInfoFormPasswordLabel.PasswordLabel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {* ���������� ����� ������� .TSelfInfoForm.PasswordLabel }
//#UC START# *C06C22D553AF_75B02E501696_var*
//#UC END# *C06C22D553AF_75B02E501696_var*
begin
//#UC START# *C06C22D553AF_75B02E501696_impl*
 !!! Needs to be implemented !!!
//#UC END# *C06C22D553AF_75B02E501696_impl*
end;//TkwSelfInfoFormPasswordLabel.PasswordLabel

procedure TkwSelfInfoFormPasswordLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_75B02E501696_var*
//#UC END# *4DAEEDE10285_75B02E501696_var*
begin
//#UC START# *4DAEEDE10285_75B02E501696_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_75B02E501696_impl*
end;//TkwSelfInfoFormPasswordLabel.DoDoIt

class function TkwSelfInfoFormPasswordLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.PasswordLabel';
end;//TkwSelfInfoFormPasswordLabel.GetWordNameForRegister

procedure TkwSelfInfoFormPasswordLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_75B02E501696_var*
//#UC END# *52D00B00031A_75B02E501696_var*
begin
//#UC START# *52D00B00031A_75B02E501696_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_75B02E501696_impl*
end;//TkwSelfInfoFormPasswordLabel.SetValuePrim

function TkwSelfInfoFormPasswordLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_75B02E501696_var*
//#UC END# *551544E2001A_75B02E501696_var*
begin
//#UC START# *551544E2001A_75B02E501696_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_75B02E501696_impl*
end;//TkwSelfInfoFormPasswordLabel.GetResultTypeInfo

function TkwSelfInfoFormPasswordLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormPasswordLabel.GetAllParamsCount

function TkwSelfInfoFormPasswordLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_75B02E501696_var*
//#UC END# *5617F4D00243_75B02E501696_var*
begin
//#UC START# *5617F4D00243_75B02E501696_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_75B02E501696_impl*
end;//TkwSelfInfoFormPasswordLabel.ParamsTypes

function TkwSelfInfoFormLoginLabel.LoginLabel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {* ���������� ����� ������� .TSelfInfoForm.LoginLabel }
//#UC START# *AC6B4B62DF72_D666F64419BE_var*
//#UC END# *AC6B4B62DF72_D666F64419BE_var*
begin
//#UC START# *AC6B4B62DF72_D666F64419BE_impl*
 !!! Needs to be implemented !!!
//#UC END# *AC6B4B62DF72_D666F64419BE_impl*
end;//TkwSelfInfoFormLoginLabel.LoginLabel

procedure TkwSelfInfoFormLoginLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D666F64419BE_var*
//#UC END# *4DAEEDE10285_D666F64419BE_var*
begin
//#UC START# *4DAEEDE10285_D666F64419BE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D666F64419BE_impl*
end;//TkwSelfInfoFormLoginLabel.DoDoIt

class function TkwSelfInfoFormLoginLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.LoginLabel';
end;//TkwSelfInfoFormLoginLabel.GetWordNameForRegister

procedure TkwSelfInfoFormLoginLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_D666F64419BE_var*
//#UC END# *52D00B00031A_D666F64419BE_var*
begin
//#UC START# *52D00B00031A_D666F64419BE_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_D666F64419BE_impl*
end;//TkwSelfInfoFormLoginLabel.SetValuePrim

function TkwSelfInfoFormLoginLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_D666F64419BE_var*
//#UC END# *551544E2001A_D666F64419BE_var*
begin
//#UC START# *551544E2001A_D666F64419BE_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_D666F64419BE_impl*
end;//TkwSelfInfoFormLoginLabel.GetResultTypeInfo

function TkwSelfInfoFormLoginLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormLoginLabel.GetAllParamsCount

function TkwSelfInfoFormLoginLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D666F64419BE_var*
//#UC END# *5617F4D00243_D666F64419BE_var*
begin
//#UC START# *5617F4D00243_D666F64419BE_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D666F64419BE_impl*
end;//TkwSelfInfoFormLoginLabel.ParamsTypes

function TkwSelfInfoFormInfoLabel.InfoLabel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {* ���������� ����� ������� .TSelfInfoForm.InfoLabel }
//#UC START# *BF7F3D5B60C7_1FE6B40FE2DF_var*
//#UC END# *BF7F3D5B60C7_1FE6B40FE2DF_var*
begin
//#UC START# *BF7F3D5B60C7_1FE6B40FE2DF_impl*
 !!! Needs to be implemented !!!
//#UC END# *BF7F3D5B60C7_1FE6B40FE2DF_impl*
end;//TkwSelfInfoFormInfoLabel.InfoLabel

procedure TkwSelfInfoFormInfoLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1FE6B40FE2DF_var*
//#UC END# *4DAEEDE10285_1FE6B40FE2DF_var*
begin
//#UC START# *4DAEEDE10285_1FE6B40FE2DF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1FE6B40FE2DF_impl*
end;//TkwSelfInfoFormInfoLabel.DoDoIt

class function TkwSelfInfoFormInfoLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.InfoLabel';
end;//TkwSelfInfoFormInfoLabel.GetWordNameForRegister

procedure TkwSelfInfoFormInfoLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_1FE6B40FE2DF_var*
//#UC END# *52D00B00031A_1FE6B40FE2DF_var*
begin
//#UC START# *52D00B00031A_1FE6B40FE2DF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_1FE6B40FE2DF_impl*
end;//TkwSelfInfoFormInfoLabel.SetValuePrim

function TkwSelfInfoFormInfoLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_1FE6B40FE2DF_var*
//#UC END# *551544E2001A_1FE6B40FE2DF_var*
begin
//#UC START# *551544E2001A_1FE6B40FE2DF_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_1FE6B40FE2DF_impl*
end;//TkwSelfInfoFormInfoLabel.GetResultTypeInfo

function TkwSelfInfoFormInfoLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormInfoLabel.GetAllParamsCount

function TkwSelfInfoFormInfoLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_1FE6B40FE2DF_var*
//#UC END# *5617F4D00243_1FE6B40FE2DF_var*
begin
//#UC START# *5617F4D00243_1FE6B40FE2DF_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1FE6B40FE2DF_impl*
end;//TkwSelfInfoFormInfoLabel.ParamsTypes

function TkwSelfInfoFormEMailLabel.EMailLabel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {* ���������� ����� ������� .TSelfInfoForm.EMailLabel }
//#UC START# *05ACA86A5B9D_E047E7B1A49D_var*
//#UC END# *05ACA86A5B9D_E047E7B1A49D_var*
begin
//#UC START# *05ACA86A5B9D_E047E7B1A49D_impl*
 !!! Needs to be implemented !!!
//#UC END# *05ACA86A5B9D_E047E7B1A49D_impl*
end;//TkwSelfInfoFormEMailLabel.EMailLabel

procedure TkwSelfInfoFormEMailLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E047E7B1A49D_var*
//#UC END# *4DAEEDE10285_E047E7B1A49D_var*
begin
//#UC START# *4DAEEDE10285_E047E7B1A49D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E047E7B1A49D_impl*
end;//TkwSelfInfoFormEMailLabel.DoDoIt

class function TkwSelfInfoFormEMailLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.EMailLabel';
end;//TkwSelfInfoFormEMailLabel.GetWordNameForRegister

procedure TkwSelfInfoFormEMailLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_E047E7B1A49D_var*
//#UC END# *52D00B00031A_E047E7B1A49D_var*
begin
//#UC START# *52D00B00031A_E047E7B1A49D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_E047E7B1A49D_impl*
end;//TkwSelfInfoFormEMailLabel.SetValuePrim

function TkwSelfInfoFormEMailLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_E047E7B1A49D_var*
//#UC END# *551544E2001A_E047E7B1A49D_var*
begin
//#UC START# *551544E2001A_E047E7B1A49D_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_E047E7B1A49D_impl*
end;//TkwSelfInfoFormEMailLabel.GetResultTypeInfo

function TkwSelfInfoFormEMailLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormEMailLabel.GetAllParamsCount

function TkwSelfInfoFormEMailLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E047E7B1A49D_var*
//#UC END# *5617F4D00243_E047E7B1A49D_var*
begin
//#UC START# *5617F4D00243_E047E7B1A49D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E047E7B1A49D_impl*
end;//TkwSelfInfoFormEMailLabel.ParamsTypes

function TkwSelfInfoFormConfirmPasswordLabel.ConfirmPasswordLabel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {* ���������� ����� ������� .TSelfInfoForm.ConfirmPasswordLabel }
//#UC START# *078253DA2F28_8C88B1445D54_var*
//#UC END# *078253DA2F28_8C88B1445D54_var*
begin
//#UC START# *078253DA2F28_8C88B1445D54_impl*
 !!! Needs to be implemented !!!
//#UC END# *078253DA2F28_8C88B1445D54_impl*
end;//TkwSelfInfoFormConfirmPasswordLabel.ConfirmPasswordLabel

procedure TkwSelfInfoFormConfirmPasswordLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8C88B1445D54_var*
//#UC END# *4DAEEDE10285_8C88B1445D54_var*
begin
//#UC START# *4DAEEDE10285_8C88B1445D54_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8C88B1445D54_impl*
end;//TkwSelfInfoFormConfirmPasswordLabel.DoDoIt

class function TkwSelfInfoFormConfirmPasswordLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.ConfirmPasswordLabel';
end;//TkwSelfInfoFormConfirmPasswordLabel.GetWordNameForRegister

procedure TkwSelfInfoFormConfirmPasswordLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_8C88B1445D54_var*
//#UC END# *52D00B00031A_8C88B1445D54_var*
begin
//#UC START# *52D00B00031A_8C88B1445D54_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_8C88B1445D54_impl*
end;//TkwSelfInfoFormConfirmPasswordLabel.SetValuePrim

function TkwSelfInfoFormConfirmPasswordLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_8C88B1445D54_var*
//#UC END# *551544E2001A_8C88B1445D54_var*
begin
//#UC START# *551544E2001A_8C88B1445D54_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_8C88B1445D54_impl*
end;//TkwSelfInfoFormConfirmPasswordLabel.GetResultTypeInfo

function TkwSelfInfoFormConfirmPasswordLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormConfirmPasswordLabel.GetAllParamsCount

function TkwSelfInfoFormConfirmPasswordLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_8C88B1445D54_var*
//#UC END# *5617F4D00243_8C88B1445D54_var*
begin
//#UC START# *5617F4D00243_8C88B1445D54_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_8C88B1445D54_impl*
end;//TkwSelfInfoFormConfirmPasswordLabel.ParamsTypes

function TkwSelfInfoFormVtAsteriskLabelLogin.vtAsteriskLabelLogin(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {* ���������� ����� ������� .TSelfInfoForm.vtAsteriskLabelLogin }
//#UC START# *3B0803EA8C9E_7F6A65A32889_var*
//#UC END# *3B0803EA8C9E_7F6A65A32889_var*
begin
//#UC START# *3B0803EA8C9E_7F6A65A32889_impl*
 !!! Needs to be implemented !!!
//#UC END# *3B0803EA8C9E_7F6A65A32889_impl*
end;//TkwSelfInfoFormVtAsteriskLabelLogin.vtAsteriskLabelLogin

procedure TkwSelfInfoFormVtAsteriskLabelLogin.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7F6A65A32889_var*
//#UC END# *4DAEEDE10285_7F6A65A32889_var*
begin
//#UC START# *4DAEEDE10285_7F6A65A32889_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7F6A65A32889_impl*
end;//TkwSelfInfoFormVtAsteriskLabelLogin.DoDoIt

class function TkwSelfInfoFormVtAsteriskLabelLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.vtAsteriskLabelLogin';
end;//TkwSelfInfoFormVtAsteriskLabelLogin.GetWordNameForRegister

procedure TkwSelfInfoFormVtAsteriskLabelLogin.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_7F6A65A32889_var*
//#UC END# *52D00B00031A_7F6A65A32889_var*
begin
//#UC START# *52D00B00031A_7F6A65A32889_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_7F6A65A32889_impl*
end;//TkwSelfInfoFormVtAsteriskLabelLogin.SetValuePrim

function TkwSelfInfoFormVtAsteriskLabelLogin.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_7F6A65A32889_var*
//#UC END# *551544E2001A_7F6A65A32889_var*
begin
//#UC START# *551544E2001A_7F6A65A32889_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_7F6A65A32889_impl*
end;//TkwSelfInfoFormVtAsteriskLabelLogin.GetResultTypeInfo

function TkwSelfInfoFormVtAsteriskLabelLogin.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormVtAsteriskLabelLogin.GetAllParamsCount

function TkwSelfInfoFormVtAsteriskLabelLogin.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_7F6A65A32889_var*
//#UC END# *5617F4D00243_7F6A65A32889_var*
begin
//#UC START# *5617F4D00243_7F6A65A32889_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_7F6A65A32889_impl*
end;//TkwSelfInfoFormVtAsteriskLabelLogin.ParamsTypes

function TkwSelfInfoFormVtAsteriskLabelFIO.vtAsteriskLabelFIO(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {* ���������� ����� ������� .TSelfInfoForm.vtAsteriskLabelFIO }
//#UC START# *6291443782C4_BEC210F63387_var*
//#UC END# *6291443782C4_BEC210F63387_var*
begin
//#UC START# *6291443782C4_BEC210F63387_impl*
 !!! Needs to be implemented !!!
//#UC END# *6291443782C4_BEC210F63387_impl*
end;//TkwSelfInfoFormVtAsteriskLabelFIO.vtAsteriskLabelFIO

procedure TkwSelfInfoFormVtAsteriskLabelFIO.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BEC210F63387_var*
//#UC END# *4DAEEDE10285_BEC210F63387_var*
begin
//#UC START# *4DAEEDE10285_BEC210F63387_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BEC210F63387_impl*
end;//TkwSelfInfoFormVtAsteriskLabelFIO.DoDoIt

class function TkwSelfInfoFormVtAsteriskLabelFIO.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.vtAsteriskLabelFIO';
end;//TkwSelfInfoFormVtAsteriskLabelFIO.GetWordNameForRegister

procedure TkwSelfInfoFormVtAsteriskLabelFIO.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_BEC210F63387_var*
//#UC END# *52D00B00031A_BEC210F63387_var*
begin
//#UC START# *52D00B00031A_BEC210F63387_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_BEC210F63387_impl*
end;//TkwSelfInfoFormVtAsteriskLabelFIO.SetValuePrim

function TkwSelfInfoFormVtAsteriskLabelFIO.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_BEC210F63387_var*
//#UC END# *551544E2001A_BEC210F63387_var*
begin
//#UC START# *551544E2001A_BEC210F63387_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_BEC210F63387_impl*
end;//TkwSelfInfoFormVtAsteriskLabelFIO.GetResultTypeInfo

function TkwSelfInfoFormVtAsteriskLabelFIO.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormVtAsteriskLabelFIO.GetAllParamsCount

function TkwSelfInfoFormVtAsteriskLabelFIO.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_BEC210F63387_var*
//#UC END# *5617F4D00243_BEC210F63387_var*
begin
//#UC START# *5617F4D00243_BEC210F63387_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_BEC210F63387_impl*
end;//TkwSelfInfoFormVtAsteriskLabelFIO.ParamsTypes

function TkwSelfInfoFormEdPassword.edPassword(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TnscComboBoxWithPwdChar;
 {* ���������� ����� ������� .TSelfInfoForm.edPassword }
//#UC START# *06A4B700D261_0FBF6408C500_var*
//#UC END# *06A4B700D261_0FBF6408C500_var*
begin
//#UC START# *06A4B700D261_0FBF6408C500_impl*
 !!! Needs to be implemented !!!
//#UC END# *06A4B700D261_0FBF6408C500_impl*
end;//TkwSelfInfoFormEdPassword.edPassword

procedure TkwSelfInfoFormEdPassword.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0FBF6408C500_var*
//#UC END# *4DAEEDE10285_0FBF6408C500_var*
begin
//#UC START# *4DAEEDE10285_0FBF6408C500_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0FBF6408C500_impl*
end;//TkwSelfInfoFormEdPassword.DoDoIt

class function TkwSelfInfoFormEdPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.edPassword';
end;//TkwSelfInfoFormEdPassword.GetWordNameForRegister

procedure TkwSelfInfoFormEdPassword.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_0FBF6408C500_var*
//#UC END# *52D00B00031A_0FBF6408C500_var*
begin
//#UC START# *52D00B00031A_0FBF6408C500_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_0FBF6408C500_impl*
end;//TkwSelfInfoFormEdPassword.SetValuePrim

function TkwSelfInfoFormEdPassword.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_0FBF6408C500_var*
//#UC END# *551544E2001A_0FBF6408C500_var*
begin
//#UC START# *551544E2001A_0FBF6408C500_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_0FBF6408C500_impl*
end;//TkwSelfInfoFormEdPassword.GetResultTypeInfo

function TkwSelfInfoFormEdPassword.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormEdPassword.GetAllParamsCount

function TkwSelfInfoFormEdPassword.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0FBF6408C500_var*
//#UC END# *5617F4D00243_0FBF6408C500_var*
begin
//#UC START# *5617F4D00243_0FBF6408C500_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0FBF6408C500_impl*
end;//TkwSelfInfoFormEdPassword.ParamsTypes

function TkwSelfInfoFormEdUserName.edUserName(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TnscEdit;
 {* ���������� ����� ������� .TSelfInfoForm.edUserName }
//#UC START# *04150BED36DA_780E2742FC3B_var*
//#UC END# *04150BED36DA_780E2742FC3B_var*
begin
//#UC START# *04150BED36DA_780E2742FC3B_impl*
 !!! Needs to be implemented !!!
//#UC END# *04150BED36DA_780E2742FC3B_impl*
end;//TkwSelfInfoFormEdUserName.edUserName

procedure TkwSelfInfoFormEdUserName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_780E2742FC3B_var*
//#UC END# *4DAEEDE10285_780E2742FC3B_var*
begin
//#UC START# *4DAEEDE10285_780E2742FC3B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_780E2742FC3B_impl*
end;//TkwSelfInfoFormEdUserName.DoDoIt

class function TkwSelfInfoFormEdUserName.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.edUserName';
end;//TkwSelfInfoFormEdUserName.GetWordNameForRegister

procedure TkwSelfInfoFormEdUserName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_780E2742FC3B_var*
//#UC END# *52D00B00031A_780E2742FC3B_var*
begin
//#UC START# *52D00B00031A_780E2742FC3B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_780E2742FC3B_impl*
end;//TkwSelfInfoFormEdUserName.SetValuePrim

function TkwSelfInfoFormEdUserName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_780E2742FC3B_var*
//#UC END# *551544E2001A_780E2742FC3B_var*
begin
//#UC START# *551544E2001A_780E2742FC3B_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_780E2742FC3B_impl*
end;//TkwSelfInfoFormEdUserName.GetResultTypeInfo

function TkwSelfInfoFormEdUserName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormEdUserName.GetAllParamsCount

function TkwSelfInfoFormEdUserName.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_780E2742FC3B_var*
//#UC END# *5617F4D00243_780E2742FC3B_var*
begin
//#UC START# *5617F4D00243_780E2742FC3B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_780E2742FC3B_impl*
end;//TkwSelfInfoFormEdUserName.ParamsTypes

function TkwSelfInfoFormEdLogin.edLogin(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TnscEdit;
 {* ���������� ����� ������� .TSelfInfoForm.edLogin }
//#UC START# *D1FC09620485_A7803EA671CA_var*
//#UC END# *D1FC09620485_A7803EA671CA_var*
begin
//#UC START# *D1FC09620485_A7803EA671CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *D1FC09620485_A7803EA671CA_impl*
end;//TkwSelfInfoFormEdLogin.edLogin

procedure TkwSelfInfoFormEdLogin.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A7803EA671CA_var*
//#UC END# *4DAEEDE10285_A7803EA671CA_var*
begin
//#UC START# *4DAEEDE10285_A7803EA671CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A7803EA671CA_impl*
end;//TkwSelfInfoFormEdLogin.DoDoIt

class function TkwSelfInfoFormEdLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.edLogin';
end;//TkwSelfInfoFormEdLogin.GetWordNameForRegister

procedure TkwSelfInfoFormEdLogin.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_A7803EA671CA_var*
//#UC END# *52D00B00031A_A7803EA671CA_var*
begin
//#UC START# *52D00B00031A_A7803EA671CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_A7803EA671CA_impl*
end;//TkwSelfInfoFormEdLogin.SetValuePrim

function TkwSelfInfoFormEdLogin.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_A7803EA671CA_var*
//#UC END# *551544E2001A_A7803EA671CA_var*
begin
//#UC START# *551544E2001A_A7803EA671CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_A7803EA671CA_impl*
end;//TkwSelfInfoFormEdLogin.GetResultTypeInfo

function TkwSelfInfoFormEdLogin.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormEdLogin.GetAllParamsCount

function TkwSelfInfoFormEdLogin.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_A7803EA671CA_var*
//#UC END# *5617F4D00243_A7803EA671CA_var*
begin
//#UC START# *5617F4D00243_A7803EA671CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_A7803EA671CA_impl*
end;//TkwSelfInfoFormEdLogin.ParamsTypes

function TkwSelfInfoFormEdEmail.edEmail(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TnscEdit;
 {* ���������� ����� ������� .TSelfInfoForm.edEmail }
//#UC START# *65629E1DAE6F_64238C59B15B_var*
//#UC END# *65629E1DAE6F_64238C59B15B_var*
begin
//#UC START# *65629E1DAE6F_64238C59B15B_impl*
 !!! Needs to be implemented !!!
//#UC END# *65629E1DAE6F_64238C59B15B_impl*
end;//TkwSelfInfoFormEdEmail.edEmail

procedure TkwSelfInfoFormEdEmail.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_64238C59B15B_var*
//#UC END# *4DAEEDE10285_64238C59B15B_var*
begin
//#UC START# *4DAEEDE10285_64238C59B15B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_64238C59B15B_impl*
end;//TkwSelfInfoFormEdEmail.DoDoIt

class function TkwSelfInfoFormEdEmail.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.edEmail';
end;//TkwSelfInfoFormEdEmail.GetWordNameForRegister

procedure TkwSelfInfoFormEdEmail.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_64238C59B15B_var*
//#UC END# *52D00B00031A_64238C59B15B_var*
begin
//#UC START# *52D00B00031A_64238C59B15B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_64238C59B15B_impl*
end;//TkwSelfInfoFormEdEmail.SetValuePrim

function TkwSelfInfoFormEdEmail.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_64238C59B15B_var*
//#UC END# *551544E2001A_64238C59B15B_var*
begin
//#UC START# *551544E2001A_64238C59B15B_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_64238C59B15B_impl*
end;//TkwSelfInfoFormEdEmail.GetResultTypeInfo

function TkwSelfInfoFormEdEmail.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormEdEmail.GetAllParamsCount

function TkwSelfInfoFormEdEmail.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_64238C59B15B_var*
//#UC END# *5617F4D00243_64238C59B15B_var*
begin
//#UC START# *5617F4D00243_64238C59B15B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_64238C59B15B_impl*
end;//TkwSelfInfoFormEdEmail.ParamsTypes

function TkwSelfInfoFormEdConfirm.edConfirm(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TnscComboBoxWithPwdChar;
 {* ���������� ����� ������� .TSelfInfoForm.edConfirm }
//#UC START# *AB4D08E910C5_F13F65A2A049_var*
//#UC END# *AB4D08E910C5_F13F65A2A049_var*
begin
//#UC START# *AB4D08E910C5_F13F65A2A049_impl*
 !!! Needs to be implemented !!!
//#UC END# *AB4D08E910C5_F13F65A2A049_impl*
end;//TkwSelfInfoFormEdConfirm.edConfirm

procedure TkwSelfInfoFormEdConfirm.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F13F65A2A049_var*
//#UC END# *4DAEEDE10285_F13F65A2A049_var*
begin
//#UC START# *4DAEEDE10285_F13F65A2A049_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F13F65A2A049_impl*
end;//TkwSelfInfoFormEdConfirm.DoDoIt

class function TkwSelfInfoFormEdConfirm.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.edConfirm';
end;//TkwSelfInfoFormEdConfirm.GetWordNameForRegister

procedure TkwSelfInfoFormEdConfirm.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_F13F65A2A049_var*
//#UC END# *52D00B00031A_F13F65A2A049_var*
begin
//#UC START# *52D00B00031A_F13F65A2A049_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_F13F65A2A049_impl*
end;//TkwSelfInfoFormEdConfirm.SetValuePrim

function TkwSelfInfoFormEdConfirm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F13F65A2A049_var*
//#UC END# *551544E2001A_F13F65A2A049_var*
begin
//#UC START# *551544E2001A_F13F65A2A049_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F13F65A2A049_impl*
end;//TkwSelfInfoFormEdConfirm.GetResultTypeInfo

function TkwSelfInfoFormEdConfirm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormEdConfirm.GetAllParamsCount

function TkwSelfInfoFormEdConfirm.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F13F65A2A049_var*
//#UC END# *5617F4D00243_F13F65A2A049_var*
begin
//#UC START# *5617F4D00243_F13F65A2A049_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F13F65A2A049_impl*
end;//TkwSelfInfoFormEdConfirm.ParamsTypes

function TkwSelfInfoFormBottomPanel.BottomPanel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtPanel;
 {* ���������� ����� ������� .TSelfInfoForm.BottomPanel }
//#UC START# *B4AAE7AE965E_B80ACB58E282_var*
//#UC END# *B4AAE7AE965E_B80ACB58E282_var*
begin
//#UC START# *B4AAE7AE965E_B80ACB58E282_impl*
 !!! Needs to be implemented !!!
//#UC END# *B4AAE7AE965E_B80ACB58E282_impl*
end;//TkwSelfInfoFormBottomPanel.BottomPanel

procedure TkwSelfInfoFormBottomPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B80ACB58E282_var*
//#UC END# *4DAEEDE10285_B80ACB58E282_var*
begin
//#UC START# *4DAEEDE10285_B80ACB58E282_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B80ACB58E282_impl*
end;//TkwSelfInfoFormBottomPanel.DoDoIt

class function TkwSelfInfoFormBottomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.BottomPanel';
end;//TkwSelfInfoFormBottomPanel.GetWordNameForRegister

procedure TkwSelfInfoFormBottomPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_B80ACB58E282_var*
//#UC END# *52D00B00031A_B80ACB58E282_var*
begin
//#UC START# *52D00B00031A_B80ACB58E282_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_B80ACB58E282_impl*
end;//TkwSelfInfoFormBottomPanel.SetValuePrim

function TkwSelfInfoFormBottomPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_B80ACB58E282_var*
//#UC END# *551544E2001A_B80ACB58E282_var*
begin
//#UC START# *551544E2001A_B80ACB58E282_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_B80ACB58E282_impl*
end;//TkwSelfInfoFormBottomPanel.GetResultTypeInfo

function TkwSelfInfoFormBottomPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormBottomPanel.GetAllParamsCount

function TkwSelfInfoFormBottomPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_B80ACB58E282_var*
//#UC END# *5617F4D00243_B80ACB58E282_var*
begin
//#UC START# *5617F4D00243_B80ACB58E282_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B80ACB58E282_impl*
end;//TkwSelfInfoFormBottomPanel.ParamsTypes

function TkwSelfInfoFormRegisterButton.RegisterButton(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TElPopupButton;
 {* ���������� ����� ������� .TSelfInfoForm.RegisterButton }
//#UC START# *AC277BBC52D1_FD3682257D32_var*
//#UC END# *AC277BBC52D1_FD3682257D32_var*
begin
//#UC START# *AC277BBC52D1_FD3682257D32_impl*
 !!! Needs to be implemented !!!
//#UC END# *AC277BBC52D1_FD3682257D32_impl*
end;//TkwSelfInfoFormRegisterButton.RegisterButton

procedure TkwSelfInfoFormRegisterButton.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FD3682257D32_var*
//#UC END# *4DAEEDE10285_FD3682257D32_var*
begin
//#UC START# *4DAEEDE10285_FD3682257D32_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FD3682257D32_impl*
end;//TkwSelfInfoFormRegisterButton.DoDoIt

class function TkwSelfInfoFormRegisterButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.RegisterButton';
end;//TkwSelfInfoFormRegisterButton.GetWordNameForRegister

procedure TkwSelfInfoFormRegisterButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_FD3682257D32_var*
//#UC END# *52D00B00031A_FD3682257D32_var*
begin
//#UC START# *52D00B00031A_FD3682257D32_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_FD3682257D32_impl*
end;//TkwSelfInfoFormRegisterButton.SetValuePrim

function TkwSelfInfoFormRegisterButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_FD3682257D32_var*
//#UC END# *551544E2001A_FD3682257D32_var*
begin
//#UC START# *551544E2001A_FD3682257D32_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_FD3682257D32_impl*
end;//TkwSelfInfoFormRegisterButton.GetResultTypeInfo

function TkwSelfInfoFormRegisterButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormRegisterButton.GetAllParamsCount

function TkwSelfInfoFormRegisterButton.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_FD3682257D32_var*
//#UC END# *5617F4D00243_FD3682257D32_var*
begin
//#UC START# *5617F4D00243_FD3682257D32_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_FD3682257D32_impl*
end;//TkwSelfInfoFormRegisterButton.ParamsTypes

function TkwSelfInfoFormHelpPanel.HelpPanel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtPanel;
 {* ���������� ����� ������� .TSelfInfoForm.HelpPanel }
//#UC START# *FC13EEFAD1BA_1C53869E7936_var*
//#UC END# *FC13EEFAD1BA_1C53869E7936_var*
begin
//#UC START# *FC13EEFAD1BA_1C53869E7936_impl*
 !!! Needs to be implemented !!!
//#UC END# *FC13EEFAD1BA_1C53869E7936_impl*
end;//TkwSelfInfoFormHelpPanel.HelpPanel

procedure TkwSelfInfoFormHelpPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1C53869E7936_var*
//#UC END# *4DAEEDE10285_1C53869E7936_var*
begin
//#UC START# *4DAEEDE10285_1C53869E7936_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1C53869E7936_impl*
end;//TkwSelfInfoFormHelpPanel.DoDoIt

class function TkwSelfInfoFormHelpPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.HelpPanel';
end;//TkwSelfInfoFormHelpPanel.GetWordNameForRegister

procedure TkwSelfInfoFormHelpPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_1C53869E7936_var*
//#UC END# *52D00B00031A_1C53869E7936_var*
begin
//#UC START# *52D00B00031A_1C53869E7936_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_1C53869E7936_impl*
end;//TkwSelfInfoFormHelpPanel.SetValuePrim

function TkwSelfInfoFormHelpPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_1C53869E7936_var*
//#UC END# *551544E2001A_1C53869E7936_var*
begin
//#UC START# *551544E2001A_1C53869E7936_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_1C53869E7936_impl*
end;//TkwSelfInfoFormHelpPanel.GetResultTypeInfo

function TkwSelfInfoFormHelpPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormHelpPanel.GetAllParamsCount

function TkwSelfInfoFormHelpPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_1C53869E7936_var*
//#UC END# *5617F4D00243_1C53869E7936_var*
begin
//#UC START# *5617F4D00243_1C53869E7936_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1C53869E7936_impl*
end;//TkwSelfInfoFormHelpPanel.ParamsTypes

function TkwSelfInfoFormHelpPaintBox.HelpPaintBox(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TPaintBox;
 {* ���������� ����� ������� .TSelfInfoForm.HelpPaintBox }
//#UC START# *006E60EF257B_5BDB34AE5EFB_var*
//#UC END# *006E60EF257B_5BDB34AE5EFB_var*
begin
//#UC START# *006E60EF257B_5BDB34AE5EFB_impl*
 !!! Needs to be implemented !!!
//#UC END# *006E60EF257B_5BDB34AE5EFB_impl*
end;//TkwSelfInfoFormHelpPaintBox.HelpPaintBox

procedure TkwSelfInfoFormHelpPaintBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5BDB34AE5EFB_var*
//#UC END# *4DAEEDE10285_5BDB34AE5EFB_var*
begin
//#UC START# *4DAEEDE10285_5BDB34AE5EFB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5BDB34AE5EFB_impl*
end;//TkwSelfInfoFormHelpPaintBox.DoDoIt

class function TkwSelfInfoFormHelpPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.HelpPaintBox';
end;//TkwSelfInfoFormHelpPaintBox.GetWordNameForRegister

procedure TkwSelfInfoFormHelpPaintBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_5BDB34AE5EFB_var*
//#UC END# *52D00B00031A_5BDB34AE5EFB_var*
begin
//#UC START# *52D00B00031A_5BDB34AE5EFB_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_5BDB34AE5EFB_impl*
end;//TkwSelfInfoFormHelpPaintBox.SetValuePrim

function TkwSelfInfoFormHelpPaintBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_5BDB34AE5EFB_var*
//#UC END# *551544E2001A_5BDB34AE5EFB_var*
begin
//#UC START# *551544E2001A_5BDB34AE5EFB_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_5BDB34AE5EFB_impl*
end;//TkwSelfInfoFormHelpPaintBox.GetResultTypeInfo

function TkwSelfInfoFormHelpPaintBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormHelpPaintBox.GetAllParamsCount

function TkwSelfInfoFormHelpPaintBox.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_5BDB34AE5EFB_var*
//#UC END# *5617F4D00243_5BDB34AE5EFB_var*
begin
//#UC START# *5617F4D00243_5BDB34AE5EFB_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_5BDB34AE5EFB_impl*
end;//TkwSelfInfoFormHelpPaintBox.ParamsTypes

function TkwSelfInfoFormHelpLabel.HelpLabel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtFocusLabel;
 {* ���������� ����� ������� .TSelfInfoForm.HelpLabel }
//#UC START# *C33FFAD9E88B_2D128F2A8132_var*
//#UC END# *C33FFAD9E88B_2D128F2A8132_var*
begin
//#UC START# *C33FFAD9E88B_2D128F2A8132_impl*
 !!! Needs to be implemented !!!
//#UC END# *C33FFAD9E88B_2D128F2A8132_impl*
end;//TkwSelfInfoFormHelpLabel.HelpLabel

procedure TkwSelfInfoFormHelpLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2D128F2A8132_var*
//#UC END# *4DAEEDE10285_2D128F2A8132_var*
begin
//#UC START# *4DAEEDE10285_2D128F2A8132_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2D128F2A8132_impl*
end;//TkwSelfInfoFormHelpLabel.DoDoIt

class function TkwSelfInfoFormHelpLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.HelpLabel';
end;//TkwSelfInfoFormHelpLabel.GetWordNameForRegister

procedure TkwSelfInfoFormHelpLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_2D128F2A8132_var*
//#UC END# *52D00B00031A_2D128F2A8132_var*
begin
//#UC START# *52D00B00031A_2D128F2A8132_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_2D128F2A8132_impl*
end;//TkwSelfInfoFormHelpLabel.SetValuePrim

function TkwSelfInfoFormHelpLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_2D128F2A8132_var*
//#UC END# *551544E2001A_2D128F2A8132_var*
begin
//#UC START# *551544E2001A_2D128F2A8132_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_2D128F2A8132_impl*
end;//TkwSelfInfoFormHelpLabel.GetResultTypeInfo

function TkwSelfInfoFormHelpLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormHelpLabel.GetAllParamsCount

function TkwSelfInfoFormHelpLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_2D128F2A8132_var*
//#UC END# *5617F4D00243_2D128F2A8132_var*
begin
//#UC START# *5617F4D00243_2D128F2A8132_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_2D128F2A8132_impl*
end;//TkwSelfInfoFormHelpLabel.ParamsTypes

initialization
 Tkw_Form_SelfInfo.RegisterInEngine;
 {* ����������� Tkw_Form_SelfInfo }
 Tkw_SelfInfo_Control_pnMainData.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_pnMainData }
 Tkw_SelfInfo_Control_pnMainData_Push.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_pnMainData_Push }
 Tkw_SelfInfo_Control_UserNameLabel.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_UserNameLabel }
 Tkw_SelfInfo_Control_UserNameLabel_Push.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_UserNameLabel_Push }
 Tkw_SelfInfo_Control_PasswordLabel.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_PasswordLabel }
 Tkw_SelfInfo_Control_PasswordLabel_Push.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_PasswordLabel_Push }
 Tkw_SelfInfo_Control_LoginLabel.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_LoginLabel }
 Tkw_SelfInfo_Control_LoginLabel_Push.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_LoginLabel_Push }
 Tkw_SelfInfo_Control_InfoLabel.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_InfoLabel }
 Tkw_SelfInfo_Control_InfoLabel_Push.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_InfoLabel_Push }
 Tkw_SelfInfo_Control_EMailLabel.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_EMailLabel }
 Tkw_SelfInfo_Control_EMailLabel_Push.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_EMailLabel_Push }
 Tkw_SelfInfo_Control_ConfirmPasswordLabel.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_ConfirmPasswordLabel }
 Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push }
 Tkw_SelfInfo_Control_vtAsteriskLabelLogin.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_vtAsteriskLabelLogin }
 Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push }
 Tkw_SelfInfo_Control_vtAsteriskLabelFIO.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_vtAsteriskLabelFIO }
 Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push }
 Tkw_SelfInfo_Control_edPassword.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_edPassword }
 Tkw_SelfInfo_Control_edPassword_Push.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_edPassword_Push }
 Tkw_SelfInfo_Control_edUserName.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_edUserName }
 Tkw_SelfInfo_Control_edUserName_Push.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_edUserName_Push }
 Tkw_SelfInfo_Control_edLogin.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_edLogin }
 Tkw_SelfInfo_Control_edLogin_Push.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_edLogin_Push }
 Tkw_SelfInfo_Control_edEmail.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_edEmail }
 Tkw_SelfInfo_Control_edEmail_Push.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_edEmail_Push }
 Tkw_SelfInfo_Control_edConfirm.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_edConfirm }
 Tkw_SelfInfo_Control_edConfirm_Push.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_edConfirm_Push }
 Tkw_SelfInfo_Control_BottomPanel.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_BottomPanel }
 Tkw_SelfInfo_Control_BottomPanel_Push.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_BottomPanel_Push }
 Tkw_SelfInfo_Control_RegisterButton.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_RegisterButton }
 Tkw_SelfInfo_Control_RegisterButton_Push.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_RegisterButton_Push }
 Tkw_SelfInfo_Control_HelpPanel.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_HelpPanel }
 Tkw_SelfInfo_Control_HelpPanel_Push.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_HelpPanel_Push }
 Tkw_SelfInfo_Control_HelpPaintBox.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_HelpPaintBox }
 Tkw_SelfInfo_Control_HelpPaintBox_Push.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_HelpPaintBox_Push }
 Tkw_SelfInfo_Control_HelpLabel.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_HelpLabel }
 Tkw_SelfInfo_Control_HelpLabel_Push.RegisterInEngine;
 {* ����������� Tkw_SelfInfo_Control_HelpLabel_Push }
 TkwSelfInfoFormPnMainData.RegisterInEngine;
 {* ����������� SelfInfoForm_pnMainData }
 TkwSelfInfoFormUserNameLabel.RegisterInEngine;
 {* ����������� SelfInfoForm_UserNameLabel }
 TkwSelfInfoFormPasswordLabel.RegisterInEngine;
 {* ����������� SelfInfoForm_PasswordLabel }
 TkwSelfInfoFormLoginLabel.RegisterInEngine;
 {* ����������� SelfInfoForm_LoginLabel }
 TkwSelfInfoFormInfoLabel.RegisterInEngine;
 {* ����������� SelfInfoForm_InfoLabel }
 TkwSelfInfoFormEMailLabel.RegisterInEngine;
 {* ����������� SelfInfoForm_EMailLabel }
 TkwSelfInfoFormConfirmPasswordLabel.RegisterInEngine;
 {* ����������� SelfInfoForm_ConfirmPasswordLabel }
 TkwSelfInfoFormVtAsteriskLabelLogin.RegisterInEngine;
 {* ����������� SelfInfoForm_vtAsteriskLabelLogin }
 TkwSelfInfoFormVtAsteriskLabelFIO.RegisterInEngine;
 {* ����������� SelfInfoForm_vtAsteriskLabelFIO }
 TkwSelfInfoFormEdPassword.RegisterInEngine;
 {* ����������� SelfInfoForm_edPassword }
 TkwSelfInfoFormEdUserName.RegisterInEngine;
 {* ����������� SelfInfoForm_edUserName }
 TkwSelfInfoFormEdLogin.RegisterInEngine;
 {* ����������� SelfInfoForm_edLogin }
 TkwSelfInfoFormEdEmail.RegisterInEngine;
 {* ����������� SelfInfoForm_edEmail }
 TkwSelfInfoFormEdConfirm.RegisterInEngine;
 {* ����������� SelfInfoForm_edConfirm }
 TkwSelfInfoFormBottomPanel.RegisterInEngine;
 {* ����������� SelfInfoForm_BottomPanel }
 TkwSelfInfoFormRegisterButton.RegisterInEngine;
 {* ����������� SelfInfoForm_RegisterButton }
 TkwSelfInfoFormHelpPanel.RegisterInEngine;
 {* ����������� SelfInfoForm_HelpPanel }
 TkwSelfInfoFormHelpPaintBox.RegisterInEngine;
 {* ����������� SelfInfoForm_HelpPaintBox }
 TkwSelfInfoFormHelpLabel.RegisterInEngine;
 {* ����������� SelfInfoForm_HelpLabel }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TSelfInfoForm));
 {* ����������� ���� SelfInfo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscComboBoxWithPwdChar));
 {* ����������� ���� TnscComboBoxWithPwdChar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEdit));
 {* ����������� ���� TnscEdit }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElPopupButton));
 {* ����������� ���� TElPopupButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* ����������� ���� TPaintBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtFocusLabel));
 {* ����������� ���� TvtFocusLabel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.

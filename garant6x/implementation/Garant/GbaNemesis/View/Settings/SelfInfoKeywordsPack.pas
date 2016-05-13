unit SelfInfoKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� SelfInfo }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\SelfInfoKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "SelfInfoKeywordsPack" MUID: (B9B183D3AE2D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
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
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SelfInfo_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , TypInfo
 , tfwTypeInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
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
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_SelfInfo

 Tkw_SelfInfo_Control_pnMainData = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnMainData
----
*������ �������������*:
[code]
�������::pnMainData TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_pnMainData

 Tkw_SelfInfo_Control_pnMainData_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_UserNameLabel

 Tkw_SelfInfo_Control_UserNameLabel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_PasswordLabel

 Tkw_SelfInfo_Control_PasswordLabel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_LoginLabel

 Tkw_SelfInfo_Control_LoginLabel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_InfoLabel

 Tkw_SelfInfo_Control_InfoLabel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_EMailLabel

 Tkw_SelfInfo_Control_EMailLabel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel

 Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin

 Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO

 Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_edPassword

 Tkw_SelfInfo_Control_edPassword_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_edUserName

 Tkw_SelfInfo_Control_edUserName_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_edLogin

 Tkw_SelfInfo_Control_edLogin_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_edEmail

 Tkw_SelfInfo_Control_edEmail_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_edConfirm

 Tkw_SelfInfo_Control_edConfirm_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_BottomPanel

 Tkw_SelfInfo_Control_BottomPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_RegisterButton

 Tkw_SelfInfo_Control_RegisterButton_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_HelpPanel

 Tkw_SelfInfo_Control_HelpPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_HelpPaintBox

 Tkw_SelfInfo_Control_HelpPaintBox_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelfInfo_Control_HelpLabel

 Tkw_SelfInfo_Control_HelpLabel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
  {* ����� ������� .TSelfInfoForm.pnMainData }
  private
   function pnMainData(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtPanel;
    {* ���������� ����� ������� .TSelfInfoForm.pnMainData }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwSelfInfoFormPnMainData

 TkwSelfInfoFormUserNameLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.UserNameLabel }
  private
   function UserNameLabel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtLabel;
    {* ���������� ����� ������� .TSelfInfoForm.UserNameLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwSelfInfoFormUserNameLabel

 TkwSelfInfoFormPasswordLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.PasswordLabel }
  private
   function PasswordLabel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtLabel;
    {* ���������� ����� ������� .TSelfInfoForm.PasswordLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwSelfInfoFormPasswordLabel

 TkwSelfInfoFormLoginLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.LoginLabel }
  private
   function LoginLabel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtLabel;
    {* ���������� ����� ������� .TSelfInfoForm.LoginLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwSelfInfoFormLoginLabel

 TkwSelfInfoFormInfoLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.InfoLabel }
  private
   function InfoLabel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtLabel;
    {* ���������� ����� ������� .TSelfInfoForm.InfoLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwSelfInfoFormInfoLabel

 TkwSelfInfoFormEMailLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.EMailLabel }
  private
   function EMailLabel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtLabel;
    {* ���������� ����� ������� .TSelfInfoForm.EMailLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwSelfInfoFormEMailLabel

 TkwSelfInfoFormConfirmPasswordLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.ConfirmPasswordLabel }
  private
   function ConfirmPasswordLabel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtLabel;
    {* ���������� ����� ������� .TSelfInfoForm.ConfirmPasswordLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwSelfInfoFormConfirmPasswordLabel

 TkwSelfInfoFormVtAsteriskLabelLogin = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.vtAsteriskLabelLogin }
  private
   function vtAsteriskLabelLogin(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtLabel;
    {* ���������� ����� ������� .TSelfInfoForm.vtAsteriskLabelLogin }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwSelfInfoFormVtAsteriskLabelLogin

 TkwSelfInfoFormVtAsteriskLabelFIO = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.vtAsteriskLabelFIO }
  private
   function vtAsteriskLabelFIO(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtLabel;
    {* ���������� ����� ������� .TSelfInfoForm.vtAsteriskLabelFIO }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwSelfInfoFormVtAsteriskLabelFIO

 TkwSelfInfoFormEdPassword = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.edPassword }
  private
   function edPassword(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TnscComboBoxWithPwdChar;
    {* ���������� ����� ������� .TSelfInfoForm.edPassword }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwSelfInfoFormEdPassword

 TkwSelfInfoFormEdUserName = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.edUserName }
  private
   function edUserName(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TnscEdit;
    {* ���������� ����� ������� .TSelfInfoForm.edUserName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwSelfInfoFormEdUserName

 TkwSelfInfoFormEdLogin = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.edLogin }
  private
   function edLogin(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TnscEdit;
    {* ���������� ����� ������� .TSelfInfoForm.edLogin }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwSelfInfoFormEdLogin

 TkwSelfInfoFormEdEmail = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.edEmail }
  private
   function edEmail(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TnscEdit;
    {* ���������� ����� ������� .TSelfInfoForm.edEmail }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwSelfInfoFormEdEmail

 TkwSelfInfoFormEdConfirm = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.edConfirm }
  private
   function edConfirm(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TnscComboBoxWithPwdChar;
    {* ���������� ����� ������� .TSelfInfoForm.edConfirm }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwSelfInfoFormEdConfirm

 TkwSelfInfoFormBottomPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.BottomPanel }
  private
   function BottomPanel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtPanel;
    {* ���������� ����� ������� .TSelfInfoForm.BottomPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwSelfInfoFormBottomPanel

 TkwSelfInfoFormRegisterButton = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.RegisterButton }
  private
   function RegisterButton(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TElPopupButton;
    {* ���������� ����� ������� .TSelfInfoForm.RegisterButton }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwSelfInfoFormRegisterButton

 TkwSelfInfoFormHelpPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.HelpPanel }
  private
   function HelpPanel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtPanel;
    {* ���������� ����� ������� .TSelfInfoForm.HelpPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwSelfInfoFormHelpPanel

 TkwSelfInfoFormHelpPaintBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.HelpPaintBox }
  private
   function HelpPaintBox(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TPaintBox;
    {* ���������� ����� ������� .TSelfInfoForm.HelpPaintBox }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwSelfInfoFormHelpPaintBox

 TkwSelfInfoFormHelpLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TSelfInfoForm.HelpLabel }
  private
   function HelpLabel(const aCtx: TtfwContext;
    aSelfInfoForm: TSelfInfoForm): TvtFocusLabel;
    {* ���������� ����� ������� .TSelfInfoForm.HelpLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwSelfInfoFormHelpLabel

function Tkw_Form_SelfInfo.GetString: AnsiString;
begin
 Result := 'SelfInfoForm';
end;//Tkw_Form_SelfInfo.GetString

class function Tkw_Form_SelfInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::SelfInfo';
end;//Tkw_Form_SelfInfo.GetWordNameForRegister

function Tkw_SelfInfo_Control_pnMainData.GetString: AnsiString;
begin
 Result := 'pnMainData';
end;//Tkw_SelfInfo_Control_pnMainData.GetString

class procedure Tkw_SelfInfo_Control_pnMainData.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_SelfInfo_Control_pnMainData.RegisterInEngine

class function Tkw_SelfInfo_Control_pnMainData.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnMainData';
end;//Tkw_SelfInfo_Control_pnMainData.GetWordNameForRegister

procedure Tkw_SelfInfo_Control_pnMainData_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnMainData');
 inherited;
end;//Tkw_SelfInfo_Control_pnMainData_Push.DoDoIt

class function Tkw_SelfInfo_Control_pnMainData_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnMainData:push';
end;//Tkw_SelfInfo_Control_pnMainData_Push.GetWordNameForRegister

function Tkw_SelfInfo_Control_UserNameLabel.GetString: AnsiString;
begin
 Result := 'UserNameLabel';
end;//Tkw_SelfInfo_Control_UserNameLabel.GetString

class procedure Tkw_SelfInfo_Control_UserNameLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SelfInfo_Control_UserNameLabel.RegisterInEngine

class function Tkw_SelfInfo_Control_UserNameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserNameLabel';
end;//Tkw_SelfInfo_Control_UserNameLabel.GetWordNameForRegister

procedure Tkw_SelfInfo_Control_UserNameLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('UserNameLabel');
 inherited;
end;//Tkw_SelfInfo_Control_UserNameLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_UserNameLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UserNameLabel:push';
end;//Tkw_SelfInfo_Control_UserNameLabel_Push.GetWordNameForRegister

function Tkw_SelfInfo_Control_PasswordLabel.GetString: AnsiString;
begin
 Result := 'PasswordLabel';
end;//Tkw_SelfInfo_Control_PasswordLabel.GetString

class procedure Tkw_SelfInfo_Control_PasswordLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SelfInfo_Control_PasswordLabel.RegisterInEngine

class function Tkw_SelfInfo_Control_PasswordLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::PasswordLabel';
end;//Tkw_SelfInfo_Control_PasswordLabel.GetWordNameForRegister

procedure Tkw_SelfInfo_Control_PasswordLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('PasswordLabel');
 inherited;
end;//Tkw_SelfInfo_Control_PasswordLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_PasswordLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::PasswordLabel:push';
end;//Tkw_SelfInfo_Control_PasswordLabel_Push.GetWordNameForRegister

function Tkw_SelfInfo_Control_LoginLabel.GetString: AnsiString;
begin
 Result := 'LoginLabel';
end;//Tkw_SelfInfo_Control_LoginLabel.GetString

class procedure Tkw_SelfInfo_Control_LoginLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SelfInfo_Control_LoginLabel.RegisterInEngine

class function Tkw_SelfInfo_Control_LoginLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LoginLabel';
end;//Tkw_SelfInfo_Control_LoginLabel.GetWordNameForRegister

procedure Tkw_SelfInfo_Control_LoginLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('LoginLabel');
 inherited;
end;//Tkw_SelfInfo_Control_LoginLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_LoginLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LoginLabel:push';
end;//Tkw_SelfInfo_Control_LoginLabel_Push.GetWordNameForRegister

function Tkw_SelfInfo_Control_InfoLabel.GetString: AnsiString;
begin
 Result := 'InfoLabel';
end;//Tkw_SelfInfo_Control_InfoLabel.GetString

class procedure Tkw_SelfInfo_Control_InfoLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SelfInfo_Control_InfoLabel.RegisterInEngine

class function Tkw_SelfInfo_Control_InfoLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::InfoLabel';
end;//Tkw_SelfInfo_Control_InfoLabel.GetWordNameForRegister

procedure Tkw_SelfInfo_Control_InfoLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('InfoLabel');
 inherited;
end;//Tkw_SelfInfo_Control_InfoLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_InfoLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::InfoLabel:push';
end;//Tkw_SelfInfo_Control_InfoLabel_Push.GetWordNameForRegister

function Tkw_SelfInfo_Control_EMailLabel.GetString: AnsiString;
begin
 Result := 'EMailLabel';
end;//Tkw_SelfInfo_Control_EMailLabel.GetString

class procedure Tkw_SelfInfo_Control_EMailLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SelfInfo_Control_EMailLabel.RegisterInEngine

class function Tkw_SelfInfo_Control_EMailLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EMailLabel';
end;//Tkw_SelfInfo_Control_EMailLabel.GetWordNameForRegister

procedure Tkw_SelfInfo_Control_EMailLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('EMailLabel');
 inherited;
end;//Tkw_SelfInfo_Control_EMailLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_EMailLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EMailLabel:push';
end;//Tkw_SelfInfo_Control_EMailLabel_Push.GetWordNameForRegister

function Tkw_SelfInfo_Control_ConfirmPasswordLabel.GetString: AnsiString;
begin
 Result := 'ConfirmPasswordLabel';
end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel.GetString

class procedure Tkw_SelfInfo_Control_ConfirmPasswordLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel.RegisterInEngine

class function Tkw_SelfInfo_Control_ConfirmPasswordLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ConfirmPasswordLabel';
end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel.GetWordNameForRegister

procedure Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ConfirmPasswordLabel');
 inherited;
end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ConfirmPasswordLabel:push';
end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push.GetWordNameForRegister

function Tkw_SelfInfo_Control_vtAsteriskLabelLogin.GetString: AnsiString;
begin
 Result := 'vtAsteriskLabelLogin';
end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin.GetString

class procedure Tkw_SelfInfo_Control_vtAsteriskLabelLogin.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin.RegisterInEngine

class function Tkw_SelfInfo_Control_vtAsteriskLabelLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::vtAsteriskLabelLogin';
end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin.GetWordNameForRegister

procedure Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('vtAsteriskLabelLogin');
 inherited;
end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push.DoDoIt

class function Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::vtAsteriskLabelLogin:push';
end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push.GetWordNameForRegister

function Tkw_SelfInfo_Control_vtAsteriskLabelFIO.GetString: AnsiString;
begin
 Result := 'vtAsteriskLabelFIO';
end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO.GetString

class procedure Tkw_SelfInfo_Control_vtAsteriskLabelFIO.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO.RegisterInEngine

class function Tkw_SelfInfo_Control_vtAsteriskLabelFIO.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::vtAsteriskLabelFIO';
end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO.GetWordNameForRegister

procedure Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('vtAsteriskLabelFIO');
 inherited;
end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push.DoDoIt

class function Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::vtAsteriskLabelFIO:push';
end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push.GetWordNameForRegister

function Tkw_SelfInfo_Control_edPassword.GetString: AnsiString;
begin
 Result := 'edPassword';
end;//Tkw_SelfInfo_Control_edPassword.GetString

class procedure Tkw_SelfInfo_Control_edPassword.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscComboBoxWithPwdChar);
end;//Tkw_SelfInfo_Control_edPassword.RegisterInEngine

class function Tkw_SelfInfo_Control_edPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edPassword';
end;//Tkw_SelfInfo_Control_edPassword.GetWordNameForRegister

procedure Tkw_SelfInfo_Control_edPassword_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edPassword');
 inherited;
end;//Tkw_SelfInfo_Control_edPassword_Push.DoDoIt

class function Tkw_SelfInfo_Control_edPassword_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edPassword:push';
end;//Tkw_SelfInfo_Control_edPassword_Push.GetWordNameForRegister

function Tkw_SelfInfo_Control_edUserName.GetString: AnsiString;
begin
 Result := 'edUserName';
end;//Tkw_SelfInfo_Control_edUserName.GetString

class procedure Tkw_SelfInfo_Control_edUserName.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_SelfInfo_Control_edUserName.RegisterInEngine

class function Tkw_SelfInfo_Control_edUserName.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edUserName';
end;//Tkw_SelfInfo_Control_edUserName.GetWordNameForRegister

procedure Tkw_SelfInfo_Control_edUserName_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edUserName');
 inherited;
end;//Tkw_SelfInfo_Control_edUserName_Push.DoDoIt

class function Tkw_SelfInfo_Control_edUserName_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edUserName:push';
end;//Tkw_SelfInfo_Control_edUserName_Push.GetWordNameForRegister

function Tkw_SelfInfo_Control_edLogin.GetString: AnsiString;
begin
 Result := 'edLogin';
end;//Tkw_SelfInfo_Control_edLogin.GetString

class procedure Tkw_SelfInfo_Control_edLogin.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_SelfInfo_Control_edLogin.RegisterInEngine

class function Tkw_SelfInfo_Control_edLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edLogin';
end;//Tkw_SelfInfo_Control_edLogin.GetWordNameForRegister

procedure Tkw_SelfInfo_Control_edLogin_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edLogin');
 inherited;
end;//Tkw_SelfInfo_Control_edLogin_Push.DoDoIt

class function Tkw_SelfInfo_Control_edLogin_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edLogin:push';
end;//Tkw_SelfInfo_Control_edLogin_Push.GetWordNameForRegister

function Tkw_SelfInfo_Control_edEmail.GetString: AnsiString;
begin
 Result := 'edEmail';
end;//Tkw_SelfInfo_Control_edEmail.GetString

class procedure Tkw_SelfInfo_Control_edEmail.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_SelfInfo_Control_edEmail.RegisterInEngine

class function Tkw_SelfInfo_Control_edEmail.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edEmail';
end;//Tkw_SelfInfo_Control_edEmail.GetWordNameForRegister

procedure Tkw_SelfInfo_Control_edEmail_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edEmail');
 inherited;
end;//Tkw_SelfInfo_Control_edEmail_Push.DoDoIt

class function Tkw_SelfInfo_Control_edEmail_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edEmail:push';
end;//Tkw_SelfInfo_Control_edEmail_Push.GetWordNameForRegister

function Tkw_SelfInfo_Control_edConfirm.GetString: AnsiString;
begin
 Result := 'edConfirm';
end;//Tkw_SelfInfo_Control_edConfirm.GetString

class procedure Tkw_SelfInfo_Control_edConfirm.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscComboBoxWithPwdChar);
end;//Tkw_SelfInfo_Control_edConfirm.RegisterInEngine

class function Tkw_SelfInfo_Control_edConfirm.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edConfirm';
end;//Tkw_SelfInfo_Control_edConfirm.GetWordNameForRegister

procedure Tkw_SelfInfo_Control_edConfirm_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edConfirm');
 inherited;
end;//Tkw_SelfInfo_Control_edConfirm_Push.DoDoIt

class function Tkw_SelfInfo_Control_edConfirm_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edConfirm:push';
end;//Tkw_SelfInfo_Control_edConfirm_Push.GetWordNameForRegister

function Tkw_SelfInfo_Control_BottomPanel.GetString: AnsiString;
begin
 Result := 'BottomPanel';
end;//Tkw_SelfInfo_Control_BottomPanel.GetString

class procedure Tkw_SelfInfo_Control_BottomPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_SelfInfo_Control_BottomPanel.RegisterInEngine

class function Tkw_SelfInfo_Control_BottomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BottomPanel';
end;//Tkw_SelfInfo_Control_BottomPanel.GetWordNameForRegister

procedure Tkw_SelfInfo_Control_BottomPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BottomPanel');
 inherited;
end;//Tkw_SelfInfo_Control_BottomPanel_Push.DoDoIt

class function Tkw_SelfInfo_Control_BottomPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BottomPanel:push';
end;//Tkw_SelfInfo_Control_BottomPanel_Push.GetWordNameForRegister

function Tkw_SelfInfo_Control_RegisterButton.GetString: AnsiString;
begin
 Result := 'RegisterButton';
end;//Tkw_SelfInfo_Control_RegisterButton.GetString

class procedure Tkw_SelfInfo_Control_RegisterButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_SelfInfo_Control_RegisterButton.RegisterInEngine

class function Tkw_SelfInfo_Control_RegisterButton.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RegisterButton';
end;//Tkw_SelfInfo_Control_RegisterButton.GetWordNameForRegister

procedure Tkw_SelfInfo_Control_RegisterButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('RegisterButton');
 inherited;
end;//Tkw_SelfInfo_Control_RegisterButton_Push.DoDoIt

class function Tkw_SelfInfo_Control_RegisterButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RegisterButton:push';
end;//Tkw_SelfInfo_Control_RegisterButton_Push.GetWordNameForRegister

function Tkw_SelfInfo_Control_HelpPanel.GetString: AnsiString;
begin
 Result := 'HelpPanel';
end;//Tkw_SelfInfo_Control_HelpPanel.GetString

class procedure Tkw_SelfInfo_Control_HelpPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_SelfInfo_Control_HelpPanel.RegisterInEngine

class function Tkw_SelfInfo_Control_HelpPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HelpPanel';
end;//Tkw_SelfInfo_Control_HelpPanel.GetWordNameForRegister

procedure Tkw_SelfInfo_Control_HelpPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('HelpPanel');
 inherited;
end;//Tkw_SelfInfo_Control_HelpPanel_Push.DoDoIt

class function Tkw_SelfInfo_Control_HelpPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HelpPanel:push';
end;//Tkw_SelfInfo_Control_HelpPanel_Push.GetWordNameForRegister

function Tkw_SelfInfo_Control_HelpPaintBox.GetString: AnsiString;
begin
 Result := 'HelpPaintBox';
end;//Tkw_SelfInfo_Control_HelpPaintBox.GetString

class procedure Tkw_SelfInfo_Control_HelpPaintBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_SelfInfo_Control_HelpPaintBox.RegisterInEngine

class function Tkw_SelfInfo_Control_HelpPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HelpPaintBox';
end;//Tkw_SelfInfo_Control_HelpPaintBox.GetWordNameForRegister

procedure Tkw_SelfInfo_Control_HelpPaintBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('HelpPaintBox');
 inherited;
end;//Tkw_SelfInfo_Control_HelpPaintBox_Push.DoDoIt

class function Tkw_SelfInfo_Control_HelpPaintBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HelpPaintBox:push';
end;//Tkw_SelfInfo_Control_HelpPaintBox_Push.GetWordNameForRegister

function Tkw_SelfInfo_Control_HelpLabel.GetString: AnsiString;
begin
 Result := 'HelpLabel';
end;//Tkw_SelfInfo_Control_HelpLabel.GetString

class procedure Tkw_SelfInfo_Control_HelpLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtFocusLabel);
end;//Tkw_SelfInfo_Control_HelpLabel.RegisterInEngine

class function Tkw_SelfInfo_Control_HelpLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HelpLabel';
end;//Tkw_SelfInfo_Control_HelpLabel.GetWordNameForRegister

procedure Tkw_SelfInfo_Control_HelpLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('HelpLabel');
 inherited;
end;//Tkw_SelfInfo_Control_HelpLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_HelpLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HelpLabel:push';
end;//Tkw_SelfInfo_Control_HelpLabel_Push.GetWordNameForRegister

function TkwSelfInfoFormPnMainData.pnMainData(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtPanel;
 {* ���������� ����� ������� .TSelfInfoForm.pnMainData }
begin
 Result := aSelfInfoForm.pnMainData;
end;//TkwSelfInfoFormPnMainData.pnMainData

class function TkwSelfInfoFormPnMainData.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.pnMainData';
end;//TkwSelfInfoFormPnMainData.GetWordNameForRegister

function TkwSelfInfoFormPnMainData.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwSelfInfoFormPnMainData.GetResultTypeInfo

function TkwSelfInfoFormPnMainData.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormPnMainData.GetAllParamsCount

function TkwSelfInfoFormPnMainData.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormPnMainData.ParamsTypes

procedure TkwSelfInfoFormPnMainData.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnMainData', aCtx);
end;//TkwSelfInfoFormPnMainData.SetValuePrim

procedure TkwSelfInfoFormPnMainData.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnMainData(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormPnMainData.DoDoIt

function TkwSelfInfoFormUserNameLabel.UserNameLabel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {* ���������� ����� ������� .TSelfInfoForm.UserNameLabel }
begin
 Result := aSelfInfoForm.UserNameLabel;
end;//TkwSelfInfoFormUserNameLabel.UserNameLabel

class function TkwSelfInfoFormUserNameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.UserNameLabel';
end;//TkwSelfInfoFormUserNameLabel.GetWordNameForRegister

function TkwSelfInfoFormUserNameLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwSelfInfoFormUserNameLabel.GetResultTypeInfo

function TkwSelfInfoFormUserNameLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormUserNameLabel.GetAllParamsCount

function TkwSelfInfoFormUserNameLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormUserNameLabel.ParamsTypes

procedure TkwSelfInfoFormUserNameLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� UserNameLabel', aCtx);
end;//TkwSelfInfoFormUserNameLabel.SetValuePrim

procedure TkwSelfInfoFormUserNameLabel.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(UserNameLabel(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormUserNameLabel.DoDoIt

function TkwSelfInfoFormPasswordLabel.PasswordLabel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {* ���������� ����� ������� .TSelfInfoForm.PasswordLabel }
begin
 Result := aSelfInfoForm.PasswordLabel;
end;//TkwSelfInfoFormPasswordLabel.PasswordLabel

class function TkwSelfInfoFormPasswordLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.PasswordLabel';
end;//TkwSelfInfoFormPasswordLabel.GetWordNameForRegister

function TkwSelfInfoFormPasswordLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwSelfInfoFormPasswordLabel.GetResultTypeInfo

function TkwSelfInfoFormPasswordLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormPasswordLabel.GetAllParamsCount

function TkwSelfInfoFormPasswordLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormPasswordLabel.ParamsTypes

procedure TkwSelfInfoFormPasswordLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� PasswordLabel', aCtx);
end;//TkwSelfInfoFormPasswordLabel.SetValuePrim

procedure TkwSelfInfoFormPasswordLabel.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(PasswordLabel(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormPasswordLabel.DoDoIt

function TkwSelfInfoFormLoginLabel.LoginLabel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {* ���������� ����� ������� .TSelfInfoForm.LoginLabel }
begin
 Result := aSelfInfoForm.LoginLabel;
end;//TkwSelfInfoFormLoginLabel.LoginLabel

class function TkwSelfInfoFormLoginLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.LoginLabel';
end;//TkwSelfInfoFormLoginLabel.GetWordNameForRegister

function TkwSelfInfoFormLoginLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwSelfInfoFormLoginLabel.GetResultTypeInfo

function TkwSelfInfoFormLoginLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormLoginLabel.GetAllParamsCount

function TkwSelfInfoFormLoginLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormLoginLabel.ParamsTypes

procedure TkwSelfInfoFormLoginLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� LoginLabel', aCtx);
end;//TkwSelfInfoFormLoginLabel.SetValuePrim

procedure TkwSelfInfoFormLoginLabel.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LoginLabel(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormLoginLabel.DoDoIt

function TkwSelfInfoFormInfoLabel.InfoLabel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {* ���������� ����� ������� .TSelfInfoForm.InfoLabel }
begin
 Result := aSelfInfoForm.InfoLabel;
end;//TkwSelfInfoFormInfoLabel.InfoLabel

class function TkwSelfInfoFormInfoLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.InfoLabel';
end;//TkwSelfInfoFormInfoLabel.GetWordNameForRegister

function TkwSelfInfoFormInfoLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwSelfInfoFormInfoLabel.GetResultTypeInfo

function TkwSelfInfoFormInfoLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormInfoLabel.GetAllParamsCount

function TkwSelfInfoFormInfoLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormInfoLabel.ParamsTypes

procedure TkwSelfInfoFormInfoLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� InfoLabel', aCtx);
end;//TkwSelfInfoFormInfoLabel.SetValuePrim

procedure TkwSelfInfoFormInfoLabel.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(InfoLabel(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormInfoLabel.DoDoIt

function TkwSelfInfoFormEMailLabel.EMailLabel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {* ���������� ����� ������� .TSelfInfoForm.EMailLabel }
begin
 Result := aSelfInfoForm.EMailLabel;
end;//TkwSelfInfoFormEMailLabel.EMailLabel

class function TkwSelfInfoFormEMailLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.EMailLabel';
end;//TkwSelfInfoFormEMailLabel.GetWordNameForRegister

function TkwSelfInfoFormEMailLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwSelfInfoFormEMailLabel.GetResultTypeInfo

function TkwSelfInfoFormEMailLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormEMailLabel.GetAllParamsCount

function TkwSelfInfoFormEMailLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormEMailLabel.ParamsTypes

procedure TkwSelfInfoFormEMailLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� EMailLabel', aCtx);
end;//TkwSelfInfoFormEMailLabel.SetValuePrim

procedure TkwSelfInfoFormEMailLabel.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(EMailLabel(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormEMailLabel.DoDoIt

function TkwSelfInfoFormConfirmPasswordLabel.ConfirmPasswordLabel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {* ���������� ����� ������� .TSelfInfoForm.ConfirmPasswordLabel }
begin
 Result := aSelfInfoForm.ConfirmPasswordLabel;
end;//TkwSelfInfoFormConfirmPasswordLabel.ConfirmPasswordLabel

class function TkwSelfInfoFormConfirmPasswordLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.ConfirmPasswordLabel';
end;//TkwSelfInfoFormConfirmPasswordLabel.GetWordNameForRegister

function TkwSelfInfoFormConfirmPasswordLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwSelfInfoFormConfirmPasswordLabel.GetResultTypeInfo

function TkwSelfInfoFormConfirmPasswordLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormConfirmPasswordLabel.GetAllParamsCount

function TkwSelfInfoFormConfirmPasswordLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormConfirmPasswordLabel.ParamsTypes

procedure TkwSelfInfoFormConfirmPasswordLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ConfirmPasswordLabel', aCtx);
end;//TkwSelfInfoFormConfirmPasswordLabel.SetValuePrim

procedure TkwSelfInfoFormConfirmPasswordLabel.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ConfirmPasswordLabel(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormConfirmPasswordLabel.DoDoIt

function TkwSelfInfoFormVtAsteriskLabelLogin.vtAsteriskLabelLogin(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {* ���������� ����� ������� .TSelfInfoForm.vtAsteriskLabelLogin }
begin
 Result := aSelfInfoForm.vtAsteriskLabelLogin;
end;//TkwSelfInfoFormVtAsteriskLabelLogin.vtAsteriskLabelLogin

class function TkwSelfInfoFormVtAsteriskLabelLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.vtAsteriskLabelLogin';
end;//TkwSelfInfoFormVtAsteriskLabelLogin.GetWordNameForRegister

function TkwSelfInfoFormVtAsteriskLabelLogin.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwSelfInfoFormVtAsteriskLabelLogin.GetResultTypeInfo

function TkwSelfInfoFormVtAsteriskLabelLogin.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormVtAsteriskLabelLogin.GetAllParamsCount

function TkwSelfInfoFormVtAsteriskLabelLogin.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormVtAsteriskLabelLogin.ParamsTypes

procedure TkwSelfInfoFormVtAsteriskLabelLogin.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� vtAsteriskLabelLogin', aCtx);
end;//TkwSelfInfoFormVtAsteriskLabelLogin.SetValuePrim

procedure TkwSelfInfoFormVtAsteriskLabelLogin.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(vtAsteriskLabelLogin(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormVtAsteriskLabelLogin.DoDoIt

function TkwSelfInfoFormVtAsteriskLabelFIO.vtAsteriskLabelFIO(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {* ���������� ����� ������� .TSelfInfoForm.vtAsteriskLabelFIO }
begin
 Result := aSelfInfoForm.vtAsteriskLabelFIO;
end;//TkwSelfInfoFormVtAsteriskLabelFIO.vtAsteriskLabelFIO

class function TkwSelfInfoFormVtAsteriskLabelFIO.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.vtAsteriskLabelFIO';
end;//TkwSelfInfoFormVtAsteriskLabelFIO.GetWordNameForRegister

function TkwSelfInfoFormVtAsteriskLabelFIO.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwSelfInfoFormVtAsteriskLabelFIO.GetResultTypeInfo

function TkwSelfInfoFormVtAsteriskLabelFIO.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormVtAsteriskLabelFIO.GetAllParamsCount

function TkwSelfInfoFormVtAsteriskLabelFIO.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormVtAsteriskLabelFIO.ParamsTypes

procedure TkwSelfInfoFormVtAsteriskLabelFIO.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� vtAsteriskLabelFIO', aCtx);
end;//TkwSelfInfoFormVtAsteriskLabelFIO.SetValuePrim

procedure TkwSelfInfoFormVtAsteriskLabelFIO.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(vtAsteriskLabelFIO(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormVtAsteriskLabelFIO.DoDoIt

function TkwSelfInfoFormEdPassword.edPassword(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TnscComboBoxWithPwdChar;
 {* ���������� ����� ������� .TSelfInfoForm.edPassword }
begin
 Result := aSelfInfoForm.edPassword;
end;//TkwSelfInfoFormEdPassword.edPassword

class function TkwSelfInfoFormEdPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.edPassword';
end;//TkwSelfInfoFormEdPassword.GetWordNameForRegister

function TkwSelfInfoFormEdPassword.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscComboBoxWithPwdChar);
end;//TkwSelfInfoFormEdPassword.GetResultTypeInfo

function TkwSelfInfoFormEdPassword.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormEdPassword.GetAllParamsCount

function TkwSelfInfoFormEdPassword.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormEdPassword.ParamsTypes

procedure TkwSelfInfoFormEdPassword.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� edPassword', aCtx);
end;//TkwSelfInfoFormEdPassword.SetValuePrim

procedure TkwSelfInfoFormEdPassword.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edPassword(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormEdPassword.DoDoIt

function TkwSelfInfoFormEdUserName.edUserName(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TnscEdit;
 {* ���������� ����� ������� .TSelfInfoForm.edUserName }
begin
 Result := aSelfInfoForm.edUserName;
end;//TkwSelfInfoFormEdUserName.edUserName

class function TkwSelfInfoFormEdUserName.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.edUserName';
end;//TkwSelfInfoFormEdUserName.GetWordNameForRegister

function TkwSelfInfoFormEdUserName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEdit);
end;//TkwSelfInfoFormEdUserName.GetResultTypeInfo

function TkwSelfInfoFormEdUserName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormEdUserName.GetAllParamsCount

function TkwSelfInfoFormEdUserName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormEdUserName.ParamsTypes

procedure TkwSelfInfoFormEdUserName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� edUserName', aCtx);
end;//TkwSelfInfoFormEdUserName.SetValuePrim

procedure TkwSelfInfoFormEdUserName.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edUserName(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormEdUserName.DoDoIt

function TkwSelfInfoFormEdLogin.edLogin(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TnscEdit;
 {* ���������� ����� ������� .TSelfInfoForm.edLogin }
begin
 Result := aSelfInfoForm.edLogin;
end;//TkwSelfInfoFormEdLogin.edLogin

class function TkwSelfInfoFormEdLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.edLogin';
end;//TkwSelfInfoFormEdLogin.GetWordNameForRegister

function TkwSelfInfoFormEdLogin.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEdit);
end;//TkwSelfInfoFormEdLogin.GetResultTypeInfo

function TkwSelfInfoFormEdLogin.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormEdLogin.GetAllParamsCount

function TkwSelfInfoFormEdLogin.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormEdLogin.ParamsTypes

procedure TkwSelfInfoFormEdLogin.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� edLogin', aCtx);
end;//TkwSelfInfoFormEdLogin.SetValuePrim

procedure TkwSelfInfoFormEdLogin.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edLogin(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormEdLogin.DoDoIt

function TkwSelfInfoFormEdEmail.edEmail(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TnscEdit;
 {* ���������� ����� ������� .TSelfInfoForm.edEmail }
begin
 Result := aSelfInfoForm.edEmail;
end;//TkwSelfInfoFormEdEmail.edEmail

class function TkwSelfInfoFormEdEmail.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.edEmail';
end;//TkwSelfInfoFormEdEmail.GetWordNameForRegister

function TkwSelfInfoFormEdEmail.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEdit);
end;//TkwSelfInfoFormEdEmail.GetResultTypeInfo

function TkwSelfInfoFormEdEmail.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormEdEmail.GetAllParamsCount

function TkwSelfInfoFormEdEmail.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormEdEmail.ParamsTypes

procedure TkwSelfInfoFormEdEmail.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� edEmail', aCtx);
end;//TkwSelfInfoFormEdEmail.SetValuePrim

procedure TkwSelfInfoFormEdEmail.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edEmail(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormEdEmail.DoDoIt

function TkwSelfInfoFormEdConfirm.edConfirm(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TnscComboBoxWithPwdChar;
 {* ���������� ����� ������� .TSelfInfoForm.edConfirm }
begin
 Result := aSelfInfoForm.edConfirm;
end;//TkwSelfInfoFormEdConfirm.edConfirm

class function TkwSelfInfoFormEdConfirm.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.edConfirm';
end;//TkwSelfInfoFormEdConfirm.GetWordNameForRegister

function TkwSelfInfoFormEdConfirm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscComboBoxWithPwdChar);
end;//TkwSelfInfoFormEdConfirm.GetResultTypeInfo

function TkwSelfInfoFormEdConfirm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormEdConfirm.GetAllParamsCount

function TkwSelfInfoFormEdConfirm.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormEdConfirm.ParamsTypes

procedure TkwSelfInfoFormEdConfirm.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� edConfirm', aCtx);
end;//TkwSelfInfoFormEdConfirm.SetValuePrim

procedure TkwSelfInfoFormEdConfirm.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edConfirm(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormEdConfirm.DoDoIt

function TkwSelfInfoFormBottomPanel.BottomPanel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtPanel;
 {* ���������� ����� ������� .TSelfInfoForm.BottomPanel }
begin
 Result := aSelfInfoForm.BottomPanel;
end;//TkwSelfInfoFormBottomPanel.BottomPanel

class function TkwSelfInfoFormBottomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.BottomPanel';
end;//TkwSelfInfoFormBottomPanel.GetWordNameForRegister

function TkwSelfInfoFormBottomPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwSelfInfoFormBottomPanel.GetResultTypeInfo

function TkwSelfInfoFormBottomPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormBottomPanel.GetAllParamsCount

function TkwSelfInfoFormBottomPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormBottomPanel.ParamsTypes

procedure TkwSelfInfoFormBottomPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� BottomPanel', aCtx);
end;//TkwSelfInfoFormBottomPanel.SetValuePrim

procedure TkwSelfInfoFormBottomPanel.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BottomPanel(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormBottomPanel.DoDoIt

function TkwSelfInfoFormRegisterButton.RegisterButton(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TElPopupButton;
 {* ���������� ����� ������� .TSelfInfoForm.RegisterButton }
begin
 Result := aSelfInfoForm.RegisterButton;
end;//TkwSelfInfoFormRegisterButton.RegisterButton

class function TkwSelfInfoFormRegisterButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.RegisterButton';
end;//TkwSelfInfoFormRegisterButton.GetWordNameForRegister

function TkwSelfInfoFormRegisterButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwSelfInfoFormRegisterButton.GetResultTypeInfo

function TkwSelfInfoFormRegisterButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormRegisterButton.GetAllParamsCount

function TkwSelfInfoFormRegisterButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormRegisterButton.ParamsTypes

procedure TkwSelfInfoFormRegisterButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� RegisterButton', aCtx);
end;//TkwSelfInfoFormRegisterButton.SetValuePrim

procedure TkwSelfInfoFormRegisterButton.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(RegisterButton(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormRegisterButton.DoDoIt

function TkwSelfInfoFormHelpPanel.HelpPanel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtPanel;
 {* ���������� ����� ������� .TSelfInfoForm.HelpPanel }
begin
 Result := aSelfInfoForm.HelpPanel;
end;//TkwSelfInfoFormHelpPanel.HelpPanel

class function TkwSelfInfoFormHelpPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.HelpPanel';
end;//TkwSelfInfoFormHelpPanel.GetWordNameForRegister

function TkwSelfInfoFormHelpPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwSelfInfoFormHelpPanel.GetResultTypeInfo

function TkwSelfInfoFormHelpPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormHelpPanel.GetAllParamsCount

function TkwSelfInfoFormHelpPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormHelpPanel.ParamsTypes

procedure TkwSelfInfoFormHelpPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� HelpPanel', aCtx);
end;//TkwSelfInfoFormHelpPanel.SetValuePrim

procedure TkwSelfInfoFormHelpPanel.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(HelpPanel(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormHelpPanel.DoDoIt

function TkwSelfInfoFormHelpPaintBox.HelpPaintBox(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TPaintBox;
 {* ���������� ����� ������� .TSelfInfoForm.HelpPaintBox }
begin
 Result := aSelfInfoForm.HelpPaintBox;
end;//TkwSelfInfoFormHelpPaintBox.HelpPaintBox

class function TkwSelfInfoFormHelpPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.HelpPaintBox';
end;//TkwSelfInfoFormHelpPaintBox.GetWordNameForRegister

function TkwSelfInfoFormHelpPaintBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwSelfInfoFormHelpPaintBox.GetResultTypeInfo

function TkwSelfInfoFormHelpPaintBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormHelpPaintBox.GetAllParamsCount

function TkwSelfInfoFormHelpPaintBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormHelpPaintBox.ParamsTypes

procedure TkwSelfInfoFormHelpPaintBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� HelpPaintBox', aCtx);
end;//TkwSelfInfoFormHelpPaintBox.SetValuePrim

procedure TkwSelfInfoFormHelpPaintBox.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(HelpPaintBox(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormHelpPaintBox.DoDoIt

function TkwSelfInfoFormHelpLabel.HelpLabel(const aCtx: TtfwContext;
 aSelfInfoForm: TSelfInfoForm): TvtFocusLabel;
 {* ���������� ����� ������� .TSelfInfoForm.HelpLabel }
begin
 Result := aSelfInfoForm.HelpLabel;
end;//TkwSelfInfoFormHelpLabel.HelpLabel

class function TkwSelfInfoFormHelpLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TSelfInfoForm.HelpLabel';
end;//TkwSelfInfoFormHelpLabel.GetWordNameForRegister

function TkwSelfInfoFormHelpLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtFocusLabel);
end;//TkwSelfInfoFormHelpLabel.GetResultTypeInfo

function TkwSelfInfoFormHelpLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSelfInfoFormHelpLabel.GetAllParamsCount

function TkwSelfInfoFormHelpLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormHelpLabel.ParamsTypes

procedure TkwSelfInfoFormHelpLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� HelpLabel', aCtx);
end;//TkwSelfInfoFormHelpLabel.SetValuePrim

procedure TkwSelfInfoFormHelpLabel.DoDoIt(const aCtx: TtfwContext);
var l_aSelfInfoForm: TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(HelpLabel(aCtx, l_aSelfInfoForm));
end;//TkwSelfInfoFormHelpLabel.DoDoIt

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
 TtfwTypeRegistrator.RegisterType(TypeInfo(TSelfInfoForm));
 {* ����������� ���� TSelfInfoForm }
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

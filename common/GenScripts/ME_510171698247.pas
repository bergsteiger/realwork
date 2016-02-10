unit LoginKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Login }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\LoginKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PrimCommon_Module
 , vtGroupBox
 , vtLabel
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If Defined(Nemesis)}
 , nscComboBoxWithReadOnly
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 , vtFocusLabel
 , vtCheckBox
 , ElPopBtn
 , vtPanel
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_Login = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Login
----
*������ �������������*:
[code]
'aControl' �����::Login TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Login

 Tkw_Login_Control_RegisteredGroupBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� RegisteredGroupBox
----
*������ �������������*:
[code]
�������::RegisteredGroupBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Login_Control_RegisteredGroupBox

 Tkw_Login_Control_RegisteredGroupBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� RegisteredGroupBox
----
*������ �������������*:
[code]
�������::RegisteredGroupBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_RegisteredGroupBox_Push

 Tkw_Login_Control_lblLogin = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblLogin
----
*������ �������������*:
[code]
�������::lblLogin TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Login_Control_lblLogin

 Tkw_Login_Control_lblLogin_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lblLogin
----
*������ �������������*:
[code]
�������::lblLogin:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_lblLogin_Push

 Tkw_Login_Control_lblPassword = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblPassword
----
*������ �������������*:
[code]
�������::lblPassword TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Login_Control_lblPassword

 Tkw_Login_Control_lblPassword_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lblPassword
----
*������ �������������*:
[code]
�������::lblPassword:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_lblPassword_Push

 Tkw_Login_Control_EnterPaintBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� EnterPaintBox
----
*������ �������������*:
[code]
�������::EnterPaintBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Login_Control_EnterPaintBox

 Tkw_Login_Control_EnterPaintBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� EnterPaintBox
----
*������ �������������*:
[code]
�������::EnterPaintBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_EnterPaintBox_Push

 Tkw_Login_Control_edUserName = {final} class(TtfwControlString)
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
 end;//Tkw_Login_Control_edUserName

 Tkw_Login_Control_edUserName_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edUserName
----
*������ �������������*:
[code]
�������::edUserName:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_edUserName_Push

 Tkw_Login_Control_edPassword = {final} class(TtfwControlString)
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
 end;//Tkw_Login_Control_edPassword

 Tkw_Login_Control_edPassword_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edPassword
----
*������ �������������*:
[code]
�������::edPassword:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_edPassword_Push

 Tkw_Login_Control_lblForgetPassword = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblForgetPassword
----
*������ �������������*:
[code]
�������::lblForgetPassword TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Login_Control_lblForgetPassword

 Tkw_Login_Control_lblForgetPassword_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lblForgetPassword
----
*������ �������������*:
[code]
�������::lblForgetPassword:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_lblForgetPassword_Push

 Tkw_Login_Control_cbAutoLogin = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� cbAutoLogin
----
*������ �������������*:
[code]
�������::cbAutoLogin TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Login_Control_cbAutoLogin

 Tkw_Login_Control_cbAutoLogin_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� cbAutoLogin
----
*������ �������������*:
[code]
�������::cbAutoLogin:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_cbAutoLogin_Push

 Tkw_Login_Control_btnOk = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btnOk
----
*������ �������������*:
[code]
�������::btnOk TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Login_Control_btnOk

 Tkw_Login_Control_btnOk_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btnOk
----
*������ �������������*:
[code]
�������::btnOk:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_btnOk_Push

 Tkw_Login_Control_NewUserGroupBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� NewUserGroupBox
----
*������ �������������*:
[code]
�������::NewUserGroupBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Login_Control_NewUserGroupBox

 Tkw_Login_Control_NewUserGroupBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� NewUserGroupBox
----
*������ �������������*:
[code]
�������::NewUserGroupBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_NewUserGroupBox_Push

 Tkw_Login_Control_NewUserLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� NewUserLabel
----
*������ �������������*:
[code]
�������::NewUserLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Login_Control_NewUserLabel

 Tkw_Login_Control_NewUserLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� NewUserLabel
----
*������ �������������*:
[code]
�������::NewUserLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_NewUserLabel_Push

 Tkw_Login_Control_NewUserPaintBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� NewUserPaintBox
----
*������ �������������*:
[code]
�������::NewUserPaintBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Login_Control_NewUserPaintBox

 Tkw_Login_Control_NewUserPaintBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� NewUserPaintBox
----
*������ �������������*:
[code]
�������::NewUserPaintBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_NewUserPaintBox_Push

 Tkw_Login_Control_lblNewUser = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblNewUser
----
*������ �������������*:
[code]
�������::lblNewUser TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Login_Control_lblNewUser

 Tkw_Login_Control_lblNewUser_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lblNewUser
----
*������ �������������*:
[code]
�������::lblNewUser:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_lblNewUser_Push

 Tkw_Login_Control_HelpPanel = {final} class(TtfwControlString)
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
 end;//Tkw_Login_Control_HelpPanel

 Tkw_Login_Control_HelpPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� HelpPanel
----
*������ �������������*:
[code]
�������::HelpPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_HelpPanel_Push

 Tkw_Login_Control_HelpPaintBox = {final} class(TtfwControlString)
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
 end;//Tkw_Login_Control_HelpPaintBox

 Tkw_Login_Control_HelpPaintBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� HelpPaintBox
----
*������ �������������*:
[code]
�������::HelpPaintBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_HelpPaintBox_Push

 Tkw_Login_Control_HelpLabel = {final} class(TtfwControlString)
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
 end;//Tkw_Login_Control_HelpLabel

 Tkw_Login_Control_HelpLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� HelpLabel
----
*������ �������������*:
[code]
�������::HelpLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_HelpLabel_Push

 TkwLoginFormRegisteredGroupBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TLoginForm.RegisteredGroupBox
[panel]������� RegisteredGroupBox ����� TLoginForm[panel]
*��� ����������:* TvtGroupBox
*������:*
[code]
OBJECT VAR l_TvtGroupBox
 aLoginForm .TLoginForm.RegisteredGroupBox >>> l_TvtGroupBox
[code]  }
  private
   function RegisteredGroupBox(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TvtGroupBox;
    {* ���������� ����� ������� .TLoginForm.RegisteredGroupBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLoginFormRegisteredGroupBox

 TkwLoginFormLblLogin = {final} class(TtfwPropertyLike)
  {* ����� ������� .TLoginForm.lblLogin
[panel]������� lblLogin ����� TLoginForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aLoginForm .TLoginForm.lblLogin >>> l_TvtLabel
[code]  }
  private
   function lblLogin(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TvtLabel;
    {* ���������� ����� ������� .TLoginForm.lblLogin }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLoginFormLblLogin

 TkwLoginFormLblPassword = {final} class(TtfwPropertyLike)
  {* ����� ������� .TLoginForm.lblPassword
[panel]������� lblPassword ����� TLoginForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aLoginForm .TLoginForm.lblPassword >>> l_TvtLabel
[code]  }
  private
   function lblPassword(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TvtLabel;
    {* ���������� ����� ������� .TLoginForm.lblPassword }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLoginFormLblPassword

 TkwLoginFormEnterPaintBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TLoginForm.EnterPaintBox
[panel]������� EnterPaintBox ����� TLoginForm[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aLoginForm .TLoginForm.EnterPaintBox >>> l_TPaintBox
[code]  }
  private
   function EnterPaintBox(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TPaintBox;
    {* ���������� ����� ������� .TLoginForm.EnterPaintBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLoginFormEnterPaintBox

 TkwLoginFormEdUserName = {final} class(TtfwPropertyLike)
  {* ����� ������� .TLoginForm.edUserName
[panel]������� edUserName ����� TLoginForm[panel]
*��� ����������:* TnscComboBoxWithReadOnly
*������:*
[code]
OBJECT VAR l_TnscComboBoxWithReadOnly
 aLoginForm .TLoginForm.edUserName >>> l_TnscComboBoxWithReadOnly
[code]  }
  private
   function edUserName(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TnscComboBoxWithReadOnly;
    {* ���������� ����� ������� .TLoginForm.edUserName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLoginFormEdUserName

 TkwLoginFormEdPassword = {final} class(TtfwPropertyLike)
  {* ����� ������� .TLoginForm.edPassword
[panel]������� edPassword ����� TLoginForm[panel]
*��� ����������:* TnscComboBoxWithPwdChar
*������:*
[code]
OBJECT VAR l_TnscComboBoxWithPwdChar
 aLoginForm .TLoginForm.edPassword >>> l_TnscComboBoxWithPwdChar
[code]  }
  private
   function edPassword(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TnscComboBoxWithPwdChar;
    {* ���������� ����� ������� .TLoginForm.edPassword }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLoginFormEdPassword

 TkwLoginFormLblForgetPassword = {final} class(TtfwPropertyLike)
  {* ����� ������� .TLoginForm.lblForgetPassword
[panel]������� lblForgetPassword ����� TLoginForm[panel]
*��� ����������:* TvtFocusLabel
*������:*
[code]
OBJECT VAR l_TvtFocusLabel
 aLoginForm .TLoginForm.lblForgetPassword >>> l_TvtFocusLabel
[code]  }
  private
   function lblForgetPassword(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TvtFocusLabel;
    {* ���������� ����� ������� .TLoginForm.lblForgetPassword }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLoginFormLblForgetPassword

 TkwLoginFormCbAutoLogin = {final} class(TtfwPropertyLike)
  {* ����� ������� .TLoginForm.cbAutoLogin
[panel]������� cbAutoLogin ����� TLoginForm[panel]
*��� ����������:* TvtCheckBox
*������:*
[code]
OBJECT VAR l_TvtCheckBox
 aLoginForm .TLoginForm.cbAutoLogin >>> l_TvtCheckBox
[code]  }
  private
   function cbAutoLogin(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TvtCheckBox;
    {* ���������� ����� ������� .TLoginForm.cbAutoLogin }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLoginFormCbAutoLogin

 TkwLoginFormBtnOk = {final} class(TtfwPropertyLike)
  {* ����� ������� .TLoginForm.btnOk
[panel]������� btnOk ����� TLoginForm[panel]
*��� ����������:* TElPopupButton
*������:*
[code]
OBJECT VAR l_TElPopupButton
 aLoginForm .TLoginForm.btnOk >>> l_TElPopupButton
[code]  }
  private
   function btnOk(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TElPopupButton;
    {* ���������� ����� ������� .TLoginForm.btnOk }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLoginFormBtnOk

 TkwLoginFormNewUserGroupBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TLoginForm.NewUserGroupBox
[panel]������� NewUserGroupBox ����� TLoginForm[panel]
*��� ����������:* TvtGroupBox
*������:*
[code]
OBJECT VAR l_TvtGroupBox
 aLoginForm .TLoginForm.NewUserGroupBox >>> l_TvtGroupBox
[code]  }
  private
   function NewUserGroupBox(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TvtGroupBox;
    {* ���������� ����� ������� .TLoginForm.NewUserGroupBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLoginFormNewUserGroupBox

 TkwLoginFormNewUserLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TLoginForm.NewUserLabel
[panel]������� NewUserLabel ����� TLoginForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aLoginForm .TLoginForm.NewUserLabel >>> l_TvtLabel
[code]  }
  private
   function NewUserLabel(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TvtLabel;
    {* ���������� ����� ������� .TLoginForm.NewUserLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLoginFormNewUserLabel

 TkwLoginFormNewUserPaintBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TLoginForm.NewUserPaintBox
[panel]������� NewUserPaintBox ����� TLoginForm[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aLoginForm .TLoginForm.NewUserPaintBox >>> l_TPaintBox
[code]  }
  private
   function NewUserPaintBox(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TPaintBox;
    {* ���������� ����� ������� .TLoginForm.NewUserPaintBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLoginFormNewUserPaintBox

 TkwLoginFormLblNewUser = {final} class(TtfwPropertyLike)
  {* ����� ������� .TLoginForm.lblNewUser
[panel]������� lblNewUser ����� TLoginForm[panel]
*��� ����������:* TvtFocusLabel
*������:*
[code]
OBJECT VAR l_TvtFocusLabel
 aLoginForm .TLoginForm.lblNewUser >>> l_TvtFocusLabel
[code]  }
  private
   function lblNewUser(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TvtFocusLabel;
    {* ���������� ����� ������� .TLoginForm.lblNewUser }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLoginFormLblNewUser

 TkwLoginFormHelpPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TLoginForm.HelpPanel
[panel]������� HelpPanel ����� TLoginForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aLoginForm .TLoginForm.HelpPanel >>> l_TvtPanel
[code]  }
  private
   function HelpPanel(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TvtPanel;
    {* ���������� ����� ������� .TLoginForm.HelpPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLoginFormHelpPanel

 TkwLoginFormHelpPaintBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TLoginForm.HelpPaintBox
[panel]������� HelpPaintBox ����� TLoginForm[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aLoginForm .TLoginForm.HelpPaintBox >>> l_TPaintBox
[code]  }
  private
   function HelpPaintBox(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TPaintBox;
    {* ���������� ����� ������� .TLoginForm.HelpPaintBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLoginFormHelpPaintBox

 TkwLoginFormHelpLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TLoginForm.HelpLabel
[panel]������� HelpLabel ����� TLoginForm[panel]
*��� ����������:* TvtFocusLabel
*������:*
[code]
OBJECT VAR l_TvtFocusLabel
 aLoginForm .TLoginForm.HelpLabel >>> l_TvtFocusLabel
[code]  }
  private
   function HelpLabel(const aCtx: TtfwContext;
    aLoginForm: TLoginForm): TvtFocusLabel;
    {* ���������� ����� ������� .TLoginForm.HelpLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLoginFormHelpLabel

class function Tkw_Form_Login.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Login';
end;//Tkw_Form_Login.GetWordNameForRegister

function Tkw_Form_Login.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_261C9A9EE165_var*
//#UC END# *4DDFD2EA0116_261C9A9EE165_var*
begin
//#UC START# *4DDFD2EA0116_261C9A9EE165_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_261C9A9EE165_impl*
end;//Tkw_Form_Login.GetString

class function Tkw_Login_Control_RegisteredGroupBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RegisteredGroupBox';
end;//Tkw_Login_Control_RegisteredGroupBox.GetWordNameForRegister

function Tkw_Login_Control_RegisteredGroupBox.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_D162EBE5BA6B_var*
//#UC END# *4DDFD2EA0116_D162EBE5BA6B_var*
begin
//#UC START# *4DDFD2EA0116_D162EBE5BA6B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_D162EBE5BA6B_impl*
end;//Tkw_Login_Control_RegisteredGroupBox.GetString

class procedure Tkw_Login_Control_RegisteredGroupBox.RegisterInEngine;
//#UC START# *52A086150180_D162EBE5BA6B_var*
//#UC END# *52A086150180_D162EBE5BA6B_var*
begin
//#UC START# *52A086150180_D162EBE5BA6B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_D162EBE5BA6B_impl*
end;//Tkw_Login_Control_RegisteredGroupBox.RegisterInEngine

procedure Tkw_Login_Control_RegisteredGroupBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8F4F59817B87_var*
//#UC END# *4DAEEDE10285_8F4F59817B87_var*
begin
//#UC START# *4DAEEDE10285_8F4F59817B87_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8F4F59817B87_impl*
end;//Tkw_Login_Control_RegisteredGroupBox_Push.DoDoIt

class function Tkw_Login_Control_RegisteredGroupBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RegisteredGroupBox:push';
end;//Tkw_Login_Control_RegisteredGroupBox_Push.GetWordNameForRegister

class function Tkw_Login_Control_lblLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblLogin';
end;//Tkw_Login_Control_lblLogin.GetWordNameForRegister

function Tkw_Login_Control_lblLogin.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_498E275B1BF9_var*
//#UC END# *4DDFD2EA0116_498E275B1BF9_var*
begin
//#UC START# *4DDFD2EA0116_498E275B1BF9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_498E275B1BF9_impl*
end;//Tkw_Login_Control_lblLogin.GetString

class procedure Tkw_Login_Control_lblLogin.RegisterInEngine;
//#UC START# *52A086150180_498E275B1BF9_var*
//#UC END# *52A086150180_498E275B1BF9_var*
begin
//#UC START# *52A086150180_498E275B1BF9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_498E275B1BF9_impl*
end;//Tkw_Login_Control_lblLogin.RegisterInEngine

procedure Tkw_Login_Control_lblLogin_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BFB3A4E89D9D_var*
//#UC END# *4DAEEDE10285_BFB3A4E89D9D_var*
begin
//#UC START# *4DAEEDE10285_BFB3A4E89D9D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BFB3A4E89D9D_impl*
end;//Tkw_Login_Control_lblLogin_Push.DoDoIt

class function Tkw_Login_Control_lblLogin_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblLogin:push';
end;//Tkw_Login_Control_lblLogin_Push.GetWordNameForRegister

class function Tkw_Login_Control_lblPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblPassword';
end;//Tkw_Login_Control_lblPassword.GetWordNameForRegister

function Tkw_Login_Control_lblPassword.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_59A6F6A37B4D_var*
//#UC END# *4DDFD2EA0116_59A6F6A37B4D_var*
begin
//#UC START# *4DDFD2EA0116_59A6F6A37B4D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_59A6F6A37B4D_impl*
end;//Tkw_Login_Control_lblPassword.GetString

class procedure Tkw_Login_Control_lblPassword.RegisterInEngine;
//#UC START# *52A086150180_59A6F6A37B4D_var*
//#UC END# *52A086150180_59A6F6A37B4D_var*
begin
//#UC START# *52A086150180_59A6F6A37B4D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_59A6F6A37B4D_impl*
end;//Tkw_Login_Control_lblPassword.RegisterInEngine

procedure Tkw_Login_Control_lblPassword_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FCF20663FE01_var*
//#UC END# *4DAEEDE10285_FCF20663FE01_var*
begin
//#UC START# *4DAEEDE10285_FCF20663FE01_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FCF20663FE01_impl*
end;//Tkw_Login_Control_lblPassword_Push.DoDoIt

class function Tkw_Login_Control_lblPassword_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblPassword:push';
end;//Tkw_Login_Control_lblPassword_Push.GetWordNameForRegister

class function Tkw_Login_Control_EnterPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EnterPaintBox';
end;//Tkw_Login_Control_EnterPaintBox.GetWordNameForRegister

function Tkw_Login_Control_EnterPaintBox.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_1A40AA72C55B_var*
//#UC END# *4DDFD2EA0116_1A40AA72C55B_var*
begin
//#UC START# *4DDFD2EA0116_1A40AA72C55B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_1A40AA72C55B_impl*
end;//Tkw_Login_Control_EnterPaintBox.GetString

class procedure Tkw_Login_Control_EnterPaintBox.RegisterInEngine;
//#UC START# *52A086150180_1A40AA72C55B_var*
//#UC END# *52A086150180_1A40AA72C55B_var*
begin
//#UC START# *52A086150180_1A40AA72C55B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_1A40AA72C55B_impl*
end;//Tkw_Login_Control_EnterPaintBox.RegisterInEngine

procedure Tkw_Login_Control_EnterPaintBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E72615CEFB02_var*
//#UC END# *4DAEEDE10285_E72615CEFB02_var*
begin
//#UC START# *4DAEEDE10285_E72615CEFB02_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E72615CEFB02_impl*
end;//Tkw_Login_Control_EnterPaintBox_Push.DoDoIt

class function Tkw_Login_Control_EnterPaintBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EnterPaintBox:push';
end;//Tkw_Login_Control_EnterPaintBox_Push.GetWordNameForRegister

class function Tkw_Login_Control_edUserName.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edUserName';
end;//Tkw_Login_Control_edUserName.GetWordNameForRegister

function Tkw_Login_Control_edUserName.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_3C63147DE6A9_var*
//#UC END# *4DDFD2EA0116_3C63147DE6A9_var*
begin
//#UC START# *4DDFD2EA0116_3C63147DE6A9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_3C63147DE6A9_impl*
end;//Tkw_Login_Control_edUserName.GetString

class procedure Tkw_Login_Control_edUserName.RegisterInEngine;
//#UC START# *52A086150180_3C63147DE6A9_var*
//#UC END# *52A086150180_3C63147DE6A9_var*
begin
//#UC START# *52A086150180_3C63147DE6A9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_3C63147DE6A9_impl*
end;//Tkw_Login_Control_edUserName.RegisterInEngine

procedure Tkw_Login_Control_edUserName_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2835E1A79985_var*
//#UC END# *4DAEEDE10285_2835E1A79985_var*
begin
//#UC START# *4DAEEDE10285_2835E1A79985_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2835E1A79985_impl*
end;//Tkw_Login_Control_edUserName_Push.DoDoIt

class function Tkw_Login_Control_edUserName_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edUserName:push';
end;//Tkw_Login_Control_edUserName_Push.GetWordNameForRegister

class function Tkw_Login_Control_edPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edPassword';
end;//Tkw_Login_Control_edPassword.GetWordNameForRegister

function Tkw_Login_Control_edPassword.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_8EEA9E785569_var*
//#UC END# *4DDFD2EA0116_8EEA9E785569_var*
begin
//#UC START# *4DDFD2EA0116_8EEA9E785569_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_8EEA9E785569_impl*
end;//Tkw_Login_Control_edPassword.GetString

class procedure Tkw_Login_Control_edPassword.RegisterInEngine;
//#UC START# *52A086150180_8EEA9E785569_var*
//#UC END# *52A086150180_8EEA9E785569_var*
begin
//#UC START# *52A086150180_8EEA9E785569_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_8EEA9E785569_impl*
end;//Tkw_Login_Control_edPassword.RegisterInEngine

procedure Tkw_Login_Control_edPassword_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_82A423A38F75_var*
//#UC END# *4DAEEDE10285_82A423A38F75_var*
begin
//#UC START# *4DAEEDE10285_82A423A38F75_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_82A423A38F75_impl*
end;//Tkw_Login_Control_edPassword_Push.DoDoIt

class function Tkw_Login_Control_edPassword_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edPassword:push';
end;//Tkw_Login_Control_edPassword_Push.GetWordNameForRegister

class function Tkw_Login_Control_lblForgetPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblForgetPassword';
end;//Tkw_Login_Control_lblForgetPassword.GetWordNameForRegister

function Tkw_Login_Control_lblForgetPassword.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_6384D06DD800_var*
//#UC END# *4DDFD2EA0116_6384D06DD800_var*
begin
//#UC START# *4DDFD2EA0116_6384D06DD800_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_6384D06DD800_impl*
end;//Tkw_Login_Control_lblForgetPassword.GetString

class procedure Tkw_Login_Control_lblForgetPassword.RegisterInEngine;
//#UC START# *52A086150180_6384D06DD800_var*
//#UC END# *52A086150180_6384D06DD800_var*
begin
//#UC START# *52A086150180_6384D06DD800_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_6384D06DD800_impl*
end;//Tkw_Login_Control_lblForgetPassword.RegisterInEngine

procedure Tkw_Login_Control_lblForgetPassword_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E86756EBBDCC_var*
//#UC END# *4DAEEDE10285_E86756EBBDCC_var*
begin
//#UC START# *4DAEEDE10285_E86756EBBDCC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E86756EBBDCC_impl*
end;//Tkw_Login_Control_lblForgetPassword_Push.DoDoIt

class function Tkw_Login_Control_lblForgetPassword_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblForgetPassword:push';
end;//Tkw_Login_Control_lblForgetPassword_Push.GetWordNameForRegister

class function Tkw_Login_Control_cbAutoLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbAutoLogin';
end;//Tkw_Login_Control_cbAutoLogin.GetWordNameForRegister

function Tkw_Login_Control_cbAutoLogin.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_3FBF8382C090_var*
//#UC END# *4DDFD2EA0116_3FBF8382C090_var*
begin
//#UC START# *4DDFD2EA0116_3FBF8382C090_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_3FBF8382C090_impl*
end;//Tkw_Login_Control_cbAutoLogin.GetString

class procedure Tkw_Login_Control_cbAutoLogin.RegisterInEngine;
//#UC START# *52A086150180_3FBF8382C090_var*
//#UC END# *52A086150180_3FBF8382C090_var*
begin
//#UC START# *52A086150180_3FBF8382C090_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_3FBF8382C090_impl*
end;//Tkw_Login_Control_cbAutoLogin.RegisterInEngine

procedure Tkw_Login_Control_cbAutoLogin_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8F1D27BFB76C_var*
//#UC END# *4DAEEDE10285_8F1D27BFB76C_var*
begin
//#UC START# *4DAEEDE10285_8F1D27BFB76C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8F1D27BFB76C_impl*
end;//Tkw_Login_Control_cbAutoLogin_Push.DoDoIt

class function Tkw_Login_Control_cbAutoLogin_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbAutoLogin:push';
end;//Tkw_Login_Control_cbAutoLogin_Push.GetWordNameForRegister

class function Tkw_Login_Control_btnOk.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnOk';
end;//Tkw_Login_Control_btnOk.GetWordNameForRegister

function Tkw_Login_Control_btnOk.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_57452CA115E9_var*
//#UC END# *4DDFD2EA0116_57452CA115E9_var*
begin
//#UC START# *4DDFD2EA0116_57452CA115E9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_57452CA115E9_impl*
end;//Tkw_Login_Control_btnOk.GetString

class procedure Tkw_Login_Control_btnOk.RegisterInEngine;
//#UC START# *52A086150180_57452CA115E9_var*
//#UC END# *52A086150180_57452CA115E9_var*
begin
//#UC START# *52A086150180_57452CA115E9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_57452CA115E9_impl*
end;//Tkw_Login_Control_btnOk.RegisterInEngine

procedure Tkw_Login_Control_btnOk_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9790A2AFA59D_var*
//#UC END# *4DAEEDE10285_9790A2AFA59D_var*
begin
//#UC START# *4DAEEDE10285_9790A2AFA59D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9790A2AFA59D_impl*
end;//Tkw_Login_Control_btnOk_Push.DoDoIt

class function Tkw_Login_Control_btnOk_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnOk:push';
end;//Tkw_Login_Control_btnOk_Push.GetWordNameForRegister

class function Tkw_Login_Control_NewUserGroupBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NewUserGroupBox';
end;//Tkw_Login_Control_NewUserGroupBox.GetWordNameForRegister

function Tkw_Login_Control_NewUserGroupBox.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_CEEF938E7CA5_var*
//#UC END# *4DDFD2EA0116_CEEF938E7CA5_var*
begin
//#UC START# *4DDFD2EA0116_CEEF938E7CA5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_CEEF938E7CA5_impl*
end;//Tkw_Login_Control_NewUserGroupBox.GetString

class procedure Tkw_Login_Control_NewUserGroupBox.RegisterInEngine;
//#UC START# *52A086150180_CEEF938E7CA5_var*
//#UC END# *52A086150180_CEEF938E7CA5_var*
begin
//#UC START# *52A086150180_CEEF938E7CA5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_CEEF938E7CA5_impl*
end;//Tkw_Login_Control_NewUserGroupBox.RegisterInEngine

procedure Tkw_Login_Control_NewUserGroupBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C4771B33CA8F_var*
//#UC END# *4DAEEDE10285_C4771B33CA8F_var*
begin
//#UC START# *4DAEEDE10285_C4771B33CA8F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C4771B33CA8F_impl*
end;//Tkw_Login_Control_NewUserGroupBox_Push.DoDoIt

class function Tkw_Login_Control_NewUserGroupBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NewUserGroupBox:push';
end;//Tkw_Login_Control_NewUserGroupBox_Push.GetWordNameForRegister

class function Tkw_Login_Control_NewUserLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NewUserLabel';
end;//Tkw_Login_Control_NewUserLabel.GetWordNameForRegister

function Tkw_Login_Control_NewUserLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_BF98098EB9AC_var*
//#UC END# *4DDFD2EA0116_BF98098EB9AC_var*
begin
//#UC START# *4DDFD2EA0116_BF98098EB9AC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_BF98098EB9AC_impl*
end;//Tkw_Login_Control_NewUserLabel.GetString

class procedure Tkw_Login_Control_NewUserLabel.RegisterInEngine;
//#UC START# *52A086150180_BF98098EB9AC_var*
//#UC END# *52A086150180_BF98098EB9AC_var*
begin
//#UC START# *52A086150180_BF98098EB9AC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_BF98098EB9AC_impl*
end;//Tkw_Login_Control_NewUserLabel.RegisterInEngine

procedure Tkw_Login_Control_NewUserLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_EA4E8E50955A_var*
//#UC END# *4DAEEDE10285_EA4E8E50955A_var*
begin
//#UC START# *4DAEEDE10285_EA4E8E50955A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_EA4E8E50955A_impl*
end;//Tkw_Login_Control_NewUserLabel_Push.DoDoIt

class function Tkw_Login_Control_NewUserLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NewUserLabel:push';
end;//Tkw_Login_Control_NewUserLabel_Push.GetWordNameForRegister

class function Tkw_Login_Control_NewUserPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NewUserPaintBox';
end;//Tkw_Login_Control_NewUserPaintBox.GetWordNameForRegister

function Tkw_Login_Control_NewUserPaintBox.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_872FA0A52DE9_var*
//#UC END# *4DDFD2EA0116_872FA0A52DE9_var*
begin
//#UC START# *4DDFD2EA0116_872FA0A52DE9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_872FA0A52DE9_impl*
end;//Tkw_Login_Control_NewUserPaintBox.GetString

class procedure Tkw_Login_Control_NewUserPaintBox.RegisterInEngine;
//#UC START# *52A086150180_872FA0A52DE9_var*
//#UC END# *52A086150180_872FA0A52DE9_var*
begin
//#UC START# *52A086150180_872FA0A52DE9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_872FA0A52DE9_impl*
end;//Tkw_Login_Control_NewUserPaintBox.RegisterInEngine

procedure Tkw_Login_Control_NewUserPaintBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C7881C17D0EA_var*
//#UC END# *4DAEEDE10285_C7881C17D0EA_var*
begin
//#UC START# *4DAEEDE10285_C7881C17D0EA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C7881C17D0EA_impl*
end;//Tkw_Login_Control_NewUserPaintBox_Push.DoDoIt

class function Tkw_Login_Control_NewUserPaintBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NewUserPaintBox:push';
end;//Tkw_Login_Control_NewUserPaintBox_Push.GetWordNameForRegister

class function Tkw_Login_Control_lblNewUser.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblNewUser';
end;//Tkw_Login_Control_lblNewUser.GetWordNameForRegister

function Tkw_Login_Control_lblNewUser.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_8B1EDAFE04A3_var*
//#UC END# *4DDFD2EA0116_8B1EDAFE04A3_var*
begin
//#UC START# *4DDFD2EA0116_8B1EDAFE04A3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_8B1EDAFE04A3_impl*
end;//Tkw_Login_Control_lblNewUser.GetString

class procedure Tkw_Login_Control_lblNewUser.RegisterInEngine;
//#UC START# *52A086150180_8B1EDAFE04A3_var*
//#UC END# *52A086150180_8B1EDAFE04A3_var*
begin
//#UC START# *52A086150180_8B1EDAFE04A3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_8B1EDAFE04A3_impl*
end;//Tkw_Login_Control_lblNewUser.RegisterInEngine

procedure Tkw_Login_Control_lblNewUser_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4D2B8E8E3D56_var*
//#UC END# *4DAEEDE10285_4D2B8E8E3D56_var*
begin
//#UC START# *4DAEEDE10285_4D2B8E8E3D56_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4D2B8E8E3D56_impl*
end;//Tkw_Login_Control_lblNewUser_Push.DoDoIt

class function Tkw_Login_Control_lblNewUser_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblNewUser:push';
end;//Tkw_Login_Control_lblNewUser_Push.GetWordNameForRegister

class function Tkw_Login_Control_HelpPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HelpPanel';
end;//Tkw_Login_Control_HelpPanel.GetWordNameForRegister

function Tkw_Login_Control_HelpPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7434B9DF105F_var*
//#UC END# *4DDFD2EA0116_7434B9DF105F_var*
begin
//#UC START# *4DDFD2EA0116_7434B9DF105F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7434B9DF105F_impl*
end;//Tkw_Login_Control_HelpPanel.GetString

class procedure Tkw_Login_Control_HelpPanel.RegisterInEngine;
//#UC START# *52A086150180_7434B9DF105F_var*
//#UC END# *52A086150180_7434B9DF105F_var*
begin
//#UC START# *52A086150180_7434B9DF105F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_7434B9DF105F_impl*
end;//Tkw_Login_Control_HelpPanel.RegisterInEngine

procedure Tkw_Login_Control_HelpPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_46E268D9579B_var*
//#UC END# *4DAEEDE10285_46E268D9579B_var*
begin
//#UC START# *4DAEEDE10285_46E268D9579B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_46E268D9579B_impl*
end;//Tkw_Login_Control_HelpPanel_Push.DoDoIt

class function Tkw_Login_Control_HelpPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HelpPanel:push';
end;//Tkw_Login_Control_HelpPanel_Push.GetWordNameForRegister

class function Tkw_Login_Control_HelpPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HelpPaintBox';
end;//Tkw_Login_Control_HelpPaintBox.GetWordNameForRegister

function Tkw_Login_Control_HelpPaintBox.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2764998FE17B_var*
//#UC END# *4DDFD2EA0116_2764998FE17B_var*
begin
//#UC START# *4DDFD2EA0116_2764998FE17B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2764998FE17B_impl*
end;//Tkw_Login_Control_HelpPaintBox.GetString

class procedure Tkw_Login_Control_HelpPaintBox.RegisterInEngine;
//#UC START# *52A086150180_2764998FE17B_var*
//#UC END# *52A086150180_2764998FE17B_var*
begin
//#UC START# *52A086150180_2764998FE17B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_2764998FE17B_impl*
end;//Tkw_Login_Control_HelpPaintBox.RegisterInEngine

procedure Tkw_Login_Control_HelpPaintBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4C0DF818A1F1_var*
//#UC END# *4DAEEDE10285_4C0DF818A1F1_var*
begin
//#UC START# *4DAEEDE10285_4C0DF818A1F1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4C0DF818A1F1_impl*
end;//Tkw_Login_Control_HelpPaintBox_Push.DoDoIt

class function Tkw_Login_Control_HelpPaintBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HelpPaintBox:push';
end;//Tkw_Login_Control_HelpPaintBox_Push.GetWordNameForRegister

class function Tkw_Login_Control_HelpLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HelpLabel';
end;//Tkw_Login_Control_HelpLabel.GetWordNameForRegister

function Tkw_Login_Control_HelpLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_96D2E440FC0E_var*
//#UC END# *4DDFD2EA0116_96D2E440FC0E_var*
begin
//#UC START# *4DDFD2EA0116_96D2E440FC0E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_96D2E440FC0E_impl*
end;//Tkw_Login_Control_HelpLabel.GetString

class procedure Tkw_Login_Control_HelpLabel.RegisterInEngine;
//#UC START# *52A086150180_96D2E440FC0E_var*
//#UC END# *52A086150180_96D2E440FC0E_var*
begin
//#UC START# *52A086150180_96D2E440FC0E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_96D2E440FC0E_impl*
end;//Tkw_Login_Control_HelpLabel.RegisterInEngine

procedure Tkw_Login_Control_HelpLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F436EE8B42C5_var*
//#UC END# *4DAEEDE10285_F436EE8B42C5_var*
begin
//#UC START# *4DAEEDE10285_F436EE8B42C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F436EE8B42C5_impl*
end;//Tkw_Login_Control_HelpLabel_Push.DoDoIt

class function Tkw_Login_Control_HelpLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HelpLabel:push';
end;//Tkw_Login_Control_HelpLabel_Push.GetWordNameForRegister

function TkwLoginFormRegisteredGroupBox.RegisteredGroupBox(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtGroupBox;
 {* ���������� ����� ������� .TLoginForm.RegisteredGroupBox }
//#UC START# *73D99A3E2AA6_9B4F211D4C21_var*
//#UC END# *73D99A3E2AA6_9B4F211D4C21_var*
begin
//#UC START# *73D99A3E2AA6_9B4F211D4C21_impl*
 !!! Needs to be implemented !!!
//#UC END# *73D99A3E2AA6_9B4F211D4C21_impl*
end;//TkwLoginFormRegisteredGroupBox.RegisteredGroupBox

procedure TkwLoginFormRegisteredGroupBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9B4F211D4C21_var*
//#UC END# *4DAEEDE10285_9B4F211D4C21_var*
begin
//#UC START# *4DAEEDE10285_9B4F211D4C21_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9B4F211D4C21_impl*
end;//TkwLoginFormRegisteredGroupBox.DoDoIt

class function TkwLoginFormRegisteredGroupBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.RegisteredGroupBox';
end;//TkwLoginFormRegisteredGroupBox.GetWordNameForRegister

procedure TkwLoginFormRegisteredGroupBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwLoginFormRegisteredGroupBox.SetValuePrim

function TkwLoginFormRegisteredGroupBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwLoginFormRegisteredGroupBox.GetResultTypeInfo

function TkwLoginFormRegisteredGroupBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormRegisteredGroupBox.GetAllParamsCount

function TkwLoginFormRegisteredGroupBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwLoginFormRegisteredGroupBox.ParamsTypes

function TkwLoginFormLblLogin.lblLogin(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtLabel;
 {* ���������� ����� ������� .TLoginForm.lblLogin }
//#UC START# *66D8455F1F9B_FFD5E9C273CA_var*
//#UC END# *66D8455F1F9B_FFD5E9C273CA_var*
begin
//#UC START# *66D8455F1F9B_FFD5E9C273CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *66D8455F1F9B_FFD5E9C273CA_impl*
end;//TkwLoginFormLblLogin.lblLogin

procedure TkwLoginFormLblLogin.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FFD5E9C273CA_var*
//#UC END# *4DAEEDE10285_FFD5E9C273CA_var*
begin
//#UC START# *4DAEEDE10285_FFD5E9C273CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FFD5E9C273CA_impl*
end;//TkwLoginFormLblLogin.DoDoIt

class function TkwLoginFormLblLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.lblLogin';
end;//TkwLoginFormLblLogin.GetWordNameForRegister

procedure TkwLoginFormLblLogin.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwLoginFormLblLogin.SetValuePrim

function TkwLoginFormLblLogin.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwLoginFormLblLogin.GetResultTypeInfo

function TkwLoginFormLblLogin.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormLblLogin.GetAllParamsCount

function TkwLoginFormLblLogin.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwLoginFormLblLogin.ParamsTypes

function TkwLoginFormLblPassword.lblPassword(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtLabel;
 {* ���������� ����� ������� .TLoginForm.lblPassword }
//#UC START# *C83B0D32A29B_ADC1F68E0487_var*
//#UC END# *C83B0D32A29B_ADC1F68E0487_var*
begin
//#UC START# *C83B0D32A29B_ADC1F68E0487_impl*
 !!! Needs to be implemented !!!
//#UC END# *C83B0D32A29B_ADC1F68E0487_impl*
end;//TkwLoginFormLblPassword.lblPassword

procedure TkwLoginFormLblPassword.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_ADC1F68E0487_var*
//#UC END# *4DAEEDE10285_ADC1F68E0487_var*
begin
//#UC START# *4DAEEDE10285_ADC1F68E0487_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_ADC1F68E0487_impl*
end;//TkwLoginFormLblPassword.DoDoIt

class function TkwLoginFormLblPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.lblPassword';
end;//TkwLoginFormLblPassword.GetWordNameForRegister

procedure TkwLoginFormLblPassword.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwLoginFormLblPassword.SetValuePrim

function TkwLoginFormLblPassword.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwLoginFormLblPassword.GetResultTypeInfo

function TkwLoginFormLblPassword.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormLblPassword.GetAllParamsCount

function TkwLoginFormLblPassword.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwLoginFormLblPassword.ParamsTypes

function TkwLoginFormEnterPaintBox.EnterPaintBox(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TPaintBox;
 {* ���������� ����� ������� .TLoginForm.EnterPaintBox }
//#UC START# *50E9C138BA47_75E9BCD66298_var*
//#UC END# *50E9C138BA47_75E9BCD66298_var*
begin
//#UC START# *50E9C138BA47_75E9BCD66298_impl*
 !!! Needs to be implemented !!!
//#UC END# *50E9C138BA47_75E9BCD66298_impl*
end;//TkwLoginFormEnterPaintBox.EnterPaintBox

procedure TkwLoginFormEnterPaintBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_75E9BCD66298_var*
//#UC END# *4DAEEDE10285_75E9BCD66298_var*
begin
//#UC START# *4DAEEDE10285_75E9BCD66298_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_75E9BCD66298_impl*
end;//TkwLoginFormEnterPaintBox.DoDoIt

class function TkwLoginFormEnterPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.EnterPaintBox';
end;//TkwLoginFormEnterPaintBox.GetWordNameForRegister

procedure TkwLoginFormEnterPaintBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwLoginFormEnterPaintBox.SetValuePrim

function TkwLoginFormEnterPaintBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwLoginFormEnterPaintBox.GetResultTypeInfo

function TkwLoginFormEnterPaintBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormEnterPaintBox.GetAllParamsCount

function TkwLoginFormEnterPaintBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwLoginFormEnterPaintBox.ParamsTypes

function TkwLoginFormEdUserName.edUserName(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TnscComboBoxWithReadOnly;
 {* ���������� ����� ������� .TLoginForm.edUserName }
//#UC START# *BAB4AFF6F0A5_C550F6E48B7D_var*
//#UC END# *BAB4AFF6F0A5_C550F6E48B7D_var*
begin
//#UC START# *BAB4AFF6F0A5_C550F6E48B7D_impl*
 !!! Needs to be implemented !!!
//#UC END# *BAB4AFF6F0A5_C550F6E48B7D_impl*
end;//TkwLoginFormEdUserName.edUserName

procedure TkwLoginFormEdUserName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C550F6E48B7D_var*
//#UC END# *4DAEEDE10285_C550F6E48B7D_var*
begin
//#UC START# *4DAEEDE10285_C550F6E48B7D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C550F6E48B7D_impl*
end;//TkwLoginFormEdUserName.DoDoIt

class function TkwLoginFormEdUserName.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.edUserName';
end;//TkwLoginFormEdUserName.GetWordNameForRegister

procedure TkwLoginFormEdUserName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwLoginFormEdUserName.SetValuePrim

function TkwLoginFormEdUserName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscComboBoxWithReadOnly);
end;//TkwLoginFormEdUserName.GetResultTypeInfo

function TkwLoginFormEdUserName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormEdUserName.GetAllParamsCount

function TkwLoginFormEdUserName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwLoginFormEdUserName.ParamsTypes

function TkwLoginFormEdPassword.edPassword(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TnscComboBoxWithPwdChar;
 {* ���������� ����� ������� .TLoginForm.edPassword }
//#UC START# *891CAC2FE263_7BF42C20181F_var*
//#UC END# *891CAC2FE263_7BF42C20181F_var*
begin
//#UC START# *891CAC2FE263_7BF42C20181F_impl*
 !!! Needs to be implemented !!!
//#UC END# *891CAC2FE263_7BF42C20181F_impl*
end;//TkwLoginFormEdPassword.edPassword

procedure TkwLoginFormEdPassword.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7BF42C20181F_var*
//#UC END# *4DAEEDE10285_7BF42C20181F_var*
begin
//#UC START# *4DAEEDE10285_7BF42C20181F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7BF42C20181F_impl*
end;//TkwLoginFormEdPassword.DoDoIt

class function TkwLoginFormEdPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.edPassword';
end;//TkwLoginFormEdPassword.GetWordNameForRegister

procedure TkwLoginFormEdPassword.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwLoginFormEdPassword.SetValuePrim

function TkwLoginFormEdPassword.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscComboBoxWithPwdChar);
end;//TkwLoginFormEdPassword.GetResultTypeInfo

function TkwLoginFormEdPassword.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormEdPassword.GetAllParamsCount

function TkwLoginFormEdPassword.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwLoginFormEdPassword.ParamsTypes

function TkwLoginFormLblForgetPassword.lblForgetPassword(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtFocusLabel;
 {* ���������� ����� ������� .TLoginForm.lblForgetPassword }
//#UC START# *6E55A5043A8C_1E431A639AC6_var*
//#UC END# *6E55A5043A8C_1E431A639AC6_var*
begin
//#UC START# *6E55A5043A8C_1E431A639AC6_impl*
 !!! Needs to be implemented !!!
//#UC END# *6E55A5043A8C_1E431A639AC6_impl*
end;//TkwLoginFormLblForgetPassword.lblForgetPassword

procedure TkwLoginFormLblForgetPassword.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1E431A639AC6_var*
//#UC END# *4DAEEDE10285_1E431A639AC6_var*
begin
//#UC START# *4DAEEDE10285_1E431A639AC6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1E431A639AC6_impl*
end;//TkwLoginFormLblForgetPassword.DoDoIt

class function TkwLoginFormLblForgetPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.lblForgetPassword';
end;//TkwLoginFormLblForgetPassword.GetWordNameForRegister

procedure TkwLoginFormLblForgetPassword.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwLoginFormLblForgetPassword.SetValuePrim

function TkwLoginFormLblForgetPassword.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtFocusLabel);
end;//TkwLoginFormLblForgetPassword.GetResultTypeInfo

function TkwLoginFormLblForgetPassword.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormLblForgetPassword.GetAllParamsCount

function TkwLoginFormLblForgetPassword.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwLoginFormLblForgetPassword.ParamsTypes

function TkwLoginFormCbAutoLogin.cbAutoLogin(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtCheckBox;
 {* ���������� ����� ������� .TLoginForm.cbAutoLogin }
//#UC START# *5DCEF8E91435_7240CBBD5078_var*
//#UC END# *5DCEF8E91435_7240CBBD5078_var*
begin
//#UC START# *5DCEF8E91435_7240CBBD5078_impl*
 !!! Needs to be implemented !!!
//#UC END# *5DCEF8E91435_7240CBBD5078_impl*
end;//TkwLoginFormCbAutoLogin.cbAutoLogin

procedure TkwLoginFormCbAutoLogin.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7240CBBD5078_var*
//#UC END# *4DAEEDE10285_7240CBBD5078_var*
begin
//#UC START# *4DAEEDE10285_7240CBBD5078_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7240CBBD5078_impl*
end;//TkwLoginFormCbAutoLogin.DoDoIt

class function TkwLoginFormCbAutoLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.cbAutoLogin';
end;//TkwLoginFormCbAutoLogin.GetWordNameForRegister

procedure TkwLoginFormCbAutoLogin.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwLoginFormCbAutoLogin.SetValuePrim

function TkwLoginFormCbAutoLogin.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwLoginFormCbAutoLogin.GetResultTypeInfo

function TkwLoginFormCbAutoLogin.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormCbAutoLogin.GetAllParamsCount

function TkwLoginFormCbAutoLogin.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwLoginFormCbAutoLogin.ParamsTypes

function TkwLoginFormBtnOk.btnOk(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TElPopupButton;
 {* ���������� ����� ������� .TLoginForm.btnOk }
//#UC START# *72D0A337AD3F_82596223B513_var*
//#UC END# *72D0A337AD3F_82596223B513_var*
begin
//#UC START# *72D0A337AD3F_82596223B513_impl*
 !!! Needs to be implemented !!!
//#UC END# *72D0A337AD3F_82596223B513_impl*
end;//TkwLoginFormBtnOk.btnOk

procedure TkwLoginFormBtnOk.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_82596223B513_var*
//#UC END# *4DAEEDE10285_82596223B513_var*
begin
//#UC START# *4DAEEDE10285_82596223B513_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_82596223B513_impl*
end;//TkwLoginFormBtnOk.DoDoIt

class function TkwLoginFormBtnOk.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.btnOk';
end;//TkwLoginFormBtnOk.GetWordNameForRegister

procedure TkwLoginFormBtnOk.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwLoginFormBtnOk.SetValuePrim

function TkwLoginFormBtnOk.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwLoginFormBtnOk.GetResultTypeInfo

function TkwLoginFormBtnOk.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormBtnOk.GetAllParamsCount

function TkwLoginFormBtnOk.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwLoginFormBtnOk.ParamsTypes

function TkwLoginFormNewUserGroupBox.NewUserGroupBox(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtGroupBox;
 {* ���������� ����� ������� .TLoginForm.NewUserGroupBox }
//#UC START# *A07A1C0F218B_03381F46504D_var*
//#UC END# *A07A1C0F218B_03381F46504D_var*
begin
//#UC START# *A07A1C0F218B_03381F46504D_impl*
 !!! Needs to be implemented !!!
//#UC END# *A07A1C0F218B_03381F46504D_impl*
end;//TkwLoginFormNewUserGroupBox.NewUserGroupBox

procedure TkwLoginFormNewUserGroupBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_03381F46504D_var*
//#UC END# *4DAEEDE10285_03381F46504D_var*
begin
//#UC START# *4DAEEDE10285_03381F46504D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_03381F46504D_impl*
end;//TkwLoginFormNewUserGroupBox.DoDoIt

class function TkwLoginFormNewUserGroupBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.NewUserGroupBox';
end;//TkwLoginFormNewUserGroupBox.GetWordNameForRegister

procedure TkwLoginFormNewUserGroupBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwLoginFormNewUserGroupBox.SetValuePrim

function TkwLoginFormNewUserGroupBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwLoginFormNewUserGroupBox.GetResultTypeInfo

function TkwLoginFormNewUserGroupBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormNewUserGroupBox.GetAllParamsCount

function TkwLoginFormNewUserGroupBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwLoginFormNewUserGroupBox.ParamsTypes

function TkwLoginFormNewUserLabel.NewUserLabel(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtLabel;
 {* ���������� ����� ������� .TLoginForm.NewUserLabel }
//#UC START# *01721263E37D_FEA3248A13D0_var*
//#UC END# *01721263E37D_FEA3248A13D0_var*
begin
//#UC START# *01721263E37D_FEA3248A13D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *01721263E37D_FEA3248A13D0_impl*
end;//TkwLoginFormNewUserLabel.NewUserLabel

procedure TkwLoginFormNewUserLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FEA3248A13D0_var*
//#UC END# *4DAEEDE10285_FEA3248A13D0_var*
begin
//#UC START# *4DAEEDE10285_FEA3248A13D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FEA3248A13D0_impl*
end;//TkwLoginFormNewUserLabel.DoDoIt

class function TkwLoginFormNewUserLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.NewUserLabel';
end;//TkwLoginFormNewUserLabel.GetWordNameForRegister

procedure TkwLoginFormNewUserLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwLoginFormNewUserLabel.SetValuePrim

function TkwLoginFormNewUserLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwLoginFormNewUserLabel.GetResultTypeInfo

function TkwLoginFormNewUserLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormNewUserLabel.GetAllParamsCount

function TkwLoginFormNewUserLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwLoginFormNewUserLabel.ParamsTypes

function TkwLoginFormNewUserPaintBox.NewUserPaintBox(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TPaintBox;
 {* ���������� ����� ������� .TLoginForm.NewUserPaintBox }
//#UC START# *F881E15DB979_545C2415CF4A_var*
//#UC END# *F881E15DB979_545C2415CF4A_var*
begin
//#UC START# *F881E15DB979_545C2415CF4A_impl*
 !!! Needs to be implemented !!!
//#UC END# *F881E15DB979_545C2415CF4A_impl*
end;//TkwLoginFormNewUserPaintBox.NewUserPaintBox

procedure TkwLoginFormNewUserPaintBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_545C2415CF4A_var*
//#UC END# *4DAEEDE10285_545C2415CF4A_var*
begin
//#UC START# *4DAEEDE10285_545C2415CF4A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_545C2415CF4A_impl*
end;//TkwLoginFormNewUserPaintBox.DoDoIt

class function TkwLoginFormNewUserPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.NewUserPaintBox';
end;//TkwLoginFormNewUserPaintBox.GetWordNameForRegister

procedure TkwLoginFormNewUserPaintBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwLoginFormNewUserPaintBox.SetValuePrim

function TkwLoginFormNewUserPaintBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwLoginFormNewUserPaintBox.GetResultTypeInfo

function TkwLoginFormNewUserPaintBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormNewUserPaintBox.GetAllParamsCount

function TkwLoginFormNewUserPaintBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwLoginFormNewUserPaintBox.ParamsTypes

function TkwLoginFormLblNewUser.lblNewUser(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtFocusLabel;
 {* ���������� ����� ������� .TLoginForm.lblNewUser }
//#UC START# *6D68AB9A4BC2_BD193B22974F_var*
//#UC END# *6D68AB9A4BC2_BD193B22974F_var*
begin
//#UC START# *6D68AB9A4BC2_BD193B22974F_impl*
 !!! Needs to be implemented !!!
//#UC END# *6D68AB9A4BC2_BD193B22974F_impl*
end;//TkwLoginFormLblNewUser.lblNewUser

procedure TkwLoginFormLblNewUser.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BD193B22974F_var*
//#UC END# *4DAEEDE10285_BD193B22974F_var*
begin
//#UC START# *4DAEEDE10285_BD193B22974F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BD193B22974F_impl*
end;//TkwLoginFormLblNewUser.DoDoIt

class function TkwLoginFormLblNewUser.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.lblNewUser';
end;//TkwLoginFormLblNewUser.GetWordNameForRegister

procedure TkwLoginFormLblNewUser.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwLoginFormLblNewUser.SetValuePrim

function TkwLoginFormLblNewUser.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtFocusLabel);
end;//TkwLoginFormLblNewUser.GetResultTypeInfo

function TkwLoginFormLblNewUser.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormLblNewUser.GetAllParamsCount

function TkwLoginFormLblNewUser.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwLoginFormLblNewUser.ParamsTypes

function TkwLoginFormHelpPanel.HelpPanel(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtPanel;
 {* ���������� ����� ������� .TLoginForm.HelpPanel }
//#UC START# *6B39FF047C8C_1EF3C1D6EB3F_var*
//#UC END# *6B39FF047C8C_1EF3C1D6EB3F_var*
begin
//#UC START# *6B39FF047C8C_1EF3C1D6EB3F_impl*
 !!! Needs to be implemented !!!
//#UC END# *6B39FF047C8C_1EF3C1D6EB3F_impl*
end;//TkwLoginFormHelpPanel.HelpPanel

procedure TkwLoginFormHelpPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1EF3C1D6EB3F_var*
//#UC END# *4DAEEDE10285_1EF3C1D6EB3F_var*
begin
//#UC START# *4DAEEDE10285_1EF3C1D6EB3F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1EF3C1D6EB3F_impl*
end;//TkwLoginFormHelpPanel.DoDoIt

class function TkwLoginFormHelpPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.HelpPanel';
end;//TkwLoginFormHelpPanel.GetWordNameForRegister

procedure TkwLoginFormHelpPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwLoginFormHelpPanel.SetValuePrim

function TkwLoginFormHelpPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwLoginFormHelpPanel.GetResultTypeInfo

function TkwLoginFormHelpPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormHelpPanel.GetAllParamsCount

function TkwLoginFormHelpPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwLoginFormHelpPanel.ParamsTypes

function TkwLoginFormHelpPaintBox.HelpPaintBox(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TPaintBox;
 {* ���������� ����� ������� .TLoginForm.HelpPaintBox }
//#UC START# *2E28DD800721_0D089B690A42_var*
//#UC END# *2E28DD800721_0D089B690A42_var*
begin
//#UC START# *2E28DD800721_0D089B690A42_impl*
 !!! Needs to be implemented !!!
//#UC END# *2E28DD800721_0D089B690A42_impl*
end;//TkwLoginFormHelpPaintBox.HelpPaintBox

procedure TkwLoginFormHelpPaintBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0D089B690A42_var*
//#UC END# *4DAEEDE10285_0D089B690A42_var*
begin
//#UC START# *4DAEEDE10285_0D089B690A42_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0D089B690A42_impl*
end;//TkwLoginFormHelpPaintBox.DoDoIt

class function TkwLoginFormHelpPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.HelpPaintBox';
end;//TkwLoginFormHelpPaintBox.GetWordNameForRegister

procedure TkwLoginFormHelpPaintBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwLoginFormHelpPaintBox.SetValuePrim

function TkwLoginFormHelpPaintBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwLoginFormHelpPaintBox.GetResultTypeInfo

function TkwLoginFormHelpPaintBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormHelpPaintBox.GetAllParamsCount

function TkwLoginFormHelpPaintBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwLoginFormHelpPaintBox.ParamsTypes

function TkwLoginFormHelpLabel.HelpLabel(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtFocusLabel;
 {* ���������� ����� ������� .TLoginForm.HelpLabel }
//#UC START# *38D10DFBDBF1_61075CCC4E17_var*
//#UC END# *38D10DFBDBF1_61075CCC4E17_var*
begin
//#UC START# *38D10DFBDBF1_61075CCC4E17_impl*
 !!! Needs to be implemented !!!
//#UC END# *38D10DFBDBF1_61075CCC4E17_impl*
end;//TkwLoginFormHelpLabel.HelpLabel

procedure TkwLoginFormHelpLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_61075CCC4E17_var*
//#UC END# *4DAEEDE10285_61075CCC4E17_var*
begin
//#UC START# *4DAEEDE10285_61075CCC4E17_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_61075CCC4E17_impl*
end;//TkwLoginFormHelpLabel.DoDoIt

class function TkwLoginFormHelpLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.HelpLabel';
end;//TkwLoginFormHelpLabel.GetWordNameForRegister

procedure TkwLoginFormHelpLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwLoginFormHelpLabel.SetValuePrim

function TkwLoginFormHelpLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtFocusLabel);
end;//TkwLoginFormHelpLabel.GetResultTypeInfo

function TkwLoginFormHelpLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLoginFormHelpLabel.GetAllParamsCount

function TkwLoginFormHelpLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwLoginFormHelpLabel.ParamsTypes

initialization
 Tkw_Form_Login.RegisterInEngine;
 {* ����������� Tkw_Form_Login }
 Tkw_Login_Control_RegisteredGroupBox.RegisterInEngine;
 {* ����������� Tkw_Login_Control_RegisteredGroupBox }
 Tkw_Login_Control_RegisteredGroupBox_Push.RegisterInEngine;
 {* ����������� Tkw_Login_Control_RegisteredGroupBox_Push }
 Tkw_Login_Control_lblLogin.RegisterInEngine;
 {* ����������� Tkw_Login_Control_lblLogin }
 Tkw_Login_Control_lblLogin_Push.RegisterInEngine;
 {* ����������� Tkw_Login_Control_lblLogin_Push }
 Tkw_Login_Control_lblPassword.RegisterInEngine;
 {* ����������� Tkw_Login_Control_lblPassword }
 Tkw_Login_Control_lblPassword_Push.RegisterInEngine;
 {* ����������� Tkw_Login_Control_lblPassword_Push }
 Tkw_Login_Control_EnterPaintBox.RegisterInEngine;
 {* ����������� Tkw_Login_Control_EnterPaintBox }
 Tkw_Login_Control_EnterPaintBox_Push.RegisterInEngine;
 {* ����������� Tkw_Login_Control_EnterPaintBox_Push }
 Tkw_Login_Control_edUserName.RegisterInEngine;
 {* ����������� Tkw_Login_Control_edUserName }
 Tkw_Login_Control_edUserName_Push.RegisterInEngine;
 {* ����������� Tkw_Login_Control_edUserName_Push }
 Tkw_Login_Control_edPassword.RegisterInEngine;
 {* ����������� Tkw_Login_Control_edPassword }
 Tkw_Login_Control_edPassword_Push.RegisterInEngine;
 {* ����������� Tkw_Login_Control_edPassword_Push }
 Tkw_Login_Control_lblForgetPassword.RegisterInEngine;
 {* ����������� Tkw_Login_Control_lblForgetPassword }
 Tkw_Login_Control_lblForgetPassword_Push.RegisterInEngine;
 {* ����������� Tkw_Login_Control_lblForgetPassword_Push }
 Tkw_Login_Control_cbAutoLogin.RegisterInEngine;
 {* ����������� Tkw_Login_Control_cbAutoLogin }
 Tkw_Login_Control_cbAutoLogin_Push.RegisterInEngine;
 {* ����������� Tkw_Login_Control_cbAutoLogin_Push }
 Tkw_Login_Control_btnOk.RegisterInEngine;
 {* ����������� Tkw_Login_Control_btnOk }
 Tkw_Login_Control_btnOk_Push.RegisterInEngine;
 {* ����������� Tkw_Login_Control_btnOk_Push }
 Tkw_Login_Control_NewUserGroupBox.RegisterInEngine;
 {* ����������� Tkw_Login_Control_NewUserGroupBox }
 Tkw_Login_Control_NewUserGroupBox_Push.RegisterInEngine;
 {* ����������� Tkw_Login_Control_NewUserGroupBox_Push }
 Tkw_Login_Control_NewUserLabel.RegisterInEngine;
 {* ����������� Tkw_Login_Control_NewUserLabel }
 Tkw_Login_Control_NewUserLabel_Push.RegisterInEngine;
 {* ����������� Tkw_Login_Control_NewUserLabel_Push }
 Tkw_Login_Control_NewUserPaintBox.RegisterInEngine;
 {* ����������� Tkw_Login_Control_NewUserPaintBox }
 Tkw_Login_Control_NewUserPaintBox_Push.RegisterInEngine;
 {* ����������� Tkw_Login_Control_NewUserPaintBox_Push }
 Tkw_Login_Control_lblNewUser.RegisterInEngine;
 {* ����������� Tkw_Login_Control_lblNewUser }
 Tkw_Login_Control_lblNewUser_Push.RegisterInEngine;
 {* ����������� Tkw_Login_Control_lblNewUser_Push }
 Tkw_Login_Control_HelpPanel.RegisterInEngine;
 {* ����������� Tkw_Login_Control_HelpPanel }
 Tkw_Login_Control_HelpPanel_Push.RegisterInEngine;
 {* ����������� Tkw_Login_Control_HelpPanel_Push }
 Tkw_Login_Control_HelpPaintBox.RegisterInEngine;
 {* ����������� Tkw_Login_Control_HelpPaintBox }
 Tkw_Login_Control_HelpPaintBox_Push.RegisterInEngine;
 {* ����������� Tkw_Login_Control_HelpPaintBox_Push }
 Tkw_Login_Control_HelpLabel.RegisterInEngine;
 {* ����������� Tkw_Login_Control_HelpLabel }
 Tkw_Login_Control_HelpLabel_Push.RegisterInEngine;
 {* ����������� Tkw_Login_Control_HelpLabel_Push }
 TkwLoginFormRegisteredGroupBox.RegisterInEngine;
 {* ����������� LoginForm_RegisteredGroupBox }
 TkwLoginFormLblLogin.RegisterInEngine;
 {* ����������� LoginForm_lblLogin }
 TkwLoginFormLblPassword.RegisterInEngine;
 {* ����������� LoginForm_lblPassword }
 TkwLoginFormEnterPaintBox.RegisterInEngine;
 {* ����������� LoginForm_EnterPaintBox }
 TkwLoginFormEdUserName.RegisterInEngine;
 {* ����������� LoginForm_edUserName }
 TkwLoginFormEdPassword.RegisterInEngine;
 {* ����������� LoginForm_edPassword }
 TkwLoginFormLblForgetPassword.RegisterInEngine;
 {* ����������� LoginForm_lblForgetPassword }
 TkwLoginFormCbAutoLogin.RegisterInEngine;
 {* ����������� LoginForm_cbAutoLogin }
 TkwLoginFormBtnOk.RegisterInEngine;
 {* ����������� LoginForm_btnOk }
 TkwLoginFormNewUserGroupBox.RegisterInEngine;
 {* ����������� LoginForm_NewUserGroupBox }
 TkwLoginFormNewUserLabel.RegisterInEngine;
 {* ����������� LoginForm_NewUserLabel }
 TkwLoginFormNewUserPaintBox.RegisterInEngine;
 {* ����������� LoginForm_NewUserPaintBox }
 TkwLoginFormLblNewUser.RegisterInEngine;
 {* ����������� LoginForm_lblNewUser }
 TkwLoginFormHelpPanel.RegisterInEngine;
 {* ����������� LoginForm_HelpPanel }
 TkwLoginFormHelpPaintBox.RegisterInEngine;
 {* ����������� LoginForm_HelpPaintBox }
 TkwLoginFormHelpLabel.RegisterInEngine;
 {* ����������� LoginForm_HelpLabel }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TLoginForm));
 {* ����������� ���� Login }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtGroupBox));
 {* ����������� ���� TvtGroupBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* ����������� ���� TPaintBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscComboBoxWithReadOnly));
 {* ����������� ���� TnscComboBoxWithReadOnly }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscComboBoxWithPwdChar));
 {* ����������� ���� TnscComboBoxWithPwdChar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtFocusLabel));
 {* ����������� ���� TvtFocusLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtCheckBox));
 {* ����������� ���� TvtCheckBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElPopupButton));
 {* ����������� ���� TElPopupButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.

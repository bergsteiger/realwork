unit LoginKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Login }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\LoginKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "LoginKeywordsPack" MUID: (510171698247)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
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
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Login_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
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
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_Login

 Tkw_Login_Control_RegisteredGroupBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� RegisteredGroupBox
----
*������ �������������*:
[code]
�������::RegisteredGroupBox TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_RegisteredGroupBox

 Tkw_Login_Control_RegisteredGroupBox_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_lblLogin

 Tkw_Login_Control_lblLogin_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_lblPassword

 Tkw_Login_Control_lblPassword_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_EnterPaintBox

 Tkw_Login_Control_EnterPaintBox_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_edUserName

 Tkw_Login_Control_edUserName_Push = {final} class({$If NOT Defined(NoVCL)}
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
 end;//Tkw_Login_Control_edUserName_Push

 Tkw_Login_Control_edPassword = {final} class(TtfwControlString)
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
 end;//Tkw_Login_Control_edPassword

 Tkw_Login_Control_edPassword_Push = {final} class({$If NOT Defined(NoVCL)}
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
 end;//Tkw_Login_Control_edPassword_Push

 Tkw_Login_Control_lblForgetPassword = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblForgetPassword
----
*������ �������������*:
[code]
�������::lblForgetPassword TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_lblForgetPassword

 Tkw_Login_Control_lblForgetPassword_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_cbAutoLogin

 Tkw_Login_Control_cbAutoLogin_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_btnOk

 Tkw_Login_Control_btnOk_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_NewUserGroupBox

 Tkw_Login_Control_NewUserGroupBox_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_NewUserLabel

 Tkw_Login_Control_NewUserLabel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_NewUserPaintBox

 Tkw_Login_Control_NewUserPaintBox_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_lblNewUser

 Tkw_Login_Control_lblNewUser_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Login_Control_HelpPanel

 Tkw_Login_Control_HelpPanel_Push = {final} class({$If NOT Defined(NoVCL)}
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
 end;//Tkw_Login_Control_HelpPanel_Push

 Tkw_Login_Control_HelpPaintBox = {final} class(TtfwControlString)
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
 end;//Tkw_Login_Control_HelpPaintBox

 Tkw_Login_Control_HelpPaintBox_Push = {final} class({$If NOT Defined(NoVCL)}
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
 end;//Tkw_Login_Control_HelpPaintBox_Push

 Tkw_Login_Control_HelpLabel = {final} class(TtfwControlString)
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
 end;//Tkw_Login_Control_HelpLabel

 Tkw_Login_Control_HelpLabel_Push = {final} class({$If NOT Defined(NoVCL)}
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

function Tkw_Form_Login.GetString: AnsiString;
begin
 Result := 'LoginForm';
end;//Tkw_Form_Login.GetString

class function Tkw_Form_Login.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Login';
end;//Tkw_Form_Login.GetWordNameForRegister

function Tkw_Login_Control_RegisteredGroupBox.GetString: AnsiString;
begin
 Result := 'RegisteredGroupBox';
end;//Tkw_Login_Control_RegisteredGroupBox.GetString

class procedure Tkw_Login_Control_RegisteredGroupBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_Login_Control_RegisteredGroupBox.RegisterInEngine

class function Tkw_Login_Control_RegisteredGroupBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RegisteredGroupBox';
end;//Tkw_Login_Control_RegisteredGroupBox.GetWordNameForRegister

procedure Tkw_Login_Control_RegisteredGroupBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('RegisteredGroupBox');
 inherited;
end;//Tkw_Login_Control_RegisteredGroupBox_Push.DoDoIt

class function Tkw_Login_Control_RegisteredGroupBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RegisteredGroupBox:push';
end;//Tkw_Login_Control_RegisteredGroupBox_Push.GetWordNameForRegister

function Tkw_Login_Control_lblLogin.GetString: AnsiString;
begin
 Result := 'lblLogin';
end;//Tkw_Login_Control_lblLogin.GetString

class procedure Tkw_Login_Control_lblLogin.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_Login_Control_lblLogin.RegisterInEngine

class function Tkw_Login_Control_lblLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblLogin';
end;//Tkw_Login_Control_lblLogin.GetWordNameForRegister

procedure Tkw_Login_Control_lblLogin_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblLogin');
 inherited;
end;//Tkw_Login_Control_lblLogin_Push.DoDoIt

class function Tkw_Login_Control_lblLogin_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblLogin:push';
end;//Tkw_Login_Control_lblLogin_Push.GetWordNameForRegister

function Tkw_Login_Control_lblPassword.GetString: AnsiString;
begin
 Result := 'lblPassword';
end;//Tkw_Login_Control_lblPassword.GetString

class procedure Tkw_Login_Control_lblPassword.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_Login_Control_lblPassword.RegisterInEngine

class function Tkw_Login_Control_lblPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblPassword';
end;//Tkw_Login_Control_lblPassword.GetWordNameForRegister

procedure Tkw_Login_Control_lblPassword_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblPassword');
 inherited;
end;//Tkw_Login_Control_lblPassword_Push.DoDoIt

class function Tkw_Login_Control_lblPassword_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblPassword:push';
end;//Tkw_Login_Control_lblPassword_Push.GetWordNameForRegister

function Tkw_Login_Control_EnterPaintBox.GetString: AnsiString;
begin
 Result := 'EnterPaintBox';
end;//Tkw_Login_Control_EnterPaintBox.GetString

class procedure Tkw_Login_Control_EnterPaintBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_Login_Control_EnterPaintBox.RegisterInEngine

class function Tkw_Login_Control_EnterPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EnterPaintBox';
end;//Tkw_Login_Control_EnterPaintBox.GetWordNameForRegister

procedure Tkw_Login_Control_EnterPaintBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('EnterPaintBox');
 inherited;
end;//Tkw_Login_Control_EnterPaintBox_Push.DoDoIt

class function Tkw_Login_Control_EnterPaintBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EnterPaintBox:push';
end;//Tkw_Login_Control_EnterPaintBox_Push.GetWordNameForRegister

function Tkw_Login_Control_edUserName.GetString: AnsiString;
begin
 Result := 'edUserName';
end;//Tkw_Login_Control_edUserName.GetString

class procedure Tkw_Login_Control_edUserName.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscComboBoxWithReadOnly);
end;//Tkw_Login_Control_edUserName.RegisterInEngine

class function Tkw_Login_Control_edUserName.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edUserName';
end;//Tkw_Login_Control_edUserName.GetWordNameForRegister

procedure Tkw_Login_Control_edUserName_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edUserName');
 inherited;
end;//Tkw_Login_Control_edUserName_Push.DoDoIt

class function Tkw_Login_Control_edUserName_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edUserName:push';
end;//Tkw_Login_Control_edUserName_Push.GetWordNameForRegister

function Tkw_Login_Control_edPassword.GetString: AnsiString;
begin
 Result := 'edPassword';
end;//Tkw_Login_Control_edPassword.GetString

class procedure Tkw_Login_Control_edPassword.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscComboBoxWithPwdChar);
end;//Tkw_Login_Control_edPassword.RegisterInEngine

class function Tkw_Login_Control_edPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edPassword';
end;//Tkw_Login_Control_edPassword.GetWordNameForRegister

procedure Tkw_Login_Control_edPassword_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edPassword');
 inherited;
end;//Tkw_Login_Control_edPassword_Push.DoDoIt

class function Tkw_Login_Control_edPassword_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edPassword:push';
end;//Tkw_Login_Control_edPassword_Push.GetWordNameForRegister

function Tkw_Login_Control_lblForgetPassword.GetString: AnsiString;
begin
 Result := 'lblForgetPassword';
end;//Tkw_Login_Control_lblForgetPassword.GetString

class procedure Tkw_Login_Control_lblForgetPassword.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtFocusLabel);
end;//Tkw_Login_Control_lblForgetPassword.RegisterInEngine

class function Tkw_Login_Control_lblForgetPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblForgetPassword';
end;//Tkw_Login_Control_lblForgetPassword.GetWordNameForRegister

procedure Tkw_Login_Control_lblForgetPassword_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblForgetPassword');
 inherited;
end;//Tkw_Login_Control_lblForgetPassword_Push.DoDoIt

class function Tkw_Login_Control_lblForgetPassword_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblForgetPassword:push';
end;//Tkw_Login_Control_lblForgetPassword_Push.GetWordNameForRegister

function Tkw_Login_Control_cbAutoLogin.GetString: AnsiString;
begin
 Result := 'cbAutoLogin';
end;//Tkw_Login_Control_cbAutoLogin.GetString

class procedure Tkw_Login_Control_cbAutoLogin.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_Login_Control_cbAutoLogin.RegisterInEngine

class function Tkw_Login_Control_cbAutoLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbAutoLogin';
end;//Tkw_Login_Control_cbAutoLogin.GetWordNameForRegister

procedure Tkw_Login_Control_cbAutoLogin_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('cbAutoLogin');
 inherited;
end;//Tkw_Login_Control_cbAutoLogin_Push.DoDoIt

class function Tkw_Login_Control_cbAutoLogin_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbAutoLogin:push';
end;//Tkw_Login_Control_cbAutoLogin_Push.GetWordNameForRegister

function Tkw_Login_Control_btnOk.GetString: AnsiString;
begin
 Result := 'btnOk';
end;//Tkw_Login_Control_btnOk.GetString

class procedure Tkw_Login_Control_btnOk.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_Login_Control_btnOk.RegisterInEngine

class function Tkw_Login_Control_btnOk.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnOk';
end;//Tkw_Login_Control_btnOk.GetWordNameForRegister

procedure Tkw_Login_Control_btnOk_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnOk');
 inherited;
end;//Tkw_Login_Control_btnOk_Push.DoDoIt

class function Tkw_Login_Control_btnOk_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnOk:push';
end;//Tkw_Login_Control_btnOk_Push.GetWordNameForRegister

function Tkw_Login_Control_NewUserGroupBox.GetString: AnsiString;
begin
 Result := 'NewUserGroupBox';
end;//Tkw_Login_Control_NewUserGroupBox.GetString

class procedure Tkw_Login_Control_NewUserGroupBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_Login_Control_NewUserGroupBox.RegisterInEngine

class function Tkw_Login_Control_NewUserGroupBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NewUserGroupBox';
end;//Tkw_Login_Control_NewUserGroupBox.GetWordNameForRegister

procedure Tkw_Login_Control_NewUserGroupBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('NewUserGroupBox');
 inherited;
end;//Tkw_Login_Control_NewUserGroupBox_Push.DoDoIt

class function Tkw_Login_Control_NewUserGroupBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NewUserGroupBox:push';
end;//Tkw_Login_Control_NewUserGroupBox_Push.GetWordNameForRegister

function Tkw_Login_Control_NewUserLabel.GetString: AnsiString;
begin
 Result := 'NewUserLabel';
end;//Tkw_Login_Control_NewUserLabel.GetString

class procedure Tkw_Login_Control_NewUserLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_Login_Control_NewUserLabel.RegisterInEngine

class function Tkw_Login_Control_NewUserLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NewUserLabel';
end;//Tkw_Login_Control_NewUserLabel.GetWordNameForRegister

procedure Tkw_Login_Control_NewUserLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('NewUserLabel');
 inherited;
end;//Tkw_Login_Control_NewUserLabel_Push.DoDoIt

class function Tkw_Login_Control_NewUserLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NewUserLabel:push';
end;//Tkw_Login_Control_NewUserLabel_Push.GetWordNameForRegister

function Tkw_Login_Control_NewUserPaintBox.GetString: AnsiString;
begin
 Result := 'NewUserPaintBox';
end;//Tkw_Login_Control_NewUserPaintBox.GetString

class procedure Tkw_Login_Control_NewUserPaintBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_Login_Control_NewUserPaintBox.RegisterInEngine

class function Tkw_Login_Control_NewUserPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NewUserPaintBox';
end;//Tkw_Login_Control_NewUserPaintBox.GetWordNameForRegister

procedure Tkw_Login_Control_NewUserPaintBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('NewUserPaintBox');
 inherited;
end;//Tkw_Login_Control_NewUserPaintBox_Push.DoDoIt

class function Tkw_Login_Control_NewUserPaintBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NewUserPaintBox:push';
end;//Tkw_Login_Control_NewUserPaintBox_Push.GetWordNameForRegister

function Tkw_Login_Control_lblNewUser.GetString: AnsiString;
begin
 Result := 'lblNewUser';
end;//Tkw_Login_Control_lblNewUser.GetString

class procedure Tkw_Login_Control_lblNewUser.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtFocusLabel);
end;//Tkw_Login_Control_lblNewUser.RegisterInEngine

class function Tkw_Login_Control_lblNewUser.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblNewUser';
end;//Tkw_Login_Control_lblNewUser.GetWordNameForRegister

procedure Tkw_Login_Control_lblNewUser_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblNewUser');
 inherited;
end;//Tkw_Login_Control_lblNewUser_Push.DoDoIt

class function Tkw_Login_Control_lblNewUser_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblNewUser:push';
end;//Tkw_Login_Control_lblNewUser_Push.GetWordNameForRegister

function Tkw_Login_Control_HelpPanel.GetString: AnsiString;
begin
 Result := 'HelpPanel';
end;//Tkw_Login_Control_HelpPanel.GetString

class procedure Tkw_Login_Control_HelpPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Login_Control_HelpPanel.RegisterInEngine

class function Tkw_Login_Control_HelpPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HelpPanel';
end;//Tkw_Login_Control_HelpPanel.GetWordNameForRegister

procedure Tkw_Login_Control_HelpPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('HelpPanel');
 inherited;
end;//Tkw_Login_Control_HelpPanel_Push.DoDoIt

class function Tkw_Login_Control_HelpPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HelpPanel:push';
end;//Tkw_Login_Control_HelpPanel_Push.GetWordNameForRegister

function Tkw_Login_Control_HelpPaintBox.GetString: AnsiString;
begin
 Result := 'HelpPaintBox';
end;//Tkw_Login_Control_HelpPaintBox.GetString

class procedure Tkw_Login_Control_HelpPaintBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_Login_Control_HelpPaintBox.RegisterInEngine

class function Tkw_Login_Control_HelpPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HelpPaintBox';
end;//Tkw_Login_Control_HelpPaintBox.GetWordNameForRegister

procedure Tkw_Login_Control_HelpPaintBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('HelpPaintBox');
 inherited;
end;//Tkw_Login_Control_HelpPaintBox_Push.DoDoIt

class function Tkw_Login_Control_HelpPaintBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HelpPaintBox:push';
end;//Tkw_Login_Control_HelpPaintBox_Push.GetWordNameForRegister

function Tkw_Login_Control_HelpLabel.GetString: AnsiString;
begin
 Result := 'HelpLabel';
end;//Tkw_Login_Control_HelpLabel.GetString

class procedure Tkw_Login_Control_HelpLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtFocusLabel);
end;//Tkw_Login_Control_HelpLabel.RegisterInEngine

class function Tkw_Login_Control_HelpLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HelpLabel';
end;//Tkw_Login_Control_HelpLabel.GetWordNameForRegister

procedure Tkw_Login_Control_HelpLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('HelpLabel');
 inherited;
end;//Tkw_Login_Control_HelpLabel_Push.DoDoIt

class function Tkw_Login_Control_HelpLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HelpLabel:push';
end;//Tkw_Login_Control_HelpLabel_Push.GetWordNameForRegister

function TkwLoginFormRegisteredGroupBox.RegisteredGroupBox(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtGroupBox;
 {* ���������� ����� ������� .TLoginForm.RegisteredGroupBox }
begin
 Result := aLoginForm.RegisteredGroupBox;
end;//TkwLoginFormRegisteredGroupBox.RegisteredGroupBox

procedure TkwLoginFormRegisteredGroupBox.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(RegisteredGroupBox(aCtx, l_aLoginForm));
end;//TkwLoginFormRegisteredGroupBox.DoDoIt

procedure TkwLoginFormRegisteredGroupBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� RegisteredGroupBox', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormRegisteredGroupBox.ParamsTypes

class function TkwLoginFormRegisteredGroupBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.RegisteredGroupBox';
end;//TkwLoginFormRegisteredGroupBox.GetWordNameForRegister

function TkwLoginFormLblLogin.lblLogin(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtLabel;
 {* ���������� ����� ������� .TLoginForm.lblLogin }
begin
 Result := aLoginForm.lblLogin;
end;//TkwLoginFormLblLogin.lblLogin

procedure TkwLoginFormLblLogin.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblLogin(aCtx, l_aLoginForm));
end;//TkwLoginFormLblLogin.DoDoIt

procedure TkwLoginFormLblLogin.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lblLogin', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormLblLogin.ParamsTypes

class function TkwLoginFormLblLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.lblLogin';
end;//TkwLoginFormLblLogin.GetWordNameForRegister

function TkwLoginFormLblPassword.lblPassword(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtLabel;
 {* ���������� ����� ������� .TLoginForm.lblPassword }
begin
 Result := aLoginForm.lblPassword;
end;//TkwLoginFormLblPassword.lblPassword

procedure TkwLoginFormLblPassword.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblPassword(aCtx, l_aLoginForm));
end;//TkwLoginFormLblPassword.DoDoIt

procedure TkwLoginFormLblPassword.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lblPassword', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormLblPassword.ParamsTypes

class function TkwLoginFormLblPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.lblPassword';
end;//TkwLoginFormLblPassword.GetWordNameForRegister

function TkwLoginFormEnterPaintBox.EnterPaintBox(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TPaintBox;
 {* ���������� ����� ������� .TLoginForm.EnterPaintBox }
begin
 Result := aLoginForm.EnterPaintBox;
end;//TkwLoginFormEnterPaintBox.EnterPaintBox

procedure TkwLoginFormEnterPaintBox.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(EnterPaintBox(aCtx, l_aLoginForm));
end;//TkwLoginFormEnterPaintBox.DoDoIt

procedure TkwLoginFormEnterPaintBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� EnterPaintBox', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormEnterPaintBox.ParamsTypes

class function TkwLoginFormEnterPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.EnterPaintBox';
end;//TkwLoginFormEnterPaintBox.GetWordNameForRegister

function TkwLoginFormEdUserName.edUserName(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TnscComboBoxWithReadOnly;
 {* ���������� ����� ������� .TLoginForm.edUserName }
begin
 Result := aLoginForm.edUserName;
end;//TkwLoginFormEdUserName.edUserName

procedure TkwLoginFormEdUserName.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edUserName(aCtx, l_aLoginForm));
end;//TkwLoginFormEdUserName.DoDoIt

procedure TkwLoginFormEdUserName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� edUserName', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormEdUserName.ParamsTypes

class function TkwLoginFormEdUserName.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.edUserName';
end;//TkwLoginFormEdUserName.GetWordNameForRegister

function TkwLoginFormEdPassword.edPassword(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TnscComboBoxWithPwdChar;
 {* ���������� ����� ������� .TLoginForm.edPassword }
begin
 Result := aLoginForm.edPassword;
end;//TkwLoginFormEdPassword.edPassword

procedure TkwLoginFormEdPassword.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edPassword(aCtx, l_aLoginForm));
end;//TkwLoginFormEdPassword.DoDoIt

procedure TkwLoginFormEdPassword.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� edPassword', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormEdPassword.ParamsTypes

class function TkwLoginFormEdPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.edPassword';
end;//TkwLoginFormEdPassword.GetWordNameForRegister

function TkwLoginFormLblForgetPassword.lblForgetPassword(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtFocusLabel;
 {* ���������� ����� ������� .TLoginForm.lblForgetPassword }
begin
 Result := aLoginForm.lblForgetPassword;
end;//TkwLoginFormLblForgetPassword.lblForgetPassword

procedure TkwLoginFormLblForgetPassword.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblForgetPassword(aCtx, l_aLoginForm));
end;//TkwLoginFormLblForgetPassword.DoDoIt

procedure TkwLoginFormLblForgetPassword.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lblForgetPassword', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormLblForgetPassword.ParamsTypes

class function TkwLoginFormLblForgetPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.lblForgetPassword';
end;//TkwLoginFormLblForgetPassword.GetWordNameForRegister

function TkwLoginFormCbAutoLogin.cbAutoLogin(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtCheckBox;
 {* ���������� ����� ������� .TLoginForm.cbAutoLogin }
begin
 Result := aLoginForm.cbAutoLogin;
end;//TkwLoginFormCbAutoLogin.cbAutoLogin

procedure TkwLoginFormCbAutoLogin.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(cbAutoLogin(aCtx, l_aLoginForm));
end;//TkwLoginFormCbAutoLogin.DoDoIt

procedure TkwLoginFormCbAutoLogin.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� cbAutoLogin', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormCbAutoLogin.ParamsTypes

class function TkwLoginFormCbAutoLogin.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.cbAutoLogin';
end;//TkwLoginFormCbAutoLogin.GetWordNameForRegister

function TkwLoginFormBtnOk.btnOk(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TElPopupButton;
 {* ���������� ����� ������� .TLoginForm.btnOk }
begin
 Result := aLoginForm.btnOk;
end;//TkwLoginFormBtnOk.btnOk

procedure TkwLoginFormBtnOk.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnOk(aCtx, l_aLoginForm));
end;//TkwLoginFormBtnOk.DoDoIt

procedure TkwLoginFormBtnOk.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� btnOk', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormBtnOk.ParamsTypes

class function TkwLoginFormBtnOk.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.btnOk';
end;//TkwLoginFormBtnOk.GetWordNameForRegister

function TkwLoginFormNewUserGroupBox.NewUserGroupBox(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtGroupBox;
 {* ���������� ����� ������� .TLoginForm.NewUserGroupBox }
begin
 Result := aLoginForm.NewUserGroupBox;
end;//TkwLoginFormNewUserGroupBox.NewUserGroupBox

procedure TkwLoginFormNewUserGroupBox.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(NewUserGroupBox(aCtx, l_aLoginForm));
end;//TkwLoginFormNewUserGroupBox.DoDoIt

procedure TkwLoginFormNewUserGroupBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� NewUserGroupBox', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormNewUserGroupBox.ParamsTypes

class function TkwLoginFormNewUserGroupBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.NewUserGroupBox';
end;//TkwLoginFormNewUserGroupBox.GetWordNameForRegister

function TkwLoginFormNewUserLabel.NewUserLabel(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtLabel;
 {* ���������� ����� ������� .TLoginForm.NewUserLabel }
begin
 Result := aLoginForm.NewUserLabel;
end;//TkwLoginFormNewUserLabel.NewUserLabel

procedure TkwLoginFormNewUserLabel.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(NewUserLabel(aCtx, l_aLoginForm));
end;//TkwLoginFormNewUserLabel.DoDoIt

procedure TkwLoginFormNewUserLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� NewUserLabel', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormNewUserLabel.ParamsTypes

class function TkwLoginFormNewUserLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.NewUserLabel';
end;//TkwLoginFormNewUserLabel.GetWordNameForRegister

function TkwLoginFormNewUserPaintBox.NewUserPaintBox(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TPaintBox;
 {* ���������� ����� ������� .TLoginForm.NewUserPaintBox }
begin
 Result := aLoginForm.NewUserPaintBox;
end;//TkwLoginFormNewUserPaintBox.NewUserPaintBox

procedure TkwLoginFormNewUserPaintBox.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(NewUserPaintBox(aCtx, l_aLoginForm));
end;//TkwLoginFormNewUserPaintBox.DoDoIt

procedure TkwLoginFormNewUserPaintBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� NewUserPaintBox', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormNewUserPaintBox.ParamsTypes

class function TkwLoginFormNewUserPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.NewUserPaintBox';
end;//TkwLoginFormNewUserPaintBox.GetWordNameForRegister

function TkwLoginFormLblNewUser.lblNewUser(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtFocusLabel;
 {* ���������� ����� ������� .TLoginForm.lblNewUser }
begin
 Result := aLoginForm.lblNewUser;
end;//TkwLoginFormLblNewUser.lblNewUser

procedure TkwLoginFormLblNewUser.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblNewUser(aCtx, l_aLoginForm));
end;//TkwLoginFormLblNewUser.DoDoIt

procedure TkwLoginFormLblNewUser.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lblNewUser', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormLblNewUser.ParamsTypes

class function TkwLoginFormLblNewUser.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.lblNewUser';
end;//TkwLoginFormLblNewUser.GetWordNameForRegister

function TkwLoginFormHelpPanel.HelpPanel(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtPanel;
 {* ���������� ����� ������� .TLoginForm.HelpPanel }
begin
 Result := aLoginForm.HelpPanel;
end;//TkwLoginFormHelpPanel.HelpPanel

procedure TkwLoginFormHelpPanel.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(HelpPanel(aCtx, l_aLoginForm));
end;//TkwLoginFormHelpPanel.DoDoIt

procedure TkwLoginFormHelpPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� HelpPanel', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormHelpPanel.ParamsTypes

class function TkwLoginFormHelpPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.HelpPanel';
end;//TkwLoginFormHelpPanel.GetWordNameForRegister

function TkwLoginFormHelpPaintBox.HelpPaintBox(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TPaintBox;
 {* ���������� ����� ������� .TLoginForm.HelpPaintBox }
begin
 Result := aLoginForm.HelpPaintBox;
end;//TkwLoginFormHelpPaintBox.HelpPaintBox

procedure TkwLoginFormHelpPaintBox.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(HelpPaintBox(aCtx, l_aLoginForm));
end;//TkwLoginFormHelpPaintBox.DoDoIt

procedure TkwLoginFormHelpPaintBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� HelpPaintBox', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormHelpPaintBox.ParamsTypes

class function TkwLoginFormHelpPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.HelpPaintBox';
end;//TkwLoginFormHelpPaintBox.GetWordNameForRegister

function TkwLoginFormHelpLabel.HelpLabel(const aCtx: TtfwContext;
 aLoginForm: TLoginForm): TvtFocusLabel;
 {* ���������� ����� ������� .TLoginForm.HelpLabel }
begin
 Result := aLoginForm.HelpLabel;
end;//TkwLoginFormHelpLabel.HelpLabel

procedure TkwLoginFormHelpLabel.DoDoIt(const aCtx: TtfwContext);
var l_aLoginForm: TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(HelpLabel(aCtx, l_aLoginForm));
end;//TkwLoginFormHelpLabel.DoDoIt

procedure TkwLoginFormHelpLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� HelpLabel', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormHelpLabel.ParamsTypes

class function TkwLoginFormHelpLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLoginForm.HelpLabel';
end;//TkwLoginFormHelpLabel.GetWordNameForRegister

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

unit UserPropertyKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/UserPropertyKeywordsPack.pas"
// �����: 07.09.2009 18:00
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 �������������::Admin::View::Admin::Admin::UserPropertyKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� UserProperty
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin) AND not defined(NoScripts)}
uses
  vtPanel,
  vtComboBoxQS,
  UserProperty_Form
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtLabel,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  vtCheckBox,
  tfwPropertyLike
  ;

{$IfEnd} //Admin AND not NoScripts

implementation

{$If defined(Admin) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_UserProperty = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� UserProperty
----
*������ �������������*:
[code]
'aControl' �����::UserProperty TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_UserProperty

// start class Tkw_Form_UserProperty

class function Tkw_Form_UserProperty.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::UserProperty';
end;//Tkw_Form_UserProperty.GetWordNameForRegister

function Tkw_Form_UserProperty.GetString: AnsiString;
 {-}
begin
 Result := 'efUserProperty';
end;//Tkw_Form_UserProperty.GetString

type
  Tkw_UserProperty_Control_pnMainData = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pnMainData
----
*������ �������������*:
[code]
�������::pnMainData TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserProperty_Control_pnMainData

// start class Tkw_UserProperty_Control_pnMainData

class function Tkw_UserProperty_Control_pnMainData.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnMainData';
end;//Tkw_UserProperty_Control_pnMainData.GetWordNameForRegister

function Tkw_UserProperty_Control_pnMainData.GetString: AnsiString;
 {-}
begin
 Result := 'pnMainData';
end;//Tkw_UserProperty_Control_pnMainData.GetString

class procedure Tkw_UserProperty_Control_pnMainData.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_UserProperty_Control_pnMainData.RegisterInEngine

type
  Tkw_UserProperty_Control_pnMainData_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pnMainData
----
*������ �������������*:
[code]
�������::pnMainData:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserProperty_Control_pnMainData_Push

// start class Tkw_UserProperty_Control_pnMainData_Push

procedure Tkw_UserProperty_Control_pnMainData_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnMainData');
 inherited;
end;//Tkw_UserProperty_Control_pnMainData_Push.DoDoIt

class function Tkw_UserProperty_Control_pnMainData_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnMainData:push';
end;//Tkw_UserProperty_Control_pnMainData_Push.GetWordNameForRegister

type
  Tkw_UserProperty_Control_f_TopPanel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� f_TopPanel
----
*������ �������������*:
[code]
�������::f_TopPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserProperty_Control_f_TopPanel

// start class Tkw_UserProperty_Control_f_TopPanel

class function Tkw_UserProperty_Control_f_TopPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::f_TopPanel';
end;//Tkw_UserProperty_Control_f_TopPanel.GetWordNameForRegister

function Tkw_UserProperty_Control_f_TopPanel.GetString: AnsiString;
 {-}
begin
 Result := 'f_TopPanel';
end;//Tkw_UserProperty_Control_f_TopPanel.GetString

class procedure Tkw_UserProperty_Control_f_TopPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_UserProperty_Control_f_TopPanel.RegisterInEngine

type
  Tkw_UserProperty_Control_f_TopPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� f_TopPanel
----
*������ �������������*:
[code]
�������::f_TopPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserProperty_Control_f_TopPanel_Push

// start class Tkw_UserProperty_Control_f_TopPanel_Push

procedure Tkw_UserProperty_Control_f_TopPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('f_TopPanel');
 inherited;
end;//Tkw_UserProperty_Control_f_TopPanel_Push.DoDoIt

class function Tkw_UserProperty_Control_f_TopPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::f_TopPanel:push';
end;//Tkw_UserProperty_Control_f_TopPanel_Push.GetWordNameForRegister

type
  Tkw_UserProperty_Control_UserNameLabel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� UserNameLabel
----
*������ �������������*:
[code]
�������::UserNameLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserProperty_Control_UserNameLabel

// start class Tkw_UserProperty_Control_UserNameLabel

class function Tkw_UserProperty_Control_UserNameLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::UserNameLabel';
end;//Tkw_UserProperty_Control_UserNameLabel.GetWordNameForRegister

function Tkw_UserProperty_Control_UserNameLabel.GetString: AnsiString;
 {-}
begin
 Result := 'UserNameLabel';
end;//Tkw_UserProperty_Control_UserNameLabel.GetString

class procedure Tkw_UserProperty_Control_UserNameLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_UserProperty_Control_UserNameLabel.RegisterInEngine

type
  Tkw_UserProperty_Control_UserNameLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� UserNameLabel
----
*������ �������������*:
[code]
�������::UserNameLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserProperty_Control_UserNameLabel_Push

// start class Tkw_UserProperty_Control_UserNameLabel_Push

procedure Tkw_UserProperty_Control_UserNameLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('UserNameLabel');
 inherited;
end;//Tkw_UserProperty_Control_UserNameLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_UserNameLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::UserNameLabel:push';
end;//Tkw_UserProperty_Control_UserNameLabel_Push.GetWordNameForRegister

type
  Tkw_UserProperty_Control_PasswordLabel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� PasswordLabel
----
*������ �������������*:
[code]
�������::PasswordLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserProperty_Control_PasswordLabel

// start class Tkw_UserProperty_Control_PasswordLabel

class function Tkw_UserProperty_Control_PasswordLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::PasswordLabel';
end;//Tkw_UserProperty_Control_PasswordLabel.GetWordNameForRegister

function Tkw_UserProperty_Control_PasswordLabel.GetString: AnsiString;
 {-}
begin
 Result := 'PasswordLabel';
end;//Tkw_UserProperty_Control_PasswordLabel.GetString

class procedure Tkw_UserProperty_Control_PasswordLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_UserProperty_Control_PasswordLabel.RegisterInEngine

type
  Tkw_UserProperty_Control_PasswordLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� PasswordLabel
----
*������ �������������*:
[code]
�������::PasswordLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserProperty_Control_PasswordLabel_Push

// start class Tkw_UserProperty_Control_PasswordLabel_Push

procedure Tkw_UserProperty_Control_PasswordLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('PasswordLabel');
 inherited;
end;//Tkw_UserProperty_Control_PasswordLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_PasswordLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::PasswordLabel:push';
end;//Tkw_UserProperty_Control_PasswordLabel_Push.GetWordNameForRegister

type
  Tkw_UserProperty_Control_LoginLabel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� LoginLabel
----
*������ �������������*:
[code]
�������::LoginLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserProperty_Control_LoginLabel

// start class Tkw_UserProperty_Control_LoginLabel

class function Tkw_UserProperty_Control_LoginLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::LoginLabel';
end;//Tkw_UserProperty_Control_LoginLabel.GetWordNameForRegister

function Tkw_UserProperty_Control_LoginLabel.GetString: AnsiString;
 {-}
begin
 Result := 'LoginLabel';
end;//Tkw_UserProperty_Control_LoginLabel.GetString

class procedure Tkw_UserProperty_Control_LoginLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_UserProperty_Control_LoginLabel.RegisterInEngine

type
  Tkw_UserProperty_Control_LoginLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� LoginLabel
----
*������ �������������*:
[code]
�������::LoginLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserProperty_Control_LoginLabel_Push

// start class Tkw_UserProperty_Control_LoginLabel_Push

procedure Tkw_UserProperty_Control_LoginLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('LoginLabel');
 inherited;
end;//Tkw_UserProperty_Control_LoginLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_LoginLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::LoginLabel:push';
end;//Tkw_UserProperty_Control_LoginLabel_Push.GetWordNameForRegister

type
  Tkw_UserProperty_Control_EMailLabel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� EMailLabel
----
*������ �������������*:
[code]
�������::EMailLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserProperty_Control_EMailLabel

// start class Tkw_UserProperty_Control_EMailLabel

class function Tkw_UserProperty_Control_EMailLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::EMailLabel';
end;//Tkw_UserProperty_Control_EMailLabel.GetWordNameForRegister

function Tkw_UserProperty_Control_EMailLabel.GetString: AnsiString;
 {-}
begin
 Result := 'EMailLabel';
end;//Tkw_UserProperty_Control_EMailLabel.GetString

class procedure Tkw_UserProperty_Control_EMailLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_UserProperty_Control_EMailLabel.RegisterInEngine

type
  Tkw_UserProperty_Control_EMailLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� EMailLabel
----
*������ �������������*:
[code]
�������::EMailLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserProperty_Control_EMailLabel_Push

// start class Tkw_UserProperty_Control_EMailLabel_Push

procedure Tkw_UserProperty_Control_EMailLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('EMailLabel');
 inherited;
end;//Tkw_UserProperty_Control_EMailLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_EMailLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::EMailLabel:push';
end;//Tkw_UserProperty_Control_EMailLabel_Push.GetWordNameForRegister

type
  Tkw_UserProperty_Control_ConfirmPasswordLabel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ConfirmPasswordLabel
----
*������ �������������*:
[code]
�������::ConfirmPasswordLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserProperty_Control_ConfirmPasswordLabel

// start class Tkw_UserProperty_Control_ConfirmPasswordLabel

class function Tkw_UserProperty_Control_ConfirmPasswordLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ConfirmPasswordLabel';
end;//Tkw_UserProperty_Control_ConfirmPasswordLabel.GetWordNameForRegister

function Tkw_UserProperty_Control_ConfirmPasswordLabel.GetString: AnsiString;
 {-}
begin
 Result := 'ConfirmPasswordLabel';
end;//Tkw_UserProperty_Control_ConfirmPasswordLabel.GetString

class procedure Tkw_UserProperty_Control_ConfirmPasswordLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_UserProperty_Control_ConfirmPasswordLabel.RegisterInEngine

type
  Tkw_UserProperty_Control_ConfirmPasswordLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� ConfirmPasswordLabel
----
*������ �������������*:
[code]
�������::ConfirmPasswordLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserProperty_Control_ConfirmPasswordLabel_Push

// start class Tkw_UserProperty_Control_ConfirmPasswordLabel_Push

procedure Tkw_UserProperty_Control_ConfirmPasswordLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ConfirmPasswordLabel');
 inherited;
end;//Tkw_UserProperty_Control_ConfirmPasswordLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_ConfirmPasswordLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ConfirmPasswordLabel:push';
end;//Tkw_UserProperty_Control_ConfirmPasswordLabel_Push.GetWordNameForRegister

type
  Tkw_UserProperty_Control_GroupLabel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� GroupLabel
----
*������ �������������*:
[code]
�������::GroupLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserProperty_Control_GroupLabel

// start class Tkw_UserProperty_Control_GroupLabel

class function Tkw_UserProperty_Control_GroupLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::GroupLabel';
end;//Tkw_UserProperty_Control_GroupLabel.GetWordNameForRegister

function Tkw_UserProperty_Control_GroupLabel.GetString: AnsiString;
 {-}
begin
 Result := 'GroupLabel';
end;//Tkw_UserProperty_Control_GroupLabel.GetString

class procedure Tkw_UserProperty_Control_GroupLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_UserProperty_Control_GroupLabel.RegisterInEngine

type
  Tkw_UserProperty_Control_GroupLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� GroupLabel
----
*������ �������������*:
[code]
�������::GroupLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserProperty_Control_GroupLabel_Push

// start class Tkw_UserProperty_Control_GroupLabel_Push

procedure Tkw_UserProperty_Control_GroupLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('GroupLabel');
 inherited;
end;//Tkw_UserProperty_Control_GroupLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_GroupLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::GroupLabel:push';
end;//Tkw_UserProperty_Control_GroupLabel_Push.GetWordNameForRegister

type
  Tkw_UserProperty_Control_edPassword = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� edPassword
----
*������ �������������*:
[code]
�������::edPassword TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserProperty_Control_edPassword

// start class Tkw_UserProperty_Control_edPassword

class function Tkw_UserProperty_Control_edPassword.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::edPassword';
end;//Tkw_UserProperty_Control_edPassword.GetWordNameForRegister

function Tkw_UserProperty_Control_edPassword.GetString: AnsiString;
 {-}
begin
 Result := 'edPassword';
end;//Tkw_UserProperty_Control_edPassword.GetString

class procedure Tkw_UserProperty_Control_edPassword.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscComboBoxWithPwdChar);
end;//Tkw_UserProperty_Control_edPassword.RegisterInEngine

type
  Tkw_UserProperty_Control_edPassword_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� edPassword
----
*������ �������������*:
[code]
�������::edPassword:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserProperty_Control_edPassword_Push

// start class Tkw_UserProperty_Control_edPassword_Push

procedure Tkw_UserProperty_Control_edPassword_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edPassword');
 inherited;
end;//Tkw_UserProperty_Control_edPassword_Push.DoDoIt

class function Tkw_UserProperty_Control_edPassword_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::edPassword:push';
end;//Tkw_UserProperty_Control_edPassword_Push.GetWordNameForRegister

type
  Tkw_UserProperty_Control_edUserName = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� edUserName
----
*������ �������������*:
[code]
�������::edUserName TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserProperty_Control_edUserName

// start class Tkw_UserProperty_Control_edUserName

class function Tkw_UserProperty_Control_edUserName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::edUserName';
end;//Tkw_UserProperty_Control_edUserName.GetWordNameForRegister

function Tkw_UserProperty_Control_edUserName.GetString: AnsiString;
 {-}
begin
 Result := 'edUserName';
end;//Tkw_UserProperty_Control_edUserName.GetString

class procedure Tkw_UserProperty_Control_edUserName.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_UserProperty_Control_edUserName.RegisterInEngine

type
  Tkw_UserProperty_Control_edUserName_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� edUserName
----
*������ �������������*:
[code]
�������::edUserName:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserProperty_Control_edUserName_Push

// start class Tkw_UserProperty_Control_edUserName_Push

procedure Tkw_UserProperty_Control_edUserName_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edUserName');
 inherited;
end;//Tkw_UserProperty_Control_edUserName_Push.DoDoIt

class function Tkw_UserProperty_Control_edUserName_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::edUserName:push';
end;//Tkw_UserProperty_Control_edUserName_Push.GetWordNameForRegister

type
  Tkw_UserProperty_Control_edLogin = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� edLogin
----
*������ �������������*:
[code]
�������::edLogin TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserProperty_Control_edLogin

// start class Tkw_UserProperty_Control_edLogin

class function Tkw_UserProperty_Control_edLogin.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::edLogin';
end;//Tkw_UserProperty_Control_edLogin.GetWordNameForRegister

function Tkw_UserProperty_Control_edLogin.GetString: AnsiString;
 {-}
begin
 Result := 'edLogin';
end;//Tkw_UserProperty_Control_edLogin.GetString

class procedure Tkw_UserProperty_Control_edLogin.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_UserProperty_Control_edLogin.RegisterInEngine

type
  Tkw_UserProperty_Control_edLogin_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� edLogin
----
*������ �������������*:
[code]
�������::edLogin:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserProperty_Control_edLogin_Push

// start class Tkw_UserProperty_Control_edLogin_Push

procedure Tkw_UserProperty_Control_edLogin_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edLogin');
 inherited;
end;//Tkw_UserProperty_Control_edLogin_Push.DoDoIt

class function Tkw_UserProperty_Control_edLogin_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::edLogin:push';
end;//Tkw_UserProperty_Control_edLogin_Push.GetWordNameForRegister

type
  Tkw_UserProperty_Control_edEmail = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� edEmail
----
*������ �������������*:
[code]
�������::edEmail TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserProperty_Control_edEmail

// start class Tkw_UserProperty_Control_edEmail

class function Tkw_UserProperty_Control_edEmail.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::edEmail';
end;//Tkw_UserProperty_Control_edEmail.GetWordNameForRegister

function Tkw_UserProperty_Control_edEmail.GetString: AnsiString;
 {-}
begin
 Result := 'edEmail';
end;//Tkw_UserProperty_Control_edEmail.GetString

class procedure Tkw_UserProperty_Control_edEmail.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_UserProperty_Control_edEmail.RegisterInEngine

type
  Tkw_UserProperty_Control_edEmail_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� edEmail
----
*������ �������������*:
[code]
�������::edEmail:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserProperty_Control_edEmail_Push

// start class Tkw_UserProperty_Control_edEmail_Push

procedure Tkw_UserProperty_Control_edEmail_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edEmail');
 inherited;
end;//Tkw_UserProperty_Control_edEmail_Push.DoDoIt

class function Tkw_UserProperty_Control_edEmail_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::edEmail:push';
end;//Tkw_UserProperty_Control_edEmail_Push.GetWordNameForRegister

type
  Tkw_UserProperty_Control_edConfirm = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� edConfirm
----
*������ �������������*:
[code]
�������::edConfirm TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserProperty_Control_edConfirm

// start class Tkw_UserProperty_Control_edConfirm

class function Tkw_UserProperty_Control_edConfirm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::edConfirm';
end;//Tkw_UserProperty_Control_edConfirm.GetWordNameForRegister

function Tkw_UserProperty_Control_edConfirm.GetString: AnsiString;
 {-}
begin
 Result := 'edConfirm';
end;//Tkw_UserProperty_Control_edConfirm.GetString

class procedure Tkw_UserProperty_Control_edConfirm.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscComboBoxWithPwdChar);
end;//Tkw_UserProperty_Control_edConfirm.RegisterInEngine

type
  Tkw_UserProperty_Control_edConfirm_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� edConfirm
----
*������ �������������*:
[code]
�������::edConfirm:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserProperty_Control_edConfirm_Push

// start class Tkw_UserProperty_Control_edConfirm_Push

procedure Tkw_UserProperty_Control_edConfirm_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edConfirm');
 inherited;
end;//Tkw_UserProperty_Control_edConfirm_Push.DoDoIt

class function Tkw_UserProperty_Control_edConfirm_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::edConfirm:push';
end;//Tkw_UserProperty_Control_edConfirm_Push.GetWordNameForRegister

type
  Tkw_UserProperty_Control_edGroup = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� edGroup
----
*������ �������������*:
[code]
�������::edGroup TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserProperty_Control_edGroup

// start class Tkw_UserProperty_Control_edGroup

class function Tkw_UserProperty_Control_edGroup.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::edGroup';
end;//Tkw_UserProperty_Control_edGroup.GetWordNameForRegister

function Tkw_UserProperty_Control_edGroup.GetString: AnsiString;
 {-}
begin
 Result := 'edGroup';
end;//Tkw_UserProperty_Control_edGroup.GetString

class procedure Tkw_UserProperty_Control_edGroup.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_UserProperty_Control_edGroup.RegisterInEngine

type
  Tkw_UserProperty_Control_edGroup_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� edGroup
----
*������ �������������*:
[code]
�������::edGroup:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserProperty_Control_edGroup_Push

// start class Tkw_UserProperty_Control_edGroup_Push

procedure Tkw_UserProperty_Control_edGroup_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edGroup');
 inherited;
end;//Tkw_UserProperty_Control_edGroup_Push.DoDoIt

class function Tkw_UserProperty_Control_edGroup_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::edGroup:push';
end;//Tkw_UserProperty_Control_edGroup_Push.GetWordNameForRegister

type
  Tkw_UserProperty_Control_f_MiddlePanel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� f_MiddlePanel
----
*������ �������������*:
[code]
�������::f_MiddlePanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserProperty_Control_f_MiddlePanel

// start class Tkw_UserProperty_Control_f_MiddlePanel

class function Tkw_UserProperty_Control_f_MiddlePanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::f_MiddlePanel';
end;//Tkw_UserProperty_Control_f_MiddlePanel.GetWordNameForRegister

function Tkw_UserProperty_Control_f_MiddlePanel.GetString: AnsiString;
 {-}
begin
 Result := 'f_MiddlePanel';
end;//Tkw_UserProperty_Control_f_MiddlePanel.GetString

class procedure Tkw_UserProperty_Control_f_MiddlePanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_UserProperty_Control_f_MiddlePanel.RegisterInEngine

type
  Tkw_UserProperty_Control_f_MiddlePanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� f_MiddlePanel
----
*������ �������������*:
[code]
�������::f_MiddlePanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserProperty_Control_f_MiddlePanel_Push

// start class Tkw_UserProperty_Control_f_MiddlePanel_Push

procedure Tkw_UserProperty_Control_f_MiddlePanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('f_MiddlePanel');
 inherited;
end;//Tkw_UserProperty_Control_f_MiddlePanel_Push.DoDoIt

class function Tkw_UserProperty_Control_f_MiddlePanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::f_MiddlePanel:push';
end;//Tkw_UserProperty_Control_f_MiddlePanel_Push.GetWordNameForRegister

type
  Tkw_UserProperty_Control_edPrivilegedUser = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� edPrivilegedUser
----
*������ �������������*:
[code]
�������::edPrivilegedUser TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserProperty_Control_edPrivilegedUser

// start class Tkw_UserProperty_Control_edPrivilegedUser

class function Tkw_UserProperty_Control_edPrivilegedUser.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::edPrivilegedUser';
end;//Tkw_UserProperty_Control_edPrivilegedUser.GetWordNameForRegister

function Tkw_UserProperty_Control_edPrivilegedUser.GetString: AnsiString;
 {-}
begin
 Result := 'edPrivilegedUser';
end;//Tkw_UserProperty_Control_edPrivilegedUser.GetString

class procedure Tkw_UserProperty_Control_edPrivilegedUser.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_UserProperty_Control_edPrivilegedUser.RegisterInEngine

type
  Tkw_UserProperty_Control_edPrivilegedUser_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� edPrivilegedUser
----
*������ �������������*:
[code]
�������::edPrivilegedUser:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserProperty_Control_edPrivilegedUser_Push

// start class Tkw_UserProperty_Control_edPrivilegedUser_Push

procedure Tkw_UserProperty_Control_edPrivilegedUser_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edPrivilegedUser');
 inherited;
end;//Tkw_UserProperty_Control_edPrivilegedUser_Push.DoDoIt

class function Tkw_UserProperty_Control_edPrivilegedUser_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::edPrivilegedUser:push';
end;//Tkw_UserProperty_Control_edPrivilegedUser_Push.GetWordNameForRegister

type
  Tkw_UserProperty_Control_edBuyConsulting = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� edBuyConsulting
----
*������ �������������*:
[code]
�������::edBuyConsulting TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserProperty_Control_edBuyConsulting

// start class Tkw_UserProperty_Control_edBuyConsulting

class function Tkw_UserProperty_Control_edBuyConsulting.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::edBuyConsulting';
end;//Tkw_UserProperty_Control_edBuyConsulting.GetWordNameForRegister

function Tkw_UserProperty_Control_edBuyConsulting.GetString: AnsiString;
 {-}
begin
 Result := 'edBuyConsulting';
end;//Tkw_UserProperty_Control_edBuyConsulting.GetString

class procedure Tkw_UserProperty_Control_edBuyConsulting.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_UserProperty_Control_edBuyConsulting.RegisterInEngine

type
  Tkw_UserProperty_Control_edBuyConsulting_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� edBuyConsulting
----
*������ �������������*:
[code]
�������::edBuyConsulting:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserProperty_Control_edBuyConsulting_Push

// start class Tkw_UserProperty_Control_edBuyConsulting_Push

procedure Tkw_UserProperty_Control_edBuyConsulting_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edBuyConsulting');
 inherited;
end;//Tkw_UserProperty_Control_edBuyConsulting_Push.DoDoIt

class function Tkw_UserProperty_Control_edBuyConsulting_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::edBuyConsulting:push';
end;//Tkw_UserProperty_Control_edBuyConsulting_Push.GetWordNameForRegister

type
  Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� f_DontDeleteIdleUserPanel
----
*������ �������������*:
[code]
�������::f_DontDeleteIdleUserPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel

// start class Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel

class function Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::f_DontDeleteIdleUserPanel';
end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel.GetWordNameForRegister

function Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel.GetString: AnsiString;
 {-}
begin
 Result := 'f_DontDeleteIdleUserPanel';
end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel.GetString

class procedure Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel.RegisterInEngine

type
  Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� f_DontDeleteIdleUserPanel
----
*������ �������������*:
[code]
�������::f_DontDeleteIdleUserPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push

// start class Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push

procedure Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('f_DontDeleteIdleUserPanel');
 inherited;
end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push.DoDoIt

class function Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::f_DontDeleteIdleUserPanel:push';
end;//Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push.GetWordNameForRegister

type
  Tkw_UserProperty_Control_edDontDeleteIdleUser = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� edDontDeleteIdleUser
----
*������ �������������*:
[code]
�������::edDontDeleteIdleUser TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserProperty_Control_edDontDeleteIdleUser

// start class Tkw_UserProperty_Control_edDontDeleteIdleUser

class function Tkw_UserProperty_Control_edDontDeleteIdleUser.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::edDontDeleteIdleUser';
end;//Tkw_UserProperty_Control_edDontDeleteIdleUser.GetWordNameForRegister

function Tkw_UserProperty_Control_edDontDeleteIdleUser.GetString: AnsiString;
 {-}
begin
 Result := 'edDontDeleteIdleUser';
end;//Tkw_UserProperty_Control_edDontDeleteIdleUser.GetString

class procedure Tkw_UserProperty_Control_edDontDeleteIdleUser.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_UserProperty_Control_edDontDeleteIdleUser.RegisterInEngine

type
  Tkw_UserProperty_Control_edDontDeleteIdleUser_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� edDontDeleteIdleUser
----
*������ �������������*:
[code]
�������::edDontDeleteIdleUser:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserProperty_Control_edDontDeleteIdleUser_Push

// start class Tkw_UserProperty_Control_edDontDeleteIdleUser_Push

procedure Tkw_UserProperty_Control_edDontDeleteIdleUser_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edDontDeleteIdleUser');
 inherited;
end;//Tkw_UserProperty_Control_edDontDeleteIdleUser_Push.DoDoIt

class function Tkw_UserProperty_Control_edDontDeleteIdleUser_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::edDontDeleteIdleUser:push';
end;//Tkw_UserProperty_Control_edDontDeleteIdleUser_Push.GetWordNameForRegister

type
  Tkw_UserProperty_Control_f_BottomPanel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� f_BottomPanel
----
*������ �������������*:
[code]
�������::f_BottomPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserProperty_Control_f_BottomPanel

// start class Tkw_UserProperty_Control_f_BottomPanel

class function Tkw_UserProperty_Control_f_BottomPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::f_BottomPanel';
end;//Tkw_UserProperty_Control_f_BottomPanel.GetWordNameForRegister

function Tkw_UserProperty_Control_f_BottomPanel.GetString: AnsiString;
 {-}
begin
 Result := 'f_BottomPanel';
end;//Tkw_UserProperty_Control_f_BottomPanel.GetString

class procedure Tkw_UserProperty_Control_f_BottomPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_UserProperty_Control_f_BottomPanel.RegisterInEngine

type
  Tkw_UserProperty_Control_f_BottomPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� f_BottomPanel
----
*������ �������������*:
[code]
�������::f_BottomPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserProperty_Control_f_BottomPanel_Push

// start class Tkw_UserProperty_Control_f_BottomPanel_Push

procedure Tkw_UserProperty_Control_f_BottomPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('f_BottomPanel');
 inherited;
end;//Tkw_UserProperty_Control_f_BottomPanel_Push.DoDoIt

class function Tkw_UserProperty_Control_f_BottomPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::f_BottomPanel:push';
end;//Tkw_UserProperty_Control_f_BottomPanel_Push.GetWordNameForRegister

type
  Tkw_UserProperty_Control_InfoLabel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� InfoLabel
----
*������ �������������*:
[code]
�������::InfoLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserProperty_Control_InfoLabel

// start class Tkw_UserProperty_Control_InfoLabel

class function Tkw_UserProperty_Control_InfoLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::InfoLabel';
end;//Tkw_UserProperty_Control_InfoLabel.GetWordNameForRegister

function Tkw_UserProperty_Control_InfoLabel.GetString: AnsiString;
 {-}
begin
 Result := 'InfoLabel';
end;//Tkw_UserProperty_Control_InfoLabel.GetString

class procedure Tkw_UserProperty_Control_InfoLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_UserProperty_Control_InfoLabel.RegisterInEngine

type
  Tkw_UserProperty_Control_InfoLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� InfoLabel
----
*������ �������������*:
[code]
�������::InfoLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserProperty_Control_InfoLabel_Push

// start class Tkw_UserProperty_Control_InfoLabel_Push

procedure Tkw_UserProperty_Control_InfoLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('InfoLabel');
 inherited;
end;//Tkw_UserProperty_Control_InfoLabel_Push.DoDoIt

class function Tkw_UserProperty_Control_InfoLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::InfoLabel:push';
end;//Tkw_UserProperty_Control_InfoLabel_Push.GetWordNameForRegister

type
  Tkw_UserProperty_Control_edHasSharedFilters = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� edHasSharedFilters
----
*������ �������������*:
[code]
�������::edHasSharedFilters TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserProperty_Control_edHasSharedFilters

// start class Tkw_UserProperty_Control_edHasSharedFilters

class function Tkw_UserProperty_Control_edHasSharedFilters.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::edHasSharedFilters';
end;//Tkw_UserProperty_Control_edHasSharedFilters.GetWordNameForRegister

function Tkw_UserProperty_Control_edHasSharedFilters.GetString: AnsiString;
 {-}
begin
 Result := 'edHasSharedFilters';
end;//Tkw_UserProperty_Control_edHasSharedFilters.GetString

class procedure Tkw_UserProperty_Control_edHasSharedFilters.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_UserProperty_Control_edHasSharedFilters.RegisterInEngine

type
  Tkw_UserProperty_Control_edHasSharedFilters_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� edHasSharedFilters
----
*������ �������������*:
[code]
�������::edHasSharedFilters:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserProperty_Control_edHasSharedFilters_Push

// start class Tkw_UserProperty_Control_edHasSharedFilters_Push

procedure Tkw_UserProperty_Control_edHasSharedFilters_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edHasSharedFilters');
 inherited;
end;//Tkw_UserProperty_Control_edHasSharedFilters_Push.DoDoIt

class function Tkw_UserProperty_Control_edHasSharedFilters_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::edHasSharedFilters:push';
end;//Tkw_UserProperty_Control_edHasSharedFilters_Push.GetWordNameForRegister

type
  TkwEfUserPropertyPnMainData = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserProperty.pnMainData
[panel]������� pnMainData ����� TefUserProperty[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aefUserProperty .TefUserProperty.pnMainData >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnMainData(const aCtx: TtfwContext;
     aefUserProperty: TefUserProperty): TvtPanel;
     {* ���������� ����� ������� .TefUserProperty.pnMainData }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfUserPropertyPnMainData

// start class TkwEfUserPropertyPnMainData

function TkwEfUserPropertyPnMainData.PnMainData(const aCtx: TtfwContext;
  aefUserProperty: TefUserProperty): TvtPanel;
 {-}
begin
 Result := aefUserProperty.pnMainData;
end;//TkwEfUserPropertyPnMainData.PnMainData

procedure TkwEfUserPropertyPnMainData.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserProperty : TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnMainData(aCtx, l_aefUserProperty)));
end;//TkwEfUserPropertyPnMainData.DoDoIt

class function TkwEfUserPropertyPnMainData.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserProperty.pnMainData';
end;//TkwEfUserPropertyPnMainData.GetWordNameForRegister

procedure TkwEfUserPropertyPnMainData.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pnMainData', aCtx);
end;//TkwEfUserPropertyPnMainData.SetValuePrim

function TkwEfUserPropertyPnMainData.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfUserPropertyPnMainData.GetResultTypeInfo

function TkwEfUserPropertyPnMainData.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserPropertyPnMainData.GetAllParamsCount

function TkwEfUserPropertyPnMainData.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyPnMainData.ParamsTypes

type
  TkwEfUserPropertyFTopPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserProperty.f_TopPanel
[panel]������� f_TopPanel ����� TefUserProperty[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aefUserProperty .TefUserProperty.f_TopPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function FTopPanel(const aCtx: TtfwContext;
     aefUserProperty: TefUserProperty): TvtPanel;
     {* ���������� ����� ������� .TefUserProperty.f_TopPanel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfUserPropertyFTopPanel

// start class TkwEfUserPropertyFTopPanel

function TkwEfUserPropertyFTopPanel.FTopPanel(const aCtx: TtfwContext;
  aefUserProperty: TefUserProperty): TvtPanel;
 {-}
begin
 Result := aefUserProperty.f_TopPanel;
end;//TkwEfUserPropertyFTopPanel.FTopPanel

procedure TkwEfUserPropertyFTopPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserProperty : TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FTopPanel(aCtx, l_aefUserProperty)));
end;//TkwEfUserPropertyFTopPanel.DoDoIt

class function TkwEfUserPropertyFTopPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserProperty.f_TopPanel';
end;//TkwEfUserPropertyFTopPanel.GetWordNameForRegister

procedure TkwEfUserPropertyFTopPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� f_TopPanel', aCtx);
end;//TkwEfUserPropertyFTopPanel.SetValuePrim

function TkwEfUserPropertyFTopPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfUserPropertyFTopPanel.GetResultTypeInfo

function TkwEfUserPropertyFTopPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserPropertyFTopPanel.GetAllParamsCount

function TkwEfUserPropertyFTopPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyFTopPanel.ParamsTypes

type
  TkwEfUserPropertyUserNameLabel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserProperty.UserNameLabel
[panel]������� UserNameLabel ����� TefUserProperty[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefUserProperty .TefUserProperty.UserNameLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function UserNameLabel(const aCtx: TtfwContext;
     aefUserProperty: TefUserProperty): TvtLabel;
     {* ���������� ����� ������� .TefUserProperty.UserNameLabel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfUserPropertyUserNameLabel

// start class TkwEfUserPropertyUserNameLabel

function TkwEfUserPropertyUserNameLabel.UserNameLabel(const aCtx: TtfwContext;
  aefUserProperty: TefUserProperty): TvtLabel;
 {-}
begin
 Result := aefUserProperty.UserNameLabel;
end;//TkwEfUserPropertyUserNameLabel.UserNameLabel

procedure TkwEfUserPropertyUserNameLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserProperty : TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((UserNameLabel(aCtx, l_aefUserProperty)));
end;//TkwEfUserPropertyUserNameLabel.DoDoIt

class function TkwEfUserPropertyUserNameLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserProperty.UserNameLabel';
end;//TkwEfUserPropertyUserNameLabel.GetWordNameForRegister

procedure TkwEfUserPropertyUserNameLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� UserNameLabel', aCtx);
end;//TkwEfUserPropertyUserNameLabel.SetValuePrim

function TkwEfUserPropertyUserNameLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfUserPropertyUserNameLabel.GetResultTypeInfo

function TkwEfUserPropertyUserNameLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserPropertyUserNameLabel.GetAllParamsCount

function TkwEfUserPropertyUserNameLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyUserNameLabel.ParamsTypes

type
  TkwEfUserPropertyPasswordLabel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserProperty.PasswordLabel
[panel]������� PasswordLabel ����� TefUserProperty[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefUserProperty .TefUserProperty.PasswordLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function PasswordLabel(const aCtx: TtfwContext;
     aefUserProperty: TefUserProperty): TvtLabel;
     {* ���������� ����� ������� .TefUserProperty.PasswordLabel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfUserPropertyPasswordLabel

// start class TkwEfUserPropertyPasswordLabel

function TkwEfUserPropertyPasswordLabel.PasswordLabel(const aCtx: TtfwContext;
  aefUserProperty: TefUserProperty): TvtLabel;
 {-}
begin
 Result := aefUserProperty.PasswordLabel;
end;//TkwEfUserPropertyPasswordLabel.PasswordLabel

procedure TkwEfUserPropertyPasswordLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserProperty : TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PasswordLabel(aCtx, l_aefUserProperty)));
end;//TkwEfUserPropertyPasswordLabel.DoDoIt

class function TkwEfUserPropertyPasswordLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserProperty.PasswordLabel';
end;//TkwEfUserPropertyPasswordLabel.GetWordNameForRegister

procedure TkwEfUserPropertyPasswordLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� PasswordLabel', aCtx);
end;//TkwEfUserPropertyPasswordLabel.SetValuePrim

function TkwEfUserPropertyPasswordLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfUserPropertyPasswordLabel.GetResultTypeInfo

function TkwEfUserPropertyPasswordLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserPropertyPasswordLabel.GetAllParamsCount

function TkwEfUserPropertyPasswordLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyPasswordLabel.ParamsTypes

type
  TkwEfUserPropertyLoginLabel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserProperty.LoginLabel
[panel]������� LoginLabel ����� TefUserProperty[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefUserProperty .TefUserProperty.LoginLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LoginLabel(const aCtx: TtfwContext;
     aefUserProperty: TefUserProperty): TvtLabel;
     {* ���������� ����� ������� .TefUserProperty.LoginLabel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfUserPropertyLoginLabel

// start class TkwEfUserPropertyLoginLabel

function TkwEfUserPropertyLoginLabel.LoginLabel(const aCtx: TtfwContext;
  aefUserProperty: TefUserProperty): TvtLabel;
 {-}
begin
 Result := aefUserProperty.LoginLabel;
end;//TkwEfUserPropertyLoginLabel.LoginLabel

procedure TkwEfUserPropertyLoginLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserProperty : TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LoginLabel(aCtx, l_aefUserProperty)));
end;//TkwEfUserPropertyLoginLabel.DoDoIt

class function TkwEfUserPropertyLoginLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserProperty.LoginLabel';
end;//TkwEfUserPropertyLoginLabel.GetWordNameForRegister

procedure TkwEfUserPropertyLoginLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� LoginLabel', aCtx);
end;//TkwEfUserPropertyLoginLabel.SetValuePrim

function TkwEfUserPropertyLoginLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfUserPropertyLoginLabel.GetResultTypeInfo

function TkwEfUserPropertyLoginLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserPropertyLoginLabel.GetAllParamsCount

function TkwEfUserPropertyLoginLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyLoginLabel.ParamsTypes

type
  TkwEfUserPropertyEMailLabel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserProperty.EMailLabel
[panel]������� EMailLabel ����� TefUserProperty[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefUserProperty .TefUserProperty.EMailLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function EMailLabel(const aCtx: TtfwContext;
     aefUserProperty: TefUserProperty): TvtLabel;
     {* ���������� ����� ������� .TefUserProperty.EMailLabel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfUserPropertyEMailLabel

// start class TkwEfUserPropertyEMailLabel

function TkwEfUserPropertyEMailLabel.EMailLabel(const aCtx: TtfwContext;
  aefUserProperty: TefUserProperty): TvtLabel;
 {-}
begin
 Result := aefUserProperty.EMailLabel;
end;//TkwEfUserPropertyEMailLabel.EMailLabel

procedure TkwEfUserPropertyEMailLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserProperty : TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EMailLabel(aCtx, l_aefUserProperty)));
end;//TkwEfUserPropertyEMailLabel.DoDoIt

class function TkwEfUserPropertyEMailLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserProperty.EMailLabel';
end;//TkwEfUserPropertyEMailLabel.GetWordNameForRegister

procedure TkwEfUserPropertyEMailLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� EMailLabel', aCtx);
end;//TkwEfUserPropertyEMailLabel.SetValuePrim

function TkwEfUserPropertyEMailLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfUserPropertyEMailLabel.GetResultTypeInfo

function TkwEfUserPropertyEMailLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserPropertyEMailLabel.GetAllParamsCount

function TkwEfUserPropertyEMailLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyEMailLabel.ParamsTypes

type
  TkwEfUserPropertyConfirmPasswordLabel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserProperty.ConfirmPasswordLabel
[panel]������� ConfirmPasswordLabel ����� TefUserProperty[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefUserProperty .TefUserProperty.ConfirmPasswordLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function ConfirmPasswordLabel(const aCtx: TtfwContext;
     aefUserProperty: TefUserProperty): TvtLabel;
     {* ���������� ����� ������� .TefUserProperty.ConfirmPasswordLabel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfUserPropertyConfirmPasswordLabel

// start class TkwEfUserPropertyConfirmPasswordLabel

function TkwEfUserPropertyConfirmPasswordLabel.ConfirmPasswordLabel(const aCtx: TtfwContext;
  aefUserProperty: TefUserProperty): TvtLabel;
 {-}
begin
 Result := aefUserProperty.ConfirmPasswordLabel;
end;//TkwEfUserPropertyConfirmPasswordLabel.ConfirmPasswordLabel

procedure TkwEfUserPropertyConfirmPasswordLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserProperty : TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ConfirmPasswordLabel(aCtx, l_aefUserProperty)));
end;//TkwEfUserPropertyConfirmPasswordLabel.DoDoIt

class function TkwEfUserPropertyConfirmPasswordLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserProperty.ConfirmPasswordLabel';
end;//TkwEfUserPropertyConfirmPasswordLabel.GetWordNameForRegister

procedure TkwEfUserPropertyConfirmPasswordLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ConfirmPasswordLabel', aCtx);
end;//TkwEfUserPropertyConfirmPasswordLabel.SetValuePrim

function TkwEfUserPropertyConfirmPasswordLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfUserPropertyConfirmPasswordLabel.GetResultTypeInfo

function TkwEfUserPropertyConfirmPasswordLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserPropertyConfirmPasswordLabel.GetAllParamsCount

function TkwEfUserPropertyConfirmPasswordLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyConfirmPasswordLabel.ParamsTypes

type
  TkwEfUserPropertyGroupLabel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserProperty.GroupLabel
[panel]������� GroupLabel ����� TefUserProperty[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefUserProperty .TefUserProperty.GroupLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function GroupLabel(const aCtx: TtfwContext;
     aefUserProperty: TefUserProperty): TvtLabel;
     {* ���������� ����� ������� .TefUserProperty.GroupLabel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfUserPropertyGroupLabel

// start class TkwEfUserPropertyGroupLabel

function TkwEfUserPropertyGroupLabel.GroupLabel(const aCtx: TtfwContext;
  aefUserProperty: TefUserProperty): TvtLabel;
 {-}
begin
 Result := aefUserProperty.GroupLabel;
end;//TkwEfUserPropertyGroupLabel.GroupLabel

procedure TkwEfUserPropertyGroupLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserProperty : TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((GroupLabel(aCtx, l_aefUserProperty)));
end;//TkwEfUserPropertyGroupLabel.DoDoIt

class function TkwEfUserPropertyGroupLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserProperty.GroupLabel';
end;//TkwEfUserPropertyGroupLabel.GetWordNameForRegister

procedure TkwEfUserPropertyGroupLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� GroupLabel', aCtx);
end;//TkwEfUserPropertyGroupLabel.SetValuePrim

function TkwEfUserPropertyGroupLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfUserPropertyGroupLabel.GetResultTypeInfo

function TkwEfUserPropertyGroupLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserPropertyGroupLabel.GetAllParamsCount

function TkwEfUserPropertyGroupLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyGroupLabel.ParamsTypes

type
  TkwEfUserPropertyEdPassword = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserProperty.edPassword
[panel]������� edPassword ����� TefUserProperty[panel]
*��� ����������:* TnscComboBoxWithPwdChar
*������:*
[code]
OBJECT VAR l_TnscComboBoxWithPwdChar
 aefUserProperty .TefUserProperty.edPassword >>> l_TnscComboBoxWithPwdChar
[code]  }
  private
  // private methods
   function EdPassword(const aCtx: TtfwContext;
     aefUserProperty: TefUserProperty): TnscComboBoxWithPwdChar;
     {* ���������� ����� ������� .TefUserProperty.edPassword }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfUserPropertyEdPassword

// start class TkwEfUserPropertyEdPassword

function TkwEfUserPropertyEdPassword.EdPassword(const aCtx: TtfwContext;
  aefUserProperty: TefUserProperty): TnscComboBoxWithPwdChar;
 {-}
begin
 Result := aefUserProperty.edPassword;
end;//TkwEfUserPropertyEdPassword.EdPassword

procedure TkwEfUserPropertyEdPassword.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserProperty : TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EdPassword(aCtx, l_aefUserProperty)));
end;//TkwEfUserPropertyEdPassword.DoDoIt

class function TkwEfUserPropertyEdPassword.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserProperty.edPassword';
end;//TkwEfUserPropertyEdPassword.GetWordNameForRegister

procedure TkwEfUserPropertyEdPassword.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� edPassword', aCtx);
end;//TkwEfUserPropertyEdPassword.SetValuePrim

function TkwEfUserPropertyEdPassword.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscComboBoxWithPwdChar);
end;//TkwEfUserPropertyEdPassword.GetResultTypeInfo

function TkwEfUserPropertyEdPassword.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserPropertyEdPassword.GetAllParamsCount

function TkwEfUserPropertyEdPassword.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyEdPassword.ParamsTypes

type
  TkwEfUserPropertyEdUserName = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserProperty.edUserName
[panel]������� edUserName ����� TefUserProperty[panel]
*��� ����������:* TnscEdit
*������:*
[code]
OBJECT VAR l_TnscEdit
 aefUserProperty .TefUserProperty.edUserName >>> l_TnscEdit
[code]  }
  private
  // private methods
   function EdUserName(const aCtx: TtfwContext;
     aefUserProperty: TefUserProperty): TnscEdit;
     {* ���������� ����� ������� .TefUserProperty.edUserName }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfUserPropertyEdUserName

// start class TkwEfUserPropertyEdUserName

function TkwEfUserPropertyEdUserName.EdUserName(const aCtx: TtfwContext;
  aefUserProperty: TefUserProperty): TnscEdit;
 {-}
begin
 Result := aefUserProperty.edUserName;
end;//TkwEfUserPropertyEdUserName.EdUserName

procedure TkwEfUserPropertyEdUserName.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserProperty : TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EdUserName(aCtx, l_aefUserProperty)));
end;//TkwEfUserPropertyEdUserName.DoDoIt

class function TkwEfUserPropertyEdUserName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserProperty.edUserName';
end;//TkwEfUserPropertyEdUserName.GetWordNameForRegister

procedure TkwEfUserPropertyEdUserName.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� edUserName', aCtx);
end;//TkwEfUserPropertyEdUserName.SetValuePrim

function TkwEfUserPropertyEdUserName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEdit);
end;//TkwEfUserPropertyEdUserName.GetResultTypeInfo

function TkwEfUserPropertyEdUserName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserPropertyEdUserName.GetAllParamsCount

function TkwEfUserPropertyEdUserName.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyEdUserName.ParamsTypes

type
  TkwEfUserPropertyEdLogin = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserProperty.edLogin
[panel]������� edLogin ����� TefUserProperty[panel]
*��� ����������:* TnscEdit
*������:*
[code]
OBJECT VAR l_TnscEdit
 aefUserProperty .TefUserProperty.edLogin >>> l_TnscEdit
[code]  }
  private
  // private methods
   function EdLogin(const aCtx: TtfwContext;
     aefUserProperty: TefUserProperty): TnscEdit;
     {* ���������� ����� ������� .TefUserProperty.edLogin }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfUserPropertyEdLogin

// start class TkwEfUserPropertyEdLogin

function TkwEfUserPropertyEdLogin.EdLogin(const aCtx: TtfwContext;
  aefUserProperty: TefUserProperty): TnscEdit;
 {-}
begin
 Result := aefUserProperty.edLogin;
end;//TkwEfUserPropertyEdLogin.EdLogin

procedure TkwEfUserPropertyEdLogin.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserProperty : TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EdLogin(aCtx, l_aefUserProperty)));
end;//TkwEfUserPropertyEdLogin.DoDoIt

class function TkwEfUserPropertyEdLogin.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserProperty.edLogin';
end;//TkwEfUserPropertyEdLogin.GetWordNameForRegister

procedure TkwEfUserPropertyEdLogin.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� edLogin', aCtx);
end;//TkwEfUserPropertyEdLogin.SetValuePrim

function TkwEfUserPropertyEdLogin.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEdit);
end;//TkwEfUserPropertyEdLogin.GetResultTypeInfo

function TkwEfUserPropertyEdLogin.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserPropertyEdLogin.GetAllParamsCount

function TkwEfUserPropertyEdLogin.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyEdLogin.ParamsTypes

type
  TkwEfUserPropertyEdEmail = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserProperty.edEmail
[panel]������� edEmail ����� TefUserProperty[panel]
*��� ����������:* TnscEdit
*������:*
[code]
OBJECT VAR l_TnscEdit
 aefUserProperty .TefUserProperty.edEmail >>> l_TnscEdit
[code]  }
  private
  // private methods
   function EdEmail(const aCtx: TtfwContext;
     aefUserProperty: TefUserProperty): TnscEdit;
     {* ���������� ����� ������� .TefUserProperty.edEmail }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfUserPropertyEdEmail

// start class TkwEfUserPropertyEdEmail

function TkwEfUserPropertyEdEmail.EdEmail(const aCtx: TtfwContext;
  aefUserProperty: TefUserProperty): TnscEdit;
 {-}
begin
 Result := aefUserProperty.edEmail;
end;//TkwEfUserPropertyEdEmail.EdEmail

procedure TkwEfUserPropertyEdEmail.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserProperty : TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EdEmail(aCtx, l_aefUserProperty)));
end;//TkwEfUserPropertyEdEmail.DoDoIt

class function TkwEfUserPropertyEdEmail.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserProperty.edEmail';
end;//TkwEfUserPropertyEdEmail.GetWordNameForRegister

procedure TkwEfUserPropertyEdEmail.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� edEmail', aCtx);
end;//TkwEfUserPropertyEdEmail.SetValuePrim

function TkwEfUserPropertyEdEmail.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEdit);
end;//TkwEfUserPropertyEdEmail.GetResultTypeInfo

function TkwEfUserPropertyEdEmail.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserPropertyEdEmail.GetAllParamsCount

function TkwEfUserPropertyEdEmail.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyEdEmail.ParamsTypes

type
  TkwEfUserPropertyEdConfirm = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserProperty.edConfirm
[panel]������� edConfirm ����� TefUserProperty[panel]
*��� ����������:* TnscComboBoxWithPwdChar
*������:*
[code]
OBJECT VAR l_TnscComboBoxWithPwdChar
 aefUserProperty .TefUserProperty.edConfirm >>> l_TnscComboBoxWithPwdChar
[code]  }
  private
  // private methods
   function EdConfirm(const aCtx: TtfwContext;
     aefUserProperty: TefUserProperty): TnscComboBoxWithPwdChar;
     {* ���������� ����� ������� .TefUserProperty.edConfirm }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfUserPropertyEdConfirm

// start class TkwEfUserPropertyEdConfirm

function TkwEfUserPropertyEdConfirm.EdConfirm(const aCtx: TtfwContext;
  aefUserProperty: TefUserProperty): TnscComboBoxWithPwdChar;
 {-}
begin
 Result := aefUserProperty.edConfirm;
end;//TkwEfUserPropertyEdConfirm.EdConfirm

procedure TkwEfUserPropertyEdConfirm.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserProperty : TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EdConfirm(aCtx, l_aefUserProperty)));
end;//TkwEfUserPropertyEdConfirm.DoDoIt

class function TkwEfUserPropertyEdConfirm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserProperty.edConfirm';
end;//TkwEfUserPropertyEdConfirm.GetWordNameForRegister

procedure TkwEfUserPropertyEdConfirm.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� edConfirm', aCtx);
end;//TkwEfUserPropertyEdConfirm.SetValuePrim

function TkwEfUserPropertyEdConfirm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscComboBoxWithPwdChar);
end;//TkwEfUserPropertyEdConfirm.GetResultTypeInfo

function TkwEfUserPropertyEdConfirm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserPropertyEdConfirm.GetAllParamsCount

function TkwEfUserPropertyEdConfirm.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyEdConfirm.ParamsTypes

type
  TkwEfUserPropertyEdGroup = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserProperty.edGroup
[panel]������� edGroup ����� TefUserProperty[panel]
*��� ����������:* TvtComboBoxQS
*������:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aefUserProperty .TefUserProperty.edGroup >>> l_TvtComboBoxQS
[code]  }
  private
  // private methods
   function EdGroup(const aCtx: TtfwContext;
     aefUserProperty: TefUserProperty): TvtComboBoxQS;
     {* ���������� ����� ������� .TefUserProperty.edGroup }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfUserPropertyEdGroup

// start class TkwEfUserPropertyEdGroup

function TkwEfUserPropertyEdGroup.EdGroup(const aCtx: TtfwContext;
  aefUserProperty: TefUserProperty): TvtComboBoxQS;
 {-}
begin
 Result := aefUserProperty.edGroup;
end;//TkwEfUserPropertyEdGroup.EdGroup

procedure TkwEfUserPropertyEdGroup.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserProperty : TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EdGroup(aCtx, l_aefUserProperty)));
end;//TkwEfUserPropertyEdGroup.DoDoIt

class function TkwEfUserPropertyEdGroup.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserProperty.edGroup';
end;//TkwEfUserPropertyEdGroup.GetWordNameForRegister

procedure TkwEfUserPropertyEdGroup.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� edGroup', aCtx);
end;//TkwEfUserPropertyEdGroup.SetValuePrim

function TkwEfUserPropertyEdGroup.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtComboBoxQS);
end;//TkwEfUserPropertyEdGroup.GetResultTypeInfo

function TkwEfUserPropertyEdGroup.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserPropertyEdGroup.GetAllParamsCount

function TkwEfUserPropertyEdGroup.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyEdGroup.ParamsTypes

type
  TkwEfUserPropertyFMiddlePanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserProperty.f_MiddlePanel
[panel]������� f_MiddlePanel ����� TefUserProperty[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aefUserProperty .TefUserProperty.f_MiddlePanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function FMiddlePanel(const aCtx: TtfwContext;
     aefUserProperty: TefUserProperty): TvtPanel;
     {* ���������� ����� ������� .TefUserProperty.f_MiddlePanel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfUserPropertyFMiddlePanel

// start class TkwEfUserPropertyFMiddlePanel

function TkwEfUserPropertyFMiddlePanel.FMiddlePanel(const aCtx: TtfwContext;
  aefUserProperty: TefUserProperty): TvtPanel;
 {-}
begin
 Result := aefUserProperty.f_MiddlePanel;
end;//TkwEfUserPropertyFMiddlePanel.FMiddlePanel

procedure TkwEfUserPropertyFMiddlePanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserProperty : TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FMiddlePanel(aCtx, l_aefUserProperty)));
end;//TkwEfUserPropertyFMiddlePanel.DoDoIt

class function TkwEfUserPropertyFMiddlePanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserProperty.f_MiddlePanel';
end;//TkwEfUserPropertyFMiddlePanel.GetWordNameForRegister

procedure TkwEfUserPropertyFMiddlePanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� f_MiddlePanel', aCtx);
end;//TkwEfUserPropertyFMiddlePanel.SetValuePrim

function TkwEfUserPropertyFMiddlePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfUserPropertyFMiddlePanel.GetResultTypeInfo

function TkwEfUserPropertyFMiddlePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserPropertyFMiddlePanel.GetAllParamsCount

function TkwEfUserPropertyFMiddlePanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyFMiddlePanel.ParamsTypes

type
  TkwEfUserPropertyEdPrivilegedUser = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserProperty.edPrivilegedUser
[panel]������� edPrivilegedUser ����� TefUserProperty[panel]
*��� ����������:* TvtCheckBox
*������:*
[code]
OBJECT VAR l_TvtCheckBox
 aefUserProperty .TefUserProperty.edPrivilegedUser >>> l_TvtCheckBox
[code]  }
  private
  // private methods
   function EdPrivilegedUser(const aCtx: TtfwContext;
     aefUserProperty: TefUserProperty): TvtCheckBox;
     {* ���������� ����� ������� .TefUserProperty.edPrivilegedUser }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfUserPropertyEdPrivilegedUser

// start class TkwEfUserPropertyEdPrivilegedUser

function TkwEfUserPropertyEdPrivilegedUser.EdPrivilegedUser(const aCtx: TtfwContext;
  aefUserProperty: TefUserProperty): TvtCheckBox;
 {-}
begin
 Result := aefUserProperty.edPrivilegedUser;
end;//TkwEfUserPropertyEdPrivilegedUser.EdPrivilegedUser

procedure TkwEfUserPropertyEdPrivilegedUser.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserProperty : TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EdPrivilegedUser(aCtx, l_aefUserProperty)));
end;//TkwEfUserPropertyEdPrivilegedUser.DoDoIt

class function TkwEfUserPropertyEdPrivilegedUser.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserProperty.edPrivilegedUser';
end;//TkwEfUserPropertyEdPrivilegedUser.GetWordNameForRegister

procedure TkwEfUserPropertyEdPrivilegedUser.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� edPrivilegedUser', aCtx);
end;//TkwEfUserPropertyEdPrivilegedUser.SetValuePrim

function TkwEfUserPropertyEdPrivilegedUser.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwEfUserPropertyEdPrivilegedUser.GetResultTypeInfo

function TkwEfUserPropertyEdPrivilegedUser.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserPropertyEdPrivilegedUser.GetAllParamsCount

function TkwEfUserPropertyEdPrivilegedUser.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyEdPrivilegedUser.ParamsTypes

type
  TkwEfUserPropertyEdBuyConsulting = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserProperty.edBuyConsulting
[panel]������� edBuyConsulting ����� TefUserProperty[panel]
*��� ����������:* TvtCheckBox
*������:*
[code]
OBJECT VAR l_TvtCheckBox
 aefUserProperty .TefUserProperty.edBuyConsulting >>> l_TvtCheckBox
[code]  }
  private
  // private methods
   function EdBuyConsulting(const aCtx: TtfwContext;
     aefUserProperty: TefUserProperty): TvtCheckBox;
     {* ���������� ����� ������� .TefUserProperty.edBuyConsulting }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfUserPropertyEdBuyConsulting

// start class TkwEfUserPropertyEdBuyConsulting

function TkwEfUserPropertyEdBuyConsulting.EdBuyConsulting(const aCtx: TtfwContext;
  aefUserProperty: TefUserProperty): TvtCheckBox;
 {-}
begin
 Result := aefUserProperty.edBuyConsulting;
end;//TkwEfUserPropertyEdBuyConsulting.EdBuyConsulting

procedure TkwEfUserPropertyEdBuyConsulting.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserProperty : TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EdBuyConsulting(aCtx, l_aefUserProperty)));
end;//TkwEfUserPropertyEdBuyConsulting.DoDoIt

class function TkwEfUserPropertyEdBuyConsulting.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserProperty.edBuyConsulting';
end;//TkwEfUserPropertyEdBuyConsulting.GetWordNameForRegister

procedure TkwEfUserPropertyEdBuyConsulting.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� edBuyConsulting', aCtx);
end;//TkwEfUserPropertyEdBuyConsulting.SetValuePrim

function TkwEfUserPropertyEdBuyConsulting.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwEfUserPropertyEdBuyConsulting.GetResultTypeInfo

function TkwEfUserPropertyEdBuyConsulting.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserPropertyEdBuyConsulting.GetAllParamsCount

function TkwEfUserPropertyEdBuyConsulting.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyEdBuyConsulting.ParamsTypes

type
  TkwEfUserPropertyFDontDeleteIdleUserPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserProperty.f_DontDeleteIdleUserPanel
[panel]������� f_DontDeleteIdleUserPanel ����� TefUserProperty[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aefUserProperty .TefUserProperty.f_DontDeleteIdleUserPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function FDontDeleteIdleUserPanel(const aCtx: TtfwContext;
     aefUserProperty: TefUserProperty): TvtPanel;
     {* ���������� ����� ������� .TefUserProperty.f_DontDeleteIdleUserPanel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfUserPropertyFDontDeleteIdleUserPanel

// start class TkwEfUserPropertyFDontDeleteIdleUserPanel

function TkwEfUserPropertyFDontDeleteIdleUserPanel.FDontDeleteIdleUserPanel(const aCtx: TtfwContext;
  aefUserProperty: TefUserProperty): TvtPanel;
 {-}
begin
 Result := aefUserProperty.f_DontDeleteIdleUserPanel;
end;//TkwEfUserPropertyFDontDeleteIdleUserPanel.FDontDeleteIdleUserPanel

procedure TkwEfUserPropertyFDontDeleteIdleUserPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserProperty : TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FDontDeleteIdleUserPanel(aCtx, l_aefUserProperty)));
end;//TkwEfUserPropertyFDontDeleteIdleUserPanel.DoDoIt

class function TkwEfUserPropertyFDontDeleteIdleUserPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserProperty.f_DontDeleteIdleUserPanel';
end;//TkwEfUserPropertyFDontDeleteIdleUserPanel.GetWordNameForRegister

procedure TkwEfUserPropertyFDontDeleteIdleUserPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� f_DontDeleteIdleUserPanel', aCtx);
end;//TkwEfUserPropertyFDontDeleteIdleUserPanel.SetValuePrim

function TkwEfUserPropertyFDontDeleteIdleUserPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfUserPropertyFDontDeleteIdleUserPanel.GetResultTypeInfo

function TkwEfUserPropertyFDontDeleteIdleUserPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserPropertyFDontDeleteIdleUserPanel.GetAllParamsCount

function TkwEfUserPropertyFDontDeleteIdleUserPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyFDontDeleteIdleUserPanel.ParamsTypes

type
  TkwEfUserPropertyEdDontDeleteIdleUser = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserProperty.edDontDeleteIdleUser
[panel]������� edDontDeleteIdleUser ����� TefUserProperty[panel]
*��� ����������:* TvtCheckBox
*������:*
[code]
OBJECT VAR l_TvtCheckBox
 aefUserProperty .TefUserProperty.edDontDeleteIdleUser >>> l_TvtCheckBox
[code]  }
  private
  // private methods
   function EdDontDeleteIdleUser(const aCtx: TtfwContext;
     aefUserProperty: TefUserProperty): TvtCheckBox;
     {* ���������� ����� ������� .TefUserProperty.edDontDeleteIdleUser }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfUserPropertyEdDontDeleteIdleUser

// start class TkwEfUserPropertyEdDontDeleteIdleUser

function TkwEfUserPropertyEdDontDeleteIdleUser.EdDontDeleteIdleUser(const aCtx: TtfwContext;
  aefUserProperty: TefUserProperty): TvtCheckBox;
 {-}
begin
 Result := aefUserProperty.edDontDeleteIdleUser;
end;//TkwEfUserPropertyEdDontDeleteIdleUser.EdDontDeleteIdleUser

procedure TkwEfUserPropertyEdDontDeleteIdleUser.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserProperty : TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EdDontDeleteIdleUser(aCtx, l_aefUserProperty)));
end;//TkwEfUserPropertyEdDontDeleteIdleUser.DoDoIt

class function TkwEfUserPropertyEdDontDeleteIdleUser.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserProperty.edDontDeleteIdleUser';
end;//TkwEfUserPropertyEdDontDeleteIdleUser.GetWordNameForRegister

procedure TkwEfUserPropertyEdDontDeleteIdleUser.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� edDontDeleteIdleUser', aCtx);
end;//TkwEfUserPropertyEdDontDeleteIdleUser.SetValuePrim

function TkwEfUserPropertyEdDontDeleteIdleUser.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwEfUserPropertyEdDontDeleteIdleUser.GetResultTypeInfo

function TkwEfUserPropertyEdDontDeleteIdleUser.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserPropertyEdDontDeleteIdleUser.GetAllParamsCount

function TkwEfUserPropertyEdDontDeleteIdleUser.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyEdDontDeleteIdleUser.ParamsTypes

type
  TkwEfUserPropertyFBottomPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserProperty.f_BottomPanel
[panel]������� f_BottomPanel ����� TefUserProperty[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aefUserProperty .TefUserProperty.f_BottomPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function FBottomPanel(const aCtx: TtfwContext;
     aefUserProperty: TefUserProperty): TvtPanel;
     {* ���������� ����� ������� .TefUserProperty.f_BottomPanel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfUserPropertyFBottomPanel

// start class TkwEfUserPropertyFBottomPanel

function TkwEfUserPropertyFBottomPanel.FBottomPanel(const aCtx: TtfwContext;
  aefUserProperty: TefUserProperty): TvtPanel;
 {-}
begin
 Result := aefUserProperty.f_BottomPanel;
end;//TkwEfUserPropertyFBottomPanel.FBottomPanel

procedure TkwEfUserPropertyFBottomPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserProperty : TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FBottomPanel(aCtx, l_aefUserProperty)));
end;//TkwEfUserPropertyFBottomPanel.DoDoIt

class function TkwEfUserPropertyFBottomPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserProperty.f_BottomPanel';
end;//TkwEfUserPropertyFBottomPanel.GetWordNameForRegister

procedure TkwEfUserPropertyFBottomPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� f_BottomPanel', aCtx);
end;//TkwEfUserPropertyFBottomPanel.SetValuePrim

function TkwEfUserPropertyFBottomPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfUserPropertyFBottomPanel.GetResultTypeInfo

function TkwEfUserPropertyFBottomPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserPropertyFBottomPanel.GetAllParamsCount

function TkwEfUserPropertyFBottomPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyFBottomPanel.ParamsTypes

type
  TkwEfUserPropertyInfoLabel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserProperty.InfoLabel
[panel]������� InfoLabel ����� TefUserProperty[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefUserProperty .TefUserProperty.InfoLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function InfoLabel(const aCtx: TtfwContext;
     aefUserProperty: TefUserProperty): TvtLabel;
     {* ���������� ����� ������� .TefUserProperty.InfoLabel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfUserPropertyInfoLabel

// start class TkwEfUserPropertyInfoLabel

function TkwEfUserPropertyInfoLabel.InfoLabel(const aCtx: TtfwContext;
  aefUserProperty: TefUserProperty): TvtLabel;
 {-}
begin
 Result := aefUserProperty.InfoLabel;
end;//TkwEfUserPropertyInfoLabel.InfoLabel

procedure TkwEfUserPropertyInfoLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserProperty : TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((InfoLabel(aCtx, l_aefUserProperty)));
end;//TkwEfUserPropertyInfoLabel.DoDoIt

class function TkwEfUserPropertyInfoLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserProperty.InfoLabel';
end;//TkwEfUserPropertyInfoLabel.GetWordNameForRegister

procedure TkwEfUserPropertyInfoLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� InfoLabel', aCtx);
end;//TkwEfUserPropertyInfoLabel.SetValuePrim

function TkwEfUserPropertyInfoLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfUserPropertyInfoLabel.GetResultTypeInfo

function TkwEfUserPropertyInfoLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserPropertyInfoLabel.GetAllParamsCount

function TkwEfUserPropertyInfoLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyInfoLabel.ParamsTypes

type
  TkwEfUserPropertyEdHasSharedFilters = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserProperty.edHasSharedFilters
[panel]������� edHasSharedFilters ����� TefUserProperty[panel]
*��� ����������:* TvtCheckBox
*������:*
[code]
OBJECT VAR l_TvtCheckBox
 aefUserProperty .TefUserProperty.edHasSharedFilters >>> l_TvtCheckBox
[code]  }
  private
  // private methods
   function EdHasSharedFilters(const aCtx: TtfwContext;
     aefUserProperty: TefUserProperty): TvtCheckBox;
     {* ���������� ����� ������� .TefUserProperty.edHasSharedFilters }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfUserPropertyEdHasSharedFilters

// start class TkwEfUserPropertyEdHasSharedFilters

function TkwEfUserPropertyEdHasSharedFilters.EdHasSharedFilters(const aCtx: TtfwContext;
  aefUserProperty: TefUserProperty): TvtCheckBox;
 {-}
begin
 Result := aefUserProperty.edHasSharedFilters;
end;//TkwEfUserPropertyEdHasSharedFilters.EdHasSharedFilters

procedure TkwEfUserPropertyEdHasSharedFilters.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserProperty : TefUserProperty;
begin
 try
  l_aefUserProperty := TefUserProperty(aCtx.rEngine.PopObjAs(TefUserProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserProperty: TefUserProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EdHasSharedFilters(aCtx, l_aefUserProperty)));
end;//TkwEfUserPropertyEdHasSharedFilters.DoDoIt

class function TkwEfUserPropertyEdHasSharedFilters.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserProperty.edHasSharedFilters';
end;//TkwEfUserPropertyEdHasSharedFilters.GetWordNameForRegister

procedure TkwEfUserPropertyEdHasSharedFilters.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� edHasSharedFilters', aCtx);
end;//TkwEfUserPropertyEdHasSharedFilters.SetValuePrim

function TkwEfUserPropertyEdHasSharedFilters.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwEfUserPropertyEdHasSharedFilters.GetResultTypeInfo

function TkwEfUserPropertyEdHasSharedFilters.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserPropertyEdHasSharedFilters.GetAllParamsCount

function TkwEfUserPropertyEdHasSharedFilters.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserProperty)]);
end;//TkwEfUserPropertyEdHasSharedFilters.ParamsTypes
{$IfEnd} //Admin AND not NoScripts

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_Form_UserProperty
 Tkw_Form_UserProperty.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_pnMainData
 Tkw_UserProperty_Control_pnMainData.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_pnMainData_Push
 Tkw_UserProperty_Control_pnMainData_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_f_TopPanel
 Tkw_UserProperty_Control_f_TopPanel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_f_TopPanel_Push
 Tkw_UserProperty_Control_f_TopPanel_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_UserNameLabel
 Tkw_UserProperty_Control_UserNameLabel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_UserNameLabel_Push
 Tkw_UserProperty_Control_UserNameLabel_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_PasswordLabel
 Tkw_UserProperty_Control_PasswordLabel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_PasswordLabel_Push
 Tkw_UserProperty_Control_PasswordLabel_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_LoginLabel
 Tkw_UserProperty_Control_LoginLabel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_LoginLabel_Push
 Tkw_UserProperty_Control_LoginLabel_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_EMailLabel
 Tkw_UserProperty_Control_EMailLabel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_EMailLabel_Push
 Tkw_UserProperty_Control_EMailLabel_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_ConfirmPasswordLabel
 Tkw_UserProperty_Control_ConfirmPasswordLabel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_ConfirmPasswordLabel_Push
 Tkw_UserProperty_Control_ConfirmPasswordLabel_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_GroupLabel
 Tkw_UserProperty_Control_GroupLabel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_GroupLabel_Push
 Tkw_UserProperty_Control_GroupLabel_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_edPassword
 Tkw_UserProperty_Control_edPassword.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_edPassword_Push
 Tkw_UserProperty_Control_edPassword_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_edUserName
 Tkw_UserProperty_Control_edUserName.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_edUserName_Push
 Tkw_UserProperty_Control_edUserName_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_edLogin
 Tkw_UserProperty_Control_edLogin.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_edLogin_Push
 Tkw_UserProperty_Control_edLogin_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_edEmail
 Tkw_UserProperty_Control_edEmail.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_edEmail_Push
 Tkw_UserProperty_Control_edEmail_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_edConfirm
 Tkw_UserProperty_Control_edConfirm.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_edConfirm_Push
 Tkw_UserProperty_Control_edConfirm_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_edGroup
 Tkw_UserProperty_Control_edGroup.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_edGroup_Push
 Tkw_UserProperty_Control_edGroup_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_f_MiddlePanel
 Tkw_UserProperty_Control_f_MiddlePanel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_f_MiddlePanel_Push
 Tkw_UserProperty_Control_f_MiddlePanel_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_edPrivilegedUser
 Tkw_UserProperty_Control_edPrivilegedUser.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_edPrivilegedUser_Push
 Tkw_UserProperty_Control_edPrivilegedUser_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_edBuyConsulting
 Tkw_UserProperty_Control_edBuyConsulting.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_edBuyConsulting_Push
 Tkw_UserProperty_Control_edBuyConsulting_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel
 Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push
 Tkw_UserProperty_Control_f_DontDeleteIdleUserPanel_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_edDontDeleteIdleUser
 Tkw_UserProperty_Control_edDontDeleteIdleUser.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_edDontDeleteIdleUser_Push
 Tkw_UserProperty_Control_edDontDeleteIdleUser_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_f_BottomPanel
 Tkw_UserProperty_Control_f_BottomPanel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_f_BottomPanel_Push
 Tkw_UserProperty_Control_f_BottomPanel_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_InfoLabel
 Tkw_UserProperty_Control_InfoLabel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_InfoLabel_Push
 Tkw_UserProperty_Control_InfoLabel_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_edHasSharedFilters
 Tkw_UserProperty_Control_edHasSharedFilters.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserProperty_Control_edHasSharedFilters_Push
 Tkw_UserProperty_Control_edHasSharedFilters_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserProperty_pnMainData
 TkwEfUserPropertyPnMainData.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserProperty_f_TopPanel
 TkwEfUserPropertyFTopPanel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserProperty_UserNameLabel
 TkwEfUserPropertyUserNameLabel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserProperty_PasswordLabel
 TkwEfUserPropertyPasswordLabel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserProperty_LoginLabel
 TkwEfUserPropertyLoginLabel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserProperty_EMailLabel
 TkwEfUserPropertyEMailLabel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserProperty_ConfirmPasswordLabel
 TkwEfUserPropertyConfirmPasswordLabel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserProperty_GroupLabel
 TkwEfUserPropertyGroupLabel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserProperty_edPassword
 TkwEfUserPropertyEdPassword.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserProperty_edUserName
 TkwEfUserPropertyEdUserName.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserProperty_edLogin
 TkwEfUserPropertyEdLogin.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserProperty_edEmail
 TkwEfUserPropertyEdEmail.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserProperty_edConfirm
 TkwEfUserPropertyEdConfirm.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserProperty_edGroup
 TkwEfUserPropertyEdGroup.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserProperty_f_MiddlePanel
 TkwEfUserPropertyFMiddlePanel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserProperty_edPrivilegedUser
 TkwEfUserPropertyEdPrivilegedUser.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserProperty_edBuyConsulting
 TkwEfUserPropertyEdBuyConsulting.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserProperty_f_DontDeleteIdleUserPanel
 TkwEfUserPropertyFDontDeleteIdleUserPanel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserProperty_edDontDeleteIdleUser
 TkwEfUserPropertyEdDontDeleteIdleUser.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserProperty_f_BottomPanel
 TkwEfUserPropertyFBottomPanel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserProperty_InfoLabel
 TkwEfUserPropertyInfoLabel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserProperty_edHasSharedFilters
 TkwEfUserPropertyEdHasSharedFilters.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� ���� UserProperty
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefUserProperty));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TnscComboBoxWithPwdChar
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscComboBoxWithPwdChar));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TnscEdit
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEdit));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TvtComboBoxQS
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtComboBoxQS));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TvtCheckBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtCheckBox));
{$IfEnd} //Admin AND not NoScripts

end.
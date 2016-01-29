unit LoginKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimCommon/LoginKeywordsPack.pas"
// Начат: 21.08.2009 20:15
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Базовые определения предметной области::F1 Application Template::View::PrimCommon::PrimCommon::LoginKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы Login
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  vtPanel,
  Login_Form,
  vtFocusLabel,
  vtGroupBox
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtLabel
  {$If defined(Nemesis)}
  ,
  nscComboBoxWithReadOnly
  {$IfEnd} //Nemesis
  ,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  vtCheckBox,
  ElPopBtn,
  tfwPropertyLike
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_Login = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы Login
----
*Пример использования*:
[code]
'aControl' форма::Login TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_Login

// start class Tkw_Form_Login

class function Tkw_Form_Login.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::Login';
end;//Tkw_Form_Login.GetWordNameForRegister

function Tkw_Form_Login.GetString: AnsiString;
 {-}
begin
 Result := 'LoginForm';
end;//Tkw_Form_Login.GetString

type
  Tkw_Login_Control_RegisteredGroupBox = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола RegisteredGroupBox
----
*Пример использования*:
[code]
контрол::RegisteredGroupBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Login_Control_RegisteredGroupBox

// start class Tkw_Login_Control_RegisteredGroupBox

class function Tkw_Login_Control_RegisteredGroupBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RegisteredGroupBox';
end;//Tkw_Login_Control_RegisteredGroupBox.GetWordNameForRegister

function Tkw_Login_Control_RegisteredGroupBox.GetString: AnsiString;
 {-}
begin
 Result := 'RegisteredGroupBox';
end;//Tkw_Login_Control_RegisteredGroupBox.GetString

class procedure Tkw_Login_Control_RegisteredGroupBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_Login_Control_RegisteredGroupBox.RegisterInEngine

type
  Tkw_Login_Control_RegisteredGroupBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола RegisteredGroupBox
----
*Пример использования*:
[code]
контрол::RegisteredGroupBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Login_Control_RegisteredGroupBox_Push

// start class Tkw_Login_Control_RegisteredGroupBox_Push

procedure Tkw_Login_Control_RegisteredGroupBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('RegisteredGroupBox');
 inherited;
end;//Tkw_Login_Control_RegisteredGroupBox_Push.DoDoIt

class function Tkw_Login_Control_RegisteredGroupBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RegisteredGroupBox:push';
end;//Tkw_Login_Control_RegisteredGroupBox_Push.GetWordNameForRegister

type
  Tkw_Login_Control_lblLogin = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола lblLogin
----
*Пример использования*:
[code]
контрол::lblLogin TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Login_Control_lblLogin

// start class Tkw_Login_Control_lblLogin

class function Tkw_Login_Control_lblLogin.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblLogin';
end;//Tkw_Login_Control_lblLogin.GetWordNameForRegister

function Tkw_Login_Control_lblLogin.GetString: AnsiString;
 {-}
begin
 Result := 'lblLogin';
end;//Tkw_Login_Control_lblLogin.GetString

class procedure Tkw_Login_Control_lblLogin.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_Login_Control_lblLogin.RegisterInEngine

type
  Tkw_Login_Control_lblLogin_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола lblLogin
----
*Пример использования*:
[code]
контрол::lblLogin:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Login_Control_lblLogin_Push

// start class Tkw_Login_Control_lblLogin_Push

procedure Tkw_Login_Control_lblLogin_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lblLogin');
 inherited;
end;//Tkw_Login_Control_lblLogin_Push.DoDoIt

class function Tkw_Login_Control_lblLogin_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblLogin:push';
end;//Tkw_Login_Control_lblLogin_Push.GetWordNameForRegister

type
  Tkw_Login_Control_lblPassword = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола lblPassword
----
*Пример использования*:
[code]
контрол::lblPassword TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Login_Control_lblPassword

// start class Tkw_Login_Control_lblPassword

class function Tkw_Login_Control_lblPassword.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblPassword';
end;//Tkw_Login_Control_lblPassword.GetWordNameForRegister

function Tkw_Login_Control_lblPassword.GetString: AnsiString;
 {-}
begin
 Result := 'lblPassword';
end;//Tkw_Login_Control_lblPassword.GetString

class procedure Tkw_Login_Control_lblPassword.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_Login_Control_lblPassword.RegisterInEngine

type
  Tkw_Login_Control_lblPassword_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола lblPassword
----
*Пример использования*:
[code]
контрол::lblPassword:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Login_Control_lblPassword_Push

// start class Tkw_Login_Control_lblPassword_Push

procedure Tkw_Login_Control_lblPassword_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lblPassword');
 inherited;
end;//Tkw_Login_Control_lblPassword_Push.DoDoIt

class function Tkw_Login_Control_lblPassword_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblPassword:push';
end;//Tkw_Login_Control_lblPassword_Push.GetWordNameForRegister

type
  Tkw_Login_Control_EnterPaintBox = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола EnterPaintBox
----
*Пример использования*:
[code]
контрол::EnterPaintBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Login_Control_EnterPaintBox

// start class Tkw_Login_Control_EnterPaintBox

class function Tkw_Login_Control_EnterPaintBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::EnterPaintBox';
end;//Tkw_Login_Control_EnterPaintBox.GetWordNameForRegister

function Tkw_Login_Control_EnterPaintBox.GetString: AnsiString;
 {-}
begin
 Result := 'EnterPaintBox';
end;//Tkw_Login_Control_EnterPaintBox.GetString

class procedure Tkw_Login_Control_EnterPaintBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_Login_Control_EnterPaintBox.RegisterInEngine

type
  Tkw_Login_Control_EnterPaintBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола EnterPaintBox
----
*Пример использования*:
[code]
контрол::EnterPaintBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Login_Control_EnterPaintBox_Push

// start class Tkw_Login_Control_EnterPaintBox_Push

procedure Tkw_Login_Control_EnterPaintBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('EnterPaintBox');
 inherited;
end;//Tkw_Login_Control_EnterPaintBox_Push.DoDoIt

class function Tkw_Login_Control_EnterPaintBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::EnterPaintBox:push';
end;//Tkw_Login_Control_EnterPaintBox_Push.GetWordNameForRegister

type
  Tkw_Login_Control_edUserName = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола edUserName
----
*Пример использования*:
[code]
контрол::edUserName TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Login_Control_edUserName

// start class Tkw_Login_Control_edUserName

class function Tkw_Login_Control_edUserName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edUserName';
end;//Tkw_Login_Control_edUserName.GetWordNameForRegister

function Tkw_Login_Control_edUserName.GetString: AnsiString;
 {-}
begin
 Result := 'edUserName';
end;//Tkw_Login_Control_edUserName.GetString

class procedure Tkw_Login_Control_edUserName.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscComboBoxWithReadOnly);
end;//Tkw_Login_Control_edUserName.RegisterInEngine

type
  Tkw_Login_Control_edUserName_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола edUserName
----
*Пример использования*:
[code]
контрол::edUserName:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Login_Control_edUserName_Push

// start class Tkw_Login_Control_edUserName_Push

procedure Tkw_Login_Control_edUserName_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edUserName');
 inherited;
end;//Tkw_Login_Control_edUserName_Push.DoDoIt

class function Tkw_Login_Control_edUserName_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edUserName:push';
end;//Tkw_Login_Control_edUserName_Push.GetWordNameForRegister

type
  Tkw_Login_Control_edPassword = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола edPassword
----
*Пример использования*:
[code]
контрол::edPassword TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Login_Control_edPassword

// start class Tkw_Login_Control_edPassword

class function Tkw_Login_Control_edPassword.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edPassword';
end;//Tkw_Login_Control_edPassword.GetWordNameForRegister

function Tkw_Login_Control_edPassword.GetString: AnsiString;
 {-}
begin
 Result := 'edPassword';
end;//Tkw_Login_Control_edPassword.GetString

class procedure Tkw_Login_Control_edPassword.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscComboBoxWithPwdChar);
end;//Tkw_Login_Control_edPassword.RegisterInEngine

type
  Tkw_Login_Control_edPassword_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола edPassword
----
*Пример использования*:
[code]
контрол::edPassword:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Login_Control_edPassword_Push

// start class Tkw_Login_Control_edPassword_Push

procedure Tkw_Login_Control_edPassword_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edPassword');
 inherited;
end;//Tkw_Login_Control_edPassword_Push.DoDoIt

class function Tkw_Login_Control_edPassword_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edPassword:push';
end;//Tkw_Login_Control_edPassword_Push.GetWordNameForRegister

type
  Tkw_Login_Control_lblForgetPassword = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола lblForgetPassword
----
*Пример использования*:
[code]
контрол::lblForgetPassword TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Login_Control_lblForgetPassword

// start class Tkw_Login_Control_lblForgetPassword

class function Tkw_Login_Control_lblForgetPassword.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblForgetPassword';
end;//Tkw_Login_Control_lblForgetPassword.GetWordNameForRegister

function Tkw_Login_Control_lblForgetPassword.GetString: AnsiString;
 {-}
begin
 Result := 'lblForgetPassword';
end;//Tkw_Login_Control_lblForgetPassword.GetString

class procedure Tkw_Login_Control_lblForgetPassword.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtFocusLabel);
end;//Tkw_Login_Control_lblForgetPassword.RegisterInEngine

type
  Tkw_Login_Control_lblForgetPassword_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола lblForgetPassword
----
*Пример использования*:
[code]
контрол::lblForgetPassword:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Login_Control_lblForgetPassword_Push

// start class Tkw_Login_Control_lblForgetPassword_Push

procedure Tkw_Login_Control_lblForgetPassword_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lblForgetPassword');
 inherited;
end;//Tkw_Login_Control_lblForgetPassword_Push.DoDoIt

class function Tkw_Login_Control_lblForgetPassword_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblForgetPassword:push';
end;//Tkw_Login_Control_lblForgetPassword_Push.GetWordNameForRegister

type
  Tkw_Login_Control_cbAutoLogin = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола cbAutoLogin
----
*Пример использования*:
[code]
контрол::cbAutoLogin TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Login_Control_cbAutoLogin

// start class Tkw_Login_Control_cbAutoLogin

class function Tkw_Login_Control_cbAutoLogin.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::cbAutoLogin';
end;//Tkw_Login_Control_cbAutoLogin.GetWordNameForRegister

function Tkw_Login_Control_cbAutoLogin.GetString: AnsiString;
 {-}
begin
 Result := 'cbAutoLogin';
end;//Tkw_Login_Control_cbAutoLogin.GetString

class procedure Tkw_Login_Control_cbAutoLogin.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_Login_Control_cbAutoLogin.RegisterInEngine

type
  Tkw_Login_Control_cbAutoLogin_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола cbAutoLogin
----
*Пример использования*:
[code]
контрол::cbAutoLogin:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Login_Control_cbAutoLogin_Push

// start class Tkw_Login_Control_cbAutoLogin_Push

procedure Tkw_Login_Control_cbAutoLogin_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('cbAutoLogin');
 inherited;
end;//Tkw_Login_Control_cbAutoLogin_Push.DoDoIt

class function Tkw_Login_Control_cbAutoLogin_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::cbAutoLogin:push';
end;//Tkw_Login_Control_cbAutoLogin_Push.GetWordNameForRegister

type
  Tkw_Login_Control_btnOk = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола btnOk
----
*Пример использования*:
[code]
контрол::btnOk TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Login_Control_btnOk

// start class Tkw_Login_Control_btnOk

class function Tkw_Login_Control_btnOk.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::btnOk';
end;//Tkw_Login_Control_btnOk.GetWordNameForRegister

function Tkw_Login_Control_btnOk.GetString: AnsiString;
 {-}
begin
 Result := 'btnOk';
end;//Tkw_Login_Control_btnOk.GetString

class procedure Tkw_Login_Control_btnOk.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_Login_Control_btnOk.RegisterInEngine

type
  Tkw_Login_Control_btnOk_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола btnOk
----
*Пример использования*:
[code]
контрол::btnOk:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Login_Control_btnOk_Push

// start class Tkw_Login_Control_btnOk_Push

procedure Tkw_Login_Control_btnOk_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('btnOk');
 inherited;
end;//Tkw_Login_Control_btnOk_Push.DoDoIt

class function Tkw_Login_Control_btnOk_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::btnOk:push';
end;//Tkw_Login_Control_btnOk_Push.GetWordNameForRegister

type
  Tkw_Login_Control_NewUserGroupBox = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола NewUserGroupBox
----
*Пример использования*:
[code]
контрол::NewUserGroupBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Login_Control_NewUserGroupBox

// start class Tkw_Login_Control_NewUserGroupBox

class function Tkw_Login_Control_NewUserGroupBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::NewUserGroupBox';
end;//Tkw_Login_Control_NewUserGroupBox.GetWordNameForRegister

function Tkw_Login_Control_NewUserGroupBox.GetString: AnsiString;
 {-}
begin
 Result := 'NewUserGroupBox';
end;//Tkw_Login_Control_NewUserGroupBox.GetString

class procedure Tkw_Login_Control_NewUserGroupBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_Login_Control_NewUserGroupBox.RegisterInEngine

type
  Tkw_Login_Control_NewUserGroupBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола NewUserGroupBox
----
*Пример использования*:
[code]
контрол::NewUserGroupBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Login_Control_NewUserGroupBox_Push

// start class Tkw_Login_Control_NewUserGroupBox_Push

procedure Tkw_Login_Control_NewUserGroupBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('NewUserGroupBox');
 inherited;
end;//Tkw_Login_Control_NewUserGroupBox_Push.DoDoIt

class function Tkw_Login_Control_NewUserGroupBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::NewUserGroupBox:push';
end;//Tkw_Login_Control_NewUserGroupBox_Push.GetWordNameForRegister

type
  Tkw_Login_Control_NewUserLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола NewUserLabel
----
*Пример использования*:
[code]
контрол::NewUserLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Login_Control_NewUserLabel

// start class Tkw_Login_Control_NewUserLabel

class function Tkw_Login_Control_NewUserLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::NewUserLabel';
end;//Tkw_Login_Control_NewUserLabel.GetWordNameForRegister

function Tkw_Login_Control_NewUserLabel.GetString: AnsiString;
 {-}
begin
 Result := 'NewUserLabel';
end;//Tkw_Login_Control_NewUserLabel.GetString

class procedure Tkw_Login_Control_NewUserLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_Login_Control_NewUserLabel.RegisterInEngine

type
  Tkw_Login_Control_NewUserLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола NewUserLabel
----
*Пример использования*:
[code]
контрол::NewUserLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Login_Control_NewUserLabel_Push

// start class Tkw_Login_Control_NewUserLabel_Push

procedure Tkw_Login_Control_NewUserLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('NewUserLabel');
 inherited;
end;//Tkw_Login_Control_NewUserLabel_Push.DoDoIt

class function Tkw_Login_Control_NewUserLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::NewUserLabel:push';
end;//Tkw_Login_Control_NewUserLabel_Push.GetWordNameForRegister

type
  Tkw_Login_Control_NewUserPaintBox = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола NewUserPaintBox
----
*Пример использования*:
[code]
контрол::NewUserPaintBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Login_Control_NewUserPaintBox

// start class Tkw_Login_Control_NewUserPaintBox

class function Tkw_Login_Control_NewUserPaintBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::NewUserPaintBox';
end;//Tkw_Login_Control_NewUserPaintBox.GetWordNameForRegister

function Tkw_Login_Control_NewUserPaintBox.GetString: AnsiString;
 {-}
begin
 Result := 'NewUserPaintBox';
end;//Tkw_Login_Control_NewUserPaintBox.GetString

class procedure Tkw_Login_Control_NewUserPaintBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_Login_Control_NewUserPaintBox.RegisterInEngine

type
  Tkw_Login_Control_NewUserPaintBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола NewUserPaintBox
----
*Пример использования*:
[code]
контрол::NewUserPaintBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Login_Control_NewUserPaintBox_Push

// start class Tkw_Login_Control_NewUserPaintBox_Push

procedure Tkw_Login_Control_NewUserPaintBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('NewUserPaintBox');
 inherited;
end;//Tkw_Login_Control_NewUserPaintBox_Push.DoDoIt

class function Tkw_Login_Control_NewUserPaintBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::NewUserPaintBox:push';
end;//Tkw_Login_Control_NewUserPaintBox_Push.GetWordNameForRegister

type
  Tkw_Login_Control_lblNewUser = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола lblNewUser
----
*Пример использования*:
[code]
контрол::lblNewUser TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Login_Control_lblNewUser

// start class Tkw_Login_Control_lblNewUser

class function Tkw_Login_Control_lblNewUser.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblNewUser';
end;//Tkw_Login_Control_lblNewUser.GetWordNameForRegister

function Tkw_Login_Control_lblNewUser.GetString: AnsiString;
 {-}
begin
 Result := 'lblNewUser';
end;//Tkw_Login_Control_lblNewUser.GetString

class procedure Tkw_Login_Control_lblNewUser.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtFocusLabel);
end;//Tkw_Login_Control_lblNewUser.RegisterInEngine

type
  Tkw_Login_Control_lblNewUser_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола lblNewUser
----
*Пример использования*:
[code]
контрол::lblNewUser:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Login_Control_lblNewUser_Push

// start class Tkw_Login_Control_lblNewUser_Push

procedure Tkw_Login_Control_lblNewUser_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lblNewUser');
 inherited;
end;//Tkw_Login_Control_lblNewUser_Push.DoDoIt

class function Tkw_Login_Control_lblNewUser_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblNewUser:push';
end;//Tkw_Login_Control_lblNewUser_Push.GetWordNameForRegister

type
  Tkw_Login_Control_HelpPanel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола HelpPanel
----
*Пример использования*:
[code]
контрол::HelpPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Login_Control_HelpPanel

// start class Tkw_Login_Control_HelpPanel

class function Tkw_Login_Control_HelpPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::HelpPanel';
end;//Tkw_Login_Control_HelpPanel.GetWordNameForRegister

function Tkw_Login_Control_HelpPanel.GetString: AnsiString;
 {-}
begin
 Result := 'HelpPanel';
end;//Tkw_Login_Control_HelpPanel.GetString

class procedure Tkw_Login_Control_HelpPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Login_Control_HelpPanel.RegisterInEngine

type
  Tkw_Login_Control_HelpPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола HelpPanel
----
*Пример использования*:
[code]
контрол::HelpPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Login_Control_HelpPanel_Push

// start class Tkw_Login_Control_HelpPanel_Push

procedure Tkw_Login_Control_HelpPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('HelpPanel');
 inherited;
end;//Tkw_Login_Control_HelpPanel_Push.DoDoIt

class function Tkw_Login_Control_HelpPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::HelpPanel:push';
end;//Tkw_Login_Control_HelpPanel_Push.GetWordNameForRegister

type
  Tkw_Login_Control_HelpPaintBox = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола HelpPaintBox
----
*Пример использования*:
[code]
контрол::HelpPaintBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Login_Control_HelpPaintBox

// start class Tkw_Login_Control_HelpPaintBox

class function Tkw_Login_Control_HelpPaintBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::HelpPaintBox';
end;//Tkw_Login_Control_HelpPaintBox.GetWordNameForRegister

function Tkw_Login_Control_HelpPaintBox.GetString: AnsiString;
 {-}
begin
 Result := 'HelpPaintBox';
end;//Tkw_Login_Control_HelpPaintBox.GetString

class procedure Tkw_Login_Control_HelpPaintBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_Login_Control_HelpPaintBox.RegisterInEngine

type
  Tkw_Login_Control_HelpPaintBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола HelpPaintBox
----
*Пример использования*:
[code]
контрол::HelpPaintBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Login_Control_HelpPaintBox_Push

// start class Tkw_Login_Control_HelpPaintBox_Push

procedure Tkw_Login_Control_HelpPaintBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('HelpPaintBox');
 inherited;
end;//Tkw_Login_Control_HelpPaintBox_Push.DoDoIt

class function Tkw_Login_Control_HelpPaintBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::HelpPaintBox:push';
end;//Tkw_Login_Control_HelpPaintBox_Push.GetWordNameForRegister

type
  Tkw_Login_Control_HelpLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола HelpLabel
----
*Пример использования*:
[code]
контрол::HelpLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Login_Control_HelpLabel

// start class Tkw_Login_Control_HelpLabel

class function Tkw_Login_Control_HelpLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::HelpLabel';
end;//Tkw_Login_Control_HelpLabel.GetWordNameForRegister

function Tkw_Login_Control_HelpLabel.GetString: AnsiString;
 {-}
begin
 Result := 'HelpLabel';
end;//Tkw_Login_Control_HelpLabel.GetString

class procedure Tkw_Login_Control_HelpLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtFocusLabel);
end;//Tkw_Login_Control_HelpLabel.RegisterInEngine

type
  Tkw_Login_Control_HelpLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола HelpLabel
----
*Пример использования*:
[code]
контрол::HelpLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Login_Control_HelpLabel_Push

// start class Tkw_Login_Control_HelpLabel_Push

procedure Tkw_Login_Control_HelpLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('HelpLabel');
 inherited;
end;//Tkw_Login_Control_HelpLabel_Push.DoDoIt

class function Tkw_Login_Control_HelpLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::HelpLabel:push';
end;//Tkw_Login_Control_HelpLabel_Push.GetWordNameForRegister

type
  TkwLoginFormRegisteredGroupBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TLoginForm.RegisteredGroupBox
[panel]Контрол RegisteredGroupBox формы TLoginForm[panel]
*Тип результата:* TvtGroupBox
*Пример:*
[code]
OBJECT VAR l_TvtGroupBox
 aLoginForm .TLoginForm.RegisteredGroupBox >>> l_TvtGroupBox
[code]  }
  private
  // private methods
   function RegisteredGroupBox(const aCtx: TtfwContext;
     aLoginForm: TLoginForm): TvtGroupBox;
     {* Реализация слова скрипта .TLoginForm.RegisteredGroupBox }
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
  end;//TkwLoginFormRegisteredGroupBox

// start class TkwLoginFormRegisteredGroupBox

function TkwLoginFormRegisteredGroupBox.RegisteredGroupBox(const aCtx: TtfwContext;
  aLoginForm: TLoginForm): TvtGroupBox;
 {-}
begin
 Result := aLoginForm.RegisteredGroupBox;
end;//TkwLoginFormRegisteredGroupBox.RegisteredGroupBox

procedure TkwLoginFormRegisteredGroupBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLoginForm : TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RegisteredGroupBox(aCtx, l_aLoginForm)));
end;//TkwLoginFormRegisteredGroupBox.DoDoIt

class function TkwLoginFormRegisteredGroupBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLoginForm.RegisteredGroupBox';
end;//TkwLoginFormRegisteredGroupBox.GetWordNameForRegister

procedure TkwLoginFormRegisteredGroupBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству RegisteredGroupBox', aCtx);
end;//TkwLoginFormRegisteredGroupBox.SetValuePrim

function TkwLoginFormRegisteredGroupBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwLoginFormRegisteredGroupBox.GetResultTypeInfo

function TkwLoginFormRegisteredGroupBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLoginFormRegisteredGroupBox.GetAllParamsCount

function TkwLoginFormRegisteredGroupBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormRegisteredGroupBox.ParamsTypes

type
  TkwLoginFormLblLogin = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TLoginForm.lblLogin
[panel]Контрол lblLogin формы TLoginForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aLoginForm .TLoginForm.lblLogin >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LblLogin(const aCtx: TtfwContext;
     aLoginForm: TLoginForm): TvtLabel;
     {* Реализация слова скрипта .TLoginForm.lblLogin }
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
  end;//TkwLoginFormLblLogin

// start class TkwLoginFormLblLogin

function TkwLoginFormLblLogin.LblLogin(const aCtx: TtfwContext;
  aLoginForm: TLoginForm): TvtLabel;
 {-}
begin
 Result := aLoginForm.lblLogin;
end;//TkwLoginFormLblLogin.LblLogin

procedure TkwLoginFormLblLogin.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLoginForm : TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LblLogin(aCtx, l_aLoginForm)));
end;//TkwLoginFormLblLogin.DoDoIt

class function TkwLoginFormLblLogin.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLoginForm.lblLogin';
end;//TkwLoginFormLblLogin.GetWordNameForRegister

procedure TkwLoginFormLblLogin.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblLogin', aCtx);
end;//TkwLoginFormLblLogin.SetValuePrim

function TkwLoginFormLblLogin.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwLoginFormLblLogin.GetResultTypeInfo

function TkwLoginFormLblLogin.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLoginFormLblLogin.GetAllParamsCount

function TkwLoginFormLblLogin.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormLblLogin.ParamsTypes

type
  TkwLoginFormLblPassword = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TLoginForm.lblPassword
[panel]Контрол lblPassword формы TLoginForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aLoginForm .TLoginForm.lblPassword >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LblPassword(const aCtx: TtfwContext;
     aLoginForm: TLoginForm): TvtLabel;
     {* Реализация слова скрипта .TLoginForm.lblPassword }
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
  end;//TkwLoginFormLblPassword

// start class TkwLoginFormLblPassword

function TkwLoginFormLblPassword.LblPassword(const aCtx: TtfwContext;
  aLoginForm: TLoginForm): TvtLabel;
 {-}
begin
 Result := aLoginForm.lblPassword;
end;//TkwLoginFormLblPassword.LblPassword

procedure TkwLoginFormLblPassword.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLoginForm : TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LblPassword(aCtx, l_aLoginForm)));
end;//TkwLoginFormLblPassword.DoDoIt

class function TkwLoginFormLblPassword.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLoginForm.lblPassword';
end;//TkwLoginFormLblPassword.GetWordNameForRegister

procedure TkwLoginFormLblPassword.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblPassword', aCtx);
end;//TkwLoginFormLblPassword.SetValuePrim

function TkwLoginFormLblPassword.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwLoginFormLblPassword.GetResultTypeInfo

function TkwLoginFormLblPassword.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLoginFormLblPassword.GetAllParamsCount

function TkwLoginFormLblPassword.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormLblPassword.ParamsTypes

type
  TkwLoginFormEnterPaintBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TLoginForm.EnterPaintBox
[panel]Контрол EnterPaintBox формы TLoginForm[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aLoginForm .TLoginForm.EnterPaintBox >>> l_TPaintBox
[code]  }
  private
  // private methods
   function EnterPaintBox(const aCtx: TtfwContext;
     aLoginForm: TLoginForm): TPaintBox;
     {* Реализация слова скрипта .TLoginForm.EnterPaintBox }
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
  end;//TkwLoginFormEnterPaintBox

// start class TkwLoginFormEnterPaintBox

function TkwLoginFormEnterPaintBox.EnterPaintBox(const aCtx: TtfwContext;
  aLoginForm: TLoginForm): TPaintBox;
 {-}
begin
 Result := aLoginForm.EnterPaintBox;
end;//TkwLoginFormEnterPaintBox.EnterPaintBox

procedure TkwLoginFormEnterPaintBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLoginForm : TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EnterPaintBox(aCtx, l_aLoginForm)));
end;//TkwLoginFormEnterPaintBox.DoDoIt

class function TkwLoginFormEnterPaintBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLoginForm.EnterPaintBox';
end;//TkwLoginFormEnterPaintBox.GetWordNameForRegister

procedure TkwLoginFormEnterPaintBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству EnterPaintBox', aCtx);
end;//TkwLoginFormEnterPaintBox.SetValuePrim

function TkwLoginFormEnterPaintBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TPaintBox);
end;//TkwLoginFormEnterPaintBox.GetResultTypeInfo

function TkwLoginFormEnterPaintBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLoginFormEnterPaintBox.GetAllParamsCount

function TkwLoginFormEnterPaintBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormEnterPaintBox.ParamsTypes

type
  TkwLoginFormEdUserName = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TLoginForm.edUserName
[panel]Контрол edUserName формы TLoginForm[panel]
*Тип результата:* TnscComboBoxWithReadOnly
*Пример:*
[code]
OBJECT VAR l_TnscComboBoxWithReadOnly
 aLoginForm .TLoginForm.edUserName >>> l_TnscComboBoxWithReadOnly
[code]  }
  private
  // private methods
   function EdUserName(const aCtx: TtfwContext;
     aLoginForm: TLoginForm): TnscComboBoxWithReadOnly;
     {* Реализация слова скрипта .TLoginForm.edUserName }
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
  end;//TkwLoginFormEdUserName

// start class TkwLoginFormEdUserName

function TkwLoginFormEdUserName.EdUserName(const aCtx: TtfwContext;
  aLoginForm: TLoginForm): TnscComboBoxWithReadOnly;
 {-}
begin
 Result := aLoginForm.edUserName;
end;//TkwLoginFormEdUserName.EdUserName

procedure TkwLoginFormEdUserName.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLoginForm : TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EdUserName(aCtx, l_aLoginForm)));
end;//TkwLoginFormEdUserName.DoDoIt

class function TkwLoginFormEdUserName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLoginForm.edUserName';
end;//TkwLoginFormEdUserName.GetWordNameForRegister

procedure TkwLoginFormEdUserName.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству edUserName', aCtx);
end;//TkwLoginFormEdUserName.SetValuePrim

function TkwLoginFormEdUserName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscComboBoxWithReadOnly);
end;//TkwLoginFormEdUserName.GetResultTypeInfo

function TkwLoginFormEdUserName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLoginFormEdUserName.GetAllParamsCount

function TkwLoginFormEdUserName.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormEdUserName.ParamsTypes

type
  TkwLoginFormEdPassword = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TLoginForm.edPassword
[panel]Контрол edPassword формы TLoginForm[panel]
*Тип результата:* TnscComboBoxWithPwdChar
*Пример:*
[code]
OBJECT VAR l_TnscComboBoxWithPwdChar
 aLoginForm .TLoginForm.edPassword >>> l_TnscComboBoxWithPwdChar
[code]  }
  private
  // private methods
   function EdPassword(const aCtx: TtfwContext;
     aLoginForm: TLoginForm): TnscComboBoxWithPwdChar;
     {* Реализация слова скрипта .TLoginForm.edPassword }
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
  end;//TkwLoginFormEdPassword

// start class TkwLoginFormEdPassword

function TkwLoginFormEdPassword.EdPassword(const aCtx: TtfwContext;
  aLoginForm: TLoginForm): TnscComboBoxWithPwdChar;
 {-}
begin
 Result := aLoginForm.edPassword;
end;//TkwLoginFormEdPassword.EdPassword

procedure TkwLoginFormEdPassword.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLoginForm : TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EdPassword(aCtx, l_aLoginForm)));
end;//TkwLoginFormEdPassword.DoDoIt

class function TkwLoginFormEdPassword.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLoginForm.edPassword';
end;//TkwLoginFormEdPassword.GetWordNameForRegister

procedure TkwLoginFormEdPassword.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству edPassword', aCtx);
end;//TkwLoginFormEdPassword.SetValuePrim

function TkwLoginFormEdPassword.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscComboBoxWithPwdChar);
end;//TkwLoginFormEdPassword.GetResultTypeInfo

function TkwLoginFormEdPassword.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLoginFormEdPassword.GetAllParamsCount

function TkwLoginFormEdPassword.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormEdPassword.ParamsTypes

type
  TkwLoginFormLblForgetPassword = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TLoginForm.lblForgetPassword
[panel]Контрол lblForgetPassword формы TLoginForm[panel]
*Тип результата:* TvtFocusLabel
*Пример:*
[code]
OBJECT VAR l_TvtFocusLabel
 aLoginForm .TLoginForm.lblForgetPassword >>> l_TvtFocusLabel
[code]  }
  private
  // private methods
   function LblForgetPassword(const aCtx: TtfwContext;
     aLoginForm: TLoginForm): TvtFocusLabel;
     {* Реализация слова скрипта .TLoginForm.lblForgetPassword }
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
  end;//TkwLoginFormLblForgetPassword

// start class TkwLoginFormLblForgetPassword

function TkwLoginFormLblForgetPassword.LblForgetPassword(const aCtx: TtfwContext;
  aLoginForm: TLoginForm): TvtFocusLabel;
 {-}
begin
 Result := aLoginForm.lblForgetPassword;
end;//TkwLoginFormLblForgetPassword.LblForgetPassword

procedure TkwLoginFormLblForgetPassword.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLoginForm : TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LblForgetPassword(aCtx, l_aLoginForm)));
end;//TkwLoginFormLblForgetPassword.DoDoIt

class function TkwLoginFormLblForgetPassword.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLoginForm.lblForgetPassword';
end;//TkwLoginFormLblForgetPassword.GetWordNameForRegister

procedure TkwLoginFormLblForgetPassword.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblForgetPassword', aCtx);
end;//TkwLoginFormLblForgetPassword.SetValuePrim

function TkwLoginFormLblForgetPassword.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtFocusLabel);
end;//TkwLoginFormLblForgetPassword.GetResultTypeInfo

function TkwLoginFormLblForgetPassword.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLoginFormLblForgetPassword.GetAllParamsCount

function TkwLoginFormLblForgetPassword.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormLblForgetPassword.ParamsTypes

type
  TkwLoginFormCbAutoLogin = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TLoginForm.cbAutoLogin
[panel]Контрол cbAutoLogin формы TLoginForm[panel]
*Тип результата:* TvtCheckBox
*Пример:*
[code]
OBJECT VAR l_TvtCheckBox
 aLoginForm .TLoginForm.cbAutoLogin >>> l_TvtCheckBox
[code]  }
  private
  // private methods
   function CbAutoLogin(const aCtx: TtfwContext;
     aLoginForm: TLoginForm): TvtCheckBox;
     {* Реализация слова скрипта .TLoginForm.cbAutoLogin }
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
  end;//TkwLoginFormCbAutoLogin

// start class TkwLoginFormCbAutoLogin

function TkwLoginFormCbAutoLogin.CbAutoLogin(const aCtx: TtfwContext;
  aLoginForm: TLoginForm): TvtCheckBox;
 {-}
begin
 Result := aLoginForm.cbAutoLogin;
end;//TkwLoginFormCbAutoLogin.CbAutoLogin

procedure TkwLoginFormCbAutoLogin.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLoginForm : TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((CbAutoLogin(aCtx, l_aLoginForm)));
end;//TkwLoginFormCbAutoLogin.DoDoIt

class function TkwLoginFormCbAutoLogin.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLoginForm.cbAutoLogin';
end;//TkwLoginFormCbAutoLogin.GetWordNameForRegister

procedure TkwLoginFormCbAutoLogin.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству cbAutoLogin', aCtx);
end;//TkwLoginFormCbAutoLogin.SetValuePrim

function TkwLoginFormCbAutoLogin.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwLoginFormCbAutoLogin.GetResultTypeInfo

function TkwLoginFormCbAutoLogin.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLoginFormCbAutoLogin.GetAllParamsCount

function TkwLoginFormCbAutoLogin.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormCbAutoLogin.ParamsTypes

type
  TkwLoginFormBtnOk = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TLoginForm.btnOk
[panel]Контрол btnOk формы TLoginForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aLoginForm .TLoginForm.btnOk >>> l_TElPopupButton
[code]  }
  private
  // private methods
   function BtnOk(const aCtx: TtfwContext;
     aLoginForm: TLoginForm): TElPopupButton;
     {* Реализация слова скрипта .TLoginForm.btnOk }
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
  end;//TkwLoginFormBtnOk

// start class TkwLoginFormBtnOk

function TkwLoginFormBtnOk.BtnOk(const aCtx: TtfwContext;
  aLoginForm: TLoginForm): TElPopupButton;
 {-}
begin
 Result := aLoginForm.btnOk;
end;//TkwLoginFormBtnOk.BtnOk

procedure TkwLoginFormBtnOk.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLoginForm : TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BtnOk(aCtx, l_aLoginForm)));
end;//TkwLoginFormBtnOk.DoDoIt

class function TkwLoginFormBtnOk.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLoginForm.btnOk';
end;//TkwLoginFormBtnOk.GetWordNameForRegister

procedure TkwLoginFormBtnOk.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству btnOk', aCtx);
end;//TkwLoginFormBtnOk.SetValuePrim

function TkwLoginFormBtnOk.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwLoginFormBtnOk.GetResultTypeInfo

function TkwLoginFormBtnOk.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLoginFormBtnOk.GetAllParamsCount

function TkwLoginFormBtnOk.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormBtnOk.ParamsTypes

type
  TkwLoginFormNewUserGroupBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TLoginForm.NewUserGroupBox
[panel]Контрол NewUserGroupBox формы TLoginForm[panel]
*Тип результата:* TvtGroupBox
*Пример:*
[code]
OBJECT VAR l_TvtGroupBox
 aLoginForm .TLoginForm.NewUserGroupBox >>> l_TvtGroupBox
[code]  }
  private
  // private methods
   function NewUserGroupBox(const aCtx: TtfwContext;
     aLoginForm: TLoginForm): TvtGroupBox;
     {* Реализация слова скрипта .TLoginForm.NewUserGroupBox }
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
  end;//TkwLoginFormNewUserGroupBox

// start class TkwLoginFormNewUserGroupBox

function TkwLoginFormNewUserGroupBox.NewUserGroupBox(const aCtx: TtfwContext;
  aLoginForm: TLoginForm): TvtGroupBox;
 {-}
begin
 Result := aLoginForm.NewUserGroupBox;
end;//TkwLoginFormNewUserGroupBox.NewUserGroupBox

procedure TkwLoginFormNewUserGroupBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLoginForm : TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((NewUserGroupBox(aCtx, l_aLoginForm)));
end;//TkwLoginFormNewUserGroupBox.DoDoIt

class function TkwLoginFormNewUserGroupBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLoginForm.NewUserGroupBox';
end;//TkwLoginFormNewUserGroupBox.GetWordNameForRegister

procedure TkwLoginFormNewUserGroupBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству NewUserGroupBox', aCtx);
end;//TkwLoginFormNewUserGroupBox.SetValuePrim

function TkwLoginFormNewUserGroupBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwLoginFormNewUserGroupBox.GetResultTypeInfo

function TkwLoginFormNewUserGroupBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLoginFormNewUserGroupBox.GetAllParamsCount

function TkwLoginFormNewUserGroupBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormNewUserGroupBox.ParamsTypes

type
  TkwLoginFormNewUserLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TLoginForm.NewUserLabel
[panel]Контрол NewUserLabel формы TLoginForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aLoginForm .TLoginForm.NewUserLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function NewUserLabel(const aCtx: TtfwContext;
     aLoginForm: TLoginForm): TvtLabel;
     {* Реализация слова скрипта .TLoginForm.NewUserLabel }
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
  end;//TkwLoginFormNewUserLabel

// start class TkwLoginFormNewUserLabel

function TkwLoginFormNewUserLabel.NewUserLabel(const aCtx: TtfwContext;
  aLoginForm: TLoginForm): TvtLabel;
 {-}
begin
 Result := aLoginForm.NewUserLabel;
end;//TkwLoginFormNewUserLabel.NewUserLabel

procedure TkwLoginFormNewUserLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLoginForm : TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((NewUserLabel(aCtx, l_aLoginForm)));
end;//TkwLoginFormNewUserLabel.DoDoIt

class function TkwLoginFormNewUserLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLoginForm.NewUserLabel';
end;//TkwLoginFormNewUserLabel.GetWordNameForRegister

procedure TkwLoginFormNewUserLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству NewUserLabel', aCtx);
end;//TkwLoginFormNewUserLabel.SetValuePrim

function TkwLoginFormNewUserLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwLoginFormNewUserLabel.GetResultTypeInfo

function TkwLoginFormNewUserLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLoginFormNewUserLabel.GetAllParamsCount

function TkwLoginFormNewUserLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormNewUserLabel.ParamsTypes

type
  TkwLoginFormNewUserPaintBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TLoginForm.NewUserPaintBox
[panel]Контрол NewUserPaintBox формы TLoginForm[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aLoginForm .TLoginForm.NewUserPaintBox >>> l_TPaintBox
[code]  }
  private
  // private methods
   function NewUserPaintBox(const aCtx: TtfwContext;
     aLoginForm: TLoginForm): TPaintBox;
     {* Реализация слова скрипта .TLoginForm.NewUserPaintBox }
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
  end;//TkwLoginFormNewUserPaintBox

// start class TkwLoginFormNewUserPaintBox

function TkwLoginFormNewUserPaintBox.NewUserPaintBox(const aCtx: TtfwContext;
  aLoginForm: TLoginForm): TPaintBox;
 {-}
begin
 Result := aLoginForm.NewUserPaintBox;
end;//TkwLoginFormNewUserPaintBox.NewUserPaintBox

procedure TkwLoginFormNewUserPaintBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLoginForm : TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((NewUserPaintBox(aCtx, l_aLoginForm)));
end;//TkwLoginFormNewUserPaintBox.DoDoIt

class function TkwLoginFormNewUserPaintBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLoginForm.NewUserPaintBox';
end;//TkwLoginFormNewUserPaintBox.GetWordNameForRegister

procedure TkwLoginFormNewUserPaintBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству NewUserPaintBox', aCtx);
end;//TkwLoginFormNewUserPaintBox.SetValuePrim

function TkwLoginFormNewUserPaintBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TPaintBox);
end;//TkwLoginFormNewUserPaintBox.GetResultTypeInfo

function TkwLoginFormNewUserPaintBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLoginFormNewUserPaintBox.GetAllParamsCount

function TkwLoginFormNewUserPaintBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormNewUserPaintBox.ParamsTypes

type
  TkwLoginFormLblNewUser = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TLoginForm.lblNewUser
[panel]Контрол lblNewUser формы TLoginForm[panel]
*Тип результата:* TvtFocusLabel
*Пример:*
[code]
OBJECT VAR l_TvtFocusLabel
 aLoginForm .TLoginForm.lblNewUser >>> l_TvtFocusLabel
[code]  }
  private
  // private methods
   function LblNewUser(const aCtx: TtfwContext;
     aLoginForm: TLoginForm): TvtFocusLabel;
     {* Реализация слова скрипта .TLoginForm.lblNewUser }
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
  end;//TkwLoginFormLblNewUser

// start class TkwLoginFormLblNewUser

function TkwLoginFormLblNewUser.LblNewUser(const aCtx: TtfwContext;
  aLoginForm: TLoginForm): TvtFocusLabel;
 {-}
begin
 Result := aLoginForm.lblNewUser;
end;//TkwLoginFormLblNewUser.LblNewUser

procedure TkwLoginFormLblNewUser.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLoginForm : TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LblNewUser(aCtx, l_aLoginForm)));
end;//TkwLoginFormLblNewUser.DoDoIt

class function TkwLoginFormLblNewUser.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLoginForm.lblNewUser';
end;//TkwLoginFormLblNewUser.GetWordNameForRegister

procedure TkwLoginFormLblNewUser.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblNewUser', aCtx);
end;//TkwLoginFormLblNewUser.SetValuePrim

function TkwLoginFormLblNewUser.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtFocusLabel);
end;//TkwLoginFormLblNewUser.GetResultTypeInfo

function TkwLoginFormLblNewUser.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLoginFormLblNewUser.GetAllParamsCount

function TkwLoginFormLblNewUser.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormLblNewUser.ParamsTypes

type
  TkwLoginFormHelpPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TLoginForm.HelpPanel
[panel]Контрол HelpPanel формы TLoginForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aLoginForm .TLoginForm.HelpPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function HelpPanel(const aCtx: TtfwContext;
     aLoginForm: TLoginForm): TvtPanel;
     {* Реализация слова скрипта .TLoginForm.HelpPanel }
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
  end;//TkwLoginFormHelpPanel

// start class TkwLoginFormHelpPanel

function TkwLoginFormHelpPanel.HelpPanel(const aCtx: TtfwContext;
  aLoginForm: TLoginForm): TvtPanel;
 {-}
begin
 Result := aLoginForm.HelpPanel;
end;//TkwLoginFormHelpPanel.HelpPanel

procedure TkwLoginFormHelpPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLoginForm : TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((HelpPanel(aCtx, l_aLoginForm)));
end;//TkwLoginFormHelpPanel.DoDoIt

class function TkwLoginFormHelpPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLoginForm.HelpPanel';
end;//TkwLoginFormHelpPanel.GetWordNameForRegister

procedure TkwLoginFormHelpPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству HelpPanel', aCtx);
end;//TkwLoginFormHelpPanel.SetValuePrim

function TkwLoginFormHelpPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwLoginFormHelpPanel.GetResultTypeInfo

function TkwLoginFormHelpPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLoginFormHelpPanel.GetAllParamsCount

function TkwLoginFormHelpPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormHelpPanel.ParamsTypes

type
  TkwLoginFormHelpPaintBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TLoginForm.HelpPaintBox
[panel]Контрол HelpPaintBox формы TLoginForm[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aLoginForm .TLoginForm.HelpPaintBox >>> l_TPaintBox
[code]  }
  private
  // private methods
   function HelpPaintBox(const aCtx: TtfwContext;
     aLoginForm: TLoginForm): TPaintBox;
     {* Реализация слова скрипта .TLoginForm.HelpPaintBox }
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
  end;//TkwLoginFormHelpPaintBox

// start class TkwLoginFormHelpPaintBox

function TkwLoginFormHelpPaintBox.HelpPaintBox(const aCtx: TtfwContext;
  aLoginForm: TLoginForm): TPaintBox;
 {-}
begin
 Result := aLoginForm.HelpPaintBox;
end;//TkwLoginFormHelpPaintBox.HelpPaintBox

procedure TkwLoginFormHelpPaintBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLoginForm : TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((HelpPaintBox(aCtx, l_aLoginForm)));
end;//TkwLoginFormHelpPaintBox.DoDoIt

class function TkwLoginFormHelpPaintBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLoginForm.HelpPaintBox';
end;//TkwLoginFormHelpPaintBox.GetWordNameForRegister

procedure TkwLoginFormHelpPaintBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству HelpPaintBox', aCtx);
end;//TkwLoginFormHelpPaintBox.SetValuePrim

function TkwLoginFormHelpPaintBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TPaintBox);
end;//TkwLoginFormHelpPaintBox.GetResultTypeInfo

function TkwLoginFormHelpPaintBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLoginFormHelpPaintBox.GetAllParamsCount

function TkwLoginFormHelpPaintBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormHelpPaintBox.ParamsTypes

type
  TkwLoginFormHelpLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TLoginForm.HelpLabel
[panel]Контрол HelpLabel формы TLoginForm[panel]
*Тип результата:* TvtFocusLabel
*Пример:*
[code]
OBJECT VAR l_TvtFocusLabel
 aLoginForm .TLoginForm.HelpLabel >>> l_TvtFocusLabel
[code]  }
  private
  // private methods
   function HelpLabel(const aCtx: TtfwContext;
     aLoginForm: TLoginForm): TvtFocusLabel;
     {* Реализация слова скрипта .TLoginForm.HelpLabel }
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
  end;//TkwLoginFormHelpLabel

// start class TkwLoginFormHelpLabel

function TkwLoginFormHelpLabel.HelpLabel(const aCtx: TtfwContext;
  aLoginForm: TLoginForm): TvtFocusLabel;
 {-}
begin
 Result := aLoginForm.HelpLabel;
end;//TkwLoginFormHelpLabel.HelpLabel

procedure TkwLoginFormHelpLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLoginForm : TLoginForm;
begin
 try
  l_aLoginForm := TLoginForm(aCtx.rEngine.PopObjAs(TLoginForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLoginForm: TLoginForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((HelpLabel(aCtx, l_aLoginForm)));
end;//TkwLoginFormHelpLabel.DoDoIt

class function TkwLoginFormHelpLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLoginForm.HelpLabel';
end;//TkwLoginFormHelpLabel.GetWordNameForRegister

procedure TkwLoginFormHelpLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству HelpLabel', aCtx);
end;//TkwLoginFormHelpLabel.SetValuePrim

function TkwLoginFormHelpLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtFocusLabel);
end;//TkwLoginFormHelpLabel.GetResultTypeInfo

function TkwLoginFormHelpLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLoginFormHelpLabel.GetAllParamsCount

function TkwLoginFormHelpLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLoginForm)]);
end;//TkwLoginFormHelpLabel.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация Tkw_Form_Login
 Tkw_Form_Login.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_RegisteredGroupBox
 Tkw_Login_Control_RegisteredGroupBox.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_RegisteredGroupBox_Push
 Tkw_Login_Control_RegisteredGroupBox_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_lblLogin
 Tkw_Login_Control_lblLogin.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_lblLogin_Push
 Tkw_Login_Control_lblLogin_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_lblPassword
 Tkw_Login_Control_lblPassword.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_lblPassword_Push
 Tkw_Login_Control_lblPassword_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_EnterPaintBox
 Tkw_Login_Control_EnterPaintBox.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_EnterPaintBox_Push
 Tkw_Login_Control_EnterPaintBox_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_edUserName
 Tkw_Login_Control_edUserName.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_edUserName_Push
 Tkw_Login_Control_edUserName_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_edPassword
 Tkw_Login_Control_edPassword.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_edPassword_Push
 Tkw_Login_Control_edPassword_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_lblForgetPassword
 Tkw_Login_Control_lblForgetPassword.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_lblForgetPassword_Push
 Tkw_Login_Control_lblForgetPassword_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_cbAutoLogin
 Tkw_Login_Control_cbAutoLogin.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_cbAutoLogin_Push
 Tkw_Login_Control_cbAutoLogin_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_btnOk
 Tkw_Login_Control_btnOk.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_btnOk_Push
 Tkw_Login_Control_btnOk_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_NewUserGroupBox
 Tkw_Login_Control_NewUserGroupBox.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_NewUserGroupBox_Push
 Tkw_Login_Control_NewUserGroupBox_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_NewUserLabel
 Tkw_Login_Control_NewUserLabel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_NewUserLabel_Push
 Tkw_Login_Control_NewUserLabel_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_NewUserPaintBox
 Tkw_Login_Control_NewUserPaintBox.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_NewUserPaintBox_Push
 Tkw_Login_Control_NewUserPaintBox_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_lblNewUser
 Tkw_Login_Control_lblNewUser.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_lblNewUser_Push
 Tkw_Login_Control_lblNewUser_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_HelpPanel
 Tkw_Login_Control_HelpPanel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_HelpPanel_Push
 Tkw_Login_Control_HelpPanel_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_HelpPaintBox
 Tkw_Login_Control_HelpPaintBox.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_HelpPaintBox_Push
 Tkw_Login_Control_HelpPaintBox_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_HelpLabel
 Tkw_Login_Control_HelpLabel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_Login_Control_HelpLabel_Push
 Tkw_Login_Control_HelpLabel_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация LoginForm_RegisteredGroupBox
 TkwLoginFormRegisteredGroupBox.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация LoginForm_lblLogin
 TkwLoginFormLblLogin.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация LoginForm_lblPassword
 TkwLoginFormLblPassword.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация LoginForm_EnterPaintBox
 TkwLoginFormEnterPaintBox.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация LoginForm_edUserName
 TkwLoginFormEdUserName.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация LoginForm_edPassword
 TkwLoginFormEdPassword.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация LoginForm_lblForgetPassword
 TkwLoginFormLblForgetPassword.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация LoginForm_cbAutoLogin
 TkwLoginFormCbAutoLogin.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация LoginForm_btnOk
 TkwLoginFormBtnOk.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация LoginForm_NewUserGroupBox
 TkwLoginFormNewUserGroupBox.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация LoginForm_NewUserLabel
 TkwLoginFormNewUserLabel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация LoginForm_NewUserPaintBox
 TkwLoginFormNewUserPaintBox.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация LoginForm_lblNewUser
 TkwLoginFormLblNewUser.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация LoginForm_HelpPanel
 TkwLoginFormHelpPanel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация LoginForm_HelpPaintBox
 TkwLoginFormHelpPaintBox.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация LoginForm_HelpLabel
 TkwLoginFormHelpLabel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа Login
 TtfwTypeRegistrator.RegisterType(TypeInfo(TLoginForm));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TvtGroupBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtGroupBox));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TPaintBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TnscComboBoxWithReadOnly
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscComboBoxWithReadOnly));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TnscComboBoxWithPwdChar
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscComboBoxWithPwdChar));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TvtFocusLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtFocusLabel));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TvtCheckBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtCheckBox));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TElPopupButton
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElPopupButton));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not NoScripts

end.
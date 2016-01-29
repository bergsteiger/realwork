unit SelfInfoKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/SelfInfoKeywordsPack.pas"
// Начат: 09.09.2009 16:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Основные прецеденты::Settings::View::Settings::Settings::SelfInfoKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы SelfInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  vtPanel,
  vtFocusLabel
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtLabel,
  SelfInfo_Form,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  ElPopBtn,
  tfwPropertyLike
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_SelfInfo = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы SelfInfo
----
*Пример использования*:
[code]
'aControl' форма::SelfInfo TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_SelfInfo

// start class Tkw_Form_SelfInfo

class function Tkw_Form_SelfInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::SelfInfo';
end;//Tkw_Form_SelfInfo.GetWordNameForRegister

function Tkw_Form_SelfInfo.GetString: AnsiString;
 {-}
begin
 Result := 'SelfInfoForm';
end;//Tkw_Form_SelfInfo.GetString

type
  Tkw_SelfInfo_Control_pnMainData = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pnMainData
----
*Пример использования*:
[code]
контрол::pnMainData TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_SelfInfo_Control_pnMainData

// start class Tkw_SelfInfo_Control_pnMainData

class function Tkw_SelfInfo_Control_pnMainData.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnMainData';
end;//Tkw_SelfInfo_Control_pnMainData.GetWordNameForRegister

function Tkw_SelfInfo_Control_pnMainData.GetString: AnsiString;
 {-}
begin
 Result := 'pnMainData';
end;//Tkw_SelfInfo_Control_pnMainData.GetString

class procedure Tkw_SelfInfo_Control_pnMainData.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_SelfInfo_Control_pnMainData.RegisterInEngine

type
  Tkw_SelfInfo_Control_pnMainData_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pnMainData
----
*Пример использования*:
[code]
контрол::pnMainData:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_SelfInfo_Control_pnMainData_Push

// start class Tkw_SelfInfo_Control_pnMainData_Push

procedure Tkw_SelfInfo_Control_pnMainData_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnMainData');
 inherited;
end;//Tkw_SelfInfo_Control_pnMainData_Push.DoDoIt

class function Tkw_SelfInfo_Control_pnMainData_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnMainData:push';
end;//Tkw_SelfInfo_Control_pnMainData_Push.GetWordNameForRegister

type
  Tkw_SelfInfo_Control_UserNameLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола UserNameLabel
----
*Пример использования*:
[code]
контрол::UserNameLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_SelfInfo_Control_UserNameLabel

// start class Tkw_SelfInfo_Control_UserNameLabel

class function Tkw_SelfInfo_Control_UserNameLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::UserNameLabel';
end;//Tkw_SelfInfo_Control_UserNameLabel.GetWordNameForRegister

function Tkw_SelfInfo_Control_UserNameLabel.GetString: AnsiString;
 {-}
begin
 Result := 'UserNameLabel';
end;//Tkw_SelfInfo_Control_UserNameLabel.GetString

class procedure Tkw_SelfInfo_Control_UserNameLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SelfInfo_Control_UserNameLabel.RegisterInEngine

type
  Tkw_SelfInfo_Control_UserNameLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола UserNameLabel
----
*Пример использования*:
[code]
контрол::UserNameLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_SelfInfo_Control_UserNameLabel_Push

// start class Tkw_SelfInfo_Control_UserNameLabel_Push

procedure Tkw_SelfInfo_Control_UserNameLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('UserNameLabel');
 inherited;
end;//Tkw_SelfInfo_Control_UserNameLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_UserNameLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::UserNameLabel:push';
end;//Tkw_SelfInfo_Control_UserNameLabel_Push.GetWordNameForRegister

type
  Tkw_SelfInfo_Control_PasswordLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола PasswordLabel
----
*Пример использования*:
[code]
контрол::PasswordLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_SelfInfo_Control_PasswordLabel

// start class Tkw_SelfInfo_Control_PasswordLabel

class function Tkw_SelfInfo_Control_PasswordLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::PasswordLabel';
end;//Tkw_SelfInfo_Control_PasswordLabel.GetWordNameForRegister

function Tkw_SelfInfo_Control_PasswordLabel.GetString: AnsiString;
 {-}
begin
 Result := 'PasswordLabel';
end;//Tkw_SelfInfo_Control_PasswordLabel.GetString

class procedure Tkw_SelfInfo_Control_PasswordLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SelfInfo_Control_PasswordLabel.RegisterInEngine

type
  Tkw_SelfInfo_Control_PasswordLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола PasswordLabel
----
*Пример использования*:
[code]
контрол::PasswordLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_SelfInfo_Control_PasswordLabel_Push

// start class Tkw_SelfInfo_Control_PasswordLabel_Push

procedure Tkw_SelfInfo_Control_PasswordLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('PasswordLabel');
 inherited;
end;//Tkw_SelfInfo_Control_PasswordLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_PasswordLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::PasswordLabel:push';
end;//Tkw_SelfInfo_Control_PasswordLabel_Push.GetWordNameForRegister

type
  Tkw_SelfInfo_Control_LoginLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола LoginLabel
----
*Пример использования*:
[code]
контрол::LoginLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_SelfInfo_Control_LoginLabel

// start class Tkw_SelfInfo_Control_LoginLabel

class function Tkw_SelfInfo_Control_LoginLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::LoginLabel';
end;//Tkw_SelfInfo_Control_LoginLabel.GetWordNameForRegister

function Tkw_SelfInfo_Control_LoginLabel.GetString: AnsiString;
 {-}
begin
 Result := 'LoginLabel';
end;//Tkw_SelfInfo_Control_LoginLabel.GetString

class procedure Tkw_SelfInfo_Control_LoginLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SelfInfo_Control_LoginLabel.RegisterInEngine

type
  Tkw_SelfInfo_Control_LoginLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола LoginLabel
----
*Пример использования*:
[code]
контрол::LoginLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_SelfInfo_Control_LoginLabel_Push

// start class Tkw_SelfInfo_Control_LoginLabel_Push

procedure Tkw_SelfInfo_Control_LoginLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('LoginLabel');
 inherited;
end;//Tkw_SelfInfo_Control_LoginLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_LoginLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::LoginLabel:push';
end;//Tkw_SelfInfo_Control_LoginLabel_Push.GetWordNameForRegister

type
  Tkw_SelfInfo_Control_InfoLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола InfoLabel
----
*Пример использования*:
[code]
контрол::InfoLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_SelfInfo_Control_InfoLabel

// start class Tkw_SelfInfo_Control_InfoLabel

class function Tkw_SelfInfo_Control_InfoLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::InfoLabel';
end;//Tkw_SelfInfo_Control_InfoLabel.GetWordNameForRegister

function Tkw_SelfInfo_Control_InfoLabel.GetString: AnsiString;
 {-}
begin
 Result := 'InfoLabel';
end;//Tkw_SelfInfo_Control_InfoLabel.GetString

class procedure Tkw_SelfInfo_Control_InfoLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SelfInfo_Control_InfoLabel.RegisterInEngine

type
  Tkw_SelfInfo_Control_InfoLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола InfoLabel
----
*Пример использования*:
[code]
контрол::InfoLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_SelfInfo_Control_InfoLabel_Push

// start class Tkw_SelfInfo_Control_InfoLabel_Push

procedure Tkw_SelfInfo_Control_InfoLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('InfoLabel');
 inherited;
end;//Tkw_SelfInfo_Control_InfoLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_InfoLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::InfoLabel:push';
end;//Tkw_SelfInfo_Control_InfoLabel_Push.GetWordNameForRegister

type
  Tkw_SelfInfo_Control_EMailLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола EMailLabel
----
*Пример использования*:
[code]
контрол::EMailLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_SelfInfo_Control_EMailLabel

// start class Tkw_SelfInfo_Control_EMailLabel

class function Tkw_SelfInfo_Control_EMailLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::EMailLabel';
end;//Tkw_SelfInfo_Control_EMailLabel.GetWordNameForRegister

function Tkw_SelfInfo_Control_EMailLabel.GetString: AnsiString;
 {-}
begin
 Result := 'EMailLabel';
end;//Tkw_SelfInfo_Control_EMailLabel.GetString

class procedure Tkw_SelfInfo_Control_EMailLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SelfInfo_Control_EMailLabel.RegisterInEngine

type
  Tkw_SelfInfo_Control_EMailLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола EMailLabel
----
*Пример использования*:
[code]
контрол::EMailLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_SelfInfo_Control_EMailLabel_Push

// start class Tkw_SelfInfo_Control_EMailLabel_Push

procedure Tkw_SelfInfo_Control_EMailLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('EMailLabel');
 inherited;
end;//Tkw_SelfInfo_Control_EMailLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_EMailLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::EMailLabel:push';
end;//Tkw_SelfInfo_Control_EMailLabel_Push.GetWordNameForRegister

type
  Tkw_SelfInfo_Control_ConfirmPasswordLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола ConfirmPasswordLabel
----
*Пример использования*:
[code]
контрол::ConfirmPasswordLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel

// start class Tkw_SelfInfo_Control_ConfirmPasswordLabel

class function Tkw_SelfInfo_Control_ConfirmPasswordLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ConfirmPasswordLabel';
end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel.GetWordNameForRegister

function Tkw_SelfInfo_Control_ConfirmPasswordLabel.GetString: AnsiString;
 {-}
begin
 Result := 'ConfirmPasswordLabel';
end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel.GetString

class procedure Tkw_SelfInfo_Control_ConfirmPasswordLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel.RegisterInEngine

type
  Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола ConfirmPasswordLabel
----
*Пример использования*:
[code]
контрол::ConfirmPasswordLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push

// start class Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push

procedure Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ConfirmPasswordLabel');
 inherited;
end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ConfirmPasswordLabel:push';
end;//Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push.GetWordNameForRegister

type
  Tkw_SelfInfo_Control_vtAsteriskLabelLogin = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола vtAsteriskLabelLogin
----
*Пример использования*:
[code]
контрол::vtAsteriskLabelLogin TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin

// start class Tkw_SelfInfo_Control_vtAsteriskLabelLogin

class function Tkw_SelfInfo_Control_vtAsteriskLabelLogin.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::vtAsteriskLabelLogin';
end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin.GetWordNameForRegister

function Tkw_SelfInfo_Control_vtAsteriskLabelLogin.GetString: AnsiString;
 {-}
begin
 Result := 'vtAsteriskLabelLogin';
end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin.GetString

class procedure Tkw_SelfInfo_Control_vtAsteriskLabelLogin.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin.RegisterInEngine

type
  Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола vtAsteriskLabelLogin
----
*Пример использования*:
[code]
контрол::vtAsteriskLabelLogin:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push

// start class Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push

procedure Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('vtAsteriskLabelLogin');
 inherited;
end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push.DoDoIt

class function Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::vtAsteriskLabelLogin:push';
end;//Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push.GetWordNameForRegister

type
  Tkw_SelfInfo_Control_vtAsteriskLabelFIO = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола vtAsteriskLabelFIO
----
*Пример использования*:
[code]
контрол::vtAsteriskLabelFIO TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO

// start class Tkw_SelfInfo_Control_vtAsteriskLabelFIO

class function Tkw_SelfInfo_Control_vtAsteriskLabelFIO.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::vtAsteriskLabelFIO';
end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO.GetWordNameForRegister

function Tkw_SelfInfo_Control_vtAsteriskLabelFIO.GetString: AnsiString;
 {-}
begin
 Result := 'vtAsteriskLabelFIO';
end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO.GetString

class procedure Tkw_SelfInfo_Control_vtAsteriskLabelFIO.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO.RegisterInEngine

type
  Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола vtAsteriskLabelFIO
----
*Пример использования*:
[code]
контрол::vtAsteriskLabelFIO:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push

// start class Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push

procedure Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('vtAsteriskLabelFIO');
 inherited;
end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push.DoDoIt

class function Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::vtAsteriskLabelFIO:push';
end;//Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push.GetWordNameForRegister

type
  Tkw_SelfInfo_Control_edPassword = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_SelfInfo_Control_edPassword

// start class Tkw_SelfInfo_Control_edPassword

class function Tkw_SelfInfo_Control_edPassword.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edPassword';
end;//Tkw_SelfInfo_Control_edPassword.GetWordNameForRegister

function Tkw_SelfInfo_Control_edPassword.GetString: AnsiString;
 {-}
begin
 Result := 'edPassword';
end;//Tkw_SelfInfo_Control_edPassword.GetString

class procedure Tkw_SelfInfo_Control_edPassword.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscComboBoxWithPwdChar);
end;//Tkw_SelfInfo_Control_edPassword.RegisterInEngine

type
  Tkw_SelfInfo_Control_edPassword_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_SelfInfo_Control_edPassword_Push

// start class Tkw_SelfInfo_Control_edPassword_Push

procedure Tkw_SelfInfo_Control_edPassword_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edPassword');
 inherited;
end;//Tkw_SelfInfo_Control_edPassword_Push.DoDoIt

class function Tkw_SelfInfo_Control_edPassword_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edPassword:push';
end;//Tkw_SelfInfo_Control_edPassword_Push.GetWordNameForRegister

type
  Tkw_SelfInfo_Control_edUserName = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_SelfInfo_Control_edUserName

// start class Tkw_SelfInfo_Control_edUserName

class function Tkw_SelfInfo_Control_edUserName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edUserName';
end;//Tkw_SelfInfo_Control_edUserName.GetWordNameForRegister

function Tkw_SelfInfo_Control_edUserName.GetString: AnsiString;
 {-}
begin
 Result := 'edUserName';
end;//Tkw_SelfInfo_Control_edUserName.GetString

class procedure Tkw_SelfInfo_Control_edUserName.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_SelfInfo_Control_edUserName.RegisterInEngine

type
  Tkw_SelfInfo_Control_edUserName_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_SelfInfo_Control_edUserName_Push

// start class Tkw_SelfInfo_Control_edUserName_Push

procedure Tkw_SelfInfo_Control_edUserName_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edUserName');
 inherited;
end;//Tkw_SelfInfo_Control_edUserName_Push.DoDoIt

class function Tkw_SelfInfo_Control_edUserName_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edUserName:push';
end;//Tkw_SelfInfo_Control_edUserName_Push.GetWordNameForRegister

type
  Tkw_SelfInfo_Control_edLogin = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола edLogin
----
*Пример использования*:
[code]
контрол::edLogin TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_SelfInfo_Control_edLogin

// start class Tkw_SelfInfo_Control_edLogin

class function Tkw_SelfInfo_Control_edLogin.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edLogin';
end;//Tkw_SelfInfo_Control_edLogin.GetWordNameForRegister

function Tkw_SelfInfo_Control_edLogin.GetString: AnsiString;
 {-}
begin
 Result := 'edLogin';
end;//Tkw_SelfInfo_Control_edLogin.GetString

class procedure Tkw_SelfInfo_Control_edLogin.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_SelfInfo_Control_edLogin.RegisterInEngine

type
  Tkw_SelfInfo_Control_edLogin_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола edLogin
----
*Пример использования*:
[code]
контрол::edLogin:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_SelfInfo_Control_edLogin_Push

// start class Tkw_SelfInfo_Control_edLogin_Push

procedure Tkw_SelfInfo_Control_edLogin_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edLogin');
 inherited;
end;//Tkw_SelfInfo_Control_edLogin_Push.DoDoIt

class function Tkw_SelfInfo_Control_edLogin_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edLogin:push';
end;//Tkw_SelfInfo_Control_edLogin_Push.GetWordNameForRegister

type
  Tkw_SelfInfo_Control_edEmail = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола edEmail
----
*Пример использования*:
[code]
контрол::edEmail TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_SelfInfo_Control_edEmail

// start class Tkw_SelfInfo_Control_edEmail

class function Tkw_SelfInfo_Control_edEmail.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edEmail';
end;//Tkw_SelfInfo_Control_edEmail.GetWordNameForRegister

function Tkw_SelfInfo_Control_edEmail.GetString: AnsiString;
 {-}
begin
 Result := 'edEmail';
end;//Tkw_SelfInfo_Control_edEmail.GetString

class procedure Tkw_SelfInfo_Control_edEmail.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_SelfInfo_Control_edEmail.RegisterInEngine

type
  Tkw_SelfInfo_Control_edEmail_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола edEmail
----
*Пример использования*:
[code]
контрол::edEmail:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_SelfInfo_Control_edEmail_Push

// start class Tkw_SelfInfo_Control_edEmail_Push

procedure Tkw_SelfInfo_Control_edEmail_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edEmail');
 inherited;
end;//Tkw_SelfInfo_Control_edEmail_Push.DoDoIt

class function Tkw_SelfInfo_Control_edEmail_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edEmail:push';
end;//Tkw_SelfInfo_Control_edEmail_Push.GetWordNameForRegister

type
  Tkw_SelfInfo_Control_edConfirm = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола edConfirm
----
*Пример использования*:
[code]
контрол::edConfirm TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_SelfInfo_Control_edConfirm

// start class Tkw_SelfInfo_Control_edConfirm

class function Tkw_SelfInfo_Control_edConfirm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edConfirm';
end;//Tkw_SelfInfo_Control_edConfirm.GetWordNameForRegister

function Tkw_SelfInfo_Control_edConfirm.GetString: AnsiString;
 {-}
begin
 Result := 'edConfirm';
end;//Tkw_SelfInfo_Control_edConfirm.GetString

class procedure Tkw_SelfInfo_Control_edConfirm.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscComboBoxWithPwdChar);
end;//Tkw_SelfInfo_Control_edConfirm.RegisterInEngine

type
  Tkw_SelfInfo_Control_edConfirm_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола edConfirm
----
*Пример использования*:
[code]
контрол::edConfirm:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_SelfInfo_Control_edConfirm_Push

// start class Tkw_SelfInfo_Control_edConfirm_Push

procedure Tkw_SelfInfo_Control_edConfirm_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edConfirm');
 inherited;
end;//Tkw_SelfInfo_Control_edConfirm_Push.DoDoIt

class function Tkw_SelfInfo_Control_edConfirm_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edConfirm:push';
end;//Tkw_SelfInfo_Control_edConfirm_Push.GetWordNameForRegister

type
  Tkw_SelfInfo_Control_BottomPanel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола BottomPanel
----
*Пример использования*:
[code]
контрол::BottomPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_SelfInfo_Control_BottomPanel

// start class Tkw_SelfInfo_Control_BottomPanel

class function Tkw_SelfInfo_Control_BottomPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BottomPanel';
end;//Tkw_SelfInfo_Control_BottomPanel.GetWordNameForRegister

function Tkw_SelfInfo_Control_BottomPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BottomPanel';
end;//Tkw_SelfInfo_Control_BottomPanel.GetString

class procedure Tkw_SelfInfo_Control_BottomPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_SelfInfo_Control_BottomPanel.RegisterInEngine

type
  Tkw_SelfInfo_Control_BottomPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола BottomPanel
----
*Пример использования*:
[code]
контрол::BottomPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_SelfInfo_Control_BottomPanel_Push

// start class Tkw_SelfInfo_Control_BottomPanel_Push

procedure Tkw_SelfInfo_Control_BottomPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BottomPanel');
 inherited;
end;//Tkw_SelfInfo_Control_BottomPanel_Push.DoDoIt

class function Tkw_SelfInfo_Control_BottomPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BottomPanel:push';
end;//Tkw_SelfInfo_Control_BottomPanel_Push.GetWordNameForRegister

type
  Tkw_SelfInfo_Control_RegisterButton = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола RegisterButton
----
*Пример использования*:
[code]
контрол::RegisterButton TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_SelfInfo_Control_RegisterButton

// start class Tkw_SelfInfo_Control_RegisterButton

class function Tkw_SelfInfo_Control_RegisterButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RegisterButton';
end;//Tkw_SelfInfo_Control_RegisterButton.GetWordNameForRegister

function Tkw_SelfInfo_Control_RegisterButton.GetString: AnsiString;
 {-}
begin
 Result := 'RegisterButton';
end;//Tkw_SelfInfo_Control_RegisterButton.GetString

class procedure Tkw_SelfInfo_Control_RegisterButton.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_SelfInfo_Control_RegisterButton.RegisterInEngine

type
  Tkw_SelfInfo_Control_RegisterButton_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола RegisterButton
----
*Пример использования*:
[code]
контрол::RegisterButton:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_SelfInfo_Control_RegisterButton_Push

// start class Tkw_SelfInfo_Control_RegisterButton_Push

procedure Tkw_SelfInfo_Control_RegisterButton_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('RegisterButton');
 inherited;
end;//Tkw_SelfInfo_Control_RegisterButton_Push.DoDoIt

class function Tkw_SelfInfo_Control_RegisterButton_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RegisterButton:push';
end;//Tkw_SelfInfo_Control_RegisterButton_Push.GetWordNameForRegister

type
  Tkw_SelfInfo_Control_HelpPanel = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_SelfInfo_Control_HelpPanel

// start class Tkw_SelfInfo_Control_HelpPanel

class function Tkw_SelfInfo_Control_HelpPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::HelpPanel';
end;//Tkw_SelfInfo_Control_HelpPanel.GetWordNameForRegister

function Tkw_SelfInfo_Control_HelpPanel.GetString: AnsiString;
 {-}
begin
 Result := 'HelpPanel';
end;//Tkw_SelfInfo_Control_HelpPanel.GetString

class procedure Tkw_SelfInfo_Control_HelpPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_SelfInfo_Control_HelpPanel.RegisterInEngine

type
  Tkw_SelfInfo_Control_HelpPanel_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_SelfInfo_Control_HelpPanel_Push

// start class Tkw_SelfInfo_Control_HelpPanel_Push

procedure Tkw_SelfInfo_Control_HelpPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('HelpPanel');
 inherited;
end;//Tkw_SelfInfo_Control_HelpPanel_Push.DoDoIt

class function Tkw_SelfInfo_Control_HelpPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::HelpPanel:push';
end;//Tkw_SelfInfo_Control_HelpPanel_Push.GetWordNameForRegister

type
  Tkw_SelfInfo_Control_HelpPaintBox = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_SelfInfo_Control_HelpPaintBox

// start class Tkw_SelfInfo_Control_HelpPaintBox

class function Tkw_SelfInfo_Control_HelpPaintBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::HelpPaintBox';
end;//Tkw_SelfInfo_Control_HelpPaintBox.GetWordNameForRegister

function Tkw_SelfInfo_Control_HelpPaintBox.GetString: AnsiString;
 {-}
begin
 Result := 'HelpPaintBox';
end;//Tkw_SelfInfo_Control_HelpPaintBox.GetString

class procedure Tkw_SelfInfo_Control_HelpPaintBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_SelfInfo_Control_HelpPaintBox.RegisterInEngine

type
  Tkw_SelfInfo_Control_HelpPaintBox_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_SelfInfo_Control_HelpPaintBox_Push

// start class Tkw_SelfInfo_Control_HelpPaintBox_Push

procedure Tkw_SelfInfo_Control_HelpPaintBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('HelpPaintBox');
 inherited;
end;//Tkw_SelfInfo_Control_HelpPaintBox_Push.DoDoIt

class function Tkw_SelfInfo_Control_HelpPaintBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::HelpPaintBox:push';
end;//Tkw_SelfInfo_Control_HelpPaintBox_Push.GetWordNameForRegister

type
  Tkw_SelfInfo_Control_HelpLabel = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_SelfInfo_Control_HelpLabel

// start class Tkw_SelfInfo_Control_HelpLabel

class function Tkw_SelfInfo_Control_HelpLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::HelpLabel';
end;//Tkw_SelfInfo_Control_HelpLabel.GetWordNameForRegister

function Tkw_SelfInfo_Control_HelpLabel.GetString: AnsiString;
 {-}
begin
 Result := 'HelpLabel';
end;//Tkw_SelfInfo_Control_HelpLabel.GetString

class procedure Tkw_SelfInfo_Control_HelpLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtFocusLabel);
end;//Tkw_SelfInfo_Control_HelpLabel.RegisterInEngine

type
  Tkw_SelfInfo_Control_HelpLabel_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_SelfInfo_Control_HelpLabel_Push

// start class Tkw_SelfInfo_Control_HelpLabel_Push

procedure Tkw_SelfInfo_Control_HelpLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('HelpLabel');
 inherited;
end;//Tkw_SelfInfo_Control_HelpLabel_Push.DoDoIt

class function Tkw_SelfInfo_Control_HelpLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::HelpLabel:push';
end;//Tkw_SelfInfo_Control_HelpLabel_Push.GetWordNameForRegister

type
  TkwSelfInfoFormPnMainData = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TSelfInfoForm.pnMainData
[panel]Контрол pnMainData формы TSelfInfoForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aSelfInfoForm .TSelfInfoForm.pnMainData >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnMainData(const aCtx: TtfwContext;
     aSelfInfoForm: TSelfInfoForm): TvtPanel;
     {* Реализация слова скрипта .TSelfInfoForm.pnMainData }
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
  end;//TkwSelfInfoFormPnMainData

// start class TkwSelfInfoFormPnMainData

function TkwSelfInfoFormPnMainData.PnMainData(const aCtx: TtfwContext;
  aSelfInfoForm: TSelfInfoForm): TvtPanel;
 {-}
begin
 Result := aSelfInfoForm.pnMainData;
end;//TkwSelfInfoFormPnMainData.PnMainData

procedure TkwSelfInfoFormPnMainData.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSelfInfoForm : TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnMainData(aCtx, l_aSelfInfoForm)));
end;//TkwSelfInfoFormPnMainData.DoDoIt

class function TkwSelfInfoFormPnMainData.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TSelfInfoForm.pnMainData';
end;//TkwSelfInfoFormPnMainData.GetWordNameForRegister

procedure TkwSelfInfoFormPnMainData.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnMainData', aCtx);
end;//TkwSelfInfoFormPnMainData.SetValuePrim

function TkwSelfInfoFormPnMainData.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwSelfInfoFormPnMainData.GetResultTypeInfo

function TkwSelfInfoFormPnMainData.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwSelfInfoFormPnMainData.GetAllParamsCount

function TkwSelfInfoFormPnMainData.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormPnMainData.ParamsTypes

type
  TkwSelfInfoFormUserNameLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TSelfInfoForm.UserNameLabel
[panel]Контрол UserNameLabel формы TSelfInfoForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aSelfInfoForm .TSelfInfoForm.UserNameLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function UserNameLabel(const aCtx: TtfwContext;
     aSelfInfoForm: TSelfInfoForm): TvtLabel;
     {* Реализация слова скрипта .TSelfInfoForm.UserNameLabel }
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
  end;//TkwSelfInfoFormUserNameLabel

// start class TkwSelfInfoFormUserNameLabel

function TkwSelfInfoFormUserNameLabel.UserNameLabel(const aCtx: TtfwContext;
  aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {-}
begin
 Result := aSelfInfoForm.UserNameLabel;
end;//TkwSelfInfoFormUserNameLabel.UserNameLabel

procedure TkwSelfInfoFormUserNameLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSelfInfoForm : TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((UserNameLabel(aCtx, l_aSelfInfoForm)));
end;//TkwSelfInfoFormUserNameLabel.DoDoIt

class function TkwSelfInfoFormUserNameLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TSelfInfoForm.UserNameLabel';
end;//TkwSelfInfoFormUserNameLabel.GetWordNameForRegister

procedure TkwSelfInfoFormUserNameLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству UserNameLabel', aCtx);
end;//TkwSelfInfoFormUserNameLabel.SetValuePrim

function TkwSelfInfoFormUserNameLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwSelfInfoFormUserNameLabel.GetResultTypeInfo

function TkwSelfInfoFormUserNameLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwSelfInfoFormUserNameLabel.GetAllParamsCount

function TkwSelfInfoFormUserNameLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormUserNameLabel.ParamsTypes

type
  TkwSelfInfoFormPasswordLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TSelfInfoForm.PasswordLabel
[panel]Контрол PasswordLabel формы TSelfInfoForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aSelfInfoForm .TSelfInfoForm.PasswordLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function PasswordLabel(const aCtx: TtfwContext;
     aSelfInfoForm: TSelfInfoForm): TvtLabel;
     {* Реализация слова скрипта .TSelfInfoForm.PasswordLabel }
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
  end;//TkwSelfInfoFormPasswordLabel

// start class TkwSelfInfoFormPasswordLabel

function TkwSelfInfoFormPasswordLabel.PasswordLabel(const aCtx: TtfwContext;
  aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {-}
begin
 Result := aSelfInfoForm.PasswordLabel;
end;//TkwSelfInfoFormPasswordLabel.PasswordLabel

procedure TkwSelfInfoFormPasswordLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSelfInfoForm : TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PasswordLabel(aCtx, l_aSelfInfoForm)));
end;//TkwSelfInfoFormPasswordLabel.DoDoIt

class function TkwSelfInfoFormPasswordLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TSelfInfoForm.PasswordLabel';
end;//TkwSelfInfoFormPasswordLabel.GetWordNameForRegister

procedure TkwSelfInfoFormPasswordLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству PasswordLabel', aCtx);
end;//TkwSelfInfoFormPasswordLabel.SetValuePrim

function TkwSelfInfoFormPasswordLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwSelfInfoFormPasswordLabel.GetResultTypeInfo

function TkwSelfInfoFormPasswordLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwSelfInfoFormPasswordLabel.GetAllParamsCount

function TkwSelfInfoFormPasswordLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormPasswordLabel.ParamsTypes

type
  TkwSelfInfoFormLoginLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TSelfInfoForm.LoginLabel
[panel]Контрол LoginLabel формы TSelfInfoForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aSelfInfoForm .TSelfInfoForm.LoginLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LoginLabel(const aCtx: TtfwContext;
     aSelfInfoForm: TSelfInfoForm): TvtLabel;
     {* Реализация слова скрипта .TSelfInfoForm.LoginLabel }
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
  end;//TkwSelfInfoFormLoginLabel

// start class TkwSelfInfoFormLoginLabel

function TkwSelfInfoFormLoginLabel.LoginLabel(const aCtx: TtfwContext;
  aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {-}
begin
 Result := aSelfInfoForm.LoginLabel;
end;//TkwSelfInfoFormLoginLabel.LoginLabel

procedure TkwSelfInfoFormLoginLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSelfInfoForm : TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LoginLabel(aCtx, l_aSelfInfoForm)));
end;//TkwSelfInfoFormLoginLabel.DoDoIt

class function TkwSelfInfoFormLoginLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TSelfInfoForm.LoginLabel';
end;//TkwSelfInfoFormLoginLabel.GetWordNameForRegister

procedure TkwSelfInfoFormLoginLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству LoginLabel', aCtx);
end;//TkwSelfInfoFormLoginLabel.SetValuePrim

function TkwSelfInfoFormLoginLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwSelfInfoFormLoginLabel.GetResultTypeInfo

function TkwSelfInfoFormLoginLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwSelfInfoFormLoginLabel.GetAllParamsCount

function TkwSelfInfoFormLoginLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormLoginLabel.ParamsTypes

type
  TkwSelfInfoFormInfoLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TSelfInfoForm.InfoLabel
[panel]Контрол InfoLabel формы TSelfInfoForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aSelfInfoForm .TSelfInfoForm.InfoLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function InfoLabel(const aCtx: TtfwContext;
     aSelfInfoForm: TSelfInfoForm): TvtLabel;
     {* Реализация слова скрипта .TSelfInfoForm.InfoLabel }
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
  end;//TkwSelfInfoFormInfoLabel

// start class TkwSelfInfoFormInfoLabel

function TkwSelfInfoFormInfoLabel.InfoLabel(const aCtx: TtfwContext;
  aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {-}
begin
 Result := aSelfInfoForm.InfoLabel;
end;//TkwSelfInfoFormInfoLabel.InfoLabel

procedure TkwSelfInfoFormInfoLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSelfInfoForm : TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((InfoLabel(aCtx, l_aSelfInfoForm)));
end;//TkwSelfInfoFormInfoLabel.DoDoIt

class function TkwSelfInfoFormInfoLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TSelfInfoForm.InfoLabel';
end;//TkwSelfInfoFormInfoLabel.GetWordNameForRegister

procedure TkwSelfInfoFormInfoLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству InfoLabel', aCtx);
end;//TkwSelfInfoFormInfoLabel.SetValuePrim

function TkwSelfInfoFormInfoLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwSelfInfoFormInfoLabel.GetResultTypeInfo

function TkwSelfInfoFormInfoLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwSelfInfoFormInfoLabel.GetAllParamsCount

function TkwSelfInfoFormInfoLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormInfoLabel.ParamsTypes

type
  TkwSelfInfoFormEMailLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TSelfInfoForm.EMailLabel
[panel]Контрол EMailLabel формы TSelfInfoForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aSelfInfoForm .TSelfInfoForm.EMailLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function EMailLabel(const aCtx: TtfwContext;
     aSelfInfoForm: TSelfInfoForm): TvtLabel;
     {* Реализация слова скрипта .TSelfInfoForm.EMailLabel }
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
  end;//TkwSelfInfoFormEMailLabel

// start class TkwSelfInfoFormEMailLabel

function TkwSelfInfoFormEMailLabel.EMailLabel(const aCtx: TtfwContext;
  aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {-}
begin
 Result := aSelfInfoForm.EMailLabel;
end;//TkwSelfInfoFormEMailLabel.EMailLabel

procedure TkwSelfInfoFormEMailLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSelfInfoForm : TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EMailLabel(aCtx, l_aSelfInfoForm)));
end;//TkwSelfInfoFormEMailLabel.DoDoIt

class function TkwSelfInfoFormEMailLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TSelfInfoForm.EMailLabel';
end;//TkwSelfInfoFormEMailLabel.GetWordNameForRegister

procedure TkwSelfInfoFormEMailLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству EMailLabel', aCtx);
end;//TkwSelfInfoFormEMailLabel.SetValuePrim

function TkwSelfInfoFormEMailLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwSelfInfoFormEMailLabel.GetResultTypeInfo

function TkwSelfInfoFormEMailLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwSelfInfoFormEMailLabel.GetAllParamsCount

function TkwSelfInfoFormEMailLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormEMailLabel.ParamsTypes

type
  TkwSelfInfoFormConfirmPasswordLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TSelfInfoForm.ConfirmPasswordLabel
[panel]Контрол ConfirmPasswordLabel формы TSelfInfoForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aSelfInfoForm .TSelfInfoForm.ConfirmPasswordLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function ConfirmPasswordLabel(const aCtx: TtfwContext;
     aSelfInfoForm: TSelfInfoForm): TvtLabel;
     {* Реализация слова скрипта .TSelfInfoForm.ConfirmPasswordLabel }
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
  end;//TkwSelfInfoFormConfirmPasswordLabel

// start class TkwSelfInfoFormConfirmPasswordLabel

function TkwSelfInfoFormConfirmPasswordLabel.ConfirmPasswordLabel(const aCtx: TtfwContext;
  aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {-}
begin
 Result := aSelfInfoForm.ConfirmPasswordLabel;
end;//TkwSelfInfoFormConfirmPasswordLabel.ConfirmPasswordLabel

procedure TkwSelfInfoFormConfirmPasswordLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSelfInfoForm : TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ConfirmPasswordLabel(aCtx, l_aSelfInfoForm)));
end;//TkwSelfInfoFormConfirmPasswordLabel.DoDoIt

class function TkwSelfInfoFormConfirmPasswordLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TSelfInfoForm.ConfirmPasswordLabel';
end;//TkwSelfInfoFormConfirmPasswordLabel.GetWordNameForRegister

procedure TkwSelfInfoFormConfirmPasswordLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ConfirmPasswordLabel', aCtx);
end;//TkwSelfInfoFormConfirmPasswordLabel.SetValuePrim

function TkwSelfInfoFormConfirmPasswordLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwSelfInfoFormConfirmPasswordLabel.GetResultTypeInfo

function TkwSelfInfoFormConfirmPasswordLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwSelfInfoFormConfirmPasswordLabel.GetAllParamsCount

function TkwSelfInfoFormConfirmPasswordLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormConfirmPasswordLabel.ParamsTypes

type
  TkwSelfInfoFormVtAsteriskLabelLogin = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TSelfInfoForm.vtAsteriskLabelLogin
[panel]Контрол vtAsteriskLabelLogin формы TSelfInfoForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aSelfInfoForm .TSelfInfoForm.vtAsteriskLabelLogin >>> l_TvtLabel
[code]  }
  private
  // private methods
   function VtAsteriskLabelLogin(const aCtx: TtfwContext;
     aSelfInfoForm: TSelfInfoForm): TvtLabel;
     {* Реализация слова скрипта .TSelfInfoForm.vtAsteriskLabelLogin }
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
  end;//TkwSelfInfoFormVtAsteriskLabelLogin

// start class TkwSelfInfoFormVtAsteriskLabelLogin

function TkwSelfInfoFormVtAsteriskLabelLogin.VtAsteriskLabelLogin(const aCtx: TtfwContext;
  aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {-}
begin
 Result := aSelfInfoForm.vtAsteriskLabelLogin;
end;//TkwSelfInfoFormVtAsteriskLabelLogin.VtAsteriskLabelLogin

procedure TkwSelfInfoFormVtAsteriskLabelLogin.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSelfInfoForm : TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((VtAsteriskLabelLogin(aCtx, l_aSelfInfoForm)));
end;//TkwSelfInfoFormVtAsteriskLabelLogin.DoDoIt

class function TkwSelfInfoFormVtAsteriskLabelLogin.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TSelfInfoForm.vtAsteriskLabelLogin';
end;//TkwSelfInfoFormVtAsteriskLabelLogin.GetWordNameForRegister

procedure TkwSelfInfoFormVtAsteriskLabelLogin.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству vtAsteriskLabelLogin', aCtx);
end;//TkwSelfInfoFormVtAsteriskLabelLogin.SetValuePrim

function TkwSelfInfoFormVtAsteriskLabelLogin.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwSelfInfoFormVtAsteriskLabelLogin.GetResultTypeInfo

function TkwSelfInfoFormVtAsteriskLabelLogin.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwSelfInfoFormVtAsteriskLabelLogin.GetAllParamsCount

function TkwSelfInfoFormVtAsteriskLabelLogin.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormVtAsteriskLabelLogin.ParamsTypes

type
  TkwSelfInfoFormVtAsteriskLabelFIO = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TSelfInfoForm.vtAsteriskLabelFIO
[panel]Контрол vtAsteriskLabelFIO формы TSelfInfoForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aSelfInfoForm .TSelfInfoForm.vtAsteriskLabelFIO >>> l_TvtLabel
[code]  }
  private
  // private methods
   function VtAsteriskLabelFIO(const aCtx: TtfwContext;
     aSelfInfoForm: TSelfInfoForm): TvtLabel;
     {* Реализация слова скрипта .TSelfInfoForm.vtAsteriskLabelFIO }
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
  end;//TkwSelfInfoFormVtAsteriskLabelFIO

// start class TkwSelfInfoFormVtAsteriskLabelFIO

function TkwSelfInfoFormVtAsteriskLabelFIO.VtAsteriskLabelFIO(const aCtx: TtfwContext;
  aSelfInfoForm: TSelfInfoForm): TvtLabel;
 {-}
begin
 Result := aSelfInfoForm.vtAsteriskLabelFIO;
end;//TkwSelfInfoFormVtAsteriskLabelFIO.VtAsteriskLabelFIO

procedure TkwSelfInfoFormVtAsteriskLabelFIO.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSelfInfoForm : TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((VtAsteriskLabelFIO(aCtx, l_aSelfInfoForm)));
end;//TkwSelfInfoFormVtAsteriskLabelFIO.DoDoIt

class function TkwSelfInfoFormVtAsteriskLabelFIO.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TSelfInfoForm.vtAsteriskLabelFIO';
end;//TkwSelfInfoFormVtAsteriskLabelFIO.GetWordNameForRegister

procedure TkwSelfInfoFormVtAsteriskLabelFIO.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству vtAsteriskLabelFIO', aCtx);
end;//TkwSelfInfoFormVtAsteriskLabelFIO.SetValuePrim

function TkwSelfInfoFormVtAsteriskLabelFIO.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwSelfInfoFormVtAsteriskLabelFIO.GetResultTypeInfo

function TkwSelfInfoFormVtAsteriskLabelFIO.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwSelfInfoFormVtAsteriskLabelFIO.GetAllParamsCount

function TkwSelfInfoFormVtAsteriskLabelFIO.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormVtAsteriskLabelFIO.ParamsTypes

type
  TkwSelfInfoFormEdPassword = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TSelfInfoForm.edPassword
[panel]Контрол edPassword формы TSelfInfoForm[panel]
*Тип результата:* TnscComboBoxWithPwdChar
*Пример:*
[code]
OBJECT VAR l_TnscComboBoxWithPwdChar
 aSelfInfoForm .TSelfInfoForm.edPassword >>> l_TnscComboBoxWithPwdChar
[code]  }
  private
  // private methods
   function EdPassword(const aCtx: TtfwContext;
     aSelfInfoForm: TSelfInfoForm): TnscComboBoxWithPwdChar;
     {* Реализация слова скрипта .TSelfInfoForm.edPassword }
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
  end;//TkwSelfInfoFormEdPassword

// start class TkwSelfInfoFormEdPassword

function TkwSelfInfoFormEdPassword.EdPassword(const aCtx: TtfwContext;
  aSelfInfoForm: TSelfInfoForm): TnscComboBoxWithPwdChar;
 {-}
begin
 Result := aSelfInfoForm.edPassword;
end;//TkwSelfInfoFormEdPassword.EdPassword

procedure TkwSelfInfoFormEdPassword.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSelfInfoForm : TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EdPassword(aCtx, l_aSelfInfoForm)));
end;//TkwSelfInfoFormEdPassword.DoDoIt

class function TkwSelfInfoFormEdPassword.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TSelfInfoForm.edPassword';
end;//TkwSelfInfoFormEdPassword.GetWordNameForRegister

procedure TkwSelfInfoFormEdPassword.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству edPassword', aCtx);
end;//TkwSelfInfoFormEdPassword.SetValuePrim

function TkwSelfInfoFormEdPassword.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscComboBoxWithPwdChar);
end;//TkwSelfInfoFormEdPassword.GetResultTypeInfo

function TkwSelfInfoFormEdPassword.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwSelfInfoFormEdPassword.GetAllParamsCount

function TkwSelfInfoFormEdPassword.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormEdPassword.ParamsTypes

type
  TkwSelfInfoFormEdUserName = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TSelfInfoForm.edUserName
[panel]Контрол edUserName формы TSelfInfoForm[panel]
*Тип результата:* TnscEdit
*Пример:*
[code]
OBJECT VAR l_TnscEdit
 aSelfInfoForm .TSelfInfoForm.edUserName >>> l_TnscEdit
[code]  }
  private
  // private methods
   function EdUserName(const aCtx: TtfwContext;
     aSelfInfoForm: TSelfInfoForm): TnscEdit;
     {* Реализация слова скрипта .TSelfInfoForm.edUserName }
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
  end;//TkwSelfInfoFormEdUserName

// start class TkwSelfInfoFormEdUserName

function TkwSelfInfoFormEdUserName.EdUserName(const aCtx: TtfwContext;
  aSelfInfoForm: TSelfInfoForm): TnscEdit;
 {-}
begin
 Result := aSelfInfoForm.edUserName;
end;//TkwSelfInfoFormEdUserName.EdUserName

procedure TkwSelfInfoFormEdUserName.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSelfInfoForm : TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EdUserName(aCtx, l_aSelfInfoForm)));
end;//TkwSelfInfoFormEdUserName.DoDoIt

class function TkwSelfInfoFormEdUserName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TSelfInfoForm.edUserName';
end;//TkwSelfInfoFormEdUserName.GetWordNameForRegister

procedure TkwSelfInfoFormEdUserName.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству edUserName', aCtx);
end;//TkwSelfInfoFormEdUserName.SetValuePrim

function TkwSelfInfoFormEdUserName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEdit);
end;//TkwSelfInfoFormEdUserName.GetResultTypeInfo

function TkwSelfInfoFormEdUserName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwSelfInfoFormEdUserName.GetAllParamsCount

function TkwSelfInfoFormEdUserName.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormEdUserName.ParamsTypes

type
  TkwSelfInfoFormEdLogin = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TSelfInfoForm.edLogin
[panel]Контрол edLogin формы TSelfInfoForm[panel]
*Тип результата:* TnscEdit
*Пример:*
[code]
OBJECT VAR l_TnscEdit
 aSelfInfoForm .TSelfInfoForm.edLogin >>> l_TnscEdit
[code]  }
  private
  // private methods
   function EdLogin(const aCtx: TtfwContext;
     aSelfInfoForm: TSelfInfoForm): TnscEdit;
     {* Реализация слова скрипта .TSelfInfoForm.edLogin }
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
  end;//TkwSelfInfoFormEdLogin

// start class TkwSelfInfoFormEdLogin

function TkwSelfInfoFormEdLogin.EdLogin(const aCtx: TtfwContext;
  aSelfInfoForm: TSelfInfoForm): TnscEdit;
 {-}
begin
 Result := aSelfInfoForm.edLogin;
end;//TkwSelfInfoFormEdLogin.EdLogin

procedure TkwSelfInfoFormEdLogin.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSelfInfoForm : TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EdLogin(aCtx, l_aSelfInfoForm)));
end;//TkwSelfInfoFormEdLogin.DoDoIt

class function TkwSelfInfoFormEdLogin.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TSelfInfoForm.edLogin';
end;//TkwSelfInfoFormEdLogin.GetWordNameForRegister

procedure TkwSelfInfoFormEdLogin.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству edLogin', aCtx);
end;//TkwSelfInfoFormEdLogin.SetValuePrim

function TkwSelfInfoFormEdLogin.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEdit);
end;//TkwSelfInfoFormEdLogin.GetResultTypeInfo

function TkwSelfInfoFormEdLogin.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwSelfInfoFormEdLogin.GetAllParamsCount

function TkwSelfInfoFormEdLogin.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormEdLogin.ParamsTypes

type
  TkwSelfInfoFormEdEmail = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TSelfInfoForm.edEmail
[panel]Контрол edEmail формы TSelfInfoForm[panel]
*Тип результата:* TnscEdit
*Пример:*
[code]
OBJECT VAR l_TnscEdit
 aSelfInfoForm .TSelfInfoForm.edEmail >>> l_TnscEdit
[code]  }
  private
  // private methods
   function EdEmail(const aCtx: TtfwContext;
     aSelfInfoForm: TSelfInfoForm): TnscEdit;
     {* Реализация слова скрипта .TSelfInfoForm.edEmail }
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
  end;//TkwSelfInfoFormEdEmail

// start class TkwSelfInfoFormEdEmail

function TkwSelfInfoFormEdEmail.EdEmail(const aCtx: TtfwContext;
  aSelfInfoForm: TSelfInfoForm): TnscEdit;
 {-}
begin
 Result := aSelfInfoForm.edEmail;
end;//TkwSelfInfoFormEdEmail.EdEmail

procedure TkwSelfInfoFormEdEmail.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSelfInfoForm : TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EdEmail(aCtx, l_aSelfInfoForm)));
end;//TkwSelfInfoFormEdEmail.DoDoIt

class function TkwSelfInfoFormEdEmail.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TSelfInfoForm.edEmail';
end;//TkwSelfInfoFormEdEmail.GetWordNameForRegister

procedure TkwSelfInfoFormEdEmail.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству edEmail', aCtx);
end;//TkwSelfInfoFormEdEmail.SetValuePrim

function TkwSelfInfoFormEdEmail.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEdit);
end;//TkwSelfInfoFormEdEmail.GetResultTypeInfo

function TkwSelfInfoFormEdEmail.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwSelfInfoFormEdEmail.GetAllParamsCount

function TkwSelfInfoFormEdEmail.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormEdEmail.ParamsTypes

type
  TkwSelfInfoFormEdConfirm = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TSelfInfoForm.edConfirm
[panel]Контрол edConfirm формы TSelfInfoForm[panel]
*Тип результата:* TnscComboBoxWithPwdChar
*Пример:*
[code]
OBJECT VAR l_TnscComboBoxWithPwdChar
 aSelfInfoForm .TSelfInfoForm.edConfirm >>> l_TnscComboBoxWithPwdChar
[code]  }
  private
  // private methods
   function EdConfirm(const aCtx: TtfwContext;
     aSelfInfoForm: TSelfInfoForm): TnscComboBoxWithPwdChar;
     {* Реализация слова скрипта .TSelfInfoForm.edConfirm }
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
  end;//TkwSelfInfoFormEdConfirm

// start class TkwSelfInfoFormEdConfirm

function TkwSelfInfoFormEdConfirm.EdConfirm(const aCtx: TtfwContext;
  aSelfInfoForm: TSelfInfoForm): TnscComboBoxWithPwdChar;
 {-}
begin
 Result := aSelfInfoForm.edConfirm;
end;//TkwSelfInfoFormEdConfirm.EdConfirm

procedure TkwSelfInfoFormEdConfirm.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSelfInfoForm : TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EdConfirm(aCtx, l_aSelfInfoForm)));
end;//TkwSelfInfoFormEdConfirm.DoDoIt

class function TkwSelfInfoFormEdConfirm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TSelfInfoForm.edConfirm';
end;//TkwSelfInfoFormEdConfirm.GetWordNameForRegister

procedure TkwSelfInfoFormEdConfirm.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству edConfirm', aCtx);
end;//TkwSelfInfoFormEdConfirm.SetValuePrim

function TkwSelfInfoFormEdConfirm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscComboBoxWithPwdChar);
end;//TkwSelfInfoFormEdConfirm.GetResultTypeInfo

function TkwSelfInfoFormEdConfirm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwSelfInfoFormEdConfirm.GetAllParamsCount

function TkwSelfInfoFormEdConfirm.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormEdConfirm.ParamsTypes

type
  TkwSelfInfoFormBottomPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TSelfInfoForm.BottomPanel
[panel]Контрол BottomPanel формы TSelfInfoForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aSelfInfoForm .TSelfInfoForm.BottomPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function BottomPanel(const aCtx: TtfwContext;
     aSelfInfoForm: TSelfInfoForm): TvtPanel;
     {* Реализация слова скрипта .TSelfInfoForm.BottomPanel }
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
  end;//TkwSelfInfoFormBottomPanel

// start class TkwSelfInfoFormBottomPanel

function TkwSelfInfoFormBottomPanel.BottomPanel(const aCtx: TtfwContext;
  aSelfInfoForm: TSelfInfoForm): TvtPanel;
 {-}
begin
 Result := aSelfInfoForm.BottomPanel;
end;//TkwSelfInfoFormBottomPanel.BottomPanel

procedure TkwSelfInfoFormBottomPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSelfInfoForm : TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BottomPanel(aCtx, l_aSelfInfoForm)));
end;//TkwSelfInfoFormBottomPanel.DoDoIt

class function TkwSelfInfoFormBottomPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TSelfInfoForm.BottomPanel';
end;//TkwSelfInfoFormBottomPanel.GetWordNameForRegister

procedure TkwSelfInfoFormBottomPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству BottomPanel', aCtx);
end;//TkwSelfInfoFormBottomPanel.SetValuePrim

function TkwSelfInfoFormBottomPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwSelfInfoFormBottomPanel.GetResultTypeInfo

function TkwSelfInfoFormBottomPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwSelfInfoFormBottomPanel.GetAllParamsCount

function TkwSelfInfoFormBottomPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormBottomPanel.ParamsTypes

type
  TkwSelfInfoFormRegisterButton = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TSelfInfoForm.RegisterButton
[panel]Контрол RegisterButton формы TSelfInfoForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aSelfInfoForm .TSelfInfoForm.RegisterButton >>> l_TElPopupButton
[code]  }
  private
  // private methods
   function RegisterButton(const aCtx: TtfwContext;
     aSelfInfoForm: TSelfInfoForm): TElPopupButton;
     {* Реализация слова скрипта .TSelfInfoForm.RegisterButton }
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
  end;//TkwSelfInfoFormRegisterButton

// start class TkwSelfInfoFormRegisterButton

function TkwSelfInfoFormRegisterButton.RegisterButton(const aCtx: TtfwContext;
  aSelfInfoForm: TSelfInfoForm): TElPopupButton;
 {-}
begin
 Result := aSelfInfoForm.RegisterButton;
end;//TkwSelfInfoFormRegisterButton.RegisterButton

procedure TkwSelfInfoFormRegisterButton.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSelfInfoForm : TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RegisterButton(aCtx, l_aSelfInfoForm)));
end;//TkwSelfInfoFormRegisterButton.DoDoIt

class function TkwSelfInfoFormRegisterButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TSelfInfoForm.RegisterButton';
end;//TkwSelfInfoFormRegisterButton.GetWordNameForRegister

procedure TkwSelfInfoFormRegisterButton.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству RegisterButton', aCtx);
end;//TkwSelfInfoFormRegisterButton.SetValuePrim

function TkwSelfInfoFormRegisterButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwSelfInfoFormRegisterButton.GetResultTypeInfo

function TkwSelfInfoFormRegisterButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwSelfInfoFormRegisterButton.GetAllParamsCount

function TkwSelfInfoFormRegisterButton.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormRegisterButton.ParamsTypes

type
  TkwSelfInfoFormHelpPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TSelfInfoForm.HelpPanel
[panel]Контрол HelpPanel формы TSelfInfoForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aSelfInfoForm .TSelfInfoForm.HelpPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function HelpPanel(const aCtx: TtfwContext;
     aSelfInfoForm: TSelfInfoForm): TvtPanel;
     {* Реализация слова скрипта .TSelfInfoForm.HelpPanel }
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
  end;//TkwSelfInfoFormHelpPanel

// start class TkwSelfInfoFormHelpPanel

function TkwSelfInfoFormHelpPanel.HelpPanel(const aCtx: TtfwContext;
  aSelfInfoForm: TSelfInfoForm): TvtPanel;
 {-}
begin
 Result := aSelfInfoForm.HelpPanel;
end;//TkwSelfInfoFormHelpPanel.HelpPanel

procedure TkwSelfInfoFormHelpPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSelfInfoForm : TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((HelpPanel(aCtx, l_aSelfInfoForm)));
end;//TkwSelfInfoFormHelpPanel.DoDoIt

class function TkwSelfInfoFormHelpPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TSelfInfoForm.HelpPanel';
end;//TkwSelfInfoFormHelpPanel.GetWordNameForRegister

procedure TkwSelfInfoFormHelpPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству HelpPanel', aCtx);
end;//TkwSelfInfoFormHelpPanel.SetValuePrim

function TkwSelfInfoFormHelpPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwSelfInfoFormHelpPanel.GetResultTypeInfo

function TkwSelfInfoFormHelpPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwSelfInfoFormHelpPanel.GetAllParamsCount

function TkwSelfInfoFormHelpPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormHelpPanel.ParamsTypes

type
  TkwSelfInfoFormHelpPaintBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TSelfInfoForm.HelpPaintBox
[panel]Контрол HelpPaintBox формы TSelfInfoForm[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aSelfInfoForm .TSelfInfoForm.HelpPaintBox >>> l_TPaintBox
[code]  }
  private
  // private methods
   function HelpPaintBox(const aCtx: TtfwContext;
     aSelfInfoForm: TSelfInfoForm): TPaintBox;
     {* Реализация слова скрипта .TSelfInfoForm.HelpPaintBox }
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
  end;//TkwSelfInfoFormHelpPaintBox

// start class TkwSelfInfoFormHelpPaintBox

function TkwSelfInfoFormHelpPaintBox.HelpPaintBox(const aCtx: TtfwContext;
  aSelfInfoForm: TSelfInfoForm): TPaintBox;
 {-}
begin
 Result := aSelfInfoForm.HelpPaintBox;
end;//TkwSelfInfoFormHelpPaintBox.HelpPaintBox

procedure TkwSelfInfoFormHelpPaintBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSelfInfoForm : TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((HelpPaintBox(aCtx, l_aSelfInfoForm)));
end;//TkwSelfInfoFormHelpPaintBox.DoDoIt

class function TkwSelfInfoFormHelpPaintBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TSelfInfoForm.HelpPaintBox';
end;//TkwSelfInfoFormHelpPaintBox.GetWordNameForRegister

procedure TkwSelfInfoFormHelpPaintBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству HelpPaintBox', aCtx);
end;//TkwSelfInfoFormHelpPaintBox.SetValuePrim

function TkwSelfInfoFormHelpPaintBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TPaintBox);
end;//TkwSelfInfoFormHelpPaintBox.GetResultTypeInfo

function TkwSelfInfoFormHelpPaintBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwSelfInfoFormHelpPaintBox.GetAllParamsCount

function TkwSelfInfoFormHelpPaintBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormHelpPaintBox.ParamsTypes

type
  TkwSelfInfoFormHelpLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TSelfInfoForm.HelpLabel
[panel]Контрол HelpLabel формы TSelfInfoForm[panel]
*Тип результата:* TvtFocusLabel
*Пример:*
[code]
OBJECT VAR l_TvtFocusLabel
 aSelfInfoForm .TSelfInfoForm.HelpLabel >>> l_TvtFocusLabel
[code]  }
  private
  // private methods
   function HelpLabel(const aCtx: TtfwContext;
     aSelfInfoForm: TSelfInfoForm): TvtFocusLabel;
     {* Реализация слова скрипта .TSelfInfoForm.HelpLabel }
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
  end;//TkwSelfInfoFormHelpLabel

// start class TkwSelfInfoFormHelpLabel

function TkwSelfInfoFormHelpLabel.HelpLabel(const aCtx: TtfwContext;
  aSelfInfoForm: TSelfInfoForm): TvtFocusLabel;
 {-}
begin
 Result := aSelfInfoForm.HelpLabel;
end;//TkwSelfInfoFormHelpLabel.HelpLabel

procedure TkwSelfInfoFormHelpLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSelfInfoForm : TSelfInfoForm;
begin
 try
  l_aSelfInfoForm := TSelfInfoForm(aCtx.rEngine.PopObjAs(TSelfInfoForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSelfInfoForm: TSelfInfoForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((HelpLabel(aCtx, l_aSelfInfoForm)));
end;//TkwSelfInfoFormHelpLabel.DoDoIt

class function TkwSelfInfoFormHelpLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TSelfInfoForm.HelpLabel';
end;//TkwSelfInfoFormHelpLabel.GetWordNameForRegister

procedure TkwSelfInfoFormHelpLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству HelpLabel', aCtx);
end;//TkwSelfInfoFormHelpLabel.SetValuePrim

function TkwSelfInfoFormHelpLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtFocusLabel);
end;//TkwSelfInfoFormHelpLabel.GetResultTypeInfo

function TkwSelfInfoFormHelpLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwSelfInfoFormHelpLabel.GetAllParamsCount

function TkwSelfInfoFormHelpLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TSelfInfoForm)]);
end;//TkwSelfInfoFormHelpLabel.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_SelfInfo
 Tkw_Form_SelfInfo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_pnMainData
 Tkw_SelfInfo_Control_pnMainData.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_pnMainData_Push
 Tkw_SelfInfo_Control_pnMainData_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_UserNameLabel
 Tkw_SelfInfo_Control_UserNameLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_UserNameLabel_Push
 Tkw_SelfInfo_Control_UserNameLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_PasswordLabel
 Tkw_SelfInfo_Control_PasswordLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_PasswordLabel_Push
 Tkw_SelfInfo_Control_PasswordLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_LoginLabel
 Tkw_SelfInfo_Control_LoginLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_LoginLabel_Push
 Tkw_SelfInfo_Control_LoginLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_InfoLabel
 Tkw_SelfInfo_Control_InfoLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_InfoLabel_Push
 Tkw_SelfInfo_Control_InfoLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_EMailLabel
 Tkw_SelfInfo_Control_EMailLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_EMailLabel_Push
 Tkw_SelfInfo_Control_EMailLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_ConfirmPasswordLabel
 Tkw_SelfInfo_Control_ConfirmPasswordLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push
 Tkw_SelfInfo_Control_ConfirmPasswordLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_vtAsteriskLabelLogin
 Tkw_SelfInfo_Control_vtAsteriskLabelLogin.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push
 Tkw_SelfInfo_Control_vtAsteriskLabelLogin_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_vtAsteriskLabelFIO
 Tkw_SelfInfo_Control_vtAsteriskLabelFIO.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push
 Tkw_SelfInfo_Control_vtAsteriskLabelFIO_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_edPassword
 Tkw_SelfInfo_Control_edPassword.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_edPassword_Push
 Tkw_SelfInfo_Control_edPassword_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_edUserName
 Tkw_SelfInfo_Control_edUserName.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_edUserName_Push
 Tkw_SelfInfo_Control_edUserName_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_edLogin
 Tkw_SelfInfo_Control_edLogin.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_edLogin_Push
 Tkw_SelfInfo_Control_edLogin_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_edEmail
 Tkw_SelfInfo_Control_edEmail.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_edEmail_Push
 Tkw_SelfInfo_Control_edEmail_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_edConfirm
 Tkw_SelfInfo_Control_edConfirm.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_edConfirm_Push
 Tkw_SelfInfo_Control_edConfirm_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_BottomPanel
 Tkw_SelfInfo_Control_BottomPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_BottomPanel_Push
 Tkw_SelfInfo_Control_BottomPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_RegisterButton
 Tkw_SelfInfo_Control_RegisterButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_RegisterButton_Push
 Tkw_SelfInfo_Control_RegisterButton_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_HelpPanel
 Tkw_SelfInfo_Control_HelpPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_HelpPanel_Push
 Tkw_SelfInfo_Control_HelpPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_HelpPaintBox
 Tkw_SelfInfo_Control_HelpPaintBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_HelpPaintBox_Push
 Tkw_SelfInfo_Control_HelpPaintBox_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_HelpLabel
 Tkw_SelfInfo_Control_HelpLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_SelfInfo_Control_HelpLabel_Push
 Tkw_SelfInfo_Control_HelpLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация SelfInfoForm_pnMainData
 TkwSelfInfoFormPnMainData.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация SelfInfoForm_UserNameLabel
 TkwSelfInfoFormUserNameLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация SelfInfoForm_PasswordLabel
 TkwSelfInfoFormPasswordLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация SelfInfoForm_LoginLabel
 TkwSelfInfoFormLoginLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация SelfInfoForm_InfoLabel
 TkwSelfInfoFormInfoLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация SelfInfoForm_EMailLabel
 TkwSelfInfoFormEMailLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация SelfInfoForm_ConfirmPasswordLabel
 TkwSelfInfoFormConfirmPasswordLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация SelfInfoForm_vtAsteriskLabelLogin
 TkwSelfInfoFormVtAsteriskLabelLogin.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация SelfInfoForm_vtAsteriskLabelFIO
 TkwSelfInfoFormVtAsteriskLabelFIO.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация SelfInfoForm_edPassword
 TkwSelfInfoFormEdPassword.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация SelfInfoForm_edUserName
 TkwSelfInfoFormEdUserName.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация SelfInfoForm_edLogin
 TkwSelfInfoFormEdLogin.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация SelfInfoForm_edEmail
 TkwSelfInfoFormEdEmail.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация SelfInfoForm_edConfirm
 TkwSelfInfoFormEdConfirm.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация SelfInfoForm_BottomPanel
 TkwSelfInfoFormBottomPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация SelfInfoForm_RegisterButton
 TkwSelfInfoFormRegisterButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация SelfInfoForm_HelpPanel
 TkwSelfInfoFormHelpPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация SelfInfoForm_HelpPaintBox
 TkwSelfInfoFormHelpPaintBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация SelfInfoForm_HelpLabel
 TkwSelfInfoFormHelpLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа SelfInfo
 TtfwTypeRegistrator.RegisterType(TypeInfo(TSelfInfoForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscComboBoxWithPwdChar
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscComboBoxWithPwdChar));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscEdit
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEdit));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TElPopupButton
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElPopupButton));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TPaintBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtFocusLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtFocusLabel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.
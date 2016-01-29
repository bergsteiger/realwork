unit AboutKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/AboutKeywordsPack.pas"
// Начат: 24.08.2009 20:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Core::Common::View::Common::PrimF1Common::AboutKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы About
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
  About_Form,
  vtGroupBox,
  vtLabel,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  vtButton,
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
  Tkw_Form_About = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы About
----
*Пример использования*:
[code]
'aControl' форма::About TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_About

// start class Tkw_Form_About

class function Tkw_Form_About.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::About';
end;//Tkw_Form_About.GetWordNameForRegister

function Tkw_Form_About.GetString: AnsiString;
 {-}
begin
 Result := 'efAbout';
end;//Tkw_Form_About.GetString

type
  Tkw_About_Control_pbLogo = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pbLogo
----
*Пример использования*:
[code]
контрол::pbLogo TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_About_Control_pbLogo

// start class Tkw_About_Control_pbLogo

class function Tkw_About_Control_pbLogo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pbLogo';
end;//Tkw_About_Control_pbLogo.GetWordNameForRegister

function Tkw_About_Control_pbLogo.GetString: AnsiString;
 {-}
begin
 Result := 'pbLogo';
end;//Tkw_About_Control_pbLogo.GetString

class procedure Tkw_About_Control_pbLogo.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_About_Control_pbLogo.RegisterInEngine

type
  Tkw_About_Control_pbLogo_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pbLogo
----
*Пример использования*:
[code]
контрол::pbLogo:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_About_Control_pbLogo_Push

// start class Tkw_About_Control_pbLogo_Push

procedure Tkw_About_Control_pbLogo_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pbLogo');
 inherited;
end;//Tkw_About_Control_pbLogo_Push.DoDoIt

class function Tkw_About_Control_pbLogo_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pbLogo:push';
end;//Tkw_About_Control_pbLogo_Push.GetWordNameForRegister

type
  Tkw_About_Control_ShellInfoLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола ShellInfoLabel
----
*Пример использования*:
[code]
контрол::ShellInfoLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_About_Control_ShellInfoLabel

// start class Tkw_About_Control_ShellInfoLabel

class function Tkw_About_Control_ShellInfoLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ShellInfoLabel';
end;//Tkw_About_Control_ShellInfoLabel.GetWordNameForRegister

function Tkw_About_Control_ShellInfoLabel.GetString: AnsiString;
 {-}
begin
 Result := 'ShellInfoLabel';
end;//Tkw_About_Control_ShellInfoLabel.GetString

class procedure Tkw_About_Control_ShellInfoLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_ShellInfoLabel.RegisterInEngine

type
  Tkw_About_Control_ShellInfoLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола ShellInfoLabel
----
*Пример использования*:
[code]
контрол::ShellInfoLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_About_Control_ShellInfoLabel_Push

// start class Tkw_About_Control_ShellInfoLabel_Push

procedure Tkw_About_Control_ShellInfoLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ShellInfoLabel');
 inherited;
end;//Tkw_About_Control_ShellInfoLabel_Push.DoDoIt

class function Tkw_About_Control_ShellInfoLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ShellInfoLabel:push';
end;//Tkw_About_Control_ShellInfoLabel_Push.GetWordNameForRegister

type
  Tkw_About_Control_AdapterInfoLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола AdapterInfoLabel
----
*Пример использования*:
[code]
контрол::AdapterInfoLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_About_Control_AdapterInfoLabel

// start class Tkw_About_Control_AdapterInfoLabel

class function Tkw_About_Control_AdapterInfoLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::AdapterInfoLabel';
end;//Tkw_About_Control_AdapterInfoLabel.GetWordNameForRegister

function Tkw_About_Control_AdapterInfoLabel.GetString: AnsiString;
 {-}
begin
 Result := 'AdapterInfoLabel';
end;//Tkw_About_Control_AdapterInfoLabel.GetString

class procedure Tkw_About_Control_AdapterInfoLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_AdapterInfoLabel.RegisterInEngine

type
  Tkw_About_Control_AdapterInfoLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола AdapterInfoLabel
----
*Пример использования*:
[code]
контрол::AdapterInfoLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_About_Control_AdapterInfoLabel_Push

// start class Tkw_About_Control_AdapterInfoLabel_Push

procedure Tkw_About_Control_AdapterInfoLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('AdapterInfoLabel');
 inherited;
end;//Tkw_About_Control_AdapterInfoLabel_Push.DoDoIt

class function Tkw_About_Control_AdapterInfoLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::AdapterInfoLabel:push';
end;//Tkw_About_Control_AdapterInfoLabel_Push.GetWordNameForRegister

type
  Tkw_About_Control_UserCountLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола UserCountLabel
----
*Пример использования*:
[code]
контрол::UserCountLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_About_Control_UserCountLabel

// start class Tkw_About_Control_UserCountLabel

class function Tkw_About_Control_UserCountLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::UserCountLabel';
end;//Tkw_About_Control_UserCountLabel.GetWordNameForRegister

function Tkw_About_Control_UserCountLabel.GetString: AnsiString;
 {-}
begin
 Result := 'UserCountLabel';
end;//Tkw_About_Control_UserCountLabel.GetString

class procedure Tkw_About_Control_UserCountLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_UserCountLabel.RegisterInEngine

type
  Tkw_About_Control_UserCountLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола UserCountLabel
----
*Пример использования*:
[code]
контрол::UserCountLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_About_Control_UserCountLabel_Push

// start class Tkw_About_Control_UserCountLabel_Push

procedure Tkw_About_Control_UserCountLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('UserCountLabel');
 inherited;
end;//Tkw_About_Control_UserCountLabel_Push.DoDoIt

class function Tkw_About_Control_UserCountLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::UserCountLabel:push';
end;//Tkw_About_Control_UserCountLabel_Push.GetWordNameForRegister

type
  Tkw_About_Control_OwnerLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола OwnerLabel
----
*Пример использования*:
[code]
контрол::OwnerLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_About_Control_OwnerLabel

// start class Tkw_About_Control_OwnerLabel

class function Tkw_About_Control_OwnerLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::OwnerLabel';
end;//Tkw_About_Control_OwnerLabel.GetWordNameForRegister

function Tkw_About_Control_OwnerLabel.GetString: AnsiString;
 {-}
begin
 Result := 'OwnerLabel';
end;//Tkw_About_Control_OwnerLabel.GetString

class procedure Tkw_About_Control_OwnerLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_OwnerLabel.RegisterInEngine

type
  Tkw_About_Control_OwnerLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола OwnerLabel
----
*Пример использования*:
[code]
контрол::OwnerLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_About_Control_OwnerLabel_Push

// start class Tkw_About_Control_OwnerLabel_Push

procedure Tkw_About_Control_OwnerLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('OwnerLabel');
 inherited;
end;//Tkw_About_Control_OwnerLabel_Push.DoDoIt

class function Tkw_About_Control_OwnerLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::OwnerLabel:push';
end;//Tkw_About_Control_OwnerLabel_Push.GetWordNameForRegister

type
  Tkw_About_Control_ShellCaptionLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола ShellCaptionLabel
----
*Пример использования*:
[code]
контрол::ShellCaptionLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_About_Control_ShellCaptionLabel

// start class Tkw_About_Control_ShellCaptionLabel

class function Tkw_About_Control_ShellCaptionLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ShellCaptionLabel';
end;//Tkw_About_Control_ShellCaptionLabel.GetWordNameForRegister

function Tkw_About_Control_ShellCaptionLabel.GetString: AnsiString;
 {-}
begin
 Result := 'ShellCaptionLabel';
end;//Tkw_About_Control_ShellCaptionLabel.GetString

class procedure Tkw_About_Control_ShellCaptionLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_ShellCaptionLabel.RegisterInEngine

type
  Tkw_About_Control_ShellCaptionLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола ShellCaptionLabel
----
*Пример использования*:
[code]
контрол::ShellCaptionLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_About_Control_ShellCaptionLabel_Push

// start class Tkw_About_Control_ShellCaptionLabel_Push

procedure Tkw_About_Control_ShellCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ShellCaptionLabel');
 inherited;
end;//Tkw_About_Control_ShellCaptionLabel_Push.DoDoIt

class function Tkw_About_Control_ShellCaptionLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ShellCaptionLabel:push';
end;//Tkw_About_Control_ShellCaptionLabel_Push.GetWordNameForRegister

type
  Tkw_About_Control_OwnerCaptionLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола OwnerCaptionLabel
----
*Пример использования*:
[code]
контрол::OwnerCaptionLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_About_Control_OwnerCaptionLabel

// start class Tkw_About_Control_OwnerCaptionLabel

class function Tkw_About_Control_OwnerCaptionLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::OwnerCaptionLabel';
end;//Tkw_About_Control_OwnerCaptionLabel.GetWordNameForRegister

function Tkw_About_Control_OwnerCaptionLabel.GetString: AnsiString;
 {-}
begin
 Result := 'OwnerCaptionLabel';
end;//Tkw_About_Control_OwnerCaptionLabel.GetString

class procedure Tkw_About_Control_OwnerCaptionLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_OwnerCaptionLabel.RegisterInEngine

type
  Tkw_About_Control_OwnerCaptionLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола OwnerCaptionLabel
----
*Пример использования*:
[code]
контрол::OwnerCaptionLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_About_Control_OwnerCaptionLabel_Push

// start class Tkw_About_Control_OwnerCaptionLabel_Push

procedure Tkw_About_Control_OwnerCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('OwnerCaptionLabel');
 inherited;
end;//Tkw_About_Control_OwnerCaptionLabel_Push.DoDoIt

class function Tkw_About_Control_OwnerCaptionLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::OwnerCaptionLabel:push';
end;//Tkw_About_Control_OwnerCaptionLabel_Push.GetWordNameForRegister

type
  Tkw_About_Control_UserInfoGroupBox = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола UserInfoGroupBox
----
*Пример использования*:
[code]
контрол::UserInfoGroupBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_About_Control_UserInfoGroupBox

// start class Tkw_About_Control_UserInfoGroupBox

class function Tkw_About_Control_UserInfoGroupBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::UserInfoGroupBox';
end;//Tkw_About_Control_UserInfoGroupBox.GetWordNameForRegister

function Tkw_About_Control_UserInfoGroupBox.GetString: AnsiString;
 {-}
begin
 Result := 'UserInfoGroupBox';
end;//Tkw_About_Control_UserInfoGroupBox.GetString

class procedure Tkw_About_Control_UserInfoGroupBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_About_Control_UserInfoGroupBox.RegisterInEngine

type
  Tkw_About_Control_UserInfoGroupBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола UserInfoGroupBox
----
*Пример использования*:
[code]
контрол::UserInfoGroupBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_About_Control_UserInfoGroupBox_Push

// start class Tkw_About_Control_UserInfoGroupBox_Push

procedure Tkw_About_Control_UserInfoGroupBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('UserInfoGroupBox');
 inherited;
end;//Tkw_About_Control_UserInfoGroupBox_Push.DoDoIt

class function Tkw_About_Control_UserInfoGroupBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::UserInfoGroupBox:push';
end;//Tkw_About_Control_UserInfoGroupBox_Push.GetWordNameForRegister

type
  Tkw_About_Control_EMailCaptionLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола EMailCaptionLabel
----
*Пример использования*:
[code]
контрол::EMailCaptionLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_About_Control_EMailCaptionLabel

// start class Tkw_About_Control_EMailCaptionLabel

class function Tkw_About_Control_EMailCaptionLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::EMailCaptionLabel';
end;//Tkw_About_Control_EMailCaptionLabel.GetWordNameForRegister

function Tkw_About_Control_EMailCaptionLabel.GetString: AnsiString;
 {-}
begin
 Result := 'EMailCaptionLabel';
end;//Tkw_About_Control_EMailCaptionLabel.GetString

class procedure Tkw_About_Control_EMailCaptionLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_EMailCaptionLabel.RegisterInEngine

type
  Tkw_About_Control_EMailCaptionLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола EMailCaptionLabel
----
*Пример использования*:
[code]
контрол::EMailCaptionLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_About_Control_EMailCaptionLabel_Push

// start class Tkw_About_Control_EMailCaptionLabel_Push

procedure Tkw_About_Control_EMailCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('EMailCaptionLabel');
 inherited;
end;//Tkw_About_Control_EMailCaptionLabel_Push.DoDoIt

class function Tkw_About_Control_EMailCaptionLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::EMailCaptionLabel:push';
end;//Tkw_About_Control_EMailCaptionLabel_Push.GetWordNameForRegister

type
  Tkw_About_Control_EMailLabel = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_About_Control_EMailLabel

// start class Tkw_About_Control_EMailLabel

class function Tkw_About_Control_EMailLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::EMailLabel';
end;//Tkw_About_Control_EMailLabel.GetWordNameForRegister

function Tkw_About_Control_EMailLabel.GetString: AnsiString;
 {-}
begin
 Result := 'EMailLabel';
end;//Tkw_About_Control_EMailLabel.GetString

class procedure Tkw_About_Control_EMailLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_EMailLabel.RegisterInEngine

type
  Tkw_About_Control_EMailLabel_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_About_Control_EMailLabel_Push

// start class Tkw_About_Control_EMailLabel_Push

procedure Tkw_About_Control_EMailLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('EMailLabel');
 inherited;
end;//Tkw_About_Control_EMailLabel_Push.DoDoIt

class function Tkw_About_Control_EMailLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::EMailLabel:push';
end;//Tkw_About_Control_EMailLabel_Push.GetWordNameForRegister

type
  Tkw_About_Control_LoginCaptionLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола LoginCaptionLabel
----
*Пример использования*:
[code]
контрол::LoginCaptionLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_About_Control_LoginCaptionLabel

// start class Tkw_About_Control_LoginCaptionLabel

class function Tkw_About_Control_LoginCaptionLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::LoginCaptionLabel';
end;//Tkw_About_Control_LoginCaptionLabel.GetWordNameForRegister

function Tkw_About_Control_LoginCaptionLabel.GetString: AnsiString;
 {-}
begin
 Result := 'LoginCaptionLabel';
end;//Tkw_About_Control_LoginCaptionLabel.GetString

class procedure Tkw_About_Control_LoginCaptionLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_LoginCaptionLabel.RegisterInEngine

type
  Tkw_About_Control_LoginCaptionLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола LoginCaptionLabel
----
*Пример использования*:
[code]
контрол::LoginCaptionLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_About_Control_LoginCaptionLabel_Push

// start class Tkw_About_Control_LoginCaptionLabel_Push

procedure Tkw_About_Control_LoginCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('LoginCaptionLabel');
 inherited;
end;//Tkw_About_Control_LoginCaptionLabel_Push.DoDoIt

class function Tkw_About_Control_LoginCaptionLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::LoginCaptionLabel:push';
end;//Tkw_About_Control_LoginCaptionLabel_Push.GetWordNameForRegister

type
  Tkw_About_Control_UserCaptionLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола UserCaptionLabel
----
*Пример использования*:
[code]
контрол::UserCaptionLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_About_Control_UserCaptionLabel

// start class Tkw_About_Control_UserCaptionLabel

class function Tkw_About_Control_UserCaptionLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::UserCaptionLabel';
end;//Tkw_About_Control_UserCaptionLabel.GetWordNameForRegister

function Tkw_About_Control_UserCaptionLabel.GetString: AnsiString;
 {-}
begin
 Result := 'UserCaptionLabel';
end;//Tkw_About_Control_UserCaptionLabel.GetString

class procedure Tkw_About_Control_UserCaptionLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_UserCaptionLabel.RegisterInEngine

type
  Tkw_About_Control_UserCaptionLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола UserCaptionLabel
----
*Пример использования*:
[code]
контрол::UserCaptionLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_About_Control_UserCaptionLabel_Push

// start class Tkw_About_Control_UserCaptionLabel_Push

procedure Tkw_About_Control_UserCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('UserCaptionLabel');
 inherited;
end;//Tkw_About_Control_UserCaptionLabel_Push.DoDoIt

class function Tkw_About_Control_UserCaptionLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::UserCaptionLabel:push';
end;//Tkw_About_Control_UserCaptionLabel_Push.GetWordNameForRegister

type
  Tkw_About_Control_UserNameLabel = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_About_Control_UserNameLabel

// start class Tkw_About_Control_UserNameLabel

class function Tkw_About_Control_UserNameLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::UserNameLabel';
end;//Tkw_About_Control_UserNameLabel.GetWordNameForRegister

function Tkw_About_Control_UserNameLabel.GetString: AnsiString;
 {-}
begin
 Result := 'UserNameLabel';
end;//Tkw_About_Control_UserNameLabel.GetString

class procedure Tkw_About_Control_UserNameLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_UserNameLabel.RegisterInEngine

type
  Tkw_About_Control_UserNameLabel_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_About_Control_UserNameLabel_Push

// start class Tkw_About_Control_UserNameLabel_Push

procedure Tkw_About_Control_UserNameLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('UserNameLabel');
 inherited;
end;//Tkw_About_Control_UserNameLabel_Push.DoDoIt

class function Tkw_About_Control_UserNameLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::UserNameLabel:push';
end;//Tkw_About_Control_UserNameLabel_Push.GetWordNameForRegister

type
  Tkw_About_Control_LoginLabel = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_About_Control_LoginLabel

// start class Tkw_About_Control_LoginLabel

class function Tkw_About_Control_LoginLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::LoginLabel';
end;//Tkw_About_Control_LoginLabel.GetWordNameForRegister

function Tkw_About_Control_LoginLabel.GetString: AnsiString;
 {-}
begin
 Result := 'LoginLabel';
end;//Tkw_About_Control_LoginLabel.GetString

class procedure Tkw_About_Control_LoginLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_LoginLabel.RegisterInEngine

type
  Tkw_About_Control_LoginLabel_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_About_Control_LoginLabel_Push

// start class Tkw_About_Control_LoginLabel_Push

procedure Tkw_About_Control_LoginLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('LoginLabel');
 inherited;
end;//Tkw_About_Control_LoginLabel_Push.DoDoIt

class function Tkw_About_Control_LoginLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::LoginLabel:push';
end;//Tkw_About_Control_LoginLabel_Push.GetWordNameForRegister

type
  Tkw_About_Control_CopyrightCaptionLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола CopyrightCaptionLabel
----
*Пример использования*:
[code]
контрол::CopyrightCaptionLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_About_Control_CopyrightCaptionLabel

// start class Tkw_About_Control_CopyrightCaptionLabel

class function Tkw_About_Control_CopyrightCaptionLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::CopyrightCaptionLabel';
end;//Tkw_About_Control_CopyrightCaptionLabel.GetWordNameForRegister

function Tkw_About_Control_CopyrightCaptionLabel.GetString: AnsiString;
 {-}
begin
 Result := 'CopyrightCaptionLabel';
end;//Tkw_About_Control_CopyrightCaptionLabel.GetString

class procedure Tkw_About_Control_CopyrightCaptionLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_CopyrightCaptionLabel.RegisterInEngine

type
  Tkw_About_Control_CopyrightCaptionLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола CopyrightCaptionLabel
----
*Пример использования*:
[code]
контрол::CopyrightCaptionLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_About_Control_CopyrightCaptionLabel_Push

// start class Tkw_About_Control_CopyrightCaptionLabel_Push

procedure Tkw_About_Control_CopyrightCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('CopyrightCaptionLabel');
 inherited;
end;//Tkw_About_Control_CopyrightCaptionLabel_Push.DoDoIt

class function Tkw_About_Control_CopyrightCaptionLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::CopyrightCaptionLabel:push';
end;//Tkw_About_Control_CopyrightCaptionLabel_Push.GetWordNameForRegister

type
  Tkw_About_Control_OkButton = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола OkButton
----
*Пример использования*:
[code]
контрол::OkButton TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_About_Control_OkButton

// start class Tkw_About_Control_OkButton

class function Tkw_About_Control_OkButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::OkButton';
end;//Tkw_About_Control_OkButton.GetWordNameForRegister

function Tkw_About_Control_OkButton.GetString: AnsiString;
 {-}
begin
 Result := 'OkButton';
end;//Tkw_About_Control_OkButton.GetString

class procedure Tkw_About_Control_OkButton.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
end;//Tkw_About_Control_OkButton.RegisterInEngine

type
  Tkw_About_Control_OkButton_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола OkButton
----
*Пример использования*:
[code]
контрол::OkButton:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_About_Control_OkButton_Push

// start class Tkw_About_Control_OkButton_Push

procedure Tkw_About_Control_OkButton_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('OkButton');
 inherited;
end;//Tkw_About_Control_OkButton_Push.DoDoIt

class function Tkw_About_Control_OkButton_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::OkButton:push';
end;//Tkw_About_Control_OkButton_Push.GetWordNameForRegister

type
  Tkw_About_Control_UserCountCaptionLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола UserCountCaptionLabel
----
*Пример использования*:
[code]
контрол::UserCountCaptionLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_About_Control_UserCountCaptionLabel

// start class Tkw_About_Control_UserCountCaptionLabel

class function Tkw_About_Control_UserCountCaptionLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::UserCountCaptionLabel';
end;//Tkw_About_Control_UserCountCaptionLabel.GetWordNameForRegister

function Tkw_About_Control_UserCountCaptionLabel.GetString: AnsiString;
 {-}
begin
 Result := 'UserCountCaptionLabel';
end;//Tkw_About_Control_UserCountCaptionLabel.GetString

class procedure Tkw_About_Control_UserCountCaptionLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_UserCountCaptionLabel.RegisterInEngine

type
  Tkw_About_Control_UserCountCaptionLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола UserCountCaptionLabel
----
*Пример использования*:
[code]
контрол::UserCountCaptionLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_About_Control_UserCountCaptionLabel_Push

// start class Tkw_About_Control_UserCountCaptionLabel_Push

procedure Tkw_About_Control_UserCountCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('UserCountCaptionLabel');
 inherited;
end;//Tkw_About_Control_UserCountCaptionLabel_Push.DoDoIt

class function Tkw_About_Control_UserCountCaptionLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::UserCountCaptionLabel:push';
end;//Tkw_About_Control_UserCountCaptionLabel_Push.GetWordNameForRegister

type
  Tkw_About_Control_AdapterCaptionLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола AdapterCaptionLabel
----
*Пример использования*:
[code]
контрол::AdapterCaptionLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_About_Control_AdapterCaptionLabel

// start class Tkw_About_Control_AdapterCaptionLabel

class function Tkw_About_Control_AdapterCaptionLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::AdapterCaptionLabel';
end;//Tkw_About_Control_AdapterCaptionLabel.GetWordNameForRegister

function Tkw_About_Control_AdapterCaptionLabel.GetString: AnsiString;
 {-}
begin
 Result := 'AdapterCaptionLabel';
end;//Tkw_About_Control_AdapterCaptionLabel.GetString

class procedure Tkw_About_Control_AdapterCaptionLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_About_Control_AdapterCaptionLabel.RegisterInEngine

type
  Tkw_About_Control_AdapterCaptionLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола AdapterCaptionLabel
----
*Пример использования*:
[code]
контрол::AdapterCaptionLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_About_Control_AdapterCaptionLabel_Push

// start class Tkw_About_Control_AdapterCaptionLabel_Push

procedure Tkw_About_Control_AdapterCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('AdapterCaptionLabel');
 inherited;
end;//Tkw_About_Control_AdapterCaptionLabel_Push.DoDoIt

class function Tkw_About_Control_AdapterCaptionLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::AdapterCaptionLabel:push';
end;//Tkw_About_Control_AdapterCaptionLabel_Push.GetWordNameForRegister

type
  TkwEfAboutPbLogo = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefAbout.pbLogo
[panel]Контрол pbLogo формы TefAbout[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aefAbout .TefAbout.pbLogo >>> l_TPaintBox
[code]  }
  private
  // private methods
   function PbLogo(const aCtx: TtfwContext;
     aefAbout: TefAbout): TPaintBox;
     {* Реализация слова скрипта .TefAbout.pbLogo }
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
  end;//TkwEfAboutPbLogo

// start class TkwEfAboutPbLogo

function TkwEfAboutPbLogo.PbLogo(const aCtx: TtfwContext;
  aefAbout: TefAbout): TPaintBox;
 {-}
begin
 Result := aefAbout.pbLogo;
end;//TkwEfAboutPbLogo.PbLogo

procedure TkwEfAboutPbLogo.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefAbout : TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PbLogo(aCtx, l_aefAbout)));
end;//TkwEfAboutPbLogo.DoDoIt

class function TkwEfAboutPbLogo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefAbout.pbLogo';
end;//TkwEfAboutPbLogo.GetWordNameForRegister

procedure TkwEfAboutPbLogo.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pbLogo', aCtx);
end;//TkwEfAboutPbLogo.SetValuePrim

function TkwEfAboutPbLogo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEfAboutPbLogo.GetResultTypeInfo

function TkwEfAboutPbLogo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfAboutPbLogo.GetAllParamsCount

function TkwEfAboutPbLogo.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutPbLogo.ParamsTypes

type
  TkwEfAboutShellInfoLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefAbout.ShellInfoLabel
[panel]Контрол ShellInfoLabel формы TefAbout[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.ShellInfoLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function ShellInfoLabel(const aCtx: TtfwContext;
     aefAbout: TefAbout): TvtLabel;
     {* Реализация слова скрипта .TefAbout.ShellInfoLabel }
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
  end;//TkwEfAboutShellInfoLabel

// start class TkwEfAboutShellInfoLabel

function TkwEfAboutShellInfoLabel.ShellInfoLabel(const aCtx: TtfwContext;
  aefAbout: TefAbout): TvtLabel;
 {-}
begin
 Result := aefAbout.ShellInfoLabel;
end;//TkwEfAboutShellInfoLabel.ShellInfoLabel

procedure TkwEfAboutShellInfoLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefAbout : TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ShellInfoLabel(aCtx, l_aefAbout)));
end;//TkwEfAboutShellInfoLabel.DoDoIt

class function TkwEfAboutShellInfoLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefAbout.ShellInfoLabel';
end;//TkwEfAboutShellInfoLabel.GetWordNameForRegister

procedure TkwEfAboutShellInfoLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ShellInfoLabel', aCtx);
end;//TkwEfAboutShellInfoLabel.SetValuePrim

function TkwEfAboutShellInfoLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutShellInfoLabel.GetResultTypeInfo

function TkwEfAboutShellInfoLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfAboutShellInfoLabel.GetAllParamsCount

function TkwEfAboutShellInfoLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutShellInfoLabel.ParamsTypes

type
  TkwEfAboutAdapterInfoLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefAbout.AdapterInfoLabel
[panel]Контрол AdapterInfoLabel формы TefAbout[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.AdapterInfoLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function AdapterInfoLabel(const aCtx: TtfwContext;
     aefAbout: TefAbout): TvtLabel;
     {* Реализация слова скрипта .TefAbout.AdapterInfoLabel }
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
  end;//TkwEfAboutAdapterInfoLabel

// start class TkwEfAboutAdapterInfoLabel

function TkwEfAboutAdapterInfoLabel.AdapterInfoLabel(const aCtx: TtfwContext;
  aefAbout: TefAbout): TvtLabel;
 {-}
begin
 Result := aefAbout.AdapterInfoLabel;
end;//TkwEfAboutAdapterInfoLabel.AdapterInfoLabel

procedure TkwEfAboutAdapterInfoLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefAbout : TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((AdapterInfoLabel(aCtx, l_aefAbout)));
end;//TkwEfAboutAdapterInfoLabel.DoDoIt

class function TkwEfAboutAdapterInfoLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefAbout.AdapterInfoLabel';
end;//TkwEfAboutAdapterInfoLabel.GetWordNameForRegister

procedure TkwEfAboutAdapterInfoLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству AdapterInfoLabel', aCtx);
end;//TkwEfAboutAdapterInfoLabel.SetValuePrim

function TkwEfAboutAdapterInfoLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutAdapterInfoLabel.GetResultTypeInfo

function TkwEfAboutAdapterInfoLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfAboutAdapterInfoLabel.GetAllParamsCount

function TkwEfAboutAdapterInfoLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutAdapterInfoLabel.ParamsTypes

type
  TkwEfAboutUserCountLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefAbout.UserCountLabel
[panel]Контрол UserCountLabel формы TefAbout[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.UserCountLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function UserCountLabel(const aCtx: TtfwContext;
     aefAbout: TefAbout): TvtLabel;
     {* Реализация слова скрипта .TefAbout.UserCountLabel }
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
  end;//TkwEfAboutUserCountLabel

// start class TkwEfAboutUserCountLabel

function TkwEfAboutUserCountLabel.UserCountLabel(const aCtx: TtfwContext;
  aefAbout: TefAbout): TvtLabel;
 {-}
begin
 Result := aefAbout.UserCountLabel;
end;//TkwEfAboutUserCountLabel.UserCountLabel

procedure TkwEfAboutUserCountLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefAbout : TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((UserCountLabel(aCtx, l_aefAbout)));
end;//TkwEfAboutUserCountLabel.DoDoIt

class function TkwEfAboutUserCountLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefAbout.UserCountLabel';
end;//TkwEfAboutUserCountLabel.GetWordNameForRegister

procedure TkwEfAboutUserCountLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству UserCountLabel', aCtx);
end;//TkwEfAboutUserCountLabel.SetValuePrim

function TkwEfAboutUserCountLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutUserCountLabel.GetResultTypeInfo

function TkwEfAboutUserCountLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfAboutUserCountLabel.GetAllParamsCount

function TkwEfAboutUserCountLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutUserCountLabel.ParamsTypes

type
  TkwEfAboutOwnerLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefAbout.OwnerLabel
[panel]Контрол OwnerLabel формы TefAbout[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.OwnerLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function OwnerLabel(const aCtx: TtfwContext;
     aefAbout: TefAbout): TvtLabel;
     {* Реализация слова скрипта .TefAbout.OwnerLabel }
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
  end;//TkwEfAboutOwnerLabel

// start class TkwEfAboutOwnerLabel

function TkwEfAboutOwnerLabel.OwnerLabel(const aCtx: TtfwContext;
  aefAbout: TefAbout): TvtLabel;
 {-}
begin
 Result := aefAbout.OwnerLabel;
end;//TkwEfAboutOwnerLabel.OwnerLabel

procedure TkwEfAboutOwnerLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefAbout : TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((OwnerLabel(aCtx, l_aefAbout)));
end;//TkwEfAboutOwnerLabel.DoDoIt

class function TkwEfAboutOwnerLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefAbout.OwnerLabel';
end;//TkwEfAboutOwnerLabel.GetWordNameForRegister

procedure TkwEfAboutOwnerLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству OwnerLabel', aCtx);
end;//TkwEfAboutOwnerLabel.SetValuePrim

function TkwEfAboutOwnerLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutOwnerLabel.GetResultTypeInfo

function TkwEfAboutOwnerLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfAboutOwnerLabel.GetAllParamsCount

function TkwEfAboutOwnerLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutOwnerLabel.ParamsTypes

type
  TkwEfAboutShellCaptionLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefAbout.ShellCaptionLabel
[panel]Контрол ShellCaptionLabel формы TefAbout[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.ShellCaptionLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function ShellCaptionLabel(const aCtx: TtfwContext;
     aefAbout: TefAbout): TvtLabel;
     {* Реализация слова скрипта .TefAbout.ShellCaptionLabel }
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
  end;//TkwEfAboutShellCaptionLabel

// start class TkwEfAboutShellCaptionLabel

function TkwEfAboutShellCaptionLabel.ShellCaptionLabel(const aCtx: TtfwContext;
  aefAbout: TefAbout): TvtLabel;
 {-}
begin
 Result := aefAbout.ShellCaptionLabel;
end;//TkwEfAboutShellCaptionLabel.ShellCaptionLabel

procedure TkwEfAboutShellCaptionLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefAbout : TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ShellCaptionLabel(aCtx, l_aefAbout)));
end;//TkwEfAboutShellCaptionLabel.DoDoIt

class function TkwEfAboutShellCaptionLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefAbout.ShellCaptionLabel';
end;//TkwEfAboutShellCaptionLabel.GetWordNameForRegister

procedure TkwEfAboutShellCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ShellCaptionLabel', aCtx);
end;//TkwEfAboutShellCaptionLabel.SetValuePrim

function TkwEfAboutShellCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutShellCaptionLabel.GetResultTypeInfo

function TkwEfAboutShellCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfAboutShellCaptionLabel.GetAllParamsCount

function TkwEfAboutShellCaptionLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutShellCaptionLabel.ParamsTypes

type
  TkwEfAboutOwnerCaptionLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefAbout.OwnerCaptionLabel
[panel]Контрол OwnerCaptionLabel формы TefAbout[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.OwnerCaptionLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function OwnerCaptionLabel(const aCtx: TtfwContext;
     aefAbout: TefAbout): TvtLabel;
     {* Реализация слова скрипта .TefAbout.OwnerCaptionLabel }
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
  end;//TkwEfAboutOwnerCaptionLabel

// start class TkwEfAboutOwnerCaptionLabel

function TkwEfAboutOwnerCaptionLabel.OwnerCaptionLabel(const aCtx: TtfwContext;
  aefAbout: TefAbout): TvtLabel;
 {-}
begin
 Result := aefAbout.OwnerCaptionLabel;
end;//TkwEfAboutOwnerCaptionLabel.OwnerCaptionLabel

procedure TkwEfAboutOwnerCaptionLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefAbout : TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((OwnerCaptionLabel(aCtx, l_aefAbout)));
end;//TkwEfAboutOwnerCaptionLabel.DoDoIt

class function TkwEfAboutOwnerCaptionLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefAbout.OwnerCaptionLabel';
end;//TkwEfAboutOwnerCaptionLabel.GetWordNameForRegister

procedure TkwEfAboutOwnerCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству OwnerCaptionLabel', aCtx);
end;//TkwEfAboutOwnerCaptionLabel.SetValuePrim

function TkwEfAboutOwnerCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutOwnerCaptionLabel.GetResultTypeInfo

function TkwEfAboutOwnerCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfAboutOwnerCaptionLabel.GetAllParamsCount

function TkwEfAboutOwnerCaptionLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutOwnerCaptionLabel.ParamsTypes

type
  TkwEfAboutUserInfoGroupBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefAbout.UserInfoGroupBox
[panel]Контрол UserInfoGroupBox формы TefAbout[panel]
*Тип результата:* TvtGroupBox
*Пример:*
[code]
OBJECT VAR l_TvtGroupBox
 aefAbout .TefAbout.UserInfoGroupBox >>> l_TvtGroupBox
[code]  }
  private
  // private methods
   function UserInfoGroupBox(const aCtx: TtfwContext;
     aefAbout: TefAbout): TvtGroupBox;
     {* Реализация слова скрипта .TefAbout.UserInfoGroupBox }
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
  end;//TkwEfAboutUserInfoGroupBox

// start class TkwEfAboutUserInfoGroupBox

function TkwEfAboutUserInfoGroupBox.UserInfoGroupBox(const aCtx: TtfwContext;
  aefAbout: TefAbout): TvtGroupBox;
 {-}
begin
 Result := aefAbout.UserInfoGroupBox;
end;//TkwEfAboutUserInfoGroupBox.UserInfoGroupBox

procedure TkwEfAboutUserInfoGroupBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefAbout : TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((UserInfoGroupBox(aCtx, l_aefAbout)));
end;//TkwEfAboutUserInfoGroupBox.DoDoIt

class function TkwEfAboutUserInfoGroupBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefAbout.UserInfoGroupBox';
end;//TkwEfAboutUserInfoGroupBox.GetWordNameForRegister

procedure TkwEfAboutUserInfoGroupBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству UserInfoGroupBox', aCtx);
end;//TkwEfAboutUserInfoGroupBox.SetValuePrim

function TkwEfAboutUserInfoGroupBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwEfAboutUserInfoGroupBox.GetResultTypeInfo

function TkwEfAboutUserInfoGroupBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfAboutUserInfoGroupBox.GetAllParamsCount

function TkwEfAboutUserInfoGroupBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutUserInfoGroupBox.ParamsTypes

type
  TkwEfAboutEMailCaptionLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefAbout.EMailCaptionLabel
[panel]Контрол EMailCaptionLabel формы TefAbout[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.EMailCaptionLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function EMailCaptionLabel(const aCtx: TtfwContext;
     aefAbout: TefAbout): TvtLabel;
     {* Реализация слова скрипта .TefAbout.EMailCaptionLabel }
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
  end;//TkwEfAboutEMailCaptionLabel

// start class TkwEfAboutEMailCaptionLabel

function TkwEfAboutEMailCaptionLabel.EMailCaptionLabel(const aCtx: TtfwContext;
  aefAbout: TefAbout): TvtLabel;
 {-}
begin
 Result := aefAbout.EMailCaptionLabel;
end;//TkwEfAboutEMailCaptionLabel.EMailCaptionLabel

procedure TkwEfAboutEMailCaptionLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefAbout : TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EMailCaptionLabel(aCtx, l_aefAbout)));
end;//TkwEfAboutEMailCaptionLabel.DoDoIt

class function TkwEfAboutEMailCaptionLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefAbout.EMailCaptionLabel';
end;//TkwEfAboutEMailCaptionLabel.GetWordNameForRegister

procedure TkwEfAboutEMailCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству EMailCaptionLabel', aCtx);
end;//TkwEfAboutEMailCaptionLabel.SetValuePrim

function TkwEfAboutEMailCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutEMailCaptionLabel.GetResultTypeInfo

function TkwEfAboutEMailCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfAboutEMailCaptionLabel.GetAllParamsCount

function TkwEfAboutEMailCaptionLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutEMailCaptionLabel.ParamsTypes

type
  TkwEfAboutEMailLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefAbout.EMailLabel
[panel]Контрол EMailLabel формы TefAbout[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.EMailLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function EMailLabel(const aCtx: TtfwContext;
     aefAbout: TefAbout): TvtLabel;
     {* Реализация слова скрипта .TefAbout.EMailLabel }
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
  end;//TkwEfAboutEMailLabel

// start class TkwEfAboutEMailLabel

function TkwEfAboutEMailLabel.EMailLabel(const aCtx: TtfwContext;
  aefAbout: TefAbout): TvtLabel;
 {-}
begin
 Result := aefAbout.EMailLabel;
end;//TkwEfAboutEMailLabel.EMailLabel

procedure TkwEfAboutEMailLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefAbout : TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EMailLabel(aCtx, l_aefAbout)));
end;//TkwEfAboutEMailLabel.DoDoIt

class function TkwEfAboutEMailLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefAbout.EMailLabel';
end;//TkwEfAboutEMailLabel.GetWordNameForRegister

procedure TkwEfAboutEMailLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству EMailLabel', aCtx);
end;//TkwEfAboutEMailLabel.SetValuePrim

function TkwEfAboutEMailLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutEMailLabel.GetResultTypeInfo

function TkwEfAboutEMailLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfAboutEMailLabel.GetAllParamsCount

function TkwEfAboutEMailLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutEMailLabel.ParamsTypes

type
  TkwEfAboutLoginCaptionLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefAbout.LoginCaptionLabel
[panel]Контрол LoginCaptionLabel формы TefAbout[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.LoginCaptionLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LoginCaptionLabel(const aCtx: TtfwContext;
     aefAbout: TefAbout): TvtLabel;
     {* Реализация слова скрипта .TefAbout.LoginCaptionLabel }
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
  end;//TkwEfAboutLoginCaptionLabel

// start class TkwEfAboutLoginCaptionLabel

function TkwEfAboutLoginCaptionLabel.LoginCaptionLabel(const aCtx: TtfwContext;
  aefAbout: TefAbout): TvtLabel;
 {-}
begin
 Result := aefAbout.LoginCaptionLabel;
end;//TkwEfAboutLoginCaptionLabel.LoginCaptionLabel

procedure TkwEfAboutLoginCaptionLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefAbout : TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LoginCaptionLabel(aCtx, l_aefAbout)));
end;//TkwEfAboutLoginCaptionLabel.DoDoIt

class function TkwEfAboutLoginCaptionLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefAbout.LoginCaptionLabel';
end;//TkwEfAboutLoginCaptionLabel.GetWordNameForRegister

procedure TkwEfAboutLoginCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству LoginCaptionLabel', aCtx);
end;//TkwEfAboutLoginCaptionLabel.SetValuePrim

function TkwEfAboutLoginCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutLoginCaptionLabel.GetResultTypeInfo

function TkwEfAboutLoginCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfAboutLoginCaptionLabel.GetAllParamsCount

function TkwEfAboutLoginCaptionLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutLoginCaptionLabel.ParamsTypes

type
  TkwEfAboutUserCaptionLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefAbout.UserCaptionLabel
[panel]Контрол UserCaptionLabel формы TefAbout[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.UserCaptionLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function UserCaptionLabel(const aCtx: TtfwContext;
     aefAbout: TefAbout): TvtLabel;
     {* Реализация слова скрипта .TefAbout.UserCaptionLabel }
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
  end;//TkwEfAboutUserCaptionLabel

// start class TkwEfAboutUserCaptionLabel

function TkwEfAboutUserCaptionLabel.UserCaptionLabel(const aCtx: TtfwContext;
  aefAbout: TefAbout): TvtLabel;
 {-}
begin
 Result := aefAbout.UserCaptionLabel;
end;//TkwEfAboutUserCaptionLabel.UserCaptionLabel

procedure TkwEfAboutUserCaptionLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefAbout : TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((UserCaptionLabel(aCtx, l_aefAbout)));
end;//TkwEfAboutUserCaptionLabel.DoDoIt

class function TkwEfAboutUserCaptionLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefAbout.UserCaptionLabel';
end;//TkwEfAboutUserCaptionLabel.GetWordNameForRegister

procedure TkwEfAboutUserCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству UserCaptionLabel', aCtx);
end;//TkwEfAboutUserCaptionLabel.SetValuePrim

function TkwEfAboutUserCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutUserCaptionLabel.GetResultTypeInfo

function TkwEfAboutUserCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfAboutUserCaptionLabel.GetAllParamsCount

function TkwEfAboutUserCaptionLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutUserCaptionLabel.ParamsTypes

type
  TkwEfAboutUserNameLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefAbout.UserNameLabel
[panel]Контрол UserNameLabel формы TefAbout[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.UserNameLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function UserNameLabel(const aCtx: TtfwContext;
     aefAbout: TefAbout): TvtLabel;
     {* Реализация слова скрипта .TefAbout.UserNameLabel }
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
  end;//TkwEfAboutUserNameLabel

// start class TkwEfAboutUserNameLabel

function TkwEfAboutUserNameLabel.UserNameLabel(const aCtx: TtfwContext;
  aefAbout: TefAbout): TvtLabel;
 {-}
begin
 Result := aefAbout.UserNameLabel;
end;//TkwEfAboutUserNameLabel.UserNameLabel

procedure TkwEfAboutUserNameLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefAbout : TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((UserNameLabel(aCtx, l_aefAbout)));
end;//TkwEfAboutUserNameLabel.DoDoIt

class function TkwEfAboutUserNameLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefAbout.UserNameLabel';
end;//TkwEfAboutUserNameLabel.GetWordNameForRegister

procedure TkwEfAboutUserNameLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству UserNameLabel', aCtx);
end;//TkwEfAboutUserNameLabel.SetValuePrim

function TkwEfAboutUserNameLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutUserNameLabel.GetResultTypeInfo

function TkwEfAboutUserNameLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfAboutUserNameLabel.GetAllParamsCount

function TkwEfAboutUserNameLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutUserNameLabel.ParamsTypes

type
  TkwEfAboutLoginLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefAbout.LoginLabel
[panel]Контрол LoginLabel формы TefAbout[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.LoginLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LoginLabel(const aCtx: TtfwContext;
     aefAbout: TefAbout): TvtLabel;
     {* Реализация слова скрипта .TefAbout.LoginLabel }
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
  end;//TkwEfAboutLoginLabel

// start class TkwEfAboutLoginLabel

function TkwEfAboutLoginLabel.LoginLabel(const aCtx: TtfwContext;
  aefAbout: TefAbout): TvtLabel;
 {-}
begin
 Result := aefAbout.LoginLabel;
end;//TkwEfAboutLoginLabel.LoginLabel

procedure TkwEfAboutLoginLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefAbout : TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LoginLabel(aCtx, l_aefAbout)));
end;//TkwEfAboutLoginLabel.DoDoIt

class function TkwEfAboutLoginLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefAbout.LoginLabel';
end;//TkwEfAboutLoginLabel.GetWordNameForRegister

procedure TkwEfAboutLoginLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству LoginLabel', aCtx);
end;//TkwEfAboutLoginLabel.SetValuePrim

function TkwEfAboutLoginLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutLoginLabel.GetResultTypeInfo

function TkwEfAboutLoginLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfAboutLoginLabel.GetAllParamsCount

function TkwEfAboutLoginLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutLoginLabel.ParamsTypes

type
  TkwEfAboutCopyrightCaptionLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefAbout.CopyrightCaptionLabel
[panel]Контрол CopyrightCaptionLabel формы TefAbout[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.CopyrightCaptionLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function CopyrightCaptionLabel(const aCtx: TtfwContext;
     aefAbout: TefAbout): TvtLabel;
     {* Реализация слова скрипта .TefAbout.CopyrightCaptionLabel }
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
  end;//TkwEfAboutCopyrightCaptionLabel

// start class TkwEfAboutCopyrightCaptionLabel

function TkwEfAboutCopyrightCaptionLabel.CopyrightCaptionLabel(const aCtx: TtfwContext;
  aefAbout: TefAbout): TvtLabel;
 {-}
begin
 Result := aefAbout.CopyrightCaptionLabel;
end;//TkwEfAboutCopyrightCaptionLabel.CopyrightCaptionLabel

procedure TkwEfAboutCopyrightCaptionLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefAbout : TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((CopyrightCaptionLabel(aCtx, l_aefAbout)));
end;//TkwEfAboutCopyrightCaptionLabel.DoDoIt

class function TkwEfAboutCopyrightCaptionLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefAbout.CopyrightCaptionLabel';
end;//TkwEfAboutCopyrightCaptionLabel.GetWordNameForRegister

procedure TkwEfAboutCopyrightCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству CopyrightCaptionLabel', aCtx);
end;//TkwEfAboutCopyrightCaptionLabel.SetValuePrim

function TkwEfAboutCopyrightCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutCopyrightCaptionLabel.GetResultTypeInfo

function TkwEfAboutCopyrightCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfAboutCopyrightCaptionLabel.GetAllParamsCount

function TkwEfAboutCopyrightCaptionLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutCopyrightCaptionLabel.ParamsTypes

type
  TkwEfAboutOkButton = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefAbout.OkButton
[panel]Контрол OkButton формы TefAbout[panel]
*Тип результата:* TvtButton
*Пример:*
[code]
OBJECT VAR l_TvtButton
 aefAbout .TefAbout.OkButton >>> l_TvtButton
[code]  }
  private
  // private methods
   function OkButton(const aCtx: TtfwContext;
     aefAbout: TefAbout): TvtButton;
     {* Реализация слова скрипта .TefAbout.OkButton }
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
  end;//TkwEfAboutOkButton

// start class TkwEfAboutOkButton

function TkwEfAboutOkButton.OkButton(const aCtx: TtfwContext;
  aefAbout: TefAbout): TvtButton;
 {-}
begin
 Result := aefAbout.OkButton;
end;//TkwEfAboutOkButton.OkButton

procedure TkwEfAboutOkButton.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefAbout : TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((OkButton(aCtx, l_aefAbout)));
end;//TkwEfAboutOkButton.DoDoIt

class function TkwEfAboutOkButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefAbout.OkButton';
end;//TkwEfAboutOkButton.GetWordNameForRegister

procedure TkwEfAboutOkButton.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству OkButton', aCtx);
end;//TkwEfAboutOkButton.SetValuePrim

function TkwEfAboutOkButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtButton);
end;//TkwEfAboutOkButton.GetResultTypeInfo

function TkwEfAboutOkButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfAboutOkButton.GetAllParamsCount

function TkwEfAboutOkButton.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutOkButton.ParamsTypes

type
  TkwEfAboutUserCountCaptionLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefAbout.UserCountCaptionLabel
[panel]Контрол UserCountCaptionLabel формы TefAbout[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.UserCountCaptionLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function UserCountCaptionLabel(const aCtx: TtfwContext;
     aefAbout: TefAbout): TvtLabel;
     {* Реализация слова скрипта .TefAbout.UserCountCaptionLabel }
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
  end;//TkwEfAboutUserCountCaptionLabel

// start class TkwEfAboutUserCountCaptionLabel

function TkwEfAboutUserCountCaptionLabel.UserCountCaptionLabel(const aCtx: TtfwContext;
  aefAbout: TefAbout): TvtLabel;
 {-}
begin
 Result := aefAbout.UserCountCaptionLabel;
end;//TkwEfAboutUserCountCaptionLabel.UserCountCaptionLabel

procedure TkwEfAboutUserCountCaptionLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefAbout : TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((UserCountCaptionLabel(aCtx, l_aefAbout)));
end;//TkwEfAboutUserCountCaptionLabel.DoDoIt

class function TkwEfAboutUserCountCaptionLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefAbout.UserCountCaptionLabel';
end;//TkwEfAboutUserCountCaptionLabel.GetWordNameForRegister

procedure TkwEfAboutUserCountCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству UserCountCaptionLabel', aCtx);
end;//TkwEfAboutUserCountCaptionLabel.SetValuePrim

function TkwEfAboutUserCountCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutUserCountCaptionLabel.GetResultTypeInfo

function TkwEfAboutUserCountCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfAboutUserCountCaptionLabel.GetAllParamsCount

function TkwEfAboutUserCountCaptionLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutUserCountCaptionLabel.ParamsTypes

type
  TkwEfAboutAdapterCaptionLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefAbout.AdapterCaptionLabel
[panel]Контрол AdapterCaptionLabel формы TefAbout[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefAbout .TefAbout.AdapterCaptionLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function AdapterCaptionLabel(const aCtx: TtfwContext;
     aefAbout: TefAbout): TvtLabel;
     {* Реализация слова скрипта .TefAbout.AdapterCaptionLabel }
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
  end;//TkwEfAboutAdapterCaptionLabel

// start class TkwEfAboutAdapterCaptionLabel

function TkwEfAboutAdapterCaptionLabel.AdapterCaptionLabel(const aCtx: TtfwContext;
  aefAbout: TefAbout): TvtLabel;
 {-}
begin
 Result := aefAbout.AdapterCaptionLabel;
end;//TkwEfAboutAdapterCaptionLabel.AdapterCaptionLabel

procedure TkwEfAboutAdapterCaptionLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefAbout : TefAbout;
begin
 try
  l_aefAbout := TefAbout(aCtx.rEngine.PopObjAs(TefAbout));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefAbout: TefAbout : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((AdapterCaptionLabel(aCtx, l_aefAbout)));
end;//TkwEfAboutAdapterCaptionLabel.DoDoIt

class function TkwEfAboutAdapterCaptionLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefAbout.AdapterCaptionLabel';
end;//TkwEfAboutAdapterCaptionLabel.GetWordNameForRegister

procedure TkwEfAboutAdapterCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству AdapterCaptionLabel', aCtx);
end;//TkwEfAboutAdapterCaptionLabel.SetValuePrim

function TkwEfAboutAdapterCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfAboutAdapterCaptionLabel.GetResultTypeInfo

function TkwEfAboutAdapterCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfAboutAdapterCaptionLabel.GetAllParamsCount

function TkwEfAboutAdapterCaptionLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefAbout)]);
end;//TkwEfAboutAdapterCaptionLabel.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_About
 Tkw_Form_About.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_pbLogo
 Tkw_About_Control_pbLogo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_pbLogo_Push
 Tkw_About_Control_pbLogo_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_ShellInfoLabel
 Tkw_About_Control_ShellInfoLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_ShellInfoLabel_Push
 Tkw_About_Control_ShellInfoLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_AdapterInfoLabel
 Tkw_About_Control_AdapterInfoLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_AdapterInfoLabel_Push
 Tkw_About_Control_AdapterInfoLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_UserCountLabel
 Tkw_About_Control_UserCountLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_UserCountLabel_Push
 Tkw_About_Control_UserCountLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_OwnerLabel
 Tkw_About_Control_OwnerLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_OwnerLabel_Push
 Tkw_About_Control_OwnerLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_ShellCaptionLabel
 Tkw_About_Control_ShellCaptionLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_ShellCaptionLabel_Push
 Tkw_About_Control_ShellCaptionLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_OwnerCaptionLabel
 Tkw_About_Control_OwnerCaptionLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_OwnerCaptionLabel_Push
 Tkw_About_Control_OwnerCaptionLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_UserInfoGroupBox
 Tkw_About_Control_UserInfoGroupBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_UserInfoGroupBox_Push
 Tkw_About_Control_UserInfoGroupBox_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_EMailCaptionLabel
 Tkw_About_Control_EMailCaptionLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_EMailCaptionLabel_Push
 Tkw_About_Control_EMailCaptionLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_EMailLabel
 Tkw_About_Control_EMailLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_EMailLabel_Push
 Tkw_About_Control_EMailLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_LoginCaptionLabel
 Tkw_About_Control_LoginCaptionLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_LoginCaptionLabel_Push
 Tkw_About_Control_LoginCaptionLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_UserCaptionLabel
 Tkw_About_Control_UserCaptionLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_UserCaptionLabel_Push
 Tkw_About_Control_UserCaptionLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_UserNameLabel
 Tkw_About_Control_UserNameLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_UserNameLabel_Push
 Tkw_About_Control_UserNameLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_LoginLabel
 Tkw_About_Control_LoginLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_LoginLabel_Push
 Tkw_About_Control_LoginLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_CopyrightCaptionLabel
 Tkw_About_Control_CopyrightCaptionLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_CopyrightCaptionLabel_Push
 Tkw_About_Control_CopyrightCaptionLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_OkButton
 Tkw_About_Control_OkButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_OkButton_Push
 Tkw_About_Control_OkButton_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_UserCountCaptionLabel
 Tkw_About_Control_UserCountCaptionLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_UserCountCaptionLabel_Push
 Tkw_About_Control_UserCountCaptionLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_AdapterCaptionLabel
 Tkw_About_Control_AdapterCaptionLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_About_Control_AdapterCaptionLabel_Push
 Tkw_About_Control_AdapterCaptionLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efAbout_pbLogo
 TkwEfAboutPbLogo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efAbout_ShellInfoLabel
 TkwEfAboutShellInfoLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efAbout_AdapterInfoLabel
 TkwEfAboutAdapterInfoLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efAbout_UserCountLabel
 TkwEfAboutUserCountLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efAbout_OwnerLabel
 TkwEfAboutOwnerLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efAbout_ShellCaptionLabel
 TkwEfAboutShellCaptionLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efAbout_OwnerCaptionLabel
 TkwEfAboutOwnerCaptionLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efAbout_UserInfoGroupBox
 TkwEfAboutUserInfoGroupBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efAbout_EMailCaptionLabel
 TkwEfAboutEMailCaptionLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efAbout_EMailLabel
 TkwEfAboutEMailLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efAbout_LoginCaptionLabel
 TkwEfAboutLoginCaptionLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efAbout_UserCaptionLabel
 TkwEfAboutUserCaptionLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efAbout_UserNameLabel
 TkwEfAboutUserNameLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efAbout_LoginLabel
 TkwEfAboutLoginLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efAbout_CopyrightCaptionLabel
 TkwEfAboutCopyrightCaptionLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efAbout_OkButton
 TkwEfAboutOkButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efAbout_UserCountCaptionLabel
 TkwEfAboutUserCountCaptionLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efAbout_AdapterCaptionLabel
 TkwEfAboutAdapterCaptionLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа About
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefAbout));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TPaintBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtGroupBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtGroupBox));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtButton
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtButton));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.
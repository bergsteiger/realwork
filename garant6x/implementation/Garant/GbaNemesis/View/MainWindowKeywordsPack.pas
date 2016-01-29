unit MainWindowKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/MainWindowKeywordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Оболочка Без Прецедентов::F1 Without Usecases::View::PrimNemesis::MainWindowKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы MainWindow
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
  {$If defined(Nemesis)}
  ,
  nscNavigator
  {$IfEnd} //Nemesis
  ,
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel,
  MainWindow_Form,
  tfwScriptingInterfaces
  {$If defined(Nemesis)}
  ,
  nscStatusBar
  {$IfEnd} //Nemesis
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString
  {$If defined(Nemesis)}
  ,
  nscReminder
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscRemindersLine
  {$IfEnd} //Nemesis
  ,
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
 Tkw_Form_MainWindow = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора формы MainWindow
----
*Пример использования*:
[code]
'aControl' форма::MainWindow TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_MainWindow

// start class Tkw_Form_MainWindow

class function Tkw_Form_MainWindow.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::MainWindow';
end;//Tkw_Form_MainWindow.GetWordNameForRegister

function Tkw_Form_MainWindow.GetString: AnsiString;
 {-}
begin
 Result := 'nsMainWindow';
end;//Tkw_Form_MainWindow.GetString

type
 Tkw_MainWindow_Control_remOnlineDead = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола remOnlineDead
----
*Пример использования*:
[code]
контрол::remOnlineDead TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_remOnlineDead

// start class Tkw_MainWindow_Control_remOnlineDead

class function Tkw_MainWindow_Control_remOnlineDead.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::remOnlineDead';
end;//Tkw_MainWindow_Control_remOnlineDead.GetWordNameForRegister

function Tkw_MainWindow_Control_remOnlineDead.GetString: AnsiString;
 {-}
begin
 Result := 'remOnlineDead';
end;//Tkw_MainWindow_Control_remOnlineDead.GetString

class procedure Tkw_MainWindow_Control_remOnlineDead.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_MainWindow_Control_remOnlineDead.RegisterInEngine

type
 Tkw_MainWindow_Control_remOnlineDead_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола remOnlineDead
----
*Пример использования*:
[code]
контрол::remOnlineDead:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_remOnlineDead_Push

// start class Tkw_MainWindow_Control_remOnlineDead_Push

procedure Tkw_MainWindow_Control_remOnlineDead_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('remOnlineDead');
 inherited;
end;//Tkw_MainWindow_Control_remOnlineDead_Push.DoDoIt

class function Tkw_MainWindow_Control_remOnlineDead_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::remOnlineDead:push';
end;//Tkw_MainWindow_Control_remOnlineDead_Push.GetWordNameForRegister

type
 Tkw_MainWindow_Control_remNewChatMessages = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола remNewChatMessages
----
*Пример использования*:
[code]
контрол::remNewChatMessages TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_remNewChatMessages

// start class Tkw_MainWindow_Control_remNewChatMessages

class function Tkw_MainWindow_Control_remNewChatMessages.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::remNewChatMessages';
end;//Tkw_MainWindow_Control_remNewChatMessages.GetWordNameForRegister

function Tkw_MainWindow_Control_remNewChatMessages.GetString: AnsiString;
 {-}
begin
 Result := 'remNewChatMessages';
end;//Tkw_MainWindow_Control_remNewChatMessages.GetString

class procedure Tkw_MainWindow_Control_remNewChatMessages.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_MainWindow_Control_remNewChatMessages.RegisterInEngine

type
 Tkw_MainWindow_Control_remNewChatMessages_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола remNewChatMessages
----
*Пример использования*:
[code]
контрол::remNewChatMessages:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_remNewChatMessages_Push

// start class Tkw_MainWindow_Control_remNewChatMessages_Push

procedure Tkw_MainWindow_Control_remNewChatMessages_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('remNewChatMessages');
 inherited;
end;//Tkw_MainWindow_Control_remNewChatMessages_Push.DoDoIt

class function Tkw_MainWindow_Control_remNewChatMessages_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::remNewChatMessages:push';
end;//Tkw_MainWindow_Control_remNewChatMessages_Push.GetWordNameForRegister

type
 Tkw_MainWindow_Control_TrialModeWarning = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TrialModeWarning
----
*Пример использования*:
[code]
контрол::TrialModeWarning TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_TrialModeWarning

// start class Tkw_MainWindow_Control_TrialModeWarning

class function Tkw_MainWindow_Control_TrialModeWarning.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::TrialModeWarning';
end;//Tkw_MainWindow_Control_TrialModeWarning.GetWordNameForRegister

function Tkw_MainWindow_Control_TrialModeWarning.GetString: AnsiString;
 {-}
begin
 Result := 'TrialModeWarning';
end;//Tkw_MainWindow_Control_TrialModeWarning.GetString

class procedure Tkw_MainWindow_Control_TrialModeWarning.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_MainWindow_Control_TrialModeWarning.RegisterInEngine

type
 Tkw_MainWindow_Control_TrialModeWarning_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола TrialModeWarning
----
*Пример использования*:
[code]
контрол::TrialModeWarning:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_TrialModeWarning_Push

// start class Tkw_MainWindow_Control_TrialModeWarning_Push

procedure Tkw_MainWindow_Control_TrialModeWarning_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('TrialModeWarning');
 inherited;
end;//Tkw_MainWindow_Control_TrialModeWarning_Push.DoDoIt

class function Tkw_MainWindow_Control_TrialModeWarning_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::TrialModeWarning:push';
end;//Tkw_MainWindow_Control_TrialModeWarning_Push.GetWordNameForRegister

type
 Tkw_MainWindow_Control_OldBaseWarning = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола OldBaseWarning
----
*Пример использования*:
[code]
контрол::OldBaseWarning TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_OldBaseWarning

// start class Tkw_MainWindow_Control_OldBaseWarning

class function Tkw_MainWindow_Control_OldBaseWarning.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::OldBaseWarning';
end;//Tkw_MainWindow_Control_OldBaseWarning.GetWordNameForRegister

function Tkw_MainWindow_Control_OldBaseWarning.GetString: AnsiString;
 {-}
begin
 Result := 'OldBaseWarning';
end;//Tkw_MainWindow_Control_OldBaseWarning.GetString

class procedure Tkw_MainWindow_Control_OldBaseWarning.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_MainWindow_Control_OldBaseWarning.RegisterInEngine

type
 Tkw_MainWindow_Control_OldBaseWarning_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола OldBaseWarning
----
*Пример использования*:
[code]
контрол::OldBaseWarning:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_OldBaseWarning_Push

// start class Tkw_MainWindow_Control_OldBaseWarning_Push

procedure Tkw_MainWindow_Control_OldBaseWarning_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('OldBaseWarning');
 inherited;
end;//Tkw_MainWindow_Control_OldBaseWarning_Push.DoDoIt

class function Tkw_MainWindow_Control_OldBaseWarning_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::OldBaseWarning:push';
end;//Tkw_MainWindow_Control_OldBaseWarning_Push.GetWordNameForRegister

type
 Tkw_MainWindow_Control_RemindersLine = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола RemindersLine
----
*Пример использования*:
[code]
контрол::RemindersLine TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_RemindersLine

// start class Tkw_MainWindow_Control_RemindersLine

class function Tkw_MainWindow_Control_RemindersLine.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RemindersLine';
end;//Tkw_MainWindow_Control_RemindersLine.GetWordNameForRegister

function Tkw_MainWindow_Control_RemindersLine.GetString: AnsiString;
 {-}
begin
 Result := 'RemindersLine';
end;//Tkw_MainWindow_Control_RemindersLine.GetString

class procedure Tkw_MainWindow_Control_RemindersLine.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscRemindersLine);
end;//Tkw_MainWindow_Control_RemindersLine.RegisterInEngine

type
 Tkw_MainWindow_Control_RemindersLine_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола RemindersLine
----
*Пример использования*:
[code]
контрол::RemindersLine:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_RemindersLine_Push

// start class Tkw_MainWindow_Control_RemindersLine_Push

procedure Tkw_MainWindow_Control_RemindersLine_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('RemindersLine');
 inherited;
end;//Tkw_MainWindow_Control_RemindersLine_Push.DoDoIt

class function Tkw_MainWindow_Control_RemindersLine_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RemindersLine:push';
end;//Tkw_MainWindow_Control_RemindersLine_Push.GetWordNameForRegister

type
 Tkw_MainWindow_Control_ControlledChangingWarning = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ControlledChangingWarning
----
*Пример использования*:
[code]
контрол::ControlledChangingWarning TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_ControlledChangingWarning

// start class Tkw_MainWindow_Control_ControlledChangingWarning

class function Tkw_MainWindow_Control_ControlledChangingWarning.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ControlledChangingWarning';
end;//Tkw_MainWindow_Control_ControlledChangingWarning.GetWordNameForRegister

function Tkw_MainWindow_Control_ControlledChangingWarning.GetString: AnsiString;
 {-}
begin
 Result := 'ControlledChangingWarning';
end;//Tkw_MainWindow_Control_ControlledChangingWarning.GetString

class procedure Tkw_MainWindow_Control_ControlledChangingWarning.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_MainWindow_Control_ControlledChangingWarning.RegisterInEngine

type
 Tkw_MainWindow_Control_ControlledChangingWarning_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола ControlledChangingWarning
----
*Пример использования*:
[code]
контрол::ControlledChangingWarning:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_ControlledChangingWarning_Push

// start class Tkw_MainWindow_Control_ControlledChangingWarning_Push

procedure Tkw_MainWindow_Control_ControlledChangingWarning_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ControlledChangingWarning');
 inherited;
end;//Tkw_MainWindow_Control_ControlledChangingWarning_Push.DoDoIt

class function Tkw_MainWindow_Control_ControlledChangingWarning_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ControlledChangingWarning:push';
end;//Tkw_MainWindow_Control_ControlledChangingWarning_Push.GetWordNameForRegister

type
 Tkw_MainWindow_Control_remUnreadConsultations = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола remUnreadConsultations
----
*Пример использования*:
[code]
контрол::remUnreadConsultations TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_remUnreadConsultations

// start class Tkw_MainWindow_Control_remUnreadConsultations

class function Tkw_MainWindow_Control_remUnreadConsultations.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::remUnreadConsultations';
end;//Tkw_MainWindow_Control_remUnreadConsultations.GetWordNameForRegister

function Tkw_MainWindow_Control_remUnreadConsultations.GetString: AnsiString;
 {-}
begin
 Result := 'remUnreadConsultations';
end;//Tkw_MainWindow_Control_remUnreadConsultations.GetString

class procedure Tkw_MainWindow_Control_remUnreadConsultations.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_MainWindow_Control_remUnreadConsultations.RegisterInEngine

type
 Tkw_MainWindow_Control_remUnreadConsultations_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола remUnreadConsultations
----
*Пример использования*:
[code]
контрол::remUnreadConsultations:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_remUnreadConsultations_Push

// start class Tkw_MainWindow_Control_remUnreadConsultations_Push

procedure Tkw_MainWindow_Control_remUnreadConsultations_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('remUnreadConsultations');
 inherited;
end;//Tkw_MainWindow_Control_remUnreadConsultations_Push.DoDoIt

class function Tkw_MainWindow_Control_remUnreadConsultations_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::remUnreadConsultations:push';
end;//Tkw_MainWindow_Control_remUnreadConsultations_Push.GetWordNameForRegister

type
 Tkw_MainWindow_Control_StatusBar = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола StatusBar
----
*Пример использования*:
[code]
контрол::StatusBar TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_StatusBar

// start class Tkw_MainWindow_Control_StatusBar

class function Tkw_MainWindow_Control_StatusBar.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::StatusBar';
end;//Tkw_MainWindow_Control_StatusBar.GetWordNameForRegister

function Tkw_MainWindow_Control_StatusBar.GetString: AnsiString;
 {-}
begin
 Result := 'StatusBar';
end;//Tkw_MainWindow_Control_StatusBar.GetString

class procedure Tkw_MainWindow_Control_StatusBar.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscStatusBar);
end;//Tkw_MainWindow_Control_StatusBar.RegisterInEngine

type
 Tkw_MainWindow_Control_StatusBar_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола StatusBar
----
*Пример использования*:
[code]
контрол::StatusBar:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_StatusBar_Push

// start class Tkw_MainWindow_Control_StatusBar_Push

procedure Tkw_MainWindow_Control_StatusBar_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('StatusBar');
 inherited;
end;//Tkw_MainWindow_Control_StatusBar_Push.DoDoIt

class function Tkw_MainWindow_Control_StatusBar_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::StatusBar:push';
end;//Tkw_MainWindow_Control_StatusBar_Push.GetWordNameForRegister

type
 Tkw_MainWindow_Control_ClientZone = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ClientZone
----
*Пример использования*:
[code]
контрол::ClientZone TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_ClientZone

// start class Tkw_MainWindow_Control_ClientZone

class function Tkw_MainWindow_Control_ClientZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ClientZone';
end;//Tkw_MainWindow_Control_ClientZone.GetWordNameForRegister

function Tkw_MainWindow_Control_ClientZone.GetString: AnsiString;
 {-}
begin
 Result := 'ClientZone';
end;//Tkw_MainWindow_Control_ClientZone.GetString

class procedure Tkw_MainWindow_Control_ClientZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainWindow_Control_ClientZone.RegisterInEngine

type
 Tkw_MainWindow_Control_ClientZone_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола ClientZone
----
*Пример использования*:
[code]
контрол::ClientZone:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_ClientZone_Push

// start class Tkw_MainWindow_Control_ClientZone_Push

procedure Tkw_MainWindow_Control_ClientZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ClientZone');
 inherited;
end;//Tkw_MainWindow_Control_ClientZone_Push.DoDoIt

class function Tkw_MainWindow_Control_ClientZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ClientZone:push';
end;//Tkw_MainWindow_Control_ClientZone_Push.GetWordNameForRegister

type
 Tkw_MainWindow_Control_MainZone = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола MainZone
----
*Пример использования*:
[code]
контрол::MainZone TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_MainZone

// start class Tkw_MainWindow_Control_MainZone

class function Tkw_MainWindow_Control_MainZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::MainZone';
end;//Tkw_MainWindow_Control_MainZone.GetWordNameForRegister

function Tkw_MainWindow_Control_MainZone.GetString: AnsiString;
 {-}
begin
 Result := 'MainZone';
end;//Tkw_MainWindow_Control_MainZone.GetString

class procedure Tkw_MainWindow_Control_MainZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_MainWindow_Control_MainZone.RegisterInEngine

type
 Tkw_MainWindow_Control_MainZone_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола MainZone
----
*Пример использования*:
[code]
контрол::MainZone:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_MainZone_Push

// start class Tkw_MainWindow_Control_MainZone_Push

procedure Tkw_MainWindow_Control_MainZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('MainZone');
 inherited;
end;//Tkw_MainWindow_Control_MainZone_Push.DoDoIt

class function Tkw_MainWindow_Control_MainZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::MainZone:push';
end;//Tkw_MainWindow_Control_MainZone_Push.GetWordNameForRegister

type
 Tkw_MainWindow_Control_ParentZonePanel = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ParentZonePanel
----
*Пример использования*:
[code]
контрол::ParentZonePanel TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_ParentZonePanel

// start class Tkw_MainWindow_Control_ParentZonePanel

class function Tkw_MainWindow_Control_ParentZonePanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ParentZonePanel';
end;//Tkw_MainWindow_Control_ParentZonePanel.GetWordNameForRegister

function Tkw_MainWindow_Control_ParentZonePanel.GetString: AnsiString;
 {-}
begin
 Result := 'ParentZonePanel';
end;//Tkw_MainWindow_Control_ParentZonePanel.GetString

class procedure Tkw_MainWindow_Control_ParentZonePanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainWindow_Control_ParentZonePanel.RegisterInEngine

type
 Tkw_MainWindow_Control_ParentZonePanel_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола ParentZonePanel
----
*Пример использования*:
[code]
контрол::ParentZonePanel:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_ParentZonePanel_Push

// start class Tkw_MainWindow_Control_ParentZonePanel_Push

procedure Tkw_MainWindow_Control_ParentZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ParentZonePanel');
 inherited;
end;//Tkw_MainWindow_Control_ParentZonePanel_Push.DoDoIt

class function Tkw_MainWindow_Control_ParentZonePanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ParentZonePanel:push';
end;//Tkw_MainWindow_Control_ParentZonePanel_Push.GetWordNameForRegister

type
 Tkw_MainWindow_Control_ChildZonePanel = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ChildZonePanel
----
*Пример использования*:
[code]
контрол::ChildZonePanel TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_ChildZonePanel

// start class Tkw_MainWindow_Control_ChildZonePanel

class function Tkw_MainWindow_Control_ChildZonePanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ChildZonePanel';
end;//Tkw_MainWindow_Control_ChildZonePanel.GetWordNameForRegister

function Tkw_MainWindow_Control_ChildZonePanel.GetString: AnsiString;
 {-}
begin
 Result := 'ChildZonePanel';
end;//Tkw_MainWindow_Control_ChildZonePanel.GetString

class procedure Tkw_MainWindow_Control_ChildZonePanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_MainWindow_Control_ChildZonePanel.RegisterInEngine

type
 Tkw_MainWindow_Control_ChildZonePanel_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола ChildZonePanel
----
*Пример использования*:
[code]
контрол::ChildZonePanel:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_ChildZonePanel_Push

// start class Tkw_MainWindow_Control_ChildZonePanel_Push

procedure Tkw_MainWindow_Control_ChildZonePanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ChildZonePanel');
 inherited;
end;//Tkw_MainWindow_Control_ChildZonePanel_Push.DoDoIt

class function Tkw_MainWindow_Control_ChildZonePanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ChildZonePanel:push';
end;//Tkw_MainWindow_Control_ChildZonePanel_Push.GetWordNameForRegister

type
 Tkw_MainWindow_Control_BaseSearchPanel = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BaseSearchPanel
----
*Пример использования*:
[code]
контрол::BaseSearchPanel TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_BaseSearchPanel

// start class Tkw_MainWindow_Control_BaseSearchPanel

class function Tkw_MainWindow_Control_BaseSearchPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BaseSearchPanel';
end;//Tkw_MainWindow_Control_BaseSearchPanel.GetWordNameForRegister

function Tkw_MainWindow_Control_BaseSearchPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BaseSearchPanel';
end;//Tkw_MainWindow_Control_BaseSearchPanel.GetString

class procedure Tkw_MainWindow_Control_BaseSearchPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainWindow_Control_BaseSearchPanel.RegisterInEngine

type
 Tkw_MainWindow_Control_BaseSearchPanel_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола BaseSearchPanel
----
*Пример использования*:
[code]
контрол::BaseSearchPanel:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_BaseSearchPanel_Push

// start class Tkw_MainWindow_Control_BaseSearchPanel_Push

procedure Tkw_MainWindow_Control_BaseSearchPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BaseSearchPanel');
 inherited;
end;//Tkw_MainWindow_Control_BaseSearchPanel_Push.DoDoIt

class function Tkw_MainWindow_Control_BaseSearchPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BaseSearchPanel:push';
end;//Tkw_MainWindow_Control_BaseSearchPanel_Push.GetWordNameForRegister

type
 Tkw_MainWindow_Control_LeftNavigator = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола LeftNavigator
----
*Пример использования*:
[code]
контрол::LeftNavigator TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_LeftNavigator

// start class Tkw_MainWindow_Control_LeftNavigator

class function Tkw_MainWindow_Control_LeftNavigator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::LeftNavigator';
end;//Tkw_MainWindow_Control_LeftNavigator.GetWordNameForRegister

function Tkw_MainWindow_Control_LeftNavigator.GetString: AnsiString;
 {-}
begin
 Result := 'LeftNavigator';
end;//Tkw_MainWindow_Control_LeftNavigator.GetString

class procedure Tkw_MainWindow_Control_LeftNavigator.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscNavigator);
end;//Tkw_MainWindow_Control_LeftNavigator.RegisterInEngine

type
 Tkw_MainWindow_Control_LeftNavigator_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола LeftNavigator
----
*Пример использования*:
[code]
контрол::LeftNavigator:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_LeftNavigator_Push

// start class Tkw_MainWindow_Control_LeftNavigator_Push

procedure Tkw_MainWindow_Control_LeftNavigator_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('LeftNavigator');
 inherited;
end;//Tkw_MainWindow_Control_LeftNavigator_Push.DoDoIt

class function Tkw_MainWindow_Control_LeftNavigator_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::LeftNavigator:push';
end;//Tkw_MainWindow_Control_LeftNavigator_Push.GetWordNameForRegister
{$If defined(HasRightNavigator) AND not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

type
 Tkw_MainWindow_Control_RightNavigator = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола RightNavigator
----
*Пример использования*:
[code]
контрол::RightNavigator TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainWindow_Control_RightNavigator
{$IfEnd} //HasRightNavigator AND not Admin AND not Monitorings AND not NoScripts

{$If defined(HasRightNavigator) AND not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_MainWindow_Control_RightNavigator

class function Tkw_MainWindow_Control_RightNavigator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RightNavigator';
end;//Tkw_MainWindow_Control_RightNavigator.GetWordNameForRegister

function Tkw_MainWindow_Control_RightNavigator.GetString: AnsiString;
 {-}
begin
 Result := 'RightNavigator';
end;//Tkw_MainWindow_Control_RightNavigator.GetString

class procedure Tkw_MainWindow_Control_RightNavigator.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscNavigator);
end;//Tkw_MainWindow_Control_RightNavigator.RegisterInEngine

{$IfEnd} //HasRightNavigator AND not Admin AND not Monitorings AND not NoScripts
{$If defined(HasRightNavigator) AND not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

type
 Tkw_MainWindow_Control_RightNavigator_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола RightNavigator
----
*Пример использования*:
[code]
контрол::RightNavigator:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainWindow_Control_RightNavigator_Push
{$IfEnd} //HasRightNavigator AND not Admin AND not Monitorings AND not NoScripts

{$If defined(HasRightNavigator) AND not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_MainWindow_Control_RightNavigator_Push

procedure Tkw_MainWindow_Control_RightNavigator_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('RightNavigator');
 inherited;
end;//Tkw_MainWindow_Control_RightNavigator_Push.DoDoIt

class function Tkw_MainWindow_Control_RightNavigator_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RightNavigator:push';
end;//Tkw_MainWindow_Control_RightNavigator_Push.GetWordNameForRegister

{$IfEnd} //HasRightNavigator AND not Admin AND not Monitorings AND not NoScripts

type
 TkwMainWindowRemOnlineDead = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.remOnlineDead
[panel]Контрол remOnlineDead формы TnsMainWindow[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aMainWindow .TnsMainWindow.remOnlineDead >>> l_TnscReminder
[code]  }
 private
 // private methods
   function RemOnlineDead(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscReminder;
     {* Реализация слова скрипта .TnsMainWindow.remOnlineDead }
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
 end;//TkwMainWindowRemOnlineDead

// start class TkwMainWindowRemOnlineDead

function TkwMainWindowRemOnlineDead.RemOnlineDead(const aCtx: TtfwContext;
  aMainWindow: TnsMainWindow): TnscReminder;
 {-}
begin
 Result := aMainWindow.remOnlineDead;
end;//TkwMainWindowRemOnlineDead.RemOnlineDead

procedure TkwMainWindowRemOnlineDead.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMainWindow : TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RemOnlineDead(aCtx, l_aMainWindow)));
end;//TkwMainWindowRemOnlineDead.DoDoIt

class function TkwMainWindowRemOnlineDead.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TnsMainWindow.remOnlineDead';
end;//TkwMainWindowRemOnlineDead.GetWordNameForRegister

procedure TkwMainWindowRemOnlineDead.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству remOnlineDead', aCtx);
end;//TkwMainWindowRemOnlineDead.SetValuePrim

function TkwMainWindowRemOnlineDead.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscReminder);
end;//TkwMainWindowRemOnlineDead.GetResultTypeInfo

function TkwMainWindowRemOnlineDead.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMainWindowRemOnlineDead.GetAllParamsCount

function TkwMainWindowRemOnlineDead.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowRemOnlineDead.ParamsTypes

type
 TkwMainWindowRemNewChatMessages = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.remNewChatMessages
[panel]Контрол remNewChatMessages формы TnsMainWindow[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aMainWindow .TnsMainWindow.remNewChatMessages >>> l_TnscReminder
[code]  }
 private
 // private methods
   function RemNewChatMessages(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscReminder;
     {* Реализация слова скрипта .TnsMainWindow.remNewChatMessages }
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
 end;//TkwMainWindowRemNewChatMessages

// start class TkwMainWindowRemNewChatMessages

function TkwMainWindowRemNewChatMessages.RemNewChatMessages(const aCtx: TtfwContext;
  aMainWindow: TnsMainWindow): TnscReminder;
 {-}
begin
 Result := aMainWindow.remNewChatMessages;
end;//TkwMainWindowRemNewChatMessages.RemNewChatMessages

procedure TkwMainWindowRemNewChatMessages.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMainWindow : TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RemNewChatMessages(aCtx, l_aMainWindow)));
end;//TkwMainWindowRemNewChatMessages.DoDoIt

class function TkwMainWindowRemNewChatMessages.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TnsMainWindow.remNewChatMessages';
end;//TkwMainWindowRemNewChatMessages.GetWordNameForRegister

procedure TkwMainWindowRemNewChatMessages.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству remNewChatMessages', aCtx);
end;//TkwMainWindowRemNewChatMessages.SetValuePrim

function TkwMainWindowRemNewChatMessages.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscReminder);
end;//TkwMainWindowRemNewChatMessages.GetResultTypeInfo

function TkwMainWindowRemNewChatMessages.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMainWindowRemNewChatMessages.GetAllParamsCount

function TkwMainWindowRemNewChatMessages.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowRemNewChatMessages.ParamsTypes

type
 TkwMainWindowTrialModeWarning = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.TrialModeWarning
[panel]Контрол TrialModeWarning формы TnsMainWindow[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aMainWindow .TnsMainWindow.TrialModeWarning >>> l_TnscReminder
[code]  }
 private
 // private methods
   function TrialModeWarning(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscReminder;
     {* Реализация слова скрипта .TnsMainWindow.TrialModeWarning }
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
 end;//TkwMainWindowTrialModeWarning

// start class TkwMainWindowTrialModeWarning

function TkwMainWindowTrialModeWarning.TrialModeWarning(const aCtx: TtfwContext;
  aMainWindow: TnsMainWindow): TnscReminder;
 {-}
begin
 Result := aMainWindow.TrialModeWarning;
end;//TkwMainWindowTrialModeWarning.TrialModeWarning

procedure TkwMainWindowTrialModeWarning.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMainWindow : TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TrialModeWarning(aCtx, l_aMainWindow)));
end;//TkwMainWindowTrialModeWarning.DoDoIt

class function TkwMainWindowTrialModeWarning.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TnsMainWindow.TrialModeWarning';
end;//TkwMainWindowTrialModeWarning.GetWordNameForRegister

procedure TkwMainWindowTrialModeWarning.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству TrialModeWarning', aCtx);
end;//TkwMainWindowTrialModeWarning.SetValuePrim

function TkwMainWindowTrialModeWarning.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscReminder);
end;//TkwMainWindowTrialModeWarning.GetResultTypeInfo

function TkwMainWindowTrialModeWarning.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMainWindowTrialModeWarning.GetAllParamsCount

function TkwMainWindowTrialModeWarning.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowTrialModeWarning.ParamsTypes

type
 TkwMainWindowOldBaseWarning = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.OldBaseWarning
[panel]Контрол OldBaseWarning формы TnsMainWindow[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aMainWindow .TnsMainWindow.OldBaseWarning >>> l_TnscReminder
[code]  }
 private
 // private methods
   function OldBaseWarning(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscReminder;
     {* Реализация слова скрипта .TnsMainWindow.OldBaseWarning }
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
 end;//TkwMainWindowOldBaseWarning

// start class TkwMainWindowOldBaseWarning

function TkwMainWindowOldBaseWarning.OldBaseWarning(const aCtx: TtfwContext;
  aMainWindow: TnsMainWindow): TnscReminder;
 {-}
begin
 Result := aMainWindow.OldBaseWarning;
end;//TkwMainWindowOldBaseWarning.OldBaseWarning

procedure TkwMainWindowOldBaseWarning.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMainWindow : TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((OldBaseWarning(aCtx, l_aMainWindow)));
end;//TkwMainWindowOldBaseWarning.DoDoIt

class function TkwMainWindowOldBaseWarning.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TnsMainWindow.OldBaseWarning';
end;//TkwMainWindowOldBaseWarning.GetWordNameForRegister

procedure TkwMainWindowOldBaseWarning.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству OldBaseWarning', aCtx);
end;//TkwMainWindowOldBaseWarning.SetValuePrim

function TkwMainWindowOldBaseWarning.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscReminder);
end;//TkwMainWindowOldBaseWarning.GetResultTypeInfo

function TkwMainWindowOldBaseWarning.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMainWindowOldBaseWarning.GetAllParamsCount

function TkwMainWindowOldBaseWarning.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowOldBaseWarning.ParamsTypes

type
 TkwMainWindowRemindersLine = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.RemindersLine
[panel]Контрол RemindersLine формы TnsMainWindow[panel]
*Тип результата:* TnscRemindersLine
*Пример:*
[code]
OBJECT VAR l_TnscRemindersLine
 aMainWindow .TnsMainWindow.RemindersLine >>> l_TnscRemindersLine
[code]  }
 private
 // private methods
   function RemindersLine(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscRemindersLine;
     {* Реализация слова скрипта .TnsMainWindow.RemindersLine }
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
 end;//TkwMainWindowRemindersLine

// start class TkwMainWindowRemindersLine

function TkwMainWindowRemindersLine.RemindersLine(const aCtx: TtfwContext;
  aMainWindow: TnsMainWindow): TnscRemindersLine;
 {-}
begin
 Result := aMainWindow.RemindersLine;
end;//TkwMainWindowRemindersLine.RemindersLine

procedure TkwMainWindowRemindersLine.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMainWindow : TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RemindersLine(aCtx, l_aMainWindow)));
end;//TkwMainWindowRemindersLine.DoDoIt

class function TkwMainWindowRemindersLine.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TnsMainWindow.RemindersLine';
end;//TkwMainWindowRemindersLine.GetWordNameForRegister

procedure TkwMainWindowRemindersLine.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству RemindersLine', aCtx);
end;//TkwMainWindowRemindersLine.SetValuePrim

function TkwMainWindowRemindersLine.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscRemindersLine);
end;//TkwMainWindowRemindersLine.GetResultTypeInfo

function TkwMainWindowRemindersLine.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMainWindowRemindersLine.GetAllParamsCount

function TkwMainWindowRemindersLine.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowRemindersLine.ParamsTypes

type
 TkwMainWindowControlledChangingWarning = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.ControlledChangingWarning
[panel]Контрол ControlledChangingWarning формы TnsMainWindow[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aMainWindow .TnsMainWindow.ControlledChangingWarning >>> l_TnscReminder
[code]  }
 private
 // private methods
   function ControlledChangingWarning(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscReminder;
     {* Реализация слова скрипта .TnsMainWindow.ControlledChangingWarning }
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
 end;//TkwMainWindowControlledChangingWarning

// start class TkwMainWindowControlledChangingWarning

function TkwMainWindowControlledChangingWarning.ControlledChangingWarning(const aCtx: TtfwContext;
  aMainWindow: TnsMainWindow): TnscReminder;
 {-}
begin
 Result := aMainWindow.ControlledChangingWarning;
end;//TkwMainWindowControlledChangingWarning.ControlledChangingWarning

procedure TkwMainWindowControlledChangingWarning.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMainWindow : TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ControlledChangingWarning(aCtx, l_aMainWindow)));
end;//TkwMainWindowControlledChangingWarning.DoDoIt

class function TkwMainWindowControlledChangingWarning.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TnsMainWindow.ControlledChangingWarning';
end;//TkwMainWindowControlledChangingWarning.GetWordNameForRegister

procedure TkwMainWindowControlledChangingWarning.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ControlledChangingWarning', aCtx);
end;//TkwMainWindowControlledChangingWarning.SetValuePrim

function TkwMainWindowControlledChangingWarning.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscReminder);
end;//TkwMainWindowControlledChangingWarning.GetResultTypeInfo

function TkwMainWindowControlledChangingWarning.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMainWindowControlledChangingWarning.GetAllParamsCount

function TkwMainWindowControlledChangingWarning.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowControlledChangingWarning.ParamsTypes

type
 TkwMainWindowRemUnreadConsultations = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.remUnreadConsultations
[panel]Контрол remUnreadConsultations формы TnsMainWindow[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aMainWindow .TnsMainWindow.remUnreadConsultations >>> l_TnscReminder
[code]  }
 private
 // private methods
   function RemUnreadConsultations(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscReminder;
     {* Реализация слова скрипта .TnsMainWindow.remUnreadConsultations }
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
 end;//TkwMainWindowRemUnreadConsultations

// start class TkwMainWindowRemUnreadConsultations

function TkwMainWindowRemUnreadConsultations.RemUnreadConsultations(const aCtx: TtfwContext;
  aMainWindow: TnsMainWindow): TnscReminder;
 {-}
begin
 Result := aMainWindow.remUnreadConsultations;
end;//TkwMainWindowRemUnreadConsultations.RemUnreadConsultations

procedure TkwMainWindowRemUnreadConsultations.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMainWindow : TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RemUnreadConsultations(aCtx, l_aMainWindow)));
end;//TkwMainWindowRemUnreadConsultations.DoDoIt

class function TkwMainWindowRemUnreadConsultations.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TnsMainWindow.remUnreadConsultations';
end;//TkwMainWindowRemUnreadConsultations.GetWordNameForRegister

procedure TkwMainWindowRemUnreadConsultations.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству remUnreadConsultations', aCtx);
end;//TkwMainWindowRemUnreadConsultations.SetValuePrim

function TkwMainWindowRemUnreadConsultations.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscReminder);
end;//TkwMainWindowRemUnreadConsultations.GetResultTypeInfo

function TkwMainWindowRemUnreadConsultations.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMainWindowRemUnreadConsultations.GetAllParamsCount

function TkwMainWindowRemUnreadConsultations.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowRemUnreadConsultations.ParamsTypes

type
 TkwMainWindowStatusBar = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.StatusBar
[panel]Контрол StatusBar формы TnsMainWindow[panel]
*Тип результата:* TnscStatusBar
*Пример:*
[code]
OBJECT VAR l_TnscStatusBar
 aMainWindow .TnsMainWindow.StatusBar >>> l_TnscStatusBar
[code]  }
 private
 // private methods
   function StatusBar(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscStatusBar;
     {* Реализация слова скрипта .TnsMainWindow.StatusBar }
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
 end;//TkwMainWindowStatusBar

// start class TkwMainWindowStatusBar

function TkwMainWindowStatusBar.StatusBar(const aCtx: TtfwContext;
  aMainWindow: TnsMainWindow): TnscStatusBar;
 {-}
begin
 Result := aMainWindow.StatusBar;
end;//TkwMainWindowStatusBar.StatusBar

procedure TkwMainWindowStatusBar.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMainWindow : TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((StatusBar(aCtx, l_aMainWindow)));
end;//TkwMainWindowStatusBar.DoDoIt

class function TkwMainWindowStatusBar.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TnsMainWindow.StatusBar';
end;//TkwMainWindowStatusBar.GetWordNameForRegister

procedure TkwMainWindowStatusBar.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству StatusBar', aCtx);
end;//TkwMainWindowStatusBar.SetValuePrim

function TkwMainWindowStatusBar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscStatusBar);
end;//TkwMainWindowStatusBar.GetResultTypeInfo

function TkwMainWindowStatusBar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMainWindowStatusBar.GetAllParamsCount

function TkwMainWindowStatusBar.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowStatusBar.ParamsTypes

type
 TkwMainWindowClientZone = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.ClientZone
[panel]Контрол ClientZone формы TnsMainWindow[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aMainWindow .TnsMainWindow.ClientZone >>> l_TvtPanel
[code]  }
 private
 // private methods
   function ClientZone(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TvtPanel;
     {* Реализация слова скрипта .TnsMainWindow.ClientZone }
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
 end;//TkwMainWindowClientZone

// start class TkwMainWindowClientZone

function TkwMainWindowClientZone.ClientZone(const aCtx: TtfwContext;
  aMainWindow: TnsMainWindow): TvtPanel;
 {-}
begin
 Result := aMainWindow.ClientZone;
end;//TkwMainWindowClientZone.ClientZone

procedure TkwMainWindowClientZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMainWindow : TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ClientZone(aCtx, l_aMainWindow)));
end;//TkwMainWindowClientZone.DoDoIt

class function TkwMainWindowClientZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TnsMainWindow.ClientZone';
end;//TkwMainWindowClientZone.GetWordNameForRegister

procedure TkwMainWindowClientZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ClientZone', aCtx);
end;//TkwMainWindowClientZone.SetValuePrim

function TkwMainWindowClientZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMainWindowClientZone.GetResultTypeInfo

function TkwMainWindowClientZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMainWindowClientZone.GetAllParamsCount

function TkwMainWindowClientZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowClientZone.ParamsTypes

type
 TkwMainWindowMainZone = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.MainZone
[panel]Контрол MainZone формы TnsMainWindow[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aMainWindow .TnsMainWindow.MainZone >>> l_TvtProportionalPanel
[code]  }
 private
 // private methods
   function MainZone(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TvtProportionalPanel;
     {* Реализация слова скрипта .TnsMainWindow.MainZone }
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
 end;//TkwMainWindowMainZone

// start class TkwMainWindowMainZone

function TkwMainWindowMainZone.MainZone(const aCtx: TtfwContext;
  aMainWindow: TnsMainWindow): TvtProportionalPanel;
 {-}
begin
 Result := aMainWindow.MainZone;
end;//TkwMainWindowMainZone.MainZone

procedure TkwMainWindowMainZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMainWindow : TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((MainZone(aCtx, l_aMainWindow)));
end;//TkwMainWindowMainZone.DoDoIt

class function TkwMainWindowMainZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TnsMainWindow.MainZone';
end;//TkwMainWindowMainZone.GetWordNameForRegister

procedure TkwMainWindowMainZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству MainZone', aCtx);
end;//TkwMainWindowMainZone.SetValuePrim

function TkwMainWindowMainZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwMainWindowMainZone.GetResultTypeInfo

function TkwMainWindowMainZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMainWindowMainZone.GetAllParamsCount

function TkwMainWindowMainZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowMainZone.ParamsTypes

type
 TkwMainWindowParentZonePanel = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.ParentZonePanel
[panel]Контрол ParentZonePanel формы TnsMainWindow[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aMainWindow .TnsMainWindow.ParentZonePanel >>> l_TvtPanel
[code]  }
 private
 // private methods
   function ParentZonePanel(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TvtPanel;
     {* Реализация слова скрипта .TnsMainWindow.ParentZonePanel }
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
 end;//TkwMainWindowParentZonePanel

// start class TkwMainWindowParentZonePanel

function TkwMainWindowParentZonePanel.ParentZonePanel(const aCtx: TtfwContext;
  aMainWindow: TnsMainWindow): TvtPanel;
 {-}
begin
 Result := aMainWindow.ParentZonePanel;
end;//TkwMainWindowParentZonePanel.ParentZonePanel

procedure TkwMainWindowParentZonePanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMainWindow : TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ParentZonePanel(aCtx, l_aMainWindow)));
end;//TkwMainWindowParentZonePanel.DoDoIt

class function TkwMainWindowParentZonePanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TnsMainWindow.ParentZonePanel';
end;//TkwMainWindowParentZonePanel.GetWordNameForRegister

procedure TkwMainWindowParentZonePanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ParentZonePanel', aCtx);
end;//TkwMainWindowParentZonePanel.SetValuePrim

function TkwMainWindowParentZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMainWindowParentZonePanel.GetResultTypeInfo

function TkwMainWindowParentZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMainWindowParentZonePanel.GetAllParamsCount

function TkwMainWindowParentZonePanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowParentZonePanel.ParamsTypes

type
 TkwMainWindowChildZonePanel = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.ChildZonePanel
[panel]Контрол ChildZonePanel формы TnsMainWindow[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aMainWindow .TnsMainWindow.ChildZonePanel >>> l_TvtSizeablePanel
[code]  }
 private
 // private methods
   function ChildZonePanel(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TvtSizeablePanel;
     {* Реализация слова скрипта .TnsMainWindow.ChildZonePanel }
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
 end;//TkwMainWindowChildZonePanel

// start class TkwMainWindowChildZonePanel

function TkwMainWindowChildZonePanel.ChildZonePanel(const aCtx: TtfwContext;
  aMainWindow: TnsMainWindow): TvtSizeablePanel;
 {-}
begin
 Result := aMainWindow.ChildZonePanel;
end;//TkwMainWindowChildZonePanel.ChildZonePanel

procedure TkwMainWindowChildZonePanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMainWindow : TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ChildZonePanel(aCtx, l_aMainWindow)));
end;//TkwMainWindowChildZonePanel.DoDoIt

class function TkwMainWindowChildZonePanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TnsMainWindow.ChildZonePanel';
end;//TkwMainWindowChildZonePanel.GetWordNameForRegister

procedure TkwMainWindowChildZonePanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ChildZonePanel', aCtx);
end;//TkwMainWindowChildZonePanel.SetValuePrim

function TkwMainWindowChildZonePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwMainWindowChildZonePanel.GetResultTypeInfo

function TkwMainWindowChildZonePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMainWindowChildZonePanel.GetAllParamsCount

function TkwMainWindowChildZonePanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowChildZonePanel.ParamsTypes

type
 TkwMainWindowBaseSearchPanel = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.BaseSearchPanel
[panel]Контрол BaseSearchPanel формы TnsMainWindow[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aMainWindow .TnsMainWindow.BaseSearchPanel >>> l_TvtPanel
[code]  }
 private
 // private methods
   function BaseSearchPanel(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TvtPanel;
     {* Реализация слова скрипта .TnsMainWindow.BaseSearchPanel }
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
 end;//TkwMainWindowBaseSearchPanel

// start class TkwMainWindowBaseSearchPanel

function TkwMainWindowBaseSearchPanel.BaseSearchPanel(const aCtx: TtfwContext;
  aMainWindow: TnsMainWindow): TvtPanel;
 {-}
begin
 Result := aMainWindow.BaseSearchPanel;
end;//TkwMainWindowBaseSearchPanel.BaseSearchPanel

procedure TkwMainWindowBaseSearchPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMainWindow : TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BaseSearchPanel(aCtx, l_aMainWindow)));
end;//TkwMainWindowBaseSearchPanel.DoDoIt

class function TkwMainWindowBaseSearchPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TnsMainWindow.BaseSearchPanel';
end;//TkwMainWindowBaseSearchPanel.GetWordNameForRegister

procedure TkwMainWindowBaseSearchPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству BaseSearchPanel', aCtx);
end;//TkwMainWindowBaseSearchPanel.SetValuePrim

function TkwMainWindowBaseSearchPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMainWindowBaseSearchPanel.GetResultTypeInfo

function TkwMainWindowBaseSearchPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMainWindowBaseSearchPanel.GetAllParamsCount

function TkwMainWindowBaseSearchPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowBaseSearchPanel.ParamsTypes

type
 TkwMainWindowLeftNavigator = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.LeftNavigator
[panel]Контрол LeftNavigator формы TnsMainWindow[panel]
*Тип результата:* TnscNavigator
*Пример:*
[code]
OBJECT VAR l_TnscNavigator
 aMainWindow .TnsMainWindow.LeftNavigator >>> l_TnscNavigator
[code]  }
 private
 // private methods
   function LeftNavigator(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscNavigator;
     {* Реализация слова скрипта .TnsMainWindow.LeftNavigator }
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
 end;//TkwMainWindowLeftNavigator

// start class TkwMainWindowLeftNavigator

function TkwMainWindowLeftNavigator.LeftNavigator(const aCtx: TtfwContext;
  aMainWindow: TnsMainWindow): TnscNavigator;
 {-}
begin
 Result := aMainWindow.LeftNavigator;
end;//TkwMainWindowLeftNavigator.LeftNavigator

procedure TkwMainWindowLeftNavigator.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMainWindow : TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LeftNavigator(aCtx, l_aMainWindow)));
end;//TkwMainWindowLeftNavigator.DoDoIt

class function TkwMainWindowLeftNavigator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TnsMainWindow.LeftNavigator';
end;//TkwMainWindowLeftNavigator.GetWordNameForRegister

procedure TkwMainWindowLeftNavigator.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству LeftNavigator', aCtx);
end;//TkwMainWindowLeftNavigator.SetValuePrim

function TkwMainWindowLeftNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscNavigator);
end;//TkwMainWindowLeftNavigator.GetResultTypeInfo

function TkwMainWindowLeftNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMainWindowLeftNavigator.GetAllParamsCount

function TkwMainWindowLeftNavigator.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowLeftNavigator.ParamsTypes
{$If defined(HasRightNavigator) AND not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

type
 TkwMainWindowRightNavigator = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TnsMainWindow.RightNavigator
[panel]Контрол RightNavigator формы TnsMainWindow[panel]
*Тип результата:* TnscNavigator
*Пример:*
[code]
OBJECT VAR l_TnscNavigator
 aMainWindow .TnsMainWindow.RightNavigator >>> l_TnscNavigator
[code]  }
 private
 // private methods
   function RightNavigator(const aCtx: TtfwContext;
    aMainWindow: TnsMainWindow): TnscNavigator;
     {* Реализация слова скрипта .TnsMainWindow.RightNavigator }
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
 end;//TkwMainWindowRightNavigator
{$IfEnd} //HasRightNavigator AND not Admin AND not Monitorings AND not NoScripts

{$If defined(HasRightNavigator) AND not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class TkwMainWindowRightNavigator

function TkwMainWindowRightNavigator.RightNavigator(const aCtx: TtfwContext;
  aMainWindow: TnsMainWindow): TnscNavigator;
 {-}
begin
 Result := aMainWindow.RightNavigator;
end;//TkwMainWindowRightNavigator.RightNavigator

procedure TkwMainWindowRightNavigator.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMainWindow : TnsMainWindow;
begin
 try
  l_aMainWindow := TnsMainWindow(aCtx.rEngine.PopObjAs(TnsMainWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainWindow: TnsMainWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RightNavigator(aCtx, l_aMainWindow)));
end;//TkwMainWindowRightNavigator.DoDoIt

class function TkwMainWindowRightNavigator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TnsMainWindow.RightNavigator';
end;//TkwMainWindowRightNavigator.GetWordNameForRegister

procedure TkwMainWindowRightNavigator.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству RightNavigator', aCtx);
end;//TkwMainWindowRightNavigator.SetValuePrim

function TkwMainWindowRightNavigator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscNavigator);
end;//TkwMainWindowRightNavigator.GetResultTypeInfo

function TkwMainWindowRightNavigator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMainWindowRightNavigator.GetAllParamsCount

function TkwMainWindowRightNavigator.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TnsMainWindow)]);
end;//TkwMainWindowRightNavigator.ParamsTypes

{$IfEnd} //HasRightNavigator AND not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_MainWindow
 Tkw_Form_MainWindow.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_remOnlineDead
 Tkw_MainWindow_Control_remOnlineDead.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_remOnlineDead_Push
 Tkw_MainWindow_Control_remOnlineDead_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_remNewChatMessages
 Tkw_MainWindow_Control_remNewChatMessages.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_remNewChatMessages_Push
 Tkw_MainWindow_Control_remNewChatMessages_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_TrialModeWarning
 Tkw_MainWindow_Control_TrialModeWarning.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_TrialModeWarning_Push
 Tkw_MainWindow_Control_TrialModeWarning_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_OldBaseWarning
 Tkw_MainWindow_Control_OldBaseWarning.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_OldBaseWarning_Push
 Tkw_MainWindow_Control_OldBaseWarning_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_RemindersLine
 Tkw_MainWindow_Control_RemindersLine.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_RemindersLine_Push
 Tkw_MainWindow_Control_RemindersLine_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_ControlledChangingWarning
 Tkw_MainWindow_Control_ControlledChangingWarning.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_ControlledChangingWarning_Push
 Tkw_MainWindow_Control_ControlledChangingWarning_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_remUnreadConsultations
 Tkw_MainWindow_Control_remUnreadConsultations.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_remUnreadConsultations_Push
 Tkw_MainWindow_Control_remUnreadConsultations_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_StatusBar
 Tkw_MainWindow_Control_StatusBar.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_StatusBar_Push
 Tkw_MainWindow_Control_StatusBar_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_ClientZone
 Tkw_MainWindow_Control_ClientZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_ClientZone_Push
 Tkw_MainWindow_Control_ClientZone_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_MainZone
 Tkw_MainWindow_Control_MainZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_MainZone_Push
 Tkw_MainWindow_Control_MainZone_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_ParentZonePanel
 Tkw_MainWindow_Control_ParentZonePanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_ParentZonePanel_Push
 Tkw_MainWindow_Control_ParentZonePanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_ChildZonePanel
 Tkw_MainWindow_Control_ChildZonePanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_ChildZonePanel_Push
 Tkw_MainWindow_Control_ChildZonePanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_BaseSearchPanel
 Tkw_MainWindow_Control_BaseSearchPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_BaseSearchPanel_Push
 Tkw_MainWindow_Control_BaseSearchPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_LeftNavigator
 Tkw_MainWindow_Control_LeftNavigator.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_LeftNavigator_Push
 Tkw_MainWindow_Control_LeftNavigator_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If defined(HasRightNavigator) AND not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_RightNavigator
 Tkw_MainWindow_Control_RightNavigator.RegisterInEngine;
{$IfEnd} //HasRightNavigator AND not Admin AND not Monitorings AND not NoScripts
{$If defined(HasRightNavigator) AND not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MainWindow_Control_RightNavigator_Push
 Tkw_MainWindow_Control_RightNavigator_Push.RegisterInEngine;
{$IfEnd} //HasRightNavigator AND not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MainWindow_remOnlineDead
 TkwMainWindowRemOnlineDead.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MainWindow_remNewChatMessages
 TkwMainWindowRemNewChatMessages.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MainWindow_TrialModeWarning
 TkwMainWindowTrialModeWarning.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MainWindow_OldBaseWarning
 TkwMainWindowOldBaseWarning.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MainWindow_RemindersLine
 TkwMainWindowRemindersLine.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MainWindow_ControlledChangingWarning
 TkwMainWindowControlledChangingWarning.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MainWindow_remUnreadConsultations
 TkwMainWindowRemUnreadConsultations.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MainWindow_StatusBar
 TkwMainWindowStatusBar.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MainWindow_ClientZone
 TkwMainWindowClientZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MainWindow_MainZone
 TkwMainWindowMainZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MainWindow_ParentZonePanel
 TkwMainWindowParentZonePanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MainWindow_ChildZonePanel
 TkwMainWindowChildZonePanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MainWindow_BaseSearchPanel
 TkwMainWindowBaseSearchPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MainWindow_LeftNavigator
 TkwMainWindowLeftNavigator.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If defined(HasRightNavigator) AND not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MainWindow_RightNavigator
 TkwMainWindowRightNavigator.RegisterInEngine;
{$IfEnd} //HasRightNavigator AND not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа MainWindow
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnsMainWindow));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscReminder
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscReminder));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscRemindersLine
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscRemindersLine));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscStatusBar
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscStatusBar));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtProportionalPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtSizeablePanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscNavigator
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscNavigator));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.
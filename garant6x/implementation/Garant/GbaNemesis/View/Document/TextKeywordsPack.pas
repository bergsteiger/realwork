unit TextKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/TextKeywordsPack.pas"
// Начат: 05.02.2009 19:28
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Работа с документом и списком документов::Document::View::Document::Document::TextKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы Text
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
  nscEditor
  {$IfEnd} //Nemesis
  ,
  Text_Form,
  eeSubPanel,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  vtScrollBar,
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
  TtfwClassRef_Proxy
  {$If defined(Nemesis)}
  ,
  nscTextSource
  {$IfEnd} //Nemesis
  ,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_Text = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы Text
----
*Пример использования*:
[code]
'aControl' форма::Text TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_Text

// start class Tkw_Form_Text

class function Tkw_Form_Text.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::Text';
end;//Tkw_Form_Text.GetWordNameForRegister

function Tkw_Form_Text.GetString: AnsiString;
 {-}
begin
 Result := 'TextForm';
end;//Tkw_Form_Text.GetString

type
  Tkw_Text_Control_RemindersLine = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_Text_Control_RemindersLine

// start class Tkw_Text_Control_RemindersLine

class function Tkw_Text_Control_RemindersLine.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RemindersLine';
end;//Tkw_Text_Control_RemindersLine.GetWordNameForRegister

function Tkw_Text_Control_RemindersLine.GetString: AnsiString;
 {-}
begin
 Result := 'RemindersLine';
end;//Tkw_Text_Control_RemindersLine.GetString

class procedure Tkw_Text_Control_RemindersLine.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscRemindersLine);
end;//Tkw_Text_Control_RemindersLine.RegisterInEngine

type
  Tkw_Text_Control_RemindersLine_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_Text_Control_RemindersLine_Push

// start class Tkw_Text_Control_RemindersLine_Push

procedure Tkw_Text_Control_RemindersLine_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('RemindersLine');
 inherited;
end;//Tkw_Text_Control_RemindersLine_Push.DoDoIt

class function Tkw_Text_Control_RemindersLine_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RemindersLine:push';
end;//Tkw_Text_Control_RemindersLine_Push.GetWordNameForRegister

type
  Tkw_Text_Control_WarnTimeMachineException = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола WarnTimeMachineException
----
*Пример использования*:
[code]
контрол::WarnTimeMachineException TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Text_Control_WarnTimeMachineException

// start class Tkw_Text_Control_WarnTimeMachineException

class function Tkw_Text_Control_WarnTimeMachineException.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WarnTimeMachineException';
end;//Tkw_Text_Control_WarnTimeMachineException.GetWordNameForRegister

function Tkw_Text_Control_WarnTimeMachineException.GetString: AnsiString;
 {-}
begin
 Result := 'WarnTimeMachineException';
end;//Tkw_Text_Control_WarnTimeMachineException.GetString

class procedure Tkw_Text_Control_WarnTimeMachineException.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_Text_Control_WarnTimeMachineException.RegisterInEngine

type
  Tkw_Text_Control_WarnTimeMachineException_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола WarnTimeMachineException
----
*Пример использования*:
[code]
контрол::WarnTimeMachineException:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Text_Control_WarnTimeMachineException_Push

// start class Tkw_Text_Control_WarnTimeMachineException_Push

procedure Tkw_Text_Control_WarnTimeMachineException_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('WarnTimeMachineException');
 inherited;
end;//Tkw_Text_Control_WarnTimeMachineException_Push.DoDoIt

class function Tkw_Text_Control_WarnTimeMachineException_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WarnTimeMachineException:push';
end;//Tkw_Text_Control_WarnTimeMachineException_Push.GetWordNameForRegister

type
  Tkw_Text_Control_WarnIsAbolished = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола WarnIsAbolished
----
*Пример использования*:
[code]
контрол::WarnIsAbolished TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Text_Control_WarnIsAbolished

// start class Tkw_Text_Control_WarnIsAbolished

class function Tkw_Text_Control_WarnIsAbolished.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WarnIsAbolished';
end;//Tkw_Text_Control_WarnIsAbolished.GetWordNameForRegister

function Tkw_Text_Control_WarnIsAbolished.GetString: AnsiString;
 {-}
begin
 Result := 'WarnIsAbolished';
end;//Tkw_Text_Control_WarnIsAbolished.GetString

class procedure Tkw_Text_Control_WarnIsAbolished.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_Text_Control_WarnIsAbolished.RegisterInEngine

type
  Tkw_Text_Control_WarnIsAbolished_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола WarnIsAbolished
----
*Пример использования*:
[code]
контрол::WarnIsAbolished:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Text_Control_WarnIsAbolished_Push

// start class Tkw_Text_Control_WarnIsAbolished_Push

procedure Tkw_Text_Control_WarnIsAbolished_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('WarnIsAbolished');
 inherited;
end;//Tkw_Text_Control_WarnIsAbolished_Push.DoDoIt

class function Tkw_Text_Control_WarnIsAbolished_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WarnIsAbolished:push';
end;//Tkw_Text_Control_WarnIsAbolished_Push.GetWordNameForRegister

type
  Tkw_Text_Control_WarnPreActive = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола WarnPreActive
----
*Пример использования*:
[code]
контрол::WarnPreActive TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Text_Control_WarnPreActive

// start class Tkw_Text_Control_WarnPreActive

class function Tkw_Text_Control_WarnPreActive.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WarnPreActive';
end;//Tkw_Text_Control_WarnPreActive.GetWordNameForRegister

function Tkw_Text_Control_WarnPreActive.GetString: AnsiString;
 {-}
begin
 Result := 'WarnPreActive';
end;//Tkw_Text_Control_WarnPreActive.GetString

class procedure Tkw_Text_Control_WarnPreActive.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_Text_Control_WarnPreActive.RegisterInEngine

type
  Tkw_Text_Control_WarnPreActive_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола WarnPreActive
----
*Пример использования*:
[code]
контрол::WarnPreActive:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Text_Control_WarnPreActive_Push

// start class Tkw_Text_Control_WarnPreActive_Push

procedure Tkw_Text_Control_WarnPreActive_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('WarnPreActive');
 inherited;
end;//Tkw_Text_Control_WarnPreActive_Push.DoDoIt

class function Tkw_Text_Control_WarnPreActive_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WarnPreActive:push';
end;//Tkw_Text_Control_WarnPreActive_Push.GetWordNameForRegister

type
  Tkw_Text_Control_WarnTimeMachineWarning = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола WarnTimeMachineWarning
----
*Пример использования*:
[code]
контрол::WarnTimeMachineWarning TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Text_Control_WarnTimeMachineWarning

// start class Tkw_Text_Control_WarnTimeMachineWarning

class function Tkw_Text_Control_WarnTimeMachineWarning.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WarnTimeMachineWarning';
end;//Tkw_Text_Control_WarnTimeMachineWarning.GetWordNameForRegister

function Tkw_Text_Control_WarnTimeMachineWarning.GetString: AnsiString;
 {-}
begin
 Result := 'WarnTimeMachineWarning';
end;//Tkw_Text_Control_WarnTimeMachineWarning.GetString

class procedure Tkw_Text_Control_WarnTimeMachineWarning.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_Text_Control_WarnTimeMachineWarning.RegisterInEngine

type
  Tkw_Text_Control_WarnTimeMachineWarning_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола WarnTimeMachineWarning
----
*Пример использования*:
[code]
контрол::WarnTimeMachineWarning:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Text_Control_WarnTimeMachineWarning_Push

// start class Tkw_Text_Control_WarnTimeMachineWarning_Push

procedure Tkw_Text_Control_WarnTimeMachineWarning_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('WarnTimeMachineWarning');
 inherited;
end;//Tkw_Text_Control_WarnTimeMachineWarning_Push.DoDoIt

class function Tkw_Text_Control_WarnTimeMachineWarning_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WarnTimeMachineWarning:push';
end;//Tkw_Text_Control_WarnTimeMachineWarning_Push.GetWordNameForRegister

type
  Tkw_Text_Control_WarnOnControl = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола WarnOnControl
----
*Пример использования*:
[code]
контрол::WarnOnControl TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Text_Control_WarnOnControl

// start class Tkw_Text_Control_WarnOnControl

class function Tkw_Text_Control_WarnOnControl.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WarnOnControl';
end;//Tkw_Text_Control_WarnOnControl.GetWordNameForRegister

function Tkw_Text_Control_WarnOnControl.GetString: AnsiString;
 {-}
begin
 Result := 'WarnOnControl';
end;//Tkw_Text_Control_WarnOnControl.GetString

class procedure Tkw_Text_Control_WarnOnControl.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_Text_Control_WarnOnControl.RegisterInEngine

type
  Tkw_Text_Control_WarnOnControl_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола WarnOnControl
----
*Пример использования*:
[code]
контрол::WarnOnControl:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Text_Control_WarnOnControl_Push

// start class Tkw_Text_Control_WarnOnControl_Push

procedure Tkw_Text_Control_WarnOnControl_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('WarnOnControl');
 inherited;
end;//Tkw_Text_Control_WarnOnControl_Push.DoDoIt

class function Tkw_Text_Control_WarnOnControl_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WarnOnControl:push';
end;//Tkw_Text_Control_WarnOnControl_Push.GetWordNameForRegister

type
  Tkw_Text_Control_WarnJuror = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола WarnJuror
----
*Пример использования*:
[code]
контрол::WarnJuror TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Text_Control_WarnJuror

// start class Tkw_Text_Control_WarnJuror

class function Tkw_Text_Control_WarnJuror.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WarnJuror';
end;//Tkw_Text_Control_WarnJuror.GetWordNameForRegister

function Tkw_Text_Control_WarnJuror.GetString: AnsiString;
 {-}
begin
 Result := 'WarnJuror';
end;//Tkw_Text_Control_WarnJuror.GetString

class procedure Tkw_Text_Control_WarnJuror.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_Text_Control_WarnJuror.RegisterInEngine

type
  Tkw_Text_Control_WarnJuror_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола WarnJuror
----
*Пример использования*:
[code]
контрол::WarnJuror:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Text_Control_WarnJuror_Push

// start class Tkw_Text_Control_WarnJuror_Push

procedure Tkw_Text_Control_WarnJuror_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('WarnJuror');
 inherited;
end;//Tkw_Text_Control_WarnJuror_Push.DoDoIt

class function Tkw_Text_Control_WarnJuror_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WarnJuror:push';
end;//Tkw_Text_Control_WarnJuror_Push.GetWordNameForRegister

type
  Tkw_Text_Control_WarnRedaction = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола WarnRedaction
----
*Пример использования*:
[code]
контрол::WarnRedaction TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Text_Control_WarnRedaction

// start class Tkw_Text_Control_WarnRedaction

class function Tkw_Text_Control_WarnRedaction.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WarnRedaction';
end;//Tkw_Text_Control_WarnRedaction.GetWordNameForRegister

function Tkw_Text_Control_WarnRedaction.GetString: AnsiString;
 {-}
begin
 Result := 'WarnRedaction';
end;//Tkw_Text_Control_WarnRedaction.GetString

class procedure Tkw_Text_Control_WarnRedaction.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_Text_Control_WarnRedaction.RegisterInEngine

type
  Tkw_Text_Control_WarnRedaction_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола WarnRedaction
----
*Пример использования*:
[code]
контрол::WarnRedaction:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Text_Control_WarnRedaction_Push

// start class Tkw_Text_Control_WarnRedaction_Push

procedure Tkw_Text_Control_WarnRedaction_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('WarnRedaction');
 inherited;
end;//Tkw_Text_Control_WarnRedaction_Push.DoDoIt

class function Tkw_Text_Control_WarnRedaction_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WarnRedaction:push';
end;//Tkw_Text_Control_WarnRedaction_Push.GetWordNameForRegister

type
  Tkw_Text_Control_WarnInactualDocument = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола WarnInactualDocument
----
*Пример использования*:
[code]
контрол::WarnInactualDocument TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Text_Control_WarnInactualDocument

// start class Tkw_Text_Control_WarnInactualDocument

class function Tkw_Text_Control_WarnInactualDocument.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WarnInactualDocument';
end;//Tkw_Text_Control_WarnInactualDocument.GetWordNameForRegister

function Tkw_Text_Control_WarnInactualDocument.GetString: AnsiString;
 {-}
begin
 Result := 'WarnInactualDocument';
end;//Tkw_Text_Control_WarnInactualDocument.GetString

class procedure Tkw_Text_Control_WarnInactualDocument.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_Text_Control_WarnInactualDocument.RegisterInEngine

type
  Tkw_Text_Control_WarnInactualDocument_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола WarnInactualDocument
----
*Пример использования*:
[code]
контрол::WarnInactualDocument:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Text_Control_WarnInactualDocument_Push

// start class Tkw_Text_Control_WarnInactualDocument_Push

procedure Tkw_Text_Control_WarnInactualDocument_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('WarnInactualDocument');
 inherited;
end;//Tkw_Text_Control_WarnInactualDocument_Push.DoDoIt

class function Tkw_Text_Control_WarnInactualDocument_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WarnInactualDocument:push';
end;//Tkw_Text_Control_WarnInactualDocument_Push.GetWordNameForRegister

type
  Tkw_Text_Control_WarnTimeMachineOn = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола WarnTimeMachineOn
----
*Пример использования*:
[code]
контрол::WarnTimeMachineOn TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Text_Control_WarnTimeMachineOn

// start class Tkw_Text_Control_WarnTimeMachineOn

class function Tkw_Text_Control_WarnTimeMachineOn.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WarnTimeMachineOn';
end;//Tkw_Text_Control_WarnTimeMachineOn.GetWordNameForRegister

function Tkw_Text_Control_WarnTimeMachineOn.GetString: AnsiString;
 {-}
begin
 Result := 'WarnTimeMachineOn';
end;//Tkw_Text_Control_WarnTimeMachineOn.GetString

class procedure Tkw_Text_Control_WarnTimeMachineOn.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_Text_Control_WarnTimeMachineOn.RegisterInEngine

type
  Tkw_Text_Control_WarnTimeMachineOn_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола WarnTimeMachineOn
----
*Пример использования*:
[code]
контрол::WarnTimeMachineOn:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Text_Control_WarnTimeMachineOn_Push

// start class Tkw_Text_Control_WarnTimeMachineOn_Push

procedure Tkw_Text_Control_WarnTimeMachineOn_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('WarnTimeMachineOn');
 inherited;
end;//Tkw_Text_Control_WarnTimeMachineOn_Push.DoDoIt

class function Tkw_Text_Control_WarnTimeMachineOn_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WarnTimeMachineOn:push';
end;//Tkw_Text_Control_WarnTimeMachineOn_Push.GetWordNameForRegister

type
  Tkw_Text_Control_SubPanel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола SubPanel
----
*Пример использования*:
[code]
контрол::SubPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Text_Control_SubPanel

// start class Tkw_Text_Control_SubPanel

class function Tkw_Text_Control_SubPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::SubPanel';
end;//Tkw_Text_Control_SubPanel.GetWordNameForRegister

function Tkw_Text_Control_SubPanel.GetString: AnsiString;
 {-}
begin
 Result := 'SubPanel';
end;//Tkw_Text_Control_SubPanel.GetString

class procedure Tkw_Text_Control_SubPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TeeSubPanel);
end;//Tkw_Text_Control_SubPanel.RegisterInEngine

type
  Tkw_Text_Control_SubPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола SubPanel
----
*Пример использования*:
[code]
контрол::SubPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Text_Control_SubPanel_Push

// start class Tkw_Text_Control_SubPanel_Push

procedure Tkw_Text_Control_SubPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('SubPanel');
 inherited;
end;//Tkw_Text_Control_SubPanel_Push.DoDoIt

class function Tkw_Text_Control_SubPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::SubPanel:push';
end;//Tkw_Text_Control_SubPanel_Push.GetWordNameForRegister

type
  Tkw_Text_Control_HScroll = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола HScroll
----
*Пример использования*:
[code]
контрол::HScroll TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Text_Control_HScroll

// start class Tkw_Text_Control_HScroll

class function Tkw_Text_Control_HScroll.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::HScroll';
end;//Tkw_Text_Control_HScroll.GetWordNameForRegister

function Tkw_Text_Control_HScroll.GetString: AnsiString;
 {-}
begin
 Result := 'HScroll';
end;//Tkw_Text_Control_HScroll.GetString

class procedure Tkw_Text_Control_HScroll.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtScrollBar);
end;//Tkw_Text_Control_HScroll.RegisterInEngine

type
  Tkw_Text_Control_HScroll_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола HScroll
----
*Пример использования*:
[code]
контрол::HScroll:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Text_Control_HScroll_Push

// start class Tkw_Text_Control_HScroll_Push

procedure Tkw_Text_Control_HScroll_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('HScroll');
 inherited;
end;//Tkw_Text_Control_HScroll_Push.DoDoIt

class function Tkw_Text_Control_HScroll_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::HScroll:push';
end;//Tkw_Text_Control_HScroll_Push.GetWordNameForRegister

type
  Tkw_Text_Control_Text = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола Text
----
*Пример использования*:
[code]
контрол::Text TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Text_Control_Text

// start class Tkw_Text_Control_Text

class function Tkw_Text_Control_Text.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::Text';
end;//Tkw_Text_Control_Text.GetWordNameForRegister

function Tkw_Text_Control_Text.GetString: AnsiString;
 {-}
begin
 Result := 'Text';
end;//Tkw_Text_Control_Text.GetString

class procedure Tkw_Text_Control_Text.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_Text_Control_Text.RegisterInEngine

type
  Tkw_Text_Control_Text_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола Text
----
*Пример использования*:
[code]
контрол::Text:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Text_Control_Text_Push

// start class Tkw_Text_Control_Text_Push

procedure Tkw_Text_Control_Text_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Text');
 inherited;
end;//Tkw_Text_Control_Text_Push.DoDoIt

class function Tkw_Text_Control_Text_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::Text:push';
end;//Tkw_Text_Control_Text_Push.GetWordNameForRegister

type
  Tkw_Text_Component_TextSource = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола TextSource
----
*Пример использования*:
[code]
компонент::TextSource TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Text_Component_TextSource

// start class Tkw_Text_Component_TextSource

class function Tkw_Text_Component_TextSource.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'компонент::TextSource';
end;//Tkw_Text_Component_TextSource.GetWordNameForRegister

function Tkw_Text_Component_TextSource.GetString: AnsiString;
 {-}
begin
 Result := 'TextSource';
end;//Tkw_Text_Component_TextSource.GetString

class procedure Tkw_Text_Component_TextSource.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTextSource);
end;//Tkw_Text_Component_TextSource.RegisterInEngine

type
  TkwTextFormRemindersLine = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TTextForm.RemindersLine
[panel]Контрол RemindersLine формы TTextForm[panel]
*Тип результата:* TnscRemindersLine
*Пример:*
[code]
OBJECT VAR l_TnscRemindersLine
 aTextForm .TTextForm.RemindersLine >>> l_TnscRemindersLine
[code]  }
  private
  // private methods
   function RemindersLine(const aCtx: TtfwContext;
     aTextForm: TTextForm): TnscRemindersLine;
     {* Реализация слова скрипта .TTextForm.RemindersLine }
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
  end;//TkwTextFormRemindersLine

// start class TkwTextFormRemindersLine

function TkwTextFormRemindersLine.RemindersLine(const aCtx: TtfwContext;
  aTextForm: TTextForm): TnscRemindersLine;
 {-}
begin
 Result := aTextForm.RemindersLine;
end;//TkwTextFormRemindersLine.RemindersLine

procedure TkwTextFormRemindersLine.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTextForm : TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RemindersLine(aCtx, l_aTextForm)));
end;//TkwTextFormRemindersLine.DoDoIt

class function TkwTextFormRemindersLine.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TTextForm.RemindersLine';
end;//TkwTextFormRemindersLine.GetWordNameForRegister

procedure TkwTextFormRemindersLine.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству RemindersLine', aCtx);
end;//TkwTextFormRemindersLine.SetValuePrim

function TkwTextFormRemindersLine.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscRemindersLine);
end;//TkwTextFormRemindersLine.GetResultTypeInfo

function TkwTextFormRemindersLine.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwTextFormRemindersLine.GetAllParamsCount

function TkwTextFormRemindersLine.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormRemindersLine.ParamsTypes

type
  TkwTextFormWarnTimeMachineException = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TTextForm.WarnTimeMachineException
[panel]Контрол WarnTimeMachineException формы TTextForm[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnTimeMachineException >>> l_TnscReminder
[code]  }
  private
  // private methods
   function WarnTimeMachineException(const aCtx: TtfwContext;
     aTextForm: TTextForm): TnscReminder;
     {* Реализация слова скрипта .TTextForm.WarnTimeMachineException }
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
  end;//TkwTextFormWarnTimeMachineException

// start class TkwTextFormWarnTimeMachineException

function TkwTextFormWarnTimeMachineException.WarnTimeMachineException(const aCtx: TtfwContext;
  aTextForm: TTextForm): TnscReminder;
 {-}
begin
 Result := aTextForm.WarnTimeMachineException;
end;//TkwTextFormWarnTimeMachineException.WarnTimeMachineException

procedure TkwTextFormWarnTimeMachineException.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTextForm : TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((WarnTimeMachineException(aCtx, l_aTextForm)));
end;//TkwTextFormWarnTimeMachineException.DoDoIt

class function TkwTextFormWarnTimeMachineException.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TTextForm.WarnTimeMachineException';
end;//TkwTextFormWarnTimeMachineException.GetWordNameForRegister

procedure TkwTextFormWarnTimeMachineException.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству WarnTimeMachineException', aCtx);
end;//TkwTextFormWarnTimeMachineException.SetValuePrim

function TkwTextFormWarnTimeMachineException.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscReminder);
end;//TkwTextFormWarnTimeMachineException.GetResultTypeInfo

function TkwTextFormWarnTimeMachineException.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwTextFormWarnTimeMachineException.GetAllParamsCount

function TkwTextFormWarnTimeMachineException.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormWarnTimeMachineException.ParamsTypes

type
  TkwTextFormWarnIsAbolished = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TTextForm.WarnIsAbolished
[panel]Контрол WarnIsAbolished формы TTextForm[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnIsAbolished >>> l_TnscReminder
[code]  }
  private
  // private methods
   function WarnIsAbolished(const aCtx: TtfwContext;
     aTextForm: TTextForm): TnscReminder;
     {* Реализация слова скрипта .TTextForm.WarnIsAbolished }
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
  end;//TkwTextFormWarnIsAbolished

// start class TkwTextFormWarnIsAbolished

function TkwTextFormWarnIsAbolished.WarnIsAbolished(const aCtx: TtfwContext;
  aTextForm: TTextForm): TnscReminder;
 {-}
begin
 Result := aTextForm.WarnIsAbolished;
end;//TkwTextFormWarnIsAbolished.WarnIsAbolished

procedure TkwTextFormWarnIsAbolished.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTextForm : TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((WarnIsAbolished(aCtx, l_aTextForm)));
end;//TkwTextFormWarnIsAbolished.DoDoIt

class function TkwTextFormWarnIsAbolished.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TTextForm.WarnIsAbolished';
end;//TkwTextFormWarnIsAbolished.GetWordNameForRegister

procedure TkwTextFormWarnIsAbolished.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству WarnIsAbolished', aCtx);
end;//TkwTextFormWarnIsAbolished.SetValuePrim

function TkwTextFormWarnIsAbolished.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscReminder);
end;//TkwTextFormWarnIsAbolished.GetResultTypeInfo

function TkwTextFormWarnIsAbolished.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwTextFormWarnIsAbolished.GetAllParamsCount

function TkwTextFormWarnIsAbolished.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormWarnIsAbolished.ParamsTypes

type
  TkwTextFormWarnPreActive = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TTextForm.WarnPreActive
[panel]Контрол WarnPreActive формы TTextForm[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnPreActive >>> l_TnscReminder
[code]  }
  private
  // private methods
   function WarnPreActive(const aCtx: TtfwContext;
     aTextForm: TTextForm): TnscReminder;
     {* Реализация слова скрипта .TTextForm.WarnPreActive }
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
  end;//TkwTextFormWarnPreActive

// start class TkwTextFormWarnPreActive

function TkwTextFormWarnPreActive.WarnPreActive(const aCtx: TtfwContext;
  aTextForm: TTextForm): TnscReminder;
 {-}
begin
 Result := aTextForm.WarnPreActive;
end;//TkwTextFormWarnPreActive.WarnPreActive

procedure TkwTextFormWarnPreActive.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTextForm : TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((WarnPreActive(aCtx, l_aTextForm)));
end;//TkwTextFormWarnPreActive.DoDoIt

class function TkwTextFormWarnPreActive.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TTextForm.WarnPreActive';
end;//TkwTextFormWarnPreActive.GetWordNameForRegister

procedure TkwTextFormWarnPreActive.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству WarnPreActive', aCtx);
end;//TkwTextFormWarnPreActive.SetValuePrim

function TkwTextFormWarnPreActive.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscReminder);
end;//TkwTextFormWarnPreActive.GetResultTypeInfo

function TkwTextFormWarnPreActive.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwTextFormWarnPreActive.GetAllParamsCount

function TkwTextFormWarnPreActive.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormWarnPreActive.ParamsTypes

type
  TkwTextFormWarnTimeMachineWarning = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TTextForm.WarnTimeMachineWarning
[panel]Контрол WarnTimeMachineWarning формы TTextForm[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnTimeMachineWarning >>> l_TnscReminder
[code]  }
  private
  // private methods
   function WarnTimeMachineWarning(const aCtx: TtfwContext;
     aTextForm: TTextForm): TnscReminder;
     {* Реализация слова скрипта .TTextForm.WarnTimeMachineWarning }
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
  end;//TkwTextFormWarnTimeMachineWarning

// start class TkwTextFormWarnTimeMachineWarning

function TkwTextFormWarnTimeMachineWarning.WarnTimeMachineWarning(const aCtx: TtfwContext;
  aTextForm: TTextForm): TnscReminder;
 {-}
begin
 Result := aTextForm.WarnTimeMachineWarning;
end;//TkwTextFormWarnTimeMachineWarning.WarnTimeMachineWarning

procedure TkwTextFormWarnTimeMachineWarning.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTextForm : TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((WarnTimeMachineWarning(aCtx, l_aTextForm)));
end;//TkwTextFormWarnTimeMachineWarning.DoDoIt

class function TkwTextFormWarnTimeMachineWarning.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TTextForm.WarnTimeMachineWarning';
end;//TkwTextFormWarnTimeMachineWarning.GetWordNameForRegister

procedure TkwTextFormWarnTimeMachineWarning.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству WarnTimeMachineWarning', aCtx);
end;//TkwTextFormWarnTimeMachineWarning.SetValuePrim

function TkwTextFormWarnTimeMachineWarning.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscReminder);
end;//TkwTextFormWarnTimeMachineWarning.GetResultTypeInfo

function TkwTextFormWarnTimeMachineWarning.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwTextFormWarnTimeMachineWarning.GetAllParamsCount

function TkwTextFormWarnTimeMachineWarning.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormWarnTimeMachineWarning.ParamsTypes

type
  TkwTextFormWarnOnControl = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TTextForm.WarnOnControl
[panel]Контрол WarnOnControl формы TTextForm[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnOnControl >>> l_TnscReminder
[code]  }
  private
  // private methods
   function WarnOnControl(const aCtx: TtfwContext;
     aTextForm: TTextForm): TnscReminder;
     {* Реализация слова скрипта .TTextForm.WarnOnControl }
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
  end;//TkwTextFormWarnOnControl

// start class TkwTextFormWarnOnControl

function TkwTextFormWarnOnControl.WarnOnControl(const aCtx: TtfwContext;
  aTextForm: TTextForm): TnscReminder;
 {-}
begin
 Result := aTextForm.WarnOnControl;
end;//TkwTextFormWarnOnControl.WarnOnControl

procedure TkwTextFormWarnOnControl.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTextForm : TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((WarnOnControl(aCtx, l_aTextForm)));
end;//TkwTextFormWarnOnControl.DoDoIt

class function TkwTextFormWarnOnControl.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TTextForm.WarnOnControl';
end;//TkwTextFormWarnOnControl.GetWordNameForRegister

procedure TkwTextFormWarnOnControl.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству WarnOnControl', aCtx);
end;//TkwTextFormWarnOnControl.SetValuePrim

function TkwTextFormWarnOnControl.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscReminder);
end;//TkwTextFormWarnOnControl.GetResultTypeInfo

function TkwTextFormWarnOnControl.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwTextFormWarnOnControl.GetAllParamsCount

function TkwTextFormWarnOnControl.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormWarnOnControl.ParamsTypes

type
  TkwTextFormWarnJuror = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TTextForm.WarnJuror
[panel]Контрол WarnJuror формы TTextForm[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnJuror >>> l_TnscReminder
[code]  }
  private
  // private methods
   function WarnJuror(const aCtx: TtfwContext;
     aTextForm: TTextForm): TnscReminder;
     {* Реализация слова скрипта .TTextForm.WarnJuror }
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
  end;//TkwTextFormWarnJuror

// start class TkwTextFormWarnJuror

function TkwTextFormWarnJuror.WarnJuror(const aCtx: TtfwContext;
  aTextForm: TTextForm): TnscReminder;
 {-}
begin
 Result := aTextForm.WarnJuror;
end;//TkwTextFormWarnJuror.WarnJuror

procedure TkwTextFormWarnJuror.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTextForm : TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((WarnJuror(aCtx, l_aTextForm)));
end;//TkwTextFormWarnJuror.DoDoIt

class function TkwTextFormWarnJuror.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TTextForm.WarnJuror';
end;//TkwTextFormWarnJuror.GetWordNameForRegister

procedure TkwTextFormWarnJuror.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству WarnJuror', aCtx);
end;//TkwTextFormWarnJuror.SetValuePrim

function TkwTextFormWarnJuror.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscReminder);
end;//TkwTextFormWarnJuror.GetResultTypeInfo

function TkwTextFormWarnJuror.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwTextFormWarnJuror.GetAllParamsCount

function TkwTextFormWarnJuror.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormWarnJuror.ParamsTypes

type
  TkwTextFormWarnRedaction = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TTextForm.WarnRedaction
[panel]Контрол WarnRedaction формы TTextForm[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnRedaction >>> l_TnscReminder
[code]  }
  private
  // private methods
   function WarnRedaction(const aCtx: TtfwContext;
     aTextForm: TTextForm): TnscReminder;
     {* Реализация слова скрипта .TTextForm.WarnRedaction }
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
  end;//TkwTextFormWarnRedaction

// start class TkwTextFormWarnRedaction

function TkwTextFormWarnRedaction.WarnRedaction(const aCtx: TtfwContext;
  aTextForm: TTextForm): TnscReminder;
 {-}
begin
 Result := aTextForm.WarnRedaction;
end;//TkwTextFormWarnRedaction.WarnRedaction

procedure TkwTextFormWarnRedaction.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTextForm : TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((WarnRedaction(aCtx, l_aTextForm)));
end;//TkwTextFormWarnRedaction.DoDoIt

class function TkwTextFormWarnRedaction.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TTextForm.WarnRedaction';
end;//TkwTextFormWarnRedaction.GetWordNameForRegister

procedure TkwTextFormWarnRedaction.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству WarnRedaction', aCtx);
end;//TkwTextFormWarnRedaction.SetValuePrim

function TkwTextFormWarnRedaction.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscReminder);
end;//TkwTextFormWarnRedaction.GetResultTypeInfo

function TkwTextFormWarnRedaction.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwTextFormWarnRedaction.GetAllParamsCount

function TkwTextFormWarnRedaction.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormWarnRedaction.ParamsTypes

type
  TkwTextFormWarnInactualDocument = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TTextForm.WarnInactualDocument
[panel]Контрол WarnInactualDocument формы TTextForm[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnInactualDocument >>> l_TnscReminder
[code]  }
  private
  // private methods
   function WarnInactualDocument(const aCtx: TtfwContext;
     aTextForm: TTextForm): TnscReminder;
     {* Реализация слова скрипта .TTextForm.WarnInactualDocument }
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
  end;//TkwTextFormWarnInactualDocument

// start class TkwTextFormWarnInactualDocument

function TkwTextFormWarnInactualDocument.WarnInactualDocument(const aCtx: TtfwContext;
  aTextForm: TTextForm): TnscReminder;
 {-}
begin
 Result := aTextForm.WarnInactualDocument;
end;//TkwTextFormWarnInactualDocument.WarnInactualDocument

procedure TkwTextFormWarnInactualDocument.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTextForm : TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((WarnInactualDocument(aCtx, l_aTextForm)));
end;//TkwTextFormWarnInactualDocument.DoDoIt

class function TkwTextFormWarnInactualDocument.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TTextForm.WarnInactualDocument';
end;//TkwTextFormWarnInactualDocument.GetWordNameForRegister

procedure TkwTextFormWarnInactualDocument.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству WarnInactualDocument', aCtx);
end;//TkwTextFormWarnInactualDocument.SetValuePrim

function TkwTextFormWarnInactualDocument.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscReminder);
end;//TkwTextFormWarnInactualDocument.GetResultTypeInfo

function TkwTextFormWarnInactualDocument.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwTextFormWarnInactualDocument.GetAllParamsCount

function TkwTextFormWarnInactualDocument.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormWarnInactualDocument.ParamsTypes

type
  TkwTextFormWarnTimeMachineOn = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TTextForm.WarnTimeMachineOn
[panel]Контрол WarnTimeMachineOn формы TTextForm[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aTextForm .TTextForm.WarnTimeMachineOn >>> l_TnscReminder
[code]  }
  private
  // private methods
   function WarnTimeMachineOn(const aCtx: TtfwContext;
     aTextForm: TTextForm): TnscReminder;
     {* Реализация слова скрипта .TTextForm.WarnTimeMachineOn }
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
  end;//TkwTextFormWarnTimeMachineOn

// start class TkwTextFormWarnTimeMachineOn

function TkwTextFormWarnTimeMachineOn.WarnTimeMachineOn(const aCtx: TtfwContext;
  aTextForm: TTextForm): TnscReminder;
 {-}
begin
 Result := aTextForm.WarnTimeMachineOn;
end;//TkwTextFormWarnTimeMachineOn.WarnTimeMachineOn

procedure TkwTextFormWarnTimeMachineOn.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTextForm : TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((WarnTimeMachineOn(aCtx, l_aTextForm)));
end;//TkwTextFormWarnTimeMachineOn.DoDoIt

class function TkwTextFormWarnTimeMachineOn.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TTextForm.WarnTimeMachineOn';
end;//TkwTextFormWarnTimeMachineOn.GetWordNameForRegister

procedure TkwTextFormWarnTimeMachineOn.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству WarnTimeMachineOn', aCtx);
end;//TkwTextFormWarnTimeMachineOn.SetValuePrim

function TkwTextFormWarnTimeMachineOn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscReminder);
end;//TkwTextFormWarnTimeMachineOn.GetResultTypeInfo

function TkwTextFormWarnTimeMachineOn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwTextFormWarnTimeMachineOn.GetAllParamsCount

function TkwTextFormWarnTimeMachineOn.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormWarnTimeMachineOn.ParamsTypes

type
  TkwTextFormSubPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TTextForm.SubPanel
[panel]Контрол SubPanel формы TTextForm[panel]
*Тип результата:* TeeSubPanel
*Пример:*
[code]
OBJECT VAR l_TeeSubPanel
 aTextForm .TTextForm.SubPanel >>> l_TeeSubPanel
[code]  }
  private
  // private methods
   function SubPanel(const aCtx: TtfwContext;
     aTextForm: TTextForm): TeeSubPanel;
     {* Реализация слова скрипта .TTextForm.SubPanel }
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
  end;//TkwTextFormSubPanel

// start class TkwTextFormSubPanel

function TkwTextFormSubPanel.SubPanel(const aCtx: TtfwContext;
  aTextForm: TTextForm): TeeSubPanel;
 {-}
begin
 Result := aTextForm.SubPanel;
end;//TkwTextFormSubPanel.SubPanel

procedure TkwTextFormSubPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTextForm : TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((SubPanel(aCtx, l_aTextForm)));
end;//TkwTextFormSubPanel.DoDoIt

class function TkwTextFormSubPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TTextForm.SubPanel';
end;//TkwTextFormSubPanel.GetWordNameForRegister

procedure TkwTextFormSubPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству SubPanel', aCtx);
end;//TkwTextFormSubPanel.SetValuePrim

function TkwTextFormSubPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TeeSubPanel);
end;//TkwTextFormSubPanel.GetResultTypeInfo

function TkwTextFormSubPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwTextFormSubPanel.GetAllParamsCount

function TkwTextFormSubPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormSubPanel.ParamsTypes

type
  TkwTextFormHScroll = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TTextForm.HScroll
[panel]Контрол HScroll формы TTextForm[panel]
*Тип результата:* TvtScrollBar
*Пример:*
[code]
OBJECT VAR l_TvtScrollBar
 aTextForm .TTextForm.HScroll >>> l_TvtScrollBar
[code]  }
  private
  // private methods
   function HScroll(const aCtx: TtfwContext;
     aTextForm: TTextForm): TvtScrollBar;
     {* Реализация слова скрипта .TTextForm.HScroll }
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
  end;//TkwTextFormHScroll

// start class TkwTextFormHScroll

function TkwTextFormHScroll.HScroll(const aCtx: TtfwContext;
  aTextForm: TTextForm): TvtScrollBar;
 {-}
begin
 Result := aTextForm.HScroll;
end;//TkwTextFormHScroll.HScroll

procedure TkwTextFormHScroll.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTextForm : TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((HScroll(aCtx, l_aTextForm)));
end;//TkwTextFormHScroll.DoDoIt

class function TkwTextFormHScroll.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TTextForm.HScroll';
end;//TkwTextFormHScroll.GetWordNameForRegister

procedure TkwTextFormHScroll.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству HScroll', aCtx);
end;//TkwTextFormHScroll.SetValuePrim

function TkwTextFormHScroll.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtScrollBar);
end;//TkwTextFormHScroll.GetResultTypeInfo

function TkwTextFormHScroll.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwTextFormHScroll.GetAllParamsCount

function TkwTextFormHScroll.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormHScroll.ParamsTypes

type
  TkwTextFormText = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TTextForm.Text
[panel]Контрол Text формы TTextForm[panel]
*Тип результата:* TnscEditor
*Пример:*
[code]
OBJECT VAR l_TnscEditor
 aTextForm .TTextForm.Text >>> l_TnscEditor
[code]  }
  private
  // private methods
   function Text(const aCtx: TtfwContext;
     aTextForm: TTextForm): TnscEditor;
     {* Реализация слова скрипта .TTextForm.Text }
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
  end;//TkwTextFormText

// start class TkwTextFormText

function TkwTextFormText.Text(const aCtx: TtfwContext;
  aTextForm: TTextForm): TnscEditor;
 {-}
begin
 Result := aTextForm.Text;
end;//TkwTextFormText.Text

procedure TkwTextFormText.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTextForm : TTextForm;
begin
 try
  l_aTextForm := TTextForm(aCtx.rEngine.PopObjAs(TTextForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTextForm: TTextForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Text(aCtx, l_aTextForm)));
end;//TkwTextFormText.DoDoIt

class function TkwTextFormText.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TTextForm.Text';
end;//TkwTextFormText.GetWordNameForRegister

procedure TkwTextFormText.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Text', aCtx);
end;//TkwTextFormText.SetValuePrim

function TkwTextFormText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEditor);
end;//TkwTextFormText.GetResultTypeInfo

function TkwTextFormText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwTextFormText.GetAllParamsCount

function TkwTextFormText.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTextForm)]);
end;//TkwTextFormText.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_Text
 Tkw_Form_Text.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_RemindersLine
 Tkw_Text_Control_RemindersLine.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_RemindersLine_Push
 Tkw_Text_Control_RemindersLine_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_WarnTimeMachineException
 Tkw_Text_Control_WarnTimeMachineException.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_WarnTimeMachineException_Push
 Tkw_Text_Control_WarnTimeMachineException_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_WarnIsAbolished
 Tkw_Text_Control_WarnIsAbolished.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_WarnIsAbolished_Push
 Tkw_Text_Control_WarnIsAbolished_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_WarnPreActive
 Tkw_Text_Control_WarnPreActive.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_WarnPreActive_Push
 Tkw_Text_Control_WarnPreActive_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_WarnTimeMachineWarning
 Tkw_Text_Control_WarnTimeMachineWarning.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_WarnTimeMachineWarning_Push
 Tkw_Text_Control_WarnTimeMachineWarning_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_WarnOnControl
 Tkw_Text_Control_WarnOnControl.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_WarnOnControl_Push
 Tkw_Text_Control_WarnOnControl_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_WarnJuror
 Tkw_Text_Control_WarnJuror.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_WarnJuror_Push
 Tkw_Text_Control_WarnJuror_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_WarnRedaction
 Tkw_Text_Control_WarnRedaction.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_WarnRedaction_Push
 Tkw_Text_Control_WarnRedaction_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_WarnInactualDocument
 Tkw_Text_Control_WarnInactualDocument.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_WarnInactualDocument_Push
 Tkw_Text_Control_WarnInactualDocument_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_WarnTimeMachineOn
 Tkw_Text_Control_WarnTimeMachineOn.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_WarnTimeMachineOn_Push
 Tkw_Text_Control_WarnTimeMachineOn_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_SubPanel
 Tkw_Text_Control_SubPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_SubPanel_Push
 Tkw_Text_Control_SubPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_HScroll
 Tkw_Text_Control_HScroll.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_HScroll_Push
 Tkw_Text_Control_HScroll_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_Text
 Tkw_Text_Control_Text.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Control_Text_Push
 Tkw_Text_Control_Text_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Text_Component_TextSource
 Tkw_Text_Component_TextSource.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация TextForm_RemindersLine
 TkwTextFormRemindersLine.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация TextForm_WarnTimeMachineException
 TkwTextFormWarnTimeMachineException.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация TextForm_WarnIsAbolished
 TkwTextFormWarnIsAbolished.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация TextForm_WarnPreActive
 TkwTextFormWarnPreActive.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация TextForm_WarnTimeMachineWarning
 TkwTextFormWarnTimeMachineWarning.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация TextForm_WarnOnControl
 TkwTextFormWarnOnControl.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация TextForm_WarnJuror
 TkwTextFormWarnJuror.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация TextForm_WarnRedaction
 TkwTextFormWarnRedaction.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация TextForm_WarnInactualDocument
 TkwTextFormWarnInactualDocument.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация TextForm_WarnTimeMachineOn
 TkwTextFormWarnTimeMachineOn.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация TextForm_SubPanel
 TkwTextFormSubPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация TextForm_HScroll
 TkwTextFormHScroll.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация TextForm_Text
 TkwTextFormText.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа Text
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTextForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscRemindersLine
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscRemindersLine));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscReminder
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscReminder));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TeeSubPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeSubPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtScrollBar
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtScrollBar));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscEditor
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.
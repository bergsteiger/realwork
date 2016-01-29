unit TurnOffTimeMachineKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/TurnOffTimeMachineKeywordsPack.pas"
// Начат: 24.08.2009 20:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Core::Common::View::Common::PrimF1Common::TurnOffTimeMachineKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы TurnOffTimeMachine
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
  TurnOffTimeMachine_Form,
  vtDblClickDateEdit,
  vtLabel,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  vtButton,
  vtRadioButton,
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
  Tkw_Form_TurnOffTimeMachine = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы TurnOffTimeMachine
----
*Пример использования*:
[code]
'aControl' форма::TurnOffTimeMachine TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_TurnOffTimeMachine

// start class Tkw_Form_TurnOffTimeMachine

class function Tkw_Form_TurnOffTimeMachine.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::TurnOffTimeMachine';
end;//Tkw_Form_TurnOffTimeMachine.GetWordNameForRegister

function Tkw_Form_TurnOffTimeMachine.GetString: AnsiString;
 {-}
begin
 Result := 'en_TurnOffTimeMachine';
end;//Tkw_Form_TurnOffTimeMachine.GetString

type
  Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола rb_totmChangeDate
----
*Пример использования*:
[code]
контрол::rb_totmChangeDate TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate

// start class Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate

class function Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::rb_totmChangeDate';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.GetString: AnsiString;
 {-}
begin
 Result := 'rb_totmChangeDate';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.GetString

class procedure Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.RegisterInEngine

type
  Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола rb_totmChangeDate
----
*Пример использования*:
[code]
контрол::rb_totmChangeDate:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push

// start class Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push

procedure Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('rb_totmChangeDate');
 inherited;
end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::rb_totmChangeDate:push';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push.GetWordNameForRegister

type
  Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола rb_totmStayInCurrentRedaction
----
*Пример использования*:
[code]
контрол::rb_totmStayInCurrentRedaction TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction

// start class Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction

class function Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::rb_totmStayInCurrentRedaction';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.GetString: AnsiString;
 {-}
begin
 Result := 'rb_totmStayInCurrentRedaction';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.GetString

class procedure Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.RegisterInEngine

type
  Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола rb_totmStayInCurrentRedaction
----
*Пример использования*:
[code]
контрол::rb_totmStayInCurrentRedaction:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push

// start class Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push

procedure Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('rb_totmStayInCurrentRedaction');
 inherited;
end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::rb_totmStayInCurrentRedaction:push';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push.GetWordNameForRegister

type
  Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола rb_totmGotoActualRedaction
----
*Пример использования*:
[code]
контрол::rb_totmGotoActualRedaction TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction

// start class Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction

class function Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::rb_totmGotoActualRedaction';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.GetString: AnsiString;
 {-}
begin
 Result := 'rb_totmGotoActualRedaction';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.GetString

class procedure Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.RegisterInEngine

type
  Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола rb_totmGotoActualRedaction
----
*Пример использования*:
[code]
контрол::rb_totmGotoActualRedaction:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push

// start class Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push

procedure Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('rb_totmGotoActualRedaction');
 inherited;
end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::rb_totmGotoActualRedaction:push';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push.GetWordNameForRegister

type
  Tkw_TurnOffTimeMachine_Control_deChangeDate = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола deChangeDate
----
*Пример использования*:
[code]
контрол::deChangeDate TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_TurnOffTimeMachine_Control_deChangeDate

// start class Tkw_TurnOffTimeMachine_Control_deChangeDate

class function Tkw_TurnOffTimeMachine_Control_deChangeDate.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::deChangeDate';
end;//Tkw_TurnOffTimeMachine_Control_deChangeDate.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_deChangeDate.GetString: AnsiString;
 {-}
begin
 Result := 'deChangeDate';
end;//Tkw_TurnOffTimeMachine_Control_deChangeDate.GetString

class procedure Tkw_TurnOffTimeMachine_Control_deChangeDate.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtDblClickDateEdit);
end;//Tkw_TurnOffTimeMachine_Control_deChangeDate.RegisterInEngine

type
  Tkw_TurnOffTimeMachine_Control_deChangeDate_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола deChangeDate
----
*Пример использования*:
[code]
контрол::deChangeDate:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_TurnOffTimeMachine_Control_deChangeDate_Push

// start class Tkw_TurnOffTimeMachine_Control_deChangeDate_Push

procedure Tkw_TurnOffTimeMachine_Control_deChangeDate_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('deChangeDate');
 inherited;
end;//Tkw_TurnOffTimeMachine_Control_deChangeDate_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_deChangeDate_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::deChangeDate:push';
end;//Tkw_TurnOffTimeMachine_Control_deChangeDate_Push.GetWordNameForRegister

type
  Tkw_TurnOffTimeMachine_Control_pbDialogIcon = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pbDialogIcon
----
*Пример использования*:
[code]
контрол::pbDialogIcon TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon

// start class Tkw_TurnOffTimeMachine_Control_pbDialogIcon

class function Tkw_TurnOffTimeMachine_Control_pbDialogIcon.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pbDialogIcon';
end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_pbDialogIcon.GetString: AnsiString;
 {-}
begin
 Result := 'pbDialogIcon';
end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon.GetString

class procedure Tkw_TurnOffTimeMachine_Control_pbDialogIcon.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon.RegisterInEngine

type
  Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pbDialogIcon
----
*Пример использования*:
[code]
контрол::pbDialogIcon:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push

// start class Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push

procedure Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pbDialogIcon');
 inherited;
end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pbDialogIcon:push';
end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push.GetWordNameForRegister

type
  Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола lblTurnOnTimeMachineInfo
----
*Пример использования*:
[code]
контрол::lblTurnOnTimeMachineInfo TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo

// start class Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo

class function Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblTurnOnTimeMachineInfo';
end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.GetString: AnsiString;
 {-}
begin
 Result := 'lblTurnOnTimeMachineInfo';
end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.GetString

class procedure Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.RegisterInEngine

type
  Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола lblTurnOnTimeMachineInfo
----
*Пример использования*:
[code]
контрол::lblTurnOnTimeMachineInfo:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push

// start class Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push

procedure Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lblTurnOnTimeMachineInfo');
 inherited;
end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblTurnOnTimeMachineInfo:push';
end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.GetWordNameForRegister

type
  Tkw_TurnOffTimeMachine_Control_btnOk = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_TurnOffTimeMachine_Control_btnOk

// start class Tkw_TurnOffTimeMachine_Control_btnOk

class function Tkw_TurnOffTimeMachine_Control_btnOk.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::btnOk';
end;//Tkw_TurnOffTimeMachine_Control_btnOk.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_btnOk.GetString: AnsiString;
 {-}
begin
 Result := 'btnOk';
end;//Tkw_TurnOffTimeMachine_Control_btnOk.GetString

class procedure Tkw_TurnOffTimeMachine_Control_btnOk.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
end;//Tkw_TurnOffTimeMachine_Control_btnOk.RegisterInEngine

type
  Tkw_TurnOffTimeMachine_Control_btnOk_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_TurnOffTimeMachine_Control_btnOk_Push

// start class Tkw_TurnOffTimeMachine_Control_btnOk_Push

procedure Tkw_TurnOffTimeMachine_Control_btnOk_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('btnOk');
 inherited;
end;//Tkw_TurnOffTimeMachine_Control_btnOk_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_btnOk_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::btnOk:push';
end;//Tkw_TurnOffTimeMachine_Control_btnOk_Push.GetWordNameForRegister

type
  Tkw_TurnOffTimeMachine_Control_btnCancel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола btnCancel
----
*Пример использования*:
[code]
контрол::btnCancel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_TurnOffTimeMachine_Control_btnCancel

// start class Tkw_TurnOffTimeMachine_Control_btnCancel

class function Tkw_TurnOffTimeMachine_Control_btnCancel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::btnCancel';
end;//Tkw_TurnOffTimeMachine_Control_btnCancel.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_btnCancel.GetString: AnsiString;
 {-}
begin
 Result := 'btnCancel';
end;//Tkw_TurnOffTimeMachine_Control_btnCancel.GetString

class procedure Tkw_TurnOffTimeMachine_Control_btnCancel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
end;//Tkw_TurnOffTimeMachine_Control_btnCancel.RegisterInEngine

type
  Tkw_TurnOffTimeMachine_Control_btnCancel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола btnCancel
----
*Пример использования*:
[code]
контрол::btnCancel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_TurnOffTimeMachine_Control_btnCancel_Push

// start class Tkw_TurnOffTimeMachine_Control_btnCancel_Push

procedure Tkw_TurnOffTimeMachine_Control_btnCancel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('btnCancel');
 inherited;
end;//Tkw_TurnOffTimeMachine_Control_btnCancel_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_btnCancel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::btnCancel:push';
end;//Tkw_TurnOffTimeMachine_Control_btnCancel_Push.GetWordNameForRegister

type
  TkwEnTurnOffTimeMachineRbTotmChangeDate = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_TurnOffTimeMachine.rb_totmChangeDate
[panel]Контрол rb_totmChangeDate формы Ten_TurnOffTimeMachine[panel]
*Тип результата:* TvtRadioButton
*Пример:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_TurnOffTimeMachine .Ten_TurnOffTimeMachine.rb_totmChangeDate >>> l_TvtRadioButton
[code]  }
  private
  // private methods
   function RbTotmChangeDate(const aCtx: TtfwContext;
     aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtRadioButton;
     {* Реализация слова скрипта .Ten_TurnOffTimeMachine.rb_totmChangeDate }
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
  end;//TkwEnTurnOffTimeMachineRbTotmChangeDate

// start class TkwEnTurnOffTimeMachineRbTotmChangeDate

function TkwEnTurnOffTimeMachineRbTotmChangeDate.RbTotmChangeDate(const aCtx: TtfwContext;
  aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtRadioButton;
 {-}
begin
 Result := aen_TurnOffTimeMachine.rb_totmChangeDate;
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.RbTotmChangeDate

procedure TkwEnTurnOffTimeMachineRbTotmChangeDate.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_TurnOffTimeMachine : Ten_TurnOffTimeMachine;
begin
 try
  l_aen_TurnOffTimeMachine := Ten_TurnOffTimeMachine(aCtx.rEngine.PopObjAs(Ten_TurnOffTimeMachine));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RbTotmChangeDate(aCtx, l_aen_TurnOffTimeMachine)));
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.DoDoIt

class function TkwEnTurnOffTimeMachineRbTotmChangeDate.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_TurnOffTimeMachine.rb_totmChangeDate';
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.GetWordNameForRegister

procedure TkwEnTurnOffTimeMachineRbTotmChangeDate.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству rb_totmChangeDate', aCtx);
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.SetValuePrim

function TkwEnTurnOffTimeMachineRbTotmChangeDate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.GetResultTypeInfo

function TkwEnTurnOffTimeMachineRbTotmChangeDate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.GetAllParamsCount

function TkwEnTurnOffTimeMachineRbTotmChangeDate.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOffTimeMachine)]);
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.ParamsTypes

type
  TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_TurnOffTimeMachine.rb_totmStayInCurrentRedaction
[panel]Контрол rb_totmStayInCurrentRedaction формы Ten_TurnOffTimeMachine[panel]
*Тип результата:* TvtRadioButton
*Пример:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_TurnOffTimeMachine .Ten_TurnOffTimeMachine.rb_totmStayInCurrentRedaction >>> l_TvtRadioButton
[code]  }
  private
  // private methods
   function RbTotmStayInCurrentRedaction(const aCtx: TtfwContext;
     aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtRadioButton;
     {* Реализация слова скрипта .Ten_TurnOffTimeMachine.rb_totmStayInCurrentRedaction }
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
  end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction

// start class TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction

function TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.RbTotmStayInCurrentRedaction(const aCtx: TtfwContext;
  aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtRadioButton;
 {-}
begin
 Result := aen_TurnOffTimeMachine.rb_totmStayInCurrentRedaction;
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.RbTotmStayInCurrentRedaction

procedure TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_TurnOffTimeMachine : Ten_TurnOffTimeMachine;
begin
 try
  l_aen_TurnOffTimeMachine := Ten_TurnOffTimeMachine(aCtx.rEngine.PopObjAs(Ten_TurnOffTimeMachine));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RbTotmStayInCurrentRedaction(aCtx, l_aen_TurnOffTimeMachine)));
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.DoDoIt

class function TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_TurnOffTimeMachine.rb_totmStayInCurrentRedaction';
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.GetWordNameForRegister

procedure TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству rb_totmStayInCurrentRedaction', aCtx);
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.SetValuePrim

function TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.GetResultTypeInfo

function TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.GetAllParamsCount

function TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOffTimeMachine)]);
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.ParamsTypes

type
  TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_TurnOffTimeMachine.rb_totmGotoActualRedaction
[panel]Контрол rb_totmGotoActualRedaction формы Ten_TurnOffTimeMachine[panel]
*Тип результата:* TvtRadioButton
*Пример:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_TurnOffTimeMachine .Ten_TurnOffTimeMachine.rb_totmGotoActualRedaction >>> l_TvtRadioButton
[code]  }
  private
  // private methods
   function RbTotmGotoActualRedaction(const aCtx: TtfwContext;
     aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtRadioButton;
     {* Реализация слова скрипта .Ten_TurnOffTimeMachine.rb_totmGotoActualRedaction }
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
  end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction

// start class TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction

function TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.RbTotmGotoActualRedaction(const aCtx: TtfwContext;
  aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtRadioButton;
 {-}
begin
 Result := aen_TurnOffTimeMachine.rb_totmGotoActualRedaction;
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.RbTotmGotoActualRedaction

procedure TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_TurnOffTimeMachine : Ten_TurnOffTimeMachine;
begin
 try
  l_aen_TurnOffTimeMachine := Ten_TurnOffTimeMachine(aCtx.rEngine.PopObjAs(Ten_TurnOffTimeMachine));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RbTotmGotoActualRedaction(aCtx, l_aen_TurnOffTimeMachine)));
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.DoDoIt

class function TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_TurnOffTimeMachine.rb_totmGotoActualRedaction';
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.GetWordNameForRegister

procedure TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству rb_totmGotoActualRedaction', aCtx);
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.SetValuePrim

function TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.GetResultTypeInfo

function TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.GetAllParamsCount

function TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOffTimeMachine)]);
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.ParamsTypes

type
  TkwEnTurnOffTimeMachineDeChangeDate = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_TurnOffTimeMachine.deChangeDate
[panel]Контрол deChangeDate формы Ten_TurnOffTimeMachine[panel]
*Тип результата:* TvtDblClickDateEdit
*Пример:*
[code]
OBJECT VAR l_TvtDblClickDateEdit
 aen_TurnOffTimeMachine .Ten_TurnOffTimeMachine.deChangeDate >>> l_TvtDblClickDateEdit
[code]  }
  private
  // private methods
   function DeChangeDate(const aCtx: TtfwContext;
     aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtDblClickDateEdit;
     {* Реализация слова скрипта .Ten_TurnOffTimeMachine.deChangeDate }
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
  end;//TkwEnTurnOffTimeMachineDeChangeDate

// start class TkwEnTurnOffTimeMachineDeChangeDate

function TkwEnTurnOffTimeMachineDeChangeDate.DeChangeDate(const aCtx: TtfwContext;
  aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtDblClickDateEdit;
 {-}
begin
 Result := aen_TurnOffTimeMachine.deChangeDate;
end;//TkwEnTurnOffTimeMachineDeChangeDate.DeChangeDate

procedure TkwEnTurnOffTimeMachineDeChangeDate.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_TurnOffTimeMachine : Ten_TurnOffTimeMachine;
begin
 try
  l_aen_TurnOffTimeMachine := Ten_TurnOffTimeMachine(aCtx.rEngine.PopObjAs(Ten_TurnOffTimeMachine));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((DeChangeDate(aCtx, l_aen_TurnOffTimeMachine)));
end;//TkwEnTurnOffTimeMachineDeChangeDate.DoDoIt

class function TkwEnTurnOffTimeMachineDeChangeDate.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_TurnOffTimeMachine.deChangeDate';
end;//TkwEnTurnOffTimeMachineDeChangeDate.GetWordNameForRegister

procedure TkwEnTurnOffTimeMachineDeChangeDate.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству deChangeDate', aCtx);
end;//TkwEnTurnOffTimeMachineDeChangeDate.SetValuePrim

function TkwEnTurnOffTimeMachineDeChangeDate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtDblClickDateEdit);
end;//TkwEnTurnOffTimeMachineDeChangeDate.GetResultTypeInfo

function TkwEnTurnOffTimeMachineDeChangeDate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnTurnOffTimeMachineDeChangeDate.GetAllParamsCount

function TkwEnTurnOffTimeMachineDeChangeDate.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOffTimeMachine)]);
end;//TkwEnTurnOffTimeMachineDeChangeDate.ParamsTypes

type
  TkwEnTurnOffTimeMachinePbDialogIcon = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_TurnOffTimeMachine.pbDialogIcon
[panel]Контрол pbDialogIcon формы Ten_TurnOffTimeMachine[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aen_TurnOffTimeMachine .Ten_TurnOffTimeMachine.pbDialogIcon >>> l_TPaintBox
[code]  }
  private
  // private methods
   function PbDialogIcon(const aCtx: TtfwContext;
     aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TPaintBox;
     {* Реализация слова скрипта .Ten_TurnOffTimeMachine.pbDialogIcon }
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
  end;//TkwEnTurnOffTimeMachinePbDialogIcon

// start class TkwEnTurnOffTimeMachinePbDialogIcon

function TkwEnTurnOffTimeMachinePbDialogIcon.PbDialogIcon(const aCtx: TtfwContext;
  aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TPaintBox;
 {-}
begin
 Result := aen_TurnOffTimeMachine.pbDialogIcon;
end;//TkwEnTurnOffTimeMachinePbDialogIcon.PbDialogIcon

procedure TkwEnTurnOffTimeMachinePbDialogIcon.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_TurnOffTimeMachine : Ten_TurnOffTimeMachine;
begin
 try
  l_aen_TurnOffTimeMachine := Ten_TurnOffTimeMachine(aCtx.rEngine.PopObjAs(Ten_TurnOffTimeMachine));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PbDialogIcon(aCtx, l_aen_TurnOffTimeMachine)));
end;//TkwEnTurnOffTimeMachinePbDialogIcon.DoDoIt

class function TkwEnTurnOffTimeMachinePbDialogIcon.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_TurnOffTimeMachine.pbDialogIcon';
end;//TkwEnTurnOffTimeMachinePbDialogIcon.GetWordNameForRegister

procedure TkwEnTurnOffTimeMachinePbDialogIcon.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pbDialogIcon', aCtx);
end;//TkwEnTurnOffTimeMachinePbDialogIcon.SetValuePrim

function TkwEnTurnOffTimeMachinePbDialogIcon.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEnTurnOffTimeMachinePbDialogIcon.GetResultTypeInfo

function TkwEnTurnOffTimeMachinePbDialogIcon.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnTurnOffTimeMachinePbDialogIcon.GetAllParamsCount

function TkwEnTurnOffTimeMachinePbDialogIcon.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOffTimeMachine)]);
end;//TkwEnTurnOffTimeMachinePbDialogIcon.ParamsTypes

type
  TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_TurnOffTimeMachine.lblTurnOnTimeMachineInfo
[panel]Контрол lblTurnOnTimeMachineInfo формы Ten_TurnOffTimeMachine[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aen_TurnOffTimeMachine .Ten_TurnOffTimeMachine.lblTurnOnTimeMachineInfo >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LblTurnOnTimeMachineInfo(const aCtx: TtfwContext;
     aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtLabel;
     {* Реализация слова скрипта .Ten_TurnOffTimeMachine.lblTurnOnTimeMachineInfo }
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
  end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo

// start class TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo

function TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.LblTurnOnTimeMachineInfo(const aCtx: TtfwContext;
  aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtLabel;
 {-}
begin
 Result := aen_TurnOffTimeMachine.lblTurnOnTimeMachineInfo;
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.LblTurnOnTimeMachineInfo

procedure TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_TurnOffTimeMachine : Ten_TurnOffTimeMachine;
begin
 try
  l_aen_TurnOffTimeMachine := Ten_TurnOffTimeMachine(aCtx.rEngine.PopObjAs(Ten_TurnOffTimeMachine));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LblTurnOnTimeMachineInfo(aCtx, l_aen_TurnOffTimeMachine)));
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.DoDoIt

class function TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_TurnOffTimeMachine.lblTurnOnTimeMachineInfo';
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.GetWordNameForRegister

procedure TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblTurnOnTimeMachineInfo', aCtx);
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.SetValuePrim

function TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.GetResultTypeInfo

function TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.GetAllParamsCount

function TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOffTimeMachine)]);
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.ParamsTypes

type
  TkwEnTurnOffTimeMachineBtnOk = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_TurnOffTimeMachine.btnOk
[panel]Контрол btnOk формы Ten_TurnOffTimeMachine[panel]
*Тип результата:* TvtButton
*Пример:*
[code]
OBJECT VAR l_TvtButton
 aen_TurnOffTimeMachine .Ten_TurnOffTimeMachine.btnOk >>> l_TvtButton
[code]  }
  private
  // private methods
   function BtnOk(const aCtx: TtfwContext;
     aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtButton;
     {* Реализация слова скрипта .Ten_TurnOffTimeMachine.btnOk }
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
  end;//TkwEnTurnOffTimeMachineBtnOk

// start class TkwEnTurnOffTimeMachineBtnOk

function TkwEnTurnOffTimeMachineBtnOk.BtnOk(const aCtx: TtfwContext;
  aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtButton;
 {-}
begin
 Result := aen_TurnOffTimeMachine.btnOk;
end;//TkwEnTurnOffTimeMachineBtnOk.BtnOk

procedure TkwEnTurnOffTimeMachineBtnOk.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_TurnOffTimeMachine : Ten_TurnOffTimeMachine;
begin
 try
  l_aen_TurnOffTimeMachine := Ten_TurnOffTimeMachine(aCtx.rEngine.PopObjAs(Ten_TurnOffTimeMachine));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BtnOk(aCtx, l_aen_TurnOffTimeMachine)));
end;//TkwEnTurnOffTimeMachineBtnOk.DoDoIt

class function TkwEnTurnOffTimeMachineBtnOk.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_TurnOffTimeMachine.btnOk';
end;//TkwEnTurnOffTimeMachineBtnOk.GetWordNameForRegister

procedure TkwEnTurnOffTimeMachineBtnOk.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству btnOk', aCtx);
end;//TkwEnTurnOffTimeMachineBtnOk.SetValuePrim

function TkwEnTurnOffTimeMachineBtnOk.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtButton);
end;//TkwEnTurnOffTimeMachineBtnOk.GetResultTypeInfo

function TkwEnTurnOffTimeMachineBtnOk.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnTurnOffTimeMachineBtnOk.GetAllParamsCount

function TkwEnTurnOffTimeMachineBtnOk.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOffTimeMachine)]);
end;//TkwEnTurnOffTimeMachineBtnOk.ParamsTypes

type
  TkwEnTurnOffTimeMachineBtnCancel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_TurnOffTimeMachine.btnCancel
[panel]Контрол btnCancel формы Ten_TurnOffTimeMachine[panel]
*Тип результата:* TvtButton
*Пример:*
[code]
OBJECT VAR l_TvtButton
 aen_TurnOffTimeMachine .Ten_TurnOffTimeMachine.btnCancel >>> l_TvtButton
[code]  }
  private
  // private methods
   function BtnCancel(const aCtx: TtfwContext;
     aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtButton;
     {* Реализация слова скрипта .Ten_TurnOffTimeMachine.btnCancel }
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
  end;//TkwEnTurnOffTimeMachineBtnCancel

// start class TkwEnTurnOffTimeMachineBtnCancel

function TkwEnTurnOffTimeMachineBtnCancel.BtnCancel(const aCtx: TtfwContext;
  aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtButton;
 {-}
begin
 Result := aen_TurnOffTimeMachine.btnCancel;
end;//TkwEnTurnOffTimeMachineBtnCancel.BtnCancel

procedure TkwEnTurnOffTimeMachineBtnCancel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_TurnOffTimeMachine : Ten_TurnOffTimeMachine;
begin
 try
  l_aen_TurnOffTimeMachine := Ten_TurnOffTimeMachine(aCtx.rEngine.PopObjAs(Ten_TurnOffTimeMachine));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BtnCancel(aCtx, l_aen_TurnOffTimeMachine)));
end;//TkwEnTurnOffTimeMachineBtnCancel.DoDoIt

class function TkwEnTurnOffTimeMachineBtnCancel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_TurnOffTimeMachine.btnCancel';
end;//TkwEnTurnOffTimeMachineBtnCancel.GetWordNameForRegister

procedure TkwEnTurnOffTimeMachineBtnCancel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству btnCancel', aCtx);
end;//TkwEnTurnOffTimeMachineBtnCancel.SetValuePrim

function TkwEnTurnOffTimeMachineBtnCancel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtButton);
end;//TkwEnTurnOffTimeMachineBtnCancel.GetResultTypeInfo

function TkwEnTurnOffTimeMachineBtnCancel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnTurnOffTimeMachineBtnCancel.GetAllParamsCount

function TkwEnTurnOffTimeMachineBtnCancel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOffTimeMachine)]);
end;//TkwEnTurnOffTimeMachineBtnCancel.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_TurnOffTimeMachine
 Tkw_Form_TurnOffTimeMachine.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate
 Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push
 Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction
 Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push
 Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction
 Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push
 Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_TurnOffTimeMachine_Control_deChangeDate
 Tkw_TurnOffTimeMachine_Control_deChangeDate.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_TurnOffTimeMachine_Control_deChangeDate_Push
 Tkw_TurnOffTimeMachine_Control_deChangeDate_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_TurnOffTimeMachine_Control_pbDialogIcon
 Tkw_TurnOffTimeMachine_Control_pbDialogIcon.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push
 Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo
 Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push
 Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_TurnOffTimeMachine_Control_btnOk
 Tkw_TurnOffTimeMachine_Control_btnOk.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_TurnOffTimeMachine_Control_btnOk_Push
 Tkw_TurnOffTimeMachine_Control_btnOk_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_TurnOffTimeMachine_Control_btnCancel
 Tkw_TurnOffTimeMachine_Control_btnCancel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_TurnOffTimeMachine_Control_btnCancel_Push
 Tkw_TurnOffTimeMachine_Control_btnCancel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_TurnOffTimeMachine_rb_totmChangeDate
 TkwEnTurnOffTimeMachineRbTotmChangeDate.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_TurnOffTimeMachine_rb_totmStayInCurrentRedaction
 TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_TurnOffTimeMachine_rb_totmGotoActualRedaction
 TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_TurnOffTimeMachine_deChangeDate
 TkwEnTurnOffTimeMachineDeChangeDate.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_TurnOffTimeMachine_pbDialogIcon
 TkwEnTurnOffTimeMachinePbDialogIcon.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_TurnOffTimeMachine_lblTurnOnTimeMachineInfo
 TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_TurnOffTimeMachine_btnOk
 TkwEnTurnOffTimeMachineBtnOk.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_TurnOffTimeMachine_btnCancel
 TkwEnTurnOffTimeMachineBtnCancel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TurnOffTimeMachine
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_TurnOffTimeMachine));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtRadioButton
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtRadioButton));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtDblClickDateEdit
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtDblClickDateEdit));
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
// Регистрация типа TvtButton
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtButton));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.
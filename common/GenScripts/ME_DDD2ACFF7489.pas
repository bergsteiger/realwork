unit TurnOffTimeMachineKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы TurnOffTimeMachine }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\TurnOffTimeMachineKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PrimF1Common_Module
 , vtRadioButton
 , vtDblClickDateEdit
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , vtLabel
 , vtButton
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_TurnOffTimeMachine = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы TurnOffTimeMachine
----
*Пример использования*:
[code]
'aControl' форма::TurnOffTimeMachine TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_TurnOffTimeMachine

 Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола rb_totmChangeDate
----
*Пример использования*:
[code]
контрол::rb_totmChangeDate TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate

 Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола rb_totmChangeDate
----
*Пример использования*:
[code]
контрол::rb_totmChangeDate:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push

 Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола rb_totmStayInCurrentRedaction
----
*Пример использования*:
[code]
контрол::rb_totmStayInCurrentRedaction TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction

 Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола rb_totmStayInCurrentRedaction
----
*Пример использования*:
[code]
контрол::rb_totmStayInCurrentRedaction:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push

 Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола rb_totmGotoActualRedaction
----
*Пример использования*:
[code]
контрол::rb_totmGotoActualRedaction TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction

 Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола rb_totmGotoActualRedaction
----
*Пример использования*:
[code]
контрол::rb_totmGotoActualRedaction:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push

 Tkw_TurnOffTimeMachine_Control_deChangeDate = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола deChangeDate
----
*Пример использования*:
[code]
контрол::deChangeDate TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TurnOffTimeMachine_Control_deChangeDate

 Tkw_TurnOffTimeMachine_Control_deChangeDate_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола deChangeDate
----
*Пример использования*:
[code]
контрол::deChangeDate:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_deChangeDate_Push

 Tkw_TurnOffTimeMachine_Control_pbDialogIcon = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pbDialogIcon
----
*Пример использования*:
[code]
контрол::pbDialogIcon TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon

 Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pbDialogIcon
----
*Пример использования*:
[code]
контрол::pbDialogIcon:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push

 Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblTurnOnTimeMachineInfo
----
*Пример использования*:
[code]
контрол::lblTurnOnTimeMachineInfo TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo

 Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lblTurnOnTimeMachineInfo
----
*Пример использования*:
[code]
контрол::lblTurnOnTimeMachineInfo:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push

 Tkw_TurnOffTimeMachine_Control_btnOk = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnOk
----
*Пример использования*:
[code]
контрол::btnOk TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TurnOffTimeMachine_Control_btnOk

 Tkw_TurnOffTimeMachine_Control_btnOk_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола btnOk
----
*Пример использования*:
[code]
контрол::btnOk:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_btnOk_Push

 Tkw_TurnOffTimeMachine_Control_btnCancel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnCancel
----
*Пример использования*:
[code]
контрол::btnCancel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TurnOffTimeMachine_Control_btnCancel

 Tkw_TurnOffTimeMachine_Control_btnCancel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола btnCancel
----
*Пример использования*:
[code]
контрол::btnCancel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_btnCancel_Push

 TkwEnTurnOffTimeMachineRbTotmChangeDate = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_TurnOffTimeMachine.rb_totmChangeDate
[panel]Контрол rb_totmChangeDate формы Ten_TurnOffTimeMachine[panel]
*Тип результата:* TvtRadioButton
*Пример:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_TurnOffTimeMachine .Ten_TurnOffTimeMachine.rb_totmChangeDate >>> l_TvtRadioButton
[code]  }
  private
   function rb_totmChangeDate(const aCtx: TtfwContext;
    aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtRadioButton;
    {* Реализация слова скрипта .Ten_TurnOffTimeMachine.rb_totmChangeDate }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOffTimeMachineRbTotmChangeDate

 TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_TurnOffTimeMachine.rb_totmStayInCurrentRedaction
[panel]Контрол rb_totmStayInCurrentRedaction формы Ten_TurnOffTimeMachine[panel]
*Тип результата:* TvtRadioButton
*Пример:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_TurnOffTimeMachine .Ten_TurnOffTimeMachine.rb_totmStayInCurrentRedaction >>> l_TvtRadioButton
[code]  }
  private
   function rb_totmStayInCurrentRedaction(const aCtx: TtfwContext;
    aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtRadioButton;
    {* Реализация слова скрипта .Ten_TurnOffTimeMachine.rb_totmStayInCurrentRedaction }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction

 TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_TurnOffTimeMachine.rb_totmGotoActualRedaction
[panel]Контрол rb_totmGotoActualRedaction формы Ten_TurnOffTimeMachine[panel]
*Тип результата:* TvtRadioButton
*Пример:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_TurnOffTimeMachine .Ten_TurnOffTimeMachine.rb_totmGotoActualRedaction >>> l_TvtRadioButton
[code]  }
  private
   function rb_totmGotoActualRedaction(const aCtx: TtfwContext;
    aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtRadioButton;
    {* Реализация слова скрипта .Ten_TurnOffTimeMachine.rb_totmGotoActualRedaction }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction

 TkwEnTurnOffTimeMachineDeChangeDate = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_TurnOffTimeMachine.deChangeDate
[panel]Контрол deChangeDate формы Ten_TurnOffTimeMachine[panel]
*Тип результата:* TvtDblClickDateEdit
*Пример:*
[code]
OBJECT VAR l_TvtDblClickDateEdit
 aen_TurnOffTimeMachine .Ten_TurnOffTimeMachine.deChangeDate >>> l_TvtDblClickDateEdit
[code]  }
  private
   function deChangeDate(const aCtx: TtfwContext;
    aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtDblClickDateEdit;
    {* Реализация слова скрипта .Ten_TurnOffTimeMachine.deChangeDate }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOffTimeMachineDeChangeDate

 TkwEnTurnOffTimeMachinePbDialogIcon = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_TurnOffTimeMachine.pbDialogIcon
[panel]Контрол pbDialogIcon формы Ten_TurnOffTimeMachine[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aen_TurnOffTimeMachine .Ten_TurnOffTimeMachine.pbDialogIcon >>> l_TPaintBox
[code]  }
  private
   function pbDialogIcon(const aCtx: TtfwContext;
    aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TPaintBox;
    {* Реализация слова скрипта .Ten_TurnOffTimeMachine.pbDialogIcon }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOffTimeMachinePbDialogIcon

 TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_TurnOffTimeMachine.lblTurnOnTimeMachineInfo
[panel]Контрол lblTurnOnTimeMachineInfo формы Ten_TurnOffTimeMachine[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aen_TurnOffTimeMachine .Ten_TurnOffTimeMachine.lblTurnOnTimeMachineInfo >>> l_TvtLabel
[code]  }
  private
   function lblTurnOnTimeMachineInfo(const aCtx: TtfwContext;
    aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtLabel;
    {* Реализация слова скрипта .Ten_TurnOffTimeMachine.lblTurnOnTimeMachineInfo }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo

 TkwEnTurnOffTimeMachineBtnOk = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_TurnOffTimeMachine.btnOk
[panel]Контрол btnOk формы Ten_TurnOffTimeMachine[panel]
*Тип результата:* TvtButton
*Пример:*
[code]
OBJECT VAR l_TvtButton
 aen_TurnOffTimeMachine .Ten_TurnOffTimeMachine.btnOk >>> l_TvtButton
[code]  }
  private
   function btnOk(const aCtx: TtfwContext;
    aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtButton;
    {* Реализация слова скрипта .Ten_TurnOffTimeMachine.btnOk }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOffTimeMachineBtnOk

 TkwEnTurnOffTimeMachineBtnCancel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_TurnOffTimeMachine.btnCancel
[panel]Контрол btnCancel формы Ten_TurnOffTimeMachine[panel]
*Тип результата:* TvtButton
*Пример:*
[code]
OBJECT VAR l_TvtButton
 aen_TurnOffTimeMachine .Ten_TurnOffTimeMachine.btnCancel >>> l_TvtButton
[code]  }
  private
   function btnCancel(const aCtx: TtfwContext;
    aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtButton;
    {* Реализация слова скрипта .Ten_TurnOffTimeMachine.btnCancel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOffTimeMachineBtnCancel

class function Tkw_Form_TurnOffTimeMachine.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::TurnOffTimeMachine';
end;//Tkw_Form_TurnOffTimeMachine.GetWordNameForRegister

function Tkw_Form_TurnOffTimeMachine.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_8CE500D1CACC_var*
//#UC END# *4DDFD2EA0116_8CE500D1CACC_var*
begin
//#UC START# *4DDFD2EA0116_8CE500D1CACC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_8CE500D1CACC_impl*
end;//Tkw_Form_TurnOffTimeMachine.GetString

class function Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rb_totmChangeDate';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_CD280F25968E_var*
//#UC END# *4DDFD2EA0116_CD280F25968E_var*
begin
//#UC START# *4DDFD2EA0116_CD280F25968E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_CD280F25968E_impl*
end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.GetString

class procedure Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.RegisterInEngine;
//#UC START# *52A086150180_CD280F25968E_var*
//#UC END# *52A086150180_CD280F25968E_var*
begin
//#UC START# *52A086150180_CD280F25968E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_CD280F25968E_impl*
end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.RegisterInEngine

procedure Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_73970F114C67_var*
//#UC END# *4DAEEDE10285_73970F114C67_var*
begin
//#UC START# *4DAEEDE10285_73970F114C67_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_73970F114C67_impl*
end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rb_totmChangeDate:push';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push.GetWordNameForRegister

class function Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rb_totmStayInCurrentRedaction';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_923B45BF5881_var*
//#UC END# *4DDFD2EA0116_923B45BF5881_var*
begin
//#UC START# *4DDFD2EA0116_923B45BF5881_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_923B45BF5881_impl*
end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.GetString

class procedure Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.RegisterInEngine;
//#UC START# *52A086150180_923B45BF5881_var*
//#UC END# *52A086150180_923B45BF5881_var*
begin
//#UC START# *52A086150180_923B45BF5881_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_923B45BF5881_impl*
end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.RegisterInEngine

procedure Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_329347BC9621_var*
//#UC END# *4DAEEDE10285_329347BC9621_var*
begin
//#UC START# *4DAEEDE10285_329347BC9621_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_329347BC9621_impl*
end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rb_totmStayInCurrentRedaction:push';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push.GetWordNameForRegister

class function Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rb_totmGotoActualRedaction';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_E0F0973062CD_var*
//#UC END# *4DDFD2EA0116_E0F0973062CD_var*
begin
//#UC START# *4DDFD2EA0116_E0F0973062CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_E0F0973062CD_impl*
end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.GetString

class procedure Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.RegisterInEngine;
//#UC START# *52A086150180_E0F0973062CD_var*
//#UC END# *52A086150180_E0F0973062CD_var*
begin
//#UC START# *52A086150180_E0F0973062CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_E0F0973062CD_impl*
end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.RegisterInEngine

procedure Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_AADFFD9BC500_var*
//#UC END# *4DAEEDE10285_AADFFD9BC500_var*
begin
//#UC START# *4DAEEDE10285_AADFFD9BC500_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_AADFFD9BC500_impl*
end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rb_totmGotoActualRedaction:push';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push.GetWordNameForRegister

class function Tkw_TurnOffTimeMachine_Control_deChangeDate.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::deChangeDate';
end;//Tkw_TurnOffTimeMachine_Control_deChangeDate.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_deChangeDate.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_23C9486AA8E3_var*
//#UC END# *4DDFD2EA0116_23C9486AA8E3_var*
begin
//#UC START# *4DDFD2EA0116_23C9486AA8E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_23C9486AA8E3_impl*
end;//Tkw_TurnOffTimeMachine_Control_deChangeDate.GetString

class procedure Tkw_TurnOffTimeMachine_Control_deChangeDate.RegisterInEngine;
//#UC START# *52A086150180_23C9486AA8E3_var*
//#UC END# *52A086150180_23C9486AA8E3_var*
begin
//#UC START# *52A086150180_23C9486AA8E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_23C9486AA8E3_impl*
end;//Tkw_TurnOffTimeMachine_Control_deChangeDate.RegisterInEngine

procedure Tkw_TurnOffTimeMachine_Control_deChangeDate_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_13E12623C327_var*
//#UC END# *4DAEEDE10285_13E12623C327_var*
begin
//#UC START# *4DAEEDE10285_13E12623C327_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_13E12623C327_impl*
end;//Tkw_TurnOffTimeMachine_Control_deChangeDate_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_deChangeDate_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::deChangeDate:push';
end;//Tkw_TurnOffTimeMachine_Control_deChangeDate_Push.GetWordNameForRegister

class function Tkw_TurnOffTimeMachine_Control_pbDialogIcon.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbDialogIcon';
end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_pbDialogIcon.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5DA40358DF8A_var*
//#UC END# *4DDFD2EA0116_5DA40358DF8A_var*
begin
//#UC START# *4DDFD2EA0116_5DA40358DF8A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5DA40358DF8A_impl*
end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon.GetString

class procedure Tkw_TurnOffTimeMachine_Control_pbDialogIcon.RegisterInEngine;
//#UC START# *52A086150180_5DA40358DF8A_var*
//#UC END# *52A086150180_5DA40358DF8A_var*
begin
//#UC START# *52A086150180_5DA40358DF8A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_5DA40358DF8A_impl*
end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon.RegisterInEngine

procedure Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1A612EADDA25_var*
//#UC END# *4DAEEDE10285_1A612EADDA25_var*
begin
//#UC START# *4DAEEDE10285_1A612EADDA25_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1A612EADDA25_impl*
end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbDialogIcon:push';
end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push.GetWordNameForRegister

class function Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblTurnOnTimeMachineInfo';
end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_731F438BD6C0_var*
//#UC END# *4DDFD2EA0116_731F438BD6C0_var*
begin
//#UC START# *4DDFD2EA0116_731F438BD6C0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_731F438BD6C0_impl*
end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.GetString

class procedure Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.RegisterInEngine;
//#UC START# *52A086150180_731F438BD6C0_var*
//#UC END# *52A086150180_731F438BD6C0_var*
begin
//#UC START# *52A086150180_731F438BD6C0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_731F438BD6C0_impl*
end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.RegisterInEngine

procedure Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_99BA6CB5CBE4_var*
//#UC END# *4DAEEDE10285_99BA6CB5CBE4_var*
begin
//#UC START# *4DAEEDE10285_99BA6CB5CBE4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_99BA6CB5CBE4_impl*
end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblTurnOnTimeMachineInfo:push';
end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.GetWordNameForRegister

class function Tkw_TurnOffTimeMachine_Control_btnOk.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnOk';
end;//Tkw_TurnOffTimeMachine_Control_btnOk.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_btnOk.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2454A1DFC304_var*
//#UC END# *4DDFD2EA0116_2454A1DFC304_var*
begin
//#UC START# *4DDFD2EA0116_2454A1DFC304_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2454A1DFC304_impl*
end;//Tkw_TurnOffTimeMachine_Control_btnOk.GetString

class procedure Tkw_TurnOffTimeMachine_Control_btnOk.RegisterInEngine;
//#UC START# *52A086150180_2454A1DFC304_var*
//#UC END# *52A086150180_2454A1DFC304_var*
begin
//#UC START# *52A086150180_2454A1DFC304_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_2454A1DFC304_impl*
end;//Tkw_TurnOffTimeMachine_Control_btnOk.RegisterInEngine

procedure Tkw_TurnOffTimeMachine_Control_btnOk_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_27CEBC2CD753_var*
//#UC END# *4DAEEDE10285_27CEBC2CD753_var*
begin
//#UC START# *4DAEEDE10285_27CEBC2CD753_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_27CEBC2CD753_impl*
end;//Tkw_TurnOffTimeMachine_Control_btnOk_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_btnOk_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnOk:push';
end;//Tkw_TurnOffTimeMachine_Control_btnOk_Push.GetWordNameForRegister

class function Tkw_TurnOffTimeMachine_Control_btnCancel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnCancel';
end;//Tkw_TurnOffTimeMachine_Control_btnCancel.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_btnCancel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_4CA19D35483C_var*
//#UC END# *4DDFD2EA0116_4CA19D35483C_var*
begin
//#UC START# *4DDFD2EA0116_4CA19D35483C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_4CA19D35483C_impl*
end;//Tkw_TurnOffTimeMachine_Control_btnCancel.GetString

class procedure Tkw_TurnOffTimeMachine_Control_btnCancel.RegisterInEngine;
//#UC START# *52A086150180_4CA19D35483C_var*
//#UC END# *52A086150180_4CA19D35483C_var*
begin
//#UC START# *52A086150180_4CA19D35483C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_4CA19D35483C_impl*
end;//Tkw_TurnOffTimeMachine_Control_btnCancel.RegisterInEngine

procedure Tkw_TurnOffTimeMachine_Control_btnCancel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_EE06077A6BAF_var*
//#UC END# *4DAEEDE10285_EE06077A6BAF_var*
begin
//#UC START# *4DAEEDE10285_EE06077A6BAF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_EE06077A6BAF_impl*
end;//Tkw_TurnOffTimeMachine_Control_btnCancel_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_btnCancel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnCancel:push';
end;//Tkw_TurnOffTimeMachine_Control_btnCancel_Push.GetWordNameForRegister

function TkwEnTurnOffTimeMachineRbTotmChangeDate.rb_totmChangeDate(const aCtx: TtfwContext;
 aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtRadioButton;
 {* Реализация слова скрипта .Ten_TurnOffTimeMachine.rb_totmChangeDate }
//#UC START# *3B52A3781D9B_1868E4F82544_var*
//#UC END# *3B52A3781D9B_1868E4F82544_var*
begin
//#UC START# *3B52A3781D9B_1868E4F82544_impl*
 !!! Needs to be implemented !!!
//#UC END# *3B52A3781D9B_1868E4F82544_impl*
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.rb_totmChangeDate

procedure TkwEnTurnOffTimeMachineRbTotmChangeDate.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1868E4F82544_var*
//#UC END# *4DAEEDE10285_1868E4F82544_var*
begin
//#UC START# *4DAEEDE10285_1868E4F82544_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1868E4F82544_impl*
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.DoDoIt

class function TkwEnTurnOffTimeMachineRbTotmChangeDate.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOffTimeMachine.rb_totmChangeDate';
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.GetWordNameForRegister

procedure TkwEnTurnOffTimeMachineRbTotmChangeDate.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_1868E4F82544_var*
//#UC END# *52D00B00031A_1868E4F82544_var*
begin
//#UC START# *52D00B00031A_1868E4F82544_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_1868E4F82544_impl*
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.SetValuePrim

function TkwEnTurnOffTimeMachineRbTotmChangeDate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_1868E4F82544_var*
//#UC END# *551544E2001A_1868E4F82544_var*
begin
//#UC START# *551544E2001A_1868E4F82544_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_1868E4F82544_impl*
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.GetResultTypeInfo

function TkwEnTurnOffTimeMachineRbTotmChangeDate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.GetAllParamsCount

function TkwEnTurnOffTimeMachineRbTotmChangeDate.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_1868E4F82544_var*
//#UC END# *5617F4D00243_1868E4F82544_var*
begin
//#UC START# *5617F4D00243_1868E4F82544_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1868E4F82544_impl*
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.ParamsTypes

function TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.rb_totmStayInCurrentRedaction(const aCtx: TtfwContext;
 aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtRadioButton;
 {* Реализация слова скрипта .Ten_TurnOffTimeMachine.rb_totmStayInCurrentRedaction }
//#UC START# *D9F538B461E6_F59F378BD196_var*
//#UC END# *D9F538B461E6_F59F378BD196_var*
begin
//#UC START# *D9F538B461E6_F59F378BD196_impl*
 !!! Needs to be implemented !!!
//#UC END# *D9F538B461E6_F59F378BD196_impl*
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.rb_totmStayInCurrentRedaction

procedure TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F59F378BD196_var*
//#UC END# *4DAEEDE10285_F59F378BD196_var*
begin
//#UC START# *4DAEEDE10285_F59F378BD196_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F59F378BD196_impl*
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.DoDoIt

class function TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOffTimeMachine.rb_totmStayInCurrentRedaction';
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.GetWordNameForRegister

procedure TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_F59F378BD196_var*
//#UC END# *52D00B00031A_F59F378BD196_var*
begin
//#UC START# *52D00B00031A_F59F378BD196_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_F59F378BD196_impl*
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.SetValuePrim

function TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F59F378BD196_var*
//#UC END# *551544E2001A_F59F378BD196_var*
begin
//#UC START# *551544E2001A_F59F378BD196_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F59F378BD196_impl*
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.GetResultTypeInfo

function TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.GetAllParamsCount

function TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F59F378BD196_var*
//#UC END# *5617F4D00243_F59F378BD196_var*
begin
//#UC START# *5617F4D00243_F59F378BD196_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F59F378BD196_impl*
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.ParamsTypes

function TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.rb_totmGotoActualRedaction(const aCtx: TtfwContext;
 aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtRadioButton;
 {* Реализация слова скрипта .Ten_TurnOffTimeMachine.rb_totmGotoActualRedaction }
//#UC START# *E6AEBC624CD0_2A6564384E23_var*
//#UC END# *E6AEBC624CD0_2A6564384E23_var*
begin
//#UC START# *E6AEBC624CD0_2A6564384E23_impl*
 !!! Needs to be implemented !!!
//#UC END# *E6AEBC624CD0_2A6564384E23_impl*
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.rb_totmGotoActualRedaction

procedure TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2A6564384E23_var*
//#UC END# *4DAEEDE10285_2A6564384E23_var*
begin
//#UC START# *4DAEEDE10285_2A6564384E23_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2A6564384E23_impl*
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.DoDoIt

class function TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOffTimeMachine.rb_totmGotoActualRedaction';
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.GetWordNameForRegister

procedure TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_2A6564384E23_var*
//#UC END# *52D00B00031A_2A6564384E23_var*
begin
//#UC START# *52D00B00031A_2A6564384E23_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_2A6564384E23_impl*
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.SetValuePrim

function TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_2A6564384E23_var*
//#UC END# *551544E2001A_2A6564384E23_var*
begin
//#UC START# *551544E2001A_2A6564384E23_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_2A6564384E23_impl*
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.GetResultTypeInfo

function TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.GetAllParamsCount

function TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_2A6564384E23_var*
//#UC END# *5617F4D00243_2A6564384E23_var*
begin
//#UC START# *5617F4D00243_2A6564384E23_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_2A6564384E23_impl*
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.ParamsTypes

function TkwEnTurnOffTimeMachineDeChangeDate.deChangeDate(const aCtx: TtfwContext;
 aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtDblClickDateEdit;
 {* Реализация слова скрипта .Ten_TurnOffTimeMachine.deChangeDate }
//#UC START# *ABBB3E17C15C_F661DF4EA2C1_var*
//#UC END# *ABBB3E17C15C_F661DF4EA2C1_var*
begin
//#UC START# *ABBB3E17C15C_F661DF4EA2C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *ABBB3E17C15C_F661DF4EA2C1_impl*
end;//TkwEnTurnOffTimeMachineDeChangeDate.deChangeDate

procedure TkwEnTurnOffTimeMachineDeChangeDate.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F661DF4EA2C1_var*
//#UC END# *4DAEEDE10285_F661DF4EA2C1_var*
begin
//#UC START# *4DAEEDE10285_F661DF4EA2C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F661DF4EA2C1_impl*
end;//TkwEnTurnOffTimeMachineDeChangeDate.DoDoIt

class function TkwEnTurnOffTimeMachineDeChangeDate.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOffTimeMachine.deChangeDate';
end;//TkwEnTurnOffTimeMachineDeChangeDate.GetWordNameForRegister

procedure TkwEnTurnOffTimeMachineDeChangeDate.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_F661DF4EA2C1_var*
//#UC END# *52D00B00031A_F661DF4EA2C1_var*
begin
//#UC START# *52D00B00031A_F661DF4EA2C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_F661DF4EA2C1_impl*
end;//TkwEnTurnOffTimeMachineDeChangeDate.SetValuePrim

function TkwEnTurnOffTimeMachineDeChangeDate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F661DF4EA2C1_var*
//#UC END# *551544E2001A_F661DF4EA2C1_var*
begin
//#UC START# *551544E2001A_F661DF4EA2C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F661DF4EA2C1_impl*
end;//TkwEnTurnOffTimeMachineDeChangeDate.GetResultTypeInfo

function TkwEnTurnOffTimeMachineDeChangeDate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOffTimeMachineDeChangeDate.GetAllParamsCount

function TkwEnTurnOffTimeMachineDeChangeDate.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F661DF4EA2C1_var*
//#UC END# *5617F4D00243_F661DF4EA2C1_var*
begin
//#UC START# *5617F4D00243_F661DF4EA2C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F661DF4EA2C1_impl*
end;//TkwEnTurnOffTimeMachineDeChangeDate.ParamsTypes

function TkwEnTurnOffTimeMachinePbDialogIcon.pbDialogIcon(const aCtx: TtfwContext;
 aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TPaintBox;
 {* Реализация слова скрипта .Ten_TurnOffTimeMachine.pbDialogIcon }
//#UC START# *71DAB973C644_A0F488D95317_var*
//#UC END# *71DAB973C644_A0F488D95317_var*
begin
//#UC START# *71DAB973C644_A0F488D95317_impl*
 !!! Needs to be implemented !!!
//#UC END# *71DAB973C644_A0F488D95317_impl*
end;//TkwEnTurnOffTimeMachinePbDialogIcon.pbDialogIcon

procedure TkwEnTurnOffTimeMachinePbDialogIcon.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A0F488D95317_var*
//#UC END# *4DAEEDE10285_A0F488D95317_var*
begin
//#UC START# *4DAEEDE10285_A0F488D95317_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A0F488D95317_impl*
end;//TkwEnTurnOffTimeMachinePbDialogIcon.DoDoIt

class function TkwEnTurnOffTimeMachinePbDialogIcon.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOffTimeMachine.pbDialogIcon';
end;//TkwEnTurnOffTimeMachinePbDialogIcon.GetWordNameForRegister

procedure TkwEnTurnOffTimeMachinePbDialogIcon.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_A0F488D95317_var*
//#UC END# *52D00B00031A_A0F488D95317_var*
begin
//#UC START# *52D00B00031A_A0F488D95317_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_A0F488D95317_impl*
end;//TkwEnTurnOffTimeMachinePbDialogIcon.SetValuePrim

function TkwEnTurnOffTimeMachinePbDialogIcon.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_A0F488D95317_var*
//#UC END# *551544E2001A_A0F488D95317_var*
begin
//#UC START# *551544E2001A_A0F488D95317_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_A0F488D95317_impl*
end;//TkwEnTurnOffTimeMachinePbDialogIcon.GetResultTypeInfo

function TkwEnTurnOffTimeMachinePbDialogIcon.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOffTimeMachinePbDialogIcon.GetAllParamsCount

function TkwEnTurnOffTimeMachinePbDialogIcon.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_A0F488D95317_var*
//#UC END# *5617F4D00243_A0F488D95317_var*
begin
//#UC START# *5617F4D00243_A0F488D95317_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_A0F488D95317_impl*
end;//TkwEnTurnOffTimeMachinePbDialogIcon.ParamsTypes

function TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.lblTurnOnTimeMachineInfo(const aCtx: TtfwContext;
 aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtLabel;
 {* Реализация слова скрипта .Ten_TurnOffTimeMachine.lblTurnOnTimeMachineInfo }
//#UC START# *62827A517902_BA15E8037522_var*
//#UC END# *62827A517902_BA15E8037522_var*
begin
//#UC START# *62827A517902_BA15E8037522_impl*
 !!! Needs to be implemented !!!
//#UC END# *62827A517902_BA15E8037522_impl*
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.lblTurnOnTimeMachineInfo

procedure TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BA15E8037522_var*
//#UC END# *4DAEEDE10285_BA15E8037522_var*
begin
//#UC START# *4DAEEDE10285_BA15E8037522_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BA15E8037522_impl*
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.DoDoIt

class function TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOffTimeMachine.lblTurnOnTimeMachineInfo';
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.GetWordNameForRegister

procedure TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_BA15E8037522_var*
//#UC END# *52D00B00031A_BA15E8037522_var*
begin
//#UC START# *52D00B00031A_BA15E8037522_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_BA15E8037522_impl*
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.SetValuePrim

function TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_BA15E8037522_var*
//#UC END# *551544E2001A_BA15E8037522_var*
begin
//#UC START# *551544E2001A_BA15E8037522_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_BA15E8037522_impl*
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.GetResultTypeInfo

function TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.GetAllParamsCount

function TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_BA15E8037522_var*
//#UC END# *5617F4D00243_BA15E8037522_var*
begin
//#UC START# *5617F4D00243_BA15E8037522_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_BA15E8037522_impl*
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.ParamsTypes

function TkwEnTurnOffTimeMachineBtnOk.btnOk(const aCtx: TtfwContext;
 aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtButton;
 {* Реализация слова скрипта .Ten_TurnOffTimeMachine.btnOk }
//#UC START# *72DE79D255F0_39ED602876E3_var*
//#UC END# *72DE79D255F0_39ED602876E3_var*
begin
//#UC START# *72DE79D255F0_39ED602876E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *72DE79D255F0_39ED602876E3_impl*
end;//TkwEnTurnOffTimeMachineBtnOk.btnOk

procedure TkwEnTurnOffTimeMachineBtnOk.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_39ED602876E3_var*
//#UC END# *4DAEEDE10285_39ED602876E3_var*
begin
//#UC START# *4DAEEDE10285_39ED602876E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_39ED602876E3_impl*
end;//TkwEnTurnOffTimeMachineBtnOk.DoDoIt

class function TkwEnTurnOffTimeMachineBtnOk.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOffTimeMachine.btnOk';
end;//TkwEnTurnOffTimeMachineBtnOk.GetWordNameForRegister

procedure TkwEnTurnOffTimeMachineBtnOk.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_39ED602876E3_var*
//#UC END# *52D00B00031A_39ED602876E3_var*
begin
//#UC START# *52D00B00031A_39ED602876E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_39ED602876E3_impl*
end;//TkwEnTurnOffTimeMachineBtnOk.SetValuePrim

function TkwEnTurnOffTimeMachineBtnOk.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_39ED602876E3_var*
//#UC END# *551544E2001A_39ED602876E3_var*
begin
//#UC START# *551544E2001A_39ED602876E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_39ED602876E3_impl*
end;//TkwEnTurnOffTimeMachineBtnOk.GetResultTypeInfo

function TkwEnTurnOffTimeMachineBtnOk.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOffTimeMachineBtnOk.GetAllParamsCount

function TkwEnTurnOffTimeMachineBtnOk.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_39ED602876E3_var*
//#UC END# *5617F4D00243_39ED602876E3_var*
begin
//#UC START# *5617F4D00243_39ED602876E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_39ED602876E3_impl*
end;//TkwEnTurnOffTimeMachineBtnOk.ParamsTypes

function TkwEnTurnOffTimeMachineBtnCancel.btnCancel(const aCtx: TtfwContext;
 aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtButton;
 {* Реализация слова скрипта .Ten_TurnOffTimeMachine.btnCancel }
//#UC START# *68B29319E6DB_D14C3EA641C3_var*
//#UC END# *68B29319E6DB_D14C3EA641C3_var*
begin
//#UC START# *68B29319E6DB_D14C3EA641C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *68B29319E6DB_D14C3EA641C3_impl*
end;//TkwEnTurnOffTimeMachineBtnCancel.btnCancel

procedure TkwEnTurnOffTimeMachineBtnCancel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D14C3EA641C3_var*
//#UC END# *4DAEEDE10285_D14C3EA641C3_var*
begin
//#UC START# *4DAEEDE10285_D14C3EA641C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D14C3EA641C3_impl*
end;//TkwEnTurnOffTimeMachineBtnCancel.DoDoIt

class function TkwEnTurnOffTimeMachineBtnCancel.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOffTimeMachine.btnCancel';
end;//TkwEnTurnOffTimeMachineBtnCancel.GetWordNameForRegister

procedure TkwEnTurnOffTimeMachineBtnCancel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_D14C3EA641C3_var*
//#UC END# *52D00B00031A_D14C3EA641C3_var*
begin
//#UC START# *52D00B00031A_D14C3EA641C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_D14C3EA641C3_impl*
end;//TkwEnTurnOffTimeMachineBtnCancel.SetValuePrim

function TkwEnTurnOffTimeMachineBtnCancel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_D14C3EA641C3_var*
//#UC END# *551544E2001A_D14C3EA641C3_var*
begin
//#UC START# *551544E2001A_D14C3EA641C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_D14C3EA641C3_impl*
end;//TkwEnTurnOffTimeMachineBtnCancel.GetResultTypeInfo

function TkwEnTurnOffTimeMachineBtnCancel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOffTimeMachineBtnCancel.GetAllParamsCount

function TkwEnTurnOffTimeMachineBtnCancel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D14C3EA641C3_var*
//#UC END# *5617F4D00243_D14C3EA641C3_var*
begin
//#UC START# *5617F4D00243_D14C3EA641C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D14C3EA641C3_impl*
end;//TkwEnTurnOffTimeMachineBtnCancel.ParamsTypes

initialization
 Tkw_Form_TurnOffTimeMachine.RegisterInEngine;
 {* Регистрация Tkw_Form_TurnOffTimeMachine }
 Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.RegisterInEngine;
 {* Регистрация Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate }
 Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push.RegisterInEngine;
 {* Регистрация Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push }
 Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.RegisterInEngine;
 {* Регистрация Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction }
 Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push.RegisterInEngine;
 {* Регистрация Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push }
 Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.RegisterInEngine;
 {* Регистрация Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction }
 Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push.RegisterInEngine;
 {* Регистрация Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push }
 Tkw_TurnOffTimeMachine_Control_deChangeDate.RegisterInEngine;
 {* Регистрация Tkw_TurnOffTimeMachine_Control_deChangeDate }
 Tkw_TurnOffTimeMachine_Control_deChangeDate_Push.RegisterInEngine;
 {* Регистрация Tkw_TurnOffTimeMachine_Control_deChangeDate_Push }
 Tkw_TurnOffTimeMachine_Control_pbDialogIcon.RegisterInEngine;
 {* Регистрация Tkw_TurnOffTimeMachine_Control_pbDialogIcon }
 Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push.RegisterInEngine;
 {* Регистрация Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push }
 Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.RegisterInEngine;
 {* Регистрация Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo }
 Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.RegisterInEngine;
 {* Регистрация Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push }
 Tkw_TurnOffTimeMachine_Control_btnOk.RegisterInEngine;
 {* Регистрация Tkw_TurnOffTimeMachine_Control_btnOk }
 Tkw_TurnOffTimeMachine_Control_btnOk_Push.RegisterInEngine;
 {* Регистрация Tkw_TurnOffTimeMachine_Control_btnOk_Push }
 Tkw_TurnOffTimeMachine_Control_btnCancel.RegisterInEngine;
 {* Регистрация Tkw_TurnOffTimeMachine_Control_btnCancel }
 Tkw_TurnOffTimeMachine_Control_btnCancel_Push.RegisterInEngine;
 {* Регистрация Tkw_TurnOffTimeMachine_Control_btnCancel_Push }
 TkwEnTurnOffTimeMachineRbTotmChangeDate.RegisterInEngine;
 {* Регистрация en_TurnOffTimeMachine_rb_totmChangeDate }
 TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.RegisterInEngine;
 {* Регистрация en_TurnOffTimeMachine_rb_totmStayInCurrentRedaction }
 TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.RegisterInEngine;
 {* Регистрация en_TurnOffTimeMachine_rb_totmGotoActualRedaction }
 TkwEnTurnOffTimeMachineDeChangeDate.RegisterInEngine;
 {* Регистрация en_TurnOffTimeMachine_deChangeDate }
 TkwEnTurnOffTimeMachinePbDialogIcon.RegisterInEngine;
 {* Регистрация en_TurnOffTimeMachine_pbDialogIcon }
 TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.RegisterInEngine;
 {* Регистрация en_TurnOffTimeMachine_lblTurnOnTimeMachineInfo }
 TkwEnTurnOffTimeMachineBtnOk.RegisterInEngine;
 {* Регистрация en_TurnOffTimeMachine_btnOk }
 TkwEnTurnOffTimeMachineBtnCancel.RegisterInEngine;
 {* Регистрация en_TurnOffTimeMachine_btnCancel }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_TurnOffTimeMachine));
 {* Регистрация типа TurnOffTimeMachine }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtRadioButton));
 {* Регистрация типа TvtRadioButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtDblClickDateEdit));
 {* Регистрация типа TvtDblClickDateEdit }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* Регистрация типа TPaintBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtButton));
 {* Регистрация типа TvtButton }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.

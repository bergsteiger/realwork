unit TurnOnTimeMachineKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы TurnOnTimeMachine }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\TurnOnTimeMachineKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Document_Module
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
 Tkw_Form_TurnOnTimeMachine = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы TurnOnTimeMachine
----
*Пример использования*:
[code]
'aControl' форма::TurnOnTimeMachine TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_TurnOnTimeMachine

 Tkw_TurnOnTimeMachine_Control_rb_totmOnDate = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола rb_totmOnDate
----
*Пример использования*:
[code]
контрол::rb_totmOnDate TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnDate

 Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола rb_totmOnDate
----
*Пример использования*:
[code]
контрол::rb_totmOnDate:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push

 Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола rb_totmOnCurrentRedation
----
*Пример использования*:
[code]
контрол::rb_totmOnCurrentRedation TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation

 Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола rb_totmOnCurrentRedation
----
*Пример использования*:
[code]
контрол::rb_totmOnCurrentRedation:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push

 Tkw_TurnOnTimeMachine_Control_deDate = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола deDate
----
*Пример использования*:
[code]
контрол::deDate TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TurnOnTimeMachine_Control_deDate

 Tkw_TurnOnTimeMachine_Control_deDate_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола deDate
----
*Пример использования*:
[code]
контрол::deDate:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOnTimeMachine_Control_deDate_Push

 Tkw_TurnOnTimeMachine_Control_pbDialogIcon = {final} class(TtfwControlString)
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
 end;//Tkw_TurnOnTimeMachine_Control_pbDialogIcon

 Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pbDialogIcon
----
*Пример использования*:
[code]
контрол::pbDialogIcon:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push

 Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo = {final} class(TtfwControlString)
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
 end;//Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo

 Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lblTurnOnTimeMachineInfo
----
*Пример использования*:
[code]
контрол::lblTurnOnTimeMachineInfo:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push

 Tkw_TurnOnTimeMachine_Control_btnOk = {final} class(TtfwControlString)
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
 end;//Tkw_TurnOnTimeMachine_Control_btnOk

 Tkw_TurnOnTimeMachine_Control_btnOk_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола btnOk
----
*Пример использования*:
[code]
контрол::btnOk:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOnTimeMachine_Control_btnOk_Push

 Tkw_TurnOnTimeMachine_Control_btnCancel = {final} class(TtfwControlString)
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
 end;//Tkw_TurnOnTimeMachine_Control_btnCancel

 Tkw_TurnOnTimeMachine_Control_btnCancel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола btnCancel
----
*Пример использования*:
[code]
контрол::btnCancel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOnTimeMachine_Control_btnCancel_Push

 TkwEnTurnOnTimeMachineRbTotmOnDate = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_TurnOnTimeMachine.rb_totmOnDate
[panel]Контрол rb_totmOnDate формы Ten_TurnOnTimeMachine[panel]
*Тип результата:* TvtRadioButton
*Пример:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_TurnOnTimeMachine .Ten_TurnOnTimeMachine.rb_totmOnDate >>> l_TvtRadioButton
[code]  }
  private
   function rb_totmOnDate(const aCtx: TtfwContext;
    aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtRadioButton;
    {* Реализация слова скрипта .Ten_TurnOnTimeMachine.rb_totmOnDate }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOnTimeMachineRbTotmOnDate

 TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_TurnOnTimeMachine.rb_totmOnCurrentRedation
[panel]Контрол rb_totmOnCurrentRedation формы Ten_TurnOnTimeMachine[panel]
*Тип результата:* TvtRadioButton
*Пример:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_TurnOnTimeMachine .Ten_TurnOnTimeMachine.rb_totmOnCurrentRedation >>> l_TvtRadioButton
[code]  }
  private
   function rb_totmOnCurrentRedation(const aCtx: TtfwContext;
    aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtRadioButton;
    {* Реализация слова скрипта .Ten_TurnOnTimeMachine.rb_totmOnCurrentRedation }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation

 TkwEnTurnOnTimeMachineDeDate = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_TurnOnTimeMachine.deDate
[panel]Контрол deDate формы Ten_TurnOnTimeMachine[panel]
*Тип результата:* TvtDblClickDateEdit
*Пример:*
[code]
OBJECT VAR l_TvtDblClickDateEdit
 aen_TurnOnTimeMachine .Ten_TurnOnTimeMachine.deDate >>> l_TvtDblClickDateEdit
[code]  }
  private
   function deDate(const aCtx: TtfwContext;
    aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtDblClickDateEdit;
    {* Реализация слова скрипта .Ten_TurnOnTimeMachine.deDate }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOnTimeMachineDeDate

 TkwEnTurnOnTimeMachinePbDialogIcon = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_TurnOnTimeMachine.pbDialogIcon
[panel]Контрол pbDialogIcon формы Ten_TurnOnTimeMachine[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aen_TurnOnTimeMachine .Ten_TurnOnTimeMachine.pbDialogIcon >>> l_TPaintBox
[code]  }
  private
   function pbDialogIcon(const aCtx: TtfwContext;
    aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TPaintBox;
    {* Реализация слова скрипта .Ten_TurnOnTimeMachine.pbDialogIcon }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOnTimeMachinePbDialogIcon

 TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_TurnOnTimeMachine.lblTurnOnTimeMachineInfo
[panel]Контрол lblTurnOnTimeMachineInfo формы Ten_TurnOnTimeMachine[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aen_TurnOnTimeMachine .Ten_TurnOnTimeMachine.lblTurnOnTimeMachineInfo >>> l_TvtLabel
[code]  }
  private
   function lblTurnOnTimeMachineInfo(const aCtx: TtfwContext;
    aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtLabel;
    {* Реализация слова скрипта .Ten_TurnOnTimeMachine.lblTurnOnTimeMachineInfo }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo

 TkwEnTurnOnTimeMachineBtnOk = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_TurnOnTimeMachine.btnOk
[panel]Контрол btnOk формы Ten_TurnOnTimeMachine[panel]
*Тип результата:* TvtButton
*Пример:*
[code]
OBJECT VAR l_TvtButton
 aen_TurnOnTimeMachine .Ten_TurnOnTimeMachine.btnOk >>> l_TvtButton
[code]  }
  private
   function btnOk(const aCtx: TtfwContext;
    aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtButton;
    {* Реализация слова скрипта .Ten_TurnOnTimeMachine.btnOk }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOnTimeMachineBtnOk

 TkwEnTurnOnTimeMachineBtnCancel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_TurnOnTimeMachine.btnCancel
[panel]Контрол btnCancel формы Ten_TurnOnTimeMachine[panel]
*Тип результата:* TvtButton
*Пример:*
[code]
OBJECT VAR l_TvtButton
 aen_TurnOnTimeMachine .Ten_TurnOnTimeMachine.btnCancel >>> l_TvtButton
[code]  }
  private
   function btnCancel(const aCtx: TtfwContext;
    aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtButton;
    {* Реализация слова скрипта .Ten_TurnOnTimeMachine.btnCancel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnTurnOnTimeMachineBtnCancel

class function Tkw_Form_TurnOnTimeMachine.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::TurnOnTimeMachine';
end;//Tkw_Form_TurnOnTimeMachine.GetWordNameForRegister

function Tkw_Form_TurnOnTimeMachine.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_967CB34C707C_var*
//#UC END# *4DDFD2EA0116_967CB34C707C_var*
begin
//#UC START# *4DDFD2EA0116_967CB34C707C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_967CB34C707C_impl*
end;//Tkw_Form_TurnOnTimeMachine.GetString

class function Tkw_TurnOnTimeMachine_Control_rb_totmOnDate.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rb_totmOnDate';
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnDate.GetWordNameForRegister

function Tkw_TurnOnTimeMachine_Control_rb_totmOnDate.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_893BC6387739_var*
//#UC END# *4DDFD2EA0116_893BC6387739_var*
begin
//#UC START# *4DDFD2EA0116_893BC6387739_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_893BC6387739_impl*
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnDate.GetString

class procedure Tkw_TurnOnTimeMachine_Control_rb_totmOnDate.RegisterInEngine;
//#UC START# *52A086150180_893BC6387739_var*
//#UC END# *52A086150180_893BC6387739_var*
begin
//#UC START# *52A086150180_893BC6387739_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_893BC6387739_impl*
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnDate.RegisterInEngine

procedure Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CFCC6EBD4298_var*
//#UC END# *4DAEEDE10285_CFCC6EBD4298_var*
begin
//#UC START# *4DAEEDE10285_CFCC6EBD4298_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CFCC6EBD4298_impl*
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push.DoDoIt

class function Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rb_totmOnDate:push';
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push.GetWordNameForRegister

class function Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rb_totmOnCurrentRedation';
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation.GetWordNameForRegister

function Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2A0774CE123E_var*
//#UC END# *4DDFD2EA0116_2A0774CE123E_var*
begin
//#UC START# *4DDFD2EA0116_2A0774CE123E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2A0774CE123E_impl*
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation.GetString

class procedure Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation.RegisterInEngine;
//#UC START# *52A086150180_2A0774CE123E_var*
//#UC END# *52A086150180_2A0774CE123E_var*
begin
//#UC START# *52A086150180_2A0774CE123E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_2A0774CE123E_impl*
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation.RegisterInEngine

procedure Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_723237D81DCB_var*
//#UC END# *4DAEEDE10285_723237D81DCB_var*
begin
//#UC START# *4DAEEDE10285_723237D81DCB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_723237D81DCB_impl*
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push.DoDoIt

class function Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rb_totmOnCurrentRedation:push';
end;//Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push.GetWordNameForRegister

class function Tkw_TurnOnTimeMachine_Control_deDate.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::deDate';
end;//Tkw_TurnOnTimeMachine_Control_deDate.GetWordNameForRegister

function Tkw_TurnOnTimeMachine_Control_deDate.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_6B28BDA682B1_var*
//#UC END# *4DDFD2EA0116_6B28BDA682B1_var*
begin
//#UC START# *4DDFD2EA0116_6B28BDA682B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_6B28BDA682B1_impl*
end;//Tkw_TurnOnTimeMachine_Control_deDate.GetString

class procedure Tkw_TurnOnTimeMachine_Control_deDate.RegisterInEngine;
//#UC START# *52A086150180_6B28BDA682B1_var*
//#UC END# *52A086150180_6B28BDA682B1_var*
begin
//#UC START# *52A086150180_6B28BDA682B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_6B28BDA682B1_impl*
end;//Tkw_TurnOnTimeMachine_Control_deDate.RegisterInEngine

procedure Tkw_TurnOnTimeMachine_Control_deDate_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3186ABAE2AA9_var*
//#UC END# *4DAEEDE10285_3186ABAE2AA9_var*
begin
//#UC START# *4DAEEDE10285_3186ABAE2AA9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3186ABAE2AA9_impl*
end;//Tkw_TurnOnTimeMachine_Control_deDate_Push.DoDoIt

class function Tkw_TurnOnTimeMachine_Control_deDate_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::deDate:push';
end;//Tkw_TurnOnTimeMachine_Control_deDate_Push.GetWordNameForRegister

class function Tkw_TurnOnTimeMachine_Control_pbDialogIcon.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbDialogIcon';
end;//Tkw_TurnOnTimeMachine_Control_pbDialogIcon.GetWordNameForRegister

function Tkw_TurnOnTimeMachine_Control_pbDialogIcon.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_FD7F9843981F_var*
//#UC END# *4DDFD2EA0116_FD7F9843981F_var*
begin
//#UC START# *4DDFD2EA0116_FD7F9843981F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_FD7F9843981F_impl*
end;//Tkw_TurnOnTimeMachine_Control_pbDialogIcon.GetString

class procedure Tkw_TurnOnTimeMachine_Control_pbDialogIcon.RegisterInEngine;
//#UC START# *52A086150180_FD7F9843981F_var*
//#UC END# *52A086150180_FD7F9843981F_var*
begin
//#UC START# *52A086150180_FD7F9843981F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_FD7F9843981F_impl*
end;//Tkw_TurnOnTimeMachine_Control_pbDialogIcon.RegisterInEngine

procedure Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_33CAA65DF7D1_var*
//#UC END# *4DAEEDE10285_33CAA65DF7D1_var*
begin
//#UC START# *4DAEEDE10285_33CAA65DF7D1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_33CAA65DF7D1_impl*
end;//Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push.DoDoIt

class function Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbDialogIcon:push';
end;//Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push.GetWordNameForRegister

class function Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblTurnOnTimeMachineInfo';
end;//Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo.GetWordNameForRegister

function Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_AFC9E630D2DC_var*
//#UC END# *4DDFD2EA0116_AFC9E630D2DC_var*
begin
//#UC START# *4DDFD2EA0116_AFC9E630D2DC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_AFC9E630D2DC_impl*
end;//Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo.GetString

class procedure Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo.RegisterInEngine;
//#UC START# *52A086150180_AFC9E630D2DC_var*
//#UC END# *52A086150180_AFC9E630D2DC_var*
begin
//#UC START# *52A086150180_AFC9E630D2DC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_AFC9E630D2DC_impl*
end;//Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo.RegisterInEngine

procedure Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6090FF1AC866_var*
//#UC END# *4DAEEDE10285_6090FF1AC866_var*
begin
//#UC START# *4DAEEDE10285_6090FF1AC866_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6090FF1AC866_impl*
end;//Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.DoDoIt

class function Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblTurnOnTimeMachineInfo:push';
end;//Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.GetWordNameForRegister

class function Tkw_TurnOnTimeMachine_Control_btnOk.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnOk';
end;//Tkw_TurnOnTimeMachine_Control_btnOk.GetWordNameForRegister

function Tkw_TurnOnTimeMachine_Control_btnOk.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C61CBC097283_var*
//#UC END# *4DDFD2EA0116_C61CBC097283_var*
begin
//#UC START# *4DDFD2EA0116_C61CBC097283_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C61CBC097283_impl*
end;//Tkw_TurnOnTimeMachine_Control_btnOk.GetString

class procedure Tkw_TurnOnTimeMachine_Control_btnOk.RegisterInEngine;
//#UC START# *52A086150180_C61CBC097283_var*
//#UC END# *52A086150180_C61CBC097283_var*
begin
//#UC START# *52A086150180_C61CBC097283_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_C61CBC097283_impl*
end;//Tkw_TurnOnTimeMachine_Control_btnOk.RegisterInEngine

procedure Tkw_TurnOnTimeMachine_Control_btnOk_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_31C7F4871998_var*
//#UC END# *4DAEEDE10285_31C7F4871998_var*
begin
//#UC START# *4DAEEDE10285_31C7F4871998_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_31C7F4871998_impl*
end;//Tkw_TurnOnTimeMachine_Control_btnOk_Push.DoDoIt

class function Tkw_TurnOnTimeMachine_Control_btnOk_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnOk:push';
end;//Tkw_TurnOnTimeMachine_Control_btnOk_Push.GetWordNameForRegister

class function Tkw_TurnOnTimeMachine_Control_btnCancel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnCancel';
end;//Tkw_TurnOnTimeMachine_Control_btnCancel.GetWordNameForRegister

function Tkw_TurnOnTimeMachine_Control_btnCancel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_A0B1AFDB49C3_var*
//#UC END# *4DDFD2EA0116_A0B1AFDB49C3_var*
begin
//#UC START# *4DDFD2EA0116_A0B1AFDB49C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_A0B1AFDB49C3_impl*
end;//Tkw_TurnOnTimeMachine_Control_btnCancel.GetString

class procedure Tkw_TurnOnTimeMachine_Control_btnCancel.RegisterInEngine;
//#UC START# *52A086150180_A0B1AFDB49C3_var*
//#UC END# *52A086150180_A0B1AFDB49C3_var*
begin
//#UC START# *52A086150180_A0B1AFDB49C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_A0B1AFDB49C3_impl*
end;//Tkw_TurnOnTimeMachine_Control_btnCancel.RegisterInEngine

procedure Tkw_TurnOnTimeMachine_Control_btnCancel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_477582858D4D_var*
//#UC END# *4DAEEDE10285_477582858D4D_var*
begin
//#UC START# *4DAEEDE10285_477582858D4D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_477582858D4D_impl*
end;//Tkw_TurnOnTimeMachine_Control_btnCancel_Push.DoDoIt

class function Tkw_TurnOnTimeMachine_Control_btnCancel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnCancel:push';
end;//Tkw_TurnOnTimeMachine_Control_btnCancel_Push.GetWordNameForRegister

function TkwEnTurnOnTimeMachineRbTotmOnDate.rb_totmOnDate(const aCtx: TtfwContext;
 aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtRadioButton;
 {* Реализация слова скрипта .Ten_TurnOnTimeMachine.rb_totmOnDate }
//#UC START# *C52210223D9B_738D30BFC216_var*
//#UC END# *C52210223D9B_738D30BFC216_var*
begin
//#UC START# *C52210223D9B_738D30BFC216_impl*
 !!! Needs to be implemented !!!
//#UC END# *C52210223D9B_738D30BFC216_impl*
end;//TkwEnTurnOnTimeMachineRbTotmOnDate.rb_totmOnDate

procedure TkwEnTurnOnTimeMachineRbTotmOnDate.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_738D30BFC216_var*
//#UC END# *4DAEEDE10285_738D30BFC216_var*
begin
//#UC START# *4DAEEDE10285_738D30BFC216_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_738D30BFC216_impl*
end;//TkwEnTurnOnTimeMachineRbTotmOnDate.DoDoIt

class function TkwEnTurnOnTimeMachineRbTotmOnDate.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOnTimeMachine.rb_totmOnDate';
end;//TkwEnTurnOnTimeMachineRbTotmOnDate.GetWordNameForRegister

procedure TkwEnTurnOnTimeMachineRbTotmOnDate.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_: ;
begin
end;//TkwEnTurnOnTimeMachineRbTotmOnDate.SetValuePrim

function TkwEnTurnOnTimeMachineRbTotmOnDate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnTurnOnTimeMachineRbTotmOnDate.GetResultTypeInfo

function TkwEnTurnOnTimeMachineRbTotmOnDate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOnTimeMachineRbTotmOnDate.GetAllParamsCount

function TkwEnTurnOnTimeMachineRbTotmOnDate.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnTurnOnTimeMachineRbTotmOnDate.ParamsTypes

function TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.rb_totmOnCurrentRedation(const aCtx: TtfwContext;
 aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtRadioButton;
 {* Реализация слова скрипта .Ten_TurnOnTimeMachine.rb_totmOnCurrentRedation }
//#UC START# *A397D716C9EB_410A0E5236E8_var*
//#UC END# *A397D716C9EB_410A0E5236E8_var*
begin
//#UC START# *A397D716C9EB_410A0E5236E8_impl*
 !!! Needs to be implemented !!!
//#UC END# *A397D716C9EB_410A0E5236E8_impl*
end;//TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.rb_totmOnCurrentRedation

procedure TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_410A0E5236E8_var*
//#UC END# *4DAEEDE10285_410A0E5236E8_var*
begin
//#UC START# *4DAEEDE10285_410A0E5236E8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_410A0E5236E8_impl*
end;//TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.DoDoIt

class function TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOnTimeMachine.rb_totmOnCurrentRedation';
end;//TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.GetWordNameForRegister

procedure TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_: ;
begin
end;//TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.SetValuePrim

function TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.GetResultTypeInfo

function TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.GetAllParamsCount

function TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.ParamsTypes

function TkwEnTurnOnTimeMachineDeDate.deDate(const aCtx: TtfwContext;
 aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtDblClickDateEdit;
 {* Реализация слова скрипта .Ten_TurnOnTimeMachine.deDate }
//#UC START# *23E6BEC283DC_34CF83AB09E2_var*
//#UC END# *23E6BEC283DC_34CF83AB09E2_var*
begin
//#UC START# *23E6BEC283DC_34CF83AB09E2_impl*
 !!! Needs to be implemented !!!
//#UC END# *23E6BEC283DC_34CF83AB09E2_impl*
end;//TkwEnTurnOnTimeMachineDeDate.deDate

procedure TkwEnTurnOnTimeMachineDeDate.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_34CF83AB09E2_var*
//#UC END# *4DAEEDE10285_34CF83AB09E2_var*
begin
//#UC START# *4DAEEDE10285_34CF83AB09E2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_34CF83AB09E2_impl*
end;//TkwEnTurnOnTimeMachineDeDate.DoDoIt

class function TkwEnTurnOnTimeMachineDeDate.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOnTimeMachine.deDate';
end;//TkwEnTurnOnTimeMachineDeDate.GetWordNameForRegister

procedure TkwEnTurnOnTimeMachineDeDate.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_: ;
begin
end;//TkwEnTurnOnTimeMachineDeDate.SetValuePrim

function TkwEnTurnOnTimeMachineDeDate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtDblClickDateEdit);
end;//TkwEnTurnOnTimeMachineDeDate.GetResultTypeInfo

function TkwEnTurnOnTimeMachineDeDate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOnTimeMachineDeDate.GetAllParamsCount

function TkwEnTurnOnTimeMachineDeDate.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnTurnOnTimeMachineDeDate.ParamsTypes

function TkwEnTurnOnTimeMachinePbDialogIcon.pbDialogIcon(const aCtx: TtfwContext;
 aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TPaintBox;
 {* Реализация слова скрипта .Ten_TurnOnTimeMachine.pbDialogIcon }
//#UC START# *560E6C43DAEA_D77A7DA792C7_var*
//#UC END# *560E6C43DAEA_D77A7DA792C7_var*
begin
//#UC START# *560E6C43DAEA_D77A7DA792C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *560E6C43DAEA_D77A7DA792C7_impl*
end;//TkwEnTurnOnTimeMachinePbDialogIcon.pbDialogIcon

procedure TkwEnTurnOnTimeMachinePbDialogIcon.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D77A7DA792C7_var*
//#UC END# *4DAEEDE10285_D77A7DA792C7_var*
begin
//#UC START# *4DAEEDE10285_D77A7DA792C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D77A7DA792C7_impl*
end;//TkwEnTurnOnTimeMachinePbDialogIcon.DoDoIt

class function TkwEnTurnOnTimeMachinePbDialogIcon.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOnTimeMachine.pbDialogIcon';
end;//TkwEnTurnOnTimeMachinePbDialogIcon.GetWordNameForRegister

procedure TkwEnTurnOnTimeMachinePbDialogIcon.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_: ;
begin
end;//TkwEnTurnOnTimeMachinePbDialogIcon.SetValuePrim

function TkwEnTurnOnTimeMachinePbDialogIcon.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEnTurnOnTimeMachinePbDialogIcon.GetResultTypeInfo

function TkwEnTurnOnTimeMachinePbDialogIcon.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOnTimeMachinePbDialogIcon.GetAllParamsCount

function TkwEnTurnOnTimeMachinePbDialogIcon.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnTurnOnTimeMachinePbDialogIcon.ParamsTypes

function TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.lblTurnOnTimeMachineInfo(const aCtx: TtfwContext;
 aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtLabel;
 {* Реализация слова скрипта .Ten_TurnOnTimeMachine.lblTurnOnTimeMachineInfo }
//#UC START# *18664E7965BC_47E2676FB408_var*
//#UC END# *18664E7965BC_47E2676FB408_var*
begin
//#UC START# *18664E7965BC_47E2676FB408_impl*
 !!! Needs to be implemented !!!
//#UC END# *18664E7965BC_47E2676FB408_impl*
end;//TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.lblTurnOnTimeMachineInfo

procedure TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_47E2676FB408_var*
//#UC END# *4DAEEDE10285_47E2676FB408_var*
begin
//#UC START# *4DAEEDE10285_47E2676FB408_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_47E2676FB408_impl*
end;//TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.DoDoIt

class function TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOnTimeMachine.lblTurnOnTimeMachineInfo';
end;//TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.GetWordNameForRegister

procedure TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_: ;
begin
end;//TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.SetValuePrim

function TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.GetResultTypeInfo

function TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.GetAllParamsCount

function TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.ParamsTypes

function TkwEnTurnOnTimeMachineBtnOk.btnOk(const aCtx: TtfwContext;
 aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtButton;
 {* Реализация слова скрипта .Ten_TurnOnTimeMachine.btnOk }
//#UC START# *B11DF7087FAE_E6A646BF492A_var*
//#UC END# *B11DF7087FAE_E6A646BF492A_var*
begin
//#UC START# *B11DF7087FAE_E6A646BF492A_impl*
 !!! Needs to be implemented !!!
//#UC END# *B11DF7087FAE_E6A646BF492A_impl*
end;//TkwEnTurnOnTimeMachineBtnOk.btnOk

procedure TkwEnTurnOnTimeMachineBtnOk.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E6A646BF492A_var*
//#UC END# *4DAEEDE10285_E6A646BF492A_var*
begin
//#UC START# *4DAEEDE10285_E6A646BF492A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E6A646BF492A_impl*
end;//TkwEnTurnOnTimeMachineBtnOk.DoDoIt

class function TkwEnTurnOnTimeMachineBtnOk.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOnTimeMachine.btnOk';
end;//TkwEnTurnOnTimeMachineBtnOk.GetWordNameForRegister

procedure TkwEnTurnOnTimeMachineBtnOk.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_: ;
begin
end;//TkwEnTurnOnTimeMachineBtnOk.SetValuePrim

function TkwEnTurnOnTimeMachineBtnOk.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtButton);
end;//TkwEnTurnOnTimeMachineBtnOk.GetResultTypeInfo

function TkwEnTurnOnTimeMachineBtnOk.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOnTimeMachineBtnOk.GetAllParamsCount

function TkwEnTurnOnTimeMachineBtnOk.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnTurnOnTimeMachineBtnOk.ParamsTypes

function TkwEnTurnOnTimeMachineBtnCancel.btnCancel(const aCtx: TtfwContext;
 aen_TurnOnTimeMachine: Ten_TurnOnTimeMachine): TvtButton;
 {* Реализация слова скрипта .Ten_TurnOnTimeMachine.btnCancel }
//#UC START# *9B55E9293AEE_FEC8921670AD_var*
//#UC END# *9B55E9293AEE_FEC8921670AD_var*
begin
//#UC START# *9B55E9293AEE_FEC8921670AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *9B55E9293AEE_FEC8921670AD_impl*
end;//TkwEnTurnOnTimeMachineBtnCancel.btnCancel

procedure TkwEnTurnOnTimeMachineBtnCancel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FEC8921670AD_var*
//#UC END# *4DAEEDE10285_FEC8921670AD_var*
begin
//#UC START# *4DAEEDE10285_FEC8921670AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FEC8921670AD_impl*
end;//TkwEnTurnOnTimeMachineBtnCancel.DoDoIt

class function TkwEnTurnOnTimeMachineBtnCancel.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOnTimeMachine.btnCancel';
end;//TkwEnTurnOnTimeMachineBtnCancel.GetWordNameForRegister

procedure TkwEnTurnOnTimeMachineBtnCancel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_: ;
begin
end;//TkwEnTurnOnTimeMachineBtnCancel.SetValuePrim

function TkwEnTurnOnTimeMachineBtnCancel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtButton);
end;//TkwEnTurnOnTimeMachineBtnCancel.GetResultTypeInfo

function TkwEnTurnOnTimeMachineBtnCancel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOnTimeMachineBtnCancel.GetAllParamsCount

function TkwEnTurnOnTimeMachineBtnCancel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnTurnOnTimeMachineBtnCancel.ParamsTypes

initialization
 Tkw_Form_TurnOnTimeMachine.RegisterInEngine;
 {* Регистрация Tkw_Form_TurnOnTimeMachine }
 Tkw_TurnOnTimeMachine_Control_rb_totmOnDate.RegisterInEngine;
 {* Регистрация Tkw_TurnOnTimeMachine_Control_rb_totmOnDate }
 Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push.RegisterInEngine;
 {* Регистрация Tkw_TurnOnTimeMachine_Control_rb_totmOnDate_Push }
 Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation.RegisterInEngine;
 {* Регистрация Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation }
 Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push.RegisterInEngine;
 {* Регистрация Tkw_TurnOnTimeMachine_Control_rb_totmOnCurrentRedation_Push }
 Tkw_TurnOnTimeMachine_Control_deDate.RegisterInEngine;
 {* Регистрация Tkw_TurnOnTimeMachine_Control_deDate }
 Tkw_TurnOnTimeMachine_Control_deDate_Push.RegisterInEngine;
 {* Регистрация Tkw_TurnOnTimeMachine_Control_deDate_Push }
 Tkw_TurnOnTimeMachine_Control_pbDialogIcon.RegisterInEngine;
 {* Регистрация Tkw_TurnOnTimeMachine_Control_pbDialogIcon }
 Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push.RegisterInEngine;
 {* Регистрация Tkw_TurnOnTimeMachine_Control_pbDialogIcon_Push }
 Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo.RegisterInEngine;
 {* Регистрация Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo }
 Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.RegisterInEngine;
 {* Регистрация Tkw_TurnOnTimeMachine_Control_lblTurnOnTimeMachineInfo_Push }
 Tkw_TurnOnTimeMachine_Control_btnOk.RegisterInEngine;
 {* Регистрация Tkw_TurnOnTimeMachine_Control_btnOk }
 Tkw_TurnOnTimeMachine_Control_btnOk_Push.RegisterInEngine;
 {* Регистрация Tkw_TurnOnTimeMachine_Control_btnOk_Push }
 Tkw_TurnOnTimeMachine_Control_btnCancel.RegisterInEngine;
 {* Регистрация Tkw_TurnOnTimeMachine_Control_btnCancel }
 Tkw_TurnOnTimeMachine_Control_btnCancel_Push.RegisterInEngine;
 {* Регистрация Tkw_TurnOnTimeMachine_Control_btnCancel_Push }
 TkwEnTurnOnTimeMachineRbTotmOnDate.RegisterInEngine;
 {* Регистрация en_TurnOnTimeMachine_rb_totmOnDate }
 TkwEnTurnOnTimeMachineRbTotmOnCurrentRedation.RegisterInEngine;
 {* Регистрация en_TurnOnTimeMachine_rb_totmOnCurrentRedation }
 TkwEnTurnOnTimeMachineDeDate.RegisterInEngine;
 {* Регистрация en_TurnOnTimeMachine_deDate }
 TkwEnTurnOnTimeMachinePbDialogIcon.RegisterInEngine;
 {* Регистрация en_TurnOnTimeMachine_pbDialogIcon }
 TkwEnTurnOnTimeMachineLblTurnOnTimeMachineInfo.RegisterInEngine;
 {* Регистрация en_TurnOnTimeMachine_lblTurnOnTimeMachineInfo }
 TkwEnTurnOnTimeMachineBtnOk.RegisterInEngine;
 {* Регистрация en_TurnOnTimeMachine_btnOk }
 TkwEnTurnOnTimeMachineBtnCancel.RegisterInEngine;
 {* Регистрация en_TurnOnTimeMachine_btnCancel }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_TurnOnTimeMachine));
 {* Регистрация типа TurnOnTimeMachine }
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

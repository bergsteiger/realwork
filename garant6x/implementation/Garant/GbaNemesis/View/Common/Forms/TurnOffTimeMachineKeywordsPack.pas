unit TurnOffTimeMachineKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы TurnOffTimeMachine }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\TurnOffTimeMachineKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "TurnOffTimeMachineKeywordsPack" MUID: (4AB135AC01DE_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , TurnOffTimeMachine_Form
 , tfwPropertyLike
 , vtRadioButton
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , vtDblClickDateEdit
 , ExtCtrls
 , vtLabel
 , vtButton
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwEnTurnOffTimeMachineRbTotmChangeDate = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_TurnOffTimeMachine.rb_totmChangeDate }
  private
   function rb_totmChangeDate(const aCtx: TtfwContext;
    aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtRadioButton;
    {* Реализация слова скрипта .Ten_TurnOffTimeMachine.rb_totmChangeDate }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnTurnOffTimeMachineRbTotmChangeDate

 TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_TurnOffTimeMachine.rb_totmStayInCurrentRedaction }
  private
   function rb_totmStayInCurrentRedaction(const aCtx: TtfwContext;
    aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtRadioButton;
    {* Реализация слова скрипта .Ten_TurnOffTimeMachine.rb_totmStayInCurrentRedaction }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction

 TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_TurnOffTimeMachine.rb_totmGotoActualRedaction }
  private
   function rb_totmGotoActualRedaction(const aCtx: TtfwContext;
    aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtRadioButton;
    {* Реализация слова скрипта .Ten_TurnOffTimeMachine.rb_totmGotoActualRedaction }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction

 TkwEnTurnOffTimeMachineDeChangeDate = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_TurnOffTimeMachine.deChangeDate }
  private
   function deChangeDate(const aCtx: TtfwContext;
    aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtDblClickDateEdit;
    {* Реализация слова скрипта .Ten_TurnOffTimeMachine.deChangeDate }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnTurnOffTimeMachineDeChangeDate

 TkwEnTurnOffTimeMachinePbDialogIcon = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_TurnOffTimeMachine.pbDialogIcon }
  private
   function pbDialogIcon(const aCtx: TtfwContext;
    aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TPaintBox;
    {* Реализация слова скрипта .Ten_TurnOffTimeMachine.pbDialogIcon }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnTurnOffTimeMachinePbDialogIcon

 TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_TurnOffTimeMachine.lblTurnOnTimeMachineInfo }
  private
   function lblTurnOnTimeMachineInfo(const aCtx: TtfwContext;
    aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtLabel;
    {* Реализация слова скрипта .Ten_TurnOffTimeMachine.lblTurnOnTimeMachineInfo }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo

 TkwEnTurnOffTimeMachineBtnOk = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_TurnOffTimeMachine.btnOk }
  private
   function btnOk(const aCtx: TtfwContext;
    aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtButton;
    {* Реализация слова скрипта .Ten_TurnOffTimeMachine.btnOk }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnTurnOffTimeMachineBtnOk

 TkwEnTurnOffTimeMachineBtnCancel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_TurnOffTimeMachine.btnCancel }
  private
   function btnCancel(const aCtx: TtfwContext;
    aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtButton;
    {* Реализация слова скрипта .Ten_TurnOffTimeMachine.btnCancel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnTurnOffTimeMachineBtnCancel

 Tkw_Form_TurnOffTimeMachine = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы TurnOffTimeMachine
----
*Пример использования*:
[code]форма::TurnOffTimeMachine TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_TurnOffTimeMachine

 Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола rb_totmChangeDate
----
*Пример использования*:
[code]контрол::rb_totmChangeDate TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate

 Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола rb_totmChangeDate
----
*Пример использования*:
[code]контрол::rb_totmChangeDate:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push

 Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола rb_totmStayInCurrentRedaction
----
*Пример использования*:
[code]контрол::rb_totmStayInCurrentRedaction TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction

 Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола rb_totmStayInCurrentRedaction
----
*Пример использования*:
[code]контрол::rb_totmStayInCurrentRedaction:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push

 Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола rb_totmGotoActualRedaction
----
*Пример использования*:
[code]контрол::rb_totmGotoActualRedaction TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction

 Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола rb_totmGotoActualRedaction
----
*Пример использования*:
[code]контрол::rb_totmGotoActualRedaction:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push

 Tkw_TurnOffTimeMachine_Control_deChangeDate = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола deChangeDate
----
*Пример использования*:
[code]контрол::deChangeDate TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_deChangeDate

 Tkw_TurnOffTimeMachine_Control_deChangeDate_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола deChangeDate
----
*Пример использования*:
[code]контрол::deChangeDate:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_deChangeDate_Push

 Tkw_TurnOffTimeMachine_Control_pbDialogIcon = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pbDialogIcon
----
*Пример использования*:
[code]контрол::pbDialogIcon TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon

 Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pbDialogIcon
----
*Пример использования*:
[code]контрол::pbDialogIcon:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push

 Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblTurnOnTimeMachineInfo
----
*Пример использования*:
[code]контрол::lblTurnOnTimeMachineInfo TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo

 Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lblTurnOnTimeMachineInfo
----
*Пример использования*:
[code]контрол::lblTurnOnTimeMachineInfo:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push

 Tkw_TurnOffTimeMachine_Control_btnOk = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnOk
----
*Пример использования*:
[code]контрол::btnOk TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_btnOk

 Tkw_TurnOffTimeMachine_Control_btnOk_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола btnOk
----
*Пример использования*:
[code]контрол::btnOk:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_btnOk_Push

 Tkw_TurnOffTimeMachine_Control_btnCancel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnCancel
----
*Пример использования*:
[code]контрол::btnCancel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_btnCancel

 Tkw_TurnOffTimeMachine_Control_btnCancel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола btnCancel
----
*Пример использования*:
[code]контрол::btnCancel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TurnOffTimeMachine_Control_btnCancel_Push

function TkwEnTurnOffTimeMachineRbTotmChangeDate.rb_totmChangeDate(const aCtx: TtfwContext;
 aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtRadioButton;
 {* Реализация слова скрипта .Ten_TurnOffTimeMachine.rb_totmChangeDate }
begin
 Result := aen_TurnOffTimeMachine.rb_totmChangeDate;
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.rb_totmChangeDate

class function TkwEnTurnOffTimeMachineRbTotmChangeDate.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOffTimeMachine.rb_totmChangeDate';
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.GetWordNameForRegister

function TkwEnTurnOffTimeMachineRbTotmChangeDate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.GetResultTypeInfo

function TkwEnTurnOffTimeMachineRbTotmChangeDate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.GetAllParamsCount

function TkwEnTurnOffTimeMachineRbTotmChangeDate.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOffTimeMachine)]);
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.ParamsTypes

procedure TkwEnTurnOffTimeMachineRbTotmChangeDate.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству rb_totmChangeDate', aCtx);
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.SetValuePrim

procedure TkwEnTurnOffTimeMachineRbTotmChangeDate.DoDoIt(const aCtx: TtfwContext);
var l_aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine;
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
 aCtx.rEngine.PushObj(rb_totmChangeDate(aCtx, l_aen_TurnOffTimeMachine));
end;//TkwEnTurnOffTimeMachineRbTotmChangeDate.DoDoIt

function TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.rb_totmStayInCurrentRedaction(const aCtx: TtfwContext;
 aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtRadioButton;
 {* Реализация слова скрипта .Ten_TurnOffTimeMachine.rb_totmStayInCurrentRedaction }
begin
 Result := aen_TurnOffTimeMachine.rb_totmStayInCurrentRedaction;
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.rb_totmStayInCurrentRedaction

class function TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOffTimeMachine.rb_totmStayInCurrentRedaction';
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.GetWordNameForRegister

function TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.GetResultTypeInfo

function TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.GetAllParamsCount

function TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOffTimeMachine)]);
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.ParamsTypes

procedure TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству rb_totmStayInCurrentRedaction', aCtx);
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.SetValuePrim

procedure TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.DoDoIt(const aCtx: TtfwContext);
var l_aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine;
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
 aCtx.rEngine.PushObj(rb_totmStayInCurrentRedaction(aCtx, l_aen_TurnOffTimeMachine));
end;//TkwEnTurnOffTimeMachineRbTotmStayInCurrentRedaction.DoDoIt

function TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.rb_totmGotoActualRedaction(const aCtx: TtfwContext;
 aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtRadioButton;
 {* Реализация слова скрипта .Ten_TurnOffTimeMachine.rb_totmGotoActualRedaction }
begin
 Result := aen_TurnOffTimeMachine.rb_totmGotoActualRedaction;
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.rb_totmGotoActualRedaction

class function TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOffTimeMachine.rb_totmGotoActualRedaction';
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.GetWordNameForRegister

function TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.GetResultTypeInfo

function TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.GetAllParamsCount

function TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOffTimeMachine)]);
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.ParamsTypes

procedure TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству rb_totmGotoActualRedaction', aCtx);
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.SetValuePrim

procedure TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.DoDoIt(const aCtx: TtfwContext);
var l_aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine;
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
 aCtx.rEngine.PushObj(rb_totmGotoActualRedaction(aCtx, l_aen_TurnOffTimeMachine));
end;//TkwEnTurnOffTimeMachineRbTotmGotoActualRedaction.DoDoIt

function TkwEnTurnOffTimeMachineDeChangeDate.deChangeDate(const aCtx: TtfwContext;
 aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtDblClickDateEdit;
 {* Реализация слова скрипта .Ten_TurnOffTimeMachine.deChangeDate }
begin
 Result := aen_TurnOffTimeMachine.deChangeDate;
end;//TkwEnTurnOffTimeMachineDeChangeDate.deChangeDate

class function TkwEnTurnOffTimeMachineDeChangeDate.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOffTimeMachine.deChangeDate';
end;//TkwEnTurnOffTimeMachineDeChangeDate.GetWordNameForRegister

function TkwEnTurnOffTimeMachineDeChangeDate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtDblClickDateEdit);
end;//TkwEnTurnOffTimeMachineDeChangeDate.GetResultTypeInfo

function TkwEnTurnOffTimeMachineDeChangeDate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOffTimeMachineDeChangeDate.GetAllParamsCount

function TkwEnTurnOffTimeMachineDeChangeDate.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOffTimeMachine)]);
end;//TkwEnTurnOffTimeMachineDeChangeDate.ParamsTypes

procedure TkwEnTurnOffTimeMachineDeChangeDate.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству deChangeDate', aCtx);
end;//TkwEnTurnOffTimeMachineDeChangeDate.SetValuePrim

procedure TkwEnTurnOffTimeMachineDeChangeDate.DoDoIt(const aCtx: TtfwContext);
var l_aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine;
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
 aCtx.rEngine.PushObj(deChangeDate(aCtx, l_aen_TurnOffTimeMachine));
end;//TkwEnTurnOffTimeMachineDeChangeDate.DoDoIt

function TkwEnTurnOffTimeMachinePbDialogIcon.pbDialogIcon(const aCtx: TtfwContext;
 aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TPaintBox;
 {* Реализация слова скрипта .Ten_TurnOffTimeMachine.pbDialogIcon }
begin
 Result := aen_TurnOffTimeMachine.pbDialogIcon;
end;//TkwEnTurnOffTimeMachinePbDialogIcon.pbDialogIcon

class function TkwEnTurnOffTimeMachinePbDialogIcon.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOffTimeMachine.pbDialogIcon';
end;//TkwEnTurnOffTimeMachinePbDialogIcon.GetWordNameForRegister

function TkwEnTurnOffTimeMachinePbDialogIcon.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEnTurnOffTimeMachinePbDialogIcon.GetResultTypeInfo

function TkwEnTurnOffTimeMachinePbDialogIcon.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOffTimeMachinePbDialogIcon.GetAllParamsCount

function TkwEnTurnOffTimeMachinePbDialogIcon.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOffTimeMachine)]);
end;//TkwEnTurnOffTimeMachinePbDialogIcon.ParamsTypes

procedure TkwEnTurnOffTimeMachinePbDialogIcon.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pbDialogIcon', aCtx);
end;//TkwEnTurnOffTimeMachinePbDialogIcon.SetValuePrim

procedure TkwEnTurnOffTimeMachinePbDialogIcon.DoDoIt(const aCtx: TtfwContext);
var l_aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine;
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
 aCtx.rEngine.PushObj(pbDialogIcon(aCtx, l_aen_TurnOffTimeMachine));
end;//TkwEnTurnOffTimeMachinePbDialogIcon.DoDoIt

function TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.lblTurnOnTimeMachineInfo(const aCtx: TtfwContext;
 aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtLabel;
 {* Реализация слова скрипта .Ten_TurnOffTimeMachine.lblTurnOnTimeMachineInfo }
begin
 Result := aen_TurnOffTimeMachine.lblTurnOnTimeMachineInfo;
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.lblTurnOnTimeMachineInfo

class function TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOffTimeMachine.lblTurnOnTimeMachineInfo';
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.GetWordNameForRegister

function TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.GetResultTypeInfo

function TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.GetAllParamsCount

function TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOffTimeMachine)]);
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.ParamsTypes

procedure TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblTurnOnTimeMachineInfo', aCtx);
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.SetValuePrim

procedure TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.DoDoIt(const aCtx: TtfwContext);
var l_aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine;
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
 aCtx.rEngine.PushObj(lblTurnOnTimeMachineInfo(aCtx, l_aen_TurnOffTimeMachine));
end;//TkwEnTurnOffTimeMachineLblTurnOnTimeMachineInfo.DoDoIt

function TkwEnTurnOffTimeMachineBtnOk.btnOk(const aCtx: TtfwContext;
 aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtButton;
 {* Реализация слова скрипта .Ten_TurnOffTimeMachine.btnOk }
begin
 Result := aen_TurnOffTimeMachine.btnOk;
end;//TkwEnTurnOffTimeMachineBtnOk.btnOk

class function TkwEnTurnOffTimeMachineBtnOk.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOffTimeMachine.btnOk';
end;//TkwEnTurnOffTimeMachineBtnOk.GetWordNameForRegister

function TkwEnTurnOffTimeMachineBtnOk.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtButton);
end;//TkwEnTurnOffTimeMachineBtnOk.GetResultTypeInfo

function TkwEnTurnOffTimeMachineBtnOk.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOffTimeMachineBtnOk.GetAllParamsCount

function TkwEnTurnOffTimeMachineBtnOk.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOffTimeMachine)]);
end;//TkwEnTurnOffTimeMachineBtnOk.ParamsTypes

procedure TkwEnTurnOffTimeMachineBtnOk.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству btnOk', aCtx);
end;//TkwEnTurnOffTimeMachineBtnOk.SetValuePrim

procedure TkwEnTurnOffTimeMachineBtnOk.DoDoIt(const aCtx: TtfwContext);
var l_aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine;
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
 aCtx.rEngine.PushObj(btnOk(aCtx, l_aen_TurnOffTimeMachine));
end;//TkwEnTurnOffTimeMachineBtnOk.DoDoIt

function TkwEnTurnOffTimeMachineBtnCancel.btnCancel(const aCtx: TtfwContext;
 aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine): TvtButton;
 {* Реализация слова скрипта .Ten_TurnOffTimeMachine.btnCancel }
begin
 Result := aen_TurnOffTimeMachine.btnCancel;
end;//TkwEnTurnOffTimeMachineBtnCancel.btnCancel

class function TkwEnTurnOffTimeMachineBtnCancel.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_TurnOffTimeMachine.btnCancel';
end;//TkwEnTurnOffTimeMachineBtnCancel.GetWordNameForRegister

function TkwEnTurnOffTimeMachineBtnCancel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtButton);
end;//TkwEnTurnOffTimeMachineBtnCancel.GetResultTypeInfo

function TkwEnTurnOffTimeMachineBtnCancel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnTurnOffTimeMachineBtnCancel.GetAllParamsCount

function TkwEnTurnOffTimeMachineBtnCancel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_TurnOffTimeMachine)]);
end;//TkwEnTurnOffTimeMachineBtnCancel.ParamsTypes

procedure TkwEnTurnOffTimeMachineBtnCancel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству btnCancel', aCtx);
end;//TkwEnTurnOffTimeMachineBtnCancel.SetValuePrim

procedure TkwEnTurnOffTimeMachineBtnCancel.DoDoIt(const aCtx: TtfwContext);
var l_aen_TurnOffTimeMachine: Ten_TurnOffTimeMachine;
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
 aCtx.rEngine.PushObj(btnCancel(aCtx, l_aen_TurnOffTimeMachine));
end;//TkwEnTurnOffTimeMachineBtnCancel.DoDoIt

function Tkw_Form_TurnOffTimeMachine.GetString: AnsiString;
begin
 Result := 'en_TurnOffTimeMachine';
end;//Tkw_Form_TurnOffTimeMachine.GetString

class procedure Tkw_Form_TurnOffTimeMachine.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(Ten_TurnOffTimeMachine);
end;//Tkw_Form_TurnOffTimeMachine.RegisterInEngine

class function Tkw_Form_TurnOffTimeMachine.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::TurnOffTimeMachine';
end;//Tkw_Form_TurnOffTimeMachine.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.GetString: AnsiString;
begin
 Result := 'rb_totmChangeDate';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.GetString

class procedure Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.RegisterInEngine

class function Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rb_totmChangeDate';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate.GetWordNameForRegister

procedure Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('rb_totmChangeDate');
 inherited;
end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rb_totmChangeDate:push';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmChangeDate_Push.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.GetString: AnsiString;
begin
 Result := 'rb_totmStayInCurrentRedaction';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.GetString

class procedure Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.RegisterInEngine

class function Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rb_totmStayInCurrentRedaction';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction.GetWordNameForRegister

procedure Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('rb_totmStayInCurrentRedaction');
 inherited;
end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rb_totmStayInCurrentRedaction:push';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmStayInCurrentRedaction_Push.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.GetString: AnsiString;
begin
 Result := 'rb_totmGotoActualRedaction';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.GetString

class procedure Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.RegisterInEngine

class function Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rb_totmGotoActualRedaction';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction.GetWordNameForRegister

procedure Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('rb_totmGotoActualRedaction');
 inherited;
end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::rb_totmGotoActualRedaction:push';
end;//Tkw_TurnOffTimeMachine_Control_rb_totmGotoActualRedaction_Push.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_deChangeDate.GetString: AnsiString;
begin
 Result := 'deChangeDate';
end;//Tkw_TurnOffTimeMachine_Control_deChangeDate.GetString

class procedure Tkw_TurnOffTimeMachine_Control_deChangeDate.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtDblClickDateEdit);
end;//Tkw_TurnOffTimeMachine_Control_deChangeDate.RegisterInEngine

class function Tkw_TurnOffTimeMachine_Control_deChangeDate.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::deChangeDate';
end;//Tkw_TurnOffTimeMachine_Control_deChangeDate.GetWordNameForRegister

procedure Tkw_TurnOffTimeMachine_Control_deChangeDate_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('deChangeDate');
 inherited;
end;//Tkw_TurnOffTimeMachine_Control_deChangeDate_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_deChangeDate_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::deChangeDate:push';
end;//Tkw_TurnOffTimeMachine_Control_deChangeDate_Push.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_pbDialogIcon.GetString: AnsiString;
begin
 Result := 'pbDialogIcon';
end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon.GetString

class procedure Tkw_TurnOffTimeMachine_Control_pbDialogIcon.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon.RegisterInEngine

class function Tkw_TurnOffTimeMachine_Control_pbDialogIcon.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbDialogIcon';
end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon.GetWordNameForRegister

procedure Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pbDialogIcon');
 inherited;
end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbDialogIcon:push';
end;//Tkw_TurnOffTimeMachine_Control_pbDialogIcon_Push.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.GetString: AnsiString;
begin
 Result := 'lblTurnOnTimeMachineInfo';
end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.GetString

class procedure Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.RegisterInEngine

class function Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblTurnOnTimeMachineInfo';
end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo.GetWordNameForRegister

procedure Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblTurnOnTimeMachineInfo');
 inherited;
end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblTurnOnTimeMachineInfo:push';
end;//Tkw_TurnOffTimeMachine_Control_lblTurnOnTimeMachineInfo_Push.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_btnOk.GetString: AnsiString;
begin
 Result := 'btnOk';
end;//Tkw_TurnOffTimeMachine_Control_btnOk.GetString

class procedure Tkw_TurnOffTimeMachine_Control_btnOk.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
end;//Tkw_TurnOffTimeMachine_Control_btnOk.RegisterInEngine

class function Tkw_TurnOffTimeMachine_Control_btnOk.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnOk';
end;//Tkw_TurnOffTimeMachine_Control_btnOk.GetWordNameForRegister

procedure Tkw_TurnOffTimeMachine_Control_btnOk_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnOk');
 inherited;
end;//Tkw_TurnOffTimeMachine_Control_btnOk_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_btnOk_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnOk:push';
end;//Tkw_TurnOffTimeMachine_Control_btnOk_Push.GetWordNameForRegister

function Tkw_TurnOffTimeMachine_Control_btnCancel.GetString: AnsiString;
begin
 Result := 'btnCancel';
end;//Tkw_TurnOffTimeMachine_Control_btnCancel.GetString

class procedure Tkw_TurnOffTimeMachine_Control_btnCancel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
end;//Tkw_TurnOffTimeMachine_Control_btnCancel.RegisterInEngine

class function Tkw_TurnOffTimeMachine_Control_btnCancel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnCancel';
end;//Tkw_TurnOffTimeMachine_Control_btnCancel.GetWordNameForRegister

procedure Tkw_TurnOffTimeMachine_Control_btnCancel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnCancel');
 inherited;
end;//Tkw_TurnOffTimeMachine_Control_btnCancel_Push.DoDoIt

class function Tkw_TurnOffTimeMachine_Control_btnCancel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnCancel:push';
end;//Tkw_TurnOffTimeMachine_Control_btnCancel_Push.GetWordNameForRegister

initialization
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
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_TurnOffTimeMachine));
 {* Регистрация типа Ten_TurnOffTimeMachine }
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.

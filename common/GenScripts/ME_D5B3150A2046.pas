unit EditionsContainerKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы EditionsContainer }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\EditionsContainerKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , BaseEditions_Module
 , vtProportionalPanel
 , vtSizeablePanel
 , vtPanel
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
 Tkw_Form_EditionsContainer = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы EditionsContainer
----
*Пример использования*:
[code]
'aControl' форма::EditionsContainer TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_EditionsContainer

 Tkw_EditionsContainer_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_EditionsContainer_Control_BackgroundPanel

 Tkw_EditionsContainer_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_EditionsContainer_Control_BackgroundPanel_Push

 Tkw_EditionsContainer_Control_pnLeft = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnLeft
----
*Пример использования*:
[code]
контрол::pnLeft TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_EditionsContainer_Control_pnLeft

 Tkw_EditionsContainer_Control_pnLeft_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnLeft
----
*Пример использования*:
[code]
контрол::pnLeft:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_EditionsContainer_Control_pnLeft_Push

 Tkw_EditionsContainer_Control_pnRight = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnRight
----
*Пример использования*:
[code]
контрол::pnRight TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_EditionsContainer_Control_pnRight

 Tkw_EditionsContainer_Control_pnRight_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnRight
----
*Пример использования*:
[code]
контрол::pnRight:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_EditionsContainer_Control_pnRight_Push

 TkwEditionsContainerFormBackgroundPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TEditionsContainerForm.BackgroundPanel
[panel]Контрол BackgroundPanel формы TEditionsContainerForm[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aEditionsContainerForm .TEditionsContainerForm.BackgroundPanel >>> l_TvtProportionalPanel
[code]  }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aEditionsContainerForm: TEditionsContainerForm): TvtProportionalPanel;
    {* Реализация слова скрипта .TEditionsContainerForm.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEditionsContainerFormBackgroundPanel

 TkwEditionsContainerFormPnLeft = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TEditionsContainerForm.pnLeft
[panel]Контрол pnLeft формы TEditionsContainerForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aEditionsContainerForm .TEditionsContainerForm.pnLeft >>> l_TvtSizeablePanel
[code]  }
  private
   function pnLeft(const aCtx: TtfwContext;
    aEditionsContainerForm: TEditionsContainerForm): TvtSizeablePanel;
    {* Реализация слова скрипта .TEditionsContainerForm.pnLeft }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEditionsContainerFormPnLeft

 TkwEditionsContainerFormPnRight = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TEditionsContainerForm.pnRight
[panel]Контрол pnRight формы TEditionsContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aEditionsContainerForm .TEditionsContainerForm.pnRight >>> l_TvtPanel
[code]  }
  private
   function pnRight(const aCtx: TtfwContext;
    aEditionsContainerForm: TEditionsContainerForm): TvtPanel;
    {* Реализация слова скрипта .TEditionsContainerForm.pnRight }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEditionsContainerFormPnRight

class function Tkw_Form_EditionsContainer.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::EditionsContainer';
end;//Tkw_Form_EditionsContainer.GetWordNameForRegister

function Tkw_Form_EditionsContainer.GetString: AnsiString;
begin
 Result := 'EditionsContainerForm';
end;//Tkw_Form_EditionsContainer.GetString

class function Tkw_EditionsContainer_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_EditionsContainer_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_EditionsContainer_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_EditionsContainer_Control_BackgroundPanel.GetString

class procedure Tkw_EditionsContainer_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_EditionsContainer_Control_BackgroundPanel.RegisterInEngine

procedure Tkw_EditionsContainer_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D5FE5D3474DD_var*
//#UC END# *4DAEEDE10285_D5FE5D3474DD_var*
begin
//#UC START# *4DAEEDE10285_D5FE5D3474DD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D5FE5D3474DD_impl*
end;//Tkw_EditionsContainer_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_EditionsContainer_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_EditionsContainer_Control_BackgroundPanel_Push.GetWordNameForRegister

class function Tkw_EditionsContainer_Control_pnLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnLeft';
end;//Tkw_EditionsContainer_Control_pnLeft.GetWordNameForRegister

function Tkw_EditionsContainer_Control_pnLeft.GetString: AnsiString;
begin
 Result := 'pnLeft';
end;//Tkw_EditionsContainer_Control_pnLeft.GetString

class procedure Tkw_EditionsContainer_Control_pnLeft.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_EditionsContainer_Control_pnLeft.RegisterInEngine

procedure Tkw_EditionsContainer_Control_pnLeft_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1A3FAB16A745_var*
//#UC END# *4DAEEDE10285_1A3FAB16A745_var*
begin
//#UC START# *4DAEEDE10285_1A3FAB16A745_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1A3FAB16A745_impl*
end;//Tkw_EditionsContainer_Control_pnLeft_Push.DoDoIt

class function Tkw_EditionsContainer_Control_pnLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnLeft:push';
end;//Tkw_EditionsContainer_Control_pnLeft_Push.GetWordNameForRegister

class function Tkw_EditionsContainer_Control_pnRight.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnRight';
end;//Tkw_EditionsContainer_Control_pnRight.GetWordNameForRegister

function Tkw_EditionsContainer_Control_pnRight.GetString: AnsiString;
begin
 Result := 'pnRight';
end;//Tkw_EditionsContainer_Control_pnRight.GetString

class procedure Tkw_EditionsContainer_Control_pnRight.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_EditionsContainer_Control_pnRight.RegisterInEngine

procedure Tkw_EditionsContainer_Control_pnRight_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2482D3157379_var*
//#UC END# *4DAEEDE10285_2482D3157379_var*
begin
//#UC START# *4DAEEDE10285_2482D3157379_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2482D3157379_impl*
end;//Tkw_EditionsContainer_Control_pnRight_Push.DoDoIt

class function Tkw_EditionsContainer_Control_pnRight_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnRight:push';
end;//Tkw_EditionsContainer_Control_pnRight_Push.GetWordNameForRegister

function TkwEditionsContainerFormBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aEditionsContainerForm: TEditionsContainerForm): TvtProportionalPanel;
 {* Реализация слова скрипта .TEditionsContainerForm.BackgroundPanel }
begin
 Result := aEditionsContainerForm.BackgroundPanel;
end;//TkwEditionsContainerFormBackgroundPanel.BackgroundPanel

procedure TkwEditionsContainerFormBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_aEditionsContainerForm: TEditionsContainerForm;
begin
 try
  l_aEditionsContainerForm := TEditionsContainerForm(aCtx.rEngine.PopObjAs(TEditionsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditionsContainerForm: TEditionsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_aEditionsContainerForm));
end;//TkwEditionsContainerFormBackgroundPanel.DoDoIt

class function TkwEditionsContainerFormBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TEditionsContainerForm.BackgroundPanel';
end;//TkwEditionsContainerFormBackgroundPanel.GetWordNameForRegister

procedure TkwEditionsContainerFormBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwEditionsContainerFormBackgroundPanel.SetValuePrim

function TkwEditionsContainerFormBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwEditionsContainerFormBackgroundPanel.GetResultTypeInfo

function TkwEditionsContainerFormBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEditionsContainerFormBackgroundPanel.GetAllParamsCount

function TkwEditionsContainerFormBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TEditionsContainerForm)]);
end;//TkwEditionsContainerFormBackgroundPanel.ParamsTypes

function TkwEditionsContainerFormPnLeft.pnLeft(const aCtx: TtfwContext;
 aEditionsContainerForm: TEditionsContainerForm): TvtSizeablePanel;
 {* Реализация слова скрипта .TEditionsContainerForm.pnLeft }
begin
 Result := aEditionsContainerForm.pnLeft;
end;//TkwEditionsContainerFormPnLeft.pnLeft

procedure TkwEditionsContainerFormPnLeft.DoDoIt(const aCtx: TtfwContext);
var l_aEditionsContainerForm: TEditionsContainerForm;
begin
 try
  l_aEditionsContainerForm := TEditionsContainerForm(aCtx.rEngine.PopObjAs(TEditionsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditionsContainerForm: TEditionsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnLeft(aCtx, l_aEditionsContainerForm));
end;//TkwEditionsContainerFormPnLeft.DoDoIt

class function TkwEditionsContainerFormPnLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.TEditionsContainerForm.pnLeft';
end;//TkwEditionsContainerFormPnLeft.GetWordNameForRegister

procedure TkwEditionsContainerFormPnLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnLeft', aCtx);
end;//TkwEditionsContainerFormPnLeft.SetValuePrim

function TkwEditionsContainerFormPnLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwEditionsContainerFormPnLeft.GetResultTypeInfo

function TkwEditionsContainerFormPnLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEditionsContainerFormPnLeft.GetAllParamsCount

function TkwEditionsContainerFormPnLeft.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TEditionsContainerForm)]);
end;//TkwEditionsContainerFormPnLeft.ParamsTypes

function TkwEditionsContainerFormPnRight.pnRight(const aCtx: TtfwContext;
 aEditionsContainerForm: TEditionsContainerForm): TvtPanel;
 {* Реализация слова скрипта .TEditionsContainerForm.pnRight }
begin
 Result := aEditionsContainerForm.pnRight;
end;//TkwEditionsContainerFormPnRight.pnRight

procedure TkwEditionsContainerFormPnRight.DoDoIt(const aCtx: TtfwContext);
var l_aEditionsContainerForm: TEditionsContainerForm;
begin
 try
  l_aEditionsContainerForm := TEditionsContainerForm(aCtx.rEngine.PopObjAs(TEditionsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditionsContainerForm: TEditionsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnRight(aCtx, l_aEditionsContainerForm));
end;//TkwEditionsContainerFormPnRight.DoDoIt

class function TkwEditionsContainerFormPnRight.GetWordNameForRegister: AnsiString;
begin
 Result := '.TEditionsContainerForm.pnRight';
end;//TkwEditionsContainerFormPnRight.GetWordNameForRegister

procedure TkwEditionsContainerFormPnRight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnRight', aCtx);
end;//TkwEditionsContainerFormPnRight.SetValuePrim

function TkwEditionsContainerFormPnRight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEditionsContainerFormPnRight.GetResultTypeInfo

function TkwEditionsContainerFormPnRight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEditionsContainerFormPnRight.GetAllParamsCount

function TkwEditionsContainerFormPnRight.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TEditionsContainerForm)]);
end;//TkwEditionsContainerFormPnRight.ParamsTypes

initialization
 Tkw_Form_EditionsContainer.RegisterInEngine;
 {* Регистрация Tkw_Form_EditionsContainer }
 Tkw_EditionsContainer_Control_BackgroundPanel.RegisterInEngine;
 {* Регистрация Tkw_EditionsContainer_Control_BackgroundPanel }
 Tkw_EditionsContainer_Control_BackgroundPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_EditionsContainer_Control_BackgroundPanel_Push }
 Tkw_EditionsContainer_Control_pnLeft.RegisterInEngine;
 {* Регистрация Tkw_EditionsContainer_Control_pnLeft }
 Tkw_EditionsContainer_Control_pnLeft_Push.RegisterInEngine;
 {* Регистрация Tkw_EditionsContainer_Control_pnLeft_Push }
 Tkw_EditionsContainer_Control_pnRight.RegisterInEngine;
 {* Регистрация Tkw_EditionsContainer_Control_pnRight }
 Tkw_EditionsContainer_Control_pnRight_Push.RegisterInEngine;
 {* Регистрация Tkw_EditionsContainer_Control_pnRight_Push }
 TkwEditionsContainerFormBackgroundPanel.RegisterInEngine;
 {* Регистрация EditionsContainerForm_BackgroundPanel }
 TkwEditionsContainerFormPnLeft.RegisterInEngine;
 {* Регистрация EditionsContainerForm_pnLeft }
 TkwEditionsContainerFormPnRight.RegisterInEngine;
 {* Регистрация EditionsContainerForm_pnRight }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TEditionsContainerForm));
 {* Регистрация типа EditionsContainer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* Регистрация типа TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* Регистрация типа TvtSizeablePanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.

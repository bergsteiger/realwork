unit ContactListKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы ContactList }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\ContactListKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ContactListKeywordsPack" MUID: (4A6971D00157_Pack)

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
 , ContactList_Form
 , tfwPropertyLike
 , vtPanel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 , eeTreeView
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwContactListFormBackgroundPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TContactListForm.BackgroundPanel }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aContactListForm: TContactListForm): TvtPanel;
    {* Реализация слова скрипта .TContactListForm.BackgroundPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwContactListFormBackgroundPanel

 TkwContactListFormContextFilter = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TContactListForm.ContextFilter }
  private
   function ContextFilter(const aCtx: TtfwContext;
    aContactListForm: TContactListForm): TnscContextFilter;
    {* Реализация слова скрипта .TContactListForm.ContextFilter }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwContactListFormContextFilter

 TkwContactListFormTrContactList = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TContactListForm.trContactList }
  private
   function trContactList(const aCtx: TtfwContext;
    aContactListForm: TContactListForm): TeeTreeView;
    {* Реализация слова скрипта .TContactListForm.trContactList }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwContactListFormTrContactList

 Tkw_Form_ContactList = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы ContactList
----
*Пример использования*:
[code]форма::ContactList TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_ContactList

 Tkw_ContactList_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BackgroundPanel
----
*Пример использования*:
[code]контрол::BackgroundPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ContactList_Control_BackgroundPanel

 Tkw_ContactList_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]контрол::BackgroundPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ContactList_Control_BackgroundPanel_Push

 Tkw_ContactList_Control_ContextFilter = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ContextFilter
----
*Пример использования*:
[code]контрол::ContextFilter TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ContactList_Control_ContextFilter

 Tkw_ContactList_Control_ContextFilter_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ContextFilter
----
*Пример использования*:
[code]контрол::ContextFilter:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ContactList_Control_ContextFilter_Push

 Tkw_ContactList_Control_trContactList = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола trContactList
----
*Пример использования*:
[code]контрол::trContactList TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ContactList_Control_trContactList

 Tkw_ContactList_Control_trContactList_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола trContactList
----
*Пример использования*:
[code]контрол::trContactList:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ContactList_Control_trContactList_Push

function TkwContactListFormBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aContactListForm: TContactListForm): TvtPanel;
 {* Реализация слова скрипта .TContactListForm.BackgroundPanel }
begin
 Result := aContactListForm.BackgroundPanel;
end;//TkwContactListFormBackgroundPanel.BackgroundPanel

class function TkwContactListFormBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContactListForm.BackgroundPanel';
end;//TkwContactListFormBackgroundPanel.GetWordNameForRegister

function TkwContactListFormBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwContactListFormBackgroundPanel.GetResultTypeInfo

function TkwContactListFormBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwContactListFormBackgroundPanel.GetAllParamsCount

function TkwContactListFormBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TContactListForm)]);
end;//TkwContactListFormBackgroundPanel.ParamsTypes

procedure TkwContactListFormBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwContactListFormBackgroundPanel.SetValuePrim

procedure TkwContactListFormBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_aContactListForm: TContactListForm;
begin
 try
  l_aContactListForm := TContactListForm(aCtx.rEngine.PopObjAs(TContactListForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aContactListForm: TContactListForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_aContactListForm));
end;//TkwContactListFormBackgroundPanel.DoDoIt

function TkwContactListFormContextFilter.ContextFilter(const aCtx: TtfwContext;
 aContactListForm: TContactListForm): TnscContextFilter;
 {* Реализация слова скрипта .TContactListForm.ContextFilter }
begin
 Result := aContactListForm.ContextFilter;
end;//TkwContactListFormContextFilter.ContextFilter

class function TkwContactListFormContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContactListForm.ContextFilter';
end;//TkwContactListFormContextFilter.GetWordNameForRegister

function TkwContactListFormContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwContactListFormContextFilter.GetResultTypeInfo

function TkwContactListFormContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwContactListFormContextFilter.GetAllParamsCount

function TkwContactListFormContextFilter.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TContactListForm)]);
end;//TkwContactListFormContextFilter.ParamsTypes

procedure TkwContactListFormContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ContextFilter', aCtx);
end;//TkwContactListFormContextFilter.SetValuePrim

procedure TkwContactListFormContextFilter.DoDoIt(const aCtx: TtfwContext);
var l_aContactListForm: TContactListForm;
begin
 try
  l_aContactListForm := TContactListForm(aCtx.rEngine.PopObjAs(TContactListForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aContactListForm: TContactListForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ContextFilter(aCtx, l_aContactListForm));
end;//TkwContactListFormContextFilter.DoDoIt

function TkwContactListFormTrContactList.trContactList(const aCtx: TtfwContext;
 aContactListForm: TContactListForm): TeeTreeView;
 {* Реализация слова скрипта .TContactListForm.trContactList }
begin
 Result := aContactListForm.trContactList;
end;//TkwContactListFormTrContactList.trContactList

class function TkwContactListFormTrContactList.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContactListForm.trContactList';
end;//TkwContactListFormTrContactList.GetWordNameForRegister

function TkwContactListFormTrContactList.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeTreeView);
end;//TkwContactListFormTrContactList.GetResultTypeInfo

function TkwContactListFormTrContactList.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwContactListFormTrContactList.GetAllParamsCount

function TkwContactListFormTrContactList.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TContactListForm)]);
end;//TkwContactListFormTrContactList.ParamsTypes

procedure TkwContactListFormTrContactList.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству trContactList', aCtx);
end;//TkwContactListFormTrContactList.SetValuePrim

procedure TkwContactListFormTrContactList.DoDoIt(const aCtx: TtfwContext);
var l_aContactListForm: TContactListForm;
begin
 try
  l_aContactListForm := TContactListForm(aCtx.rEngine.PopObjAs(TContactListForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aContactListForm: TContactListForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(trContactList(aCtx, l_aContactListForm));
end;//TkwContactListFormTrContactList.DoDoIt

function Tkw_Form_ContactList.GetString: AnsiString;
begin
 Result := 'ContactListForm';
end;//Tkw_Form_ContactList.GetString

class procedure Tkw_Form_ContactList.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TContactListForm);
end;//Tkw_Form_ContactList.RegisterInEngine

class function Tkw_Form_ContactList.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::ContactList';
end;//Tkw_Form_ContactList.GetWordNameForRegister

function Tkw_ContactList_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_ContactList_Control_BackgroundPanel.GetString

class procedure Tkw_ContactList_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_ContactList_Control_BackgroundPanel.RegisterInEngine

class function Tkw_ContactList_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_ContactList_Control_BackgroundPanel.GetWordNameForRegister

procedure Tkw_ContactList_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_ContactList_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_ContactList_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_ContactList_Control_BackgroundPanel_Push.GetWordNameForRegister

function Tkw_ContactList_Control_ContextFilter.GetString: AnsiString;
begin
 Result := 'ContextFilter';
end;//Tkw_ContactList_Control_ContextFilter.GetString

class procedure Tkw_ContactList_Control_ContextFilter.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_ContactList_Control_ContextFilter.RegisterInEngine

class function Tkw_ContactList_Control_ContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter';
end;//Tkw_ContactList_Control_ContextFilter.GetWordNameForRegister

procedure Tkw_ContactList_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ContextFilter');
 inherited;
end;//Tkw_ContactList_Control_ContextFilter_Push.DoDoIt

class function Tkw_ContactList_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter:push';
end;//Tkw_ContactList_Control_ContextFilter_Push.GetWordNameForRegister

function Tkw_ContactList_Control_trContactList.GetString: AnsiString;
begin
 Result := 'trContactList';
end;//Tkw_ContactList_Control_trContactList.GetString

class procedure Tkw_ContactList_Control_trContactList.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeTreeView);
end;//Tkw_ContactList_Control_trContactList.RegisterInEngine

class function Tkw_ContactList_Control_trContactList.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::trContactList';
end;//Tkw_ContactList_Control_trContactList.GetWordNameForRegister

procedure Tkw_ContactList_Control_trContactList_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('trContactList');
 inherited;
end;//Tkw_ContactList_Control_trContactList_Push.DoDoIt

class function Tkw_ContactList_Control_trContactList_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::trContactList:push';
end;//Tkw_ContactList_Control_trContactList_Push.GetWordNameForRegister

initialization
 TkwContactListFormBackgroundPanel.RegisterInEngine;
 {* Регистрация ContactListForm_BackgroundPanel }
 TkwContactListFormContextFilter.RegisterInEngine;
 {* Регистрация ContactListForm_ContextFilter }
 TkwContactListFormTrContactList.RegisterInEngine;
 {* Регистрация ContactListForm_trContactList }
 Tkw_Form_ContactList.RegisterInEngine;
 {* Регистрация Tkw_Form_ContactList }
 Tkw_ContactList_Control_BackgroundPanel.RegisterInEngine;
 {* Регистрация Tkw_ContactList_Control_BackgroundPanel }
 Tkw_ContactList_Control_BackgroundPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_ContactList_Control_BackgroundPanel_Push }
 Tkw_ContactList_Control_ContextFilter.RegisterInEngine;
 {* Регистрация Tkw_ContactList_Control_ContextFilter }
 Tkw_ContactList_Control_ContextFilter_Push.RegisterInEngine;
 {* Регистрация Tkw_ContactList_Control_ContextFilter_Push }
 Tkw_ContactList_Control_trContactList.RegisterInEngine;
 {* Регистрация Tkw_ContactList_Control_trContactList }
 Tkw_ContactList_Control_trContactList_Push.RegisterInEngine;
 {* Регистрация Tkw_ContactList_Control_trContactList_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TContactListForm));
 {* Регистрация типа TContactListForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* Регистрация типа TnscContextFilter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
 {* Регистрация типа TeeTreeView }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.

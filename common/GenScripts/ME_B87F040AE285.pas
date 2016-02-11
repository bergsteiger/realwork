unit ContactListKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы ContactList }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\ContactListKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , BaseChat_Module
 , vtPanel
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 , eeTreeView
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
 Tkw_Form_ContactList = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы ContactList
----
*Пример использования*:
[code]
'aControl' форма::ContactList TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_ContactList

 Tkw_ContactList_Control_BackgroundPanel = {final} class(TtfwControlString)
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
 end;//Tkw_ContactList_Control_BackgroundPanel

 Tkw_ContactList_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ContactList_Control_BackgroundPanel_Push

 Tkw_ContactList_Control_ContextFilter = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ContextFilter
----
*Пример использования*:
[code]
контрол::ContextFilter TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ContactList_Control_ContextFilter

 Tkw_ContactList_Control_ContextFilter_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ContextFilter
----
*Пример использования*:
[code]
контрол::ContextFilter:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ContactList_Control_ContextFilter_Push

 Tkw_ContactList_Control_trContactList = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола trContactList
----
*Пример использования*:
[code]
контрол::trContactList TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ContactList_Control_trContactList

 Tkw_ContactList_Control_trContactList_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола trContactList
----
*Пример использования*:
[code]
контрол::trContactList:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ContactList_Control_trContactList_Push

 TkwContactListFormBackgroundPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TContactListForm.BackgroundPanel
[panel]Контрол BackgroundPanel формы TContactListForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aContactListForm .TContactListForm.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aContactListForm: TContactListForm): TvtPanel;
    {* Реализация слова скрипта .TContactListForm.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwContactListFormBackgroundPanel

 TkwContactListFormContextFilter = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TContactListForm.ContextFilter
[panel]Контрол ContextFilter формы TContactListForm[panel]
*Тип результата:* TnscContextFilter
*Пример:*
[code]
OBJECT VAR l_TnscContextFilter
 aContactListForm .TContactListForm.ContextFilter >>> l_TnscContextFilter
[code]  }
  private
   function ContextFilter(const aCtx: TtfwContext;
    aContactListForm: TContactListForm): TnscContextFilter;
    {* Реализация слова скрипта .TContactListForm.ContextFilter }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwContactListFormContextFilter

 TkwContactListFormTrContactList = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TContactListForm.trContactList
[panel]Контрол trContactList формы TContactListForm[panel]
*Тип результата:* TeeTreeView
*Пример:*
[code]
OBJECT VAR l_TeeTreeView
 aContactListForm .TContactListForm.trContactList >>> l_TeeTreeView
[code]  }
  private
   function trContactList(const aCtx: TtfwContext;
    aContactListForm: TContactListForm): TeeTreeView;
    {* Реализация слова скрипта .TContactListForm.trContactList }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwContactListFormTrContactList

class function Tkw_Form_ContactList.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::ContactList';
end;//Tkw_Form_ContactList.GetWordNameForRegister

function Tkw_Form_ContactList.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_28E6A164A9F8_var*
//#UC END# *4DDFD2EA0116_28E6A164A9F8_var*
begin
//#UC START# *4DDFD2EA0116_28E6A164A9F8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_28E6A164A9F8_impl*
end;//Tkw_Form_ContactList.GetString

class function Tkw_ContactList_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_ContactList_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_ContactList_Control_BackgroundPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5E4DAD0D336F_var*
//#UC END# *4DDFD2EA0116_5E4DAD0D336F_var*
begin
//#UC START# *4DDFD2EA0116_5E4DAD0D336F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5E4DAD0D336F_impl*
end;//Tkw_ContactList_Control_BackgroundPanel.GetString

class procedure Tkw_ContactList_Control_BackgroundPanel.RegisterInEngine;
//#UC START# *52A086150180_5E4DAD0D336F_var*
//#UC END# *52A086150180_5E4DAD0D336F_var*
begin
//#UC START# *52A086150180_5E4DAD0D336F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_5E4DAD0D336F_impl*
end;//Tkw_ContactList_Control_BackgroundPanel.RegisterInEngine

procedure Tkw_ContactList_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_11C6DB268592_var*
//#UC END# *4DAEEDE10285_11C6DB268592_var*
begin
//#UC START# *4DAEEDE10285_11C6DB268592_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_11C6DB268592_impl*
end;//Tkw_ContactList_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_ContactList_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_ContactList_Control_BackgroundPanel_Push.GetWordNameForRegister

class function Tkw_ContactList_Control_ContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter';
end;//Tkw_ContactList_Control_ContextFilter.GetWordNameForRegister

function Tkw_ContactList_Control_ContextFilter.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B79E9FD124AE_var*
//#UC END# *4DDFD2EA0116_B79E9FD124AE_var*
begin
//#UC START# *4DDFD2EA0116_B79E9FD124AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B79E9FD124AE_impl*
end;//Tkw_ContactList_Control_ContextFilter.GetString

class procedure Tkw_ContactList_Control_ContextFilter.RegisterInEngine;
//#UC START# *52A086150180_B79E9FD124AE_var*
//#UC END# *52A086150180_B79E9FD124AE_var*
begin
//#UC START# *52A086150180_B79E9FD124AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_B79E9FD124AE_impl*
end;//Tkw_ContactList_Control_ContextFilter.RegisterInEngine

procedure Tkw_ContactList_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_AF9DFB9A52B5_var*
//#UC END# *4DAEEDE10285_AF9DFB9A52B5_var*
begin
//#UC START# *4DAEEDE10285_AF9DFB9A52B5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_AF9DFB9A52B5_impl*
end;//Tkw_ContactList_Control_ContextFilter_Push.DoDoIt

class function Tkw_ContactList_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter:push';
end;//Tkw_ContactList_Control_ContextFilter_Push.GetWordNameForRegister

class function Tkw_ContactList_Control_trContactList.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::trContactList';
end;//Tkw_ContactList_Control_trContactList.GetWordNameForRegister

function Tkw_ContactList_Control_trContactList.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_AC6CB336CB67_var*
//#UC END# *4DDFD2EA0116_AC6CB336CB67_var*
begin
//#UC START# *4DDFD2EA0116_AC6CB336CB67_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_AC6CB336CB67_impl*
end;//Tkw_ContactList_Control_trContactList.GetString

class procedure Tkw_ContactList_Control_trContactList.RegisterInEngine;
//#UC START# *52A086150180_AC6CB336CB67_var*
//#UC END# *52A086150180_AC6CB336CB67_var*
begin
//#UC START# *52A086150180_AC6CB336CB67_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_AC6CB336CB67_impl*
end;//Tkw_ContactList_Control_trContactList.RegisterInEngine

procedure Tkw_ContactList_Control_trContactList_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_89EEF1E5433F_var*
//#UC END# *4DAEEDE10285_89EEF1E5433F_var*
begin
//#UC START# *4DAEEDE10285_89EEF1E5433F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_89EEF1E5433F_impl*
end;//Tkw_ContactList_Control_trContactList_Push.DoDoIt

class function Tkw_ContactList_Control_trContactList_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::trContactList:push';
end;//Tkw_ContactList_Control_trContactList_Push.GetWordNameForRegister

function TkwContactListFormBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aContactListForm: TContactListForm): TvtPanel;
 {* Реализация слова скрипта .TContactListForm.BackgroundPanel }
//#UC START# *6814A55D1B46_DAF37FC67167_var*
//#UC END# *6814A55D1B46_DAF37FC67167_var*
begin
//#UC START# *6814A55D1B46_DAF37FC67167_impl*
 !!! Needs to be implemented !!!
//#UC END# *6814A55D1B46_DAF37FC67167_impl*
end;//TkwContactListFormBackgroundPanel.BackgroundPanel

procedure TkwContactListFormBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DAF37FC67167_var*
//#UC END# *4DAEEDE10285_DAF37FC67167_var*
begin
//#UC START# *4DAEEDE10285_DAF37FC67167_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DAF37FC67167_impl*
end;//TkwContactListFormBackgroundPanel.DoDoIt

class function TkwContactListFormBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContactListForm.BackgroundPanel';
end;//TkwContactListFormBackgroundPanel.GetWordNameForRegister

procedure TkwContactListFormBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_DAF37FC67167_var*
//#UC END# *52D00B00031A_DAF37FC67167_var*
begin
//#UC START# *52D00B00031A_DAF37FC67167_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_DAF37FC67167_impl*
end;//TkwContactListFormBackgroundPanel.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwContactListFormBackgroundPanel.ParamsTypes

function TkwContactListFormContextFilter.ContextFilter(const aCtx: TtfwContext;
 aContactListForm: TContactListForm): TnscContextFilter;
 {* Реализация слова скрипта .TContactListForm.ContextFilter }
//#UC START# *F26BB9432D34_141AC39E15DF_var*
//#UC END# *F26BB9432D34_141AC39E15DF_var*
begin
//#UC START# *F26BB9432D34_141AC39E15DF_impl*
 !!! Needs to be implemented !!!
//#UC END# *F26BB9432D34_141AC39E15DF_impl*
end;//TkwContactListFormContextFilter.ContextFilter

procedure TkwContactListFormContextFilter.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_141AC39E15DF_var*
//#UC END# *4DAEEDE10285_141AC39E15DF_var*
begin
//#UC START# *4DAEEDE10285_141AC39E15DF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_141AC39E15DF_impl*
end;//TkwContactListFormContextFilter.DoDoIt

class function TkwContactListFormContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContactListForm.ContextFilter';
end;//TkwContactListFormContextFilter.GetWordNameForRegister

procedure TkwContactListFormContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_141AC39E15DF_var*
//#UC END# *52D00B00031A_141AC39E15DF_var*
begin
//#UC START# *52D00B00031A_141AC39E15DF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_141AC39E15DF_impl*
end;//TkwContactListFormContextFilter.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwContactListFormContextFilter.ParamsTypes

function TkwContactListFormTrContactList.trContactList(const aCtx: TtfwContext;
 aContactListForm: TContactListForm): TeeTreeView;
 {* Реализация слова скрипта .TContactListForm.trContactList }
//#UC START# *658C87795981_3B0FB738C178_var*
//#UC END# *658C87795981_3B0FB738C178_var*
begin
//#UC START# *658C87795981_3B0FB738C178_impl*
 !!! Needs to be implemented !!!
//#UC END# *658C87795981_3B0FB738C178_impl*
end;//TkwContactListFormTrContactList.trContactList

procedure TkwContactListFormTrContactList.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3B0FB738C178_var*
//#UC END# *4DAEEDE10285_3B0FB738C178_var*
begin
//#UC START# *4DAEEDE10285_3B0FB738C178_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3B0FB738C178_impl*
end;//TkwContactListFormTrContactList.DoDoIt

class function TkwContactListFormTrContactList.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContactListForm.trContactList';
end;//TkwContactListFormTrContactList.GetWordNameForRegister

procedure TkwContactListFormTrContactList.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_3B0FB738C178_var*
//#UC END# *52D00B00031A_3B0FB738C178_var*
begin
//#UC START# *52D00B00031A_3B0FB738C178_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_3B0FB738C178_impl*
end;//TkwContactListFormTrContactList.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwContactListFormTrContactList.ParamsTypes

initialization
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
 TkwContactListFormBackgroundPanel.RegisterInEngine;
 {* Регистрация ContactListForm_BackgroundPanel }
 TkwContactListFormContextFilter.RegisterInEngine;
 {* Регистрация ContactListForm_ContextFilter }
 TkwContactListFormTrContactList.RegisterInEngine;
 {* Регистрация ContactListForm_trContactList }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TContactListForm));
 {* Регистрация типа ContactList }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* Регистрация типа TnscContextFilter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
 {* Регистрация типа TeeTreeView }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.

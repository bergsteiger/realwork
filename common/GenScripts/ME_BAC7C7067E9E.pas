unit OldSituationSearchKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы OldSituationSearch }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\OldSituationSearchKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Search_Module
 , vtPanel
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 , vtProportionalPanel
 , vtSizeablePanel
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
 Tkw_Form_OldSituationSearch = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы OldSituationSearch
----
*Пример использования*:
[code]
'aControl' форма::OldSituationSearch TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_OldSituationSearch

 Tkw_OldSituationSearch_Control_BackgroundPanel = {final} class(TtfwControlString)
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
 end;//Tkw_OldSituationSearch_Control_BackgroundPanel

 Tkw_OldSituationSearch_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_OldSituationSearch_Control_BackgroundPanel_Push

 Tkw_OldSituationSearch_Control_ContextFilter = {final} class(TtfwControlString)
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
 end;//Tkw_OldSituationSearch_Control_ContextFilter

 Tkw_OldSituationSearch_Control_ContextFilter_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ContextFilter
----
*Пример использования*:
[code]
контрол::ContextFilter:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_OldSituationSearch_Control_ContextFilter_Push

 Tkw_OldSituationSearch_Control_InnerBackgroundPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола InnerBackgroundPanel
----
*Пример использования*:
[code]
контрол::InnerBackgroundPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_OldSituationSearch_Control_InnerBackgroundPanel

 Tkw_OldSituationSearch_Control_InnerBackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола InnerBackgroundPanel
----
*Пример использования*:
[code]
контрол::InnerBackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_OldSituationSearch_Control_InnerBackgroundPanel_Push

 Tkw_OldSituationSearch_Control_BotomPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BotomPanel
----
*Пример использования*:
[code]
контрол::BotomPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_OldSituationSearch_Control_BotomPanel

 Tkw_OldSituationSearch_Control_BotomPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BotomPanel
----
*Пример использования*:
[code]
контрол::BotomPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_OldSituationSearch_Control_BotomPanel_Push

 Tkw_OldSituationSearch_Control_ParentZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ParentZone
----
*Пример использования*:
[code]
контрол::ParentZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_OldSituationSearch_Control_ParentZone

 Tkw_OldSituationSearch_Control_ParentZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ParentZone
----
*Пример использования*:
[code]
контрол::ParentZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_OldSituationSearch_Control_ParentZone_Push

 Tkw_OldSituationSearch_Control_ZoneContainer = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ZoneContainer
----
*Пример использования*:
[code]
контрол::ZoneContainer TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_OldSituationSearch_Control_ZoneContainer

 Tkw_OldSituationSearch_Control_ZoneContainer_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ZoneContainer
----
*Пример использования*:
[code]
контрол::ZoneContainer:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_OldSituationSearch_Control_ZoneContainer_Push

 Tkw_OldSituationSearch_Control_ChildZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ChildZone
----
*Пример использования*:
[code]
контрол::ChildZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_OldSituationSearch_Control_ChildZone

 Tkw_OldSituationSearch_Control_ChildZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ChildZone
----
*Пример использования*:
[code]
контрол::ChildZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_OldSituationSearch_Control_ChildZone_Push

 Tkw_OldSituationSearch_Control_MainZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола MainZone
----
*Пример использования*:
[code]
контрол::MainZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_OldSituationSearch_Control_MainZone

 Tkw_OldSituationSearch_Control_MainZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола MainZone
----
*Пример использования*:
[code]
контрол::MainZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_OldSituationSearch_Control_MainZone_Push

 TkwCfOldSituationSearchBackgroundPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfOldSituationSearch.BackgroundPanel
[panel]Контрол BackgroundPanel формы TcfOldSituationSearch[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 acfOldSituationSearch .TcfOldSituationSearch.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    acfOldSituationSearch: TcfOldSituationSearch): TvtPanel;
    {* Реализация слова скрипта .TcfOldSituationSearch.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfOldSituationSearchBackgroundPanel

 TkwCfOldSituationSearchContextFilter = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfOldSituationSearch.ContextFilter
[panel]Контрол ContextFilter формы TcfOldSituationSearch[panel]
*Тип результата:* TnscContextFilter
*Пример:*
[code]
OBJECT VAR l_TnscContextFilter
 acfOldSituationSearch .TcfOldSituationSearch.ContextFilter >>> l_TnscContextFilter
[code]  }
  private
   function ContextFilter(const aCtx: TtfwContext;
    acfOldSituationSearch: TcfOldSituationSearch): TnscContextFilter;
    {* Реализация слова скрипта .TcfOldSituationSearch.ContextFilter }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfOldSituationSearchContextFilter

 TkwCfOldSituationSearchInnerBackgroundPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfOldSituationSearch.InnerBackgroundPanel
[panel]Контрол InnerBackgroundPanel формы TcfOldSituationSearch[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 acfOldSituationSearch .TcfOldSituationSearch.InnerBackgroundPanel >>> l_TvtProportionalPanel
[code]  }
  private
   function InnerBackgroundPanel(const aCtx: TtfwContext;
    acfOldSituationSearch: TcfOldSituationSearch): TvtProportionalPanel;
    {* Реализация слова скрипта .TcfOldSituationSearch.InnerBackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfOldSituationSearchInnerBackgroundPanel

 TkwCfOldSituationSearchBotomPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfOldSituationSearch.BotomPanel
[panel]Контрол BotomPanel формы TcfOldSituationSearch[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 acfOldSituationSearch .TcfOldSituationSearch.BotomPanel >>> l_TvtSizeablePanel
[code]  }
  private
   function BotomPanel(const aCtx: TtfwContext;
    acfOldSituationSearch: TcfOldSituationSearch): TvtSizeablePanel;
    {* Реализация слова скрипта .TcfOldSituationSearch.BotomPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfOldSituationSearchBotomPanel

 TkwCfOldSituationSearchParentZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfOldSituationSearch.ParentZone
[panel]Контрол ParentZone формы TcfOldSituationSearch[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 acfOldSituationSearch .TcfOldSituationSearch.ParentZone >>> l_TvtPanel
[code]  }
  private
   function ParentZone(const aCtx: TtfwContext;
    acfOldSituationSearch: TcfOldSituationSearch): TvtPanel;
    {* Реализация слова скрипта .TcfOldSituationSearch.ParentZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfOldSituationSearchParentZone

 TkwCfOldSituationSearchZoneContainer = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfOldSituationSearch.ZoneContainer
[panel]Контрол ZoneContainer формы TcfOldSituationSearch[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 acfOldSituationSearch .TcfOldSituationSearch.ZoneContainer >>> l_TvtProportionalPanel
[code]  }
  private
   function ZoneContainer(const aCtx: TtfwContext;
    acfOldSituationSearch: TcfOldSituationSearch): TvtProportionalPanel;
    {* Реализация слова скрипта .TcfOldSituationSearch.ZoneContainer }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfOldSituationSearchZoneContainer

 TkwCfOldSituationSearchChildZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfOldSituationSearch.ChildZone
[panel]Контрол ChildZone формы TcfOldSituationSearch[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 acfOldSituationSearch .TcfOldSituationSearch.ChildZone >>> l_TvtPanel
[code]  }
  private
   function ChildZone(const aCtx: TtfwContext;
    acfOldSituationSearch: TcfOldSituationSearch): TvtPanel;
    {* Реализация слова скрипта .TcfOldSituationSearch.ChildZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfOldSituationSearchChildZone

 TkwCfOldSituationSearchMainZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfOldSituationSearch.MainZone
[panel]Контрол MainZone формы TcfOldSituationSearch[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 acfOldSituationSearch .TcfOldSituationSearch.MainZone >>> l_TvtSizeablePanel
[code]  }
  private
   function MainZone(const aCtx: TtfwContext;
    acfOldSituationSearch: TcfOldSituationSearch): TvtSizeablePanel;
    {* Реализация слова скрипта .TcfOldSituationSearch.MainZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfOldSituationSearchMainZone

class function Tkw_Form_OldSituationSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::OldSituationSearch';
end;//Tkw_Form_OldSituationSearch.GetWordNameForRegister

function Tkw_Form_OldSituationSearch.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2EB1D27B79DC_var*
//#UC END# *4DDFD2EA0116_2EB1D27B79DC_var*
begin
//#UC START# *4DDFD2EA0116_2EB1D27B79DC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2EB1D27B79DC_impl*
end;//Tkw_Form_OldSituationSearch.GetString

class function Tkw_OldSituationSearch_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_OldSituationSearch_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_OldSituationSearch_Control_BackgroundPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_43F8F63B0E60_var*
//#UC END# *4DDFD2EA0116_43F8F63B0E60_var*
begin
//#UC START# *4DDFD2EA0116_43F8F63B0E60_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_43F8F63B0E60_impl*
end;//Tkw_OldSituationSearch_Control_BackgroundPanel.GetString

class procedure Tkw_OldSituationSearch_Control_BackgroundPanel.RegisterInEngine;
//#UC START# *52A086150180_43F8F63B0E60_var*
//#UC END# *52A086150180_43F8F63B0E60_var*
begin
//#UC START# *52A086150180_43F8F63B0E60_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_43F8F63B0E60_impl*
end;//Tkw_OldSituationSearch_Control_BackgroundPanel.RegisterInEngine

procedure Tkw_OldSituationSearch_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_76B4108B65DF_var*
//#UC END# *4DAEEDE10285_76B4108B65DF_var*
begin
//#UC START# *4DAEEDE10285_76B4108B65DF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_76B4108B65DF_impl*
end;//Tkw_OldSituationSearch_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_OldSituationSearch_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_OldSituationSearch_Control_BackgroundPanel_Push.GetWordNameForRegister

class function Tkw_OldSituationSearch_Control_ContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter';
end;//Tkw_OldSituationSearch_Control_ContextFilter.GetWordNameForRegister

function Tkw_OldSituationSearch_Control_ContextFilter.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2843F0EF5353_var*
//#UC END# *4DDFD2EA0116_2843F0EF5353_var*
begin
//#UC START# *4DDFD2EA0116_2843F0EF5353_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2843F0EF5353_impl*
end;//Tkw_OldSituationSearch_Control_ContextFilter.GetString

class procedure Tkw_OldSituationSearch_Control_ContextFilter.RegisterInEngine;
//#UC START# *52A086150180_2843F0EF5353_var*
//#UC END# *52A086150180_2843F0EF5353_var*
begin
//#UC START# *52A086150180_2843F0EF5353_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_2843F0EF5353_impl*
end;//Tkw_OldSituationSearch_Control_ContextFilter.RegisterInEngine

procedure Tkw_OldSituationSearch_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FF019C96AEA7_var*
//#UC END# *4DAEEDE10285_FF019C96AEA7_var*
begin
//#UC START# *4DAEEDE10285_FF019C96AEA7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FF019C96AEA7_impl*
end;//Tkw_OldSituationSearch_Control_ContextFilter_Push.DoDoIt

class function Tkw_OldSituationSearch_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter:push';
end;//Tkw_OldSituationSearch_Control_ContextFilter_Push.GetWordNameForRegister

class function Tkw_OldSituationSearch_Control_InnerBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::InnerBackgroundPanel';
end;//Tkw_OldSituationSearch_Control_InnerBackgroundPanel.GetWordNameForRegister

function Tkw_OldSituationSearch_Control_InnerBackgroundPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C496C1BEC8BA_var*
//#UC END# *4DDFD2EA0116_C496C1BEC8BA_var*
begin
//#UC START# *4DDFD2EA0116_C496C1BEC8BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C496C1BEC8BA_impl*
end;//Tkw_OldSituationSearch_Control_InnerBackgroundPanel.GetString

class procedure Tkw_OldSituationSearch_Control_InnerBackgroundPanel.RegisterInEngine;
//#UC START# *52A086150180_C496C1BEC8BA_var*
//#UC END# *52A086150180_C496C1BEC8BA_var*
begin
//#UC START# *52A086150180_C496C1BEC8BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_C496C1BEC8BA_impl*
end;//Tkw_OldSituationSearch_Control_InnerBackgroundPanel.RegisterInEngine

procedure Tkw_OldSituationSearch_Control_InnerBackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2D9C2652E1B6_var*
//#UC END# *4DAEEDE10285_2D9C2652E1B6_var*
begin
//#UC START# *4DAEEDE10285_2D9C2652E1B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2D9C2652E1B6_impl*
end;//Tkw_OldSituationSearch_Control_InnerBackgroundPanel_Push.DoDoIt

class function Tkw_OldSituationSearch_Control_InnerBackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::InnerBackgroundPanel:push';
end;//Tkw_OldSituationSearch_Control_InnerBackgroundPanel_Push.GetWordNameForRegister

class function Tkw_OldSituationSearch_Control_BotomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BotomPanel';
end;//Tkw_OldSituationSearch_Control_BotomPanel.GetWordNameForRegister

function Tkw_OldSituationSearch_Control_BotomPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_3CDF87965E1F_var*
//#UC END# *4DDFD2EA0116_3CDF87965E1F_var*
begin
//#UC START# *4DDFD2EA0116_3CDF87965E1F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_3CDF87965E1F_impl*
end;//Tkw_OldSituationSearch_Control_BotomPanel.GetString

class procedure Tkw_OldSituationSearch_Control_BotomPanel.RegisterInEngine;
//#UC START# *52A086150180_3CDF87965E1F_var*
//#UC END# *52A086150180_3CDF87965E1F_var*
begin
//#UC START# *52A086150180_3CDF87965E1F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_3CDF87965E1F_impl*
end;//Tkw_OldSituationSearch_Control_BotomPanel.RegisterInEngine

procedure Tkw_OldSituationSearch_Control_BotomPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5F0F569DDD28_var*
//#UC END# *4DAEEDE10285_5F0F569DDD28_var*
begin
//#UC START# *4DAEEDE10285_5F0F569DDD28_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5F0F569DDD28_impl*
end;//Tkw_OldSituationSearch_Control_BotomPanel_Push.DoDoIt

class function Tkw_OldSituationSearch_Control_BotomPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BotomPanel:push';
end;//Tkw_OldSituationSearch_Control_BotomPanel_Push.GetWordNameForRegister

class function Tkw_OldSituationSearch_Control_ParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ParentZone';
end;//Tkw_OldSituationSearch_Control_ParentZone.GetWordNameForRegister

function Tkw_OldSituationSearch_Control_ParentZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_6B84F99B05DE_var*
//#UC END# *4DDFD2EA0116_6B84F99B05DE_var*
begin
//#UC START# *4DDFD2EA0116_6B84F99B05DE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_6B84F99B05DE_impl*
end;//Tkw_OldSituationSearch_Control_ParentZone.GetString

class procedure Tkw_OldSituationSearch_Control_ParentZone.RegisterInEngine;
//#UC START# *52A086150180_6B84F99B05DE_var*
//#UC END# *52A086150180_6B84F99B05DE_var*
begin
//#UC START# *52A086150180_6B84F99B05DE_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_6B84F99B05DE_impl*
end;//Tkw_OldSituationSearch_Control_ParentZone.RegisterInEngine

procedure Tkw_OldSituationSearch_Control_ParentZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C352884AFBA6_var*
//#UC END# *4DAEEDE10285_C352884AFBA6_var*
begin
//#UC START# *4DAEEDE10285_C352884AFBA6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C352884AFBA6_impl*
end;//Tkw_OldSituationSearch_Control_ParentZone_Push.DoDoIt

class function Tkw_OldSituationSearch_Control_ParentZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ParentZone:push';
end;//Tkw_OldSituationSearch_Control_ParentZone_Push.GetWordNameForRegister

class function Tkw_OldSituationSearch_Control_ZoneContainer.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ZoneContainer';
end;//Tkw_OldSituationSearch_Control_ZoneContainer.GetWordNameForRegister

function Tkw_OldSituationSearch_Control_ZoneContainer.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_791D7B5112C3_var*
//#UC END# *4DDFD2EA0116_791D7B5112C3_var*
begin
//#UC START# *4DDFD2EA0116_791D7B5112C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_791D7B5112C3_impl*
end;//Tkw_OldSituationSearch_Control_ZoneContainer.GetString

class procedure Tkw_OldSituationSearch_Control_ZoneContainer.RegisterInEngine;
//#UC START# *52A086150180_791D7B5112C3_var*
//#UC END# *52A086150180_791D7B5112C3_var*
begin
//#UC START# *52A086150180_791D7B5112C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_791D7B5112C3_impl*
end;//Tkw_OldSituationSearch_Control_ZoneContainer.RegisterInEngine

procedure Tkw_OldSituationSearch_Control_ZoneContainer_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1B1D66E28628_var*
//#UC END# *4DAEEDE10285_1B1D66E28628_var*
begin
//#UC START# *4DAEEDE10285_1B1D66E28628_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1B1D66E28628_impl*
end;//Tkw_OldSituationSearch_Control_ZoneContainer_Push.DoDoIt

class function Tkw_OldSituationSearch_Control_ZoneContainer_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ZoneContainer:push';
end;//Tkw_OldSituationSearch_Control_ZoneContainer_Push.GetWordNameForRegister

class function Tkw_OldSituationSearch_Control_ChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZone';
end;//Tkw_OldSituationSearch_Control_ChildZone.GetWordNameForRegister

function Tkw_OldSituationSearch_Control_ChildZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_ADEA77DFC527_var*
//#UC END# *4DDFD2EA0116_ADEA77DFC527_var*
begin
//#UC START# *4DDFD2EA0116_ADEA77DFC527_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_ADEA77DFC527_impl*
end;//Tkw_OldSituationSearch_Control_ChildZone.GetString

class procedure Tkw_OldSituationSearch_Control_ChildZone.RegisterInEngine;
//#UC START# *52A086150180_ADEA77DFC527_var*
//#UC END# *52A086150180_ADEA77DFC527_var*
begin
//#UC START# *52A086150180_ADEA77DFC527_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_ADEA77DFC527_impl*
end;//Tkw_OldSituationSearch_Control_ChildZone.RegisterInEngine

procedure Tkw_OldSituationSearch_Control_ChildZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B3B6FFAE5AF8_var*
//#UC END# *4DAEEDE10285_B3B6FFAE5AF8_var*
begin
//#UC START# *4DAEEDE10285_B3B6FFAE5AF8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B3B6FFAE5AF8_impl*
end;//Tkw_OldSituationSearch_Control_ChildZone_Push.DoDoIt

class function Tkw_OldSituationSearch_Control_ChildZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZone:push';
end;//Tkw_OldSituationSearch_Control_ChildZone_Push.GetWordNameForRegister

class function Tkw_OldSituationSearch_Control_MainZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MainZone';
end;//Tkw_OldSituationSearch_Control_MainZone.GetWordNameForRegister

function Tkw_OldSituationSearch_Control_MainZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_D07D82653A14_var*
//#UC END# *4DDFD2EA0116_D07D82653A14_var*
begin
//#UC START# *4DDFD2EA0116_D07D82653A14_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_D07D82653A14_impl*
end;//Tkw_OldSituationSearch_Control_MainZone.GetString

class procedure Tkw_OldSituationSearch_Control_MainZone.RegisterInEngine;
//#UC START# *52A086150180_D07D82653A14_var*
//#UC END# *52A086150180_D07D82653A14_var*
begin
//#UC START# *52A086150180_D07D82653A14_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_D07D82653A14_impl*
end;//Tkw_OldSituationSearch_Control_MainZone.RegisterInEngine

procedure Tkw_OldSituationSearch_Control_MainZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B98A4E1F0302_var*
//#UC END# *4DAEEDE10285_B98A4E1F0302_var*
begin
//#UC START# *4DAEEDE10285_B98A4E1F0302_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B98A4E1F0302_impl*
end;//Tkw_OldSituationSearch_Control_MainZone_Push.DoDoIt

class function Tkw_OldSituationSearch_Control_MainZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MainZone:push';
end;//Tkw_OldSituationSearch_Control_MainZone_Push.GetWordNameForRegister

function TkwCfOldSituationSearchBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 acfOldSituationSearch: TcfOldSituationSearch): TvtPanel;
 {* Реализация слова скрипта .TcfOldSituationSearch.BackgroundPanel }
//#UC START# *D39879C009DD_E6E04DA21252_var*
//#UC END# *D39879C009DD_E6E04DA21252_var*
begin
//#UC START# *D39879C009DD_E6E04DA21252_impl*
 !!! Needs to be implemented !!!
//#UC END# *D39879C009DD_E6E04DA21252_impl*
end;//TkwCfOldSituationSearchBackgroundPanel.BackgroundPanel

procedure TkwCfOldSituationSearchBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E6E04DA21252_var*
//#UC END# *4DAEEDE10285_E6E04DA21252_var*
begin
//#UC START# *4DAEEDE10285_E6E04DA21252_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E6E04DA21252_impl*
end;//TkwCfOldSituationSearchBackgroundPanel.DoDoIt

class function TkwCfOldSituationSearchBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfOldSituationSearch.BackgroundPanel';
end;//TkwCfOldSituationSearchBackgroundPanel.GetWordNameForRegister

procedure TkwCfOldSituationSearchBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_E6E04DA21252_var*
//#UC END# *52D00B00031A_E6E04DA21252_var*
begin
//#UC START# *52D00B00031A_E6E04DA21252_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_E6E04DA21252_impl*
end;//TkwCfOldSituationSearchBackgroundPanel.SetValuePrim

function TkwCfOldSituationSearchBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfOldSituationSearchBackgroundPanel.GetResultTypeInfo

function TkwCfOldSituationSearchBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfOldSituationSearchBackgroundPanel.GetAllParamsCount

function TkwCfOldSituationSearchBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCfOldSituationSearchBackgroundPanel.ParamsTypes

function TkwCfOldSituationSearchContextFilter.ContextFilter(const aCtx: TtfwContext;
 acfOldSituationSearch: TcfOldSituationSearch): TnscContextFilter;
 {* Реализация слова скрипта .TcfOldSituationSearch.ContextFilter }
//#UC START# *48A443B012C8_A70ACD88A02D_var*
//#UC END# *48A443B012C8_A70ACD88A02D_var*
begin
//#UC START# *48A443B012C8_A70ACD88A02D_impl*
 !!! Needs to be implemented !!!
//#UC END# *48A443B012C8_A70ACD88A02D_impl*
end;//TkwCfOldSituationSearchContextFilter.ContextFilter

procedure TkwCfOldSituationSearchContextFilter.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A70ACD88A02D_var*
//#UC END# *4DAEEDE10285_A70ACD88A02D_var*
begin
//#UC START# *4DAEEDE10285_A70ACD88A02D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A70ACD88A02D_impl*
end;//TkwCfOldSituationSearchContextFilter.DoDoIt

class function TkwCfOldSituationSearchContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfOldSituationSearch.ContextFilter';
end;//TkwCfOldSituationSearchContextFilter.GetWordNameForRegister

procedure TkwCfOldSituationSearchContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_A70ACD88A02D_var*
//#UC END# *52D00B00031A_A70ACD88A02D_var*
begin
//#UC START# *52D00B00031A_A70ACD88A02D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_A70ACD88A02D_impl*
end;//TkwCfOldSituationSearchContextFilter.SetValuePrim

function TkwCfOldSituationSearchContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwCfOldSituationSearchContextFilter.GetResultTypeInfo

function TkwCfOldSituationSearchContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfOldSituationSearchContextFilter.GetAllParamsCount

function TkwCfOldSituationSearchContextFilter.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCfOldSituationSearchContextFilter.ParamsTypes

function TkwCfOldSituationSearchInnerBackgroundPanel.InnerBackgroundPanel(const aCtx: TtfwContext;
 acfOldSituationSearch: TcfOldSituationSearch): TvtProportionalPanel;
 {* Реализация слова скрипта .TcfOldSituationSearch.InnerBackgroundPanel }
//#UC START# *4635BA0BCCEC_3226F237B61F_var*
//#UC END# *4635BA0BCCEC_3226F237B61F_var*
begin
//#UC START# *4635BA0BCCEC_3226F237B61F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4635BA0BCCEC_3226F237B61F_impl*
end;//TkwCfOldSituationSearchInnerBackgroundPanel.InnerBackgroundPanel

procedure TkwCfOldSituationSearchInnerBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3226F237B61F_var*
//#UC END# *4DAEEDE10285_3226F237B61F_var*
begin
//#UC START# *4DAEEDE10285_3226F237B61F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3226F237B61F_impl*
end;//TkwCfOldSituationSearchInnerBackgroundPanel.DoDoIt

class function TkwCfOldSituationSearchInnerBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfOldSituationSearch.InnerBackgroundPanel';
end;//TkwCfOldSituationSearchInnerBackgroundPanel.GetWordNameForRegister

procedure TkwCfOldSituationSearchInnerBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_3226F237B61F_var*
//#UC END# *52D00B00031A_3226F237B61F_var*
begin
//#UC START# *52D00B00031A_3226F237B61F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_3226F237B61F_impl*
end;//TkwCfOldSituationSearchInnerBackgroundPanel.SetValuePrim

function TkwCfOldSituationSearchInnerBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwCfOldSituationSearchInnerBackgroundPanel.GetResultTypeInfo

function TkwCfOldSituationSearchInnerBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfOldSituationSearchInnerBackgroundPanel.GetAllParamsCount

function TkwCfOldSituationSearchInnerBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCfOldSituationSearchInnerBackgroundPanel.ParamsTypes

function TkwCfOldSituationSearchBotomPanel.BotomPanel(const aCtx: TtfwContext;
 acfOldSituationSearch: TcfOldSituationSearch): TvtSizeablePanel;
 {* Реализация слова скрипта .TcfOldSituationSearch.BotomPanel }
//#UC START# *30B33AE00C36_F188CE819F7D_var*
//#UC END# *30B33AE00C36_F188CE819F7D_var*
begin
//#UC START# *30B33AE00C36_F188CE819F7D_impl*
 !!! Needs to be implemented !!!
//#UC END# *30B33AE00C36_F188CE819F7D_impl*
end;//TkwCfOldSituationSearchBotomPanel.BotomPanel

procedure TkwCfOldSituationSearchBotomPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F188CE819F7D_var*
//#UC END# *4DAEEDE10285_F188CE819F7D_var*
begin
//#UC START# *4DAEEDE10285_F188CE819F7D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F188CE819F7D_impl*
end;//TkwCfOldSituationSearchBotomPanel.DoDoIt

class function TkwCfOldSituationSearchBotomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfOldSituationSearch.BotomPanel';
end;//TkwCfOldSituationSearchBotomPanel.GetWordNameForRegister

procedure TkwCfOldSituationSearchBotomPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_F188CE819F7D_var*
//#UC END# *52D00B00031A_F188CE819F7D_var*
begin
//#UC START# *52D00B00031A_F188CE819F7D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_F188CE819F7D_impl*
end;//TkwCfOldSituationSearchBotomPanel.SetValuePrim

function TkwCfOldSituationSearchBotomPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwCfOldSituationSearchBotomPanel.GetResultTypeInfo

function TkwCfOldSituationSearchBotomPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfOldSituationSearchBotomPanel.GetAllParamsCount

function TkwCfOldSituationSearchBotomPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCfOldSituationSearchBotomPanel.ParamsTypes

function TkwCfOldSituationSearchParentZone.ParentZone(const aCtx: TtfwContext;
 acfOldSituationSearch: TcfOldSituationSearch): TvtPanel;
 {* Реализация слова скрипта .TcfOldSituationSearch.ParentZone }
//#UC START# *6D8070D10F29_9530C933E1D4_var*
//#UC END# *6D8070D10F29_9530C933E1D4_var*
begin
//#UC START# *6D8070D10F29_9530C933E1D4_impl*
 !!! Needs to be implemented !!!
//#UC END# *6D8070D10F29_9530C933E1D4_impl*
end;//TkwCfOldSituationSearchParentZone.ParentZone

procedure TkwCfOldSituationSearchParentZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9530C933E1D4_var*
//#UC END# *4DAEEDE10285_9530C933E1D4_var*
begin
//#UC START# *4DAEEDE10285_9530C933E1D4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9530C933E1D4_impl*
end;//TkwCfOldSituationSearchParentZone.DoDoIt

class function TkwCfOldSituationSearchParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfOldSituationSearch.ParentZone';
end;//TkwCfOldSituationSearchParentZone.GetWordNameForRegister

procedure TkwCfOldSituationSearchParentZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_9530C933E1D4_var*
//#UC END# *52D00B00031A_9530C933E1D4_var*
begin
//#UC START# *52D00B00031A_9530C933E1D4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_9530C933E1D4_impl*
end;//TkwCfOldSituationSearchParentZone.SetValuePrim

function TkwCfOldSituationSearchParentZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfOldSituationSearchParentZone.GetResultTypeInfo

function TkwCfOldSituationSearchParentZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfOldSituationSearchParentZone.GetAllParamsCount

function TkwCfOldSituationSearchParentZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCfOldSituationSearchParentZone.ParamsTypes

function TkwCfOldSituationSearchZoneContainer.ZoneContainer(const aCtx: TtfwContext;
 acfOldSituationSearch: TcfOldSituationSearch): TvtProportionalPanel;
 {* Реализация слова скрипта .TcfOldSituationSearch.ZoneContainer }
//#UC START# *15DFFB172336_C9CB01FB6D8E_var*
//#UC END# *15DFFB172336_C9CB01FB6D8E_var*
begin
//#UC START# *15DFFB172336_C9CB01FB6D8E_impl*
 !!! Needs to be implemented !!!
//#UC END# *15DFFB172336_C9CB01FB6D8E_impl*
end;//TkwCfOldSituationSearchZoneContainer.ZoneContainer

procedure TkwCfOldSituationSearchZoneContainer.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C9CB01FB6D8E_var*
//#UC END# *4DAEEDE10285_C9CB01FB6D8E_var*
begin
//#UC START# *4DAEEDE10285_C9CB01FB6D8E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C9CB01FB6D8E_impl*
end;//TkwCfOldSituationSearchZoneContainer.DoDoIt

class function TkwCfOldSituationSearchZoneContainer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfOldSituationSearch.ZoneContainer';
end;//TkwCfOldSituationSearchZoneContainer.GetWordNameForRegister

procedure TkwCfOldSituationSearchZoneContainer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_C9CB01FB6D8E_var*
//#UC END# *52D00B00031A_C9CB01FB6D8E_var*
begin
//#UC START# *52D00B00031A_C9CB01FB6D8E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_C9CB01FB6D8E_impl*
end;//TkwCfOldSituationSearchZoneContainer.SetValuePrim

function TkwCfOldSituationSearchZoneContainer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwCfOldSituationSearchZoneContainer.GetResultTypeInfo

function TkwCfOldSituationSearchZoneContainer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfOldSituationSearchZoneContainer.GetAllParamsCount

function TkwCfOldSituationSearchZoneContainer.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCfOldSituationSearchZoneContainer.ParamsTypes

function TkwCfOldSituationSearchChildZone.ChildZone(const aCtx: TtfwContext;
 acfOldSituationSearch: TcfOldSituationSearch): TvtPanel;
 {* Реализация слова скрипта .TcfOldSituationSearch.ChildZone }
//#UC START# *FB844D9C260B_6E6F2EE2FBD4_var*
//#UC END# *FB844D9C260B_6E6F2EE2FBD4_var*
begin
//#UC START# *FB844D9C260B_6E6F2EE2FBD4_impl*
 !!! Needs to be implemented !!!
//#UC END# *FB844D9C260B_6E6F2EE2FBD4_impl*
end;//TkwCfOldSituationSearchChildZone.ChildZone

procedure TkwCfOldSituationSearchChildZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6E6F2EE2FBD4_var*
//#UC END# *4DAEEDE10285_6E6F2EE2FBD4_var*
begin
//#UC START# *4DAEEDE10285_6E6F2EE2FBD4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6E6F2EE2FBD4_impl*
end;//TkwCfOldSituationSearchChildZone.DoDoIt

class function TkwCfOldSituationSearchChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfOldSituationSearch.ChildZone';
end;//TkwCfOldSituationSearchChildZone.GetWordNameForRegister

procedure TkwCfOldSituationSearchChildZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_6E6F2EE2FBD4_var*
//#UC END# *52D00B00031A_6E6F2EE2FBD4_var*
begin
//#UC START# *52D00B00031A_6E6F2EE2FBD4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_6E6F2EE2FBD4_impl*
end;//TkwCfOldSituationSearchChildZone.SetValuePrim

function TkwCfOldSituationSearchChildZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfOldSituationSearchChildZone.GetResultTypeInfo

function TkwCfOldSituationSearchChildZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfOldSituationSearchChildZone.GetAllParamsCount

function TkwCfOldSituationSearchChildZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCfOldSituationSearchChildZone.ParamsTypes

function TkwCfOldSituationSearchMainZone.MainZone(const aCtx: TtfwContext;
 acfOldSituationSearch: TcfOldSituationSearch): TvtSizeablePanel;
 {* Реализация слова скрипта .TcfOldSituationSearch.MainZone }
//#UC START# *D83D81F762D1_6CD72A3FA477_var*
//#UC END# *D83D81F762D1_6CD72A3FA477_var*
begin
//#UC START# *D83D81F762D1_6CD72A3FA477_impl*
 !!! Needs to be implemented !!!
//#UC END# *D83D81F762D1_6CD72A3FA477_impl*
end;//TkwCfOldSituationSearchMainZone.MainZone

procedure TkwCfOldSituationSearchMainZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6CD72A3FA477_var*
//#UC END# *4DAEEDE10285_6CD72A3FA477_var*
begin
//#UC START# *4DAEEDE10285_6CD72A3FA477_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6CD72A3FA477_impl*
end;//TkwCfOldSituationSearchMainZone.DoDoIt

class function TkwCfOldSituationSearchMainZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfOldSituationSearch.MainZone';
end;//TkwCfOldSituationSearchMainZone.GetWordNameForRegister

procedure TkwCfOldSituationSearchMainZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_6CD72A3FA477_var*
//#UC END# *52D00B00031A_6CD72A3FA477_var*
begin
//#UC START# *52D00B00031A_6CD72A3FA477_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_6CD72A3FA477_impl*
end;//TkwCfOldSituationSearchMainZone.SetValuePrim

function TkwCfOldSituationSearchMainZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwCfOldSituationSearchMainZone.GetResultTypeInfo

function TkwCfOldSituationSearchMainZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfOldSituationSearchMainZone.GetAllParamsCount

function TkwCfOldSituationSearchMainZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCfOldSituationSearchMainZone.ParamsTypes

initialization
 Tkw_Form_OldSituationSearch.RegisterInEngine;
 {* Регистрация Tkw_Form_OldSituationSearch }
 Tkw_OldSituationSearch_Control_BackgroundPanel.RegisterInEngine;
 {* Регистрация Tkw_OldSituationSearch_Control_BackgroundPanel }
 Tkw_OldSituationSearch_Control_BackgroundPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_OldSituationSearch_Control_BackgroundPanel_Push }
 Tkw_OldSituationSearch_Control_ContextFilter.RegisterInEngine;
 {* Регистрация Tkw_OldSituationSearch_Control_ContextFilter }
 Tkw_OldSituationSearch_Control_ContextFilter_Push.RegisterInEngine;
 {* Регистрация Tkw_OldSituationSearch_Control_ContextFilter_Push }
 Tkw_OldSituationSearch_Control_InnerBackgroundPanel.RegisterInEngine;
 {* Регистрация Tkw_OldSituationSearch_Control_InnerBackgroundPanel }
 Tkw_OldSituationSearch_Control_InnerBackgroundPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_OldSituationSearch_Control_InnerBackgroundPanel_Push }
 Tkw_OldSituationSearch_Control_BotomPanel.RegisterInEngine;
 {* Регистрация Tkw_OldSituationSearch_Control_BotomPanel }
 Tkw_OldSituationSearch_Control_BotomPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_OldSituationSearch_Control_BotomPanel_Push }
 Tkw_OldSituationSearch_Control_ParentZone.RegisterInEngine;
 {* Регистрация Tkw_OldSituationSearch_Control_ParentZone }
 Tkw_OldSituationSearch_Control_ParentZone_Push.RegisterInEngine;
 {* Регистрация Tkw_OldSituationSearch_Control_ParentZone_Push }
 Tkw_OldSituationSearch_Control_ZoneContainer.RegisterInEngine;
 {* Регистрация Tkw_OldSituationSearch_Control_ZoneContainer }
 Tkw_OldSituationSearch_Control_ZoneContainer_Push.RegisterInEngine;
 {* Регистрация Tkw_OldSituationSearch_Control_ZoneContainer_Push }
 Tkw_OldSituationSearch_Control_ChildZone.RegisterInEngine;
 {* Регистрация Tkw_OldSituationSearch_Control_ChildZone }
 Tkw_OldSituationSearch_Control_ChildZone_Push.RegisterInEngine;
 {* Регистрация Tkw_OldSituationSearch_Control_ChildZone_Push }
 Tkw_OldSituationSearch_Control_MainZone.RegisterInEngine;
 {* Регистрация Tkw_OldSituationSearch_Control_MainZone }
 Tkw_OldSituationSearch_Control_MainZone_Push.RegisterInEngine;
 {* Регистрация Tkw_OldSituationSearch_Control_MainZone_Push }
 TkwCfOldSituationSearchBackgroundPanel.RegisterInEngine;
 {* Регистрация cfOldSituationSearch_BackgroundPanel }
 TkwCfOldSituationSearchContextFilter.RegisterInEngine;
 {* Регистрация cfOldSituationSearch_ContextFilter }
 TkwCfOldSituationSearchInnerBackgroundPanel.RegisterInEngine;
 {* Регистрация cfOldSituationSearch_InnerBackgroundPanel }
 TkwCfOldSituationSearchBotomPanel.RegisterInEngine;
 {* Регистрация cfOldSituationSearch_BotomPanel }
 TkwCfOldSituationSearchParentZone.RegisterInEngine;
 {* Регистрация cfOldSituationSearch_ParentZone }
 TkwCfOldSituationSearchZoneContainer.RegisterInEngine;
 {* Регистрация cfOldSituationSearch_ZoneContainer }
 TkwCfOldSituationSearchChildZone.RegisterInEngine;
 {* Регистрация cfOldSituationSearch_ChildZone }
 TkwCfOldSituationSearchMainZone.RegisterInEngine;
 {* Регистрация cfOldSituationSearch_MainZone }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TcfOldSituationSearch));
 {* Регистрация типа OldSituationSearch }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* Регистрация типа TnscContextFilter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* Регистрация типа TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* Регистрация типа TvtSizeablePanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.

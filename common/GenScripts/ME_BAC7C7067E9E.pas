unit OldSituationSearchKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы OldSituationSearch }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\OldSituationSearchKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
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
begin
 Result := 'cfOldSituationSearch';
end;//Tkw_Form_OldSituationSearch.GetString

class function Tkw_OldSituationSearch_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_OldSituationSearch_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_OldSituationSearch_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_OldSituationSearch_Control_BackgroundPanel.GetString

class procedure Tkw_OldSituationSearch_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
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
begin
 Result := 'ContextFilter';
end;//Tkw_OldSituationSearch_Control_ContextFilter.GetString

class procedure Tkw_OldSituationSearch_Control_ContextFilter.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
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
begin
 Result := 'InnerBackgroundPanel';
end;//Tkw_OldSituationSearch_Control_InnerBackgroundPanel.GetString

class procedure Tkw_OldSituationSearch_Control_InnerBackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
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
begin
 Result := 'BotomPanel';
end;//Tkw_OldSituationSearch_Control_BotomPanel.GetString

class procedure Tkw_OldSituationSearch_Control_BotomPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
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
begin
 Result := 'ParentZone';
end;//Tkw_OldSituationSearch_Control_ParentZone.GetString

class procedure Tkw_OldSituationSearch_Control_ParentZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
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
begin
 Result := 'ZoneContainer';
end;//Tkw_OldSituationSearch_Control_ZoneContainer.GetString

class procedure Tkw_OldSituationSearch_Control_ZoneContainer.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
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
begin
 Result := 'ChildZone';
end;//Tkw_OldSituationSearch_Control_ChildZone.GetString

class procedure Tkw_OldSituationSearch_Control_ChildZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
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
begin
 Result := 'MainZone';
end;//Tkw_OldSituationSearch_Control_MainZone.GetString

class procedure Tkw_OldSituationSearch_Control_MainZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
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
begin
 Result := acfOldSituationSearch.BackgroundPanel;
end;//TkwCfOldSituationSearchBackgroundPanel.BackgroundPanel

procedure TkwCfOldSituationSearchBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_acfOldSituationSearch: TcfOldSituationSearch;
begin
 try
  l_acfOldSituationSearch := TcfOldSituationSearch(aCtx.rEngine.PopObjAs(TcfOldSituationSearch));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfOldSituationSearch: TcfOldSituationSearch : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_acfOldSituationSearch));
end;//TkwCfOldSituationSearchBackgroundPanel.DoDoIt

class function TkwCfOldSituationSearchBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfOldSituationSearch.BackgroundPanel';
end;//TkwCfOldSituationSearchBackgroundPanel.GetWordNameForRegister

procedure TkwCfOldSituationSearchBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TcfOldSituationSearch)]);
end;//TkwCfOldSituationSearchBackgroundPanel.ParamsTypes

function TkwCfOldSituationSearchContextFilter.ContextFilter(const aCtx: TtfwContext;
 acfOldSituationSearch: TcfOldSituationSearch): TnscContextFilter;
 {* Реализация слова скрипта .TcfOldSituationSearch.ContextFilter }
begin
 Result := acfOldSituationSearch.ContextFilter;
end;//TkwCfOldSituationSearchContextFilter.ContextFilter

procedure TkwCfOldSituationSearchContextFilter.DoDoIt(const aCtx: TtfwContext);
var l_acfOldSituationSearch: TcfOldSituationSearch;
begin
 try
  l_acfOldSituationSearch := TcfOldSituationSearch(aCtx.rEngine.PopObjAs(TcfOldSituationSearch));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfOldSituationSearch: TcfOldSituationSearch : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ContextFilter(aCtx, l_acfOldSituationSearch));
end;//TkwCfOldSituationSearchContextFilter.DoDoIt

class function TkwCfOldSituationSearchContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfOldSituationSearch.ContextFilter';
end;//TkwCfOldSituationSearchContextFilter.GetWordNameForRegister

procedure TkwCfOldSituationSearchContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ContextFilter', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TcfOldSituationSearch)]);
end;//TkwCfOldSituationSearchContextFilter.ParamsTypes

function TkwCfOldSituationSearchInnerBackgroundPanel.InnerBackgroundPanel(const aCtx: TtfwContext;
 acfOldSituationSearch: TcfOldSituationSearch): TvtProportionalPanel;
 {* Реализация слова скрипта .TcfOldSituationSearch.InnerBackgroundPanel }
begin
 Result := acfOldSituationSearch.InnerBackgroundPanel;
end;//TkwCfOldSituationSearchInnerBackgroundPanel.InnerBackgroundPanel

procedure TkwCfOldSituationSearchInnerBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_acfOldSituationSearch: TcfOldSituationSearch;
begin
 try
  l_acfOldSituationSearch := TcfOldSituationSearch(aCtx.rEngine.PopObjAs(TcfOldSituationSearch));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfOldSituationSearch: TcfOldSituationSearch : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(InnerBackgroundPanel(aCtx, l_acfOldSituationSearch));
end;//TkwCfOldSituationSearchInnerBackgroundPanel.DoDoIt

class function TkwCfOldSituationSearchInnerBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfOldSituationSearch.InnerBackgroundPanel';
end;//TkwCfOldSituationSearchInnerBackgroundPanel.GetWordNameForRegister

procedure TkwCfOldSituationSearchInnerBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству InnerBackgroundPanel', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TcfOldSituationSearch)]);
end;//TkwCfOldSituationSearchInnerBackgroundPanel.ParamsTypes

function TkwCfOldSituationSearchBotomPanel.BotomPanel(const aCtx: TtfwContext;
 acfOldSituationSearch: TcfOldSituationSearch): TvtSizeablePanel;
 {* Реализация слова скрипта .TcfOldSituationSearch.BotomPanel }
begin
 Result := acfOldSituationSearch.BotomPanel;
end;//TkwCfOldSituationSearchBotomPanel.BotomPanel

procedure TkwCfOldSituationSearchBotomPanel.DoDoIt(const aCtx: TtfwContext);
var l_acfOldSituationSearch: TcfOldSituationSearch;
begin
 try
  l_acfOldSituationSearch := TcfOldSituationSearch(aCtx.rEngine.PopObjAs(TcfOldSituationSearch));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfOldSituationSearch: TcfOldSituationSearch : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BotomPanel(aCtx, l_acfOldSituationSearch));
end;//TkwCfOldSituationSearchBotomPanel.DoDoIt

class function TkwCfOldSituationSearchBotomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfOldSituationSearch.BotomPanel';
end;//TkwCfOldSituationSearchBotomPanel.GetWordNameForRegister

procedure TkwCfOldSituationSearchBotomPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BotomPanel', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TcfOldSituationSearch)]);
end;//TkwCfOldSituationSearchBotomPanel.ParamsTypes

function TkwCfOldSituationSearchParentZone.ParentZone(const aCtx: TtfwContext;
 acfOldSituationSearch: TcfOldSituationSearch): TvtPanel;
 {* Реализация слова скрипта .TcfOldSituationSearch.ParentZone }
begin
 Result := acfOldSituationSearch.ParentZone;
end;//TkwCfOldSituationSearchParentZone.ParentZone

procedure TkwCfOldSituationSearchParentZone.DoDoIt(const aCtx: TtfwContext);
var l_acfOldSituationSearch: TcfOldSituationSearch;
begin
 try
  l_acfOldSituationSearch := TcfOldSituationSearch(aCtx.rEngine.PopObjAs(TcfOldSituationSearch));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfOldSituationSearch: TcfOldSituationSearch : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ParentZone(aCtx, l_acfOldSituationSearch));
end;//TkwCfOldSituationSearchParentZone.DoDoIt

class function TkwCfOldSituationSearchParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfOldSituationSearch.ParentZone';
end;//TkwCfOldSituationSearchParentZone.GetWordNameForRegister

procedure TkwCfOldSituationSearchParentZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ParentZone', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TcfOldSituationSearch)]);
end;//TkwCfOldSituationSearchParentZone.ParamsTypes

function TkwCfOldSituationSearchZoneContainer.ZoneContainer(const aCtx: TtfwContext;
 acfOldSituationSearch: TcfOldSituationSearch): TvtProportionalPanel;
 {* Реализация слова скрипта .TcfOldSituationSearch.ZoneContainer }
begin
 Result := acfOldSituationSearch.ZoneContainer;
end;//TkwCfOldSituationSearchZoneContainer.ZoneContainer

procedure TkwCfOldSituationSearchZoneContainer.DoDoIt(const aCtx: TtfwContext);
var l_acfOldSituationSearch: TcfOldSituationSearch;
begin
 try
  l_acfOldSituationSearch := TcfOldSituationSearch(aCtx.rEngine.PopObjAs(TcfOldSituationSearch));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfOldSituationSearch: TcfOldSituationSearch : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ZoneContainer(aCtx, l_acfOldSituationSearch));
end;//TkwCfOldSituationSearchZoneContainer.DoDoIt

class function TkwCfOldSituationSearchZoneContainer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfOldSituationSearch.ZoneContainer';
end;//TkwCfOldSituationSearchZoneContainer.GetWordNameForRegister

procedure TkwCfOldSituationSearchZoneContainer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ZoneContainer', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TcfOldSituationSearch)]);
end;//TkwCfOldSituationSearchZoneContainer.ParamsTypes

function TkwCfOldSituationSearchChildZone.ChildZone(const aCtx: TtfwContext;
 acfOldSituationSearch: TcfOldSituationSearch): TvtPanel;
 {* Реализация слова скрипта .TcfOldSituationSearch.ChildZone }
begin
 Result := acfOldSituationSearch.ChildZone;
end;//TkwCfOldSituationSearchChildZone.ChildZone

procedure TkwCfOldSituationSearchChildZone.DoDoIt(const aCtx: TtfwContext);
var l_acfOldSituationSearch: TcfOldSituationSearch;
begin
 try
  l_acfOldSituationSearch := TcfOldSituationSearch(aCtx.rEngine.PopObjAs(TcfOldSituationSearch));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfOldSituationSearch: TcfOldSituationSearch : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ChildZone(aCtx, l_acfOldSituationSearch));
end;//TkwCfOldSituationSearchChildZone.DoDoIt

class function TkwCfOldSituationSearchChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfOldSituationSearch.ChildZone';
end;//TkwCfOldSituationSearchChildZone.GetWordNameForRegister

procedure TkwCfOldSituationSearchChildZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ChildZone', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TcfOldSituationSearch)]);
end;//TkwCfOldSituationSearchChildZone.ParamsTypes

function TkwCfOldSituationSearchMainZone.MainZone(const aCtx: TtfwContext;
 acfOldSituationSearch: TcfOldSituationSearch): TvtSizeablePanel;
 {* Реализация слова скрипта .TcfOldSituationSearch.MainZone }
begin
 Result := acfOldSituationSearch.MainZone;
end;//TkwCfOldSituationSearchMainZone.MainZone

procedure TkwCfOldSituationSearchMainZone.DoDoIt(const aCtx: TtfwContext);
var l_acfOldSituationSearch: TcfOldSituationSearch;
begin
 try
  l_acfOldSituationSearch := TcfOldSituationSearch(aCtx.rEngine.PopObjAs(TcfOldSituationSearch));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfOldSituationSearch: TcfOldSituationSearch : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(MainZone(aCtx, l_acfOldSituationSearch));
end;//TkwCfOldSituationSearchMainZone.DoDoIt

class function TkwCfOldSituationSearchMainZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfOldSituationSearch.MainZone';
end;//TkwCfOldSituationSearchMainZone.GetWordNameForRegister

procedure TkwCfOldSituationSearchMainZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству MainZone', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TcfOldSituationSearch)]);
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

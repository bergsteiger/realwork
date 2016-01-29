unit MainKeywordsPack;

interface

uses
 l3IntfUses
 , NewGenRes
 , nscStatusBar
 , vtPanel
 , vtProportionalPanel
 , vtSizeablePanel
 , nscNavigator
 , tfwControlString
 , kwBynameControlPush
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_Main = class(TtfwControlString)
  {* Слово словаря для идентификатора формы Main
----
*Пример использования*:
[code]
'aControl' форма::Main TryFocus ASSERT
[code] }
 end;//Tkw_Form_Main
 
 Tkw_Main_Control_StatusBar = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола StatusBar
----
*Пример использования*:
[code]
контрол::StatusBar TryFocus ASSERT
[code] }
 end;//Tkw_Main_Control_StatusBar
 
 Tkw_Main_Control_StatusBar_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола StatusBar
----
*Пример использования*:
[code]
контрол::StatusBar:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_Main_Control_StatusBar_Push
 
 Tkw_Main_Control_ClientZone = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ClientZone
----
*Пример использования*:
[code]
контрол::ClientZone TryFocus ASSERT
[code] }
 end;//Tkw_Main_Control_ClientZone
 
 Tkw_Main_Control_ClientZone_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола ClientZone
----
*Пример использования*:
[code]
контрол::ClientZone:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_Main_Control_ClientZone_Push
 
 Tkw_Main_Control_MainZone = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола MainZone
----
*Пример использования*:
[code]
контрол::MainZone TryFocus ASSERT
[code] }
 end;//Tkw_Main_Control_MainZone
 
 Tkw_Main_Control_MainZone_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола MainZone
----
*Пример использования*:
[code]
контрол::MainZone:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_Main_Control_MainZone_Push
 
 Tkw_Main_Control_ParentZonePanel = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ParentZonePanel
----
*Пример использования*:
[code]
контрол::ParentZonePanel TryFocus ASSERT
[code] }
 end;//Tkw_Main_Control_ParentZonePanel
 
 Tkw_Main_Control_ParentZonePanel_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола ParentZonePanel
----
*Пример использования*:
[code]
контрол::ParentZonePanel:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_Main_Control_ParentZonePanel_Push
 
 Tkw_Main_Control_ChildZonePanel = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ChildZonePanel
----
*Пример использования*:
[code]
контрол::ChildZonePanel TryFocus ASSERT
[code] }
 end;//Tkw_Main_Control_ChildZonePanel
 
 Tkw_Main_Control_ChildZonePanel_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола ChildZonePanel
----
*Пример использования*:
[code]
контрол::ChildZonePanel:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_Main_Control_ChildZonePanel_Push
 
 Tkw_Main_Control_BaseSearchPanel = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BaseSearchPanel
----
*Пример использования*:
[code]
контрол::BaseSearchPanel TryFocus ASSERT
[code] }
 end;//Tkw_Main_Control_BaseSearchPanel
 
 Tkw_Main_Control_BaseSearchPanel_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола BaseSearchPanel
----
*Пример использования*:
[code]
контрол::BaseSearchPanel:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_Main_Control_BaseSearchPanel_Push
 
 Tkw_Main_Control_LeftNavigator = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола LeftNavigator
----
*Пример использования*:
[code]
контрол::LeftNavigator TryFocus ASSERT
[code] }
 end;//Tkw_Main_Control_LeftNavigator
 
 Tkw_Main_Control_LeftNavigator_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола LeftNavigator
----
*Пример использования*:
[code]
контрол::LeftNavigator:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_Main_Control_LeftNavigator_Push
 
 Tkw_Main_Control_RightNavigator = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола RightNavigator
----
*Пример использования*:
[code]
контрол::RightNavigator TryFocus ASSERT
[code] }
 end;//Tkw_Main_Control_RightNavigator
 
 Tkw_Main_Control_RightNavigator_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола RightNavigator
----
*Пример использования*:
[code]
контрол::RightNavigator:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_Main_Control_RightNavigator_Push
 
 TkwMainFormStatusBar = class(TtfwPropertyLike)
  {* Слово скрипта .TMainForm.StatusBar
[panel]Контрол StatusBar формы TMainForm[panel]
*Тип результата:* TnscStatusBar
*Пример:*
[code]
OBJECT VAR l_TnscStatusBar
 aMainForm .TMainForm.StatusBar >>> l_TnscStatusBar
[code]  }
  function StatusBar(const aCtx: TtfwContext;
   aMainForm: TMainForm): TnscStatusBar;
   {* Реализация слова скрипта .TMainForm.StatusBar }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMainFormStatusBar
 
 TkwMainFormClientZone = class(TtfwPropertyLike)
  {* Слово скрипта .TMainForm.ClientZone
[panel]Контрол ClientZone формы TMainForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aMainForm .TMainForm.ClientZone >>> l_TvtPanel
[code]  }
  function ClientZone(const aCtx: TtfwContext;
   aMainForm: TMainForm): TvtPanel;
   {* Реализация слова скрипта .TMainForm.ClientZone }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMainFormClientZone
 
 TkwMainFormMainZone = class(TtfwPropertyLike)
  {* Слово скрипта .TMainForm.MainZone
[panel]Контрол MainZone формы TMainForm[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aMainForm .TMainForm.MainZone >>> l_TvtProportionalPanel
[code]  }
  function MainZone(const aCtx: TtfwContext;
   aMainForm: TMainForm): TvtProportionalPanel;
   {* Реализация слова скрипта .TMainForm.MainZone }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMainFormMainZone
 
 TkwMainFormParentZonePanel = class(TtfwPropertyLike)
  {* Слово скрипта .TMainForm.ParentZonePanel
[panel]Контрол ParentZonePanel формы TMainForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aMainForm .TMainForm.ParentZonePanel >>> l_TvtPanel
[code]  }
  function ParentZonePanel(const aCtx: TtfwContext;
   aMainForm: TMainForm): TvtPanel;
   {* Реализация слова скрипта .TMainForm.ParentZonePanel }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMainFormParentZonePanel
 
 TkwMainFormChildZonePanel = class(TtfwPropertyLike)
  {* Слово скрипта .TMainForm.ChildZonePanel
[panel]Контрол ChildZonePanel формы TMainForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aMainForm .TMainForm.ChildZonePanel >>> l_TvtSizeablePanel
[code]  }
  function ChildZonePanel(const aCtx: TtfwContext;
   aMainForm: TMainForm): TvtSizeablePanel;
   {* Реализация слова скрипта .TMainForm.ChildZonePanel }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMainFormChildZonePanel
 
 TkwMainFormBaseSearchPanel = class(TtfwPropertyLike)
  {* Слово скрипта .TMainForm.BaseSearchPanel
[panel]Контрол BaseSearchPanel формы TMainForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aMainForm .TMainForm.BaseSearchPanel >>> l_TvtPanel
[code]  }
  function BaseSearchPanel(const aCtx: TtfwContext;
   aMainForm: TMainForm): TvtPanel;
   {* Реализация слова скрипта .TMainForm.BaseSearchPanel }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMainFormBaseSearchPanel
 
 TkwMainFormLeftNavigator = class(TtfwPropertyLike)
  {* Слово скрипта .TMainForm.LeftNavigator
[panel]Контрол LeftNavigator формы TMainForm[panel]
*Тип результата:* TnscNavigator
*Пример:*
[code]
OBJECT VAR l_TnscNavigator
 aMainForm .TMainForm.LeftNavigator >>> l_TnscNavigator
[code]  }
  function LeftNavigator(const aCtx: TtfwContext;
   aMainForm: TMainForm): TnscNavigator;
   {* Реализация слова скрипта .TMainForm.LeftNavigator }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMainFormLeftNavigator
 
 TkwMainFormRightNavigator = class(TtfwPropertyLike)
  {* Слово скрипта .TMainForm.RightNavigator
[panel]Контрол RightNavigator формы TMainForm[panel]
*Тип результата:* TnscNavigator
*Пример:*
[code]
OBJECT VAR l_TnscNavigator
 aMainForm .TMainForm.RightNavigator >>> l_TnscNavigator
[code]  }
  function RightNavigator(const aCtx: TtfwContext;
   aMainForm: TMainForm): TnscNavigator;
   {* Реализация слова скрипта .TMainForm.RightNavigator }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMainFormRightNavigator
 
end.

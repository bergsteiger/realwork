unit vcmTabsWordsPack;

interface

uses
 l3IntfUses
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
 , l3TabbedContainersDispatcher
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwVcmTabsCloseCurrent = class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:CloseCurrent
[panel]Закрыть текущую вкладку в активном окне. Не закрывает последнюю.[panel]
*Пример:*
[code]
 vcm:tabs:CloseCurrent
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsCloseCurrent
 
 TkwVcmTabsClose = class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:Close
[panel]Закрыть вкладку по индексу. Нумерация с нуля.[panel]
*Пример:*
[code]
 aTabIndex vcm:tabs:Close
[code]  }
  procedure vcm_tabs_Close(const aCtx: TtfwContext;
   aTabIndex: Integer);
   {* Реализация слова скрипта vcm:tabs:Close }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsClose
 
 TkwVcmTabsCloseAllButCurrent = class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:CloseAllButCurrent
[panel]Закрыть все вкладки кроме текущей в активном окне[panel]
*Пример:*
[code]
 vcm:tabs:CloseAllButCurrent
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsCloseAllButCurrent
 
 TkwVcmTabsActive = class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:Active
[panel]Номер активной вкладки в текущем окне. Нумерация с нуля.[panel]
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 vcm:tabs:Active >>> l_Integer
[code]  }
  function vcm_tabs_Active(const aCtx: TtfwContext): Integer;
   {* Реализация слова скрипта vcm:tabs:Active }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsActive
 
 TkwVcmTabsSetActive = class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:SetActive
[panel]Перейти на вкладку в активном окне (нумерация с нуля)[panel]
*Пример:*
[code]
 aValue vcm:tabs:SetActive
[code]  }
  procedure vcm_tabs_SetActive(const aCtx: TtfwContext;
   aValue: Integer);
   {* Реализация слова скрипта vcm:tabs:SetActive }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsSetActive
 
 TkwVcmTabsCount = class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:Count
[panel]Количество вкладок в активном окне[panel]
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 vcm:tabs:Count >>> l_Integer
[code]  }
  function vcm_tabs_Count(const aCtx: TtfwContext): Integer;
   {* Реализация слова скрипта vcm:tabs:Count }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsCount
 
 TkwVcmTabsOpenNewTab = class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:OpenNewTab
[panel]Открыть новую вкладку в активном окне[panel]
*Пример:*
[code]
 vcm:tabs:OpenNewTab
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsOpenNewTab
 
 TkwVcmTabsCanOpenNewTab = class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:CanOpenNewTab
[panel]Можно ли открыть новую вкладку в активном окне[panel]
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 vcm:tabs:CanOpenNewTab >>> l_Boolean
[code]  }
  function vcm_tabs_CanOpenNewTab(const aCtx: TtfwContext): Boolean;
   {* Реализация слова скрипта vcm:tabs:CanOpenNewTab }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsCanOpenNewTab
 
 TkwVcmTabsDuplicate = class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:Duplicate
[panel]Дублировать вкладку в активном окне[panel]
*Пример:*
[code]
 aTabIndex vcm:tabs:Duplicate
[code]  }
  procedure vcm_tabs_Duplicate(const aCtx: TtfwContext;
   aTabIndex: Integer);
   {* Реализация слова скрипта vcm:tabs:Duplicate }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsDuplicate
 
 TkwVcmTabsCanDuplicate = class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:CanDuplicate
[panel]Можно ли дублировать вкладку в активном окне[panel]
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTabIndex vcm:tabs:CanDuplicate >>> l_Boolean
[code]  }
  function vcm_tabs_CanDuplicate(const aCtx: TtfwContext;
   aTabIndex: Integer): Boolean;
   {* Реализация слова скрипта vcm:tabs:CanDuplicate }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsCanDuplicate
 
 TkwVcmTabsReopen = class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:Reopen
[panel]Открыть закрытую вкладку в активном окне[panel]
*Пример:*
[code]
 vcm:tabs:Reopen
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsReopen
 
 TkwVcmTabsCanReopen = class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:CanReopen
[panel]Можно ли открыть закрытую вкладку в активном окне[panel]
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 vcm:tabs:CanReopen >>> l_Boolean
[code]  }
  function vcm_tabs_CanReopen(const aCtx: TtfwContext): Boolean;
   {* Реализация слова скрипта vcm:tabs:CanReopen }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsCanReopen
 
 TkwVcmTabsGetIconIndex = class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:GetIconIndex
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aTabIndex vcm:tabs:GetIconIndex >>> l_Integer
[code]  }
  function vcm_tabs_GetIconIndex(const aCtx: TtfwContext;
   aTabIndex: Integer): Integer;
   {* Реализация слова скрипта vcm:tabs:GetIconIndex }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsGetIconIndex
 
end.

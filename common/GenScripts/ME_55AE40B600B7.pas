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
  {* ����� ������� vcm:tabs:CloseCurrent
[panel]������� ������� ������� � �������� ����. �� ��������� ���������.[panel]
*������:*
[code]
 vcm:tabs:CloseCurrent
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsCloseCurrent
 
 TkwVcmTabsClose = class(TtfwGlobalKeyWord)
  {* ����� ������� vcm:tabs:Close
[panel]������� ������� �� �������. ��������� � ����.[panel]
*������:*
[code]
 aTabIndex vcm:tabs:Close
[code]  }
  procedure vcm_tabs_Close(const aCtx: TtfwContext;
   aTabIndex: Integer);
   {* ���������� ����� ������� vcm:tabs:Close }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsClose
 
 TkwVcmTabsCloseAllButCurrent = class(TtfwGlobalKeyWord)
  {* ����� ������� vcm:tabs:CloseAllButCurrent
[panel]������� ��� ������� ����� ������� � �������� ����[panel]
*������:*
[code]
 vcm:tabs:CloseAllButCurrent
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsCloseAllButCurrent
 
 TkwVcmTabsActive = class(TtfwGlobalKeyWord)
  {* ����� ������� vcm:tabs:Active
[panel]����� �������� ������� � ������� ����. ��������� � ����.[panel]
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 vcm:tabs:Active >>> l_Integer
[code]  }
  function vcm_tabs_Active(const aCtx: TtfwContext): Integer;
   {* ���������� ����� ������� vcm:tabs:Active }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsActive
 
 TkwVcmTabsSetActive = class(TtfwGlobalKeyWord)
  {* ����� ������� vcm:tabs:SetActive
[panel]������� �� ������� � �������� ���� (��������� � ����)[panel]
*������:*
[code]
 aValue vcm:tabs:SetActive
[code]  }
  procedure vcm_tabs_SetActive(const aCtx: TtfwContext;
   aValue: Integer);
   {* ���������� ����� ������� vcm:tabs:SetActive }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsSetActive
 
 TkwVcmTabsCount = class(TtfwGlobalKeyWord)
  {* ����� ������� vcm:tabs:Count
[panel]���������� ������� � �������� ����[panel]
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 vcm:tabs:Count >>> l_Integer
[code]  }
  function vcm_tabs_Count(const aCtx: TtfwContext): Integer;
   {* ���������� ����� ������� vcm:tabs:Count }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsCount
 
 TkwVcmTabsOpenNewTab = class(TtfwGlobalKeyWord)
  {* ����� ������� vcm:tabs:OpenNewTab
[panel]������� ����� ������� � �������� ����[panel]
*������:*
[code]
 vcm:tabs:OpenNewTab
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsOpenNewTab
 
 TkwVcmTabsCanOpenNewTab = class(TtfwGlobalKeyWord)
  {* ����� ������� vcm:tabs:CanOpenNewTab
[panel]����� �� ������� ����� ������� � �������� ����[panel]
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 vcm:tabs:CanOpenNewTab >>> l_Boolean
[code]  }
  function vcm_tabs_CanOpenNewTab(const aCtx: TtfwContext): Boolean;
   {* ���������� ����� ������� vcm:tabs:CanOpenNewTab }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsCanOpenNewTab
 
 TkwVcmTabsDuplicate = class(TtfwGlobalKeyWord)
  {* ����� ������� vcm:tabs:Duplicate
[panel]����������� ������� � �������� ����[panel]
*������:*
[code]
 aTabIndex vcm:tabs:Duplicate
[code]  }
  procedure vcm_tabs_Duplicate(const aCtx: TtfwContext;
   aTabIndex: Integer);
   {* ���������� ����� ������� vcm:tabs:Duplicate }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsDuplicate
 
 TkwVcmTabsCanDuplicate = class(TtfwGlobalKeyWord)
  {* ����� ������� vcm:tabs:CanDuplicate
[panel]����� �� ����������� ������� � �������� ����[panel]
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aTabIndex vcm:tabs:CanDuplicate >>> l_Boolean
[code]  }
  function vcm_tabs_CanDuplicate(const aCtx: TtfwContext;
   aTabIndex: Integer): Boolean;
   {* ���������� ����� ������� vcm:tabs:CanDuplicate }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsCanDuplicate
 
 TkwVcmTabsReopen = class(TtfwGlobalKeyWord)
  {* ����� ������� vcm:tabs:Reopen
[panel]������� �������� ������� � �������� ����[panel]
*������:*
[code]
 vcm:tabs:Reopen
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsReopen
 
 TkwVcmTabsCanReopen = class(TtfwGlobalKeyWord)
  {* ����� ������� vcm:tabs:CanReopen
[panel]����� �� ������� �������� ������� � �������� ����[panel]
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 vcm:tabs:CanReopen >>> l_Boolean
[code]  }
  function vcm_tabs_CanReopen(const aCtx: TtfwContext): Boolean;
   {* ���������� ����� ������� vcm:tabs:CanReopen }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsCanReopen
 
 TkwVcmTabsGetIconIndex = class(TtfwGlobalKeyWord)
  {* ����� ������� vcm:tabs:GetIconIndex
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aTabIndex vcm:tabs:GetIconIndex >>> l_Integer
[code]  }
  function vcm_tabs_GetIconIndex(const aCtx: TtfwContext;
   aTabIndex: Integer): Integer;
   {* ���������� ����� ������� vcm:tabs:GetIconIndex }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmTabsGetIconIndex
 
end.

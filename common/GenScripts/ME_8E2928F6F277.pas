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
  {* ����� ������� ��� �������������� ����� Main
----
*������ �������������*:
[code]
'aControl' �����::Main TryFocus ASSERT
[code] }
 end;//Tkw_Form_Main
 
 Tkw_Main_Control_StatusBar = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� StatusBar
----
*������ �������������*:
[code]
�������::StatusBar TryFocus ASSERT
[code] }
 end;//Tkw_Main_Control_StatusBar
 
 Tkw_Main_Control_StatusBar_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� StatusBar
----
*������ �������������*:
[code]
�������::StatusBar:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_Main_Control_StatusBar_Push
 
 Tkw_Main_Control_ClientZone = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ClientZone
----
*������ �������������*:
[code]
�������::ClientZone TryFocus ASSERT
[code] }
 end;//Tkw_Main_Control_ClientZone
 
 Tkw_Main_Control_ClientZone_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ClientZone
----
*������ �������������*:
[code]
�������::ClientZone:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_Main_Control_ClientZone_Push
 
 Tkw_Main_Control_MainZone = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� MainZone
----
*������ �������������*:
[code]
�������::MainZone TryFocus ASSERT
[code] }
 end;//Tkw_Main_Control_MainZone
 
 Tkw_Main_Control_MainZone_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� MainZone
----
*������ �������������*:
[code]
�������::MainZone:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_Main_Control_MainZone_Push
 
 Tkw_Main_Control_ParentZonePanel = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ParentZonePanel
----
*������ �������������*:
[code]
�������::ParentZonePanel TryFocus ASSERT
[code] }
 end;//Tkw_Main_Control_ParentZonePanel
 
 Tkw_Main_Control_ParentZonePanel_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ParentZonePanel
----
*������ �������������*:
[code]
�������::ParentZonePanel:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_Main_Control_ParentZonePanel_Push
 
 Tkw_Main_Control_ChildZonePanel = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ChildZonePanel
----
*������ �������������*:
[code]
�������::ChildZonePanel TryFocus ASSERT
[code] }
 end;//Tkw_Main_Control_ChildZonePanel
 
 Tkw_Main_Control_ChildZonePanel_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ChildZonePanel
----
*������ �������������*:
[code]
�������::ChildZonePanel:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_Main_Control_ChildZonePanel_Push
 
 Tkw_Main_Control_BaseSearchPanel = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BaseSearchPanel
----
*������ �������������*:
[code]
�������::BaseSearchPanel TryFocus ASSERT
[code] }
 end;//Tkw_Main_Control_BaseSearchPanel
 
 Tkw_Main_Control_BaseSearchPanel_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� BaseSearchPanel
----
*������ �������������*:
[code]
�������::BaseSearchPanel:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_Main_Control_BaseSearchPanel_Push
 
 Tkw_Main_Control_LeftNavigator = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� LeftNavigator
----
*������ �������������*:
[code]
�������::LeftNavigator TryFocus ASSERT
[code] }
 end;//Tkw_Main_Control_LeftNavigator
 
 Tkw_Main_Control_LeftNavigator_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� LeftNavigator
----
*������ �������������*:
[code]
�������::LeftNavigator:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_Main_Control_LeftNavigator_Push
 
 Tkw_Main_Control_RightNavigator = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� RightNavigator
----
*������ �������������*:
[code]
�������::RightNavigator TryFocus ASSERT
[code] }
 end;//Tkw_Main_Control_RightNavigator
 
 Tkw_Main_Control_RightNavigator_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� RightNavigator
----
*������ �������������*:
[code]
�������::RightNavigator:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_Main_Control_RightNavigator_Push
 
 TkwMainFormStatusBar = class(TtfwPropertyLike)
  {* ����� ������� .TMainForm.StatusBar
[panel]������� StatusBar ����� TMainForm[panel]
*��� ����������:* TnscStatusBar
*������:*
[code]
OBJECT VAR l_TnscStatusBar
 aMainForm .TMainForm.StatusBar >>> l_TnscStatusBar
[code]  }
  function StatusBar(const aCtx: TtfwContext;
   aMainForm: TMainForm): TnscStatusBar;
   {* ���������� ����� ������� .TMainForm.StatusBar }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMainFormStatusBar
 
 TkwMainFormClientZone = class(TtfwPropertyLike)
  {* ����� ������� .TMainForm.ClientZone
[panel]������� ClientZone ����� TMainForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aMainForm .TMainForm.ClientZone >>> l_TvtPanel
[code]  }
  function ClientZone(const aCtx: TtfwContext;
   aMainForm: TMainForm): TvtPanel;
   {* ���������� ����� ������� .TMainForm.ClientZone }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMainFormClientZone
 
 TkwMainFormMainZone = class(TtfwPropertyLike)
  {* ����� ������� .TMainForm.MainZone
[panel]������� MainZone ����� TMainForm[panel]
*��� ����������:* TvtProportionalPanel
*������:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aMainForm .TMainForm.MainZone >>> l_TvtProportionalPanel
[code]  }
  function MainZone(const aCtx: TtfwContext;
   aMainForm: TMainForm): TvtProportionalPanel;
   {* ���������� ����� ������� .TMainForm.MainZone }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMainFormMainZone
 
 TkwMainFormParentZonePanel = class(TtfwPropertyLike)
  {* ����� ������� .TMainForm.ParentZonePanel
[panel]������� ParentZonePanel ����� TMainForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aMainForm .TMainForm.ParentZonePanel >>> l_TvtPanel
[code]  }
  function ParentZonePanel(const aCtx: TtfwContext;
   aMainForm: TMainForm): TvtPanel;
   {* ���������� ����� ������� .TMainForm.ParentZonePanel }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMainFormParentZonePanel
 
 TkwMainFormChildZonePanel = class(TtfwPropertyLike)
  {* ����� ������� .TMainForm.ChildZonePanel
[panel]������� ChildZonePanel ����� TMainForm[panel]
*��� ����������:* TvtSizeablePanel
*������:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aMainForm .TMainForm.ChildZonePanel >>> l_TvtSizeablePanel
[code]  }
  function ChildZonePanel(const aCtx: TtfwContext;
   aMainForm: TMainForm): TvtSizeablePanel;
   {* ���������� ����� ������� .TMainForm.ChildZonePanel }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMainFormChildZonePanel
 
 TkwMainFormBaseSearchPanel = class(TtfwPropertyLike)
  {* ����� ������� .TMainForm.BaseSearchPanel
[panel]������� BaseSearchPanel ����� TMainForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aMainForm .TMainForm.BaseSearchPanel >>> l_TvtPanel
[code]  }
  function BaseSearchPanel(const aCtx: TtfwContext;
   aMainForm: TMainForm): TvtPanel;
   {* ���������� ����� ������� .TMainForm.BaseSearchPanel }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMainFormBaseSearchPanel
 
 TkwMainFormLeftNavigator = class(TtfwPropertyLike)
  {* ����� ������� .TMainForm.LeftNavigator
[panel]������� LeftNavigator ����� TMainForm[panel]
*��� ����������:* TnscNavigator
*������:*
[code]
OBJECT VAR l_TnscNavigator
 aMainForm .TMainForm.LeftNavigator >>> l_TnscNavigator
[code]  }
  function LeftNavigator(const aCtx: TtfwContext;
   aMainForm: TMainForm): TnscNavigator;
   {* ���������� ����� ������� .TMainForm.LeftNavigator }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMainFormLeftNavigator
 
 TkwMainFormRightNavigator = class(TtfwPropertyLike)
  {* ����� ������� .TMainForm.RightNavigator
[panel]������� RightNavigator ����� TMainForm[panel]
*��� ����������:* TnscNavigator
*������:*
[code]
OBJECT VAR l_TnscNavigator
 aMainForm .TMainForm.RightNavigator >>> l_TnscNavigator
[code]  }
  function RightNavigator(const aCtx: TtfwContext;
   aMainForm: TMainForm): TnscNavigator;
   {* ���������� ����� ������� .TMainForm.RightNavigator }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwMainFormRightNavigator
 
end.

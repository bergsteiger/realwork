unit ChildKeywordsPack;

interface

uses
 l3IntfUses
 , ParentAndChildPrim_Module
 , nscFormsPageControl
 , ElPgCtl
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
 Tkw_Form_Child = class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Child
----
*������ �������������*:
[code]
'aControl' �����::Child TryFocus ASSERT
[code] }
 end;//Tkw_Form_Child
 
 Tkw_Child_Control_ChildZone = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ChildZone
----
*������ �������������*:
[code]
�������::ChildZone TryFocus ASSERT
[code] }
 end;//Tkw_Child_Control_ChildZone
 
 Tkw_Child_Control_ChildZone_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ChildZone
----
*������ �������������*:
[code]
�������::ChildZone:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_Child_Control_ChildZone_Push
 
 Tkw_Child_Control_MainPageTab = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� MainPageTab
----
*������ �������������*:
[code]
�������::MainPageTab TryFocus ASSERT
[code] }
 end;//Tkw_Child_Control_MainPageTab
 
 Tkw_Child_Control_MainPageTab_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� MainPageTab
----
*������ �������������*:
[code]
�������::MainPageTab:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_Child_Control_MainPageTab_Push
 
 TkwChildFormChildZone = class(TtfwPropertyLike)
  {* ����� ������� .TChildForm.ChildZone
[panel]������� ChildZone ����� TChildForm[panel]
*��� ����������:* TnscFormsPageControl
*������:*
[code]
OBJECT VAR l_TnscFormsPageControl
 aChildForm .TChildForm.ChildZone >>> l_TnscFormsPageControl
[code]  }
  function ChildZone(const aCtx: TtfwContext;
   aChildForm: TChildForm): TnscFormsPageControl;
   {* ���������� ����� ������� .TChildForm.ChildZone }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwChildFormChildZone
 
 TkwChildFormMainPageTab = class(TtfwPropertyLike)
  {* ����� ������� .TChildForm.MainPageTab
[panel]������� MainPageTab ����� TChildForm[panel]
*��� ����������:* TElTabSheet
*������:*
[code]
OBJECT VAR l_TElTabSheet
 aChildForm .TChildForm.MainPageTab >>> l_TElTabSheet
[code]  }
  function MainPageTab(const aCtx: TtfwContext;
   aChildForm: TChildForm): TElTabSheet;
   {* ���������� ����� ������� .TChildForm.MainPageTab }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwChildFormMainPageTab
 
end.

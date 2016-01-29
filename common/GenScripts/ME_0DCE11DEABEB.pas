unit FromWithPanelKeywordsPack;

interface

uses
 l3IntfUses
 , FromWithPanel_Form
 , vtPanel
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
 Tkw_Form_FromWithPanel = class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� FromWithPanel
----
*������ �������������*:
[code]
'aControl' �����::FromWithPanel TryFocus ASSERT
[code] }
 end;//Tkw_Form_FromWithPanel
 
 Tkw_FromWithPanel_Control_WorkSpace = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� WorkSpace
----
*������ �������������*:
[code]
�������::WorkSpace TryFocus ASSERT
[code] }
 end;//Tkw_FromWithPanel_Control_WorkSpace
 
 Tkw_FromWithPanel_Control_WorkSpace_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� WorkSpace
----
*������ �������������*:
[code]
�������::WorkSpace:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_FromWithPanel_Control_WorkSpace_Push
 
 TkwFromWithPanelFormWorkSpace = class(TtfwPropertyLike)
  {* ����� ������� .TFromWithPanelForm.WorkSpace
[panel]������� WorkSpace ����� TFromWithPanelForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aFromWithPanelForm .TFromWithPanelForm.WorkSpace >>> l_TvtPanel
[code]  }
  function WorkSpace(const aCtx: TtfwContext;
   aFromWithPanelForm: TFromWithPanelForm): TvtPanel;
   {* ���������� ����� ������� .TFromWithPanelForm.WorkSpace }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFromWithPanelFormWorkSpace
 
end.

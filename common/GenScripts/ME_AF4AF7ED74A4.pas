unit OutlinerFormKeywordsPack;

interface

uses
 l3IntfUses
 , Outliner_Form
 , vtOutlinerControl
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
 Tkw_Form_OutlinerForm = class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� OutlinerForm
----
*������ �������������*:
[code]
'aControl' �����::OutlinerForm TryFocus ASSERT
[code] }
 end;//Tkw_Form_OutlinerForm
 
 Tkw_OutlinerForm_Control_TreeControl = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TreeControl
----
*������ �������������*:
[code]
�������::TreeControl TryFocus ASSERT
[code] }
 end;//Tkw_OutlinerForm_Control_TreeControl
 
 Tkw_OutlinerForm_Control_TreeControl_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� TreeControl
----
*������ �������������*:
[code]
�������::TreeControl:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_OutlinerForm_Control_TreeControl_Push
 
 TkwOutlinerFormFormTreeControl = class(TtfwPropertyLike)
  {* ����� ������� .TOutlinerFormForm.TreeControl
[panel]������� TreeControl ����� TOutlinerFormForm[panel]
*��� ����������:* TvtOutlinerControl
*������:*
[code]
OBJECT VAR l_TvtOutlinerControl
 aOutlinerFormForm .TOutlinerFormForm.TreeControl >>> l_TvtOutlinerControl
[code]  }
  function TreeControl(const aCtx: TtfwContext;
   aOutlinerFormForm: TOutlinerFormForm): TvtOutlinerControl;
   {* ���������� ����� ������� .TOutlinerFormForm.TreeControl }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwOutlinerFormFormTreeControl
 
end.

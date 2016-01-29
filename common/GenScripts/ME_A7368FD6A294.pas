unit ParentKeywordsPack;

interface

uses
 l3IntfUses
 , ParentAndChildPrim_Module
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
 Tkw_Form_Parent = class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Parent
----
*������ �������������*:
[code]
'aControl' �����::Parent TryFocus ASSERT
[code] }
 end;//Tkw_Form_Parent
 
 Tkw_Parent_Control_ParentZone = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ParentZone
----
*������ �������������*:
[code]
�������::ParentZone TryFocus ASSERT
[code] }
 end;//Tkw_Parent_Control_ParentZone
 
 Tkw_Parent_Control_ParentZone_Push = class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ParentZone
----
*������ �������������*:
[code]
�������::ParentZone:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_Parent_Control_ParentZone_Push
 
 TkwParentFormParentZone = class(TtfwPropertyLike)
  {* ����� ������� .TParentForm.ParentZone
[panel]������� ParentZone ����� TParentForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aParentForm .TParentForm.ParentZone >>> l_TvtPanel
[code]  }
  function ParentZone(const aCtx: TtfwContext;
   aParentForm: TParentForm): TvtPanel;
   {* ���������� ����� ������� .TParentForm.ParentZone }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwParentFormParentZone
 
end.

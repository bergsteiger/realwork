unit elCustomEditKeywordsPack;

interface

uses
 l3IntfUses
 , elCustomEdit_Form
 , elCustomEdit
 , tfwControlString
 , tfwPropertyLike
 , tfwScriptingInterfaces
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
 Tkw_Form_elCustomEdit = class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� elCustomEdit
----
*������ �������������*:
[code]
'aControl' �����::elCustomEdit TryFocus ASSERT
[code] }
 end;//Tkw_Form_elCustomEdit
 
 Tkw_elCustomEdit_Component_Edit = class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Edit
----
*������ �������������*:
[code]
���������::Edit TryFocus ASSERT
[code] }
 end;//Tkw_elCustomEdit_Component_Edit
 
 TkwElCustomEditFormEdit = class(TtfwPropertyLike)
  {* ����� ������� .TelCustomEditForm.Edit
[panel]������� Edit ����� TelCustomEditForm[panel]
*��� ����������:* TelCustomEdit
*������:*
[code]
OBJECT VAR l_TelCustomEdit
 aelCustomEditForm .TelCustomEditForm.Edit >>> l_TelCustomEdit
[code]  }
  function Edit(const aCtx: TtfwContext;
   aelCustomEditForm: TelCustomEditForm): TelCustomEdit;
   {* ���������� ����� ������� .TelCustomEditForm.Edit }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwElCustomEditFormEdit
 
end.

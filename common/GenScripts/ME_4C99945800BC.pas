unit SelectColumnAndDelete;

interface

uses
 l3IntfUses
 , TableToolsTest
 , evEditorInterfaces
 , PrimTextLoad_Form
;

type
 TSelectColumnAndDelete = class(TTableToolsTest)
  {* ���� ��������� � �������� �������. }
  procedure ApplyTools(const aRange: IedRange);
   {* ������� ���������� ��� ������� }
 end;//TSelectColumnAndDelete
 
implementation

uses
 l3ImplUses
 , nevTools
 , TestFrameWork
;

end.

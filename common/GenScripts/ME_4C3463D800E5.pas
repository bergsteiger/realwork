unit Translate2TextTest;

interface

uses
 l3IntfUses
 , TableToolsTest
 , evEditorInterfaces
;

type
 TTranslate2TextTest = class(TTableToolsTest)
  {* ������������� ������� ��� � ����� � ����� }
  procedure ApplyTools(const aRange: IedRange);
   {* ������� ���������� ��� ������� }
 end;//TTranslate2TextTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.

unit ClickOnCommentTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
 , evCustomEditorWindow
;

type
 TClickOnCommentTest = class(TTextViaEditorProcessor)
  {* ������������ �������� ����� �� ��������� �����������. }
  procedure Process(aForm: TPrimTextLoadForm);
   {* ���������� ������� ��������� ������ }
  function CheckCollapsed(aText: TevCustomEditorWindow): Boolean;
 end;//TClickOnCommentTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , nevTools
 , l3Base
;

end.

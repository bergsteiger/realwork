unit PasteColumnTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TPasteColumnTest = class(TTextViaEditorProcessor)
  {* ���� ����������� � ������� �� ������ ������� � ������������ �������. }
  procedure Process(aForm: TPrimTextLoadForm);
   {* ���������� ������� ��������� ������ }
 end;//TPasteColumnTest
 
implementation

uses
 l3ImplUses
 , evCursorTools
 , nevTools
 , l3Base
 , TestFrameWork
;

end.

unit ColumnResizeByMousePrimTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TColumnResizeByMousePrimTest = class(TTextViaEditorProcessor)
  {* ���� ��������� ������� � ������� ���� }
  procedure Process(aForm: TPrimTextLoadForm);
   {* ���������� ������� ��������� ������ }
 end;//TColumnResizeByMousePrimTest
 
implementation

uses
 l3ImplUses
 , evConst
 , TestFrameWork
 , nevTools
 , l3Base
;

end.

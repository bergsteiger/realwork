unit HotSpotSelectionTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 THotSpotSelectionTest = class(TTextViaEditorProcessor)
  {* ���� ��������� � ������� ��������. }
  procedure Process(aForm: TPrimTextLoadForm);
   {* ���������� ������� ��������� ������ }
 end;//THotSpotSelectionTest
 
implementation

uses
 l3ImplUses
 , nevGUIInterfaces
 , Types
 , TestFrameWork
 , l3Base
 , evOp
 , l3InternalInterfaces
 , nevTools
;

end.

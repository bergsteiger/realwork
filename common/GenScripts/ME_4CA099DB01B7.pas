unit QueryCardAddAttributeTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TQueryCardAddAttributeTest = class(TTextViaEditorProcessor)
  {* ���� ���������� �������� � ��. }
  procedure Process(aForm: TPrimTextLoadForm);
   {* ���������� ������� ��������� ������ }
 end;//TQueryCardAddAttributeTest
 
implementation

uses
 l3ImplUses
 , evQueryCardInt
 , evControlContainerEX
 , evQueryDocumentContainer
 , l3Base
 , nevTools
 , TestFrameWork
;

end.

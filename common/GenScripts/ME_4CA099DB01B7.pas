unit QueryCardAddAttributeTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TQueryCardAddAttributeTest = class(TTextViaEditorProcessor)
  {* Тест добавления атрибута в КЗ. }
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
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

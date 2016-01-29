unit ctFakeBoxStrings;

interface

uses
 l3IntfUses
 , ComboBoxStrings
 , FakeBox
 , Classes
;

type
 TctFakeBoxStrings = class(TComboBoxStrings)
  procedure Create(anOwner: TFakeBox);
 end;//TctFakeBoxStrings
 
implementation

uses
 l3ImplUses
 , l3String
;

end.

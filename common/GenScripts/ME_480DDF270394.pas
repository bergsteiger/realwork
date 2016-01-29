unit afwCaret;

interface

uses
 l3IntfUses
 , afwCaretPair
 , afwInterfaces
 , l3Interfaces
;

type
 TafwCaret = class(TafwCaretPair, IafwCaret)
  {* ѕара кареток (дл€ окончательного использовани€). }
  function Extent: TPoint;
  function Position: Tl3_SPoint;
  function Visible: Boolean;
 end;//TafwCaret
 
implementation

uses
 l3ImplUses
 , l3Units
;

end.

unit afwSingleCaret;

interface

uses
 l3IntfUses
 , l3ProtoPersistent
 , l3Units
 , Windows
 , afwCustomCaretType
 , Controls
 , Classes
;

type
 TafwSingleCaret = class(Tl3ProtoPersistent)
  {* Одиночная каретка ввода. }
  procedure Create(anOwner: TWinControl);
  procedure DoShowCaret;
  procedure DoHideCaret;
  procedure CaretTypeHasChanged(Sender: TObject);
  function CheckHidden: Boolean;
  function CanHide: Boolean;
  procedure Scrolled;
  procedure MakeShape;
  procedure Reinit;
  procedure ResetPos;
 end;//TafwSingleCaret
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.

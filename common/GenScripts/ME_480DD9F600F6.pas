unit afwCaretPair;

interface

uses
 l3IntfUses
 , afwSingleCaret
 , afwInsCaretType
 , afwOvrCaretType
 , Controls
;

type
 TafwCaretPair = class(TafwSingleCaret)
  {* Пара кареток (для вставки и замены). }
 end;//TafwCaretPair
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.

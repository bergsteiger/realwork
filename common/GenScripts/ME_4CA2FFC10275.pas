unit evStrictContentsElementEliminator;

interface

uses
 l3IntfUses
 , k2TagFilter
;

type
 TevStrictContentsElementEliminator = class(Tk2TagFilter)
  {* Фильтр, удаляющий "элементы оглавления" (k2_idContentsElement). Но не блоки, и никаких других наследников }
 end;//TevStrictContentsElementEliminator
 
implementation

uses
 l3ImplUses
 , ContentsElement_Const
;

end.

unit evdChildrenCountEliminator;

interface

uses
 l3IntfUses
 , k2TagFilter
 , l3Variant
;

type
 TevdChildrenCountEliminator = class(Tk2TagFilter)
  {* ¬ыкидавает ChildrenCount из потока генерации, чтобы не распредел€лась лишн€€ пам€ть при буферизации на проходе }
 end;//TevdChildrenCountEliminator
 
implementation

uses
 l3ImplUses
 , k2Tags
;

end.

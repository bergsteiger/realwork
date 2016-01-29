unit evdStartAndTimeEliminator;

interface

uses
 l3IntfUses
 , k2TagFilter
 , l3Variant
;

type
 TevdStartAndTimeEliminator = class(Tk2TagFilter)
  {* Обнуляет Start и Time у документа. }
 end;//TevdStartAndTimeEliminator
 
implementation

uses
 l3ImplUses
 , Document_Const
 , k2Tags
;

end.

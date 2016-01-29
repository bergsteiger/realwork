unit evdHypelinkDocIDEliminator;

interface

uses
 l3IntfUses
 , k2TagFilter
 , l3Variant
;

type
 TevdHypelinkDocIDEliminator = class(Tk2TagFilter)
  {* Обнуляет DocID у ссылок. Создан для тестов. }
 end;//TevdHypelinkDocIDEliminator
 
implementation

uses
 l3ImplUses
 , k2Tags
 , Address_Const
;

end.

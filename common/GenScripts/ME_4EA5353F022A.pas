unit dd_lcPageNumberEliminator;

interface

uses
 l3IntfUses
 , evdBufferedFilter
;

type
 Tdd_lcPageNumberEliminator = class(TevdChildBufferedFilter)
  {* Удаляет псевдономера страниц из текста судебных постановлений }
 end;//Tdd_lcPageNumberEliminator
 
implementation

uses
 l3ImplUses
;

end.

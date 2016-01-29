unit evdScriptHyperlinkEliminator;

interface

uses
 l3IntfUses
 , evdHyperlinkEliminator
 , l3Variant
;

type
 TevdScriptHyperlinkEliminator = class(TevdHyperlinkEliminator)
  {* Фильтр, отрезающий ссылки на скрипты }
 end;//TevdScriptHyperlinkEliminator
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3String
 , evdTypes
;

end.

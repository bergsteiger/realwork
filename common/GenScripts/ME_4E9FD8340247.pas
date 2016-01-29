unit evdHyperlinkEliminator;

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , k2Base
 , l3Variant
;

type
 TevdHyperlinkEliminator = class(TevdLeafParaFilter)
  {* ‘ильтр, удал€ющий все гиперссылки в документе }
 end;//TevdHyperlinkEliminator
 
implementation

uses
 l3ImplUses
 , HyperLink_Const
;

end.

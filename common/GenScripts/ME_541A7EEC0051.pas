unit evdPDFHyperLinkEliminator;

interface

uses
 l3IntfUses
 , evdHyperlinkEliminator
 , l3Variant
;

type
 TevdPDFHyperLinkEliminator = class(TevdHyperlinkEliminator)
  {* ‘ильтр, удал€ющий ссылки дл€ PDF. }
 end;//TevdPDFHyperLinkEliminator
 
implementation

uses
 l3ImplUses
 , k2Tags
 , k2VariantImpl
 , k2Types
 , evdStyles
;

end.

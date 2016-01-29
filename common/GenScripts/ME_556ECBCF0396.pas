unit f1ExternalHyperlinkEliminator;

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , l3Variant
 , k2Base
;

type
 Tf1ExternalHyperlinkEliminator = class(TevdLeafParaFilter)
  function SetTo(var theGenerator: Ik2TagGenerator): Ik2TagGenerator;
 end;//Tf1ExternalHyperlinkEliminator
 
implementation

uses
 l3ImplUses
 , k2Tags
 , HyperLink_Const
 , SysUtils
 , evdTypes
;

end.

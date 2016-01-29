unit evParaCollapser;

interface

uses
 l3IntfUses
 , evDecorHotSpot
 , nevTools
 , evDecorHyperlink
;

type
 TevParaCollapser = class(TevDecorHotSpot)
  function DoCollapse(const aView: InevControlView): Boolean;
 end;//TevParaCollapser
 
implementation

uses
 l3ImplUses
 , nevBase
 , evCollapserHyperlink
 , evParaTools
 , k2Tags
;

end.

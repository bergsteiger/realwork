unit evDecorHyperlink;

interface

uses
 l3IntfUses
 , evHyperlinkProxy
 , nevTools
 , nevNavigation
;

type
 RevDecorHyperlink = class of TevDecorHyperlink;
 
 TevDecorHyperlink = class(TevHyperlinkProxy)
  procedure Create(const aPara: InevPara;
   const aLink: IevHyperlink);
  function Make(const aPara: InevPara;
   const aLink: IevHyperlink): IevHyperlink;
 end;//TevDecorHyperlink
 
implementation

uses
 l3ImplUses
 , evParaTools
 , Document_Const
 , k2Tags
 , l3Variant
;

end.

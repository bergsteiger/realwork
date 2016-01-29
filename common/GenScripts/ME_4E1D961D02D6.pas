unit evDecorHotSpot;

interface

uses
 l3IntfUses
 , evHotSpotProxy
 , nevTools
 , nevGUIInterfaces
 , evDecorHyperlink
 , nevDecorActiveHyperlink
 , l3Interfaces
;

type
 TevDecorHotSpot = class(TevHotSpotProxy)
  procedure Create(const aPara: InevPara;
   const aHotSpot: IevHotSpot);
  function Make(const aPara: InevPara;
   const aHotSpot: IevHotSpot): IevHotSpot;
  function NeedProxyHyperlink: Boolean;
  function GetDecorHyperlinkClass: RevDecorHyperlink;
  function GetDecorActiveHyperlinkClass: RnevDecorActiveHyperlinkClass;
 end;//TevDecorHotSpot
 
implementation

uses
 l3ImplUses
 , l3InterfacesMisc
 , SysUtils
 , nevNavigation
;

end.

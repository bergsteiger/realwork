unit evControlParaHotSpotTester;

interface

uses
 l3IntfUses
 , evTextParaHotSpotTester
 , nevTools
 , nevGUIInterfaces
;

type
 TevControlParaHotSpotTester = class(TevTextParaHotSpotTester)
  {* Парень, который определяет зону контрола (некий аналог WM_NCHITTEST) }
 end;//TevControlParaHotSpotTester
 
implementation

uses
 l3ImplUses
 , evControlParaHotSpot
 , evControlSegmentHotSpot
;

end.

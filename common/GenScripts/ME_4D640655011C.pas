unit evTableHotSpot;

interface

uses
 l3IntfUses
 , evSelectingHotSpot
 , evParaListHotSpotTester
;

type
 TevTableHotSpotTester = class(TevParaListHotSpotTester)
 end;//TevTableHotSpotTester
 
 TevTableHotSpot = class(TevSelectingHotSpot)
 end;//TevTableHotSpot
 
implementation

uses
 l3ImplUses
;

end.

unit evSubPanelSubCollection;

interface

uses
 l3IntfUses
 , evSubPanelSubCollectionPrim
 , evSubPanelSubArray
 , l3Types
;

type
 TevSubPanelSubCollection = class(TevSubPanelSubCollectionPrim)
  function CheckLayer(aHandle: Tl3Handle): TevSubPanelSubArray;
 end;//TevSubPanelSubCollection
 
implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
;

end.

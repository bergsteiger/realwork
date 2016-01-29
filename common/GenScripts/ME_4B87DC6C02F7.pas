unit evSubPanelSub;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Units
 , nevTools
 , l3Types
;

type
 TevSubPanelSub = class(Tl3ProtoObject)
  procedure Create(const aRealSub: IevSub);
 end;//TevSubPanelSub
 
implementation

uses
 l3ImplUses
;

end.

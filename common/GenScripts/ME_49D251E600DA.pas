unit nevParentPointFactory.imp;

interface

uses
 l3IntfUses
 , nevTools
 , nevBase
;

type
 _nevParentPointFactory_ = class
  function PointToParent(const aThisTarget: InevObjectPrim;
   aNeedShowCollapsed: Boolean): InevBasePoint;
  function TopParentPoint: InevBasePoint;
 end;//_nevParentPointFactory_
 
implementation

uses
 l3ImplUses
;

end.

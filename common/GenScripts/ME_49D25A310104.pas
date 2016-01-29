unit nevParentPointFactoryEx.imp;

interface

uses
 l3IntfUses
 , nevTools
 , k2Base
;

type
 _nevParentPointFactoryEx_ = class
  function PointToParentByLevel(aLevel: Integer): InevBasePoint;
  function PointToTypedParent(aParentType: Tk2Type): InevBasePoint;
 end;//_nevParentPointFactoryEx_
 
implementation

uses
 l3ImplUses
;

end.

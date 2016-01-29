unit nevParentPointFactoryExVOID.imp;

interface

uses
 l3IntfUses
 , nevTools
 , k2Base
;

type
 _nevParentPointFactoryExVOID_ = class
  {* Абстрактная реализация MnevParentPointFactoryEx }
  function PointToParentByLevel(aLevel: Integer): InevBasePoint;
  function PointToTypedParent(aParentType: Tk2Type): InevBasePoint;
 end;//_nevParentPointFactoryExVOID_
 
implementation

uses
 l3ImplUses
;

end.

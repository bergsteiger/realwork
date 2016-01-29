unit evLocation;

interface

uses
 l3IntfUses
 , evLocationBase
 , nevTools
;

type
 TevLocation = class(TevLocationBase, InevText)
  function CanBeDeleted: Boolean;
  function Modify: InevTextModify;
 end;//TevLocation
 
implementation

uses
 l3ImplUses
;

end.

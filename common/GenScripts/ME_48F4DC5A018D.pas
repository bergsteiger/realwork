unit evNodeDataObject;

interface

uses
 l3IntfUses
 , evNodeStorable
 , l3TreeInterfaces
;

type
 TevNodeDataObject = class(_evDataObjectFromStorable_)
 end;//TevNodeDataObject
 
implementation

uses
 l3ImplUses
 , evFormats
 , evTypes
 , nevTools
 , l3Base
;

end.

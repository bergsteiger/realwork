unit evTreeDataObject;

interface

uses
 l3IntfUses
 , evTreeStorable
 , nevTools
;

type
 TevTreeDataObject = class(_evDataObjectFromStorable_)
  function MakeStorable(const aData: TevTreeStorableData): InevDataObjectPrim2;
 end;//TevTreeDataObject
 
implementation

uses
 l3ImplUses
 , evFormats
 , evTypes
 , l3Base
;

end.

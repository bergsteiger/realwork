unit evConstStringDataObject;

interface

uses
 l3IntfUses
 , evConstStringStorable
 , evdInterfaces
 , nevBase
 , l3Interfaces
;

type
 TevConstStringDataObject = class(_evDataObjectFromStorable_)
 end;//TevConstStringDataObject
 
implementation

uses
 l3ImplUses
 , l3String
 , evTypes
 , evdTextToFirstParaAdder
 , evFormats
 , nevTools
 , l3Base
;

end.

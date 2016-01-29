unit evPersistentDataObjectEx;

interface

uses
 l3IntfUses
 , evPersistentDataObject
 , nevTools
;

type
 TevPersistentDataObjectEx = class(TevPersistentDataObject)
  function Holder: InevObjectHolder;
 end;//TevPersistentDataObjectEx
 
implementation

uses
 l3ImplUses
 , nevPersistentDocumentContainer
;

end.

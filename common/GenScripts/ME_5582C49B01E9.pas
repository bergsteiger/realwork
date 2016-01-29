unit vcmEntitiesDefIterator;

interface

uses
 l3IntfUses
 , vcmInterfaces
 , vcmEntitiesDefList
;

type
 TvcmEntitiesDefIterator = class(_vcmIterator_, IvcmEntitiesDefIterator)
  function Next: IvcmEntityDef;
   {* следующий описатель сущности }
 end;//TvcmEntitiesDefIterator
 
implementation

uses
 l3ImplUses
;

end.

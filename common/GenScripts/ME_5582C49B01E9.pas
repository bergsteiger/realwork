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
   {* ��������� ��������� �������� }
 end;//TvcmEntitiesDefIterator
 
implementation

uses
 l3ImplUses
;

end.

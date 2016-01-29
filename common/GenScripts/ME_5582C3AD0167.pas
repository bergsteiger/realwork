unit vcmUserTypesIterator;

interface

uses
 l3IntfUses
 , vcmInterfaces
 , vcmUserTypeDefList
;

type
 TvcmUserTypesIterator = class(_vcmIterator_, IvcmUserTypesIterator)
  function Make(aList: TvcmUserTypeDefList): IvcmUserTypesIterator;
  function Next: IvcmUserTypeDef;
 end;//TvcmUserTypesIterator
 
implementation

uses
 l3ImplUses
;

end.

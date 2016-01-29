unit vcmOperationsDefIterator;

interface

uses
 l3IntfUses
 , vcmUserControls
 , vcmOperationDefList
;

type
 TvcmOperationsDefIterator = class(_vcmIterator_, IvcmOperationsDefIterator)
  function Next: IvcmOperationDef;
   {* следующий описатель операции }
 end;//TvcmOperationsDefIterator
 
implementation

uses
 l3ImplUses
;

end.

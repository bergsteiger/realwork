unit myReferenceCountGuard;

interface

uses
 l3IntfUses
 , myInterfacedObject
;

type
 ImyReferenceCountGuard = interface
  {* ��������� ������������� ��� �������� }
  function GetRefCount: Integer;
 end;//ImyReferenceCountGuard
 
 TmyReferenceCountGuard = class(TmyInterfacedObject, ImyReferenceCountGuard)
  {* ����� ������������� ��� �������� }
  function Make: ImyReferenceCountGuard;
  function GetRefCount: Integer;
 end;//TmyReferenceCountGuard
 
implementation

uses
 l3ImplUses
;

end.

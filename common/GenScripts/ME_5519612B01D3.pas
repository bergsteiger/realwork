unit IterateableServiceProvider;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , IterateableService
 , Classes
;

type
 TIterateableServiceImpl = class(Tl3ProtoObject, IIterateableService)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  procedure IterateF;
 end;//TIterateableServiceImpl
 
 TIterateableServiceProvider = class
 end;//TIterateableServiceProvider
 
implementation

uses
 l3ImplUses
;

end.

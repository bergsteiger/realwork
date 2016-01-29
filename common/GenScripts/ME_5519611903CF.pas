unit IterateableService;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , Classes
;

type
 MIterateableService_IterateF_Action = function(anItem: TComponent): Boolean;
  {* ��� �������������� ������� ��� MIterateableService.IterateF }
 
 (*
 MIterateableService = interface
  {* �������� ������� TIterateableService }
  procedure IterateF;
 end;//MIterateableService
 *)
 
 IIterateableService = interface
  {* ��������� ������� TIterateableService }
  procedure IterateF;
 end;//IIterateableService
 
 TIterateableService = class(Tl3ProtoObject)
  procedure Iterate;
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  procedure IterateF;
 end;//TIterateableService
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.

unit l3DocumentsCacheService;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3DocumentsCacheService = interface
  {* �������� ������� Tl3DocumentsCacheService }
  procedure Clear;
 end;//Ml3DocumentsCacheService
 *)
 
type
 Il3DocumentsCacheService = interface
  {* ��������� ������� Tl3DocumentsCacheService }
  procedure Clear;
 end;//Il3DocumentsCacheService
 
 Tl3DocumentsCacheService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  procedure Clear;
 end;//Tl3DocumentsCacheService
 
implementation

uses
 l3ImplUses
;

end.

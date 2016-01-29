unit l3TabService;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3TabService = interface
  {* �������� ������� Tl3TabService }
  function HasTabs: Boolean;
 end;//Ml3TabService
 *)
 
type
 Il3TabService = interface
  {* ��������� ������� Tl3TabService }
  function HasTabs: Boolean;
 end;//Il3TabService
 
 Tl3TabService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  function HasTabs: Boolean;
 end;//Tl3TabService
 
implementation

uses
 l3ImplUses
;

end.

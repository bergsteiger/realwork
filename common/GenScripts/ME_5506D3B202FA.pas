unit l3MessagesService;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3MessagesService = interface
  {* �������� ������� Tl3MessagesService }
  procedure ProcessMessages;
 end;//Ml3MessagesService
 *)
 
type
 Il3MessagesService = interface
  {* ��������� ������� Tl3MessagesService }
  procedure ProcessMessages;
 end;//Il3MessagesService
 
 Tl3MessagesService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  procedure ProcessMessages;
 end;//Tl3MessagesService
 
implementation

uses
 l3ImplUses
;

end.

unit l3ScreenService;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3InternalInterfaces
;

 (*
 Ml3ScreenService = interface
  {* �������� ������� Tl3ScreenService }
  function IC: Il3InfoCanvas;
 end;//Ml3ScreenService
 *)
 
type
 Il3ScreenService = interface
  {* ��������� ������� Tl3ScreenService }
  function IC: Il3InfoCanvas;
 end;//Il3ScreenService
 
 Tl3ScreenService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  function IC: Il3InfoCanvas;
 end;//Tl3ScreenService
 
implementation

uses
 l3ImplUses
;

end.

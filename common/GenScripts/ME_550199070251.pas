unit l3MenuManagerHelper;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3MenuManagerHelper = interface
  {* �������� ������� Tl3MenuManagerHelper }
  function CreateManager: Boolean;
  procedure FreeManager;
 end;//Ml3MenuManagerHelper
 *)
 
type
 Il3MenuManagerHelper = interface
  {* ��������� ������� Tl3MenuManagerHelper }
  function CreateManager: Boolean;
  procedure FreeManager;
 end;//Il3MenuManagerHelper
 
 Tl3MenuManagerHelper = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  function CreateManager: Boolean;
  procedure FreeManager;
 end;//Tl3MenuManagerHelper
 
implementation

uses
 l3ImplUses
;

end.

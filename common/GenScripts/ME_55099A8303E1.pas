unit l3KeyboardLayoutService;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3KeyboardLayoutService = interface
  {* �������� ������� Tl3KeyboardLayoutService }
  procedure TryActivateKeyboardLayout;
 end;//Ml3KeyboardLayoutService
 *)
 
type
 Il3KeyboardLayoutService = interface
  {* ��������� ������� Tl3KeyboardLayoutService }
  procedure TryActivateKeyboardLayout;
 end;//Il3KeyboardLayoutService
 
 Tl3KeyboardLayoutService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  procedure TryActivateKeyboardLayout;
 end;//Tl3KeyboardLayoutService
 
implementation

uses
 l3ImplUses
;

end.

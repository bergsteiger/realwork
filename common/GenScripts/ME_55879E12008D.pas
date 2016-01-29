unit l3PopupControlService;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , Windows
;

 (*
 Ml3PopupControlService = interface
  {* �������� ������� Tl3PopupControlService }
  function IsPopupControlWindow(aControlWnd: HWND): Boolean;
 end;//Ml3PopupControlService
 *)
 
type
 Il3PopupControlService = interface
  {* ��������� ������� Tl3PopupControlService }
  function IsPopupControlWindow(aControlWnd: HWND): Boolean;
 end;//Il3PopupControlService
 
 Tl3PopupControlService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  function IsPopupControlWindow(aControlWnd: HWND): Boolean;
 end;//Tl3PopupControlService
 
implementation

uses
 l3ImplUses
;

end.

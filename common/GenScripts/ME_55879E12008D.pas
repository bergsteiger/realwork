unit l3PopupControlService;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , Windows
;

 (*
 Ml3PopupControlService = interface
  {* Контракт сервиса Tl3PopupControlService }
  function IsPopupControlWindow(aControlWnd: HWND): Boolean;
 end;//Ml3PopupControlService
 *)
 
type
 Il3PopupControlService = interface
  {* Интерфейс сервиса Tl3PopupControlService }
  function IsPopupControlWindow(aControlWnd: HWND): Boolean;
 end;//Il3PopupControlService
 
 Tl3PopupControlService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function IsPopupControlWindow(aControlWnd: HWND): Boolean;
 end;//Tl3PopupControlService
 
implementation

uses
 l3ImplUses
;

end.

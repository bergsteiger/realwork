unit vcmPopupControlWindowService;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3PopupControlService
 , Windows
;

type
 TvcmPopupControlWindowService = class(Tl3ProtoObject, Il3PopupControlService)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  function IsPopupControlWindow(aControlWnd: HWND): Boolean;
 end;//TvcmPopupControlWindowService
 
implementation

uses
 l3ImplUses
 , vcmDropDownMenuForChromeLike
 , Controls
;

end.

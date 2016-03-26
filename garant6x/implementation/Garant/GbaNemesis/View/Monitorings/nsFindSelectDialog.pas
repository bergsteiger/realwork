unit nsFindSelectDialog;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Monitorings\nsFindSelectDialog.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsFindSelectDialog" MUID: (4AAF996900DC)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3Core
 , Windows
;

function FindSelectDialog(aWnd: hWnd;
 aParam: Pointer): WinBool; stdcall;
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , Messages
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

function FindSelectDialog(aWnd: hWnd;
 aParam: Pointer): WinBool;
//#UC START# *4AAF99C703C7_4AAF996900DC_var*
var
 ProcessID: Cardinal;
 TheadID: Cardinal;
//#UC END# *4AAF99C703C7_4AAF996900DC_var*
begin
//#UC START# *4AAF99C703C7_4AAF996900DC_impl*
 Result := True;
 if GetWindow(aWnd, GW_OWNER) = Application.Handle then
 begin
  if (FindControl(aWnd) = nil) and IsWindowVisible(aWnd) then
  begin
   SendMessage(aWnd, PMessage(aParam)^.Msg, PMessage(aParam)^.wParam, PMessage(aParam)^.lParam);
   SetForegroundWindow(aWnd);
  end;
 end;
//#UC END# *4AAF99C703C7_4AAF996900DC_impl*
end;//FindSelectDialog
{$IfEnd} // NOT Defined(Admin)

end.

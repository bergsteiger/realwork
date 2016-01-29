unit nsFindSelectDialog;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Monitorings/nsFindSelectDialog.pas"
// Начат: 15.09.2009 17:41
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Common For Shell And Monitoring::PostingOrder::View::Monitorings::nsFindSelectDialog
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  l3Core,
  Windows
  ;

function FindSelectDialog(aWnd: hWnd;
  aParam: Pointer): WinBool; stdcall;
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  Messages
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  ;

// unit methods

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
{$IfEnd} //not Admin

end.
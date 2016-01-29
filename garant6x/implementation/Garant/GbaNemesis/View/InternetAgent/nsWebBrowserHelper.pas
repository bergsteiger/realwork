unit nsWebBrowserHelper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/InternetAgent/nsWebBrowserHelper.pas"
// Начат: 12.10.2011 15:07
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Встроенные продукты::InternetAgent::View::InternetAgent::nsWebBrowserHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Windows
  ;

function EnumChildWindowProc(hwnd: HWND;
  lParam: LPARAM): Boolean; stdcall;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  StrUtils,
  Messages
  ;

// unit methods

function EnumChildWindowProc(hwnd: HWND;
  lParam: LPARAM): Boolean;
//#UC START# *4E957515024B_4E9574DB0120_var*
var
 clName: array [0..259] of AnsiChar;
 WindowPlacement: TWindowPlacement;
 R : TRect;
//#UC END# *4E957515024B_4E9574DB0120_var*
begin
//#UC START# *4E957515024B_4E9574DB0120_impl*
 Result := true;
 FillChar(clName, 260, 0);
 GetClassNameA(hwnd, clName, 260);
 //if AnsiStartsText('Shell', PChar(@clName)) then
 begin
  SetWindowPos(hwnd, 0, 0, 0, LoWord(lParam), HiWord(lParam),
        SWP_FRAMECHANGED + SWP_NOZORDER + SWP_NOACTIVATE);
  WindowPlacement.Length := SizeOf(WindowPlacement);
  GetWindowPlacement(hwnd, @WindowPlacement);
  WindowPlacement.ShowCmd := SW_SHOW;
  SetWindowPlacement(hwnd, @WindowPlacement);
  GetWindowRect(hwnd, R);
  Assert(R.Right - R.Left = LoWord(lParam));
  Assert(R.Bottom - R.Top = HiWord(lParam));
  GetClientRect(hwnd, R);
 end;//AnsiStartsText('Shell'
 SendMessage(hwnd,
             WM_Size,
             0, lParam);
 GetWindowRect(hwnd, R);
 Assert(R.Right - R.Left = LoWord(lParam));
 Assert(R.Bottom - R.Top = HiWord(lParam));
 GetClientRect(hwnd, R);
//#UC END# *4E957515024B_4E9574DB0120_impl*
end;//EnumChildWindowProc
{$IfEnd} //not Admin AND not Monitorings

end.
unit nsWebBrowserHelper;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\nsWebBrowserHelper.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsWebBrowserHelper" MUID: (4E9574DB0120)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Windows
;

function EnumChildWindowProc(hwnd: HWND;
 lParam: LPARAM): Boolean; stdcall;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , StrUtils
 , Messages
;

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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

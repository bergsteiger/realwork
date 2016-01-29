unit nsFlashWindow;

// $Id: nsFlashWindow.pas,v 1.1 2012/04/05 19:42:21 lulin Exp $

// $Log: nsFlashWindow.pas,v $
// Revision 1.1  2012/04/05 19:42:21  lulin
// {RequestLink:237994598}
//
// Revision 1.4  2007/08/14 19:31:39  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.3  2005/08/12 11:33:11  migel
// - cleanup: ненужный код.
//
// Revision 1.2  2005/08/12 11:32:25  migel
// - change: вынесли в отдельный модуль врапер над `FlashWindowEx`.
// - cleanup: ненужный код.
//
// Revision 1.1  2005/08/12 11:19:57  migel
// - new: вынесли в отдельный модуль врапер над `FlashWindowEx`.
//

interface

uses
 Windows;

function  nsFlashWindowByHandle(const aHWND: HWND; const aFlags: DWORD = FLASHW_TRAY or FLASHW_TIMERNOFG): BOOL;
function  nsFlashWindowEx(var aFlashWInfo: TFlashWInfo): BOOL; stdcall;

implementation

uses
 DataAdapter, // от этого нужно избавиться [используется `GetProcedureAddress`]

 l3Base
 ; 

function nsFlashWindowByHandle(const aHWND: HWND; const aFlags: DWORD): BOOL;
var
 l_FlashWInfo: TFlashWInfo;
begin
 l3FillChar(l_FlashWInfo, SizeOf(l_FlashWInfo), 0);
 //
 with l_FlashWInfo do
 begin
  cbSize := SizeOf(l_FlashWInfo);
  //
  hWND := aHWND;
  dwFlags := aFlags;
 end;
 //
 try
  Result := nsFlashWindowEx(l_FlashWInfo);
 except
  Result := False;
 end;
end;

var
 _nsFlashWindowEx: Pointer;

function nsFlashWindowEx(var aFlashWInfo: TFlashWInfo): BOOL;
begin
 Result := False;
 //
 GetProcedureAddress(_nsFlashWindowEx, user32, 'FlashWindowEx');
 asm
  mov esp, ebp
  pop ebp
  jmp [_nsFlashWindowEx]
 end;
end;

end.

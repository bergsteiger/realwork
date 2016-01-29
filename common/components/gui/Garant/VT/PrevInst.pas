unit PrevInst;

{ $Id: PrevInst.pas,v 1.3 2000/12/15 15:36:28 law Exp $ }

// $Log: PrevInst.pas,v $
// Revision 1.3  2000/12/15 15:36:28  law
// - вставлены директивы Log.
//

interface

uses
  Windows, Messages, SysUtils, Classes, Forms;

Function GotoPrevInst : Boolean;
const wmMainInstanceOpenFile = WM_USER+ 101;            //new

implementation

var
  MyAppName, MyClassName: array[0..255] of Char;
  NumFound: Integer;
  LastFound, MyPopup: HWND;

function LookAtAllWindows(Handle: HWND; Temp: LongInt): BOOL; stdcall;
 var
  WindowName, ClassName: Array[0..255] of Char;
 begin
  if (GetClassName(Handle, ClassName, SizeOf(ClassName)) > 0) and
     (StrComp(ClassName, MyClassName) = 0) and
     (GetWindowText(Handle, WindowName, SizeOf(WindowName)) > 0) and
     (StrComp(WindowName, MyAppName) = 0) then
  begin
    Inc(NumFound);
    if Handle <> Application.Handle then LastFound := Handle;
  end;
  Result:= True;
 end;

function SendParam(aHandle: hWND): Boolean;             //new
 var
  S: String;
  i: Integer;
  Atom: tAtom;
 begin
  Result:= False;
  S:= '';
  for i:= 1 to ParamCount do
  begin
    S:= S+ ParamStr(i)+ ' ';
    if Pos('.EXE', UpperCase(S))<>0 then S:= '';
  end;
  if S='' then Exit;
  Atom := GlobalAddAtom(PChar(S));
  SendMessage(aHandle, wmMainInstanceOpenFile, Atom, 0);
  GlobalDeleteAtom(Atom);
  Result:= True;
 end;

function GotoPrevInst : Boolean;
 begin
  Result := False;
  NumFound := 0;
  LastFound := 0;
  GetWindowText(Application.Handle, MyAppName, SizeOf(MyAppName));
  GetClassName(Application.Handle, MyClassName, SizeOf(MyClassName));
  EnumWindows(@LookAtAllWindows, 0);
  if NumFound > 1 then
   begin
    MyPopup := GetLastActivePopup(LastFound);
    SendParam(MyPopup);                                //new
    BringWindowToTop(LastFound);
    if IsIconic(MyPopup)
      then ShowWindow(MyPopup, SW_RESTORE)
      else SetForegroundWindow(MyPopup);
    Result := True;
   end
 end;

end.

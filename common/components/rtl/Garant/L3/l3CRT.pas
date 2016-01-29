unit l3CRT;

{ $Id: l3CRT.pas,v 1.4 2014/02/13 10:53:59 lulin Exp $ }

// $Log: l3CRT.pas,v $
// Revision 1.4  2014/02/13 10:53:59  lulin
// - ���������� �������� ������.
//
// Revision 1.3  2012/11/01 09:42:57  lulin
// - ����� ����� � �������.
//
// Revision 1.2  2012/11/01 07:45:08  lulin
// - ������ ����������� ����������� �������� �������� �������.
//
// Revision 1.1  2012/01/11 11:03:09  voba
// - k: 326771281
//

{$I vtDefine.inc}

interface

uses
  Windows,
  Messages,
  SysUtils,
  l3Base,
  l3ProtoObject
  ;

type
  Tl3CRT = class(Tl3ProtoObject)
  protected
   fConHandle : THandle; // ���������� ����������� ����
   fMaxX : Word;
   fMaxY : Word; // ��� �������� ������������ �������� ����
  public
   constructor Create;

   function GetConInputHandle : THandle;
    {- ��������� ����������� ��� ����������� �����}

   function GetConOutputHandle : THandle;
    {- ��������� ����������� ��� ����������� ������}

   procedure GotoXY(X, Y : Word);
    {- ��������� ������� � ���������� X, Y}

   procedure Cls;
    {- ������� ������ - ���������� ��� ���������}

   procedure ShowCursor(Show : Bool);
    {- ����������/�������� ������}

   procedure ReWrite(const aStr : String);
    {- ������������ ���������� ������� ������ �������}
  end;

var
 CRT : Tl3CRT;

implementation

function Coord(X, Y : Word): TCoord;
begin
 Result.X := X;
 Result.Y := Y;
end;

constructor Tl3CRT.Create;
var
 lCoord: TCoord;
begin
 Inherited Create;
  // �������� ���������� ������ (output)
 fConHandle := GetConOutputHandle;
 // �������� ������������ ������� ����
 lCoord := GetLargestConsoleWindowSize(fConHandle);
 fMaxX := lCoord.X;
 fMaxY := lCoord.Y;
 ShowCursor(False);
end;

function Tl3CRT.GetConInputHandle : THandle;
{- ��������� ����������� ��� ����������� �����}
begin
  Result := GetStdHandle(STD_INPUT_HANDLE)
end;

function Tl3CRT.GetConOutputHandle : THandle;
{- ��������� ����������� ��� ����������� ������}
begin
  Result := GetStdHandle(STD_OUTPUT_HANDLE)
end;

procedure Tl3CRT.GotoXY(X, Y : Word);
{- ��������� ������� � ���������� X, Y}
begin
  SetConsoleCursorPosition(fConHandle, Coord(X, Y));
end;

procedure Tl3CRT.Cls;
{- ������� ������ - ���������� ��� ���������}
var
 lNOAW: DWORD; // ��� �������� ����������� ��������� �������
begin
  FillConsoleOutputCharacter(fConHandle, ' ', fMaxX * fMaxY, Coord(0, 0), lNOAW);
  GotoXY(0, 0);
end;

procedure Tl3CRT.ShowCursor(Show : Bool);
{- ����������/�������� ������}
var
 CCI: TConsoleCursorInfo;
begin
  CCI.bVisible := Show;
  SetConsoleCursorInfo(fConHandle, CCI);
end;

procedure Tl3CRT.ReWrite(const aStr : String);
{- ������������ ���������� ������� ������ �������}
var
 lpConsoleScreenBufferInfo: TConsoleScreenBufferInfo;
 lNOAW: DWORD; // ��� �������� ����������� ��������� �������
 lLen : Integer;
begin
 GetConsoleScreenBufferInfo(fConHandle, lpConsoleScreenBufferInfo);

 lLen := Length(aStr);
 with lpConsoleScreenBufferInfo do
 begin
  if lLen < dwCursorPosition.X then //��������� ����� ���������� ������� ���� ��� ���� �������
   FillConsoleOutputCharacter(fConHandle, ' ', dwCursorPosition.X - lLen, Coord(lLen, dwCursorPosition.Y), lNOAW);
  GotoXY(0, dwCursorPosition.Y);
  Write(aStr);
 end;
end;


initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\L3\l3CRT.pas initialization enter'); {$EndIf}
 CRT := Tl3CRT.Create;

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\L3\l3CRT.pas initialization leave'); {$EndIf}
finalization
 FreeAndNil(CRT);
end.

(*

SetConsoleCtrlHandler(@ConProc, False);
Cls;
//
// "���� ��������� ���������"
//
Continue := True;
while Continue do
begin
  ReadConsoleInput(GetConInputHandle, IBuff, 1, IEvent);
  case IBuff.EventType of
    KEY_EVENT :
      begin
        // ��������� ������� ESC � ��������� ���������
        if ((IBuff.KeyEvent.bKeyDown = True) and
        (IBuff.KeyEvent.wVirtualKeyCode = VK_ESCAPE)) then
          Continue := False;
      end;
    _MOUSE_EVENT :
      begin
        with IBuff.MouseEvent.dwMousePosition do
          StatusLine(Format('%d, %d', [X, Y]));
      end;
  end;
end {While}


��� �� ����� �������� "���������� �������" � ������������� ����� ���������� ������ ��� Ctrl+C � Ctrl+Break:

//-----------------------------------------------------
// ���������� ���������� �������
//-----------------------------------------------------
function ConProc(CtrlType: DWord): Bool; stdcall; far;
var
  S: string;
begin
  case CtrlType of
    CTRL_C_EVENT: S := 'CTRL_C_EVENT';
    CTRL_BREAK_EVENT: S := 'CTRL_BREAK_EVENT';
    CTRL_CLOSE_EVENT: S := 'CTRL_CLOSE_EVENT';
    CTRL_LOGOFF_EVENT: S := 'CTRL_LOGOFF_EVENT';
    CTRL_SHUTDOWN_EVENT: S := 'CTRL_SHUTDOWN_EVENT';
    else
      S := 'UNKNOWN_EVENT';
  end;
  MessageBox(0, PChar(S + ' detected'), 'Win32 Console', MB_OK);
  Result := True;
end;


����� ���������� �� ��� � ��������, � ������ ��������� ���������������� ���������, ������� �������� ������������, ���������� ����, � ��� �� ��������� ������ �����������. ����� ������� ������ �������� ��� ����� ����������. �������������!

{
[]-----------------------------------------------------------[]
CON001 - Show various Console API functions. Checked with Win95

version 1.01

by Alex G. Fedorov, May-July, 1997
alexfedorov@geocities.com

09-Jul-97 some minor corrections (shown in comments)
[]-----------------------------------------------------------[]
}
program Con001;

{$APPTYPE CONSOLE}

uses
  Windows, SysUtils;

const
  // ��������� ����������� �����
  YellowOnBlue = FOREGROUND_GREEN or FOREGROUND_RED or
  FOREGROUND_INTENSITY or BACKGROUND_BLUE;
  WhiteOnBlue = FOREGROUND_BLUE or FOREGROUND_GREEN or
  FOREGROUND_RED or FOREGROUND_INTENSITY or
  BACKGROUND_BLUE;

  RedOnWhite = FOREGROUND_RED or FOREGROUND_INTENSITY or
  BACKGROUND_RED or BACKGROUND_GREEN or BACKGROUND_BLUE
  or BACKGROUND_INTENSITY;

  WhiteOnRed = BACKGROUND_RED or BACKGROUND_INTENSITY or
  FOREGROUND_RED or FOREGROUND_GREEN or FOREGROUND_BLUE
  or FOREGROUND_INTENSITY;

var
  ConHandle: THandle; // ���������� ����������� ����
  Coord: TCoord; // ��� ��������/��������� ������� ������
  MaxX, MaxY: Word; // ��� �������� ������������ �������� ����
  CCI: TConsoleCursorInfo;
  NOAW: LongInt; // ��� �������� ����������� ��������� �������


//---------------------------------------
// ������ ������ ������� ("status line")
//---------------------------------------
procedure StatusLine(S : string);
begin
  Coord.X := 0; Coord.Y := 0;
  WriteConsoleOutputCharacter(ConHandle, PChar(S), Length(S)+1, Coord, NOAW);
  FillConsoleOutputAttribute (ConHandle, WhiteOnRed, Length(S), Coord, NOAW);
end;

//-----------------------------------------------------
// ���������� ���������� �������
//-----------------------------------------------------
function ConProc(CtrlType : DWord) : Bool; stdcall; far;
var
  S: string;
begin
  case CtrlType of
    CTRL_C_EVENT: S := 'CTRL_C_EVENT';
    CTRL_BREAK_EVENT: S := 'CTRL_BREAK_EVENT';
    CTRL_CLOSE_EVENT: S := 'CTRL_CLOSE_EVENT';
    CTRL_LOGOFF_EVENT: S := 'CTRL_LOGOFF_EVENT';
    CTRL_SHUTDOWN_EVENT: S := 'CTRL_SHUTDOWN_EVENT';
    else
      S := 'UNKNOWN_EVENT';
  end;
  MessageBox(0, PChar(S + ' detected'), 'Win32 Console', MB_OK);
  Result := True;
end;

{
[]-----------------------------------------------------------[]
�������� ��������� - ���������� ������������� ��������� �����������
� ��� �� ��������� ������� ����������� API
[]-----------------------------------------------------------[]
}
var
  R: TSmallRect;
  Color: Word;
  OSVer: TOSVersionInfo;
  IBuff: TInputRecord;
  IEvent: DWord;
  Continue: Bool;

begin
  // ������������� ���������� ����������
  Init;
  // ������������ ���� �� ������
  {!! 1.01 !!}
  with R do
  begin
    Left := 10;
    Top := 10;
    Right := 40;
    Bottom := 40;
  end

  {!! 1.01 !!}
  SetConsoleWindowInfo(ConHandle, False, R);
  // ������������� ���������� �������
  SetConsoleCtrlHandler(@ConProc, True);
  // ��������� ���������� �������
  GenerateConsoleCtrlEvent(CTRL_C_EVENT, 0);
  // �������� ��������� ����
  SetConsoleTitle('Console Demo');
  // ������ ������
  ShowCursor(False);
  Coord.X := 0; Coord.Y := 0;
  // ������������� ����� ����� �� ����� ����
  Color := WhiteOnBlue;
  FillConsoleOutputAttribute(ConHandle, Color, MaxX * MaxY, Coord, NOAW);
  // Console Code Page API is not supported under Win95 - only GetConsoleCP
  Writeln('Console Code Page = ', GetConsoleCP);
  Writeln('Max X=', MaxX,' Max Y=', MaxY);
  Readln; // ������� ����� ������������
  Cls; // ������� �����
  ShowCursor(True); // ���������� ������

  // Use some Win32API stuff
  OSVer.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(OSVer);
  with OSVer do
  begin
    Writeln('dwMajorVersion = ', dwMajorVersion);
    Writeln('dwMinorVersion = ', dwMinorVersion);
    Writeln('dwBuildNumber = ', dwBuildNumber);
    Writeln('dwPlatformID = ', dwPlatformID);
  end;

  // ������� ����� ������������
  Readln;
  // ������� ���������� �������
  SetConsoleCtrlHandler(@ConProc, False);
  Cls;

  // "���� ��������� ���������"
  Continue := True;
  while Continue do
  begin
    ReadConsoleInput(GetConInputHandle, IBuff, 1, IEvent);
    case IBuff.EventType of
      KEY_EVENT :
        begin
          // ��������� ������� ESC � ��������� ���������
          if ((IBuff.KeyEvent.bKeyDown = True) and
          (IBuff.KeyEvent.wVirtualKeyCode = VK_ESCAPE)) then
            Continue := False;
        end;
      _MOUSE_EVENT :
        begin
          with IBuff.MouseEvent.dwMousePosition do
            StatusLine(Format('%d, %d', [X, Y]));
        end;
    end;
  end {While}
end. *)


{$HINTS OFF}
{$APPTYPE CONSOLE}
{*******************************************************}
{                                                       }
{       Turbo Pascal Runtime Library                    }
{       CRT Interface Unit                              }
{                                                       }
{       Copyright (C) 1988,92 Borland International     }
{                                                       }
{*******************************************************}
{                     DELPHI 3.0                        }
{         Copyright (C) 1998  Sergey Perevoznik         }
{*******************************************************}

{Note: Some procedures very old and use only for compatibilites}

unit Crt;

interface

Uses Windows;

const

{ CRT modes }

  BW40          = 0;            { 40x25 B/W on Color Adapter }
  CO40          = 1;            { 40x25 Color on Color Adapter }
  BW80          = 2;            { 80x25 B/W on Color Adapter }
  CO80          = 3;            { 80x25 Color on Color Adapter }
  Mono          = 7;            { 80x25 on Monochrome Adapter }
  Font8x8       = 256;          { Add-in for ROM font }

{ Mode constants for 3.0 compatibility }

  C40           = CO40;
  C80           = CO80;

{ Foreground and background color constants }

  Black         = 0;
  Blue          = 1;
  Green         = 2;
  Cyan          = 3;
  Red           = 4;
  Magenta       = 5;
  Brown         = 6;
  LightGray     = 7;

{ Foreground color constants }

  DarkGray      = 8;
  LightBlue     = 9;
  LightGreen    = 10;
  LightCyan     = 11;
  LightRed      = 12;
  LightMagenta  = 13;
  Yellow        = 14;
  White         = 15;

{ Add-in for blinking }

  Blink         = 128;

var

{ Interface variables }

  CheckBreak  : Boolean;       { Enable Ctrl-Break              }
  CheckEOF    : Boolean;       { Enable Ctrl-Z                  }
  DirectVideo : Boolean;       { Enable direct video addressing }
  CheckSnow   : Boolean;       { Enable snow filtering          }
  LastMode    : Word;          { Current text mode              }
  TextAttr    : Word;          { Current text attribute         }
  WindMin     : Word;          { Window upper left coordinates  }
  WindMax     : Word;          { Window lower right coordinates }

{ Interface procedures }

procedure AssignCrt(var F: Text);
function  KeyPressed: Boolean;
function  ReadKey: Char;
procedure TextMode(Mode: Integer);
procedure Window(X1,Y1,X2,Y2: Short);
procedure GotoXY(X,Y: Byte);
function  WhereX: Short;
function  WhereY: Short;
procedure ClrScr;
procedure ClrEol;
procedure InsLine;
procedure DelLine;
procedure TextColor(Color: Byte);
procedure TextBackground(Color: Byte);
procedure LowVideo;
procedure HighVideo;
procedure NormVideo;
procedure Delay(MS: Word);
procedure Sound(Hz: Word);
procedure NoSound;

{Extended}
Procedure SetTitle(Title : PChar);

Var WHandle, RHandle : THandle;

implementation

uses SysUtils;

var
  vPBI : TConsoleScreenBufferInfo;


procedure AssignCrt(var F: Text);
begin
end;

function  KeyPressed: Boolean;
Var irInBuf : TInputRecord;
    W : DWord;
begin
  KeyPressed := False;
  if PeekConsoleInput(RHandle,irInBuf,1,W) then
    if ( (irInBuf.EventType = Key_Event) and
         (irInBuf.Event.KeyEvent.bKeyDown = true))
       then
      KeyPressed := true;
end;


function ReadKey: Char;
var
  NumRead:       DWORD;
  InputRec:      TInputRecord;
begin
  repeat
    ReadConsoleInput(RHandle,InputRec,
                             1,
                             NumRead);
    if InputRec.EventType <> KEY_EVENT then
    Continue;

   if InputRec.Event.KeyEvent.bKeyDown then
     begin
        case InputRec.Event.KeyEvent.dwControlKeyState of
          0 : begin
               Result := InputRec.Event.KeyEvent.AsciiChar;
               Exit;
              end;
        256 : begin
               Result := Chr(InputRec.Event.KeyEvent.wVirtualScanCode);
               Exit;
              end
          else begin
               Result := InputRec.Event.KeyEvent.AsciiChar;
               Exit;
               end;
         end
     end
  until false;
end;



procedure TextMode(Mode: Integer);
begin
end;

procedure Window(X1,Y1,X2,Y2: Short);
Var vWinCon : TSmallRect;
begin
  with vWinCon do
    begin
      Left   := X1-1;
      Top    := Y1-1;
      Right  := X2-1;
      Bottom := Y2-1;
    end;
  SetConsoleWindowInfo(WHandle,true,vWinCon);
end;

procedure GotoXY(X,Y: Byte);
Var vCPos : TCoord;
begin
 vCPos.X := X-1;
 vCPos.Y := Y-1;
 SetConsoleCursorPosition(WHandle,vCPos);
end;

function  WhereX: Short;
begin
  GetConsoleScreenBufferInfo(WHandle,vPBI);
  WhereX := vPBI.dwCursorPosition.X + 1;
end;

function  WhereY: Short;
begin
  GetConsoleScreenBufferInfo(WHandle,vPBI);
  WhereY := vPBI.dwCursorPosition.Y + 1;
end;

procedure ClrScr;
Var
  vCPos : TCoord;
  W     : DWORD;
begin
  vCPos.X := 0;
  vCPos.Y := 0;
  GetConsoleScreenBufferInfo(WHandle,vPBI);
  FillConsoleOutputAttribute(WHandle,TextAttr,vPBI.dwSize.x*vPBI.dwSize.y,vCPos,W);
  FillConsoleOutputCharacter(WHandle,' ',vPBI.dwSize.x*vPBI.dwSize.y,vCPos,W);
  GotoXY(1,1);
end;

Procedure ClrEol;
Var
  vCPos  :tCoord;
  Len,
  W      : DWORD;
begin
  GetConsoleScreenBufferInfo(WHandle,vPBI);
  len     := vPBI.dwSize.x-vPBI.dwCursorPosition.x;
  vCPos.x := vPBI.dwCursorPosition.x;
  vCPos.y := vPBI.dwCursorPosition.y;
  FillConsoleOutputAttribute(WHandle,TextAttr,len,vCPos,W);
  FillConsoleOutputCharacter(WHandle,#32,len,vCPos,W);
end;

Procedure InsLine;
var
 ssr   : TSmallRect;
 coord : TCoord;
 ci    : TCharInfo;
 W     : DWORD;
begin
  GetConsoleScreenBufferInfo(WHandle,vPBI);
  coord         := vPBI.dwCursorPosition;
  ssr.left      := 0;
  ssr.top       := coord.y;
  ssr.right     := vPBI.srwindow.right;
  ssr.bottom    := vPBI.srwindow.bottom;
  ci.asciichar  := ' ';
  ci.attributes := vPBI.wattributes;
  coord.x       := 0;
  coord.y       := coord.y+1;
  ScrollConsoleScreenBuffer(WHandle,ssr,nil,coord,ci);
  coord.y       := coord.y-1;
  FillConsoleOutputAttribute(WHandle,TextAttr,vPBI.dwsize.x*vPBI.dwsize.y,coord,W);
end;

procedure DelLine;
var
 ssr   : TSmallRect;
 coord : TCoord;
 ci    : TCharInfo;
 W     : DWORD;
begin
  GetConsoleScreenBufferInfo(WHandle,vPBI);
  coord         := vPBI.dwCursorPosition;
  ssr.left      := 0;
  ssr.top       := coord.y+1;
  ssr.right     := vPBI.srwindow.right;
  ssr.bottom    := vPBI.srwindow.bottom;
  ci.asciichar  := ' ';
  ci.attributes := vPBI.wattributes;
  coord.x       := 0;
  coord.y       := coord.y;
  ScrollConsoleScreenBuffer(WHandle,ssr,nil,coord,ci);
  FillConsoleOutputAttribute(WHandle,TextAttr,vPBI.dwsize.x*vPBI.dwsize.y,coord,W);
end;

procedure TextColor(Color: Byte);
begin
  TextAttr := (color and $f) or (TextAttr and $f0);
  SetConsoleTextAttribute(WHandle,TextAttr);
end;

procedure TextBackground(Color: Byte);
begin
  TextAttr := (color shl 4) or (TextAttr and $f);
  SetConsoleTextAttribute(WHandle,TextAttr);
end;

procedure LowVideo;
begin
  TextAttr := TextAttr AND $0F7;
  SetConsoleTextAttribute(WHandle,TextAttr);
end;

procedure HighVideo;
begin
  TextAttr := TextAttr OR $8;
  SetConsoleTextAttribute(WHandle,TextAttr);
end;

procedure NormVideo;
begin
  TextAttr := $07;
  SetConsoleTextAttribute(WHandle,TextAttr);
end;

procedure Delay(MS: Word);
var
   FirstTickCount:DWORD;
begin
     FirstTickCount:=GetTickCount;
     repeat
     until ((GetTickCount-FirstTickCount) >= DWORD(MS));
end;

Procedure Sound(Hz:Word); assembler;
   ASM
      MOV  BX,Hz
      MOV  AX,34DDH
      MOV  DX,0012H
      CMP  DX,BX
      JNC  @DONE
      DIV  BX
      MOV  BX,AX
      IN   AL,61H
      TEST AL,3
      JNZ  @99
      OR   AL,3
      OUT  61H,AL
      MOV  AL,0B6H
      OUT  43H,AL
@99:  MOV  AL,BL
      OUT  42H,AL
      MOV  AL,BH
      OUT  42H,AL
@DONE:
  end;

Procedure NoSound; assembler;
  asm
     IN   AL, $61
     AND  AL, $FC
     OUT  $61, AL
  end;


Procedure SetTitle(Title : PChar);
begin
  SetConsoleTitle(Title);
end;


Procedure Init;
begin
  RHandle := GetStdHandle(STD_INPUT_HANDLE);
  WHandle := GetStdHandle(STD_OUTPUT_HANDLE);
  SetFileApisToOEM;
  TextAttr := $07;
  WindMin  := $0101;
  WindMax  := $1950;
  FlushConsoleInputBuffer(RHandle);
end;

Initialization
 Init;
end.

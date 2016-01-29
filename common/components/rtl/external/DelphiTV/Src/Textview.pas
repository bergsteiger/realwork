
{*******************************************************}
{                                                       }
{       Turbo Pascal Version 7.0                        }
{       Turbo Vision Unit                               }
{                                                       }
{       Copyright (c) 1992 Borland International        }
{                                                       }
{       Virtual Pascal v2.1                             }
{       Copyright (C) 1996-2000 vpascal.com             }
{                                                       }
{*******************************************************}

unit TextView;

{$X+,I-,S-,H-}

interface

uses Use32, Objects, Drivers, Views, W32SysLow;

type

  { TTextDevice }

  PTextDevice = ^TTextDevice;
  TTextDevice = object(TScroller)
    function StrRead(var S: TextBuf): Byte; virtual;
    procedure StrWrite(var S: TextBuf; Count: Byte); virtual;
  end;

  { TTerminal }

  PTerminalBuffer = ^TTerminalBuffer;
  TTerminalBuffer = array[0..65534] of Char;

  PTerminal = ^TTerminal;
  TTerminal = object(TTextDevice)
    BufSize: Word;
    Buffer: PTerminalBuffer;
    QueFront, QueBack: Word;
    constructor Init(var Bounds:TRect; AHScrollBar, AVScrollBar: PScrollBar;
      ABufSize: Word);
    destructor Done; virtual;
    procedure BufDec(var Val: Word);
    procedure BufInc(var Val: Word);
    function CalcWidth: Integer;
    function CanInsert(Amount: Word): Boolean;
    procedure Draw; virtual;
    function NextLine(Pos:Word): Word;
    function PrevLines(Pos:Word; Lines: Word): Word; pascal;
    function StrRead(var S: TextBuf): Byte; virtual;
    procedure StrWrite(var S: TextBuf; Count: Byte); virtual;
    function QueEmpty: Boolean;
  end;

procedure AssignDevice(var T: Text; Screen: PTextDevice);

implementation

{ TTextDevice }

function TTextDevice.StrRead(var S: TextBuf): Byte;
begin
  StrRead := 0;
end;

procedure TTextDevice.StrWrite(var S: TextBuf; Count: Byte);
begin
end;

{ TTerminal }

constructor TTerminal.Init(var Bounds:TRect; AHScrollBar,
  AVScrollBar: PScrollBar; ABufSize: Word);
begin
  TTextDevice.Init(Bounds, AHScrollBar, AVScrollBar);
  GrowMode := gfGrowHiX + gfGrowHiY;
  BufSize := ABufSize;
  if BufSize > 65520 then BufSize := 65520;
  GetMem(Buffer, BufSize);
  QueFront := 0;
  QueBack := 0;
  SetLimit(0,1);
  SetCursor(0,0);
  ShowCursor;
end;

destructor TTerminal.Done;
begin
  FreeMem(Buffer, BufSize);
  TTextDevice.Done;
end;

procedure TTerminal.BufDec(var Val: Word);
begin
  if Val = 0 then Val := BufSize - 1
  else Dec(Val);
end;

procedure TTerminal.BufInc(var Val: Word);
begin
  Inc(Val);
  if Val >= BufSize then Val := 0;
end;

function TTerminal.CalcWidth: Integer;
var
  I, Len, Width: Integer;
  CurPos, EndPos: Integer;
begin
  Width := 0;
  CurPos := QueBack;
  for I := 1 to Limit.Y do
  begin
    EndPos := NextLine(CurPos);
    if EndPos >= CurPos then
      Len := EndPos - CurPos else
      Len := BufSize - CurPos + EndPos;
    if Buffer^[EndPos-1] = #10 then
      Dec(Len) else
      Inc(Len);
    if Len > Width then
      Width := Len;
    CurPos := EndPos;
  end;
  CalcWidth := Width;
end;

function TTerminal.CanInsert(Amount: Word): Boolean;
var
  T: Longint;
begin
  if QueFront < QueBack then T := QueFront + Amount
  else T := LongInt(QueFront) - LongInt(BufSize) + Amount;
  CanInsert := QueBack > T;
end;

procedure TTerminal.Draw;
var
  I: Integer;
  BegLine, EndLine: Word;
  S: String;
  T: Longint;
  BottomLine: Word;
begin
  BottomLine := Size.Y + Delta.Y;
  if Limit.Y > BottomLine then
  begin
    EndLine := PrevLines(QueFront, Limit.Y-BottomLine);
    BufDec(EndLine);
  end
  else EndLine := QueFront;
  if Limit.Y-1 >= Size.Y then I := Size.Y-1
  else
  begin
    for I := Limit.Y to Size.Y-1 do
      WriteChar(0, I, ' ', 1, Size.X);
    I := Limit.Y-1;
  end;
  for I := I downto 0 do
  begin
    BegLine := PrevLines(EndLine,1);
    if EndLine >= BegLine then
    begin
      T := EndLine - BegLine;
      Move(Buffer^[BegLine], S[1], T);
      S[0] := Char(T);
    end
    else
    begin
      T := BufSize - BegLine;
      Move(Buffer^[BegLine], S[1], T);
      Move(Buffer^, S[T+1], EndLine);
      S[0] := Char(T + EndLine);
    end;
    if Delta.X >= Length(S) then S := ''
    else S := Copy(S, Delta.X+1, 255);
    WriteStr(0, I, S, 1);
    WriteChar(Length(S), I, ' ', 1, Size.X);
    EndLine := BegLine;
    BufDec(EndLine);
  end;
end;

function TTerminal.NextLine(Pos:Word): Word;
begin
  if Pos <> QueFront then
  begin
    while (Buffer^[Pos] <> #10) and (Pos <> QueFront) do
      BufInc(Pos);
    if Pos <> QueFront then BufInc(Pos);
  end;
  NextLine := Pos;
end;

procedure DecEDi;
asm
                cmp     edi,[esi].TTerminal.Buffer
                ja      @@1
                add     edi,[esi].TTerminal.BufSize
              @@1:
                dec     edi
end;

procedure IncEDi;
asm
                inc     edi
                mov     eax,[esi].TTerminal.Buffer
                add     eax,[esi].TTerminal.BufSize
                cmp     edi,eax
                jb      @@1
                mov     edi,[esi].TTerminal.Buffer
              @@1:
end;

function TTerminal.PrevLines(Pos:Word; Lines:Word): Word; pascal;
const
  LineSeparator = #10;
asm
                push esi
                push edi
                mov     esi,Self
                mov     edi,[esi].TTerminal.Buffer
                add     edi,Pos
              @@1:
                mov     ecx,Lines
                jecxz   @@6
                mov     eax,[esi].TTerminal.QueBack
                add     eax,[esi].TTerminal.Buffer
                cmp     edi,eax
                je      @@7
                Call    DecEDI
              @@2:
                mov     eax,[esi].TTerminal.QueBack
                add     eax,[esi].TTerminal.Buffer
                cmp     edi,eax
                ja      @@3
                mov     ecx,edi
                sub     ecx,[esi].TTerminal.Buffer
                jmp     @@4
              @@3:
                mov     ecx,edi
                sub     ecx,eax
              @@4:
                mov     al,LineSeparator
                inc     ecx
                std
                repne   scasb
                je      @@5
                mov     eax,edi
                sub     eax,[esi].TTerminal.Buffer
                inc     eax
                cmp     eax,[esi].TTerminal.QueBack
                je      @@8
                mov     edi,[esi].TTerminal.Buffer
                add     edi,[esi].TTerminal.BufSize
                dec     edi
                jmp     @@2
              @@5:
                dec     Lines
                jnz     @@2
              @@6:
                Call    IncEDI
                Call    IncEDI
                mov     eax,edi
              @@7:
                sub     eax,[esi].TTerminal.Buffer
              @@8:
                pop edi
                pop esi
end;

function TTerminal.StrRead(var S: TextBuf): Byte;
begin
  StrRead := 0;
end;

procedure TTerminal.StrWrite(var S: TextBuf; Count: Byte);
var
  I, J: Word;
  ScreenLines: Word;
begin
  if Count = 0 then
    Exit else
    if Count >= BufSize then
      Count := BufSize-1;
  ScreenLines := Limit.Y;
  J := 0;
  for I := 0 to Count-1 do
    case S[I] of
      #13: Dec(Count)
      else
      begin
        if S[I] = #10 then Inc(ScreenLines);
        S[J] := S[I];
        Inc(J);
      end;
    end;

  while not CanInsert(Count) do
  begin
    QueBack := NextLine(QueBack);
    Dec(ScreenLines);
  end;

  if LongInt(QueFront) + Count >= BufSize then
  begin
    I := BufSize - QueFront;
    Move(S,Buffer^[QueFront], I);
    Move(S[I],Buffer^, Count - I);
    QueFront := Count - I;
  end
  else
  begin
    Move(S,Buffer^[QueFront],Count);
    Inc(QueFront,Count);
  end;
  SetLimit(CalcWidth,ScreenLines);
  ScrollTo(0, ScreenLines+1);
  I := PrevLines(QueFront,1);
  if I <= QueFront then I := QueFront - I
  else I := BufSize - (I - QueFront);
  SetCursor(I, ScreenLines-Delta.Y-1);
  DrawView;
end;

function TTerminal.QueEmpty: Boolean;
begin
  QueEmpty := QueBack = QueFront;
end;

{ Window Text Device Driver }

type
  WindowData = record
    Screen: PTextDevice;
    Filler: array [1..28] of Char;
  end;

function WindowWrite(var F: TextRec): Integer; far;
begin
  with F do
  begin
    WindowData(UserData).Screen^.StrWrite(BufPtr^, BufPos);
    BufPos := 0;
  end;
  WindowWrite := 0;
end;

function WindowRead(var F: TextRec): Integer; far;
begin
  with F do
  begin
    BufPos := 0;
    BufEnd := WindowData(F.UserData).Screen^.StrRead(BufPtr^);
  end;
  WindowRead := 0;
end;

function WindowFlush(var F: TextRec): Integer; far;
begin
  F.BufPos := 0;
  F.BufEnd := 0;
  WindowFlush := 0;
end;

function WindowOpen(var F: TextRec): Integer; far;
begin
  with F do
  begin
    if Mode = fmInput then
    begin
      InOutFunc := @WindowRead;
      FlushFunc := @WindowFlush;
    end
    else
    begin
      InOutFunc := @WindowWrite;
      FlushFunc := @WindowWrite;
    end;
    WindowOpen := 0;
  end;
end;

function WindowIgnore(var F: TextRec): Integer; far;
begin
  WindowIgnore := 0;
end;

var
  Buffer: TextBuf;

procedure AssignDevice(var T: Text; Screen: PTextDevice);
begin
  with TextRec(T) do
  begin
    Handle := $FFFFFFFF;
    Mode := fmClosed;
    BufSize := SizeOf(Buffer);
    BufPtr := @Buffer;
    OpenFunc := @WindowOpen;
    CloseFunc := @WindowIgnore;
    WindowData(UserData).Screen:= Screen;
  end;
end;

end.

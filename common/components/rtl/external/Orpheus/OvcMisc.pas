{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                   OVCMISC.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcMisc;
  {-Miscellaneous functions and procedures}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Controls, Forms, Graphics, Messages, SysUtils,
  OvcData;

function CompStruct(const S1, S2; Size : Cardinal) : Integer;
  {-Compare two fixed size structures}
function LoadOvcBaseBitmap(lpBitmapName : PAnsiChar) : HBITMAP;
  {-load a bitmap and return the handle}
procedure FixRealPrim(P : PAnsiChar; DC : AnsiChar);                   {!!.16}
  {-get a PChar string representing a real ready for Val()}
function GetLeftButton: Byte;
  {-return the mapped left button}
function GetNextDlgItem(Ctrl : hWnd) : hWnd;
  {-get handle of next control in the same form}
function GetShiftFlags : Byte;
  {-get current shift flags, the high order bit is set if the key is down}
function CreateRotatedFont(F : TFont; Angle : Integer) : hFont;
  {-create a rotated font based on the font object F}
{!!.01} {revised}
function GetTopTextMargin(Font : TFont; BorderStyle : TBorderStyle;
         Height : Integer; Ctl3D : Boolean) : Integer;
  {-return the pixel top margin size}
function PtrDiff(const P1, P2) : Word;                                 {!!.10}
  {-return the difference between P1 and P2}
procedure PtrInc(var P; Delta : Word);                                 {!!.10}
  {-increase P by Delta}
procedure PtrDec(var P; Delta : Word);                                 {!!.10}
  {-decrease P by Delta}


implementation

uses
  {$IFDEF Version3}   {this circular reference causes problems with Delphi 1}
  OvcBase,            {and is only really needed for version 3 or later.    }
  {$ENDIF}
  OvcStr;


{$IFDEF Win32}

function CompStruct(const S1, S2; Size : Cardinal) : Integer; register;
  {-compare two fixed size structures}
asm
  push    esi
  push    edi

  mov     esi, eax     {pointer to S1}
  mov     edi, edx     {pointer to S2}

  xor     eax, eax     {eax holds temporary result (Equal)}

  or      ecx, ecx     {size is already in ecx}
  jz      @@CSDone     {make sure size isn't zero}

  cld                  {go forward}
  repe    cmpsb        {compare until no match or ecx = 0}

  je      @@CSDone     {if equal, result is already in eax}
  inc     eax          {prepare for greater}
  ja      @@CSDone     {S1 greater? return +1}
  mov     eax, -1      {else S1 less, return -1}

@@CSDone:

  pop     edi
  pop     esi
end;

{$ELSE}

function CompStruct(const S1, S2; Size : Cardinal) : Integer; assembler;
  {-compare two fixed size structures}
asm
  mov     dx,ds        {save ds}

  xor     ax,ax        {AX holds temporary result (Equal)}

  mov     cx,Size      {size in cx}
  jcxz    @@CSDone     {make sure size isn't zero}

  les     di,S2        {es:di points to S2}
  lds     si,S1        {ds:si points to S1}

  cld                  {go forward}
  repe    cmpsb        {compare until no match or cx = 0}

  je      @@CSDone     {if equal, result ready based on length}
  inc     ax           {prepare for greater}
  ja      @@CSDone     {S1 greater? return +1}
  mov     ax,-1        {else S1 less, return -1}

@@CSDone:

  mov     ds,dx        {restore ds}
end;
{$ENDIF}

function LoadOvcBaseBitmap(lpBitmapName : PAnsiChar) : HBITMAP;
begin
  {$IFDEF Version3}
  Result := LoadBitmapA(FindClassHInstance(TOvcBase), lpBitmapName);
  {$ELSE}
  Result := LoadBitmap(HInstance, lpBitmapName);
  {$ENDIF}
end;

{!!.16}
procedure FixRealPrim(P : PAnsiChar; DC : AnsiChar);
  {-Get a string representing a real ready for Val()}
var
  DotPos : Cardinal;
  EPos   : Cardinal;
  Len    : Word;
  Found  : Boolean;
  EFound : Boolean;
begin
  TrimAllSpacesPChar(P);

  Len := StrLen(P);
  if Len > 0 then begin
    if P[Len-1] = DC then begin
      Dec(Len);
      P[Len] := #0;
      TrimAllSpacesPChar(P);                                           {!!.14}
    end;

    {Val doesn't accept alternate decimal point chars}
    Found := StrChPos(P, DC, DotPos);
    if Found and (DotPos > 0) then
      P[DotPos] := '.';  {replace with '.'}

    if Found then begin

      {check for 'nnnn.'}
      if DotPos + 1 = Len then begin
        P[Len] := '0';
        Inc(Len);
        P[Len] := #0;
      end;

      {check for '.nnnn'}
      if DotPos = 0 then begin
        StrChInsertPrim(P, '0', 0);
        Inc(Len);
        Inc(DotPos);
      end;

      {check for '-.nnnn'}
      if (Len > 1) and (P^ = '-') and (DotPos = 1) then begin
        StrChInsertPrim(P, '0', 1);
        Inc(DotPos);
      end;

    end;

    {fix up numbers with exponents}
    EFound := StrChPos(P, 'E', EPos);
    if EFound and (EPos > 0) then begin
      if not Found then begin
        StrChInsertPrim(P, '.', EPos);
        DotPos := EPos;
        Inc(EPos);
      end;
      if EPos-DotPos < 12 then
        StrStInsertPrim(P, '00000', EPos);
    end;

    {remove blanks before and after '.' }
    if Found then begin
      while (DotPos > 0) and (P[DotPos-1] = ' ') do begin
        StrStDeletePrim(P, DotPos-1, 1);
        Dec(DotPos);
      end;
      while P[DotPos+1] = ' ' do
        StrStDeletePrim(P, DotPos+1, 1);
    end;

  end else begin
    {empty string = '0'}
    P[0] := '0';
    P[1] := #0;
  end;
end;

function GetLeftButton: Byte;
const
  RLButton : array[Boolean] of Word = (VK_LBUTTON, VK_RBUTTON);
begin
  Result := RLButton[GetSystemMetrics(SM_SWAPBUTTON) <> 0];
end;

function GetNextDlgItem(Ctrl : hWnd) : hWnd;
  {-Get handle of next control in the same form}
begin
  {asking for previous returns next}
  Result := GetNextWindow(Ctrl, GW_HWNDPREV);
  if Result = 0 then begin
    {asking for last returns first}
    Result := GetWindow(Ctrl, GW_HWNDLAST);
    if Result = 0 then
      Result := Ctrl;
  end;
end;

function GetShiftFlags : Byte;
  {-get current shift flags, the high order bit is set if the key is down}
begin
  Result := (Ord(GetKeyState(VK_CONTROL) < 0) * ss_Ctrl) +
            (Ord(GetKeyState(VK_SHIFT  ) < 0) * ss_Shift) +
            (Ord(GetKeyState(VK_ALT    ) < 0) * ss_Alt);
end;

function CreateRotatedFont(F : TFont; Angle : Integer) : hFont;
  {-create a rotated font based on the font object F}
var
  LF : TLogFont;
begin
  FillChar(LF, SizeOf(LF), #0);
  with LF do begin
    lfHeight           := F.Height;
    lfWidth            := 0;
    lfEscapement       := Angle*10;
    lfOrientation      := 0;
    if fsBold in F.Style then
      lfWeight         := FW_BOLD
    else
      lfWeight         := FW_NORMAL;
    lfItalic           := Byte(fsItalic in F.Style);
    lfUnderline        := Byte(fsUnderline in F.Style);
    lfStrikeOut        := Byte(fsStrikeOut in F.Style);
    lfCharSet          := F.CharSet; //DEFAULT_CHARSET;
    StrPCopy(lfFaceName, F.Name);
    lfQuality          := DEFAULT_QUALITY;
    {everything else as default}
    lfOutPrecision     := OUT_DEFAULT_PRECIS;
    lfClipPrecision    := CLIP_DEFAULT_PRECIS;
    case F.Pitch of
      fpVariable : lfPitchAndFamily := VARIABLE_PITCH;
      fpFixed    : lfPitchAndFamily := FIXED_PITCH;
    else
      lfPitchAndFamily := DEFAULT_PITCH;
    end;
  end;
  Result := CreateFontIndirect(LF);
end;

{!!.01} {revised}
function GetTopTextMargin(Font : TFont; BorderStyle : TBorderStyle;
         Height : Integer; Ctl3D : Boolean) : Integer;
  {-return the pixel top margin size}
var
  I          : Integer;
  DC         : hDC;
  SaveFont   : hFont;
  Metrics    : TTextMetric;
  SysMetrics : TTextMetric;
begin
  DC := GetDC(0);
  try
    GetTextMetrics(DC, SysMetrics);
    SaveFont := SelectObject(DC, Font.Handle);
    GetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
  finally
    ReleaseDC(0, DC);
  end;
  I := SysMetrics.tmHeight;
  if I > Metrics.tmHeight then
    I := Metrics.tmHeight;

  if NewStyleControls then begin
    {$IFDEF Win32}
    if BorderStyle = bsNone then begin
      Result := 0;
      if I >= Height-2 then
        Result := (Height-I-2) div 2 - Ord(Odd(Height-I));
    end else if Ctl3D then begin
      Result := 1;
      if I >= Height-4 then
        Result := (Height-I-4) div 2 - 1;
    end else begin
      Result := 1;
      if I >= Height-4 then
        Result := (Height-I-4) div 2 - Ord(Odd(Height-I));
    end;
    {$ELSE}
    if BorderStyle = bsNone then begin
      Result := 0;
      if I >= Height then
        Result := (Height-I) div 2 - 1;
    end else if Ctl3D then begin
      Result := 1;
      if I >= Height-2 then
        Result := (Height-2-I) div 2 - 1;
    end else begin
      Result := 2;
      if I >= Height-4 then
        Result := (Height-4-I) div 2;
    end;
    {$ENDIF}
  end else begin
{    Result := (Height-I-1) div 2;}                                    {!!.12}
    Result := (Height-Metrics.tmHeight-1) div 2;                       {!!.12}
    if I > Height-2 then begin
      Dec(Result, 2);
      if BorderStyle = bsNone then
        Inc(Result, 1);
    end;
  end;
end;

{!!.10}
{$IFDEF Win32}
function PtrDiff(const P1, P2) : Word;
  {-return the difference between P1 and P2}
begin
  {P1 and P2 are assumed to point within the same buffer}
  Result := PAnsiChar(P1) - PAnsiChar(P2);
end;
{$ELSE}
function PtrDiff(const P1, P2) : Word;
  {-return the difference between P1 and P2}
begin
  Result := Word(P1) - Word(P2);
end;
{$ENDIF}

{!!.10}
{$IFDEF Win32}
procedure PtrInc(var P; Delta : Word);
  {-increase P by Delta}
begin
  Inc(PAnsiChar(P), Delta);
end;
{$ELSE}
procedure PtrInc(var P; Delta : Word);
  {-increase P by Delta}
var
  PO : Word absolute P;
begin
  Inc(PO, Delta);
end;
{$ENDIF}

{!!.10}
{$IFDEF Win32}
procedure PtrDec(var P; Delta : Word);
  {-increase P by Delta}
begin
  Dec(PAnsiChar(P), Delta);
end;
{$ELSE}
procedure PtrDec(var P; Delta : Word);
  {-increase P by Delta}
var
  PO : Word absolute P;
begin
  Dec(PO, Delta);
end;
{$ENDIF}


end.

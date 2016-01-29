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
{*                  OVCEDITU.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcEditU;
  {-Editor utility routines}

interface

uses
  OvcBase, OvcData;

const
  MaxMarkers          = 10;    {maximum number of text markers}
  MaxHScrollRange     = 512;   {maximum horizontal scroll range}

  CRLF : array[1..2] of AnsiChar = ^M^J;

type
  TOvcEditBase = class(TOvcBase);

type
  TMarker = record
    Para  : LongInt;  {number of paragraph}
    Pos   : Integer;  {position in paragraph}
  end;
  TMarkerArray = array[0..MaxMarkers-1] of TMarker;

type
  {text position record}
  TOvcTextPos = packed record
    Line : LongInt;
    Col  : Integer;
  end;

function edBreakPoint(S : PAnsiChar; MaxLen : Word): Word;
  {-return the position to word break S}
procedure edDeleteSubString(S : PAnsiChar; SLen, Count, Pos : Integer);
  {-delete Cound characters from S starting at Pos}
function edEffectiveLen(S : PAnsiChar; Len : Word; TabSize : Byte) : Word;
  {-compute effective length of S, accounting for tabs}
function edFindNextLine(S : PAnsiChar; WrapCol : Integer) : PAnsiChar;
  {-find the start of the next line}
function edFindPosInMap(Map : Pointer; Lines, Pos : Integer) : Integer;
  {-return the para position}
function edGetActualCol(S : PAnsiChar; Col : Word; TabSize : Byte) : Word;
  {-compute actual column for effective column Col, accounting for tabs}
function edHaveTabs(S : PAnsiChar; Len : Word) : Boolean;
  {Return True if tab are found in S}
procedure edMoveBlock(var Src, Dest; Count : Word);
  {-move block of data from Src to Dest}
procedure edMoveFast(var Src, Dest; Count : Word);
  {-move block of data from Src to Dest fastly}
function edPadChPrim(S : PAnsiChar; C : AnsiChar; Len : Word) : PAnsiChar;
  {-return S padded with C to length Len}
function edPadPrim(S : PAnsiChar; Len : Word) : PAnsiChar;
  {-return a string right-padded to length len with blanks}
function edScanToEnd(P : PAnsiChar; Len : Word) : Word;
  {-return position of end of para P}
function edStrStInsert(Dest, S : PAnsiChar; DLen, SLen, Pos : Word) : PAnsiChar;
  {-insert S into Dest}
function edWhiteSpace(C : AnsiChar) : Boolean;
  {-return True if C is a white space character}


implementation


uses
  {$IFDEF Win32} Windows; {$ELSE} WinTypes, WinProcs; {$ENDIF}

{$IFNDEF Win32}
type
  CpuType = (Cpu8086, Cpu80186, Cpu80286, Cpu80386, Cpu80486, Cpu80586);

var
  edWhichCpu : CpuType;
{$ENDIF}

function edBreakPoint(S : PAnsiChar; MaxLen : Word): Word;
  {-return the position to word break S}
var
  I : Word;
begin
  I := MaxLen;
  while (I > 0) and not edWhiteSpace(S[I-1]) do
    Dec(I);
  if I = 0 then
    Result := MaxLen
  else
    Result := I;
end;

procedure edDeleteSubString(S : PAnsiChar; SLen, Count, Pos : Integer);
  {-delete Count characters from S starting at Pos}
begin
  if SLen+1 >= 1024 then
    edMoveBlock(S[Pos+Count], S[Pos], (SLen+1)-(Pos+Count))
  else
    edMoveFast(S[Pos+Count], S[Pos], (SLen+1)-(Pos+Count));
end;

{$IFDEF Win32}
function edEffectiveLen(S : PAnsiChar; Len : Word; TabSize : Byte) : Word; register;
  {-compute effective length of S, accounting for tabs}
asm {!!.12} {revised}
  push   edi            {save}
  push   esi            {save}
  push   ebx            {save}

  mov    esi,eax        {esi = S}
  xor    ebx,ebx        {clear}
  mov    bl,cl          {ebx = TabSize}
  xor    ecx,ecx        {clear}
  mov    cx,dx          {ecx = Len}
  xor    edi,edi        {temp length storage}
  xor    edx,edx

@@1:
  jcxz   @@2            {done if ecx is 0}
  dec    ecx            {decrement length}
  lodsb                 {get next character}
  or     al,al          {is it a null?}
  jz     @@2            {done if so}
  inc    edi            {increment length}
  cmp    al,9           {is it a tab?}
  jne    @@1            {if not, get next}
  dec    edi            {decrement length}
  mov    eax,edi        {ax has length}
  div    ebx            {divide by tabsize}
  inc    eax            {add one}
  mul    ebx            {multiply by tabsize}
  mov    edi,eax        {save result in edi}
  jmp    @@1            {get next character}
@@2:
  mov    eax,edi        {put effective length in eax}

  pop    ebx            {restore}
  pop    esi            {restore}
  pop    edi            {restore}
end;

(*!!.12
asm
  push   edi            {save}
  push   esi            {save}
  push   ebx            {save}

  mov    esi,eax        {esi = S}
  mov    bx,cx          {bx = TabSize}
  mov    cx,dx          {cx = Len}
  xor    di,di          {temp length storage}
  xor    edx,edx

  cld                   {go forward}
@@1:
  jcxz   @@2            {done if ecx is 0}
  dec    cx             {decrement length}
  lodsb                 {get next character}
  or     al,al          {is it a null?}
  jz     @@2            {done if so}
  inc    di             {increment length}
  cmp    al,9           {is it a tab?}
  jne    @@1            {if not, get next}
  dec    di             {decrement length}
  mov    ax,di          {ax has length}
  div    bx             {divide by tabsize}
  inc    ax             {add one}
  mul    bx             {multiply by tabsize}
  mov    di,ax          {save result in di}
  jmp    @@1            {get next character}
@@2:
  xor    eax,eax        {clear}
  mov    ax,di          {put effective length in eax}

  pop    ebx            {restore}
  pop    esi            {restore}
  pop    edi            {restore}
end;
*)

{$ELSE}
function edEffectiveLen(S : PAnsiChar; Len : Word; TabSize : Byte) : Word; assembler;
  {-compute effective length of S, accounting for tabs}
asm
  push ds        {save DS}
  lds si,S       {DS:SI = S}
  xor di,di      {length = 0}
  xor dx,dx
  mov bl,TabSize {BX has tabsize}
  xor bh,bh
  mov cx,len     {CX = length}
  cld            {go forward}
@1:
  jcxz @2        {done if cx is 0}
  dec cx         {decrement length}
  lodsb          {get next character}
  or al,al       {is it a null?}
  jz @2          {done if so}
  inc di         {increment length}
  cmp al,9       {is it a tab?}
  jne @1         {if not, get next}
  dec di         {decrement length}
  mov ax,di      {ax has length}
  div bx         {divide by tabsize}
  inc ax         {add one}
  mul bx         {multiply by tabsize}
  mov di,ax      {put result in DI}
  jmp @1         {get next character}
@2:
  pop ds         {restore DS}
  mov ax,di      {put length in AX}
end;
{$ENDIF}

{$IFDEF Win32}
function edFindNextLine(S : PAnsiChar; WrapCol : Integer) : PAnsiChar; register;
  {-find the start of the next line}
asm
  push   esi            {save}
  push   edi            {save}

  mov    esi,eax        {esi = S}
  mov    ecx,edx        {ecx = WrapCol}
  add    esi,ecx        {point to default wrap point}
  mov    edi,esi        {save esi in edi}

  std                   {go backward}
  inc    ecx
  cmp    byte ptr [esi],0 {is default wrap point a null?}
  jne    @@1
  mov    eax,edi        {force a break at the default wrap point}
  jmp    @@7

@@1:
  lodsb                 {next byte into al}
  cmp    al,'-'         {is it a hyphen?}
  ja     @@2
  je     @@3
  cmp    al,' '         {is it a space?}
  je     @@4
  cmp    al,9           {is it a tab?}
  je     @@4

@@2:
  loop   @@1            {try previous character}
  mov    eax,edi        {force a break at the default wrap point}
  jmp    @@7

@@3:
  inc    esi            {skip the hyphen}

@@4:
  cld                   {clear direction flag}
  inc    esi            {point to next character}

@@5:
  lodsb                 {next character into al}
  cmp    al,' '         {is it > than a space?}
  ja     @@6            {if so, we're done}
  je     @@5            {if it's a space, keep going}
  cmp    al,9           {if it's a tab, keep going}
  je     @@5            {otherwise, we're done}

@@6:
  dec    esi            {point to previous character}
  mov    eax,esi        {wrap point in eax}

@@7:
  pop    edi            {restore}
  pop    esi            {restore}
  cld                   {clear direction flag}
end;
{$ELSE}
function edFindNextLine(S : PAnsiChar; WrapCol : Integer) : PAnsiChar; assembler;
  {-find the start of the next line}
asm
  push ds          {save ds}
  lds si,S         {ds:si = S}
  mov cx,WrapCol   {cx = WrapCol}
  add si,cx        {point to default wrap point}
  mov di,si        {save si in di}
  std              {go backward}
  inc cx
  cmp byte ptr [si],0 {is default wrap point a null?}
  jne @1
  mov ax,di        {force a break at the default wrap point}
  jmp @7
@1:
  lodsb            {next byte into al}
  cmp al,'-'       {is it a hyphen?}
  ja @2
  je @3
  cmp al,' '       {is it a space?}
  je @4
  cmp al,9         {is it a tab?}
  je @4
@2:
  loop @1          {try previous character}
  mov ax,di        {force a break at the default wrap point}
  jmp @7
@3:
  inc si           {skip the hyphen}
@4:
  cld              {clear direction flag}
  inc si           {point to next character}
@5:
  lodsb            {next character into al}
  cmp al,' '       {is it > than a space?}
  ja @6            {if so, we're done}
  je @5            {if it's a space, keep going}
  cmp al,9         {if it's a tab, keep going}
  je @5            {otherwise, we're done}
@6:
  dec si           {point to previous character}
  mov ax,si        {offset of wrap point in ax}
@7:
  mov dx,ds        {segment of S in dx}
  pop ds           {restore ds}
  cld              {clear direction flag}
end;
{$ENDIF}

{$IFDEF Win32}
function edFindPosInMap(Map : Pointer; Lines, Pos : Integer) : Integer; register;
  {-return the para position}
asm
  push   esi            {save}
  push   ebx            {save}

  mov    esi,eax        {esi = Map}
  mov    ebx,ecx        {ebx = Pos}
  and    ebx,0FFFFh     {clear high word}
  dec    ebx            {ebx = Pos-1}
  mov    ecx,edx        {ecx = Lines}
  and    ecx,0FFFFh     {clear high word}
  mov    eax,ecx        {eax = Lines}
  dec    eax            {prepare for word access}
  shl    eax,1
  add    esi,eax        {point to position in Map}

  std                   {go backwards}
@@1:
  lodsw
  cmp    bx,ax
  jae    @@2
  loop   @@1

@@2:
  mov    eax,ecx        {result in eax}
  and    eax,0FFFFh     {clear high word}

  pop    ebx            {restore}
  pop    esi            {restore}
  cld                   {clear direction flag}
end;
{$ELSE}
function edFindPosInMap(Map : Pointer; Lines, Pos : Integer) : Integer; assembler;
  {-return the para position}
asm
  push ds
  lds si,Map
  mov cx,Lines
  mov ax,cx
  dec ax
  shl ax,1
  add si,ax
  mov bx,Pos
  dec bx
  std
@1:
  lodsw
  cmp bx,ax
  jae @2
  loop @1
@2:
  mov ax,cx
  cld
  pop ds
end;
{$ENDIF}

{$IFDEF Win32}
function edGetActualCol(S : PAnsiChar; Col : Word; TabSize : Byte) : Word; register;
  {-compute actual column for effective column Col, accounting for tabs}
asm
  push   esi            {save}
  push   edi            {save}
  push   ebx            {save}

  mov    esi,eax        {esi = S}
  and    edx,0FFFFh     {clear high word}                              {!!.12}
  mov    edi,edx        {edi = Col}
  {and    edi,0FFh}       {clear all except low byte}                  {!!.12}
  xor    ebx,ebx        {length = 0}
  mov    edx,ecx        {dl = TabSize}
  mov    dh,9           {dh = Tab char}
  and    edx,0FFFFh     {clear high word}
  xor    ecx,ecx        {ecx = actual column}

  cld                   {go forward}
@@1:
  inc    ecx            {increment column}
  lodsb                 {get next character}
  or     al,al          {is it a null?}
  jz     @@3            {done if so}
  inc    ebx            {increment effective length}
  cmp    al,dh          {is it a tab?}
  jne    @@2            {if not, check the column}
  dec    ebx            {decrement length}
  mov    eax,ebx        {eax has length}

  {!!.13}
  {determine integral offset}
  push   edx            {save}
  push   ecx            {save}
  xor    cx,cx          {use cx for division}
  mov    cl,dl          {cx=tab size}
  xor    dx,dx          {clear remainder register}
  div    cx             {divide by tabsize}
  inc    ax             {add one}
  mul    cx             {multiply by tabsize}
  pop    ecx            {restore}
  pop    edx            {restore - ignore upper 16 bits}

  {div    dl}           {divide by tabsize}                            {!!.13}
  {and    eax,0FFh}     {clear remainder}                              {!!.13}
  {inc    ax}           {add one}                                      {!!.13}
  {mul    dl}           {multiply by tabsize}                          {!!.13}

  mov    ebx,eax        {put result in ebx}

@@2:
  cmp    ebx,edi        {have we reached the target column yet?}
  jb     @@1            {get next character}

@@3:
  mov    eax,ecx        {put result in eax}

  pop    ebx            {restore}
  pop    edi            {restore}
  pop    esi            {restore}
end;
{$ELSE}
function edGetActualCol(S : PAnsiChar; Col : Word; TabSize : Byte) : Word; assembler;
  {-compute actual column for effective column Col, accounting for tabs}
asm
  push ds        {save DS}
  lds si,S       {DS:SI = S}
  xor bx,bx      {length = 0}
  mov dl,TabSize {DL has tabsize}
  mov dh,9       {DH = Tab}
  xor cx,cx      {CX = actual column}
  mov di,Col     {DI = target column}
  cld            {go forward}
@1:
  inc cx         {increment column}
  lodsb          {get next character}
  or al,al       {is it a null?}
  jz @3          {done if so}
  inc bx         {increment effective length}
  cmp al,dh      {is it a tab?}
  jne @2         {if not, check the column}
  dec bx         {decrement length}
  mov ax,bx      {ax has length}
  div dl         {divide by tabsize}
  inc ax         {add one}
  mul dl         {multiply by tabsize}
  mov bx,ax      {put result in BX}
@2:
  cmp bx,di      {have we reached the target column yet?}
  jb @1          {get next character}
@3:
  pop ds         {restore DS}
  mov ax,cx      {put result in AX}
end;
{$ENDIF}

{$IFNDEF Win32}
function edGetCPUType : CPUType;
  {-return the type of CPU being used}
var
  WinFlags : LongInt;
begin
  WinFlags := GetWinFlags;
  if LongBool(WinFlags and WF_CPU186) then
    Result := Cpu80186
  else if LongBool(WinFlags and WF_CPU286) then
    Result := Cpu80286
  else if LongBool(WinFlags and WF_CPU386) then
    Result := Cpu80386
  else if LongBool(WinFlags and WF_CPU486) then
    Result := Cpu80486
  else
    Result := Cpu8086;
end;
{$ENDIF}

{$IFDEF Win32}
function edHaveTabs(S : PAnsiChar; Len : Word) : Boolean; register;
  {-return True if tabs are found in S}
asm
  {Note: this routine returns true if Len=0}
  push   edi            {save}
  mov    edi,eax        {edi = S}
  mov    al,9           {al = Tab character}
  mov    ecx,edx        {ecx = Len}
  and    ecx,0FFFFh     {clear high word}
  cld                   {go forward}
  repne  scasb          {search for the character}
  mov    eax,0          {assume False}
  jne    @@1
  inc    eax            {else return True}
@@1:
  pop    edi            {restore}
end;
{$ELSE}
function edHaveTabs(S : PAnsiChar; Len : Word) : Boolean; assembler;
  {-return True if tabs are found in S}
asm
  {Note: this routine returns true if Len=0}
  les    di,S          {ES:DI = S}
  mov    al,9          {AL = Tab}
  mov    cx,Len        {CX has length}
  cld                  {go forward}
  repne  scasb         {search for the character}
  mov    al,0          {assume False}
  jne    @@1
  inc    al            {else return True}
@@1:
end;
{$ENDIF}

{$IFDEF Win32}
procedure edMoveBlock(var Src, Dest; Count : Word);
  {-move block of data from Src to Dest}
begin
  Move(Src, Dest, Count);
end;
{$ELSE}
procedure edMoveBlock(var Src, Dest; Count : Word); assembler;
  {-move block of data from Src to Dest}
asm
  push      ds
  cld
  mov       cx,Count
  mov       dx,3
  cmp       cx,dx
  jb        @@MoveWord
  cmp       edWhichCPU,dl
  jb        @@MoveWord

  cli
  db        66h
  xor       ax,ax
  db        66h
  mov       si,ax
  db        66h
  mov       di,ax
  lds       si,Src
  les       di,Dest
  mov       ax,ds
  mov       bx,es
  cmp       ax,bx
  jne       @@Align
  cmp       si,di
  ja        @@Align

  sti
  std
  dec       si
  dec       di
  add       si,cx
  add       di,cx
  mov       bx,cx
  mov       cx,di
  inc       cx
  and       cx,dx
  sub       bx,cx
  rep       movsb
  mov       cx,bx

  sub       si,dx
  sub       di,dx
  mov       bx,cx
  shr       cx,2
  rep
  db        66h
  movsw
  mov       cx,bx
  and       cx,dx
  add       si,dx
  add       di,dx
  rep       movsb
  jmp       @@Done
@@Align:
  sti
  test      di,dx
  jz        @@ForDWord
  movsb
  loop      @@Align
  jmp       @@Done
@@ForDWord:
  mov       bx,cx
  shr       cx,2
  rep
  db        66h
  movsw
  mov       cx,bx
  and       cx,dx
  rep       movsb
  jmp       @@Done
@@MoveWord:
  jcxz      @@Done
  lds       si,Src
  les       di,Dest
  mov       dx,ds
  mov       bx,es
  cmp       bx,dx
  jne       @@Forward
  cmp       si,di
  ja        @@Forward
@@Reverse:
  std
  add       si,cx
  add       di,cx
  dec       si
  dec       di
  test      di,1
  jnz       @@RevWord
  movsb
  dec       cx
@@RevWord:
  dec       si
  dec       di
  shr       cx,1
  rep       movsw
  jnc       @@Done
  inc       si
  inc       di
  jmp       @@OddByte
@@Forward:
  cld
  test      di,1
  jz        @@ForWord
  movsb
  dec       cx
@@ForWord:
  shr       cx,1
  rep       movsw
  jnc       @@Done
@@OddByte:
  movsb
@@Done:
  pop       ds
end;
{$ENDIF}

{$IFDEF Win32}
procedure edMoveFast(var Src, Dest; Count : Word);
  {-move block of data from Src to Dest fastly}
begin
  Move(Src, Dest, Count);
end;
{$ELSE}
procedure edMoveFast(var Src, Dest; Count : Word); assembler;
  {-move block of data from Src to Dest fastly}
asm
  push    ds
  lds     si,Src
  les     di,Dest
  mov     cx,Count
  jcxz    @@Done
  mov     dx,ds
  mov     bx,es
  cmp     bx,dx
  jne     @@Forward
  cmp     si,di
  ja      @@Forward
@@Reverse:
  std
  add     si,cx
  add     di,cx
  dec     si
  dec     di
  test    di,1
  jnz     @@RevWord
  movsb
  dec     cx
@@RevWord:
  dec     si
  dec     di
  shr     cx,1
  rep     movsw
  jnc     @@Done
  inc     si
  inc     di
  jmp     @@OddByte
@@Forward:
  cld
  test    di,1
  jz      @@ForWord
  movsb
  dec     cx
@@ForWord:
  shr     cx,1
  rep     movsw
  jnc     @@Done
@@OddByte:
  movsb
@@Done:
  pop     ds
end;
{$ENDIF}

{$IFDEF Win32}
function edPadChPrim(S : PAnsiChar; C : AnsiChar; Len : Word) : PAnsiChar; register;
  {-return S padded with C to length Len}
asm
  push   esi            {save}
  push   edi            {save}
  push   ebx            {save}

  mov    edi,eax        {edi = S}
  mov    esi,eax        {esi = S}
  mov    ebx,ecx        {save Len}
  and    ebx,0FFFFh     {clear high word}

  cld
  xor    eax, eax        {null}
  or     ecx, -1
  repne  scasb           {find null terminator}
  not    ecx             {calc length of S}
  dec    ecx             {backup one character}
  dec    edi
  mov    eax,ebx         {eax = Len}
  sub    eax,ecx         {find difference}
  jbe    @@ExitPoint     {nothing to do}
  mov    ecx,eax         {count of character to add}
  mov    al,dl           {al=C}
  rep    stosb           {add ecx characters}

@@ExitPoint:
  mov    byte ptr [edi],0
  mov    eax,esi

  pop    ebx            {restore}
  pop    edi            {restore}
  pop    esi            {restore}
end;
{$ELSE}
function edPadChPrim(S : PAnsiChar; C : AnsiChar; Len : Word) : PAnsiChar; assembler;
  {-return S padded with C to length Len}
asm
  les     di,S
  mov     dx,es
  mov     si,di
  cld
  xor     al,al
  mov     cx,0FFFFh
  repne   scasb
  not     cx
  dec     cx
  dec     di
  mov     ax,Len
  sub     ax,cx
  jbe     @@ExitPoint
  mov     cx,ax
  mov     al,C
  rep     stosb
@@ExitPoint:
  mov     byte ptr es:[di],0
  mov     ax,si
end;
{$ENDIF}

function edPadPrim(S : PAnsiChar; Len : Word) : PAnsiChar;
  {-return a string right-padded to length len with blanks}
begin
  Result := edPadChPrim(S, ' ', Len);
end;

{$IFDEF Win32}
function edScanToEnd(P : PAnsiChar; Len : Word) : Word; register;
  {-return position of end of para P}
asm
  push   edi            {save}
  push   ebx            {save}

  mov    edi,eax        {edi = P}
  mov    ebx,edi        {save edi}
  mov    ecx,edx        {ecx = Len}
  and    ecx,0FFFFh     {clear high word}
  mov    edx,ecx        {default for exit}
  mov    al, 0Ah
  cld
  jecxz  @@9
  repne  scasb
  jne    @@9
  mov    edx,edi
  sub    edx,ebx        {find difference}
@@9:
  mov    eax,edx

  pop    ebx            {restore}
  pop    edi            {restore}
end;
{$ELSE}
function edScanToEnd(P : PAnsiChar; Len : Word) : Word; assembler;
  {-return position of end of para P}
asm
  les di,P
  mov bx,di
  mov cx,Len
  mov dx,cx
  mov al,$0A
  cld
  jcxz @9
  repne scasb
  jne @9
  mov dx,di
  sub dx,bx
@9:
  mov ax,dx
end;
{$ENDIF}

{$IFDEF Win32}
function edStrStInsert(Dest, S : PAnsiChar; DLen, SLen, Pos : Word) : PAnsiChar; register;
  {-insert S into Dest}
asm
  push   esi            {save}
  push   edi            {save}
  push   ebx            {save}

  push   eax            {save Dest}
  push   edx            {save S}

  mov    bx,Pos         {ebx = Pos}
  and    ebx,0FFFFh     {clear high word}
  mov    esi,eax        {eax = Dest}
  mov    edi,eax        {eax = Dest}
  and    ecx,0FFFFh     {ecx = DLen}
  inc    ecx            {ecx = DLen+1}
  add    edi,ecx        {point di one past terminating null}
  mov    dx,SLen
  and    edx,0FFFFh     {clear high word}
  cmp    dx,0           {if str to insert has 0 len then exit}
  je     @@1
  std                   {backwards string ops}
  add    edi,edx
  dec    edi
  add    esi,ecx
  dec    esi            {point to end of source string}
  sub    ecx,ebx        {calculate number to do}
  jb     @@1            {exit if Pos greater than strlen + 1}
  test   edi,1
  jnz    @@0
  movsb
  dec    ecx

@@0:
  dec    esi
  dec    edi
  shr    ecx,1
  rep    movsw
  jnc    @@2
  inc    esi
  inc    edi
  movsb
  jmp    @@3
@@2:
  inc    edi
@@3:
  pop    esi            {esi = S}
  push   esi
  add    esi,edx
  dec    esi
  mov    ecx,edx
  rep    movsb
@@1:
  cld
  pop    eax            {remove S}
  pop    eax            {eax = Dest}

  pop    ebx            {restore}
  pop    edi            {restore}
  pop    esi            {restore}
end;
{$ELSE}
function edStrStInsert(Dest, S : PAnsiChar; DLen, SLen, Pos : Word) : PAnsiChar; assembler;
  {-insert S into Dest}
asm
  push      ds
  mov       bx,Pos
  lds       si,Dest
  les       di,Dest
  mov       cx,DLen     {cx = DLen+1}
  inc       cx
  add       di,cx       {point di to terminating null}
  mov       dx,SLen
  cmp       dx,0        {if str to insert has 0 len then exit}
  je        @1
  std                   {backwards string ops}
  add       di,dx
  dec       di
  add       si,cx
  dec       si          {point to end of source string}
  sub       cx,bx       {calculate number to do}
  jb        @1          {exit if Pos greater than strlen + 1}

  test      di,1
  jnz       @0
  movsb
  dec       cx
@0:
  dec       si
  dec       di
  shr       cx,1
  rep       movsw
  jnc       @2
  inc       si
  inc       di
  movsb
  jmp       @3
@2:
  inc       di
@3:
  lds       si,S
  add       si,dx
  dec       si
  mov       cx,dx
  rep       movsb
@1:
  cld
  pop       ds
  les       ax,Dest
  mov       dx,es
end;
{$ENDIF}

{$IFDEF Win32}
function edWhiteSpace(C : AnsiChar) : Boolean; register;
  {-return True if C is a white space character}
asm
  {Result := C in [' ', #9];}
  cmp    al,' '
  je     @@001
  cmp    al,09
  je     @@001
  xor    eax,eax
  jmp    @@002
@@001:
  mov    eax,01
@@002:
end;
{$ELSE}
function edWhiteSpace(C : AnsiChar) : Boolean; assembler;
  {-return True if C is a white space character}
asm
  mov al,1    {assume True}
  mov ah,C    {AH = C}
  cmp ah,' '  {is it a space?}
  je @1
  cmp ah,9    {is it a tab?}
  je @1
  xor al,al   {it's neither}
@1:
end;
{$ENDIF}

{$IFNDEF Win32}
initialization
  edWhichCPU := edGetCPUType;
{$ENDIF}

end.

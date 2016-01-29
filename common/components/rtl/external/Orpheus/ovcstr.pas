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
{*                   OVCSTR.PAS 2.17                     *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcStr;
  {-General string handling routines}

interface

uses
  OvcData;

type
  BTable = array[0..255] of Byte;
  {table used by the Boyer-Moore search routines}

function BinaryBPChar(Dest : PAnsiChar; B : Byte) : PAnsiChar;
  {-Return a binary PAnsiChar string for a byte}
function BinaryLPChar(Dest : PAnsiChar; L : LongInt) : PAnsiChar;
  {-Return the binary PAnsiChar string for a long integer}
function BinaryWPChar(Dest : PAnsiChar; W : Word) : PAnsiChar;
  {-Return the binary PAnsiChar string for a word}
procedure BMMakeTable(MatchString : PAnsiChar; var BT : BTable);
  {-Build a Boyer-Moore link table}
function BMSearch(var Buffer; BufLength : Cardinal; var BT : BTable;
                  MatchString : PAnsiChar ; var Pos : Cardinal) : Boolean;
  {-Use the Boyer-Moore search method to search a buffer for a string}
function BMSearchUC(var Buffer; BufLength : Cardinal; var BT : BTable;
                    MatchString : PAnsiChar ; var Pos : Cardinal) : Boolean;
  {-Use the Boyer-Moore search method to search a buffer for a string. This
    search is not case sensitive}
function CharStrPChar(Dest : PAnsiChar; C : AnsiChar; Len : Cardinal) : PAnsiChar;
  {-Return a PAnsiChar string filled with the specified character}
function DetabPChar(Dest : PAnsiChar; Src : PAnsiChar; TabSize : Byte) : PAnsiChar;
  {-Expand tabs in a PAnsiChar string to blanks}
function HexBPChar(Dest : PAnsiChar; B : Byte) : PAnsiChar;
  {-Return hex PAnsiChar string for byte}
function HexLPChar(Dest : PAnsiChar; L : LongInt) : PAnsiChar;
  {-Return the hex PAnsiChar string for a long integer}
function HexPtrPChar(Dest : PAnsiChar; P : Pointer) : PAnsiChar;
  {-Return hex PAnsiChar string for pointer}
function HexWPChar(Dest : PAnsiChar; W : Word) : PAnsiChar;
  {-Return the hex PAnsiChar string for a word}
function LoCaseChar(C : AnsiChar) : AnsiChar;
  {-Convert C to lower case}
function OctalLPChar(Dest : PAnsiChar; L : LongInt) : PAnsiChar;
  {-Return the octal PAnsiChar string for a long integer}
function StrChDeletePrim(P : PAnsiChar; Pos : Cardinal) : PAnsiChar;
  {-Primitive routine to delete a character from a PAnsiChar string}
function StrChInsertPrim(Dest : PAnsiChar; C : AnsiChar; Pos : Cardinal) : PAnsiChar;
  {-Primitive routine to insert a character into a PAnsiChar string}
function StrChPos(P : PAnsiChar; C : AnsiChar; var Pos : Cardinal) : Boolean;
  {-Sets Pos to location of C in P, return is True if found}
procedure StrInsertChars(Dest : PAnsiChar; Ch : AnsiChar; Pos, Count : Word);
  {-Insert count instances of Ch into S at Pos}
function StrStCopy(Dest, S : PAnsiChar; Pos, Count : Cardinal) : PAnsiChar;
  {-Copy characters at a specified position in a PAnsiChar string}
function StrStDeletePrim(P : PAnsiChar; Pos, Count : Cardinal) : PAnsiChar;
  {-Primitive routine to delete a sub-string from a PAnsiChar string}
function StrStInsert(Dest, S1, S2 : PAnsiChar; Pos : Cardinal) : PAnsiChar;
  {-Insert a PAnsiChar string into another at a specified position}
function StrStInsertPrim(Dest, S : PAnsiChar; Pos : Cardinal) : PAnsiChar;
  {-Insert a PAnsiChar string into another at a specified position. This
    primitive version modifies the source directly}
function StrStPos(P, S : PAnsiChar; var Pos : Cardinal) : Boolean;
  {-Sets Pos to position of the S in P, returns True if found}
function StrToLongPChar(S : PAnsiChar; var I : LongInt) : Boolean;
  {-Convert a PAnsiChar string to a long integer}
{$IFNDEF Win32}
function Trim(const S : string) : string;
  {-return a string with leading and trailing white space removed}
{$ENDIF}
procedure TrimAllSpacesPChar(P : PAnsiChar);
  {-Trim leading and trailing blanks from P}
function TrimEmbeddedZeros(const S : string) : string;
  {-Trim embedded zeros from a numeric string in exponential format}
procedure TrimEmbeddedZerosPChar(P : PAnsiChar);
  {-Trim embedded zeros from a numeric PAnsiChar string in exponential format}
function TrimTrailPrimPChar(S : PAnsiChar) : PAnsiChar;
  {-Return a PAnsiChar string with trailing white space removed}
function TrimTrailPChar(Dest, S : PAnsiChar) : PAnsiChar;
  {-Return a PAnsiChar string with trailing white space removed}
function TrimTrailingZeros(const S : string) : string;
  {-Trim trailing zeros from a numeric string. It is assumed that there is
    a decimal point prior to the zeros. Also strips leading spaces.}
procedure TrimTrailingZerosPChar(P : PAnsiChar);
  {-Trim trailing zeros from a numeric PAnsiChar string. It is assumed that
    there is a decimal point prior to the zeros. Also strips leading spaces.}
function UpCaseChar(C : AnsiChar) : AnsiChar;
  {-Convert a character to uppercase using the AnsiUpper API}


implementation

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  SysUtils;

const
  Digits : array[0..$F] of AnsiChar = '0123456789ABCDEF';


function BinaryBPChar(Dest : PAnsiChar; B : Byte) : PAnsiChar;
  {-Return binary string for byte}
var
  I : Word;
begin
  Result := Dest;
  for I := 7 downto 0 do begin
    Dest^ := Digits[Ord(B and (1 shl I) <> 0)]; {0 or 1}
    Inc(Dest);
  end;
  Dest^ := #0;
end;

function BinaryLPChar(Dest : PAnsiChar; L : LongInt) : PAnsiChar;
  {-Return binary string for LongInt}
var
  I : LongInt;
begin
  Result := Dest;
  for I := 31 downto 0 do begin
    Dest^ := Digits[Ord(L and LongInt(1 shl I) <> 0)]; {0 or 1}
    Inc(Dest);
  end;
  Dest^ := #0;
end;

function BinaryWPChar(Dest : PAnsiChar; W : Word) : PAnsiChar;
  {-Return binary string for word}
var
  I : Word;
begin
  Result := Dest;
  for I := 15 downto 0 do begin
    Dest^ := Digits[Ord(W and (1 shl I) <> 0)]; {0 or 1}
    Inc(Dest);
  end;
  Dest^ := #0;
end;

{$IFDEF WIN32}
procedure BMMakeTable(MatchString : PAnsiChar; var BT : BTable); register;
  {Build Boyer-Moore link table}
asm
  push  esi             { Save registers because they will be changed }
  push  edi
  push  ebx

  cld                   { Ensure forward string ops }
  mov   edi, eax        { Move EAX to ESI & EDI }
  mov   esi, eax
  xor   eax, eax        { Zero EAX }
  or    ecx, -1
  repne scasb           { Search for null terminator }
  not   ecx
  dec   ecx             { ECX is length of search string }
  cmp   ecx, 0FFh       { If ECX > 255, force to 255 }
  jbe   @@1
  mov   ecx, 0FFh

@@1:
  mov   ch, cl          { Duplicate CL in CH }
  mov   eax, ecx        { Fill each byte in EAX with length }
  shl   eax, 16
  mov   ax, cx
  mov   edi, edx        { Point to the table }
  mov   ecx, 64         { Fill table bytes with length }
  rep   stosd
  cmp   al, 1           { If length >= 1, we're done }
  jbe   @@MTDone
  mov   edi, edx        { Reset EDI to beginning of table }
  xor   ebx, ebx        { Zero EBX }
  mov   cl, al          { Restore CL to length of string }
  dec   ecx

@@MTNext:
  lodsb                 { Load table with positions of letters }
  mov   bl, al          { That exist in the search string }
  mov   [edi+ebx], cl
  loop  @@MTNext

@@MTDone:
  pop   ebx             { Restore registers }
  pop   edi
  pop   esi
end;
{$ELSE}
procedure BMMakeTable(MatchString : PAnsiChar; var BT : BTable); assembler;
  {Build Boyer-Moore link table}
asm
  MOV    DX,DS                    {Save DS in DX}
  CLD                             {Go forward}
  LES    DI,MatchString
  XOR    AL,AL
  MOV    CX,0FFFFh
  REPNE  SCASB
  NOT    CX
  DEC    CX
  MOV    AX,CX
  LDS    SI,MatchString           {DS:SI => MatchString}
  LES    DI,BT                    {ES:DI => BT}
  MOV    BX,DI                    {Save DI in BX}
  MOV    AH,AL                    {Copy it to AH}
  MOV    CX,128                   {Number of words in BT}
  REP    STOSW                    {Fill BT with length(MatchString)}
  CMP    AL,1                     {Is length(MatchString) <= 1?}
  JBE    @@MTDONE                 {Yes, we're done}

  MOV    DI,BX                    {Restore base of table from BX}
  MOV    BH,CH                    {BH = 0}
  MOV    CL,AL                    {CX = length(MatchString)}
  DEC    CX                       {CX = length(MatchString)-1}

@@MTnext:
  LODSB                           {AL = MatchString[i]}
  MOV    BL,AL                    {BL = MatchString[i]}
  MOV    ES:[BX+DI],CL            {BTable[char] = length(MatchString)-i}
  LOOP   @@MTnext                 {Repeat for all characters in MatchString}

@@MTDone:
  MOV    DS,DX                    {Restore DS from DX}
end;
{$ENDIF}

{$IFDEF Win32}
function BMSearch(var Buffer; BufLength : Cardinal; var BT : BTable;
  MatchString : PAnsiChar; var Pos : Cardinal) : Boolean; register;
var
  BufPtr : Pointer;
asm
  push  edi                 { Save registers since we will be changing }
  push  esi
  push  ebx
  push  edx

  mov   BufPtr, eax         { Copy Buffer to local variable and ESI }
  mov   esi, eax
  mov   ebx, ecx            { Copy BufLength to EBX }

  cld                       { Ensure forward string ops }
  xor   eax, eax            { Zero out EAX so we can search for null }
  mov   edi, MatchString    { Set EDI to beginning of MatchString }
  or    ecx, -1             { We will be counting down }
  repne scasb               { Find null }
  not   ecx                 { ECX = length of MatchString + null }
  dec   ecx                 { ECX = length of MatchString }
  mov   edx, ecx            { Copy length of MatchString to EDX }

  pop   ecx                 { Pop length of buffer into ECX }
  mov   edi, esi            { Set EDI to beginning of search buffer }
  mov   esi, MatchString    { Set ESI to beginning of MatchString }

  cmp   dl, 1               { Check to see if we have a trivial case }
  ja    @@BMSInit           { If Length(MatchString) > 1 do BM search }
  jb    @@BMSNotFound       { If Length(MatchString) = 0 we're done }

  mov   al,[esi]            { If Length(MatchString) = 1 do a REPNE SCASB }
  mov   ebx, edi
  repne scasb
  jne   @@BMSNotFound       { No match during REP SCASB }
  dec   edi                 { Found, calculate position }
  sub   edi, ebx
  mov   esi, Pos            { Set position in Pos }
  mov   [esi], edi
  mov   eax, 1              { Set result to True }
  jmp   @@BMSDone           { We're done }

@@BMSInit:
  dec   edx                 { Set up for BM Search }
  add   esi, edx            { Set ESI to end of MatchString }
  add   ecx, edi            { Set ECX to end of buffer }
  add   edi, edx            { Set EDI to first check point }
  mov   dh, [esi]           { Set DH to character we'll be looking for }
  dec   esi                 { Dec ESI in prep for BMSFound loop }
  std                       { Backward string ops }
  jmp   @@BMSComp           { Jump to first comparison }

@@BMSNext:
  mov   al, [ebx+eax]       { Look up skip distance from table }
  add   edi, eax            { Skip EDI ahead to next check point }

@@BMSComp:
  cmp   edi, ecx            { Have we reached end of buffer? }
  jae   @@BMSNotFound       { If so, we're done }
  mov   al, [edi]           { Move character from buffer into AL for comparison }
  cmp   dh, al              { Compare }
  jne   @@BMSNext           { If not equal, go to next checkpoint }

  push  ecx                 { Save ECX }
  dec   edi
  xor   ecx, ecx            { Zero ECX }
  mov   cl, dl              { Move Length(MatchString) to ECX }
  repe  cmpsb               { Compare MatchString to buffer }
  je    @@BMSFound          { If equal, string is found }

  mov   al, dl              { Move Length(MatchString) to AL }
  sub   al, cl              { Calculate offset that string didn't match }
  add   esi, eax            { Move ESI back to end of MatchString }
  add   edi, eax            { Move EDI to pre-string compare location }
  inc   edi
  mov   al, dh              { Move character back to AL }
  pop   ecx                 { Restore ECX }
  jmp   @@BMSNext           { Do another compare }

@@BMSFound:                 { EDI points to start of match }
  mov   edx, BufPtr         { Move pointer to buffer into EDX }
  sub   edi, edx            { Calculate position of match }
  mov   eax, edi
  inc   eax
  mov   esi, Pos
  mov   [esi], eax          { Set Pos to position of match }
  mov   eax, 1              { Set result to True }
  pop   ecx                 { Restore ESP }
  jmp   @@BMSDone

@@BMSNotFound:
  xor   eax, eax            { Set result to False }

@@BMSDone:
  cld                       { Restore direction flag }
  pop   ebx                 { Restore registers }
  pop   esi
  pop   edi
end;
{$ELSE}
function BMSearch(var Buffer; BufLength : Cardinal; var BT : BTable;
  MatchString : PAnsiChar; var Pos : Cardinal) : Boolean; assembler;
asm
  PUSH   DS                       {Will wipe out DS}
  PUSH   BP                       {Will use BP for temp storage later}
  XOR    AX,AX
  XOR    DX,DX
  CLD
  LES    DI,MatchString
  MOV    CX,0FFFFh
  REPNE  SCASB
  NOT    CX
  DEC    CX
  MOV    DL,CL

  MOV    CX,BufLength             {CX = Buffer size}
  LES    DI,Buffer                {ES:DI => Buffer}
  LDS    BX,BT                    {DS:BX => BTable}
  MOV    AX,DS                    {Keep BTable segment in AX a moment}
  LDS    SI,MatchString           {DS:SI => MatchString}
  MOV    BP,AX                    {Keep BTable segment in BP}

  XOR    AX,AX                    {AX = 0}
  CMP    DL,1                     {Check for trivial cases}
  JA     @@BMSinit                {Do Boyer-Moore if longer than one char}
  JB     @@BMSnotFound            {Fail for empty string}

  MOV    AL,[SI]                  {AL = one and only char to find}
  MOV    BX,DI                    {Save offset of Buffer}
  CLD                             {Forward}
  REPNE  SCASB                    {Scan Buffer for AL}
  JNE    @@BMSnotFound            {Char wasn't found}
  MOV    AX,DI                    {AX holds offset where char was found}
  DEC    AX                       {Back up one}
  SUB    AX,BX                    {Subtract base offset of Buffer}

  POP    BP                       {Get frame pointer back}
  LES    DI,Pos                   {Get address of Pos}
  MOV    ES:[DI],AX               {Store position offset in Pos}
  MOV    AX,1                     {Set result}
  JMP    @@BMSdone2               {We're done}
  {JMP    @@BMSdone}              {We're done}

@@BMSinit:
  DEC    DL                       {DX = length(MatchString)-1}
  ADD    SI,DX                    {DS:SI => MatchString[length(MatchString)-1]}
  ADD    CX,DI                    {CX = offset of last char in buffer}
  ADD    DI,DX                    {ES:DI => first position to search}
  MOV    DH,[SI]
  DEC    SI
  STD                             {Go backwards}
  JMP    @@BMScomp                {Skip link table first time}

@@BMSnext:
  PUSH   DS                       {Save DS a moment}
  MOV    DS,BP                    {Get segment of link table}
  XLAT                            {Get size of link at DS:[BX+AL]}
  POP    DS                       {Restore DS}
  ADD    DI,AX                    {Compute next place to search}

@@BMScomp:
  JC     @@BMSnotFound            {Done if overflowed 64K}
  CMP    DI,CX                    {At end of buffer?}
  JAE    @@BMSnotFound            {Done if so}
  MOV    AL,ES:[DI]               {AL = next char to try}
  CMP    DH,AL                    {Does it match the end of MatchString?}
  JNE    @@BMSnext                {If not same, go back and try again}

  PUSH   CX                       {Save end of buffer position}
  DEC    DI                       {Start comparing one character before}
  MOV    CL,DL                    {Compare length(MatchString)-1 characters}
  MOV    CH,AH                    {CH = 0}
  REPE   CMPSB                    {Compare backwards while matched}
  JE     @@BMSfound               {Matched!}

  MOV    AL,DL                    {Restore SI,DI,AL}
  SUB    AL,CL
  ADD    SI,AX
  ADD    DI,AX
  INC    DI
  MOV    AL,DH                    {Put matched char back in AL}
  POP    CX                       {Restore end of buffer}
  JMP    @@BMSnext                {Try again}

@@BMSfound:                       {DI points to start of match}
  INC    SP                       {End of buffer off stack}
  INC    SP
  POP    BP                       {Get frame pointer back}
  SUB    DI,WORD PTR Buffer       {Subtract buffer start address}
  MOV    AX,DI
  INC    AX                       {Return 0 if found in first byte}
  les    di,Pos
  mov    es:[di],ax               {Set Pos}
  mov    ax,1                     {Result = True}
  JMP    @@BMSDone2               {We're done}

@@BMSnotFound:
  {MOV    AX,0FFFFh}
  xor    ax, ax                   {Result = False}
@@BMSDone:
  POP    BP
@@BMSDone2:
  CLD
  POP    DS
end;
{$ENDIF}

{$IFNDEF Win32}
procedure UpcasePrim; near; assembler;
  {-call the Windows AnsiUpper function}
asm
  push    bx
  push    cx
  push    dx
  push    si
  push    di
  push    es
  push    ax
  xor     ah,ah
  xor     bx,bx
  push    bx
  push    ax
  call    AnsiUpper
  pop     bx
  mov     ah,bh
  pop     es
  pop     di
  pop     si
  pop     dx
  pop     cx
  pop     bx
end;
{$ENDIF}


{$IFDEF Win32}
function BMSearchUC(var Buffer; BufLength : Cardinal; var BT : BTable;
  MatchString : PAnsiChar; var Pos : Cardinal) : Boolean; register;
  {- Case-insensitive search of Buffer for MatchString. Return indicates
     success or failure.  Assumes MatchString is already raised to
     uppercase (PRIOR to creating the table) -}
var
  BufPtr : Pointer;
asm
  push  edi                 { Save registers since we will be changing }
  push  esi
  push  ebx
  push  edx

  mov   BufPtr, eax         { Copy Buffer to local variable and ESI }
  mov   esi, eax
  mov   ebx, ecx            { Copy BufLength to EBX }

  cld                       { Ensure forward string ops }
  xor   eax, eax            { Zero out EAX so we can search for null }
  mov   edi, MatchString    { Set EDI to beginning of MatchString }
  or    ecx, -1             { We will be counting down }
  repne scasb               { Find null }
  not   ecx                 { ECX = length of MatchString + null }
  dec   ecx                 { ECX = length of MatchString }
  mov   edx, ecx            { Copy length of MatchString to EDX }

  pop   ecx                 { Pop length of buffer into ECX }
  mov   edi, esi            { Set EDI to beginning of search buffer }
  mov   esi, MatchString    { Set ESI to beginning of MatchString }

  or    dl, dl              { Check to see if we have a trivial case }
  jz    @@BMSNotFound       { If Length(MatchString) = 0 we're done }

@@BMSInit:
  dec   edx                 { Set up for BM Search }
  add   esi, edx            { Set ESI to end of MatchString }
  add   ecx, edi            { Set ECX to end of buffer }
  add   edi, edx            { Set EDI to first check point }
  mov   dh, [esi]           { Set DH to character we'll be looking for }
  dec   esi                 { Dec ESI in prep for BMSFound loop }
  std                       { Backward string ops }
  jmp   @@BMSComp           { Jump to first comparison }

@@BMSNext:
  mov   al, [ebx+eax]       { Look up skip distance from table }
  add   edi, eax            { Skip EDI ahead to next check point }

@@BMSComp:
  cmp   edi, ecx            { Have we reached end of buffer? }
  jae   @@BMSNotFound       { If so, we're done }
  mov   al, [edi]           { Move character from buffer into AL for comparison }

  push  ebx                 { Save registers }
  push  ecx
  push  edx
  push  eax                 { Push Char onto stack for CharUpper }
  cld
  call  CharUpper
  std
  pop   edx                 { Restore registers }
  pop   ecx
  pop   ebx

  cmp   dh, al              { Compare }
  jne   @@BMSNext           { If not equal, go to next checkpoint }

  push  ecx                 { Save ECX }
  dec   edi
  xor   ecx, ecx            { Zero ECX }
  mov   cl, dl              { Move Length(MatchString) to ECX }
  jecxz @@BMSFound          { If ECX is zero, string is found }

@@StringComp:
  mov   al, [edi]           { Get char from buffer }
  dec   edi                 { Dec buffer index }

  push  ebx                 { Save registers }
  push  ecx
  push  edx
  push  eax                 { Push Char onto stack for CharUpper }
  cld
  call  CharUpper
  std
  pop   edx                 { Restore registers }
  pop   ecx
  pop   ebx

  mov   ah, al              { Move buffer char to AH }
  lodsb                     { Get MatchString char }
  cmp   ah, al              { Compare }
  loope @@StringComp        { OK?  Get next character }
  je    @@BMSFound          { Matched! }

  xor   ah, ah              { Zero AH }
  mov   al, dl              { Move Length(MatchString) to AL }
  sub   al, cl              { Calculate offset that string didn't match }
  add   esi, eax            { Move ESI back to end of MatchString }
  add   edi, eax            { Move EDI to pre-string compare location }
  inc   edi
  mov   al, dh              { Move character back to AL }
  pop   ecx                 { Restore ECX }
  jmp   @@BMSNext           { Do another compare }

@@BMSFound:                 { EDI points to start of match }
  mov   edx, BufPtr         { Move pointer to buffer into EDX }
  sub   edi, edx            { Calculate position of match }
  mov   eax, edi
  inc   eax
  mov   esi, Pos
  mov   [esi], eax          { Set Pos to position of match }
  mov   eax, 1              { Set result to True }
  pop   ecx                 { Restore ESP }
  jmp   @@BMSDone

@@BMSNotFound:
  xor   eax, eax            { Set result to False }

@@BMSDone:
  cld                       { Restore direction flag }
  pop   ebx                 { Restore registers }
  pop   esi
  pop   edi
end;
{$ELSE}
function BMSearchUC(var Buffer;
                    BufLength : Cardinal;
                    var BT : BTable;
                    MatchString : PAnsiChar;
                    var Pos : Cardinal) : Boolean; assembler;
  {-Case-insensitive search of Buffer for MatchString
    Return indicates success or failure
    Assumes MatchString is already raised to uppercase}
asm
  PUSH   DS                       {Will wipe out DS}
  PUSH   BP                       {Will use BP for temp storage later}
  XOR    AX,AX
  XOR    DX,DX
  CLD
  LES    DI,MatchString
  MOV    CX,0FFFFh
  REPNE  SCASB
  NOT    CX
  DEC    CX
  MOV    DL,CL

  MOV    CX,BufLength             {CX = Buffer size}
  LES    DI,Buffer                {ES:DI => Buffer}
  LDS    BX,BT                    {DS:BX => BTable}
  MOV    AX,DS                    {Keep BTable segment in AX a moment}
  LDS    SI,MatchString           {DS:SI => MatchString}
  MOV    BP,AX                    {Keep BTable segment in BP}

  XOR    AX,AX                    {AX = 0}
  OR     DL,DL                    {Check for trivial case}
  JZ     @@BMSUnotFound           {Fail for empty string}

@@BMSUinit:
  DEC    DL                       {DX = length(MatchString)-1}
  ADD    SI,DX                    {DS:SI => MatchString[length(MatchString)-1]}
  ADD    CX,DI                    {CX = offset of last char in buffer}
  ADD    DI,DX                    {ES:DI => first position to search}
  MOV    DH,[SI]                  {DH = MatchString[length(MatchString)]}
  DEC    SI
  STD                             {Go backwards}
  JMP    @@BMSUcomp               {Skip link table first time}

@@BMSUnext:
  PUSH   DS                       {Save DS a moment}
  MOV    DS,BP                    {Get segment of link table}
  XLAT                            {Get size of link at DS:[BX+AL]}
  POP    DS                       {Restore DS}
  ADD    DI,AX                    {Compute next place to search}

@@BMSUcomp:
  JC     @@BMSUnotFound           {Done if overflowed 64K}
  CMP    DI,CX                    {At end of buffer?}
  JAE    @@BMSUnotFound           {Done if so}
  MOV    AL,ES:[DI]               {AL = next char to try}
  cld
  CALL   UpCasePrim               {Raise it to uppercase}
  std
  CMP    DH,AL                    {Does it match the end of MatchString?}
  JNE    @@BMSUnext               {If not same, go back and try again}

  PUSH   CX                       {Save end of buffer position}
  DEC    DI                       {Start comparing one character before}
  MOV    CL,DL                    {Compare length(MatchString)-1 characters}
  MOV    CH,AH                    {CH = 0}
  JCXZ   @@BMSUfound              {Completely matched if CX = 0}

@@BMSUcomp2:
  LODSB                           {Next match character in AL}
  MOV    AH,ES:[DI]               {Next buffer character in AH}
  DEC    DI                       {Decrement buffer index}
  XCHG   AL,AH                    {Uppercase it}
  PUSH   BX
  MOV    BL,AH
  cld
  CALL   UpCasePrim
  std
  MOV    AH,BL
  POP    BX
  CMP    AH,AL                    {A match?}
  LOOPE  @@BMSUcomp2              {Loop while AH=AL and CX<>0}
  JE     @@BMSUfound              {Matched!}

  XOR    AH,AH                    {Restore SI,DI,AX}
  MOV    AL,DL
  SUB    AL,CL
  ADD    SI,AX
  ADD    DI,AX
  INC    DI
  MOV    AL,DH                    {Put matched char back in AL}
  POP    CX                       {Restore end of buffer}
  JMP    @@BMSUnext               {Try again}

@@BMSUfound:                      {DI points to start of match}
  INC    SP                       {End of buffer off stack}
  INC    SP
  POP    BP                       {Get frame pointer back}
  SUB    DI,WORD PTR Buffer       {Subtract buffer start address}
  MOV    AX,DI
  INC    AX                       {Return 0 if found in first byte}
  les    di,Pos
  mov    es:[di],ax               {Set Pos}
  mov    ax,1                     {Result = True}
  JMP    @@BMSUDone2              {We're done}

@@BMSUnotFound:
  {MOV    AX,0FFFFh}
  xor    ax, ax                   {Result = False}
@@BMSUDone:
  POP    BP
@@BMSUDone2:
  CLD
  POP    DS
end;
{$ENDIF}

{$IFDEF Win32}
function CharStrPChar(Dest : PAnsiChar; C : AnsiChar;
                      Len : Cardinal) : PAnsiChar; register;
asm
  push    edi            { Save EDI-about to change it }
  push    eax            { Save Dest pointer for return }
  mov     edi, eax       { Point EDI to Dest }

  mov     dh, dl         { Dup character 4 times }
  mov     eax, edx
  shl     eax, $10
  mov     ax, dx

  mov     edx, ecx       { Save Len }

  cld                    { Forward! }
  shr     ecx, 2         { Store dword char chunks first }
  rep     stosd
  mov     ecx, edx       { Store remaining characters }
  and     ecx, 3
  rep     stosb

  xor     al,al          { Add null terminator }
  stosb

  pop     eax            { Return Dest pointer }
  pop     edi            { Restore orig value of EDI }
end;
{$ELSE}
function CharStrPChar(Dest : PAnsiChar; C : AnsiChar;
                      Len : Cardinal) : PAnsiChar; assembler;
asm
  les     di,Dest
  mov     si,di
  mov     cx,Len
  jcxz    @@ExitPoint
  cld
  mov     al,C
  mov     ah,al
  test    di,1
  jz      @@WordAligned
  stosb
  dec     cx
@@WordAligned:
  shr     cx,1
  rep     stosw
  jnc     @@ExitPoint
  stosb
@@ExitPoint:
  xor     al,al
  stosb
  mov     dx,es
  mov     ax,si
end;
{$ENDIF}

{$IFDEF Win32}
function DetabPChar(Dest : PAnsiChar; Src : PAnsiChar;
                    TabSize : Byte) : PAnsiChar; register;
  { -Expand tabs in a string to blanks on spacing TabSize- }
asm
  push    eax           { Save Dest for return value }
  push    edi           { Save EDI, ESI and EBX, we'll be changing them }
  push    esi
  push    ebx

  mov     esi, edx      { ESI -> Src }
  mov     edi, eax      { EDI -> Dest }
  xor     ebx, ebx      { Get TabSize in EBX }
  add     bl, cl
  jz      @@Done        { Exit if TabSize is zero }

  cld                   { Forward! }
  xor     edx, edx      { Set output length to zero }

@@Next:
  lodsb                 { Get next input character }
  or      al, al        { Is it a null? }
  jz      @@Done        { Yes-all done }
  cmp     al, 09        { Is it a tab? }
  je      @@Tab         { Yes, compute next tab stop }
  stosb                 { No, store to output }
  inc     edx           { Increment output length }
  jmp     @@Next        { Next character }

@@Tab:
  push    edx           { Save output length }
  mov     eax, edx      { Get current output length in DX:AX }
  xor     edx, edx
  div     ebx           { Output length MOD TabSize in DX }
  mov     ecx, ebx      { Calc number of spaces to insert... }
  sub     ecx, edx      { = TabSize - Mod value }
  pop     edx
  add     edx, ecx      { Add count of spaces into current output length }

  mov     eax,$2020     { Blank in AH, Blank in AL }
  shr     ecx, 1        { Store blanks }
  rep     stosw
  adc     ecx, ecx
  rep     stosb
  jmp     @@Next        { Back for next input }

@@Done:
  xor     al,al         { Store final null terminator }
  stosb

  pop     ebx           { Restore caller's EBX, ESI and EDI }
  pop     esi
  pop     edi
  pop     eax           { Return Dest }
end;
{$ELSE}
function DetabPChar(Dest : PAnsiChar; Src : PAnsiChar;
                    TabSize : Byte) : PAnsiChar; assembler;
  {-Expand tabs in a string to blanks on spacing TabSize}
asm
  PUSH   DS
  CLD
  XOR    CX,CX                    {Default input length = 0}
  XOR    DX,DX                    {Default output length = 0 in DL}
  LDS    SI,Src                   {DS:SI => input string}
  LES    DI,Dest                  {ES:DI => output string}
  PUSH   ES                       {save ES:DI for function result}
  PUSH   DI
  XOR    BH,BH
  MOV    BL,TabSize               {BX has tab size}
  OR     BL,BL                    {Return zero length string if TabSize = 0}
  JZ     @@Done

  MOV    AH,09                    {Store tab in AH}

@@Next:
  LODSB                           {Next input character}
  OR     AL,AL                    {Is it a null?}
  JZ     @@Done
  CMP    AL,AH                    {Is it a tab?}
  JE     @@Tab                    {Yes, compute next tab stop}
  STOSB                           {No, store to output}
  INC    DX                       {Increment output length}
  JMP    @@Next                   {Next character}

@@Tab:
  PUSH   DX                       {Save output length}
  MOV    AX,DX                    {Current output length in DX:AX}
  XOR    DX,DX
  DIV    BX                       {OLen DIV TabSize in AL}

  mov    cx, bx                   {Calc number of spaces to insert...}
  sub    cx, dx                   { = TabSize - Mod value}
  pop    dx
  add    dx, cx                   {Add count of spaces into current output length}

  MOV    AX,$0920                 {Tab in AH, Blank in AL}
  REP    STOSB                    {Store blanks}
  JMP    @@Next                   {Back for next input}

@@Done:
  XOR    AL,AL
  STOSB
  POP    AX                       {function result = Dest}
  POP    DX
  POP    DS
end;
{$ENDIF}

function HexBPChar(Dest : PAnsiChar; B : Byte) : PAnsiChar;
  {-Return hex string for byte}
begin
  Result := Dest;
  Dest^ := Digits[B shr 4];
  Inc(Dest);
  Dest^ := Digits[B and $F];
  Inc(Dest);
  Dest^ := #0;
end;

function HexLPChar(Dest : PAnsiChar; L : LongInt) : PAnsiChar;
  {-Return the hex string for a long integer}
var
  T2 : Array[0..4] of AnsiChar;
begin
  Result := StrCat(HexWPChar(Dest, HIWORD(L)), HexWPChar(T2, LOWORD(L)));
end;

function HexPtrPChar(Dest : PAnsiChar; P : Pointer) : PAnsiChar;
  {-Return hex string for pointer}
var
  T2 : Array[0..4] of AnsiChar;
begin
  StrCat(HexWPChar(Dest, HIWORD(LongInt(P))), ':');
  Result := StrCat(Dest, HexWPChar(T2, LOWORD(LongInt(P))));
end;

function HexWPChar(Dest : PAnsiChar; W : Word) : PAnsiChar;
begin
  Result := Dest;
  Dest^ := Digits[Hi(W) shr 4];
  Inc(Dest);
  Dest^ := Digits[Hi(W) and $F];
  Inc(Dest);
  Dest^ := Digits[Lo(W) shr 4];
  Inc(Dest);
  Dest^ := Digits[Lo(W) and $F];
  Inc(Dest);
  Dest^ := #0;
end;

{$IFDEF Win32}
function LoCaseChar(C: AnsiChar) : AnsiChar; register;
asm
  mov   edx, eax
  xor   eax, eax
  mov   al, dl
  push  eax
  call  CharLower
end;
{$ELSE}
procedure LoCasePrim; near; assembler;
  {-Call the Windows AnsiLower function}
asm
  push    bx
  push    cx
  push    dx
  push    si
  push    di
  push    es
  push    ax
  xor     ah,ah
  xor     bx,bx
  push    bx
  push    ax
  call    AnsiLower
  pop     bx
  mov     ah,bh
  pop     es
  pop     di
  pop     si
  pop     dx
  pop     cx
  pop     bx
end;

function LoCaseChar(C : AnsiChar) : AnsiChar; assembler;
asm
  mov     al,C
  call    LocasePrim
end;
{$ENDIF}

function OctalLPChar(Dest : PAnsiChar; L : LongInt) : PAnsiChar;
  {-Return the octal PAnsiChar string for a long integer}
var
  I : LongInt;
begin
  Result := Dest;
  FillChar(Dest^, 12, '0');
  Dest[12] := #0;
  for I := 11 downto 0 do begin
    if L = 0 then
      Exit;

    Dest[I] := Digits[L and 7];
    L :=  L shr 3;
  end;
end;

{$IFDEF Win32}
function StrChDeletePrim(P : PAnsiChar; Pos : Cardinal) : PAnsiChar; register;
asm
  push   edi             { Save because we will be changing them }
  push   esi
  push   ebx

  mov    ebx, eax        { Save P to EDI & EBX }
  mov    edi, eax

  xor    al, al          { Zero }
  or     ecx, -1         { Set ECX to $FFFFFFFF }
  cld
  repne  scasb           { Find null terminator }
  not    ecx
  jecxz  @@ExitPoint
  sub    ecx, edx        { Calc number to move }
  jb     @@ExitPoint     { Exit if Pos > StrLen }

  mov    edi, ebx
  add    edi, edx        { Point to position to adjust }
  mov    esi, edi
  inc    esi             { Offset for source string }
  inc    ecx             { One more to include null terminator }
  rep    movsb           { Adjust the string }
@@ExitPoint:

  mov    eax, ebx
  pop    ebx             { restore registers }
  pop    esi
  pop    edi
end;
{$ELSE}
function StrChDeletePrim(P : PAnsiChar; Pos : Cardinal) : PAnsiChar; assembler;
asm
  push      ds
  mov       bx,Pos
  inc       bx
  les       di,P
  mov       dx,di
  xor       al,al
  mov       cx,0FFFFh
  cld
  repne     scasb                    {find null terminator}
  not       cx
  dec       cx                       {calc length}
  jcxz      @@ExitPoint
  sub       cx,bx                    {calc number to move}
  jb        @@ExitPoint              {exit if Pos > StrLen}
  mov       di,dx
  add       di,bx                    {point to position to adjust}
  mov       si,di
  dec       di
  mov       ax,es
  mov       ds,ax
  inc       cx                       {one more to include null terminator}
  rep       movsb                    {adjust the string}
@@ExitPoint:
  pop       ds
  les       ax,P
  mov       dx,es
end;
{$ENDIF}

{$IFDEF Win32}
function StrChInsertPrim(Dest : PAnsiChar; C : AnsiChar;
                         Pos : Cardinal) : PAnsiChar; register;
asm
  push   eax             {save because we will be changing them}
  push   edi
  push   esi
  push   ebx

  xor    ebx, ebx        {zero}
  mov    ebx, ecx        {move POS to ebx}

  mov    esi, eax        {copy Dest to ESI and EDI}
  mov    edi, eax

  xor    al, al          {zero}
  or     ecx, -1         {set ECX to $FFFFFFFF}
  cld                    {ensure forward}
  repne  scasb           {find null terminator}

  not    ecx             {calc length (including null)}
  std                    {backwards string ops}
  add    esi, ecx
  dec    esi             {point to end of source string}
  sub    ecx, ebx        {calculate number to do}
  jae    @@1             {append if Pos greater than strlen + 1}
  mov    ecx, 1

@@1:
  rep    movsb           {adjust tail of string}
  mov    eax, edx
  stosb                  {insert the new character}

@@ExitPoint:

  cld                    {be a good neighbor}
  pop    ebx             {restore registers}
  pop    esi
  pop    edi
  pop    eax
end;
{$ELSE}
function StrChInsertPrim(Dest : PAnsiChar; C : AnsiChar;
                         Pos : Cardinal) : PAnsiChar; assembler;
asm
  push      ds
  mov       bx,Pos
  lds       si,Dest
  les       di,Dest
  mov       dx,di
  xor       al,al
  mov       cx,0FFFFh
  cld
  repne     scasb                    {find null terminator}
  not       cx                       {calc length (including null)}
  std                                {backwards string ops}
  add       si,cx
  dec       si                       {point to end of source string}
  mov       dx,cx
  sub       cx,bx                    {calculate number to do}
  jae       @@1                      {exit if Pos greater than strlen + 1}
  mov       cx,1

@@1:
  rep       movsb                    {adjust tail of string}
  mov       al,C
  stosb                              {insert the new character}

@@ExitPoint:
  cld
  pop       ds
  les       ax,Dest
  mov       dx,es
end;
{$ENDIF}

{$IFDEF Win32}

function StrChPos(P : PAnsiChar; C : AnsiChar;
                  var Pos : Cardinal): Boolean; register;
  {-Sets Pos to position of character C within string P returns True if found}
asm
  push   esi               {save since we'll be changing}
  push   edi
  push   ebx
  mov    esi, ecx          {save Pos}

  cld                      {forward string ops}
  mov    edi, eax          {copy P to EDI}
  or     ecx, -1
  xor    eax, eax          {zero}
  mov    ebx, edi          {save EDI to EBX}
  repne  scasb             {search for NULL terminator}
  not    ecx
  dec    ecx               {ecx has len of string}

  test   ecx, ecx
  jz     @@NotFound        {if len of P = 0 then done}

  mov    edi, ebx          {reset EDI to beginning of string}
  mov    al, dl            {copy C to AL}
  repne  scasb             {find C in string}
  jne    @@NotFound

  mov    ecx, edi          {calculate position of C}
  sub    ecx, ebx
  dec    ecx               {ecx holds found position}

  mov    [esi], ecx        {store location}
  mov    eax, 1            {return true}
  jmp    @@ExitCode

@@NotFound:
  xor    eax, eax

@@ExitCode:

  pop    ebx               {restore registers}
  pop    edi
  pop    esi
end;

{$ELSE}

function StrChPos(P : PAnsiChar; C : AnsiChar;
                  var Pos : Cardinal): Boolean; assembler;
  {-Sets Pos to position of character C within string P returns True if found}
asm
  cld
  les       di,P
  xor       al,al
  mov       cx,0FFFFh
  mov       bx,di
  repne     scasb
  not       cx
  dec       cx                       {cx has len of P}
  jcxz      @@ExitCode
  mov       di,bx
  mov       al,C
  repne     scasb                    {find C in P}
  jne       @@ExitCode
  mov       cx,di
  sub       cx,bx
  dec       cx
  les       di,Pos
  mov       es:[di],cx
  mov       cx,1
@@ExitCode:
  mov       ax,cx
  {dec       ax}
end;
{$ENDIF}

procedure StrInsertChars(Dest : PAnsiChar; Ch : AnsiChar; Pos, Count : Word);
  {-Insert count instances of Ch into S at Pos}
var
  A : array[0..1024] of AnsiChar;
begin
  FillChar(A, Count, Ch);
  A[Count] := #0;
  StrStInsertPrim(Dest, A, Pos);
end;

function StrStCopy(Dest : PAnsiChar; S : PAnsiChar; Pos, Count : Cardinal) : PAnsiChar;
var
  Len : Cardinal;
begin
  Len := StrLen(S);
  if Pos < Len then begin
    if (Len-Pos) < Count then
      Count := Len-Pos;
    Move(S[Pos], Dest^, Count);
    Dest[Count] := #0;
  end else
    Dest[0] := #0;
  Result := Dest;
end;

{$IFDEF Win32}
function StrStDeletePrim(P : PAnsiChar; Pos, Count : Cardinal) : PAnsiChar; register;
asm
  push   eax             {save because we will be changing them}
  push   edi
  push   esi
  push   ebx

  mov    ebx, ecx        {move Count to BX}
  mov    esi, eax        {move P to ESI and EDI}
  mov    edi, eax

  xor    eax, eax        {null}
  or     ecx, -1
  cld
  repne  scasb           {find null terminator}
  not    ecx             {calc length}
  jecxz  @@ExitPoint

  sub    ecx, ebx        {subtract Count}
  sub    ecx, edx        {subtract Pos}
  jns    @@L1

  mov    edi,esi         {delete everything after Pos}
  add    edi,edx
  stosb
  jmp    @@ExitPoint

@@L1:
  mov    edi,esi
  add    edi,edx         {point to position to adjust}
  mov    esi,edi
  add    esi,ebx         {point past string to delete in src}
  inc    ecx             {one more to include null terminator}
  rep    movsb           {adjust the string}

@@ExitPoint:

  pop    ebx            {restore registers}
  pop    esi
  pop    edi
  pop    eax
end;
{$ELSE}
function StrStDeletePrim(P : PAnsiChar; Pos, Count : Cardinal) : PAnsiChar; assembler;
asm
  push      ds
  mov       bx,Pos
  inc       bx
  les       di,P
  mov       dx,di
  xor       al,al
  mov       cx,0FFFFh
  cld
  repne     scasb                    {find null terminator}
  not       cx
  dec       cx                       {calc length}
  inc       cx
  jcxz      @@ExitPoint
  sub       cx,Count                 {calc number to move}
  sub       cx,bx
  jns       @@L1                     {delete string in middle}

  mov       di,dx                    {delete everything after Pos}
  add       di,bx
  dec       di
  xor       al,al
  stosb
  jmp       @@ExitPoint
@@L1:
  mov       di,dx
  add       di,bx                    {point to position to adjust}
  dec       di
  mov       si,di
  add       si,Count                 {point past string to delete in src}
  mov       ax,es
  mov       ds,ax
  inc       cx                       {one more to include null terminator}
  rep       movsb                    {adjust the string}
@@ExitPoint:
  pop       ds
  les       ax,P
  mov       dx,es
end;
{$ENDIF}

function StrStInsert(Dest : PAnsiChar; S1, S2 : PAnsiChar; Pos : Cardinal) : PAnsiChar;
begin
  StrCopy(Dest, S1);
  Result := StrStInsertPrim(Dest, S2, Pos);
end;

{$IFDEF Win32}
function StrStInsertPrim(Dest : PAnsiChar; S : PAnsiChar;
                         Pos : Cardinal) : PAnsiChar; register;
asm
  push   eax             {save because we will be changing them}
  push   edi
  push   esi
  push   ebx

  mov    ebx, ecx        {move POS to ebx}
  mov    esi, eax        {copy Dest to ESI, S to EDI}
  mov    edi, edx

  xor    al, al          {zero}
  or     ecx, -1         {set ECX to $FFFFFFFF}
  cld                    {ensure forward}
  repne  scasb           {find null terminator}
  not    ecx             {calc length of source string (including null)}
  dec    ecx             {length without null}
  jecxz  @@ExitPoint     {if source length = 0, exit}
  push   ecx             {save length for later}

  mov    edi, esi        {reset EDI to Dest}
  or     ecx, -1
  repne  scasb           {find null}
  not    ecx             {length of dest string}

  cmp    ebx, ecx
  jb     @@1
  mov    ebx, ecx
  dec    ebx

@@1:
  std                    {backwards string ops}
  pop    eax             {restore length of S from stack}
  add    edi, eax        {set EDI S beyond end of Dest}
  dec    edi             {back up one for null}

  add    esi, ecx        {set ESI to end of Dest}
  dec    esi             {back up one for null}
  sub    ecx, ebx        {# of chars in Dest that are past Pos}
  rep    movsb           {adjust tail of string}

  mov    esi, edx        {set ESI to S}
  add    esi, eax        {set ESI to end of S}
  dec    esi             {back up one for null}
  mov    ecx, eax        {# of chars in S}
  rep    movsb           {copy S into Dest}

  cld                    {be a good neighbor}

@@ExitPoint:
  pop    ebx             {restore registers}
  pop    esi
  pop    edi
  pop    eax
end;
{$ELSE}
function StrStInsertPrim(Dest : PAnsiChar; S : PAnsiChar;
                         Pos : Cardinal) : PAnsiChar; assembler;
asm
  cld
  xor       al,al
  les       di,S
  mov       cx,0FFFFh
  repne     scasb
  not       cx
  mov       dx,cx
  dec       dx                       {dx = StrLen(S)}
  or        dx,dx                    {exit if StrLen(S) = 0}
  je        @@ExitPoint

  les       di,Dest
  mov       cx,0FFFFh
  repne     scasb
  not       cx                       {cx = StrLen(Dest)+1}

  mov       bx,Pos                   {bx = Pos}
  cmp       bx,cx                    {append if Pos > StrLen(Dest)}
  jb        @@1
  mov       bx,cx
  dec       bx                       {bx = StrLen(Dest)}

@@1:
  push      ds
  std                                {backwards string ops}
  add       di,dx
  dec       di                       {es:di -> past end of Dest+S}
  lds       si,Dest
  add       si,cx
  dec       si                       {ds:si -> past end of Dest}
  sub       cx,bx                    {# of chars in Dest that are past Pos}
  rep       movsb                    {adjust tail of string}
  lds       si,S
  add       si,dx
  dec       si                       {ds:si -> past end of S}
  mov       cx,dx                    {# of chars in S}
  rep       movsb                    {copy S into Dest}
  cld                                {return to forwards for safety}
  pop       ds

@@ExitPoint:
  les       ax,Dest
  mov       dx,es
end;
{$ENDIF}

{$IFDEF Win32}
function StrStPos(P, S : PAnsiChar; var Pos : Cardinal) : boolean; register;
asm
  push   edi                 { Save registers }
  push   esi
  push   ebx
  push   ecx

  mov    ebx, eax            { Move P to EBX }
  mov    edi, edx            { Move S to EDI & ESI }
  mov    esi, edx

  xor    eax, eax            { Zero EAX }
  or     ecx, -1             { Set ECX to FFFFFFFF }
  repne  scasb               { Find null at end of S }
  not    ecx

  mov    edx, ecx            { Save length to EDX }
  dec    edx                 { EDX has len of S }
  test   edx, edx
  jz     @@NotFound          { If len of S = 0 then done }

  mov    edi, ebx            { Set EDI to beginning of P }
  or     ecx, -1             { Set ECX to FFFFFFFF }
  repne  scasb               { Find null at end of P }
  not    ecx
  dec    ecx                 { ECX has len of P }
  jcxz   @@NotFound          { If len of P = 0 then done }

  dec    edx
  sub    ecx,edx             { Max chars to search }
  jbe    @@NotFound          { Done if len S > len P }
  lodsb                      { Get first char of S in AL }
  mov    edi,ebx             { Set EDI to beginning of EDI }

@@Next:
  repne  scasb               { Find first char of S in P }
  jne    @@NotFound          { If not found then done }
  test   edx, edx            { If length of S was one then found }
  jz     @@Found
  push   ecx
  push   edi
  push   esi
  mov    ecx,edx
  repe   cmpsb               { See if remaining chars in S match }
  pop    esi
  pop    edi
  pop    ecx
  je     @@Found             { Yes, so found }
  jmp    @@Next              { Look for next first char occurrence }

@@NotFound:
  pop    ecx
  xor    eax,eax             { Set return to False }
  jmp    @@ExitPoint

@@Found:
  dec    edi                 { Calc position of found string }
  mov    eax, edi
  sub    eax, ebx
  pop    ecx
  mov    [ecx], eax
  mov    eax, 1              { Set return to True }

@@ExitPoint:
  pop    ebx                 { Restore registers }
  pop    esi
  pop    edi
end;
{$ELSE}
function StrStPos(P, S : PAnsiChar; var Pos : Cardinal) : boolean; assembler;
asm
  push      ds
  cld
  les       di,S
  mov       si,di
  mov       bx,es
  mov       ds,bx
  xor       ax,ax
  mov       cx,0FFFFh
  mov       bx,di
  repne     scasb
  not       cx
  mov       dx,cx
  dec       dx                       {dx has len of S}
  test      dx,dx
  jz        @@ExitPoint              {if len of S = 0 then done}
  les       di,P
  mov       cx,0FFFFh
  mov       bx,di
  repne     scasb
  not       cx
  dec       cx                       {cx has len of P}
  jcxz      @@ExitPoint              {if len of P = 0 then done}
  dec       dx
  sub       cx,dx                    {max chars to search}
  jbe       @@ExitPoint              {done if len S > len P}
  lodsb                              {get first char of S in al}
  mov       di,bx
@@Next:
  repne     scasb                    {find first char of S in P}
  jne       @@NotFound               {if not found then done}
  test      dx,dx                    {if length of S was one then found}
  jz        @@Found
  push      cx
  push      di
  push      si
  mov       cx,dx
  repe      cmpsb                    {see if remaining chars in S match}
  pop       si
  pop       di
  pop       cx
  je        @@Found                  {yes, so found}
  jmp       @@Next                   {look for next first char occurance}
@@NotFound:
  xor       ax,ax                    {set return to false}
  jmp       @@ExitPoint
@@Found:
  dec       di
  mov       ax,di
  sub       ax,bx
  les       di, Pos
  mov       es:[di], ax
  mov       ax, 1                    {set return to true}
  {inc       ax}
@@ExitPoint:
  pop       ds
  {dec       ax}
end;
{$ENDIF}

function StrToLongPChar(S : PAnsiChar; var I : LongInt) : Boolean;
  {-Convert a string to a longint, returning true if successful}
var
  Code : Cardinal;
  P    : array[0..255] of AnsiChar;
begin
  if StrLen(S)+1 > SizeOf(P) then begin
    Result := False;
    I := -1;
    Exit;
  end;
  StrCopy(P, S);
  TrimTrailPrimPChar(P);
  if StrStPos(P, '0x', Code) then begin
    StrStDeletePrim(P, Code, 2);
    StrChInsertPrim(P, '$', Code);
  end;
  Val(P, I, Code);
  if Code <> 0 then begin
    I := Code - 1;
    Result := False;
  end else
    Result := True;
end;

{$IFNDEF Win32}
function Trim(const S : string) : string;
  {-return a string with leading and trailing white space removed}
var
  I    : Word;
  SLen : Byte absolute Result;
begin
  Result := S;
  while (SLen > 0) and (Result[SLen] <= ' ') do
    Dec(SLen);

  I := 1;
  while (I <= SLen) and (Result[I] <= ' ') do
    Inc(I);
  Dec(I);
  if I > 0 then
    Delete(Result, 1, I);
end;
{$ENDIF}

procedure TrimAllSpacesPChar(P : PAnsiChar);
  {-Trim leading and trailing blanks from P}
var
  I : Integer;
  PT : PAnsiChar;
begin
  I := StrLen(P);
  if I = 0 then
    Exit;

  {delete trailing spaces}
  Dec(I);
  while (I >= 0) and (P[I] = ' ') do begin
    P[I] := #0;
    Dec(I);
  end;

  {delete leading spaces}
  I := 0;
  PT := P;
  while PT^ = ' ' do begin
    Inc(I);
    Inc(PT);
  end;
  if I > 0 then
    StrStDeletePrim(P, 0, I);
end;

function TrimEmbeddedZeros(const S : string) : string;
  {-trim embedded zeros from a numeric string in exponential format}
var
  I, J : Integer;
begin
  I := Pos('E', S);
  if I = 0 then
    Exit;  {nothing to do}

  Result := S;

  {get rid of excess 0's after the decimal point}
  J := I;
  while (J > 1) and (Result[J-1] = '0') do
    Dec(J);
  if J <> I then begin
    System.Delete(Result, J, I-J);

    {get rid of the decimal point if that's all that's left}
    if (J > 1) and (Result[J-1] = '.') then
      System.Delete(Result, J-1, 1);
  end;

  {get rid of excess 0's in the exponent}
  I := Pos('E', Result);
  if I > 0 then begin
    Inc(I);
    J := I;
    while Result[J+1] = '0' do
      Inc(J);
    if J > I then
      System.Delete(Result, I+1, J-I);
  end;
end;

procedure TrimEmbeddedZerosPChar(P : PAnsiChar);
  {-Trim embedded zeros from a numeric string in exponential format}
var
  I, J : Cardinal;
begin
  if not StrChPos(P, 'E', I) then
    Exit;

  {get rid of excess 0's after the decimal point}
  J := I;
  while (J > 0) and (P[J-1] = '0') do
    Dec(J);
  if J <> I then begin
    StrStDeletePrim(P, J, I-J);

    {get rid of the decimal point if that's all that's left}
    if (J > 0) and (P[J-1] = '.') then
      StrStDeletePrim(P, J-1, 1);
  end;

  {Get rid of excess 0's in the exponent}
  if StrChPos(P, 'E', I) then begin
    Inc(I);
    J := I;
    while P[J+1] = '0' do
      Inc(J);
    if J > I then
      if P[J+1] = #0 then
        P[I-1] := #0
      else
        StrStDeletePrim(P, I+1, J-I);
  end;
end;

function TrimTrailingZeros(const S : string) : string;
  {-Trim trailing zeros from a numeric string. It is assumed that there is
    a decimal point prior to the zeros. Also strips leading spaces.}
var
  I : Integer;
begin
  if S = '' then
    Exit;

  Result := S;
  I := Length(Result);
  {delete trailing zeros}
  while (Result[I] = '0') and (I > 1) do
    Dec(I);
  {delete decimal point, if any}
  if Result[I] = '.' then
    Dec(I);
  Result := Trim(Copy(Result, 1, I));
end;

procedure TrimTrailingZerosPChar(P : PAnsiChar);
  {-Trim trailing zeros from a numeric string. It is assumed that there is
    a decimal point prior to the zeros. Also strips leading spaces.}
var
  PT : PAnsiChar;
begin
  PT := StrEnd(P);
  if Pointer(PT) = Pointer(P) then
    Exit;

  {back up to character prior to null}
  Dec(PT);

  {delete trailing zeros}
  while PT^ = '0' do begin
    PT^ := #0;
    Dec(PT);
  end;

  {delete decimal point, if any}
  if PT^ = '.' then
    PT^ := #0;

  TrimAllSpacesPChar(P);
end;

{$IFDEF Win32}
function TrimTrailPrimPChar(S : PAnsiChar) : PAnsiChar; register;
asm
   cld
   push   edi
   mov    edx, eax
   mov    edi, eax

   or     ecx, -1
   xor    al, al
   repne  scasb
   not    ecx
   dec    ecx
   jecxz  @@ExitPoint

   dec    edi

@@1:
   dec    edi
   cmp    byte ptr [edi],' '
   jbe    @@1
   mov    byte ptr [edi+1],00h
@@ExitPoint:
   mov    eax, edx
   pop    edi
end;
{$ELSE}
function TrimTrailPrimPChar(S : PAnsiChar) : PAnsiChar; assembler;
  {-Return a string with trailing white space removed}
asm
  les     di,S
  mov     dx,es
  mov     bx,di
  xor     al,al
  cld
  mov     cx,0FFFFh
  repne   scasb
  not     cx
  dec     cx
  jcxz    @@ExitPoint
  dec     di
  dec     di
@@L0:
  cmp     byte ptr es:[di],' '
  ja      @@AllDone
  dec     di
  loop    @@L0
@@AllDone:
  inc     di
  mov     byte ptr es:[di],0
@@ExitPoint:
  mov     ax,bx
end;
{$ENDIF}

function TrimTrailPChar(Dest, S : PAnsiChar) : PAnsiChar;
  {-Return a string with trailing white space removed}
begin
  StrCopy(Dest, S);
  Result := TrimTrailPrimPChar(Dest);
end;

{$IFDEF Win32}
function UpCaseChar(C : AnsiChar) : AnsiChar; register;
asm
  and   eax, 0FFh
  push  eax
  call  CharUpper
end;
{$ELSE}
function UpCaseChar(C : AnsiChar) : AnsiChar; assembler;
asm
  mov     al,C
  call    UpcasePrim
end;
{$ENDIF}

end.
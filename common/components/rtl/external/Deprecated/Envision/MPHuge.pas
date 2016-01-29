unit MPHuge;

{ huge pointer unit }

{$I MPC.INC}
{$R-} { range checking must be off here }

interface

{ HugeInc() and HugeOffset() add an offset to a far pointer. HugeDec decrements the pointer.
  The offset can be greater than 64K and the pointer's segment is properly updated. }

type
  PPtrArray = ^TPtrArray;
  TPtrArray = array[0..0] of pointer;

procedure HugeInc(var HugePtr: pointer; Amount: longint);
procedure HugeDec(var HugePtr: pointer; Amount: longint);
function HugeOffset(HugePtr: pointer; Amount: longint): pointer;
procedure HugeMove(Base: pointer; Dst, Src, Size: longint);
{$IFNDEF Win32}
{ Win32 defines these functions so they are needed only for 16 bit }
procedure ZeroMemory(Ptr: pointer; Length: longint);
procedure FillMemory(Ptr: pointer; Length: longint; Fill: byte);
{$ENDIF}

implementation

uses
  SysUtils, WinTypes;

{$IFDEF Win32}

procedure HugeInc(var HugePtr: pointer; Amount: longint);
begin
  HugePtr:= @PByteArray(HugePtr)[Amount];
end;

procedure HugeDec(var HugePtr: pointer; Amount: longint);
begin
  HugePtr:= @PByteArray(HugePtr)[-Amount];
end;

function  HugeOffset(HugePtr: pointer; Amount: longint): pointer;
begin
  Result:= @PByteArray(HugePtr)[Amount];
end;

procedure HugeMove(Base: pointer; Dst, Src, Size: longint);

var
  BasePtr: PPtrArray absolute Base;

begin
  Move(BasePtr^[Src], BasePtr^[Dst], Size * sizeof(pointer));
end;
{$ELSE}

procedure HugeShift; far; external 'KERNEL' index 113;

{ Pascal equivalent for HugeInc:
  Inc(Amount, LongRec(HugePtr).Lo);
  Inc(LongRec(HugePtr).Hi, SelectorInc * LongRec(Amount).Hi);
  LongRec(HugePtr).Lo:= LongRec(Amount).Lo;
}
procedure HugeInc(var HugePtr: pointer; Amount: longint); assembler;
asm
  mov ax, Amount.Word[0]    { dx:ax <- Amount }
  mov dx, Amount.Word[2]
  les bx, HugePtr           { es:bx <- reference to HugePtr }
  add ax, es:[bx]           { add offset part to ax }
  adc dx, 0                 { add with carry to dx }
  mov cx, OFFSET HugeShift
  shl dx, cl                { shift high word of amount for segment }
  add es:[bx + 2], dx       { increment the segment of HugePtr }
  mov es:[bx], ax
end;

procedure HugeDec(var HugePtr: pointer; Amount: longint); assembler;
asm
  les bx, HugePtr           { es:bx <- reference to HugePtr }
  mov ax, es:[bx]
  sub ax, Amount.Word[0]    { subtract offset part }
  mov dx, Amount.Word[2]
  adc dx, 0                 { subtract with carry to dx }
  mov cx, OFFSET HugeShift
  shl dx, cl                { shift high word of amount for segment }
  sub es:[bx + 2], dx
  mov es:[bx], ax
end;

{ Add an offset to a huge pointer and return the result. }
function HugeOffset(HugePtr: pointer; Amount: longint): Pointer; assembler;
asm
  mov ax, Amount.Word[0]    { dx:ax <- Amount }
  mov dx, Amount.Word[2]
  add ax, HugePtr.Word[0]   { add offset }
  adc dx, 0                 { add with carry with high word of Amount }
  mov cx, OFFSET HugeShift
  shl dx, cl                { shift high word of amount for segment }
  add dx, HugePtr.Word[2]   { increment the segment of HugePtr }
end;

procedure FastFill(Dest: pointer; Size: word; Fill: byte); assembler;
asm
  les di, Dest              { es:[di] <- destination }
  mov al, Fill              { al = value to fill with }
  mov cx, Size              { cx = number of bytes }
  mov ah, al                { ax = value of word }
  cld                       { string ops go forward }
  shr cx, 1                 { convert bytes to words }
  rep stosw                 { fill the words }
  adc cx, 0                 { any odd byte? }
  rep stosb                 { do it }
end;

procedure FillMemory(Ptr: pointer; Length: longint; Fill: byte);

var
  Bytes: word;

begin
  while Length > 0 do
  begin
    { determine the number of bytes remaining in the segment. }
    if Ofs(Ptr^) = 0 then
      Bytes:= $FFFF
    else
      Bytes:= longint($10000) - Ofs(Ptr^);
    if Bytes > Length then
      Bytes:= Length;
    FastFill(Ptr, Bytes, Fill);
    Dec(Length, Bytes);
    Ptr:= HugeOffset(Ptr, Bytes);
  end; {while}
end;

procedure ZeroMemory(Ptr: pointer; Length: longint);
begin
  FillMemory(Ptr, Length, 0);
end;

procedure cld; inline ($fc);	{ clear direction flag }
procedure std; inline ($fd);	{ set direction flag }

function ComputeDownMoveSize(SrcOffset, DstOffset: word): word;
begin
  { Determine the number of bytes remaining in the segment to copy }
  if SrcOffset > DstOffset then
    Result:= longint($10000) - SrcOffset
  else
    Result:= longint($10000) - DstOffset;
  { Copy the entire segment. }
  if Result = 0 then
    Result:= $FFFF;
end;

function ComputeUpMoveSize(SrcOffset, DstOffset: word): word;
begin
  if SrcOffset = $FFFF then
    { Copy as many words as are available in the destination. }
    Result:= DstOffset
  else if DstOffset = $FFFF then
    { Copy as many words as are available in the source. }
    Result:= SrcOffset
  else if SrcOffset > DstOffset then
    { Copy as many words as are available in the destination. }
    Result:= DstOffset + 1
  else
    { Copy as many words as are available in the source. }
    Result:= SrcOffset + 1;
end;

procedure FastMove(SrcPtr, DstPtr: pointer; Size: word); assembler;
asm
  mov ax, ds                { save ds in ax }
  les di, DstPtr            { es:di <- destination }
  lds si, SrcPtr            { ds:si <- source }
  mov cx, Size              { get number of bytes to move }
  cld                       { string ops go forward }
  shr cx, 1                 { convert bytes to words }
  rep movsw                 { move the words }
  adc cx, 0                 { any odd byte? }
  rep movsb                 { move it }
  mov ds, ax                { restore ds }
end;

procedure HugeMove(Base: pointer; Dst, Src, Size: longint);

var
  SrcPtr,
  DstPtr: pointer;
  Bytes: word;

begin
  SrcPtr:= HugeOffset(Base, Src * sizeof(pointer));
  DstPtr:= HugeOffset(Base, Dst * sizeof(pointer));
  { Convert longword size to bytes }
  Size:= Size * (sizeof(longint) div sizeof(word));
  if Src < Dst then
  begin
    { Start from the far end and work toward the front. }
    std;
    HugeInc(SrcPtr, (Size-1) * sizeof(Word));
    HugeInc(DstPtr, (Size-1) * sizeof(Word));
    while Size > 0 do
    begin
      { Compute how many bytes to move in the current segment. }
      Bytes:= ComputeUpMoveSize(word(SrcPtr), word(DstPtr));
      if Bytes > Size then
        Bytes:= Size;

      { Move the bytes. }
      FastMove(SrcPtr, DstPtr, Bytes);

      { Update the number of bytes left to move }
      Dec(Size, Bytes);
      { Update the pointers. }
      HugeDec(SrcPtr, Bytes);
      HugeDec(DstPtr, Bytes);
    end;
    cld;     { reset the direction flag }
  end
  else
  begin
    { Start from the beginning and work toward the end. }
    cld;
    while Size > 0 do
    begin
      { Compute how many bytes to move in the current segment. }
      Bytes:= ComputeDownMoveSize(word(SrcPtr), word(DstPtr));
      if Bytes > Size then
        Bytes:= Size;

      { Move the bytes. }
      FastMove(SrcPtr, DstPtr, Bytes);

      { Update the number of bytes left to move. }
      Dec(Size, Bytes);
      { Advance the pointers. }
      HugeInc(SrcPtr, Bytes);
      HugeInc(DstPtr, Bytes);
    end;
  end;
end;
{$ENDIF}

end.

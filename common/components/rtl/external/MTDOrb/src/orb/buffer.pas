// **********************************************************************
//
// Copyright (c) 2001 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
unit buffer;

interface

{$IFNDEF USELIB}

uses
  orbtypes,SysUtils,orb,orb_int,code_int;

type
  TBuffer = class(TInterfacedObject,IBuffer)
  private
    FBuffer : Pointer;
    FSize : _ulong;
    FReadOnly : Boolean;
    FRPosition : _ulong;
    FWPosition : _ulong;
    FRalignBase,FWAlignBase: _ulong;
    procedure incSize(Count: _ulong);
  protected
    function _buffer(): Pointer;
    function data(): PByteLargeArray;
    function _size: _ulong;
    function get(var o: Octet): Boolean; overload;
    function get(var buffer; size : _ulong): Boolean; overload;
    function get1(var buffer): Boolean;
    function get2(var buffer): Boolean;
    function get4(var buffer): Boolean;
    function get8(var buffer): Boolean;
    function get16(var buffer): Boolean;
    function getRAlignBase : _ulong;
    function getWAlignBase : _ulong;
    function length(): _ulong;
    procedure put(o : Octet); overload;
    procedure put(const buffer;size: _ulong); overload;
    procedure put16(const Buffer);
    procedure put8(const Buffer);
    procedure put4(const Buffer);
    procedure put2(const Buffer);
    procedure put1(const Buffer);
    procedure reset();
    procedure resize(size: _ulong);
    function RPosition : _ulong;
    function RseekFromBegin(pos: _ulong): Boolean;
    function RseekFromCurrent(pos: long): Boolean;
    procedure setRAlignBase(val: _ulong);
    procedure setWAlignBase(val : _ulong);
    function setRAlign(modulo: _ulong): boolean;
    procedure setWAlign(modulo : _ulong);
    function WseekFromBegin(pos: _ulong): Boolean;
    function WseekFromCurrent(pos: long): Boolean;
    function WPosition : _ulong;
    function WData(): PByteLargeArray;
    function peek(var buffer; size: _ulong): boolean;
  public
    constructor Create(Size: _ulong=0); overload;
    constructor Create(buf: IBuffer); overload;
    constructor Create(Buffer: Pointer); overload;
    destructor Destroy(); override;
  end;

implementation

constructor TBuffer.Create(Size: _ulong);
begin
  FSize := Size;
  FRPosition := 0;
  FWPosition := 0;
  if FSize > 0 then
    FBuffer := AllocMem(Size);
  FReadOnly := false;
end;

constructor TBuffer.Create(Buffer: Pointer);
begin
  FSize := $7FFFFFFF;
  FWPosition := $7FFFFFFF;
  FReadOnly := true;
  FRalignBase := 0;
  FWAlignBase := 0;
  FBuffer := Buffer;
end;

constructor TBuffer.Create(buf: IBuffer);
begin
  FSize := buf._size;
  if FSize > 0 then
    begin
      FBuffer := AllocMem(FSize);
      move(buf._buffer^,FBuffer^,FSize);
    end;
  FRPosition := buf.RPosition;
  FWPosition := buf.WPosition;
  FRalignBase := buf.getRAlignBase;
  FWAlignBase := buf.getWAlignBase;
  FReadOnly := false;
end;

destructor TBuffer.Destroy;
begin
  if not FReadOnly then FreeMem(FBuffer);
  inherited;
end;

function TBuffer.Data(): PByteLargeArray;
begin
  result := @(PByteLargeArray(FBuffer)^[FRPosition]);
end;

function TBuffer.WData(): PByteLargeArray;
begin
  result := @(PByteLargeArray(FBuffer)^[FWPosition]);
end;

function TBuffer.Length(): _ulong;
begin
  result := FWPosition - FRPosition;
end;

procedure TBuffer.put(o : Octet);
begin
  Assert(not FReadOnly);
  if FSize <= (FWPosition + 1) then
    incSize(1);
  Octet(PByteLargeArray(FBuffer)^[FWPosition]) := o;
  inc(FWPosition);
end;

procedure TBuffer.put(const Buffer;size: _ulong);
begin
  Assert(not FReadOnly);
  if FSize <= (FWPosition + size) then
    incSize(size);
  move(Buffer,Pointer((_ulong(FBuffer)+FWPosition))^,size);
  inc(FWPosition,size);
end;

function TBuffer.get(var o: Octet): Boolean;
begin
  result := false;
  if FWPosition > FRPosition then
    begin
      o := Octet(PByteLargeArray(FBuffer)^[FRPosition]);
      Inc(FRPosition);
      result := true;
    end;
end;

procedure TBuffer.incSize(Count: _ulong);
var
  newsize : _ulong;
begin
  if FSize < 10000 then
    newsize := FSize * 2
  else
    newsize := FSize + 10000;
  if newsize < FSize + count then
    newsize := FSize + count;
  if FBuffer = nil then
    FBuffer := AllocMem(newsize)
  else
    begin
      ReallocMem(FBuffer,newsize);
      FillChar(Pointer(_ulong(FBuffer)+FSize)^,newsize - FSize,0);
    end;
  FSize := newsize;
end;

function TBuffer.get2(var buffer): Boolean;
var
  aligned : _ulong;
begin
  result := false;
  aligned := ((FRPosition - FRalignBase + 1) and $FFFFFFFE) + FRalignBase;
  if FWPosition >= aligned+2 then
    begin
      FRPosition := aligned;
      move(Pointer((_ulong(FBuffer)+FRPosition))^,buffer,2);
      inc(FRPosition,2);
      result := true;
    end;
end;

function TBuffer.get8(var buffer): Boolean;
var
  aligned : _ulong;
begin
  result := false;
  aligned := ((FRPosition - FRalignBase + 7) and $FFFFFFF8) + FRalignBase;
  if FWPosition >= aligned+8 then
    begin
      FRPosition := aligned;
      move(Pointer((_ulong(FBuffer)+FRPosition))^,buffer,8);
      inc(FRPosition,8);
      result := true;
    end;
end;

function TBuffer.get16(var buffer): Boolean;
var
  aligned : _ulong;
begin
  result := false;
  aligned := ((FRPosition - FRalignBase + 7) and $FFFFFFF8) + FRalignBase;
  if FWPosition >= aligned+16 then
    begin
      FRPosition := aligned;
      move(Pointer((_ulong(FBuffer)+FRPosition))^,buffer,16);
      inc(FRPosition,16);
      result := true;
    end;
end;

function TBuffer.get4(var buffer): Boolean;
var
  aligned : _ulong;
begin
  result := false;
  aligned := ((FRPosition - FRalignBase + 3) and $FFFFFFFC) + FRalignBase;
  if FWPosition >= aligned+4 then
    begin
      FRPosition := aligned;
      move(Pointer((_ulong(FBuffer)+FRPosition))^,buffer,4);
      inc(FRPosition,4);
      result := true;
    end;
end;

function TBuffer.RseekFromBegin(pos: _ulong): Boolean;
begin
  result := FWPosition >= pos;
  if result then  FRPosition := pos;
end;

function TBuffer.WseekFromBegin(pos: _ulong): Boolean;
begin
  result := (pos >= FRPosition) and (pos <= FSize);
  if result then  FWPosition := pos;
end;

function TBuffer.RseekFromCurrent(pos: long): Boolean;
begin
  result := long(FWPosition) >= long(FRPosition) + pos;
  if result then  FRPosition := long(FRPosition) + pos;
end;

function TBuffer.WseekFromCurrent(pos: long): Boolean;
begin
  result := ((long(FWPosition) + pos) >= long(FRPosition)) and ((long(FWPosition) + pos) <= long(FSize));
  if result then  FWPosition := long(FWPosition) + pos;
end;

function TBuffer.getRAlignBase : _ulong;
begin
  result := FRAlignBase;
end;

procedure TBuffer.setRAlignBase(val: _ulong);
begin
  FRAlignBase := val;
end;

procedure TBuffer.setWAlignBase(val: _ulong);
begin
  FWAlignBase := val;
end;

function TBuffer.setRAlign(modulo: _ulong): boolean;
var
  r: _ulong;
begin
  Assert(modulo >= 1);
  Assert(FRPosition >= FRalignBase);
  r := (FRPosition - FRalignBase) + modulo - 1;
  r := r - r mod modulo;
  r := r + FRalignBase;
  if (r > FWPosition) then begin
    result := false;
    Exit;
  end;
  FRPosition := r;
  result := true;
end;

procedure TBuffer.setWAlign(modulo: _ulong);
var
  w: _ulong;
begin
  Assert(modulo >= 1);
  Assert(FWPosition >= FWAlignBase);
  w := (FWPosition - FWAlignBase) + modulo - 1;
  w := w - w mod modulo;
  w := w + FWAlignBase;
  incsize(w - FWPosition);
  while (FWPosition < w) do begin
    PByteLargeArray(FBuffer)^[FWPosition] := 0;
    Inc(FWPosition);
  end;
end;

function TBuffer.RPosition : _ulong;
begin
  result := FRPosition;
end;

function TBuffer.WPosition : _ulong;
begin
  result := FWPosition;
end;

procedure TBuffer.put2(const Buffer);
begin
  if FWPosition + 3 > FSize then
    incSize(3);
  if ((FWPosition - FWAlignBase) and $1) =  1 then
    inc(FWPosition);
  move(buffer,PByteLargeArray(FBuffer)^[FWPosition],2);
  inc(FWPosition,2);
end;

procedure TBuffer.put4(const Buffer);
begin
  if FWPosition + 7 > FSize then
    incSize(7);
  case ((FWPosition - FWAlignBase) and $3) of
    1: inc(FWPosition,3);
    2: inc(FWPosition,2);
    3: inc(FWPosition,1);
  end;
  move(buffer,PByteLargeArray(FBuffer)^[FWPosition],4);
  inc(FWPosition,4);
end;

procedure TBuffer.put8(const Buffer);
begin
  if FWPosition + 15 > FSize then
    incSize(15);
  case ((FWPosition - FWAlignBase) and $7) of
    1: inc(FWPosition,7);
    2: inc(FWPosition,6);
    3: inc(FWPosition,5);
    4: inc(FWPosition,4);
    5: inc(FWPosition,3);
    6: inc(FWPosition,2);
    7: inc(FWPosition,1);
  end;
  move(buffer,PByteLargeArray(FBuffer)^[FWPosition],8);
  inc(FWPosition,8);
end;

procedure TBuffer.put16(const Buffer);
begin
  if FWPosition + 23 > FSize then
    incSize(23);
  case ((FWPosition - FWAlignBase) and $7) of
    1: inc(FWPosition,7);
    2: inc(FWPosition,6);
    3: inc(FWPosition,5);
    4: inc(FWPosition,4);
    5: inc(FWPosition,3);
    6: inc(FWPosition,2);
    7: inc(FWPosition,1);
  end;
  move(buffer,PByteLargeArray(FBuffer)^[FWPosition],16);
  inc(FWPosition,16);
end;

function TBuffer.getWAlignBase : _ulong;
begin
  result := FWAlignBase;
end;

function TBuffer._buffer(): Pointer;
begin
  result := FBuffer;
end;

procedure TBuffer.resize(size: _ulong);
begin
  if FSize < (FWPosition+size) then
    incSize(FWPosition + size - FSize);
end;

procedure TBuffer.reset();
begin
  FWPosition := 0;
  FRPosition := 0;
end;

function TBuffer.get(var buffer; size: _ulong): Boolean;
begin
  result := false;
  if FWPosition >= FRPosition+size then
    begin
      move(PByteLargeArray(FBuffer)^[FRPosition],buffer,size);
      inc(FRPosition,size);
      result := true;
    end;
end;

function TBuffer.get1(var buffer): Boolean;
begin
  result := false;
  if FWPosition > FRPosition then
    begin
      Octet(buffer) := Octet(PByteLargeArray(FBuffer)^[FRPosition]);
      Inc(FRPosition);
      result := true;
    end;
end;

procedure TBuffer.put1(const Buffer);
begin
  if FSize <= FWPosition then
    incSize(1);
  Octet(PByteLargeArray(FBuffer)^[FWPosition]) := Octet(buffer);
  inc(FWPosition);
end;

function TBuffer._size: _ulong;
begin
  result := FSize;
end;

function TBuffer.peek(var buffer; size: _ulong): boolean;
begin
  result := (FWPosition - FRPosition) >= size;
  if result then
    move(PByteLargeArray(FBuffer)^[FRPosition],buffer,size);
end;

{$ELSE}
implementation
{$ENDIF}
end.

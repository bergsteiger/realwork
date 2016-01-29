{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


function CFByteOrderGetCurrent: CFByteOrder;
begin
  Result := CFByteOrderLittleEndian;
end;

function CFSwapInt16(arg: uint16_t): uint16_t;
begin
  Result := ((arg shl 8) and $FF00) or ((arg shr 8) and $FF);
end;

function CFSwapInt32(arg: uint32_t): uint32_t;
begin
  Result := ((arg and $FF) shl 24) or ((arg and $FF00) shl 8) or ((arg shr 8) and $FF00) or ((arg shr 24) and $FF);
end;

function CFSwapInt64(arg: uint64_t): uint64_t;
type
  TTemp = record
    case Integer of
     0: (sv: uint64_t);
     1: (ul: packed array[0..1] of uint32_t);
  end;
var
  Tmp: TTemp;
begin
  Tmp.sv := arg;
  Tmp.ul[0] := CFSwapInt32(Tmp.ul[1]);
  Tmp.ul[1] := CFSwapInt32(Tmp.ul[0]);
  Result := Tmp.sv;
end;

function CFSwapInt16BigToHost(arg: uint16_t): uint16_t;
begin
  Result := CFSwapInt16(arg);
end;

function CFSwapInt32BigToHost(arg: uint32_t): uint32_t;
begin
  Result := CFSwapInt32(arg);
end;

function CFSwapInt64BigToHost(arg: uint64_t): uint64_t;
begin
  Result := CFSwapInt64(arg);
end;

function CFSwapInt16HostToBig(arg: uint16_t): uint16_t;
begin
  Result := CFSwapInt16(arg);
end;

function CFSwapInt32HostToBig(arg: uint32_t): uint32_t;
begin
  Result := CFSwapInt32(arg);
end;

function CFSwapInt64HostToBig(arg: uint64_t): uint64_t;
begin
  Result := CFSwapInt64(arg);
end;

function CFSwapInt16LittleToHost(arg: uint16_t): uint16_t;
begin
  Result := arg;
end;

function CFSwapInt32LittleToHost(arg: uint32_t): uint32_t;
begin
  Result := arg;
end;

function CFSwapInt64LittleToHost(arg: uint64_t): uint64_t;
begin
  Result := arg;
end;

function CFSwapInt16HostToLittle(arg: uint16_t): uint16_t;
begin
  Result := arg;
end;

function CFSwapInt32HostToLittle(arg: uint32_t): uint32_t;
begin
  Result := arg;
end;

function CFSwapInt64HostToLittle(arg: uint64_t): uint64_t;
begin
  Result := arg;
end;

function CFConvertFloat32HostToSwapped(arg: Float32): CFSwappedFloat32;
type
  TCFSwap = record
    case Integer of
     0: (v: Float32);
     1: (sv: CFSwappedFloat32);
  end;
var
  CFSwap: TCFSwap;
begin
  CFSWap.v := arg;
  CFSwap.sv.v := CFSwapInt32(CFSWap.sv.v);
  Result := CFSwap.sv;
end;

function CFConvertFloat32SwappedToHost(arg: CFSwappedFloat32): Float32;
type
  TCFSwap = record
    case Integer of
     0: (v: Float32);
     1: (sv: CFSwappedFloat32);
  end;
var
  CFSwap: TCFSwap;
begin
  CFSwap.sv := arg;
  CFSwap.sv.v := CFSwapInt32(CFSwap.sv.v);
  Result := CFSwap.v;
end;

function CFConvertFloat64HostToSwapped(arg: Float64): CFSwappedFloat64;
type
  TCFSwap = record
    case Integer of
     0: (v: Float64);
     1: (sv: CFSwappedFloat64);
  end;
var
  CFSwap: TCFSwap;
begin
  CFSwap.v := arg;
  CFSwap.sv.v := CFSwapInt64(CFSwap.sv.v);
  Result := CFSWap.sv;
end;

function CFConvertFloat64SwappedToHost(arg: CFSwappedFloat64): Float64;
type
  TCFSwap = record
    case Integer of
     0: (v: Float64);
     1: (sv: CFSwappedFloat64);
  end;
var
  CFSwap: TCFSwap;
begin
  CFSwap.sv := arg;
  CFSWap.sv.v := CFSwapInt64(CFSWap.sv.v);
  Result := CFSWap.v;
end;

function CFConvertFloatHostToSwapped(arg: Single): CFSwappedFloat32;
type
  TCFSwap = record
    case Integer of
     0: (v: Single);
     1: (sv: CFSwappedFloat32);
  end;
var
  CFSwap: TCFSwap;
begin
  CFSWap.v := arg;
  CFSWap.sv.v := CFSwapInt32(CFSWap.sv.v);
  Result := CFSWap.sv;
end;

function CFConvertFloatSwappedToHost(arg: CFSwappedFloat32): Single;
type
  TCFSwap = record
    case Integer of
     0: (v: Single);
     1: (sv: CFSwappedFloat32);
  end;
var
  CFSwap: TCFSwap;
begin
  CFSwap.sv := arg;
  CFSWap.sv.v := CFSwapInt32(CFSWap.sv.v);
  Result := CFSWap.v;
end;

function CFConvertDoubleHostToSwapped(arg: Double): CFSwappedFloat64;
type
  TCFSwap = record
    case Integer of
     0: (v: Double);
     1: (sv: CFSwappedFloat64);
  end;
var
  CFSwap: TCFSwap;
begin
  CFSWap.v := arg;
  CFSWap.sv.v := CFSwapInt32(CFSWap.sv.v);
  Result := CFSWap.sv;
end;

function CFConvertDoubleSwappedToHost(arg: CFSwappedFloat64): Double;
type
  TCFSwap = record
    case Integer of
     0: (v: Double);
     1: (sv: CFSwappedFloat64);
  end;
var
  CFSwap: TCFSwap;
begin
  CFSwap.sv := arg;
  CFSWap.sv.v := CFSwapInt32(CFSWap.sv.v);
  Result := CFSWap.v;
end;


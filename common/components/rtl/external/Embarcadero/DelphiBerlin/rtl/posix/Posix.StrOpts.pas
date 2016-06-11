{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.StrOpts platform;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses
  Posix.Base, Posix.SysTypes;

{$IFDEF MACOS}
{$I osx/StrOptsTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/StrOptsTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I android/StrOptsTypes.inc}
{$ENDIF}

{$I StrOptsAPI.inc}

implementation

{$IFDEF MACOS}
function IOCPARM_LEN(x: UInt32): UInt32;
begin
  Result := (x shr 16) and IOCPARM_MASK;
end;

function IOCBASECMD(x: UInt32): UInt32;
begin
  Result := x and not(IOCPARM_MASK shl 16);
end;

function IOCGROUP(x: UInt32): UInt32;
begin
  Result := (x shr 8) and $FF;
end;

function _IOC(inout, group, num, len: UInt32): UInt32;
begin
  Result := inout or
            ((len and IOCPARM_MASK) shl 16) or
            (group shl 8) or num;
end;

function _IO(g, n: UInt32): UInt32;
begin
  Result := _IOC(IOC_VOID, g, n, 0);
end;

function __IOR(g, n, t: UInt32): UInt32;
begin
  Result := _IOC(IOC_OUT, g, n, t);  { t is SizeOf(type) instead type}
end;

function __IOW(g, n, t: UInt32): UInt32;
begin
  Result := _IOC(IOC_IN, g, n, t);  { t is SizeOf(type) instead type}
end;

function __IOWR(g, n, t: UInt32): UInt32;
begin
  Result := _IOC(IOC_INOUT, g, n, t);  { t is SizeOf(type) instead type}
end;
{$ENDIF MACOS}

{$IFDEF ANDROID}
function _IOC(dir, atype, nr, size: UInt32): UInt32;
begin
  Result := (dir shl _IOC_DIRSHIFT) or
            (atype shl _IOC_TYPESHIFT) or
            (nr shl _IOC_NRSHIFT) or
            (size shl _IOC_SIZESHIFT);
end;

function _IO(atype, nr: UInt32): UInt32;
begin
  Result := _IOC(_IOC_NONE, atype, nr, 0);
end;

function _IOR(atype, nr, size: UInt32): UInt32;
begin
  Result := _IOC(_IOC_READ, atype, nr, sizeof(size));
end;

function _IOW(atype, nr, size: UInt32): UInt32;
begin
  Result := _IOC(_IOC_WRITE, atype, nr, sizeof(size));
end;

function _IOWR(atype, nr, size: UInt32): UInt32;
begin
  Result := _IOC(_IOC_READ or _IOC_WRITE, atype, nr, sizeof(size));
end;

function _IOR_BAD(atype, nr, size: UInt32): UInt32;
begin
  Result := _IOC(_IOC_READ, atype, nr, sizeof(size));
end;

function _IOW_BAD(atype, nr, size: UInt32): UInt32;
begin
  Result := _IOC(_IOC_WRITE, atype, nr, sizeof(size));
end;

function _IOWR_BAD(atype, nr, size: UInt32): UInt32;
begin
  Result := _IOC(_IOC_READ or _IOC_WRITE, atype, nr, sizeof(size));
end;

function _IOC_DIR(nr: UInt32): UInt32;
begin
  Result := ((nr shr _IOC_DIRSHIFT) and _IOC_DIRMASK);
end;

function _IOC_TYPE(nr: UInt32): UInt32;
begin
  Result := ((nr shr _IOC_TYPESHIFT) and _IOC_TYPEMASK);
end;

function _IOC_NR(nr: UInt32): UInt32;
begin
  Result := ((nr  shr _IOC_NRSHIFT) and _IOC_NRMASK);
end;

function _IOC_SIZE(nr: UInt32): UInt32;
begin
  Result := ((nr shr _IOC_SIZESHIFT) and _IOC_SIZEMASK);
end;
{$ENDIF ANDROID}

end.

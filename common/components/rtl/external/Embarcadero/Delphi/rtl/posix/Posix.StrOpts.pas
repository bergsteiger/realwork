{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.StrOpts platform;

{$WEAKPACKAGEUNIT}

interface

uses
  Posix.Base, Posix.SysTypes;

{$IFDEF MACOS}
{$I osx/StrOptsTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/StrOptsTypes.inc}
{$ENDIF LINUX}

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

end.

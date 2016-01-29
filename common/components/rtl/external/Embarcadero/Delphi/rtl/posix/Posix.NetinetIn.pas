{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.NetinetIn;

{$WEAKPACKAGEUNIT}

interface

uses Posix.Base, Posix.SysSocket;

{$HPPEMIT '#include <netinet/in.h>' }

{$IFDEF MACOS}
{$I osx/NetinetInTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/NetinetInTypes.inc}
{$ENDIF LINUX}

{$I NetinetInAPI.inc}

const
  IN_CLASSA_NET         = $ff000000 platform;
  {$EXTERNALSYM IN_CLASSA_NET}
  IN_CLASSA_NSHIFT      = 24 platform;
  {$EXTERNALSYM IN_CLASSA_NSHIFT}
  IN_CLASSA_HOST        = ($ffffffff and not IN_CLASSA_NET) platform;
  {$EXTERNALSYM IN_CLASSA_HOST}
  IN_CLASSA_MAX         = 128 platform;
  {$EXTERNALSYM IN_CLASSA_MAX}
  IN_CLASSB_NET         = $ffff0000 platform;
  {$EXTERNALSYM IN_CLASSB_NET}
  IN_CLASSB_NSHIFT      = 16 platform;
  {$EXTERNALSYM IN_CLASSB_NSHIFT}
  IN_CLASSB_HOST        = ($ffffffff and not IN_CLASSB_NET) platform;
  {$EXTERNALSYM IN_CLASSB_HOST}
  IN_CLASSB_MAX         = 65536 platform;
  {$EXTERNALSYM IN_CLASSB_MAX}
  IN_CLASSC_NET         = $ffffff00 platform;
  {$EXTERNALSYM IN_CLASSC_NET}
  IN_CLASSC_NSHIFT      = 8 platform;
  {$EXTERNALSYM IN_CLASSC_NSHIFT}
  IN_CLASSC_HOST        = ($ffffffff and not IN_CLASSC_NET) platform;
  {$EXTERNALSYM IN_CLASSC_HOST}

function IN_CLASSA(a: in_addr_t): Boolean; platform;
{$EXTERNALSYM IN_CLASSA}
function IN_CLASSB(a: in_addr_t): Boolean; platform;
{$EXTERNALSYM IN_CLASSB}
function IN_CLASSC(a: in_addr_t): Boolean; platform
{$EXTERNALSYM IN_CLASSC}
function IN_CLASSD(a: in_addr_t): Boolean; platform;
{$EXTERNALSYM IN_CLASSD}
function IN_MULTICAST(a: in_addr_t): Boolean; platform;
{$EXTERNALSYM IN_MULTICAST}
function IN_EXPERIMENTAL(a: in_addr_t): Boolean; platform;
{$EXTERNALSYM IN_EXPERIMENTAL}
function IN_BADCLASS(a: in_addr_t): Boolean; platform;
{$EXTERNALSYM IN_BADCLASS}

function IN6_ARE_ADDR_EQUAL(const a, b: in6_addr): Boolean; platform;
{$EXTERNALSYM IN6_ARE_ADDR_EQUAL}

function IN6_IS_ADDR_UNSPECIFIED(const addr: in6_addr): Boolean;
{$EXTERNALSYM IN6_IS_ADDR_UNSPECIFIED}
function IN6_IS_ADDR_LOOPBACK(const addr: in6_addr): Boolean;
{$EXTERNALSYM IN6_IS_ADDR_LOOPBACK}
function IN6_IS_ADDR_MULTICAST(const addr: in6_addr): Boolean;
{$EXTERNALSYM IN6_IS_ADDR_MULTICAST}
function IN6_IS_ADDR_LINKLOCAL(const addr: in6_addr): Boolean;
{$EXTERNALSYM IN6_IS_ADDR_LINKLOCAL}
function IN6_IS_ADDR_SITELOCAL(const addr: in6_addr): Boolean;
{$EXTERNALSYM IN6_IS_ADDR_SITELOCAL}
function IN6_IS_ADDR_V4MAPPED(const addr: in6_addr): Boolean;
{$EXTERNALSYM IN6_IS_ADDR_V4MAPPED}
function IN6_IS_ADDR_V4COMPAT(const addr: in6_addr): Boolean;
{$EXTERNALSYM IN6_IS_ADDR_V4COMPAT}
function IN6_IS_ADDR_MC_NODELOCAL(const addr: in6_addr): Boolean;
{$EXTERNALSYM IN6_IS_ADDR_MC_NODELOCAL}
function IN6_IS_ADDR_MC_LINKLOCAL(const addr: in6_addr): Boolean;
{$EXTERNALSYM IN6_IS_ADDR_MC_LINKLOCAL}
function IN6_IS_ADDR_MC_SITELOCAL(const addr: in6_addr): Boolean;
{$EXTERNALSYM IN6_IS_ADDR_MC_SITELOCAL}
function IN6_IS_ADDR_MC_ORGLOCAL(const addr: in6_addr): Boolean;
{$EXTERNALSYM IN6_IS_ADDR_MC_ORGLOCAL}
function IN6_IS_ADDR_MC_GLOBAL(const addr: in6_addr): Boolean;
{$EXTERNALSYM IN6_IS_ADDR_MC_GLOBAL}


implementation

uses Posix.ArpaInet;

type
  PUInt32 = ^UInt32;

function IN_CLASSA(a: in_addr_t): Boolean;
begin
  Result := ((a and $80000000) = 0);
end;

function IN_CLASSB(a: in_addr_t): Boolean;
begin
  Result := ((a and $c0000000) = $80000000);
end;

function IN_CLASSC(a: in_addr_t): Boolean;
begin
  Result := ((a and $e0000000) = $c0000000);
end;

function IN_CLASSD(a: in_addr_t): Boolean;
begin
  Result := ((a and $f0000000) = $e0000000);
end;

function IN_MULTICAST(a: in_addr_t): Boolean;
begin
  Result := IN_CLASSD(a);
end;

function IN_EXPERIMENTAL(a: in_addr_t): Boolean;
begin
  Result := ((a and $e0000000) = $e0000000);
end;

function IN_BADCLASS(a: in_addr_t): Boolean;
begin
  Result := ((a and $f0000000) = $f0000000);
end;

function IN6_ARE_ADDR_EQUAL(const a, b: in6_addr): Boolean;
begin
  Result := (a.s6_addr32[0] = b.s6_addr32[0]) and
            (a.s6_addr32[1] = b.s6_addr32[1]) and
            (a.s6_addr32[2] = b.s6_addr32[2]) and
            (a.s6_addr32[3] = b.s6_addr32[3]);
end;

function IN6_IS_ADDR_UNSPECIFIED(const addr: in6_addr): Boolean;
begin
  Result := (PUInt32(@addr.s6_addr[0])^ = 0) and
            (PUInt32(@addr.s6_addr[4])^ = 0) and
            (PUInt32(@addr.s6_addr[8])^ = 0) and
            (PUInt32(@addr.s6_addr[12])^ = 0);
end;

function IN6_IS_ADDR_LOOPBACK(const addr: in6_addr): Boolean;
begin
  Result := (PUInt32(@addr.s6_addr[0])^ = 0) and
            (PUInt32(@addr.s6_addr[4])^ = 0) and
            (PUInt32(@addr.s6_addr[8])^ = 0) and
            (PUInt32(@addr.s6_addr[12])^ = ntohl(1));
end;

function IN6_IS_ADDR_MULTICAST(const addr: in6_addr): Boolean;
begin
  Result := addr.s6_addr[0] = $FF;
end;

function IN6_IS_ADDR_LINKLOCAL(const addr: in6_addr): Boolean;
begin
  Result := (addr.s6_addr[0] = $FE) and
            ((addr.s6_addr[1] and $C0) = $80);
end;

function IN6_IS_ADDR_SITELOCAL(const addr: in6_addr): Boolean;
begin
  Result := (addr.s6_addr[0] = $FE) and
            ((addr.s6_addr[1] and $C0) = $C0);
end;

function IN6_IS_ADDR_V4MAPPED(const addr: in6_addr): Boolean;
begin
  Result := (PUInt32(@addr.s6_addr[0])^ = 0) and
            (PUInt32(@addr.s6_addr[4])^ = 0) and
            (PUInt32(@addr.s6_addr[8])^ = ntohl($0000FFFF));
end;

function IN6_IS_ADDR_V4COMPAT(const addr: in6_addr): Boolean;
begin
  Result := (PUInt32(@addr.s6_addr[0])^ = 0) and
            (PUInt32(@addr.s6_addr[4])^ = 0) and
            (PUInt32(@addr.s6_addr[8])^ = 0) and
            (PUInt32(@addr.s6_addr[12])^ <> ntohl(0)) and
            (PUInt32(@addr.s6_addr[12])^ <> ntohl(1));
end;

const
  IPV6_ADDR_SCOPE_NODELOCAL = $01;
  IPV6_ADDR_SCOPE_LINKLOCAL = $02;
  IPV6_ADDR_SCOPE_SITELOCAL = $05;
  IPV6_ADDR_SCOPE_ORGLOCAL  = $08;
  IPV6_ADDR_SCOPE_GLOBAL    = $0E;

function IPV6_ADDR_MC_SCOPE(const addr: in6_addr): Byte;
begin
  Result := addr.s6_addr[1] and $0F;
end;

function IN6_IS_ADDR_MC_NODELOCAL(const addr: in6_addr): Boolean;
begin
  Result := IN6_IS_ADDR_MULTICAST(addr) and 
    (IPV6_ADDR_MC_SCOPE(addr) = IPV6_ADDR_SCOPE_NODELOCAL);
end;

function IN6_IS_ADDR_MC_LINKLOCAL(const addr: in6_addr): Boolean;
begin
  Result := IN6_IS_ADDR_MULTICAST(addr) and 
    (IPV6_ADDR_MC_SCOPE(addr) = IPV6_ADDR_SCOPE_LINKLOCAL);
end;

function IN6_IS_ADDR_MC_SITELOCAL(const addr: in6_addr): Boolean;
begin
  Result := IN6_IS_ADDR_MULTICAST(addr) and 
    (IPV6_ADDR_MC_SCOPE(addr) = IPV6_ADDR_SCOPE_SITELOCAL);
end;

function IN6_IS_ADDR_MC_ORGLOCAL(const addr: in6_addr): Boolean;
begin
  Result := IN6_IS_ADDR_MULTICAST(addr) and 
    (IPV6_ADDR_MC_SCOPE(addr) = IPV6_ADDR_SCOPE_ORGLOCAL);
end;

function IN6_IS_ADDR_MC_GLOBAL(const addr: in6_addr): Boolean;
begin
  Result := IN6_IS_ADDR_MULTICAST(addr) and 
    (IPV6_ADDR_MC_SCOPE(addr) = IPV6_ADDR_SCOPE_GLOBAL);
end;

end.

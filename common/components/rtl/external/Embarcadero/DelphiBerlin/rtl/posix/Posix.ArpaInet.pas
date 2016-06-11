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

unit Posix.ArpaInet;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses Posix.Base, Posix.NetinetIn, Posix.SysSocket;

{$I ArpaInetAPI.inc}

type
  in_port_t = Posix.NetinetIn.in_port_t;
  {$EXTERNALSYM in_port_t}
  in_addr_t = Posix.NetinetIn.in_addr_t;
  {$EXTERNALSYM in_addr_t}
  in_addr = Posix.NetinetIn.in_addr;
  {$EXTERNALSYM in_addr}

{$IFDEF ANDROID}

function htonl(hostlong: UInt32): UInt32; inline;
{$EXTERNALSYM htonl}
function htons(hostshort: UInt16): UInt16; inline;
{$EXTERNALSYM htons}
function ntohl(netong: UInt32): UInt32; inline;
{$EXTERNALSYM ntohl}
function ntohs(netshort: UInt16): UInt16; inline;
{$EXTERNALSYM ntohs}

{$ELSE}

function htonl(hostlong: UInt32): UInt32; cdecl;
  external libc name _PU + 'htonl';
{$EXTERNALSYM htonl}
function htons(hostshort: UInt16): UInt16; cdecl;
  external libc name _PU + 'htons';
{$EXTERNALSYM htons}
function ntohl(netong: UInt32): UInt32; cdecl;
  external libc name _PU + 'ntohl';
{$EXTERNALSYM ntohl}
function ntohs(netshort: UInt16): UInt16; cdecl;
  external libc name _PU + 'ntohs';
{$EXTERNALSYM ntohs}

{$ENDIF ANDROID}

implementation

{$IFDEF ANDROID}

function swap16(x: UInt16): UInt16; inline;
begin
  Result := ((x and $ff) shl 8) or ((x and $ff00) shr 8);
end;

function swap32(x: UInt32): UInt32; inline;
begin
  Result := ((x and $ff) shl 24) or ((x and $ff00) shl 8) or
  ((x and $ff0000) shr 8) or ((x and $ff000000) shr 24);
end;

{$IFDEF ARM} // big endian
function htons(hostshort: UInt16): UInt16; inline;
begin
  Result := hostshort;
end;

function htonl(hostlong: UInt32): UInt32; inline;
begin
  Result := hostlong;
end;

function ntohl(netong: UInt32): UInt32; inline;
begin
  Result := netong;
end;

function ntohs(netshort: UInt16): UInt16; inline;
begin
  Result := netshort;
end;
{$ELSE} // little endian
function htons(hostshort: UInt16): UInt16; inline;
begin
  Result := swap16(hostshort);
end;

function htonl(hostlong: UInt32): UInt32; inline;
begin
  Result := swap32(hostlong);
end;

function ntohl(netong: UInt32): UInt32; inline;
begin
  Result := swap32(netong);
end;

function ntohs(netshort: UInt16): UInt16; inline;
begin
  Result := swap16(netshort);
end;

{$ENDIF ARM}


{$ENDIF ANDROID}

end.

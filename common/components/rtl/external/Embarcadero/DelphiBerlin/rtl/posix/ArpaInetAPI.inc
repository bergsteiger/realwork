{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

function inet_addr(cp: MarshaledAString): in_addr_t; cdecl;
  external libc name _PU + 'inet_addr';
{$EXTERNALSYM inet_addr}
function inet_ntoa(&in: in_addr): MarshaledAString; cdecl;
  external libc name _PU + 'inet_ntoa';
{$EXTERNALSYM inet_ntoa}
function inet_ntop(af: Integer; src: MarshaledAString; dst: MarshaledAString;
  size: socklen_t): MarshaledAString; cdecl;
  external libc name _PU + 'inet_ntop';
{$EXTERNALSYM inet_ntop}
function inet_pton(af: Integer; src: MarshaledAString;
  dst: Pointer): Integer; cdecl;
  external libc name _PU + 'inet_pton';
{$EXTERNALSYM inet_pton}

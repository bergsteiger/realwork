{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$IFNDEF ANDROID}
procedure if_freenameindex(var ptr: _if_nameindex); cdecl;
  external libc name _PU + 'if_freenameindex';
{$EXTERNALSYM if_freenameindex}

function if_nameindex: PIfNameIndex; cdecl;
  external libc name _PU + 'if_nameindex';
{$EXTERNALSYM if_nameindex}
{$ENDIF !ANDROID}

function if_indextoname(ifindex: Cardinal; ifname: MarshaledAString): MarshaledAString; cdecl;
  external libc name _PU + 'if_indextoname';
{$EXTERNALSYM if_indextoname}

function if_nametoindex(ifname: MarshaledAString): Cardinal; cdecl;
  external libc name _PU + 'if_nametoindex';
{$EXTERNALSYM if_nametoindex}

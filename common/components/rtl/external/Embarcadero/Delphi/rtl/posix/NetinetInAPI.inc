{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

type
  PUInt8 = ^UInt8; //TODO: Where to put this?

{ Hop-by-Hop and Destination Options Processing(RFC 3542).  }
function inet6_opt_init(__extbuf: Pointer; __extlen: socklen_t): Integer; cdecl; platform;
  external libc name _PU + 'inet6_opt_init';
{$EXTERNALSYM inet6_opt_init}
  
function inet6_opt_append(__extbuf: Pointer; __extlen: socklen_t; __offset: Integer;
  __type: UInt8; __len: socklen_t; __align: UInt8; 
  __databufp: PPointer): Integer; cdecl; platform;
  external libc name _PU + 'inet6_opt_append';
{$EXTERNALSYM inet6_opt_append}
  
function inet6_opt_finish(__extbuf: Pointer; __extlen: socklen_t; 
  __offset: Integer): Integer; cdecl; platform;
  external libc name _PU + 'inet6_opt_finish';
{$EXTERNALSYM inet6_opt_finish}
  
function inet6_opt_set_val(__databuf: Pointer; __offset: Integer; __val: Pointer;
  __vallen: socklen_t): Integer; cdecl; platform;
  external libc name _PU + 'inet6_opt_set_val';
{$EXTERNALSYM inet6_opt_set_val}
  
function inet6_opt_next(__extbuf: Pointer; __extlen: socklen_t; __offset: Integer;
  __typep: PUInt8; __lenp: Psocklen_t; __databufp: PPointer): Integer; cdecl; platform;
  external libc name _PU + 'inet6_opt_next';
{$EXTERNALSYM inet6_opt_next}
  
function inet6_opt_find(__extbuf: Pointer; __extlen: socklen_t; __offset: Integer;
  __type: UInt8; __lenp: Psocklen_t; __databufp: PPointer): Integer; cdecl; platform;
  external libc name _PU + 'inet6_opt_find';
{$EXTERNALSYM inet6_opt_find}
  
function inet6_opt_get_val(__databuf: Pointer; __offset: Integer; __val: Pointer;
			      __vallen: socklen_t): Integer; cdecl; platform;
  external libc name _PU + 'inet6_opt_get_val';
{$EXTERNALSYM inet6_opt_get_val}

 { Routing Header Option(RFC 3542).  }
function inet6_rth_space(__type, __segments: Integer): socklen_t; cdecl; platform;
  external libc name _PU + 'inet6_rth_space';
{$EXTERNALSYM inet6_rth_space}
  
function inet6_rth_init(__bp: Pointer; __bp_len: socklen_t;
  __type, __segments: Integer): Pointer; cdecl; platform;
  external libc name _PU + 'inet6_rth_init';
{$EXTERNALSYM inet6_rth_init}
  
function inet6_rth_add(__bp: Pointer; __addr: Pin6_addr): Integer; cdecl; platform;
  external libc name _PU + 'inet6_rth_add';
{$EXTERNALSYM inet6_rth_add}
  
function inet6_rth_reverse(__in: Pointer; __out: Pointer): Integer; cdecl; platform;
  external libc name _PU + 'inet6_rth_reverse';
{$EXTERNALSYM inet6_rth_reverse}
  
function inet6_rth_segments(__bp: Pointer): Integer; cdecl; platform;
  external libc name _PU + 'inet6_rth_segments';
{$EXTERNALSYM inet6_rth_segments}
  
function inet6_rth_getaddr(__bp: Pointer; 
  __index: Integer): Pin6_addr; cdecl; platform;
  external libc name _PU + 'inet6_rth_getaddr';
{$EXTERNALSYM inet6_rth_getaddr}

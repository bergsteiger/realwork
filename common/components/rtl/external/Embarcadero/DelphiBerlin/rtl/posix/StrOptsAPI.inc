{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{ Perform the I/O control operation specified by REQUEST on FD.
   One argument may follow; its presence and type depend on REQUEST.
   Return value depends on REQUEST.  Usually -1 indicates error.  }
function ioctl(fd: Integer; request: Integer): Integer; varargs; cdecl;
  external libc name _PU + 'ioctl';
{$EXTERNALSYM ioctl}

{$IFNDEF ANDROID}
{$IFDEF STRBUF_DEFINED}

function isastream(__fildes: Integer): Integer; cdecl;
  external libc name _PU + 'isastream';
{$EXTERNALSYM isastream}

function getmsg(__fildes: Integer; __ctlptr: Pstrbuf; __dataptr: Pstrbuf;
  __flagsp: PInteger): Integer; cdecl;
  external libc name _PU + 'getmsg';
{$EXTERNALSYM getmsg}

function getpmsg(__fildes: Integer; __ctlptr: Pstrbuf; __dataptr: Pstrbuf;
  __bandp: PInteger; __flagsp: PInteger): Integer; cdecl;
  external libc name _PU + 'getpmsg';
{$EXTERNALSYM getpmsg}

function putmsg(__fildes: Integer; __ctlptr: Pstrbuf; __dataptr: Pstrbuf;
  __flags: Integer): Integer; cdecl;
  external libc name _PU + 'putmsg';
{$EXTERNALSYM putmsg}

function putpmsg(__fildes: Integer; __ctlptr: Pstrbuf; __dataptr: Pstrbuf;
  __band: Integer; __flags: Integer): Integer; cdecl;
  external libc name _PU + 'putpmsg';
{$EXTERNALSYM putpmsg}

function fattach(__fildes: Integer; __path: MarshaledAString): Integer; cdecl;
  external libc name _PU + 'fattach';
{$EXTERNALSYM fattach}

function fdetach(__path: MarshaledAString): Integer; cdecl;
  external libc name _PU + 'fdetach';
{$EXTERNALSYM fdetach}

{$ENDIF STRBUF_DEFINED}
{$ENDIF !ANDROID}

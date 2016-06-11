{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}


{$IF not (defined(ANDROID) or defined(LINUX))}
procedure endhostent; cdecl;
  external libc name _PU + 'endhostent';
{$EXTERNALSYM endhostent}
procedure endnetent; cdecl;
  external libc name _PU + 'endnetent';
{$EXTERNALSYM endnetent}
procedure endprotoent; cdecl;
  external libc name _PU + 'endprotoent';
{$EXTERNALSYM endprotoent}
procedure endservent; cdecl;
  external libc name _PU + 'endservent';
{$EXTERNALSYM endservent}

function getprotoent: PProtoEnt; cdecl;
  external libc name _PU + 'getprotoent';
{$EXTERNALSYM getprotoent}

function getnetent: PNetEnt; cdecl;
  external libc name _PU + 'getnetent';
{$EXTERNALSYM getnetent}

procedure sethostent(host: Integer); cdecl;
  external libc name _PU + 'sethostent';
{$EXTERNALSYM sethostent}
procedure setnetent(net: Integer); cdecl;
  external libc name _PU + 'setnetent';
{$EXTERNALSYM setnetent}
procedure setprotoent(proto: Integer); cdecl;
  external libc name _PU + 'setprotoent';
{$EXTERNALSYM setprotoent}

// RPC functions
function getrpcent:rpcent; cdecl;
  external libc name _PU + 'getrpcent';
{$EXTERNALSYM getrpcent}

function getrpcbyname(const name: MarshaledAString):rpcent; cdecl;
  external libc name _PU + 'getrpcbyname';
{$EXTERNALSYM getrpcbyname}

function getrpcbynumber(number: Integer):rpcent; cdecl;
  external libc name _PU + 'getrpcbynumber';
{$EXTERNALSYM getrpcbynumber}

procedure setrpcent(stayopen: integer);
  external libc name _PU + 'setrpcent';
{$EXTERNALSYM setrpcent}

procedure endrpcent;
  external libc name _PU + 'endrpcent';
{$EXTERNALSYM endrpcent}
{$ENDIF !ANDROID or !LINUX}

procedure freeaddrinfo(var ai: addrinfo); cdecl;
  external libc name _PU + 'freeaddrinfo';
{$EXTERNALSYM freeaddrinfo}
function gai_strerror(ecode: Integer): MarshaledAString; cdecl;
  external libc name _PU + 'gai_strerror';
{$EXTERNALSYM gai_strerror}
function getaddrinfo(hostname, servname: MarshaledAString;
  const [Ref]hints: addrinfo; out res: Paddrinfo): Integer; cdecl;
  external libc name _PU + 'getaddrinfo';
{$EXTERNALSYM getaddrinfo}
function gethostent: PHostEnt; cdecl;
  external libc name _PU + 'gethostent';
{$EXTERNALSYM gethostent}
function getnameinfo(const [Ref] sa: sockaddr; salen: socklen_t;
  host: MarshaledAString; hostlen: socklen_t;
  serv: MarshaledAString; servlen: socklen_t;
  flags: Integer): Integer; cdecl;
  external libc name _PU + 'getnameinfo';
{$EXTERNALSYM getnameinfo}
function getnetbyaddr(net: UInt32; &type: Integer): PNetEnt; cdecl;
  external libc name _PU + 'getnetbyaddr';
{$EXTERNALSYM getnetbyaddr}
function getnetbyname(name: MarshaledAString): PNetEnt; cdecl;
  external libc name _PU + 'getnetbyname';
{$EXTERNALSYM getnetbyname}

function getprotobyname(name: MarshaledAString): PProtoEnt; cdecl;
  external libc name _PU + 'getprotobyname';
{$EXTERNALSYM getprotobyname}
function getprotobynumber(proto: Integer): PProtoEnt; cdecl;
  external libc name _PU + 'getprotobynumber';
{$EXTERNALSYM getprotobynumber}

function getservbyname(name, proto: MarshaledAString): PServEnt; cdecl;
  external libc name _PU + 'getservbyname';
{$EXTERNALSYM getservbyname}
function getservbyport(port: Integer; proto: MarshaledAString): PServEnt; cdecl;
  external libc name _PU + 'getservbyport';
{$EXTERNALSYM getservbyport}
function getservent: PServEnt; cdecl;
  external libc name _PU + 'getservent';
{$EXTERNALSYM getservent}

procedure setservent(serv: Integer); cdecl;
  external libc name _PU + 'setservent';
{$EXTERNALSYM setservent}

function gethostbyname(const name: MarshaledAString): PHostEnt; cdecl;
  external libc name _PU + 'gethostbyname';
{$EXTERNALSYM gethostbyname}

function gethostbyname2(const name: MarshaledAString; af: integer): PHostEnt; cdecl;
  external libc name _PU + 'gethostbyname2';
{$EXTERNALSYM gethostbyname2}

function gethostbyaddr(var addr; len: socklen_t; atype: integer): PHostEnt; cdecl;
  external libc name _PU + 'gethostbyaddr';
{$EXTERNALSYM gethostbyaddr}

procedure herror(const error: MarshaledAString); cdecl;
  external libc name _PU + 'herror';
{$EXTERNALSYM herror}
function hstrerror(error: integer): MarshaledAString; cdecl;
  external libc name _PU + 'hstrerror';
{$EXTERNALSYM hstrerror}



{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


function accept(socket: Integer; out address: sockaddr;
  var address_len: socklen_t): Integer; cdecl;
  external libc name _PU + 'accept';
  {$EXTERNALSYM accept}

function bind(socket: Integer; const [Ref] address: sockaddr;
  address_len: socklen_t): Integer; cdecl;
  external libc name _PU + 'bind';
  {$EXTERNALSYM bind}

function connect(socket: Integer; const [Ref] address: sockaddr;
  address_len: socklen_t): Integer; cdecl;
  external libc name _PU + 'connect';
  {$EXTERNALSYM connect}

function getpeername(socket: Integer; var address: sockaddr;
  var address_len: socklen_t): Integer; cdecl;
  external libc name _PU + 'getpeername';
  {$EXTERNALSYM getpeername}

function getsockname(socket: Integer; var address: sockaddr;
  var address_len: socklen_t): Integer; cdecl;
  external libc name _PU + 'getsockname';
  {$EXTERNALSYM getsockname}

function getsockopt(socket, level, option_name: Integer;
  var option_value; var option_len: socklen_t): Integer; cdecl;
  external libc name _PU + 'getsockopt';
  {$EXTERNALSYM getsockopt}

function listen(socket, backlog: Integer): Integer; cdecl;
  external libc name _PU + 'listen';
  {$EXTERNALSYM listen}

function recv(socket: Integer; var buffer; length: size_t;
  flags: Integer): ssize_t; cdecl;
  external libc name _PU + 'recv';
  {$EXTERNALSYM recv}

function recvfrom(socket: Integer; var buffer; length: Size_t;
  flags: Integer; var address: sockaddr;
  var address_len: socklen_t):  ssize_t; cdecl;
  external libc name _PU + 'recvfrom';
  {$EXTERNALSYM recvfrom}

function recvmsg(socket: Integer; var message: msghdr;
  flags: Integer): ssize_t; cdecl;
  external libc name _PU + 'recvmsg';
  {$EXTERNALSYM recvmsg}

function send(socket: Integer; const message; length: size_t;
  flags: Integer): ssize_t; cdecl;
  external libc name _PU + 'send';
  {$EXTERNALSYM send}

function sendmsg(socket: Integer; const [Ref] message: msghdr;
  flags: Integer): ssize_t; cdecl;
  external libc name _PU + 'sendmsg';
  {$EXTERNALSYM sendmsg}

function sendto(socket: Integer; const message; length: size_t;
  flags: Integer; const [Ref] dest_addr: sockaddr; dest_len: socklen_t): ssize_t; cdecl;
  external libc name _PU + 'sendto';
  {$EXTERNALSYM sendto}

function setsockopt(socket, level, option_name: Integer;
  const option_value; option_len: socklen_t): Integer; cdecl;
  external libc name _PU + 'setsockopt';
  {$EXTERNALSYM setsockopt}

function shutdown(socket, how: Integer): Integer; cdecl;
  external libc name _PU + 'shutdown';
  {$EXTERNALSYM shutdown}

function socket(domain, &type, protocol: Integer): Integer; cdecl;
  external libc name _PU + 'socket';
  {$EXTERNALSYM socket}

function socketpair(domain, &type, protocol: Integer;
  socket_vector: PInteger): Integer; cdecl;
  external libc name _PU + 'socketpair';
  {$EXTERNALSYM socketpair}

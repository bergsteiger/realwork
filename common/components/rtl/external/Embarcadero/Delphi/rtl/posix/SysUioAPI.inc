{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


function readv(filedes: Integer; const iov: iovec; 
  iovcnt: Integer): ssize_t; cdecl;
  external libc name _PU + 'readv';
{$EXTERNALSYM readv}
function writev(filedes: Integer; const iov: iovec;
  iovcnt: Integer): ssize_t; cdecl;
  external libc name _PU + 'writev';
{$EXTERNALSYM writev}

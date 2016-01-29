{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.ArpaInet;

{$WEAKPACKAGEUNIT}

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

implementation

end.

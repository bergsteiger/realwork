// **********************************************************************
//
// Copyright (c) 2001 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
unit addr_int;

interface

{$I dorb.inc}

uses
  orbtypes,SysUtils,Classes,{$IFDEF WIN32}winsock{$ENDIF} {$IFDEF LINUX}Libc{$ENDIF},
  disp_int,code_int,env_int;

type

  IAddress = interface;
  ITransportCallBack = interface;
  ITransportServerCallBack = interface;

  TTransportState = (tsClosed, tsOpen);

  ITransport = interface(IUnknown)
  ['{61252F64-4D23-11d4-9D27-204C4F4F5020}']
    function bad(): Boolean; stdcall;
    procedure block(val: Boolean);
    function isblocking(): boolean;
    function bufread(buf: IBuffer;size: _ulong): integer; stdcall;
    function bufwrite(buf: IBuffer; size: _ulong; eat: boolean = true): integer; stdcall;
    function connect(const addr : IAddress): Boolean; stdcall;
    procedure open(fd: Longint); stdcall;
    procedure close(); stdcall;
    function eof(): Boolean; stdcall;
    function peer(): IAddress;
    function read(var buffer; size: _ulong): integer; stdcall;
    procedure rselect(const disp: IORBDispatcher;const cb: ITransportCallback); stdcall;
    procedure wselect(const disp: IORBDispatcher;const cb: ITransportCallback); stdcall;
    function write(const buffer;size: _ulong): integer; stdcall;
    function get_principal(): IPrincipal;
    function get_address: IAddress;
  end;

  ITransportServer = interface
  ['{61252F65-4D23-11d4-9D27-204C4F4F5020}']
    function accept(): ITransport;
    procedure aselect(const disp: IORBDispatcher;const cb: ITransportServerCallback);
    function bind(const addr: IAddress): Boolean;
    function get_address: IAddress;
    procedure listen();
    procedure block(doblock: boolean);
    procedure close();
//    function isblocking(): boolean;
{$IFDEF HAVE_THREADS}
    procedure create_thread();
    procedure start();
{$ENDIF}
  end;

  ITransportCallBack = interface
  ['{61252F66-4D23-11d4-9D27-204C4F4F5020}']
    procedure callback(tr: ITransport;event :TTransportCallBackEvent);
  end;

  ITransportServerCallBack = interface
  ['{61252F67-4D23-11d4-9D27-204C4F4F5020}']
    procedure ts_callback(ts: ITransportServer;event :TTransportServerCallBackEvent);
  end;

  IAddress = interface
  ['{61252F68-4D23-11d4-9D27-204C4F4F5020}']
    function proto(): AnsiString;
    function compare(const addr: IAddress): Boolean;
    function toString(): AnsiString;
    function make_transport(): ITransport;
    function make_transport_server(): ITransportServer;
    function make_ior_profile(const key: AnsiString; const len: _ulong;const mc: IInterface; const version: _ushort): IInterface;
    function socketaddress(): TSockAddrIn;
    procedure set_socketaddress(val:TSockAddrIn);
    function resolve_ip(): Boolean;
    function is_local(): Boolean;
    function valid: Boolean;
  end;

  IInetAddress = interface(IAddress)
  ['{02F45D85-203A-11d4-9CCB-204C4F4F5020}']
    function Host: AnsiString;
    function _Port: _ushort;
    procedure SetPort(const port: _ushort);
    function Family: TFamily;
    function socketaddress(): TSockAddrIn;
    function ipaddr: _ulong;
    function ipaddrstr: AnsiString;
  end;

  IAddressParser = interface
  ['{02F45D86-203A-11d4-9CCB-204C4F4F5020}']
    function has_protocol(const str: AnsiString): Boolean;
    function parse(const rest: AnsiString; const proto: AnsiString): IAddress;
  end;

implementation

end.

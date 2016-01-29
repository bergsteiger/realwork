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
unit disp_int;

interface

uses
  orbtypes,SysUtils,Classes,{$IFDEF WIN32}winsock{$ENDIF} {$IFDEF LINUX}Libc{$ENDIF};

type

  IORBDispCallback = interface;

  IORBDispatcher = interface(IUnknown)
  ['{094BE463-218A-11d4-9CCE-204C4F4F5020}']
    procedure socketevent(const cb: IORBDispCallback; fd: TSocket;evt: TDispEvent);
    procedure timeevent(const cb: IORBDispCallback; timeout: longint);
    procedure run(infinite :Boolean);
    procedure move(const disp: IORBDispatcher);
    procedure remove(const cb: IORBDispCallback;evt: TDispEvent);
    function idle(): Boolean;
    procedure block(b: boolean);
    function isblocking: boolean;
  end;

  IORBDispCallback = interface(IUnknown)
  ['{094BE464-218A-11d4-9CCE-204C4F4F5020}']
    procedure callback(const disp: IORBDispatcher;event: TDispEvent);
  end;

  ISelectDispatcher = interface(IORBDispatcher)
  ['{094BE465-218A-11d4-9CCE-204C4F4F5020}']
    procedure handle_fevents(rset: TFDSet;wset: TFDSet;xset: TFDSet);
    procedure update_fevents(var rset,wset,xset: TFDSet; var nfds: integer);
    procedure interrupt_dispatch();
    function dispatch_one_event(const timeout: long): boolean;
  end;

implementation

end.

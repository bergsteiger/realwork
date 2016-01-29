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
unit iiop_int;

interface

uses
  orb_int,giop_int,orbtypes,addr_int,iior_int,mcomp_int,req_int,env_int,code_int;

type
  TListenPoint = record
    host: AnsiString;
    port: _ushort;
  end;

  TListenPointList = array of TListenPoint;

  TBiDirIIOPServiceContext = record
    listen_points: TListenPointList;
  end;

  IIOPProfile = interface(IIORProfile)
  ['{AF662CB5-4D2E-11d4-9D27-204C4F4F5020}']
    //function comps: IMultiComponent;
    function version: _ushort;
  end;

  IIIOPProxyInvokeRecord = interface
  ['{AF662CB6-4D2E-11d4-9D27-204C4F4F5020}']
    function connection(): IGIOPConnection;
    procedure init(id: ORBMessageID;conn: IGIOPConnection;req : IORBRequest);
    function id(): ORBMessageID;
    function msgid(): MessageID;
    function request(): IORBRequest;
    procedure reset();
    function active(): boolean;
    procedure deactivate();
  end;

  IIIOPServerInvokeRecord = interface
  ['{AF662CB7-4D2E-11d4-9D27-204C4F4F5020}']
    procedure init_invoke (const conn: IGIOPConnection; reqid: MessageID;
      orbid: ORBMessageID; const req : IORBRequest; const obj: IORBObject;
      const pr: IPrincipal);
    procedure init_locate (const conn: IGIOPConnection; reqid: MessageID;
      orbid: ORBMessageID; const obj: IORBObject);
    function get_request(): IORBRequest;
    function orbid: ORBMessageID;
    function _reqid: MessageID;
    function orbmsgid(): MessageID;
    procedure set_orbid(oid: ORBMessageID);
    procedure set_reqid(reqid: MessageID);
    function connection : IGIOPConnection;
    procedure clean();
    function active(): boolean;
    procedure deactivate();
  end;

  IIIOPServer = interface
  ['{AF662CB8-4D2E-11d4-9D27-204C4F4F5020}']
    procedure abort_invoke_orbid(rec : IIIOPServerInvokeRecord);
    procedure add_invoke(rec: IIIOPServerInvokeRecord);
    procedure del_invoke_orbid(rec : IIIOPServerInvokeRecord);
    procedure del_invoke_reqid(orbid: MessageID;const conn: IGIOPConnection);
    procedure kill_connection(const conn: IGIOPConnection; redo: boolean = false);
    function handle_input(const conn: IGIOPConnection; const inp: IBuffer): Boolean;
    function exec_invoke_request(const inc: IGIOPInContext;obj : IORBObject;
      req: IORBRequest; const pr: IPrincipal; resp_exp: Boolean;const conn: IGIOPConnection; id: ORBMessageID): ORBMessageID;
    function handle_invoke_request (const conn: IGIOPConnection;const inc: IGIOPInContext):Boolean;
    function handle_locate_request (const conn: IGIOPConnection;const inc: IGIOPInContext):Boolean;
    function handle_cancel_request (const conn: IGIOPConnection;const inc: IGIOPInContext):Boolean;
    procedure handle_invoke_reply (id: ORBMessageID);
    procedure handle_locate_reply (id: ORBMessageID);
    procedure handle_bind_reply (id: ORBMessageID);
    function listen(): Boolean;
    function listen_addr(addr: IAddress;addr2: IAddress):Boolean;
    //procedure callback (const orb: IORB; mid: MessageID; evt : TORBCallbackEvent);
  end;

implementation

end.

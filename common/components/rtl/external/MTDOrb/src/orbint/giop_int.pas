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
unit giop_int;

interface

{$I dorb.inc}

uses
  orbtypes,SysUtils,Classes,{$IFDEF WIN32}winsock{$ENDIF} {$IFDEF LINUX}Libc{$ENDIF},
  code_int,orb_int,req_int,addr_int,mtmanager_int,mtmanager,osthread,disp_int;

type

  IGIOPConnection = interface;
  IGIOPOutContext = interface;
  IGIOPInContext = interface;

  IGIOPCallBack = interface(IORBCallBack)
  ['{AF662CB0-4D2E-11d4-9D27-204C4F4F5020}']
    function giop_callback(const conn: IGIOPConnection;event: TEventType): Boolean;
    function input_giop_callback(const conn: IGIOPConnection;const buf: IBuffer{;event: TEventType}): Boolean;
{$IFDEF HAVE_THREADS}
    procedure send_orb_msg(const conn: IGIOPConnection;event: TORBMsgEvent);
{$ENDIF}
  end;

  IGIOPCodec = interface
  ['{AF662CB1-4D2E-11d4-9D27-204C4F4F5020}']
    function check_header(ctx: IGIOPInContext; var mt: TMessageType; var size: _ulong; var flags: byte ): Boolean;
    function get_bind_reply(const ctx: IGIOPInContext; out status: TLocateStatusType; out obj: IORBObject): Boolean;
    function get_bind_request(const ctx: IGIOPInContext; out repoid: RepositoryId; out tag: IObjectTag): Boolean;
    function get_encoder(): IEncoder;
    function get_close_msg(const inc: IGIOPInContext): Boolean;
    function get_error_msg(const inc: IGIOPInContext): Boolean;
    function get_decoder(): IDecoder;
    function get_invoke_reply1(const incon: IGIOPInContext; var reqid: _ulong;var status: TReplyStatusType;var ctx: ServiceContextList): Boolean;
    function get_invoke_reply2(const incon: IGIOPInContext; reqid: _ulong;
      status: TReplyStatusType; var obj: IORBObject; req: IORBRequest; var ad: AddressingDisposition; const ctx: ServiceContextList): Boolean;
    function get_locate_request(const ctx: IGIOPInContext; out req_id: MessageID; const obj: IORBObject): Boolean;
    function get_cancel_request(const ctx: IGIOPInContext; out req_id: MessageID): Boolean;
    function get_locate_reply(const ctx: IGIOPInContext; out req_id: MessageID; out stat: TLocateStatusType; out obj: IORBObject; out ad: AddressingDisposition): Boolean;
    function get_invoke_request(const cin: IGIOPInContext; out reqid: _ulong; out flags: byte; const obj: IORBObject;
      out req: IORBRequest; const pr: IPrincipal): Boolean;
    function get_header(ctx: IGIOPInContext; var mt: TMessageType; var size: _ulong; var flags: byte ): Boolean;
    function get_target(const inc: IGIOPInContext; const obj : IORBObject): Boolean;
    function put_args(const outc : IGIOPOutContext;const req: IORBRequest;input: Boolean): Boolean;
    function put_bind_request(const outc: IGIOPOutContext;reqid: _ulong; const repoid: RepositoryId;
      const tag: IObjectTag): Boolean;
    function put_bind_reply(const outc: IGIOPOutContext; reqid: _ulong; stat: TLocateStatusType; const obj: IORBObject): Boolean;
    function put_cancel_request(const ctx: IGIOPOutContext; mid: MessageID): Boolean;
    function put_locate_request(const ctx: IGIOPOutContext; req_id: MessageID; const obj: IORBObject): Boolean;
    function put_locate_reply(const ctx: IGIOPOutContext; req_id: MessageID; stat: TLocateStatusType; const obj: IORBObject; ad: AddressingDisposition): Boolean;
    function put_close_msg(const ctx: IGIOPOutContext): Boolean;
    function put_error_msg(const ctx: IGIOPOutContext): Boolean;
    function put_header(const outc : IGIOPOutContext;mt: TMessageType): _ulong;
    function put_invoke_reply(const outc: IGIOPOutContext; req_id: _ulong; stat: TReplyStatusType;
      obj: IORBObject; req: IORBRequest; ad: AddressingDisposition): Boolean;
    function put_invoke_reply_offset(const outc: IGIOPOutContext;const req: IORBRequest): Boolean;
    function put_invoke_request(const outc : IGIOPOutContext;mid: MessageID;
      resp: Boolean;const obj: IORBObject;const req: IORBRequest; pr: IPrincipal): Boolean;
    function header_len: _ulong;
    function version(): _ulong;
    function setup_codeset_ids(const obj: IORBObject): boolean;
    function converter(): ICodesetCoder;
  end;

  IGIOPOutContext = interface
  ['{AF662CB2-4D2E-11d4-9D27-204C4F4F5020}']
    function encoder(): IEncoder;
    function buffer(): IBuffer;
    function length(): _ulong;
    procedure set_converter(conv : ICodesetCoder);
  end;

  IGIOPInContext = interface
  ['{AF662CB3-4D2E-11d4-9D27-204C4F4F5020}']
    procedure buffer(buf: IBuffer);
    function decoder(): IDecoder;
    procedure set_converter(conv : ICodesetCoder);
  end;

  IGIOPConnection = interface
  ['{AF662CB4-4D2E-11d4-9D27-204C4F4F5020}']
    procedure do_read(break_after_read: boolean = false);
    function codec(): IGIOPCodec;
    procedure output(const buf : IBuffer);
    procedure output_handler(const buf : IBuffer);
    function input(): IBuffer;
    function transport(): ITransport;
    procedure start();
{$IFDEF HAVE_THREADS}
    function activeRef(): boolean;
    procedure activeDeref();
{$ENDIF}
    function deref(all: boolean = false): boolean;
    procedure ref();
    procedure terminate();
    function state(): TExecState;
    function input_ready_callback(const buf : IBuffer): boolean;
    procedure flush();
{$IFDEF HAVE_THREADS}
    procedure get_exclusive();
    procedure release_exclusive();
{$ENDIF}
  end;

  IGIOPConnectionMgr = interface
  ['{3B863B3E-119C-4721-8496-4C4CB42544B9}']
    function Dispatcher: IORBDispatcher;
    procedure add_connection(const conn: IGIOPConnection; const addr: IAddress);
    function find_connection(const addr: IAddress): IGIOPConnection;
    function get_current_connection(): IGIOPConnection;
  end;

  IGIOPConnectionWriter = interface(IActiveOperation)
  ['{16614E85-4191-4B9D-A0B4-97DB44370F05}']
    procedure _send_msg(msg: IMsgType);
  end;

  IGIOPConnectionMsg = interface(IUnknown)
  ['{2318B5B4-B53A-4841-889B-37EE678D96D7}']
    function connection(): IGIOPConnection;
    function buffer(): IBuffer;
    function eventType(): TEventType;
  end;

  IOrbMsg = interface(IUnknown)
  ['{1C698047-7BF3-4CB2-8265-0362BD6D6F9C}']
    function connection(): IGIOPConnection;
    function callback(): IGIOPCallBack;
    function orbEvent(): TORBMsgEvent;
  end;

implementation

end.

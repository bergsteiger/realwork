// **********************************************************************
//
// Copyright (c) 2001 - 2002 Millennium Group.
//
// Samara, Russia
//
// All Rights Reserved
//
// **********************************************************************
unit bidir_impl;

interface

uses orbtypes, pi, pi_int, orb_int;

type
  TBiDirConnectionClientInterceptor = class(TClientRequestInterceptor)
  private
    FORB: IORB;
  protected
    procedure _destroy; override;
    function _get_name: AnsiString; override;
    procedure send_request(const ri: IClientRequestInfo); override;
    procedure send_poll(const ri: IClientRequestInfo); override;
    procedure receive_reply(const ri: IClientRequestInfo); override;
    procedure receive_exception(const ri: IClientRequestInfo); override;
    procedure receive_other(const ri: IClientRequestInfo); override;
  public
    constructor Create(const AORB: IORB);
  end;

  TBiDirConnectionServerInterceptor = class(TServerRequestInterceptor)
  private
    FORB: IORB;
  protected
    procedure _destroy; override;
    function _get_name: AnsiString; override;
    procedure receive_request_service_contexts(const ri: IServerRequestInfo); override;
    procedure receive_request(const ri: IServerRequestInfo); override;
    procedure send_reply(const ri: IServerRequestInfo); override;
    procedure send_exception(const ri: IServerRequestInfo); override;
    procedure send_other(const ri: IServerRequestInfo); override;
  public
    constructor Create(const AORB: IORB);
  end;

  TBiDirConnectionInitializer = class(TORBInitializer)
  protected
    procedure pre_init(const info: IORBInitInfo); override;
    procedure post_init(const info: IORBInitInfo); override;
  public
     class procedure Init;
  end;

implementation

uses addr_int, iiop_int, code_int, any, iiop, static, std_seq, exceptions, address,
  giop_int, pi_impl, encoder, decoder, orb;

{ TBiDirConnectionClientInterceptor }

procedure TBiDirConnectionClientInterceptor._destroy;
begin

end;

function TBiDirConnectionClientInterceptor._get_name: AnsiString;
begin
  result := 'BiDirConnectionClientInterceptor';
end;

procedure TBiDirConnectionClientInterceptor.receive_exception(
  const ri: IClientRequestInfo);
begin

end;

procedure TBiDirConnectionClientInterceptor.receive_other(
  const ri: IClientRequestInfo);
begin

end;

procedure TBiDirConnectionClientInterceptor.receive_reply(
  const ri: IClientRequestInfo);
begin

end;

procedure TBiDirConnectionClientInterceptor.send_poll(
  const ri: IClientRequestInfo);
begin

end;

procedure TBiDirConnectionClientInterceptor.send_request(
  const ri: IClientRequestInfo);
var
  serviceContext: TServiceContext;
  addr: IAddress;
  bidirContext: TBiDirIIOPServiceContext;
  enc: IEncoder;
  serverConnMgr: IGIOPConnectionMgr;
begin
  if not FORB.UseBiDirGIOP then
    Exit;
  serverConnMgr := FORB.get_oa('dorb-iiop-server') as IGIOPConnectionMgr;
  //sent context in requiest initiatied by client only
  if serverConnMgr.get_current_connection <> nil then
    Exit;
  enc := CreateEncoder();
  enc.put_boolean(true);
  addr := FORB.ior_template.address();
  if addr.proto = 'inet' then begin
    SetLength(bidirContext.listen_points, 1);
    bidirContext.listen_points[0].host := (addr as IInetAddress).Host;
    bidirContext.listen_points[0].port := (addr as IInetAddress)._Port;
    BiDirIIOPServiceContext_marshaller.marshal(enc, @bidirContext);
    SetLength(serviceContext.context_data, enc.buffer.length);
    Move(Pointer(enc.buffer._buffer)^, Pointer(serviceContext.context_data)^, Length(serviceContext.context_data));
    serviceContext.context_id := IOP_BI_DIR_IIOP;

    //serviceContext.
    ri.add_request_service_context(serviceContext, true);
  end;
end;

constructor TBiDirConnectionClientInterceptor.Create(const AORB: IORB);
begin
  inherited Create;
  FORB := AORB;
end;

{ TBiDirConnectionServerInterceptor }

procedure TBiDirConnectionServerInterceptor._destroy;
begin

end;

function TBiDirConnectionServerInterceptor._get_name: AnsiString;
begin
  result := 'BiDirConnectionServerInterceptor';
end;

procedure TBiDirConnectionServerInterceptor.receive_request(
  const ri: IServerRequestInfo);
begin

end;

procedure TBiDirConnectionServerInterceptor.receive_request_service_contexts(
  const ri: IServerRequestInfo);
var
  serviceContext: TServiceContext;
  bidirContext: TBiDirIIOPServiceContext;
  i: Integer;
  addr: IAddress;
  proxyConnMgr, serverConnMgr: IGIOPConnectionMgr;
  dec: IDecoder;
  b: Boolean;
begin
  if not FORB.UseBiDirGIOP then
    Exit;
  try
    serviceContext := ri.get_request_service_context(IOP_BI_DIR_IIOP)
  except
    on E: BAD_PARAM do
      Exit;
  end; { try/except }
  dec := CreateDecoder();
  dec._buffer.put(Pointer(serviceContext.context_data)^, Length(serviceContext.context_data));
  dec.get_boolean(b);
  BiDirIIOPServiceContext_marshaller.demarshal(dec, @bidirContext);

  proxyConnMgr := FORB.get_oa('dorb-iiop-proxy') as IGIOPConnectionMgr;
  serverConnMgr := FORB.get_oa('dorb-iiop-server') as IGIOPConnectionMgr;

  for i := 0 to Length(bidirContext.listen_points) - 1 do begin
    with bidirContext.listen_points[i] do begin
      addr := TInetAddress.Create(host, port);
      //conn := serverConnMgr.find_connection(addr);
      //proxyConnMgr.add_connection(conn, addr);
      proxyConnMgr.add_connection(serverConnMgr.get_current_connection, addr);
    end; { with }
  end; { for }
end;

procedure TBiDirConnectionServerInterceptor.send_exception(
  const ri: IServerRequestInfo);
begin

end;

procedure TBiDirConnectionServerInterceptor.send_other(
  const ri: IServerRequestInfo);
begin

end;

procedure TBiDirConnectionServerInterceptor.send_reply(
  const ri: IServerRequestInfo);
begin

end;

constructor TBiDirConnectionServerInterceptor.Create(const AORB: IORB);
begin
  inherited Create;
  FORB := AORB;
end;

{ TBiDirConnectionInitializer }

class procedure TBiDirConnectionInitializer.Init;
begin
  TPIManager.RegisterOrbInitializer(TBiDirConnectionInitializer.Create());
end;

procedure TBiDirConnectionInitializer.post_init(const info: IORBInitInfo);
begin
  info.add_client_request_interceptor(TBiDirConnectionClientInterceptor.Create(ORB_Instance));
  info.add_server_request_interceptor(TBiDirConnectionServerInterceptor.Create(ORB_Instance));
  //info.register_policy_factory();
end;

procedure TBiDirConnectionInitializer.pre_init(const info: IORBInitInfo);
begin

end;

end.

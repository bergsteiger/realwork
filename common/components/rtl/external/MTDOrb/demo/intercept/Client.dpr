program Client;
{$APPTYPE CONSOLE}
uses
{$IFDEF WIN32}
  windows,
{$ENDIF}
{$IFDEF LINUX}
  Libc,
{$ENDIF}
  Classes,
  poa,
  poa_int,
  poa_impl,
  SysUtils,
  orb_int,
  orb,
  code_int,
  env_int,
  intercept_int,
  intercept,
  orbtypes,
  test_int in 'test_int.pas',
  test in 'test.pas';

type
  TTestClient = class(TClientInterceptor)
  protected
    function initialize_request(const req: ILWRequest; const env: IEnvironment): TStatus; override;
    function after_marshal(const req: ILWRequest; const env: IEnvironment): TStatus; override;
    function output_message(const buf: IBuffer; const env: IEnvironment): TStatus; override;
    function input_message(const buf: IBuffer; const env: IEnvironment): TStatus; override;
    function before_unmarshal(const req: ILWRequest; const env: IEnvironment): TStatus; override;
    function finish_request(const req: ILWRequest; const env: IEnvironment): TStatus; override;
  end;

procedure mainproc;
var
  dorb : IORB;
  obj: IORBObject;
  clientIntr: IClientInterceptor;
  fl : TStream;
  ref: AnsiString;
  myintf: IMyTest;
  prm: TStrings;
begin
  clientIntr := TTestClient.Create;
  clientIntr.activate(0);
  prm := TStringList.Create;
  try
    {prm.Add('-ORBConcModel');
    prm.Add('thread_per_connection');
    prm.Add('-ORBConnectionsLimit');
    prm.Add('5');}
    dorb := ORB_Init(prm);
  finally
    prm.Free;
  end; { try/finally }

  fl := TFileStream.Create('server.objid', fmOpenRead {$IFDEF WIN32}or fmShareCompat{$ENDIF});
  fl.Position := 0;
  SetLength(ref, fl.Size);
  fl.ReadBuffer(Pointer(ref)^, fl.Size);
  fl.free;

  obj := dorb.string_to_object(ref);
  myintf := TMyTest._narrow(obj);
  ref := 'Client';
  myintf.Foo(ref);
  WriteLn(ref);
  ReadLn;
  clientIntr.deactivate();
  dorb.shutdown(true);
  dorb._destroy();
  dorb := nil;
end;

function ThreadID(): string;
begin
  result := '. ' + IntToStr({$IFDEF WIN32}GetCurrentThreadID(){$ENDIF}{$IFDEF LINUX}getpid(){$ENDIF});
end;

{ TTestClient }

function TTestClient.after_marshal(const req: ILWRequest;
  const env: IEnvironment): TStatus;
begin
  (*
   * what you can do here:
   * - answer the request yourself by filling in out parameters
   *   or raising an exception (using env parameter) and returning
   *   INVOKE_ABORT
   *)
  WriteLn('client: after marshal for: ' + req.operation);
  result := INVOKE_CONTINUE;
end;

function TTestClient.before_unmarshal(const req: ILWRequest;
  const env: IEnvironment): TStatus;
begin
  (*
   * what you can do here:
   * - answer the request yourself by filling in out parameters
   *   or raising an exception (using env parameter) and returning
   *   INVOKE_ABORT
   *)
  WriteLn('client: before unmarshal for: ' + req.operation);
  result := INVOKE_CONTINUE;
end;

function TTestClient.finish_request(const req: ILWRequest;
  const env: IEnvironment): TStatus;
var
  ctx: ContextData;
  str: string;
begin
  (*
   * what you can do here:
   * - get the service context list from the reply
   * - modify the out/inout parameters of the request
   * - remove piggybacked extra values from the reply
   * - answer the request yourself by filling in out parameters
   *   or raising an exception (using env parameter) and returning
   *   INVOKE_ABORT
   *)
  WriteLn('client: finish request for: ' + req.operation);
  ctx := req.get_service_context(100, 0);
  SetLength(str, Length(ctx));
  move(Pointer(ctx)^, Pointer(str)^, Length(ctx));
  WriteLn(str);
  result := INVOKE_CONTINUE;
end;

function TTestClient.initialize_request(const req: ILWRequest;
  const env: IEnvironment): TStatus;
const
  cTestCtx = 'Test service context from client';
var
  ctx: ContextData;
begin
  (*
   * what you can do here:
   * - set the service context list for the request
   * - modify the in/inout parameters of the request
   * - piggyback extra values to the request
   * - change the target object reference
   * - change the operation name
   * - answer the request yourself by filling in out parameters
   *   or raising an exception (using env parameter) and returning
   *   INVOKE_ABORT
   *)
  WriteLn('client: init request for: ' + req.operation);
  SetLength(ctx, Length(cTestCtx));
  move(cTestCtx, Pointer(ctx)^, Length(cTestCtx));
  req.set_service_context(100, 0, ctx);
  result := INVOKE_CONTINUE;
end;

function TTestClient.input_message(const buf: IBuffer;
  const env: IEnvironment): TStatus;
var
  i: integer;
begin
  (*
   * what you can do here:
   * - abort the request with an exception
   * - change (decompress, decrypt, ...) the incoming message:
   *   'buf' contains the GIOP Reply message header and
   *   results between buf->rpos() and buf->wpos(). You must
   *   not change buf->rpos() and the data contained in 'buf'
   *   before buf->rpos(). You can change buf->wpos() and the
   *   data between buf->rpos() and buf->wpos().
   *)
  WriteLn('client: input message (' + IntToStr(buf.WPosition - buf.RPosition) + ' bytes)');
  // simple decryption
  for i := buf.RPosition to buf.WPosition - 1 do
    PByteArray(buf._buffer)^[i] := PByteArray(buf._buffer)^[i] xor $37;
  result := INVOKE_CONTINUE;
end;

function TTestClient.output_message(const buf: IBuffer;
  const env: IEnvironment): TStatus;
var
  i: integer;
begin
  (*
   * what you can do here:
   * - abort the request with an exception
   * - change (compress, encrypt, ...) the outgoing message:
   *   'buf' contains the GIOP Request message header and
   *   params between buf->rpos() and buf->wpos(). You must
   *   not change buf->rpos() and the data contained in 'buf'
   *   before buf->rpos(). You can change buf->wpos() and the
   *   data between buf->rpos() and buf->wpos().
   *)
  WriteLn('client: output message (' + IntToStr(buf.WPosition - buf.RPosition) + ' bytes)');
  // simple encryption
  for i := buf.RPosition to buf.WPosition - 1 do
    PByteArray(buf._buffer)^[i] := PByteArray(buf._buffer)^[i] xor $37;
  result := INVOKE_CONTINUE;
end;

begin
  // Insert user code here
  mainproc;
end.
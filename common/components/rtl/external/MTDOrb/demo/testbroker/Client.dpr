program Client;
{$APPTYPE CONSOLE}
uses
{$IFDEF WIN32}
  Windows,
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
  mtdebug,
  TestImpl,
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

  TORBThread = class(TThread)
  protected
    procedure Execute; override;
  end;

var
  dorb: IORB;
  factory: ITestIntfFactory;
  prm: TStrings;
  callbackIntf: ITestIntf;
  rootPOA: IPOA;

function CreateCallback: ITestIntf;
var
  obj: TTestIntf_impl;
begin
  if callbackIntf = nil then begin
    obj := TTestIntf_impl.Create;
    callbackIntf := obj._this();
  end;
  Result := callbackIntf;
end;

procedure RunTestIntf(const ATest: ITestIntf);
var
  i: Integer;
  shortValIn, shortValInOut, shortValOut, shortValResult: short;
  longValIn, longValInOut, longValOut, longValResult: long;
  ushortValIn, ushortValInOut, ushortValOut, ushortValResult: _ushort;
  ulongValIn, ulongValInOut, ulongValOut, ulongValResult: _ulong;
  floatValIn, floatValInOut, floatValOut, floatValResult: float;
  doubleValIn, doubleValInOut, doubleValOut, doubleValResult: double;
  booleanValIn, booleanValInOut, booleanValOut, booleanValResult: boolean;
  charValIn, charValInOut, charValOut, charValResult: AnsiChar;
  octetValIn, octetValInOut, octetValOut, octetValResult: octet;
  stringValIn, stringValInOut, stringValOut, stringValResult: AnsiString;
  longlongValIn, longlongValInOut, longlongValOut, longlongValResult: longlong;
  ulonglongValIn, ulonglongValInOut, ulonglongValOut, ulonglongValResult: _ulonglong;
  //wcharValIn, wcharValInOut, wcharValOut, wcharValResult: widechar;
  //wstringValIn, wstringValInOut, wstringValOut, wstringValResult: widestring;
  octetSeqValIn, octetSeqValInOut, octetSeqValOut, octetSeqValResult: TTestOctetSeq;
  structValIn, structValInOut, structValOut, structValResult: TTestStruct;
  objValIn, objValInOut, objValOut, objValResult: ITestIntf;
  {shortValIn, shortValInOut, shortValOut, shortValResult: short;}
begin
  shortValIn := Trunc(Random(High(short)));
  shortValInOut := shortValIn;
  shortValResult := ATest.check_short(shortValIn, shortValInOut, shortValOut);
  if shortValIn <> shortValResult then
    MTDORBLogger.Error('Mismatch short value.');
  longValIn := Trunc(Random(High(long)));
  longValInOut := longValIn;
  longValResult := ATest.check_long(longValIn, longValInOut, longValOut);
  if longValIn <> longValResult then
    MTDORBLogger.Error('Mismatch long value.');
  ushortValIn := Trunc(Random(High(_ushort)));
  ushortValInOut := ushortValIn;
  ushortValResult := ATest.check_unsigned_short(ushortValIn, ushortValInOut, ushortValOut);
  if ushortValIn <> ushortValResult then
    MTDORBLogger.Error('Mismatch unsigned short value.');
  ulongValIn := Trunc(Random(High(_ulong)));
  ulongValInOut := ulongValIn;
  ulongValResult := ATest.check_unsigned_long(ulongValIn, ulongValInOut, ulongValOut);
  if ulongValIn <> ulongValResult then
    MTDORBLogger.Error('Mismatch unsigned long value.');
  floatValIn := Random;
  floatValInOut := floatValIn;
  floatValResult := ATest.check_float(floatValIn, floatValInOut, floatValOut);
  if floatValIn <> floatValResult then
    MTDORBLogger.Error('Mismatch float value.');
  doubleValIn := Random;
  doubleValInOut := doubleValIn;
  doubleValResult := ATest.check_double(doubleValIn, doubleValInOut, doubleValOut);
  if doubleValIn <> doubleValResult then
    MTDORBLogger.Error('Mismatch double value.');
  booleanValIn := Boolean(Trunc(Random(Ord(High(boolean)))));
  booleanValInOut := booleanValIn;
  booleanValResult := ATest.check_boolean(booleanValIn, booleanValInOut, booleanValOut);
  if booleanValIn <> booleanValResult then
    MTDORBLogger.Error('Mismatch boolean value.');
  charValIn := AnsiChar(Trunc(Random(Ord(High(AnsiChar)))));
  charValInOut := charValIn;
  charValResult := ATest.check_char(charValIn, charValInOut, charValOut);
  if charValIn <> charValResult then
    MTDORBLogger.Error('Mismatch char value.');
  octetValIn := octet(Trunc(Random(Ord(High(octet)))));
  octetValInOut := octetValIn;
  octetValResult := ATest.check_octet(octetValIn, octetValInOut, octetValOut);
  if octetValIn <> octetValResult then
    MTDORBLogger.Error('Mismatch octet value.');
  stringValIn := AnsiString(Format('TestString%d', [Trunc(Random(High(Integer)))]));
  stringValInOut := stringValIn;
  stringValResult := ATest.check_string(stringValIn, stringValInOut, stringValOut);
  if stringValIn <> stringValResult then
    MTDORBLogger.Error('Mismatch string value.');
  longlongValIn := Trunc(Random(High(longlong)));
  longlongValInOut := longlongValIn;
  longlongValResult := ATest.check_longlong(longlongValIn, longlongValInOut, longlongValOut);
  if longlongValIn <> longlongValResult then
    MTDORBLogger.Error('Mismatch longlong value.');
  ulonglongValIn := Trunc(Random(High(_ulonglong)));
  ulonglongValInOut := ulonglongValIn;
  ulonglongValResult := ATest.check_unsigned_longlong(ulonglongValIn, ulonglongValInOut, ulonglongValOut);
  if ulonglongValIn <> ulonglongValResult then
    MTDORBLogger.Error('Mismatch unsigned longlong value.');
  {wcharValIn := wchar(Trunc(Random(Ord(High(widechar)))));
  wcharValInOut := wcharValIn;
  wcharValResult := ATest.check_wchar(wcharValIn, wcharValInOut, wcharValOut);
  if wcharValIn <> wcharValResult then
    MTDORBLogger.Error('Mismatch wide char value.');
  {wstringValIn := Format('TestWideString%d', [Trunc(Random(High(Integer)))]);
  wstringValResult := ATest.check_wstring(wstringValIn, wstringValInOut, wstringValOut);
  if wstringValIn <> wstringValResult then
    MTDORBLogger.Error('Mismatch wide string value.');}
  SetLength(octetSeqValIn, 1024{*1024*5});
  for i := 0 to Length(octetSeqValIn) - 1 do
    octetSeqValIn[i] := octet(Trunc(Random(Ord(High(octet)))));
  octetSeqValInOut := Copy(octetSeqValIn, 0, Length(octetSeqValIn));
  octetSeqValResult := ATest.check_octet_seq(octetSeqValIn, octetSeqValInOut, octetSeqValOut);
  if not CompareMem(octetSeqValIn, octetSeqValResult, Length(octetSeqValInOut)) then
    MTDORBLogger.Error('Mismatch octet sequence value.');
  structValIn.value_long := Trunc(Random(High(long)));
  structValIn.value_string := AnsiString(Format('TestStruct%d', [structValIn.value_long]));
  structValInOut := structValIn;
  structValResult := ATest.check_struct(structValIn, structValInOut, structValOut);
  if (structValIn.value_long <> structValResult.value_long) or (structValIn.value_string <> structValResult.value_string) then
    MTDORBLogger.Error('Mismatch struct value.');
  try
    ATest.check_exception(stringValIn);
  except
    on E: TTestException do begin
      if stringValIn <> E.message then
        MTDORBLogger.Error('Mismatch exception message.');
    end;
  end; { try/except }
  objValIn := CreateCallback;
  objValResult := ATest.check_obj(objValIn, objValInOut, objValOut);
end;

procedure WriteInfo(const ACreatePass, APass: Integer);
begin
  Write(#13);
  Write('                                                             ');
  Write(#13);
  Write(Format('Create pass: %d. Test pass: %d.', [ACreatePass, APass]));
end;

procedure RunTest;
var
  idx, i, j, createPassCount, testPassCount: Integer;
  testIntf: ITestIntf;
begin
  idx := prm.IndexOf('CREATE_PASS');
  if idx <> -1 then
    createPassCount := StrToInt(prm[idx + 1])
  else
    createPassCount := 2;
  idx := prm.IndexOf('TEST_PASS');
  if idx <> -1 then
    testPassCount := StrToInt(prm[idx + 1])
  else
    testPassCount := 3;
  WriteLn;
  for i := 1 to createPassCount do begin
    try
      testIntf := factory.create_test_intf();
      for j := 1 to testPassCount do begin
        try
          WriteInfo(i, j);
          RunTestIntf(testIntf);
        except
          on E: Exception do
            MTDORBLogger.Error(AnsiString(E.Message));
        end; { try/except }
      end;
      testIntf.deactivate();
    except
      on E: Exception do begin
        MTDORBLogger.Error(AnsiString(E.Message));
        WriteLn(E.Message);
      end;
    end; { try/except }
  end;
end;

procedure mainproc;
var
  obj: IORBObject;
  clientIntr: IClientInterceptor;
  fl : TStream;
  ref: AnsiString;
  i: Integer;
  th: TORBThread;
begin
  clientIntr := TTestClient.Create;
  clientIntr.activate(0);
  prm := TStringList.Create;
  try
    for i := 1 to ParamCount do
      prm.Add(ParamStr(i));
    prm.Add('-ORBInfoLogger');
    prm.Add('client_info_log');
    prm.Add('-ORBErrorLogger');
    prm.Add('client_error_log');
    prm.Add('-ORBDebugLevel');
    prm.Add('Info');
    prm.Add('-ORBDebugLevel');
    prm.Add('Error');
    dorb := ORB_Init(prm);

    obj := dorb.resolve_initial_reference('RootPOA');
    rootPOA := POA_narrow(obj);
    rootPOA.the_POAManager.activate();


    fl := TFileStream.Create('server.objid', fmOpenRead);
    fl.Position := 0;
    SetLength(ref, fl.Size);
    fl.ReadBuffer(Pointer(ref)^, fl.Size);
    fl.free;

    obj := dorb.string_to_object(ref);
    factory := TTestIntfFactory._narrow(obj);

    th := TORBThread.Create(True);
    th.FreeOnTerminate := True;
    th.Resume;

    WriteLn('Begin test');
    RunTest;
    WriteLn('Test completed. Press Enter for exit.');
    //ReadLn;
    clientIntr.deactivate();
    dorb.shutdown(true);
    dorb._destroy();
    dorb := nil;
  finally
    prm.Free;
  end; { try/finally }
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
  MTDORBLogger.Info('client: after marshal for: ' + req.operation);
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
  MTDORBLogger.Info('client: before unmarshal for: ' + req.operation);
  result := INVOKE_CONTINUE;
end;

function TTestClient.finish_request(const req: ILWRequest;
  const env: IEnvironment): TStatus;
var
  ctx: ContextData;
  //str: string;
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
  (*MTDORBLogger.Info('client: finish request for: ' + req.operation);
  ctx := req.get_service_context(100, 0);
  SetLength(str, Length(ctx));
  move(Pointer(ctx)^, Pointer(str)^, Length(ctx));
  MTDORBLogger.Info(str);*)
  ctx := nil;
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
  MTDORBLogger.Info('client: init request for: ' + req.operation);
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
  MTDORBLogger.Info('client: input message (' + AnsiString(IntToStr(buf.WPosition - buf.RPosition)) + ' bytes)');
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
  MTDORBLogger.Info('client: output message (' + AnsiString(IntToStr(buf.WPosition - buf.RPosition)) + ' bytes)');
  // simple encryption
  for i := buf.RPosition to buf.WPosition - 1 do
    PByteArray(buf._buffer)^[i] := PByteArray(buf._buffer)^[i] xor $37;
  result := INVOKE_CONTINUE;
end;

{ TORBThread }

procedure TORBThread.Execute;
begin
  dorb.run;
end;

begin
  Randomize;
  mainproc;
end.
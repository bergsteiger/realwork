unit SRILoggerImpl;

interface

uses pi, pi_int, orbtypes;

type
  TSRILoggerImpl = class(TServerRequestInterceptor)
  private
    FCDRCodec: ICodec;
    FSlotId: TSlotId;
    function Level(ri: IServerRequestInfo): Integer;
    procedure DisplayServerRequestInfo(ri: IServerRequestInfo; level: short);
  protected
    procedure _destroy; override;
    function _get_name: AnsiString; override;
    procedure receive_request_service_contexts(const ri: IServerRequestInfo); override;
    procedure receive_request(const ri: IServerRequestInfo); override;
    procedure send_reply(const ri: IServerRequestInfo); override;
    procedure send_exception(const ri: IServerRequestInfo); override;
    procedure send_other(const ri: IServerRequestInfo); override;
  public
    constructor Create(const info: IORBInitInfo; const slotId: TSlotId);
  end;

implementation

uses LoggerPolicy_int, LoggerPolicy, orb_int, Callstack_int, pi_impl, RILogger,
  code_int, any, std_seq, tcode, static, exceptions, SysUtils;

{ TSRILoggerImpl }

constructor TSRILoggerImpl.Create(const info: IORBInitInfo; const slotId: TSlotId);
var
  factory: ICodecFactory;
  how: pi_int.TEncoding;
begin
  FSlotId := slotId;
  //
  // Get the codec factory
  //
  factory := info.codec_factory;
  Assert(factory <> nil);

  //
  // Create codec
  //
  how.major_version := 1;
  how.minor_version := 0;
  how.format := ENCODING_CDR_ENCAPS;

  try
    FCDRCodec := factory.create_codec(how);
  except
    on E: TUnknownEncoding do
      Assert(false);
  end;
  Assert(FCDRCodec <> nil);

  //
  // Get the dynamic any factory
  //
  (*DynamicAny::DynAnyFactory_var dynAnyFactory;
  try
  {
      CORBA::Object_var obj =
          info -> resolve_initial_references("DynAnyFactory");
      dynAnyFactory = DynamicAny::DynAnyFactory::_narrow(obj);
  }
  catch(const PortableInterceptor::ORBInitInfo::InvalidName&)
  {
      assert(false);
  }
  assert(!CORBA::is_nil(dynAnyFactory));

  //
  // Create the CORBA_OUT object for displaying the CORBA::Any
  //
  out_ = new CORBA_OUT(dynAnyFactory, cout);
  out_ -> down();*)
end;

procedure TSRILoggerImpl.DisplayServerRequestInfo(ri: IServerRequestInfo;
  level: short);
var
  exception: IAny;
  octets: OctetSeq;
  i: Integer;
  repoId: TRepositoryId;
begin
  octets := nil;
  DisplayRequestInfo(ri, level, FSlotId);
    //
    // Display sending exception
    //
    try
	exception := ri.sending_exception;

	Skip();
    	WriteLn('sending exception = ');
	Down();
	TCORBAOut.DisplayAny(exception);
	Up();
    except
      on E: BAD_INV_ORDER do ;
	// Operation not supported in this context
    end;

    if level > 2 then begin
	//
	// Display object id
	//
	try
            octets := ri.object_id;
	    Skip();
	    Write('object id = ');

            for i := 0 to Length(octets) - 1 do
                Write(GetOctet(octets[i]));
            WriteLn;
	except
          on E: BAD_INV_ORDER do ;
	    // Operation not supported in this context
	end;

	//
	// Display adapter id
	//
	try
	    octets := ri.adapter_id;

	    Skip();
	    Write('adapter id = ');

            for i := 0 to Length(octets) - 1 do
                Write(GetOctet(octets[i]));
            WriteLn;
	except
          on E: BAD_INV_ORDER do ;
	    // Operation not supported in this context
	end;
    end;

    //
    // Display target most derived interface
    //
    try
      repoId := ri.target_most_derived_interface;
	Skip();
    	WriteLn('target most derived interface = ', repoId);
    except
      on E: BAD_INV_ORDER do ;
        // Operation not supported in this context
    end;
end;

function TSRILoggerImpl.Level(ri: IServerRequestInfo): Integer;
var
  p: IPolicy;
  loggerPolicy: ILoggerPolicy;
begin
  Result := 0;
  try
    //
    // Get the logger policy
    //
    p := ri.get_server_policy(LOGGER_POLICY_ID);
    loggerPolicy := TLoggerPolicy._narrow(p);
    if loggerPolicy <> nil then
      Result := loggerPolicy.level;
  except

  end; { try/except }
end;

procedure TSRILoggerImpl.receive_request(const ri: IServerRequestInfo);
var
  l: short;
begin
  l := Level(ri);
  if (l > 0) then begin
    WriteLn('receive request:');
    DisplayServerRequestInfo(ri, l);
    WriteLn;
  end;
end;

procedure TSRILoggerImpl.receive_request_service_contexts(
  const ri: IServerRequestInfo);
var
  l: short;
  callStack: TCallStack;
  sc: ServiceContext;
  a: IAny;
  data: OctetSeq;
  stack: TCallstack;
  i: Integer;
begin
  l := level(ri);
  if (l > 0) then begin
    WriteLn('receive request service contexts:');
    DisplayServerRequestInfo(ri, l);
    WriteLn;

    //
    // Get CallStack from service context
    //
    try
      //
      // Get encoded CallStack from service context
      //
      sc := ri.get_request_service_context(REQUEST_CONTEXT_ID);

      //
      // Decode CallStack
      //
      a := CreateAny;
      SetLength(data, Length(sc.context_data));
      Move(Pointer(sc.context_data)^, Pointer(data)^, Length(data));
      try
        a := FCDRCodec.decode_value(data, stat_seq_string.typecode);
      except
        on E: TTypeMismatch do
          //
          // Ignore failure in this demo
          //
          Exit;
        on E: TFormatMismatch do
          //
          // Ignore failure in this demo
          //
          Exit;
      end;

      if not a.to_static_any(StaticAny(stat_seq_string, @stack)) then
        //
        // Ignore failure in this demo
        //
        Exit;
      Assert(stack <> nil);

      //
      // Set length of new CallStack to the length of
      // the old CallStack, plus one for the new call
      //
      SetLength(callStack, Length(stack) + 1);

      //
      // Copy old CallStack to new CallStack
      //
      for i := 0 to Length(stack) do
        callStack[i] := stack[i];
    except
      on E: BAD_PARAM do
        //
        // Service context was not previously set -- set length
        // of the new CallStack to one for the new call
        //
        SetLength(callStack, 1);
    end;

    //
    // Add new call to the CallStack
    //
    callStack[Length(callStack) - 1] := ri.operation;

    //
    // Save the new CallStack in slot
    //
    a := CreateAny();
    a.from_static_any(StaticAny(stat_seq_string, @callStack));
    try
        ri.set_slot(FSlotId, a);
    except
      on E: TInvalidSlot do
        //
        // Ignore failure in this demo
        //
        Exit;
    end;

    //
    // Print the CallStack
    //
    WriteLn('stack =');
    for i := 0 to Length(callstack) - 1 do
      WriteLn(Format('%d. %s', [i + 1, callStack[i]]));
    WriteLn;
  end;
end;

procedure TSRILoggerImpl.send_exception(const ri: IServerRequestInfo);
var
  l: short;
begin
  l := Level(ri);
  if (l > 0) then begin
    WriteLn('send exception:');
    DisplayServerRequestInfo(ri, l);
    WriteLn;
  end;
end;

procedure TSRILoggerImpl.send_other(const ri: IServerRequestInfo);
var
  l: short;
begin
  l := Level(ri);
  if (l > 0) then begin
    WriteLn('send other:');
    DisplayServerRequestInfo(ri, l);
    WriteLn;
  end;
end;

procedure TSRILoggerImpl.send_reply(const ri: IServerRequestInfo);
var
  l: short;
begin
  l := Level(ri);
  if (l > 0) then begin
    WriteLn('send reply:');
    DisplayServerRequestInfo(ri, l);
    WriteLn;
  end;
end;

procedure TSRILoggerImpl._destroy;
begin
end;

function TSRILoggerImpl._get_name: AnsiString;
begin
  Result := 'SRILogger';
end;

end.

unit CRILoggerImpl;

interface

uses pi, pi_int, orbtypes;

type
  TCRILoggerImpl = class(TClientRequestInterceptor)
  private
    FCDRCodec: ICodec;
    FSlotId: TSlotId;
    function Level(ri: IClientRequestInfo): Integer;
    procedure DisplayClientRequestInfo(ri: IClientRequestInfo; level: short);
  protected
    procedure _destroy; override;
    function _get_name: AnsiString; override;
    procedure send_request(const ri: IClientRequestInfo); override;
    procedure send_poll(const ri: IClientRequestInfo); override;
    procedure receive_reply(const ri: IClientRequestInfo); override;
    procedure receive_exception(const ri: IClientRequestInfo); override;
    procedure receive_other(const ri: IClientRequestInfo); override;
  public
    constructor Create(const info: IORBInitInfo; const slotId: TSlotId);
  end;

implementation

uses LoggerPolicy_int, LoggerPolicy, orb_int, Callstack_int, pi_impl, RILogger,
  code_int, any, std_seq, tcode, static, exceptions, SysUtils;

{ TCRILoggerImpl }

constructor TCRILoggerImpl.Create(const info: IORBInitInfo;
  const slotId: TSlotId);
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

procedure TCRILoggerImpl.DisplayClientRequestInfo(ri: IClientRequestInfo;
  level: short);
var
  exception: IAny;
  i: Integer;
  profile: TTaggedProfile;
  repoId: TRepositoryId;
begin
  DisplayRequestInfo(ri, level, FSlotId);
  if level > 2 then begin
    //
    // Display effective profile
    //
    profile := ri.effective_profile;

    Skip();
    Write('effective profile = ');
    if (profile.tag = TAG_INTERNET_IOP) then
        Write('TAG_INTERNET_IOP')
    else if (profile.tag = TAG_MULTIPLE_COMPONENTS) then
        Write('TAG_MULTIPLE_COMPONENTS')
    else
        Write('UNKNOWN_TAG');
    Write(': ');

    for i := 0 to Length(profile.profile_data) do
        Write(GetOctet(profile.profile_data[i]));
    WriteLn;
  end;

  //
  // Display received exception
  //
  try
      exception := ri.received_exception;

      Skip();
      WriteLn('received exception = ');
      Down();
      TCORBAOut.DisplayAny(exception);
      Up();
  except
    on E: BAD_INV_ORDER do ;
      // Operation not supported in this context
  end;

  //
  // Display received exception id
  //
  try
    repoId := ri.received_exception_id;
    Skip();
    WriteLn('received exception id = ', repoId);
  except
    on E: BAD_INV_ORDER do ;
      // Operation not supported in this context
  end;
end;

function TCRILoggerImpl.Level(ri: IClientRequestInfo): Integer;
var
  p: IPolicy;
  loggerPolicy: ILoggerPolicy;
begin
  Result := 0;
  try
    //
    // Get the logger policy
    //
    p := ri.get_request_policy(LOGGER_POLICY_ID);
    loggerPolicy := TLoggerPolicy._narrow(p);
    if loggerPolicy <> nil then
      Result := loggerPolicy.level;
  except
    on E: INV_POLICY do ;
  end; { try/except }
end;

procedure TCRILoggerImpl.receive_exception(const ri: IClientRequestInfo);
var
  l: short;
begin
  l := Level(ri);
  if (l > 0) then begin
    WriteLn('receive exception:');
    DisplayClientRequestInfo(ri, l);
    WriteLn;
  end;
end;

procedure TCRILoggerImpl.receive_other(const ri: IClientRequestInfo);
var
  l: short;
begin
  l := Level(ri);
  if (l > 0) then begin
    WriteLn('receive other:');
    DisplayClientRequestInfo(ri, l);
    WriteLn;
  end;
end;

procedure TCRILoggerImpl.receive_reply(const ri: IClientRequestInfo);
var
  l: short;
begin
  l := Level(ri);
  if (l > 0) then begin
    WriteLn('receive reply:');
    DisplayClientRequestInfo(ri, l);
    WriteLn;
  end;
end;

procedure TCRILoggerImpl.send_poll(const ri: IClientRequestInfo);
var
  l: short;
begin
  l := Level(ri);
  if (l > 0) then begin
    WriteLn('send poll:');
    DisplayClientRequestInfo(ri, l);
    WriteLn;
  end;
end;

procedure TCRILoggerImpl.send_request(const ri: IClientRequestInfo);
var
  l: short;
  a: IAny;
  tc: ITypeCode;
  data: OctetSeq;
  sc: ServiceContext;
begin
  data := nil;
  l := Level(ri);
  if (l > 0) then begin
    //
    // Try to get the CallStack from slot
    //
    try
      a := ri.get_slot(FSlotId);
      tc := a.get_type();
      if (tc.kind() <> tk_null) and (tc.kind() <> tk_void) then begin
        //
        // Encode CallStack
        //
        data := FCDRCodec.encode_value(a);

        //
        // Add encoded CallStack to service context
        //
        sc.context_id := REQUEST_CONTEXT_ID;
        SetLength(sc.context_data, Length(data));
        Move(Pointer(sc.context_data)^, Pointer(data)^, Length(data));
        ri.add_request_service_context(sc, false);
      end;
    except
      on E: TInvalidSlot do ;
        // Ignore failure in this demo
      on E: TInvalidTypeForEncoding do ;
        // Ignore failure in this demo
    end;
    WriteLn('send request:');
    DisplayClientRequestInfo(ri, l);
    WriteLn;
  end;
end;

procedure TCRILoggerImpl._destroy;
begin

end;

function TCRILoggerImpl._get_name: AnsiString;
begin
  Result := 'CRILogger';
end;

end.

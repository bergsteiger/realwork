program Server;
{$APPTYPE CONSOLE}
uses
{$IFDEF MSWINDOWS}
  Windows,
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
  orbtypes,
  poa_except,
  exceptions,
  any,
  policy_int,
  policy,
  LoggerPolicy_int,
  PIDemo_int,
  PIDemo,
  PIImpl in 'PIImpl.pas',
  SRILoggerImpl in 'SRILoggerImpl.pas',
  RILogger in 'RILogger.pas',
  CRILoggerImpl in 'CRILoggerImpl.pas';

type
  TPIDemoLocator = class(TServantLocator)
  private
    // The PIDemo static implementation
    FPIDemoImpl: IServant;
    // The PIDemo dynamic implementation
    FPIDemoDSIImpl: IServant;
  protected
    function preinvoke(oid: ObjectID; adapter: IPOA; operation : Identifier;
      the_cookie: Cookie): IServant; override;
    procedure postinvoke(oid: ObjectID; adapter: IPOA; operation : Identifier;
      the_cookie: Cookie; servant: IServant); override;
  public
    constructor Create(pi_impl, dsi_pi_impl: IServant);
  end;

var
  dorb : IORB;
  rootPOA: IPOA;

procedure run;
var
  policies: PolicyList;
  a: IAny;
  logLevel: Integer;
  persistentPOA, p1: IPOA;
  piDemoImpl: TPIDemo_impl;
  piDemoDSIImpl: TPIDemoDSI_impl;
  obj: IORBObject;
  piDemo, piDemoDSI: IPIDemo;
  fl : TStream;
  ref: AnsiString;
begin
  logLevel := 1;

  SetLength(policies, 6);

  a := LifespanPolicyValue_to_any(PERSISTENT);
  policies[0] := dorb.create_policy(LIFESPAN_POLICY_ID, a);

  a := IdAssignmentPolicyValue_to_any(USER_ID);
  policies[1] := dorb.create_policy(ID_ASSIGNMENT_POLICY_ID, a);

  a := RequestProcessingPolicyValue_to_any(USE_SERVANT_MANAGER);
  policies[2] := dorb.create_policy(REQUEST_PROCESSING_POLICY_ID, a);

  a := ServantRetentionPolicyValue_to_any(NON_RETAIN);
  policies[3] := dorb.create_policy(SERVANT_RETENTION_POLICY_ID, a);

  a := ImplicitActivationPolicyValue_to_any(NO_IMPLICIT_ACTIVATION);
  policies[4] := dorb.create_policy(IMPLICIT_ACTIVATION_POLICY_ID, a);

  a := CreateAny();
  a.put_short(logLevel);
  policies[5] := dorb.create_policy(LOGGER_POLICY_ID, a);

  persistentPOA := rootPOA.create_POA('persistent', rootPOA.the_POAManager, policies);
  p1 := rootPOA.create_POA('p1', rootPOA.the_POAManager, policies);

  //
  // Create implementation objects
  //
  piDemoImpl := TPIDemo_impl.Create;//(dorb, persistentPOA);
  //piDemoServant := piDemoImpl;
  piDemoDSIImpl := TPIDemoDSI_impl.Create;//(orb, persistentPOA);
  //piDemoDSIServant := piDemoDSIImpl;

  //
  // Create the servant locator and register it with the POA
  //
  persistentPOA.set_servant_manager(TPIDemoLocator.Create(piDemoImpl, piDemoDSIImpl));

  //
  // The PIDemo::call_other_impl method results in calls between
  // the two implementations.  Hence, the servers are also clients.
  // Create policy to enable client logging.
  //
  SetLength(policies, 1);
  a := CreateAny();
  a.put_short(logLevel);
  policies[0] := dorb.create_policy(LOGGER_POLICY_ID, a);

  //
  // Get the object references (with the logging policy) for each
  // implementation
  //
  obj := persistentPOA.create_reference_with_id('PIDemo', 'IDL:PIDemo:1.0');
  obj := obj.set_policy_overrides(policies, ADD_OVERRIDE);
  piDemo := TPIDemo._narrow(obj);
  obj := persistentPOA.create_reference_with_id('PIDemoDSI', 'IDL:PIDemo:1.0');
  obj := obj.set_policy_overrides(policies, ADD_OVERRIDE);
  piDemoDSI := TPIDemo._narrow(obj);
  Assert(piDemo <> nil);
  Assert(piDemoDSI <> nil);

  //
  // Pass each implementation the other's corresponding object reference
  //
  piDemoImpl.SetOtherObj(piDemoDSI);
  piDemoDSIImpl.SetOtherObj(piDemo);

    //
    // Write IOR of first object to file
    //
  fl := TFileStream.Create('PIDemo.ref', fmCreate or fmShareDenyWrite);
  ref := dorb.object_to_string(piDemo as IORBObject);
  fl.WriteBuffer(Pointer(ref)^, Length(ref));
  fl.free;

  //
  // Run implementation
  //
  persistentPOA.the_POAManager.activate;
  dorb.run;
end;

procedure mainproc;
var
  obj: IORBObject;
  mgr: IPOAManager;
  prm: TStrings;
  i: Integer;
begin
  //
  // Initialize the request interceptors
  //
  TRIORBInitializerImpl.Init();

  prm := TStringList.Create;
  try
    for i := 1 to ParamCount do
      prm.Add(ParamStr(i));
    dorb := ORB_Init(prm);
  finally
    prm.Free;
  end; { try/finally }

  //Obtain a reference to the RootPOA and its Manager
  obj := dorb.resolve_initial_reference('RootPOA');
  rootPOA := POA_narrow(obj);
  mgr := rootPOA.the_POAManager;

  run;

  dorb._destroy();
  dorb := nil;
end;

{ TPIDemoLocator }

constructor TPIDemoLocator.Create(pi_impl, dsi_pi_impl: IServant);
begin
  inherited Create();
  FPIDemoImpl := pi_impl;
  FPIDemoDSIImpl := dsi_pi_impl;
end;

procedure TPIDemoLocator.postinvoke(oid: ObjectID; adapter: IPOA;
  operation: Identifier; the_cookie: Cookie; servant: IServant);
begin
  // Nothing to do here
end;

function TPIDemoLocator.preinvoke(oid: ObjectID; adapter: IPOA;
  operation: Identifier; the_cookie: Cookie): IServant;
var
  obj: IORBObject;
begin
  if 'PIDemo' = oid then begin
    //
    // Request for the static implementation
    //

    if operation = 'switch_to_dynamic_impl' then begin
      //
      // switch_to_dynamic_impl() was called -- throw
      // LOCATION_FORWARD with the object associated with
      // dynamic implementation
      //

      obj := adapter.create_reference_with_id('PIDemoDSI', 'IDL:PIDemo:1.0');

      raise ForwardRequest.Create(obj);
    end;

    result := FPIDemoImpl;
  end
  else if 'PIDemoDSI' = oid then begin
    //
    // Request for the dynamic implementation
    //

    if operation = 'switch_to_static_impl' then begin
      //
      // switch_to_static_impl() was called -- throw
      // LOCATION_FORWARD with the object associated with
      // static implementation
      //

      obj := adapter.create_reference_with_id('PIDemo', 'IDL:PIDemo:1.0');

      raise ForwardRequest.Create(obj);
    end;

    result := FPIDemoDSIImpl;
  end
  else begin
    //
    // Unknown object id -- throw OBJECT_NOT_EXIST
    //
    raise OBJECT_NOT_EXIST.Create();
  end;
end;

begin
  try
    mainproc;
  except
    on E: Exception do begin
      WriteLn(E.Message);
      ReadLn;
    end;
  end; { try/except }
end.

unit PIImpl;

interface

uses orbtypes, orb, exceptions, PIDemo_int, PIDemo, LoggerPolicy_int, LoggerPolicy,
  pi, code_int, orb_int, policy_int, poa, poa_int, req_int;

type
  TPIDemo_impl = class(TPIDemo_serv)
  private
    FOtherObj: IPIDemo;
  protected
    procedure noargs; override;
    procedure noargs_oneway; override;
    function noargs_return: AnsiString; override;
    procedure withargs(const param1: AnsiString; var param2: AnsiString; out param3: AnsiString); override;
    procedure systemexception; override;
    procedure userexception; override;
    procedure switch_to_static_impl; override;
    procedure switch_to_dynamic_impl; override;
    procedure call_other_impl(const level: short); override;
    procedure deactivate; override;
  public
    //constructor Create();
    procedure SetOtherObj(AObj: IPIDemo);
  end;

  TPIDemoDSI_impl = class(TPOADynamicImplementation)
  private
    FOtherObj: IPIDemo;
  protected
    function _primary_interface(const objid: ObjectID; const poa: IPOA): AnsiString; override;
    function _is_a(const repoid: RepositoryID): Boolean; override;
    procedure invoke(const req: IServerRequest); override;
  public
    procedure SetOtherObj(AObj: IPIDemo);
  end;

  TLoggerPolicyImpl = class(TLoggerPolicy)
  private
    FLevel: short;
  protected
    function _get_level: short; override;
  public
    constructor CreateLoggerPolicy(level: short);
  end;

  TLoggerPolicyFactory = class(TPolicyFactory)
  protected
    function create_policy(const _type: TPolicyType; const value: IAny): IPolicy; override;
  end;

implementation

uses policy, env_int, any, tcode, except_int;

{ TPIDemo_impl }

procedure TPIDemo_impl.call_other_impl(const level: short);
begin
  if (FOtherObj <> nil) and (level > 0) then
    FOtherObj.call_other_impl(Pred(level));
end;

procedure TPIDemo_impl.deactivate;
begin
  ORB_Instance.shutdown(false);
end;

procedure TPIDemo_impl.noargs;
begin

end;

procedure TPIDemo_impl.noargs_oneway;
begin
  writeln('noargs_oneway');
end;

function TPIDemo_impl.noargs_return: AnsiString;
begin
  Result := 'PIDemo';
end;

procedure TPIDemo_impl.SetOtherObj(AObj: IPIDemo);
begin
  FOtherObj := AObj;
end;

procedure TPIDemo_impl.switch_to_dynamic_impl;
begin

end;

procedure TPIDemo_impl.switch_to_static_impl;
begin

end;

procedure TPIDemo_impl.systemexception;
begin
  raise NO_IMPLEMENT.Create();
end;

procedure TPIDemo_impl.userexception;
begin
  raise TPIDemo_User.Create;
end;

procedure TPIDemo_impl.withargs(const param1: AnsiString; var param2: AnsiString;
  out param3: AnsiString);
begin
  param2 := 'PIDemo';
  param3 := 'PIDemo';
end;

{ TLoggerPolicyImpl }

constructor TLoggerPolicyImpl.CreateLoggerPolicy(level: short);
begin
  inherited Create(LOGGER_POLICY_ID);
  FLevel := level;
end;

function TLoggerPolicyImpl._get_level: short;
begin
  Result := FLevel;
end;

{ TLoggerPolicyFactory }

function TLoggerPolicyFactory.create_policy(const _type: TPolicyType;
  const value: IAny): IPolicy;
var
  level: short;
begin
  if _type = LOGGER_POLICY_ID then begin
    if value.to_short(level) then begin
      Result := TLoggerPolicyImpl.CreateLoggerPolicy(level);
      Exit;
    end;
    raise TPolicyError.Create();
  end;
  raise TPolicyError.Create(BAD_POLICY);
end;

{ TPIDemoDSI_impl }

function TPIDemoDSI_impl._is_a(const repoid: RepositoryID): Boolean;
begin
  Result := repoid = 'IDL:PIDemo:1.0';
  if not Result then
    Result := inherited _is_a(repoid);
end;

function TPIDemoDSI_impl._primary_interface(const objid: ObjectID;
  const poa: IPOA): AnsiString;
begin
  Result := 'IDL:PIDemo:1.0';
end;

procedure TPIDemoDSI_impl.invoke(const req: IServerRequest);
var
  name: AnsiString;
  nvList: INVList;
  orb: IORB;
  res, any: IAny;
  //sysEx: ISystemException;
  level: short;
begin
  name := req.operation();
  orb := ORB_Instance();

  if name = 'noargs' then begin
    orb.create_list(0, nvList);
    req.arguments(nvList);
  end
  else if name = 'noargs_oneway' then begin
    orb.create_list(0, nvList);
    req.arguments(nvList);
  end
  else if name = 'noargs_return' then begin
    orb.create_list(0, nvList);
    req.arguments(nvList);

    res := CreateAny();
    res.put_string('PIDemoDSI');
    req.set_result(res);
  end
  else if name = 'withargs' then begin
    orb.create_list(0, nvList);

    nvList.add(ARG_IN).argument.replace(_tc_string, nil);
    nvList.add(ARG_INOUT).argument.replace(_tc_string, nil);
    nvList.add(ARG_OUT).argument.replace(_tc_string, nil);
    req.arguments(nvList);

    any := nvList.item(1).argument;
    any.put_string('PIDemoDSI');

    any := nvList.item(2).argument;
    any.put_string('PIDemoDSI');
  end
  else if name = 'systemexception' then begin
    orb.create_list(0, nvList);
    req.arguments(nvList);

    {sysEx := NO_IMPLEMENT.Create();
    res := CreateAny();
    sysEx.encode_any(res);}
    req.set_exception(NO_IMPLEMENT.Create());
  end
  else if name = 'userexception' then begin
    orb.create_list(0, nvList);
    req.arguments(nvList);

    //res := PIDemo_User_to_any(TPIDemo_User.Create());
    //result <<= PIDemo::User();
    req.set_exception(TPIDemo_User.Create());
  end
  else if name = 'switch_to_static_impl' then begin
    orb.create_list(0, nvList);
    req.arguments(nvList);
  end
  else if name = 'switch_to_dynamic_impl' then begin
    orb.create_list(0, nvList);
    req.arguments(nvList);
  end
  else if name = 'call_other_impl' then begin
    orb.create_list(0, nvList);
    req.arguments(nvList);
    nvList.add(ARG_IN).argument.replace(_tc_short, nil);
    req.arguments(nvList);

    any := nvList.item(0).argument;
    if not any.to_short(level) then begin
      req.set_exception(BAD_PARAM.Create);
      Exit;
    end;

    if (FOtherObj <> nil) and (level > 0) then
      FOtherObj.call_other_impl(Pred(level));
  end
  else if name = 'deactivate' then begin
    orb.create_list(0, nvList);
    req.arguments(nvList);

    orb.shutdown(false);
  end
  else begin
    orb.create_list(0, nvList);
    req.arguments(nvList);

    req.set_exception(BAD_OPERATION.Create());
  end;
end;

procedure TPIDemoDSI_impl.SetOtherObj(AObj: IPIDemo);
begin
  FOtherObj := AObj;
end;

end.

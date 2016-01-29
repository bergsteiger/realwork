program Server;
{$APPTYPE CONSOLE}
uses
  SysUtils,
  Classes,
  orb_int,
  orb,
  poa_int,
  poa_impl,
  code_int,
  intercept,
  Intercept_int,
  env_int,
  exceptions,
  orbtypes,
  hello_int,
  bootmanager,
  bootmanager_int,
  hello;

type
  //
  // a simple access checker using interceptors
  //
  TAccessChecker = class(TServerInterceptor)
  protected
    function initialize_request(const req: ILWServerRequest; const env: IEnvironment): TStatus; override;
  end;

  THello_impl = class(THello_serv)
  protected
    procedure hello; override;
  end;

var
  dorb : IORB;
  accessChecker: IServerInterceptor;

procedure mainproc;
var
  obj: IORBObject;
  props: TStrings;
  i: integer;
  p: IPOA;
  bootManager: IBootManager;
  serv: IServant;
begin
  accessChecker := TAccessChecker.Create;
  accessChecker.activate(0);
  props := TStringList.Create;
  try
    for i := 1 to ParamCount do
      props.Add(ParamStr(i));
    dorb := ORB_Init(props);
  finally
    props.Free;
  end; { try/finally }
  obj := dorb.resolve_initial_reference('RootPOA');
  p := TPOA_impl._narrow(obj);
  serv := THello_impl.Create();
  p.activate_object(serv);
  //BootManager
  bootManager := TBootManager._narrow(dorb.resolve_initial_reference('BootManager'));
  if bootManager <> nil then
    bootManager.add_binding('Hello', p.servant_to_reference(serv));
  p.the_POAManager.activate;
  dorb.run();
end;

{ THello_impl }

procedure THello_impl.hello;
var
  obj: IORBObject;
  prCur: IPrincipalCurrent;
  pr: IPrincipal;
  a: IAny;
  str: AnsiString;
begin
  obj := dorb.resolve_initial_reference('PrincipalCurrent');
  prCur := TPrincipalCurrent._narrow(obj);
  pr := prCur.get_principal;

  a := pr.get_property('auth-method');
  a.get_string(str);
  WriteLn('authentication method: ', str);

  a := pr.get_property('peer-address');
  a.get_string(str);
  WriteLn('peer address: ', str);

  a := pr.get_property('ssl-cipher');
  a.get_string(str);
  WriteLn('cipher: ', str);

  a := pr.get_property('ssl-x509-issuer');
  a.get_string(str);
  WriteLn('ssl-x509-issuer: ', str);

  a := pr.get_property('ssl-x509-subject');
  a.get_string(str);
  WriteLn('ssl-x509-subject: ', str);

  // ... or, to get individual fields of X509 names:
  
  a := pr.get_property('ssl-x509-subject:CN');
  a.get_string(str);
  WriteLn('ssl-x509-subject:CN: ', str);

  a := pr.get_property('ssl-x509-subject:Email');
  a.get_string(str);
  WriteLn('ssl-x509-subject:Email: ', str);

  WriteLn('Hello world');
end;

{ TAccessChecker }

function TAccessChecker.initialize_request(const req: ILWServerRequest;
  const env: IEnvironment): TStatus;
var
  obj, probj: IORBObject;
  prCur: IPrincipalCurrent;
  pr: IPrincipal;
  a: IAny;
  name: AnsiString;
begin
  obj := req.get_target();

  probj := dorb.resolve_initial_reference('PrincipalCurrent');
  prCur := TPrincipalCurrent._narrow(probj);
  pr := prCur.get_principal;

  a := pr.get_property('ssl-x509-subject:CN');
  a.get_string(name);
  // try changing "Roemer" to some other name to verify that
  // the access check works ...
  if name <> 'Roemer' then begin
    // permission denied ...
    env.set_exception(SystemException.Create_type(st_NO_PERMISSION));
    result := INVOKE_ABORT;
  end
  else
    // ok ...
    result := INVOKE_CONTINUE;
end;

begin
  mainproc;
end.
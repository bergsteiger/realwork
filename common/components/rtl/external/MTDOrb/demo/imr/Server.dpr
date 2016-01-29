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
  bootmanager,
  bootmanager_int,
  policy_int,
  hello_int,
  hello;

type
  THello_impl = class(THello_serv)
  protected
    procedure hello; override;
  end;

var
  dorb : IORB;
  newpoa: IPOA;

procedure mainproc;
var
  obj: IORBObject;
  props: TStrings;
  i: integer;
  p: IPOA;
  serv: IServant;
  bootManager: IBootManager;
  lp: ILifespanPolicy;
  ap: IIdAssignmentPolicy;
  polList: PolicyList;
begin
  props := TStringList.Create;
  try
    for i := 1 to ParamCount do
      props.Add(ParamStr(i));
    dorb := ORB_Init(props);
  finally
    props.Free;
  end; { try/finally }

  //RootPOA
  obj := dorb.resolve_initial_reference('RootPOA');
  p := TPOA_impl._narrow(obj);

  SetLength(polList, 2);
  lp := p.create_lifespan_policy(PERSISTENT);
  ap := p.create_id_assignment_policy(USER_ID);
  polList[0] := lp;
  polList[1] := ap;

  //create new poa with policy
  newpoa := p.create_POA('ServerPOA', p.the_POAManager, polList);

  serv := THello_impl.Create() as IServant;
  newpoa.activate_object_with_id('ServerPOA', serv);

  //BootManager
  bootManager := TBootManager._narrow(dorb.resolve_initial_reference('BootManager'));
  if bootManager <> nil then
    bootManager.add_binding('Hello', p.servant_to_reference(serv));

  p.the_POAManager.activate;

  WriteLn('Server starting');
  dorb.run();
end;

{ THello_impl }

procedure THello_impl.hello;
begin
  WriteLn('Hello world');
end;

begin
  mainproc;
end.
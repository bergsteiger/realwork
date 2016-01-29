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
  hello_int,
  hello;

type
  THello_impl = class(THello_serv)
  protected
    procedure hello; override;
  end;

var
  dorb : IORB;

procedure mainproc;
var
  obj: IORBObject;
  props: TStrings;
  i: integer;
  p: IPOA;
  serv: IServant;
  bootManager: IBootManager;
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
  serv := THello_impl.Create() as IServant;
  p.activate_object_with_id('Hello', serv);

  //BootManager
  bootManager := TBootManager._narrow(dorb.resolve_initial_reference('BootManager'));
  if bootManager <> nil then
    bootManager.add_binding('Hello', p.servant_to_reference(serv));

  p.the_POAManager.activate;
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
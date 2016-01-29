program client;

{$APPTYPE CONSOLE}

uses
  SysUtils, Classes, bidir_impl, bidir, bidir_int, orb_int, poa_int, orb, poa_impl,
  policy_int, code_int, any;

type
  Tdemo_bidir_ClientCallback_impl = class(Tdemo_bidir_ClientCallback_serv)
  protected
    procedure hello(const message: AnsiString); override;
  end;

procedure mainproc;
var
  dorb : IORB;
  obj: IORBObject;
  rootPOA, bidirPOA: IPOA;
  mgr: IPOAManager;
  prm: TStrings;
  servObj: IServant;
  i: Integer;
  policies: PolicyList;
  str: TStringList;
  a: IAny;
  cc: Idemo_bidir_ClientCallback;
  server: Idemo_bidir_Server;
begin
  TBiDirConnectionInitializer.Init;
  a := CreateAny();
  a.put_ushort(BOTH);

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

  SetLength(policies, 4);
  policies[0] := rootPOA.create_lifespan_policy(TRANSIENT);
  policies[1] := rootPOA.create_id_assignment_policy(SYSTEM_ID);
  policies[2] := rootPOA.create_implicit_activation_policy(IMPLICIT_ACTIVATION);
  policies[3] := dorb.create_policy(BIDIRECTIONAL_POLICY_TYPE, a);


  bidirPOA := rootPOA.create_POA('BiDirPOA', mgr, policies);

  servObj := Tdemo_bidir_ClientCallback_impl.Create as IServant;

  cc := Tdemo_bidir_ClientCallback._narrow(bidirPOA.servant_to_reference(servObj));

  str := TStringList.Create;
  try
    str.LoadFromFile('server.ior');
    obj := dorb.string_to_object(str.Text);
  finally
    str.Free;
  end;
  server := Tdemo_bidir_Server._narrow(obj);

  mgr.activate;

  server.register_callback(cc);
  server.callback_hello('foo');
  Writeln('Hit <Enter> to exit');
  ReadLn;

  dorb._destroy();
  dorb := nil;
  exit;
end;

{ Tdemo_bidir_ClientCallback_impl }

procedure Tdemo_bidir_ClientCallback_impl.hello(const message: AnsiString);
begin
  WriteLn(message);
end;

begin
  mainproc;
end.

program server;

{$APPTYPE CONSOLE}

uses
  SysUtils, Classes, bidir_impl, bidir, bidir_int, orb_int, poa_int, orb, poa_impl,
  policy_int, code_int, any, osthread;

type
  Tdemo_bidir_Server_impl = class(Tdemo_bidir_Server_serv)
  private
    FCallback: Idemo_bidir_ClientCallback;
  protected
    procedure register_callback(const cc: Idemo_bidir_ClientCallback); override;
    procedure callback_hello(const message: AnsiString); override;
  end;

  TBrokerThread = class(TORBThread)
  private
    FORB: IORB;
  protected
    procedure Run(); override;
  public
    constructor Create(AORB: IORB);
  end;

{ Tdemo_bidir_Server_serv }

procedure Tdemo_bidir_Server_impl.callback_hello(const message: AnsiString);
begin
  WriteLn(message);
  FCallback.hello(message);
end;

procedure Tdemo_bidir_Server_impl.register_callback(
  const cc: Idemo_bidir_ClientCallback);
begin
  FCallback := cc;
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
  th: TBrokerThread;
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

  servObj := Tdemo_bidir_Server_impl.Create as IServant;

  obj := bidirPOA.servant_to_reference(servObj);

  str := TStringList.Create;
  try
    str.Text := String(dorb.object_to_string(obj));
    str.SaveToFile('server.ior');
  finally
    str.Free;
  end;

  mgr.activate;
  WriteLn('Server ready');
  th := TBrokerThread.Create(dorb);
  th.Start();
  WriteLn('Hit <Enter> to exit');
  ReadLn;
  dorb.shutdown(True);
  th.Wait;
  dorb := nil;
  exit;
end;

{ TBrokerThread }

constructor TBrokerThread.Create(AORB: IORB);
begin
  inherited Create();
  FORB := AORB;
end;

procedure TBrokerThread.Run;
begin
  FORB.run;
  FORB._destroy();
end;

begin
  mainproc;
end.

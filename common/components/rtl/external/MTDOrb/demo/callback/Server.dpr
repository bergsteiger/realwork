program Server;
{$APPTYPE CONSOLE}
uses
  ShareMem,
{$IFDEF WIN32}
  windows,
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
  Test_int in 'test_int.pas',
  Test in 'test.pas';

type
  TServerObject_impl = class(TServerObject_serv)
  protected
    procedure set_client_object(const obj: IClientObject); override;
  end;

procedure mainproc;
var
  dorb : IORB;
  obj: IORBObject;
  rootPOA: IPOA;
  mgr: IPOAManager;
  prm: TStrings;
  servObj: IServant;
  i: Integer;
begin
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

  servObj := TServerObject_impl.Create as IServant;

  rootPoa.activate_object(servObj);

  mgr.activate;
  dorb.run;
  dorb._destroy();
  dorb := nil;
  exit;
end;

{ TServerObject_serv }

procedure TServerObject_impl.set_client_object(const obj: IClientObject);
begin
  WriteLn('Set client object');
  try
    obj.Foo;
  except
    on E: Exception do begin
      WriteLn(E.Message);
      MTDORBLogger.Error(AnsiString(E.Message));
      raise;
    end
  end; { try/except }
end;

begin
  // Insert user code here
  mainproc;
end.
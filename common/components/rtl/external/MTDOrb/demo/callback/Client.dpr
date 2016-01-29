program Client;
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
  TClientObject_impl = class(TClientObject_serv)
  protected
    procedure Foo; override;
  end;

  TORBThread = class(TThread)
  protected
    procedure Execute; override;
  public
    constructor Create;
  end;

var
  dorb : IORB;
  th: TORBThread;

procedure mainproc;
var
  obj: IORBObject;
  prm: TStrings;
  i: Integer;
  servObj: IServerObject;
  clientObj: TClientObject_impl;
  rootPOA: IPOA;
begin
  prm := TStringList.Create;
  try
    for i := 1 to ParamCount do
      prm.Add(ParamStr(i));
    dorb := ORB_Init(prm);
  finally
    prm.Free;
  end; { try/finally }

  th := TORBThread.Create;
  try
    //Obtain a reference to the RootPOA and its Manager
    obj := dorb.resolve_initial_reference('RootPOA');
    rootPOA := POA_narrow(obj);
    rootPOA.the_POAManager.activate;

    obj := dorb.bind('IDL:ServerObject:1.0');
    servObj := TServerObject._narrow(obj);
    if servObj <> nil then begin
      clientObj := TClientObject_impl.Create;
      servObj.set_client_object(clientObj._this);
    end;

    WriteLn('Press any key');
    ReadLn;
  finally
    dorb.shutdown(true);
    dorb._destroy();
    dorb := nil;
  end; { try/finally }
  //th.Free;
end;

{ TClientObject_impl }

procedure TClientObject_impl.Foo;
begin
  WriteLn('Foo');
end;

{ TORBThread }

constructor TORBThread.Create;
begin
  FreeOnTerminate := True;
  inherited Create(False);
end;

procedure TORBThread.Execute;
begin
  dorb.run;
end;

begin
  try
    mainproc;
  except
    on E: Exception do begin
      WriteLn(E.Message);
      MTDORBLogger.Error(AnsiString(E.Message));
      ReadLn;
    end;
  end; { try/except }
end.

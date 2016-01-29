program Server;
{$APPTYPE CONSOLE}
uses
  windows,
  SysUtils,
  classes,
  orb,
  orb_int,
  poa_int,
  poa_impl,
  simple_int in 'simple_int.pas',
  simple in 'simple.pas';

type
  TSimple1_impl = class(Tsimple1_serv)
  protected
    procedure func(const id: AnsiChar); override;
    procedure flush; override;
  end;

  TSimple2_impl = class(Tsimple2_serv)
    procedure func(const id: AnsiChar); override;
    procedure flush; override;
  end;

{ TSimple1_impl }

procedure TSimple1_impl.flush;
begin
  WriteLn;
end;

procedure TSimple1_impl.func(const id: AnsiChar);
begin
  WriteLn(Char(id) + '. ThreadID: ' + IntToStr(GetCurrentThreadID));
  //Sleep(1000);
end;

{ TSimple2_impl }

procedure TSimple2_impl.flush;
begin
  WriteLn;
end;

procedure TSimple2_impl.func(const id: AnsiChar);
begin
  WriteLn(Char(id) + '. ThreadID: ' + IntToStr(GetCurrentThreadID));
  //Sleep(1000);
end;

procedure mainproc;
var
  dorb : IORB;
  rootPOA: IPOA;
  obj: IORBObject;
  s1: TSimple1_impl;
  s2: TSimple2_impl;
  params: TStrings;
begin
  params := TStringList.Create;
  try
    params.add('-ORBIIOPAddr');
    params.add('inet:127.0.0.1:10000');
    params.Add('-ORBThreadPoolTimeout');
    params.Add('10');
    dorb := ORB_Init(params);
  finally
    params.Free;
  end;
  //Obtain a reference to the RootPOA and its Manager
  obj := dorb.resolve_initial_reference('RootPOA');
  rootPOA := TPOA_impl._narrow(obj);
  s1 := TSimple1_impl.Create;
  s2 := TSimple2_impl.Create;
  rootPOA.activate_object(s1);
  rootPOA.activate_object(s2);
  WriteLn('server: activating POA manager');
  rootPOA.the_POAManager.activate();
  WriteLn('server: running');
  dorb.run();
end;

begin
  // Insert user code here
  mainproc();
end.
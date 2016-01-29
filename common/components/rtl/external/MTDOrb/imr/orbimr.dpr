// **********************************************************************
//
// Copyright (c) 2001 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
program orbimr;

{$APPTYPE CONSOLE}

{$I dorb.inc}

uses
{$IFDEF MSWINDOWS}
  Windows,
  WinSvc,
  SvcMgr,
{$ENDIF}
{$IFDEF LINUX}
  Libc,
{$ENDIF}
  SysUtils,
  Classes,
  orb,
  osthread,
  orb_int,
  poa_int,
  poa_impl,
  imr_impl,
  imr_int,
  imr;

const
  cIMRName = 'MTDORB Implementation Repository';
  cIMRServiceName = 'MTDORB_IMR';

type
  TMainORBThread = class(TORBThread)
  protected
    procedure Run(); override;
  end;

var
  dorb: IORB;
  rootPOA: IPOA;
  theDb: string;
  pmd: IPOAMediator;
  startParams: TStrings;
  orbThread: IORBThread;

procedure usage();
begin
  WriteLn(Format('usage: %s [<options>]', [ParamStr(0)]));
  WriteLn('possible <options> are:');
  WriteLn('    -help');
  WriteLn('    -forward');
  WriteLn('    -db <database file>');
  WriteLn('    -ior <IOR ref file>');
  WriteLn('    -install (for Windows only)');
  WriteLn('    -uninstall (for Windows only)');
  Halt;
end;

{$I-}
function save_imr(const fn: string): integer;
var
  outDb: Text;
  obj: IORBObject;
  imrVar: IImplRepository;
  impls: TImplDefSeq;
  i: integer;
  fileName: string;
begin
  impls := nil;
  fileName := ExtractFilePath(ParamStr(0)) + fn;
  AssignFile(outDb, fileName);
  result := IOResult();
  if result <> 0 then
    Exit;
  Rewrite(outDb);
  result := IOResult();
  if result <> 0 then
    Exit;
  try
    obj := dorb.resolve_initial_reference('ImplementationRepository');
    imrVar := TImplRepository._narrow(obj);

    (*
     * Save Imr entries
     *)
    impls := imrVar.find_all();

    for i := 0 to Length(impls) - 1 do begin
      if Length(impls[i].command) > 0 then begin
        // it is not an automatically created entry
        WriteLn(outDb, impls[i].tostring);
        result := IOResult();
        if result <> 0 then
          Exit;
      end;
    end;
  finally
    CloseFile(outDb);
    result := IOResult();
  end; { try/finally }
end;

function restore_imr(const fn: string): integer;
var
  inDb: Text;
  obj: IORBObject;
  imrVar: IImplRepository;
  line: string;
  impl: IImplementationDef;
  fileName: string;
begin
  result := 0;
  fileName := ExtractFilePath(ParamStr(0)) + fn;
  if not FileExists(fileName) then
    Exit;
  AssignFile(inDb, fileName);
  result := IOResult();
  if result <> 0 then
    Exit;
  Reset(inDb);
  result := IOResult();
  if result <> 0 then
    Exit;
  try
    obj := dorb.resolve_initial_reference('ImplementationRepository');
    imrVar := TImplRepository._narrow(obj);

    while not Eof(inDb) do begin
      ReadLn(inDb, line);
      result := IOResult();
      if result <> 0 then
        Exit;
      impl := imrVar.restore(line);
      Assert(impl <> nil);
    end; { while }
  finally
    CloseFile(inDb);
    result := IOResult();
  end; { try/finally }
end;
{$I+}

procedure main(AParams: TStrings);
var
  obj: IORBObject;
  i: integer;
  serv: IServant;
  forwardFlag: boolean;
  prm: string;
  intf: IInterface;
begin
  forwardFlag := true;
  for i := 0 to AParams.Count - 1 do begin
    prm := LowerCase(AParams[i]);
    if prm = '-forward' then
      forwardFlag := true
    else if prm = '-dont-forward' then
      forwardFlag := false
    else if (prm = '-db') and ((i + 1) < AParams.Count) then
      theDb := AParams[i + 1]
    else if (prm = '-help') or (prm = '-h') then
      usage();
  end;
  dorb := ORB_Init(AParams);

  //RootPOA
  obj := dorb.resolve_initial_reference('RootPOA');
  rootPOA := POA_narrow(obj);

  dorb.register_initial_reference('ImplementationRepository',
    rootPOA.servant_to_reference(TImplRepository_impl.Create() as IServant));

  intf := TPOAMediator_impl.Create(dorb, forwardFlag);
  serv := TPOAMediator_serv.Create(intf as IPOAMediator) as IServant;
  obj := rootPOA.activate_for_this(serv);
  (intf as IPOAMediatorImpl).ORBObject(obj);
  pmd := obj as IPOAMediator;

  rootPOA.the_POAManager.activate;

  if theDb <> '' then
    restore_imr(theDb);

  dorb.run();
  dorb._destroy();
end;

{$IFDEF MSWINDOWS}
function ConsoleCtrlHandler(ctrlType: DWORD): BOOL; stdcall;
begin
  case ctrlType of
    CTRL_BREAK_EVENT,
    CTRL_C_EVENT,
    CTRL_CLOSE_EVENT: begin
      if theDb <> '' then
        save_imr(theDb);
      if dorb <> nil then
        dorb.shutdown(false);
      result := true;
    end;
    else result := false;
  end;
end;

type
  TIMRService = class(TService)
  protected
    procedure Start(Sender: TService; var Started: Boolean);
    procedure Stop(Sender: TService; var Stopped: Boolean);
  public
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
    function GetServiceController: TServiceController; override;
  end;

var
  imrService: TIMRService = nil;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  imrService.Controller(CtrlCode);
end;

{ TIMRService }

constructor TIMRService.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  inherited CreateNew(AOwner, Dummy);
  AllowPause := False;
  Interactive := False;
  DisplayName := cIMRName;
  Name := cIMRServiceName;
  OnStart := Start;
  OnStop := Stop;
end;

function TIMRService.GetServiceController: TServiceController;
begin
  result := ServiceController;
end;

procedure TIMRService.Start(Sender: TService; var Started: Boolean);
begin
  //try load params from config file
  try
    startParams.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'orbimr.config');
    orbThread := TMainORBThread.Create();
    orbThread.Start();
    Started := True;
  except
    Started := False;
  end; { try/except }
end;

procedure TIMRService.Stop(Sender: TService; var Stopped: Boolean);
begin
  try
    if theDb <> '' then
      save_imr(theDb);
    if dorb <> nil then
      dorb.shutdown(false);
    orbThread := nil;
  except
    //consume
  end; { try/except }
  Stopped := True;
end;

function Installing: Boolean;
begin
  Result := FindCmdLineSwitch('INSTALL',['-','\','/'], True) or
            FindCmdLineSwitch('UNINSTALL',['-','\','/'], True);
end;

function StartService: Boolean;
var
  Mgr, Svc: Integer;
  UserName, ServiceStartName: string;
  Config: Pointer;
  Size: DWord;
begin
  Result := False;
  Mgr := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  if Mgr <> 0 then
  begin
    Svc := OpenService(Mgr, PChar(cIMRServiceName), SERVICE_ALL_ACCESS);
    Result := Svc <> 0;
    if Result then
    begin
      QueryServiceConfig(Svc, nil, 0, Size);
      Config := AllocMem(Size);
      try
        QueryServiceConfig(Svc, Config, Size, Size);
        ServiceStartName := PQueryServiceConfig(Config)^.lpServiceStartName;
        if CompareText(ServiceStartName, 'LocalSystem') = 0 then
          ServiceStartName := 'SYSTEM';
      finally
        Dispose(Config);
      end;
      CloseServiceHandle(Svc);
    end;
    CloseServiceHandle(Mgr);
  end;
  if Result then
  begin
    Size := 256;
    SetLength(UserName, Size);
    GetUserName(PChar(UserName), Size);
    SetLength(UserName, StrLen(PChar(UserName)));
    Result := CompareText(UserName, ServiceStartName) = 0;
  end;
end;
{$ENDIF}

{$IFDEF LINUX}
var
  bHup: Boolean = True;
  bTerm: Boolean = False;

function IsDaemon: Boolean;
begin
  Result := FindCmdLineSwitch('DAEMON',['-','\','/'], True);
end;

procedure DoAction(Sig: Longint); cdecl;
begin
  if Sig = SIGTERM then
    bTerm := True
  else if Sig = SIGHUP then
    bHup := True;
end;

procedure SetupSignalHook();
var
  SignalSet: TSigset;
  TermHandle, HupHandle{, IntHandle}: TSigAction;
begin
  sigfillset(SignalSet);
  sigdelset(SignalSet, SIGTERM);
  sigdelset(SignalSet, SIGHUP);
  sigdelset(SignalSet, SIGCHLD);
  //sigdelset(SignalSet, SIGINT);
  sigprocmask(SIG_BLOCK, @SignalSet, nil);

  FillChar(TermHandle, SizeOf(TSigAction), 0);
  FillChar(HupHandle, SizeOf(TSigAction), 0);
  //FillChar(IntHandle, SizeOf(TSigAction), 0);

  TermHandle.__sigaction_handler := @DoAction;
  HupHandle.__sigaction_handler := @DoAction;
  //IntHandle.__sigaction_handler := @DoAction;

  SigAction(SIGTERM, @TermHandle, nil);
  SigAction(SIGHUP, @HupHandle, nil);
  //SigAction(SIGINT, @IntHandle, nil);
end;

procedure CreateDaemon();
var
  pid: __pid_t;
begin
  SetupSignalHook();
  pid := fork();
  case pid of
    0: begin
      Close(Input);
      AssignFile(Output, '/dev/null');
      ReWrite(Output);
      AssignFile(ErrOutput, '/dev/null');
      ReWrite(ErrOutput);
    end;
    -1: begin
      Halt(1);
    end;
    else
      Halt(0);
  end;
end;

procedure RunDaemon();
begin
  while True do begin
    Sleep(500);
    if bHup then begin
      bHup := False;
      if orbThread <> nil then begin
        dorb.shutdown(True);
        orbThread := nil;
      end;
      startParams.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'orbimr.config');
      orbThread := TMainORBThread.Create();
      orbThread.Start();
    end;
    if bTerm then begin
      if theDb <> '' then
        save_imr(theDb);
      dorb.shutdown(True);
      Break;
    end;
  end;
end;
{$ENDIF}

{ TMainORBThread }

procedure TMainORBThread.Run;
begin
  main(startParams);
end;

var
  idx: integer;

begin
  startParams := TStringList.Create;
  try
{$IFDEF MSWINDOWS}
    if Installing or StartService then begin
      SvcMgr.Application.Initialize;
      imrService := TIMRService.CreateNew(SvcMgr.Application, 0);
      SvcMgr.Application.Run;
    end
    else begin
      WriteLn('MT DORB Implementation repository');
      WriteLn('Copyright(c) 2001 - 2003 Millennium Group. All right reserved.');
      WriteLn('Started');
      SetConsoleCtrlHandler(@ConsoleCtrlHandler, true);
      for idx := 1 to ParamCount() do
        startParams.Add(ParamStr(idx));
      main(startParams);
    end;
{$ENDIF}
{$IFDEF LINUX}
    if IsDaemon then begin
      CreateDaemon();
      RunDaemon();
    end
    else begin
      for idx := 1 to ParamCount() do
        startParams.Add(ParamStr(idx));
      WriteLn('MTDORB Implementation repository');
      WriteLn('Copyright(c) 2001 - 2004 Millennium Group. All right reserved.');
      WriteLn('Started');
      main(startParams);
    end;
{$ENDIF}
  finally
    startParams.Free;
{$IFDEF MSWINDOWS}
    imrService.Free;
{$ENDIF}
  end; { try/finally }
end.

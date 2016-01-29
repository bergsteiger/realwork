program Server;
{$APPTYPE CONSOLE}
uses
{$IFDEF WIN32}
  Windows,
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
  transact_impl,
  orbtypes,
  CosTransactions_int,
  CosTransactions,
  CounterImpl in 'CounterImpl.pas';

procedure mainproc;
var
  dorb : IORB;
  obj: IORBObject;
  rootPOA: IPOA;
  mgr: IPOAManager;
  counter: IServant;
  trCurrent: ICurrent;
  fl : TStream;
  ref: AnsiString;
  prm: TStrings;
  i: Integer;
begin
  prm := TStringList.Create;
  try
    for i := 1 to ParamCount do
      prm.Add(ParamStr(i));
    TransactionServiceInit;
    dorb := ORB_Init(prm);
  finally
    prm.Free;
  end; { try/finally }

  //obtain a reference to the transaction service
  fl := TFileStream.Create('ots.ior', fmOpenRead);
  fl.Position := 0;
  SetLength(ref, fl.Size);
  fl.ReadBuffer(Pointer(ref)^, fl.Size);
  fl.free;
  obj := dorb.string_to_object(ref);
  dorb.register_initial_reference('TransactionService', obj);

  //Obtain a reference to the RootPOA and its Manager
  obj := dorb.resolve_initial_reference('RootPOA');
  rootPOA := POA_narrow(obj);
  mgr := rootPOA.the_POAManager;

  obj := dorb.resolve_initial_reference('TransactionCurrent');
  trCurrent := TCurrent._narrow(obj);
  
  counter := TCounterImpl.Create(trCurrent);
  rootPoa.activate_object(counter);

  fl := TFileStream.Create('server.objid', fmCreate or fmShareDenyWrite);
  ref := dorb.object_to_string(rootPOA.servant_to_reference(counter));
  fl.WriteBuffer(Pointer(ref)^, Length(ref));
  fl.free;
  mgr.activate;
  dorb.run;
  dorb._destroy();
  dorb := nil;
end;

begin
  // Insert user code here
  mainproc;
end.
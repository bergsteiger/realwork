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
  policy_int,
  poa,
  throw,
  osthread,
  bank_int,
  bank;

type
  TAccountManagerActivator = class(TServantActivator)
  protected
    function incarnate(oid: ObjectID; adapter: IPOA): IServant; override;
    procedure etherealize(oid: ObjectID; adapter: IPOA; serv: IServant;
      cleanup_in_progress: Boolean; remaining_activations: Boolean); override;
  end;

  TAccountImpl = class(TBank_Account_serv)
  private
    FBalance: Float;
  protected
    function balance: float; override;
  public
    constructor Create(const ABalance: Float);
  end;

  TAccountManagerImpl = class(TBank_AccountManager_serv)
  protected
    function open_account(const name, kind: AnsiString): IBank_Account;
  public
    destructor Destroy; override;
  end;

  TSavingsAccountManagerImpl = class(TAccountManagerImpl)
  protected
    function open(const name: AnsiString): IBank_Account; override;
  end;

  TCheckingAccountManagerImpl = class(TAccountManagerImpl)
  protected
    function open(const name: AnsiString): IBank_Account; override;
  end;

  TDeActivatorThread = class(TThread)
  private
    FId: ObjectID;
    FPOA: IPOA;
  protected
    procedure Execute; override;
  public
    constructor Create(const id: ObjectID; poa: IPOA);
  end;

  TData = record
    name: string;
    servant: IServant;
  end;
  TAccountRegistry = class
  private
    FList: array of TData;
    FMutex: TMutex;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Put(const AName: AnsiString; AServ: IServant);
    function Get(const AName: AnsiString): IServant;
  end;

var
  dorb : IORB;
  accounts: TAccountRegistry;

procedure mainproc;
var
  obj: IORBObject;
  props: TStrings;
  i: integer;
  p, myPoa: IPOA;
  poaManager: IPOAManager;
  policy: PolicyList;
  servActivator: IServantActivator;
  anOId: ObjectID;
  sref, cref: IORBObject;
  strRef: AnsiString;
  fl : TStream;
begin
  accounts := TAccountRegistry.Create;
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
  SetLength(policy, 2);
  //now not supported
  policy[0] := p.create_lifespan_policy(PERSISTENT);
  policy[1] := p.create_request_processing_policy(USE_SERVANT_MANAGER);
  poaManager := p.the_POAManager;
  myPoa := p.create_POA('bank_servant_activator_poa', poaManager, policy);
  servActivator := TAccountManagerActivator.Create;
  myPoa.set_servant_manager(servActivator);

  // Generate two references - one for checking and another for savings.
  // Note that we are not creating any servants here and just manufacturing
  // a reference which is not yet backed by a servant.
  anOId := String_to_ObjectId('CheckingAccountManager');
  cref := myPoa.create_reference_with_id(anOId, 'IDL:Bank/AccountManager:1.0');
  strRef := dorb.object_to_string(cref);
  fl := TFileStream.Create('cref.dat', fmCreate or fmShareDenyWrite);
  try
    fl.WriteBuffer(Pointer(strRef)^, Length(strRef));
  finally
    fl.Free;
  end; { try/finally }

  anOId := String_to_ObjectId('SavingsAccountManager');
  sref := myPoa.create_reference_with_id(anOId, 'IDL:Bank/AccountManager:1.0');
  strRef := dorb.object_to_string(sref);
  fl := TFileStream.Create('sref.dat', fmCreate or fmShareDenyWrite);
  try
    fl.WriteBuffer(Pointer(strRef)^, Length(strRef));
  finally
    fl.Free;
  end; { try/finally }

  // Activate the POA Manager
  poaManager.activate;
  // Waiting for incoming requests
  WriteLn('BankManager Server is ready');
  dorb.run();
  accounts.Free;
end;

{ TAccountManagerActivator }

procedure TAccountManagerActivator.etherealize(oid: ObjectID;
  adapter: IPOA; serv: IServant; cleanup_in_progress,
  remaining_activations: Boolean);
begin
  // If there are no remaining activations i.e ObjectIds associated
  // with the servant delete it.
  WriteLn(Format('AccountManagerActivator::etherealize() called with ID = %s', [oid]));
end;

function TAccountManagerActivator.incarnate(oid: ObjectID;
  adapter: IPOA): IServant;
var
  s: AnsiString;
begin
  s := ObjectId_to_string(oid);
  WriteLn(Format('AccountManagerActivator::incarnate() called with ID = %s', [oid]));
  if s = 'SavingsAccountManager' then
    // Create CheckingAccountManager Servant
    result := TSavingsAccountManagerImpl.Create
  else if s = 'CheckingAccountManager' then
    // Create CheckingAccountManager Servant
    result := TCheckingAccountManagerImpl.Create
  else
    dorb_throw(st_OBJECT_NOT_EXIST);
  // Create a deactivator thread  
  TDeActivatorThread.Create(oid, adapter);
end;

{ TAccountImpl }

function TAccountImpl.balance: float;
begin
  result := FBalance;
end;

constructor TAccountImpl.Create(const ABalance: Float);
begin
  FBalance := ABalance;
end;

{ TAccountManagerImpl }

destructor TAccountManagerImpl.Destroy;
begin
  inherited;
end;

function TAccountManagerImpl.open_account(const name,
  kind: AnsiString): IBank_Account;
var
  serv: IServant;
  obj: IORBObject;
  n: AnsiString;
  bal: Float;
begin
  n := name + kind;
  // Lookup the account in the account dictionary.
  serv := accounts.Get(n);

  if serv = nil then begin
    // Create the account implementation, given the balance.
    bal := Random(1000);
    serv := TAccountImpl.Create(bal);
    // Save the account in the account dictionary.
    accounts.Put(n, serv);
    // Print out the new account.
    WriteLn(Format('Created %s''s account with %f', [name, bal]));
  end;

  // Activate it on the default POA which is root POA for this servant,
  // and return it.
  obj := _default_POA.servant_to_reference(serv);
  result := TBank_Account._narrow(obj);
end;

{ TDeActivatorThread }

constructor TDeActivatorThread.Create(const id: ObjectID; poa: IPOA);
begin
  FPOA := poa;
  FId := id;
  FreeOnTerminate := true;
  inherited Create(false);
end;

procedure TDeActivatorThread.Execute;
begin
  Sleep(15000);
  FPOA.deactivate_object(FId);
end;

{ TAccountRegistry }

constructor TAccountRegistry.Create;
begin
  FMutex := TMutex.Create();
end;

destructor TAccountRegistry.Destroy;
begin
  FMutex.Free;
  inherited;
end;

function TAccountRegistry.Get(const AName: AnsiString): IServant;
var
  i, len: integer;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMutex);
  i := 0; len := Length(FList);
  while i < len do begin
    if FList[i].name = String(AName) then
      Break;
    Inc(i);
  end; { while }
  if i < len then
    result := FList[i].servant;
end;

procedure TAccountRegistry.Put(const AName: AnsiString; AServ: IServant);
var
  i, len: integer;
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMutex);
  i := 0; len := Length(FList);
  while i < len do begin
    if FList[i].name = String(AName) then
      Break;
    Inc(i);
  end; { while }
  if i = len then
    SetLength(FList, len + 1);
  FList[i].name := String(AName);
  FList[i].servant := AServ;
end;

{ TSavingsAccountManagerImpl }

function TSavingsAccountManagerImpl.open(
  const name: AnsiString): IBank_Account;
begin
  // Pass Savings info here (just a string for now)
  result := open_account(name, '_Savings');
end;

{ TCheckingAccountManagerImpl }

function TCheckingAccountManagerImpl.open(
  const name: AnsiString): IBank_Account;
begin
  // Pass Checking info here (just a string for now)
  result := open_account(name, '_Checking');
end;

begin
  Randomize;
  mainproc;
end.
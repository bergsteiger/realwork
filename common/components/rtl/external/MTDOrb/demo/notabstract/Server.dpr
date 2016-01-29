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
  account_int,
  account;

type
  TBank_Account_impl = class(TInterfacedObject, IBank_Account)
  private
    FBalance: float;
  protected
    function balance: float;
  end;

  TBank_AccountEx_impl = class(TBank_Account_impl, IBank_AccountEx)
  protected
    procedure debit(const value: double);
    procedure credit(const value: double);
  end;

var
  dorb : IORB;

procedure mainproc;
var
  obj: IORBObject;
  props: TStrings;
  i: integer;
  p: IPOA;
begin
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
  //p.activate_object(TBank_Account_serv.Create(TBank_Account_impl.Create));
  p.activate_object(TBank_AccountEx_serv.Create(TBank_AccountEx_impl.Create));
  p.the_POAManager.activate;
  dorb.run();
end;

{ TBank_Account_impl }

function TBank_Account_impl.balance: float;
begin
  result := FBalance;
end;

{ TBank_AccountEx_impl }

procedure TBank_AccountEx_impl.credit(const value: double);
begin
  FBalance := FBalance - value;
end;

procedure TBank_AccountEx_impl.debit(const value: double);
begin
  FBalance := FBalance + value;
end;

begin
  mainproc;
end.
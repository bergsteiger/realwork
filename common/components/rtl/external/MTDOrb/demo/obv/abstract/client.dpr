program client;
{$APPTYPE CONSOLE}
uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  SysUtils,
  classes,
  orb_int,
  poa_int,
  value_int,
  orb,
  poa_impl,
  abstract in 'abstract.pas',
  abstract_int in 'abstract_int.pas',
  abstract_imp in 'abstract_imp.pas';

var
  params: TStrings;
  obj : IORBObject;
  dorb: IORB;
  f: IValueFactory;
  curr : ICurrency;
  acc : IAccount;
  ex : IExample;
begin
  params := TStringList.Create;
  try
    params.Add('-ORBBindAddr');
    params.Add('inet:localhost:1000');
    dorb := ORB_Init(params);

    f := TCurrency_factory.Create();
    dorb.register_value_factory('IDL:Currency:1.0',f);

    curr := TCurrency_impl.Create;

    obj := dorb.bind('IDL:Account:1.0');
    acc := TAccount._narrow(obj);

    if acc = nil then exit;

    obj := dorb.bind('IDL:Example:1.0');
    ex := TExample._narrow(obj);

    ex.display(acc);
    ex.display(curr);

    

  finally
    params.Free;
  end;
end.

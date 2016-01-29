program server;
{$APPTYPE CONSOLE}
uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  SysUtils,
  classes,
  value_int,
  orb_int,
  poa_int,
{$IFDEF LINUX}
  dtypes,
{$ENDIF}
  orb,
  poa_impl,
  abstract in 'abstract.pas',
  abstract_int in 'abstract_int.pas',
  abstract_imp in 'abstract_imp.pas';

var
  params: TStrings;
  obj : IORBObject;
  p: IPOA;
  pm : IPOAManager;
  dorb: IORB;
  f: IValueFactory;
  acc, example : IServant;
begin
  params := TStringList.Create;
  try
    params.Add('-ORBIIOPAddr');
    params.Add('inet:localhost:1000');
    dorb := ORB_Init(params);
    f := TCurrency_factory.Create();
    dorb.register_value_factory('IDL:Currency:1.0',f);
    obj := dorb.resolve_initial_reference('RootPOA');
    p := POA_narrow(obj);
    pm := p.the_POAManager();
    acc := TAccount_impl.Create();
    example := TExample_impl.Create();
    p.activate_object(acc);
    p.activate_object(example);
    pm.activate;
    dorb.run;
  finally
    params.Free;
  end;

end.

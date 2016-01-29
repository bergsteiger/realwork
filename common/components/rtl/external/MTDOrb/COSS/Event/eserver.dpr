program eserver;
{$APPTYPE CONSOLE}
uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  SysUtils,
  orb,
  poa_impl,
  poa_int,
  boa_int,
  classes,
  orb_int,
  orbtypes,
  coseventchanneladmin_int,
  cosnaming_int,
  cosnaming,
  coseventchanneladmin_impl in 'coseventchanneladmin_impl.pas';

var
  dorb : IORB;
  p : IPOA;
  props : TStrings;
  i : integer;
  fact : IEventChannelFactory;
  obj : IORBObject;
  nc : INamingContext;
  name : TName;
begin
  props := TStringList.Create;
  try
    for i := 1 to ParamCount do
      props.add(Paramstr(i));
    dorb := ORB_Init(props);
    obj := dorb.resolve_initial_reference('RootPOA');
    Assert(obj <> nil);
    p := POA_Narrow(obj);
    
    obj := dorb.resolve_initial_reference('NameService');
    Assert(obj <> nil);
    nc := TNamingContext._narrow(obj);
    Assert(nc <> nil);
    SetLength(name,1);
    name[0].id := 'EventChannelFactory';
    name[0].kind := '';
    fact := TEventChannelFactory_impl.Create;
    obj := p.activate_for_this(fact as IServant);
    try
      nc.bind(name, obj as IORBObject);
    except
      on e : TAlreadyBound do
        nc.rebind(name, obj as IORBObject);
    end;
  finally
    props.free;
  end;
  p.the_POAManager.activate();
  dorb.run;
end.
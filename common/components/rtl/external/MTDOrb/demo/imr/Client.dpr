program Client;
{$APPTYPE CONSOLE}
uses
  SysUtils,
  Classes,
  orb_int,
  orb,
  poa_int,
  poa_impl,
  exceptions,
  except_int,
  orbtypes,
  hello_int,
  hello;

procedure mainproc;
var
  dorb : IORB;
  obj: IORBObject;
  myobj: IHello;
  props: TStrings;
  i: integer;
begin
  props := TStringList.Create;
  try
    for i := 1 to ParamCount do
      props.Add(ParamStr(i));
    dorb := ORB_Init(props);
  finally
    props.Free;
  end; { try/finally }
  //obj := dorb.string_to_object('corbaloc::safonov:10501/ServerPOA');//dorb.bind('IDL:Hello:1.0', 'inet:localhost:10501');
  obj := dorb.bind('IDL:Hello:1.0', 'inet:localhost:10501');
  if obj <> nil then begin
    myobj := THello._narrow(obj);
    if myobj = nil then Exit;
    try
      myobj.hello;
      WriteLn('Method invoked successfully');
      ReadLn;
    except
      on E: SystemException do begin
        WriteLn(E.Message);
        ReadLn;
      end;
    end; { try/except }
  end;
end;

begin
  mainproc;
end.
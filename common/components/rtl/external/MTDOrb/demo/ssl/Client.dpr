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
  try
    //use corbaloc:ssliop (ssliop is not standart from OMG)
    obj := dorb.string_to_object('corbaloc:ssliop:localhost:12124/Hello');
    //use bind (specific of MTDORB)
    //obj := dorb.bind('IDL:Hello:1.0'{, ParamStr(2)});
    if obj <> nil then begin
      myobj := THello._narrow(obj);
      if myobj = nil then Exit;
        myobj.hello;
        WriteLn('Method invoked successfully');
        ReadLn;
    end;
  except
    on E: SystemException do begin
      WriteLn(E.Message);
      ReadLn;
    end;
  end; { try/except }
end;

begin
  mainproc;
end.
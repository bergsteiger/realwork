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
  Test_int,
  Test;

procedure TestLocationForward(const AServer: IRetryServer);
var
  test: ITest;
begin
  WriteLn('Testing forwarding loop detection... ');
  //
  // Verify that we detect excessive forwarding
  //
  test := AServer.get_location_forward_object();
  try
    test.aMethod();
  except
    on E: SystemException do
      if (E.extype <> st_TRANSIENT) and (E.minor <> MinorLocationForwardHopCountExceeded) then
        raise;
  end;
  WriteLn('Done!');
end;

procedure mainproc;
var
  dorb : IORB;
  obj: IORBObject;
  server: IRetryServer;
  props: TStrings;
  fl : TStream;
  i: integer;
  ref: AnsiString;
begin
  props := TStringList.Create;
  try
    for i := 1 to ParamCount do
      props.Add(ParamStr(i));
    dorb := ORB_Init(props);
  finally
    props.Free;
  end; { try/finally }

  fl := TFileStream.Create('Test.ref', fmOpenRead);
  fl.Position := 0;
  SetLength(ref, fl.Size);
  fl.ReadBuffer(Pointer(ref)^, fl.Size);
  fl.Free;

  obj := dorb.string_to_object(ref);
  if obj <> nil then begin
    server := TRetryServer._narrow(obj);
    if server = nil then Exit;
    try
      TestLocationForward(server);
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
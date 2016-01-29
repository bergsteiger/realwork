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
  helloworld_int,
  helloworld;

procedure mainproc;
var
  dorb : IORB;
  obj: IORBObject;
  myobj: IHelloWorld;
  props: TStrings;
  //i: integer;
  ex: ISystemException;
  ref: AnsiString;
  //c: char;
  fl: TFileStream;
begin
  props := TStringList.Create();
  dorb := ORB_Init(props);
  props.Free;
  fl := TFileStream.Create(ParamStr(1), fmOpenRead {$IFDEF WIN32}or fmShareCompat{$ENDIF});
  fl.Position := 0;
  SetLength(ref, fl.Size);
  fl.ReadBuffer(Pointer(ref)^, fl.Size);
  fl.free;

  obj := dorb.string_to_object(ref);
  if obj <> nil then begin
    myobj := THelloWorld._narrow(obj);
    if myobj = nil then Exit;
    try
      myobj.hello();
      WriteLn('Successfully complete. Press any key.');
      ReadLn;
    except
      on E: SystemException do begin
        ex := SystemException.Create(E);
        WriteLn('Corba exception: ', SYSEXC_NAMES[ex.extype()]);
        ReadLn;
      end;
    end; { try/except }
  end;
end;

begin
  mainproc;
end.
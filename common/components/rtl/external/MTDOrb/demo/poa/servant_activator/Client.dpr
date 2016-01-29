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
  bank_int,
  bank;

procedure mainproc;
var
  dorb : IORB;
  obj: IORBObject;
  props: TStrings;
  manager: IBank_AccountManager;
  myobj: IBank_Account;
  i: integer;
  ex: ISystemException;
  fl : TStream;
  name, cref: AnsiString;
  bal: Float;
  refFile: string;
begin
  props := TStringList.Create;
  try
    for i := 1 to ParamCount do
      props.Add(ParamStr(i));
    dorb := ORB_Init(props);
  finally
    props.Free;
  end; { try/finally }
  refFile := 'cref.dat';
  if (ParamCount > 1) and (LowerCase(ParamStr(2)) = 'savings') then
    refFile := 'sref.dat';
  fl := TFileStream.Create(refFile, fmOpenRead {$IFDEF WINDOWS}or fmShareCompat{$ENDIF});
  try
    fl.Position := 0;
    SetLength(cref, fl.Size);
    fl.ReadBuffer(Pointer(cref)^, fl.Size);
  finally
    fl.Free;
  end; { try/finally }
  obj := dorb.string_to_object(cref);
  if obj <> nil then begin
    // Locate an account manager. Give the full POA name and the servant ID.
    manager := TBank_AccountManager._narrow(obj);
    if manager = nil then Exit;
    try
      if ParamCount > 0 then
        name := AnsiString(ParamStr(1))
      else
        name := 'Jack B. Quick';
      // Request the account manager to open a named account.
      myobj := manager.open(name);
      // Get the balance of the account.
      bal := myobj.balance();
      WriteLn(Format('The balance in %s''s account is %f', [name, bal]));
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
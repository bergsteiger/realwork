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
  account_int,
  account;

procedure mainproc;
var
  dorb : IORB;
  obj: IORBObject;
  myobj: IBank_AccountEx;
  props: TStrings;
  i: integer;
  ex: ISystemException;
begin
  props := TStringList.Create;
  try
    for i := 1 to ParamCount do
      props.Add(ParamStr(i));
    dorb := ORB_Init(props);
  finally
    props.Free;
  end; { try/finally }
  obj := dorb.bind('IDL:Bank/AccountEx:1.0');
  if obj <> nil then begin
    myobj := TBank_AccountEx._narrow(obj);
    if myobj = nil then Exit;
    try
      myobj.debit(300);
      WriteLn(FloatToStr(myobj.balance));
      myobj.credit(100);
      WriteLn(FloatToStr(myobj.balance));
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
program Client;
{$ifndef fpc}{$apptype console}{$endif}
uses
  {$ifdef unix}cthreads,{$endif}
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
  ex: ISystemException;
  str: AnsiString;
  wstr: WideString;
  c: AnsiChar;
  cs: TChars;
  wc: widechar;
  wcs: TwChars;
  f: Text;
begin
  props := TStringList.Create;
  try
    for i := 1 to ParamCount do
      props.Add(ParamStr(i));
    dorb := ORB_Init(props);
  finally
    props.Free;
  end; { try/finally }
  obj := dorb.bind('IDL:Hello:1.0');
  if obj <> nil then begin
    myobj := THello._narrow(obj);
    if myobj = nil then Exit;
    try
      c := myobj.hello_char(AnsiChar('п')); // russian language, KOI8-R
      SetLength(cs, 6);
      move(PAnsiChar('привет')^, Pointer(cs)^, 6); // russian language, KOI8-R
      cs := myobj.hello_chars(cs);
      str := myobj.hello_string('привет'); // russian language, KOI8-R
      SetLength(wcs, 5);
      wstr := #1059#1089#1087#1077#1093;
      wc := myobj.hello_widechar(wstr[1]);
      move(Pointer(wstr)^, Pointer(wcs)^, 5 * SizeOf(WideChar));
      wcs := myobj.hello_widechars(wcs);
      wstr := '';
      wstr := myobj.hello_widesting(WideString(#1059#1089#1087#1077#1093)); // russian language
      AssignFile(f, 'Client.txt');
      Rewrite(f);
      WriteLn(f, c);
      for i := 0 to Length(cs) - 1 do
        Write(f, cs[i]);
      WriteLn(f);
      WriteLn(f, str);
      {$IFNDEF VER130}
      WriteLn(f, wc);
      for i := 0 to Length(wcs) - 1 do
        Write(f, wcs[i]);
      {$ENDIF}
      WriteLn(f);
      {$IFNDEF VER130}
      WriteLn(f, wstr);
      {$ENDIF}
      CloseFile(f);
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

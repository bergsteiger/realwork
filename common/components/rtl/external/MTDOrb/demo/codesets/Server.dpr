program Server;
{$ifndef fpc}{$apptype console}{$endif}
uses
  {$ifdef unix}cthreads,{$endif}
  SysUtils,
  Classes,
  orb_int,
  orb,
  poa_int,
  poa_impl,
  code_int,
  intercept,
  Intercept_int,
  env_int,
  exceptions,
  orbtypes,
  hello_int,
  hello;

type
  THello_impl = class(THello_serv)
  protected
    function hello_char(const msg: AnsiChar): AnsiChar; override;
    function hello_chars(const msg: Tchars): Tchars; override;
    function hello_string(const msg: AnsiString): AnsiString; override;
    function hello_widechar(const msg: widechar): widechar; override;
    function hello_widechars(const msg: Twchars): Twchars; override;
    function hello_widesting(const msg: widestring): widestring; override;
  end;

var
  dorb : IORB;
  f: Text;

procedure mainproc;
var
  obj: IORBObject;
  props: TStrings;
  i: integer;
  p: IPOA;
begin
  props := TStringList.Create;
  try
    for i := 1 to ParamCount do
      props.Add(ParamStr(i));
    dorb := ORB_Init(props);
  finally
    props.Free;
  end; { try/finally }
  obj := dorb.resolve_initial_reference('RootPOA');
  p := TPOA_impl._narrow(obj);
  p.activate_object(THello_impl.Create());
  p.the_POAManager.activate;
  AssignFile(f, 'Server.txt');
  Rewrite(f);
  dorb.run();
  CloseFile(f);
end;

{ THello_impl }

function THello_impl.hello_char(const msg: AnsiChar): AnsiChar;
begin
  WriteLn(msg);
  WriteLn(f, msg);
  result := msg;
end;

function THello_impl.hello_chars(const msg: Tchars): Tchars;
var
  i: integer;
begin
  WriteLn(PChar(msg));
  for i := 0 to Length(msg) - 1 do
    Write(f, msg[i]);
  WriteLn(f);
  result := msg;
end;

function THello_impl.hello_string(const msg: AnsiString): AnsiString;
begin
  WriteLn(msg);
  WriteLn(f, msg);
  result := msg;
end;

function THello_impl.hello_widesting(const msg: widestring): widestring;
begin
  {$IFNDEF VER130}
  WriteLn(msg);
  WriteLn(f, msg);
  {$ENDIF}
  result := msg;
end;

function THello_impl.hello_widechar(const msg: widechar): widechar;
begin
  {$IFNDEF VER130}
  WriteLn(msg);
  WriteLn(f, msg);
  {$ENDIF}
  result := msg;
end;

function THello_impl.hello_widechars(const msg: Twchars): Twchars;
{$IFNDEF VER130}
var
  i: integer;
{$ENDIF}
begin
  {$IFNDEF VER130}
  WriteLn(PChar(msg));
  for i := 0 to Length(msg) - 1 do
    Write(f, msg[i]);
  WriteLn(f);
  {$ENDIF}
  result := msg;
end;

begin
  mainproc;
end.

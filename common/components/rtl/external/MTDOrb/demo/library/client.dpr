program client;
{$APPTYPE CONSOLE}
uses
{$IFDEF USELIB}
{$IFDEF MSWINDOWS}
  ShareMem,
//  Windows,
{$ENDIF}
{$IFDEF LINUX}
  ShareExcept,
{$ENDIF}
{$ENDIF}
{$IFDEF MSWINDOWS}
  Windows,
{$ENDIF}
  orb,
  orb_int,
  poa_int,
  poa_impl,
  SysUtils,
  hello in 'hello.pas',
  hello_int in 'hello_int.pas';

var
  lib: THandle;

procedure main();
var
  poa : IPOA;
  obj : IORBObject;
  h : IHello;
  dorb: IORB;
  init_server : procedure;
begin
  dorb := ORB_Init(nil);
  @init_server := GetProcAddress(lib,'init_server');
  if @init_server = nil then
    begin
      writeln('Procedure "init_server" not found in server.dll');
      exit;
    end;
  init_server;
  obj := dorb.resolve_initial_reference('RootPOA');
  assert(obj <> nil);
  poa := POA_narrow(obj);
  poa.the_POAManager.activate;
  assert(poa <> nil);
  obj := poa.id_to_reference('HelloServer');
  assert(obj <> nil);
  h := THello._narrow(obj);
  assert(h <> nil);
  h.hello('Hello World');
  dorb._destroy();
end;

begin
  lib := LoadLibrary({$IFDEF MSWINDOWS}'server.dll'{$ENDIF}{$IFDEF LINUX}'libserver.so'{$ENDIF});
  if lib = 0 then
    writeln('Can`t load server.dll')
  else
    try
      main;
    finally
      FreeLibrary(lib);
    end;
end.
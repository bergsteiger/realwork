library server;

uses
{$IFDEF MSWINDOWS}
  ShareMem,
{$ENDIF}
{$IFDEF LINUX}
  ShareExcept,
{$ENDIF}
  poa_int,
  poa_impl,
  orb,
  orb_int,
  SysUtils,
  Classes,
  hserver in 'hserver.pas',
  hello_int in 'hello_int.pas',
  hello in 'hello.pas';

{$R *.res}

var
  poa : IPOA;

procedure init_server;
var
  dorb : IORB;
  obj : IORBObject;
begin
  dorb := ORB_Instance;
  obj := dorb.resolve_initial_reference('RootPOA');
  assert(obj <> nil);
  poa := POA_narrow(obj);
  assert(poa <> nil);
  poa.activate_object_with_id('HelloServer',THello_impl.create as IServant);
end;

procedure stop_server;
begin
  poa.deactivate_object('HelloServer');
end;

exports
  init_server,
  stop_server;
begin
end.

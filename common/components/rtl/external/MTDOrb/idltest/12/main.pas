unit main;

interface

uses
  orb_int,orb,req_int,code_int,imr,imr_int,env_int,except_int,types,
  stdstat,std_seq,poa,poa_int,value_int,classes,union_int, union;

type

  Tfoo_impl = class(Tfoo_stub)
    procedure bar(const x: IU; out y: IU; out z: IU2); override;
  end;

 procedure mainproc;

implementation

uses
  ior,
  iior_int,
  sysutils,
  boa_int;

//***********************************************************
// foo_impl
//***********************************************************
procedure Tfoo_impl.bar(const x: IU; out y: IU; out z: IU2);
begin
  if x.discriminator = 3 then
    writeln(x.get_z);
  y := TU.Create;
  y.set_x(1234);
  z := TU2.Create;
  z.set_y(22);
end;

procedure mainproc;
var
  dorb : IORB;
  foo_impl : TFoo_impl;
  ref: AnsiString;
  foo_client : IFoo;
  obj : IORBObject;
  u1,u2 : IU;
  u3 : IU2;
begin
  dorb := ORB_Init(nil);
  foo_impl := TFoo_impl.Create;
  ref := dorb.object_to_string(foo_impl);
{$DEFINE FORCE_MARSHALLING}
{$IFDEF FORCE_MARSHALLING}
  obj := TORBObject.Create(IIOR(TIOR.Create(ref)));
{$ELSE}
  obj := dorb.string_to_object(ref);
{$ENDIF}
  foo_client := TFoo._narrow(obj);
  u1 := TU.Create;
  u3 := TU2.Create;
  u1.set_z('Hello');
  foo_client.bar(u1,u2,u3);
  if u2.discriminator = 1 then
    writeln(inttostr(u2.get_x));
  if u3.discriminator = B then
    writeln(inttostr(u3.get_y));
end;

end.

unit main;

interface

uses
  orb_int,orb,req_int,code_int,imr,imr_int,env_int,except_int,types,
  stdstat,std_seq,poa,poa_int,value_int,classes,enum_int, enum;

type

  Tfoo_impl = class(Tfoo_stub)
    procedure bar(const e: TE); override;
  end;

  procedure mainproc;

implementation

uses
  ior,
  iior_int,
  sysutils;

//***********************************************************
// foo_impl
//***********************************************************
procedure Tfoo_impl.bar(const e: TE);
begin
  case e of
    A : writeln('A');
    B : writeln('B');
    C : writeln('C');
  end;
end;

procedure mainproc;
var
  dorb : IORB;
  impl: Tfoo_impl;
  ref: AnsiString;
  obj: IORBObject;
  foo_client : Ifoo;
begin
  dorb := ORB_Init(nil);
  impl := Tfoo_impl.Create;
  ref := dorb.object_to_string(impl);
{$DEFINE FORCE_MARSHALLING}
{$IFDEF FORCE_MARSHALLING}
  obj := TORBObject.Create(IIOR(TIOR.Create(ref)));
{$ELSE}
  obj := dorb.string_to_object(ref);
{$ENDIF}
  foo_client := Tfoo._narrow(obj);
  foo_client.bar(B);
end;

end.

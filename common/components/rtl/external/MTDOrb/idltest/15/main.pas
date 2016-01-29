unit main;

interface

uses
  orb_int,orb,req_int,code_int,imr,imr_int,env_int,except_int,types,
  stdstat,std_seq,poa,poa_int,value_int,classes,a_int, a, b_int;

type

  TA_foo_impl = class(TA_foo_stub)
  protected
    procedure bar(const x: TA_BSSeq); override;
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
procedure TA_foo_impl.bar(const x: TA_BSSeq);
var
  i,j : integer;
begin
  i := Length(x);
  for j := 0 to pred(i) do
    with x[j] do
      writeln(IntToStr(x));
end;

procedure mainproc;
var
  dorb : IORB;
  foo_impl : TA_Foo_impl;
  ref: AnsiString;
  foo_client : IA_Foo;
  obj : IORBObject;
  x : TA_BSSeq;
  i : integer;
begin
  dorb := ORB_Init(nil);
  foo_impl := TA_Foo_impl.Create;
  ref := dorb.object_to_string(foo_impl);
{$DEFINE FORCE_MARSHALLING}
{$IFDEF FORCE_MARSHALLING}
  obj := TORBObject.Create(IIOR(TIOR.Create(ref)));
{$ELSE}
  obj := dorb.string_to_object(ref);
{$ENDIF}
  foo_client := TA_Foo._narrow(obj);
  setLength(x,10);
  for i := 0 to 9 do
    x[i].x := i+1;
  foo_client.bar(x);
end;

end.

unit main;

interface

uses
  orb_int,orb,req_int,code_int,imr,imr_int,env_int,except_int,types,
  stdstat,std_seq,poa,poa_int,value_int,classes, objref_int,objref;

type

  Tfoo_impl = class(Tfoo_stub)
    procedure hello(const name: AnsiString); override;
  end;

  Tbar_impl = class(Tbar_stub)
    function run(const obj: Ifoo): Ifoo; override;
    procedure run1(const obj: TObjectAlias); override;
    procedure run2(const s: TS); override;
    procedure run3(const s: TfooSeq); override;
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
procedure Tfoo_impl.hello(const name: AnsiString);
begin
  writeln('Hello '+name);
end;

//***********************************************************
// bar_impl
//***********************************************************
function Tbar_impl.run(const obj: Ifoo): Ifoo;
begin
  obj.hello('Test1');
  result := obj
end;

procedure Tbar_impl.run1(const obj: TObjectAlias);
var
  f: IFoo;
begin
  f := TFoo._narrow(obj);
  f.hello('Test2');
end;

procedure Tbar_impl.run2(const s: TS);
begin
  writeln(inttostr(s.x));
  s.obj.hello('Test3');
end;

procedure Tbar_impl.run3(const s: TfooSeq);
var
  i : integer;
begin
  for i := 0 to Pred(Length(s)) do
    s[i].hello('Test4');
end;

procedure mainproc;
var
  dorb : IORB;
  foo: Tfoo_impl;
  bar: Tbar_impl;
  foo_ref, bar_ref: AnsiString;
  obj: IORBObject;
  foo_client,foo_res : Ifoo;
  bar_client : Ibar;
  s : TS;
  seq: TfooSeq;
begin
  dorb := ORB_Init(nil);
  foo := Tfoo_impl.Create;
  bar := Tbar_impl.Create;
  foo_ref := dorb.object_to_string(foo);
  bar_ref := dorb.object_to_string(bar);
{$IFDEF FORCE_MARSHALLING}
  obj := TORBObject.Create(TIOR.Create(foo_ref));
{$ELSE}
  obj := dorb.string_to_object(foo_ref);
{$ENDIF}
  foo_client := Tfoo._narrow(obj);

{$IFDEF FORCE_MARSHALLING}
  obj := TORBObject.Create(TIOR.Create(bar_ref));
{$ELSE}
  obj := dorb.string_to_object(bar_ref);
{$ENDIF}
  bar_client := Tbar._narrow(obj);
  foo_res := bar_client.run(foo_client);
  bar_client.run1(foo_res as IORBObject);
  s.x := 2000;
  s.obj := foo_client;
  bar_client.run2(s);
  setlength(seq,2);
  seq[0] := foo_client;
  seq[1] := foo_client;
  bar_client.run3(seq);
end;
end.

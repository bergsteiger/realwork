unit main;

interface

uses
  orb_int,orb,req_int,code_int,imr,imr_int,env_int,except_int,types,
  stdstat,std_seq,poa,poa_int,value_int,classes,struct_int, struct;

type

  Tfoo_impl = class(Tfoo_stub)
    function bar(const s1: TS; out s2: TS; var s3: TS): TS; override;
    function bar1(const s1: TS2; out s2: TS2; var s3: TS2): TS2; override;
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
function Tfoo_impl.bar(const s1: TS; out s2: TS; var s3: TS): TS;
begin
  writeln(inttostr(s1.a));
  writeln(inttostr(s1.b));
  writeln(s1.c);

  writeln(inttostr(s3.a));
  writeln(inttostr(s3.b));
  writeln(s3.c);

  s2 := s3;
  s3 := s1;
  result := s1;
end;

function Tfoo_impl.bar1(const s1: TS2; out s2: TS2; var s3: TS2): TS2;
begin
  writeln(s1.a);
  writeln(inttostr(s1.x.a));
  writeln(inttostr(s1.x.b));
  writeln(s1.x.c);

  writeln(s3.a);
  writeln(inttostr(s3.x.a));
  writeln(inttostr(s3.x.b));
  writeln(s3.x.c);

  s2 := s3;
  s3 := s1;

  result := s1;
end;

{$DEFINE FORCE_MARSHALLING}

procedure mainproc;
var
  dorb : IORB;
  impl: Tfoo_impl;
  ref: AnsiString;
  obj: IORBObject;
{$IFDEF FORCE_MARSHALLING}
  _ior: IIOR;
{$ENDIF}
  foo : Ifoo;
  s1,s2,s3,s4: TS;
  _s1,_s2,_s3,_s4: TS2;
begin
  assign(output,'');
  dorb := ORB_Init(nil);
  impl := Tfoo_impl.Create;
  ref := dorb.object_to_string(impl);
{$IFDEF FORCE_MARSHALLING}
  _ior := TIOR.Create();
  if _ior.from_string(ref) then
    obj := TORBObject.Create(_ior)
  else
    exit;
{$ELSE}
  obj := dorb.string_to_object(ref);
{$ENDIF}
  foo := Tfoo._narrow(obj);
  s1.a := 50;
  s1.b := 100;
  s1.c := 'a';
  s1.a := 10;
  s1.b := 300;
  s1.c := 'S';
  s4 := foo.bar(s1,s2,s3);

  writeln(inttostr(s2.a));
  writeln(inttostr(s2.b));
  writeln(s2.c);

  writeln(inttostr(s3.a));
  writeln(inttostr(s3.b));
  writeln(s3.c);

  writeln(inttostr(s4.a));
  writeln(inttostr(s4.b));
  writeln(s4.c);


  _s1.a := 'String1';
  _s1.x.a := 23;
  _s1.x.b := 123;
  _s1.x.c := '1';

  _s3.a := 'String2';
  _s3.x.a := 30;
  _s3.x.b := 300;
  _s3.x.c := 'd';

  _s4 := foo.bar1(_s1,_s2,_s3);

  writeln(_s2.a);
  writeln(inttostr(_s2.x.a));
  writeln(inttostr(_s2.x.b));
  writeln(_s2.x.c);

  writeln(_s4.a);
  writeln(inttostr(_s4.x.a));
  writeln(inttostr(_s4.x.b));
  writeln(_s4.x.c);

end;

end.

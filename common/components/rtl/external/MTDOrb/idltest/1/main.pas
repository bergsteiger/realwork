unit main;

interface

uses
  orb_int,orb,req_int,code_int,imr,imr_int,env_int,except_int,types,
  stdstat,std_seq,poa,poa_int,value_int,classes,struct_int, struct;

type

  Tfoo_impl = class(Tfoo_serv)
    procedure bar(const s1: TS; out s2: TS); override;
    procedure bar2(const s: TS2); override;
    function bar3: TS2; override;
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
procedure Tfoo_impl.bar(const s1: TS; out s2: TS);
begin
  writeln(inttostr(s1.a));
  writeln(inttostr(s1.b));
  writeln(s1.c);
  s2 := s1;
end;

procedure Tfoo_impl.bar2(const s: TS2);
begin
  writeln(inttostr(s.a));
  writeln(inttostr(s.x.a));
  writeln(inttostr(s.x.b));
  writeln(s.x.c);
end;

function Tfoo_impl.bar3: TS2;
begin
  result.a := 42;
  result.x.a := 12;
  result.x.b := 24;
  result.x.c := 'x';
end;

//{$DEFINE FORCE_MARSHALLING}

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
  s1,s2: TS;
begin
  assign(output,'');
  dorb := ORB_Init(nil);
  impl := Tfoo_impl.Create;
  ref := dorb.object_to_string(impl._this() as IORBObject);
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
  foo.bar(s1,s2);
  writeln(inttostr(s2.a));
  writeln(inttostr(s2.b));
  writeln(s2.c);

end;

end.

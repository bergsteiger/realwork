unit main;

interface

uses
  orb_int,orb,req_int,code_int,imr,imr_int,env_int,except_int,types,
  stdstat,std_seq,poa,poa_int,value_int,classes,typedef_int, typedef;

type

  Tfoo_impl = class(Tfoo_stub)
    procedure bar1(const s: AnsiString); override;
    procedure bar2(const l: Tfoo_L); override;
    procedure bar3(const s: Tfoo_S); override;
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
procedure Tfoo_impl.bar1(const s: AnsiString);
begin
  writeln(s);
end;

procedure Tfoo_impl.bar2(const l: Tfoo_L);
begin
  writeln(inttostr(l));
end;

procedure Tfoo_impl.bar3(const s: Tfoo_S);
begin
  writeln(inttostr(s.a));
  writeln(s.b);
end;

procedure mainproc;
var
  dorb : IORB;
  impl: Tfoo_impl;
  ref: AnsiString;
  obj: IORBObject;
  _ior: IIOR;
  foo : Ifoo;
  s: TFoo_s;
begin
  dorb := ORB_Init(nil);
  impl := Tfoo_impl.Create;
  ref := dorb.object_to_string(impl);
  _ior := TIOR.Create();
  if _ior.from_string(ref) then
    begin
      obj := TORBObject.Create(_ior);
      foo := Tfoo._narrow(obj);
      foo.bar1('test');
      foo.bar2(2000);
      s.a := 12;
      s.b := 'c';
      foo.bar3(s);
    end;
end;

end.

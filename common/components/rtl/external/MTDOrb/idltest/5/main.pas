unit main;

interface

uses
  orb_int,orb,req_int,code_int,imr,imr_int,env_int,except_int,types,
  stdstat,std_seq,poa,poa_int,value_int,classes,module_int, module;

type

  TM_foo_impl = class(TM_foo_stub)
    procedure bar(const e: TM_foo_E); override;
  end;

  TM2_foo_impl = class(TM2_foo_stub)
    procedure bar(const e: TM_foo_E); override;
  end;

  procedure mainproc;

implementation

uses
  ior,
  iior_int,
  sysutils;

//***********************************************************
// M_foo_impl
//***********************************************************
procedure TM_foo_impl.bar(const e: TM_foo_E);
begin
  case e of
    A: writeln('A');
    B: writeln('B');
    C: writeln('C');
  end;
end;

//***********************************************************
// M2_foo_impl
//***********************************************************
procedure TM2_foo_impl.bar(const e: TM_foo_E);
begin
  case e of
    A: writeln('A');
    B: writeln('B');
    C: writeln('C');
  end;
end;


procedure mainproc;
var
  dorb : IORB;
  impl: TM_foo_impl;
  impl2 : TM2_foo_impl;
  ref: AnsiString;
  obj: IORBObject;
  _ior: IIOR;
  foo : IM_foo;
  foo2 : IM2_foo;
begin
  dorb := ORB_Init(nil);
  impl := TM_foo_impl.Create;
  impl2 := TM2_foo_impl.Create;
  ref := dorb.object_to_string(impl);
  _ior := TIOR.Create();
  if _ior.from_string(ref) then
    begin
      obj := TORBObject.Create(_ior);
      foo := TM_foo._narrow(obj);
      foo.bar(A);
    end;
  ref := dorb.object_to_string(impl2);
  _ior := TIOR.Create();
  if _ior.from_string(ref) then
    begin
      obj := TORBObject.Create(_ior);
      foo2 := TM2_foo._narrow(obj);
      foo2.bar(C);
    end;
end;

end.

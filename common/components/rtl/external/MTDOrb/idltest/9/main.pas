unit main;

interface

uses
  orb_int,orb,req_int,code_int,imr,imr_int,env_int,except_int,types,
  stdstat,std_seq,poa,poa_int,value_int,classes,inheritance_int, inheritance;

type

  TBase_impl = class(TBase_stub)
    procedure op1; override;
  end;

  TDerived_impl = class(TDerived_stub)
    procedure op1; override;
    procedure op2; override;
  end;

  TFinal_impl = class(TFinal_stub)
    procedure op1; override;
    procedure op2; override;
    procedure op3; override;
  end;

  procedure mainproc;

implementation

uses
  ior,
  iior_int,
  sysutils,
  boa_int;

//***********************************************************
// Base_impl
//***********************************************************
procedure TBase_impl.op1;
begin
  writeln('Base::op1');
end;

//***********************************************************
// Derived_impl
//***********************************************************
procedure TDerived_impl.op1;
begin
  writeln('Derived::op1');
end;

procedure TDerived_impl.op2;
begin
  writeln('Derived::op2');
end;


//***********************************************************
// Final_impl
//***********************************************************
procedure TFinal_impl.op1;
begin
  writeln('Final::op1');
end;

procedure TFinal_impl.op2;
begin
  writeln('Final::op2');
end;

procedure TFinal_impl.op3;
begin
  writeln('Final::op3');
end;



procedure mainproc;
var
  dorb : IORB;
  base: TBase_impl;
  derived: TDerived_impl;
  final : TFinal_impl;
  base_ref, derived_ref, final_ref: AnsiString;
  base_client : IBase;
  derived_client: IDerived;
  final_client : IFinal;
  obj : IORBObject;
begin
  dorb := ORB_Init(nil);
  base := TBase_impl.Create;
  derived := TDerived_impl.Create;
  final := TFinal_impl.Create;
  base_ref := dorb.object_to_string(base);
  derived_ref := dorb.object_to_string(derived);
  final_ref := dorb.object_to_string(final);

{$IFDEF FORCE_MARSHALLING}
  obj := TORBObject.Create(TIOR.Create(base_ref));
{$ELSE}
  obj := dorb.string_to_object(base_ref);
{$ENDIF}
  base_client := TBase._narrow(obj);

{$IFDEF FORCE_MARSHALLING}
  obj := TORBObject.Create(TIOR.Create(derived_ref));
{$ELSE}
  obj := dorb.string_to_object(derived_ref);
{$ENDIF}
  derived_client := TDerived._narrow(obj);

{$IFDEF FORCE_MARSHALLING}
  obj := TORBObject.Create(TIOR.Create(final_ref));
{$ELSE}
  obj := dorb.string_to_object(final_ref);
{$ENDIF}
  final_client := TFinal._narrow(obj);


  base_client.op1;
  derived_client.op1;
  derived_client.op2;
  final_client.op1;
  final_client.op2;
  final_client.op3;

  assert((derived_client as IORBObject)._is_a('IDL:Base:1.0'));
  assert(not (base_client as IORBObject)._is_a('IDL:Derived:1.0'));
  assert((final_client as IORBObject)._is_a('IDL:Derived:1.0'));
  assert((final_client as IORBObject)._is_a('IDL:Final:1.0'));
end;

end.

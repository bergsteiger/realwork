unit main;

interface

uses
  orb_int,orb,req_int,code_int,imr,imr_int,env_int,except_int,types,
  stdstat,std_seq,poa,poa_int,value_int,classes, attribute_int,attribute;

type

  Tfoo_impl = class(Tfoo_stub)
  private
    a1: longint;
    a2: AnsiChar;
  protected
    function _get_attr1: longint; override;
    procedure _set_attr2(const val: AnsiChar); override;
    function _get_attr2: AnsiChar; override;
  public
    constructor Create();
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
constructor Tfoo_impl.Create;
begin
  inherited;
  a1 := 2000
end;

function Tfoo_impl._get_attr1: longint;
begin
  result := a1;
end;

procedure Tfoo_impl._set_attr2(const val: AnsiChar);
begin
  a2 := val;
end;

function Tfoo_impl._get_attr2: AnsiChar;
begin
  result := a2;
end;


procedure mainproc;
var
  dorb : IORB;
  foo: Tfoo_impl;
  foo_ref: AnsiString;
  obj: IORBObject;
  foo_client : Ifoo;
begin
  dorb := ORB_Init(nil);
  foo := Tfoo_impl.Create;
  foo_ref := dorb.object_to_string(foo);
{$IFDEF FORCE_MARSHALLING}
  obj := TORBObject.Create(TIOR.Create(foo_ref));
{$ELSE}
  obj := dorb.string_to_object(foo_ref);
{$ENDIF}
  foo_client := Tfoo._narrow(obj);

  writeln('attr1: '+inttostr(foo_client._get_attr1));
  foo_client._set_attr2('s');
  writeln('attr2: '+foo_client._get_attr2);
end;

end.

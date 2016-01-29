unit main;

interface
uses
  orb_int,orb,req_int,code_int,imr,imr_int,env_int,except_int,types,
  stdstat,std_seq,poa,poa_int,value_int,classes,orbtypes,attr_int,attr;

type
  Tinf1_impl = class(Tinf1_serv)
  protected
    function _get_attr1: long; override;
    procedure _set_attr2(const val: long); override;
    function _get_attr2: long; override;
    function _get_attr3: long; override;
    procedure _set_attr4(const val: long); override;
    function _get_attr4: long; override;
  end;

  procedure mainproc;

implementation

uses
  ior,
  iior_int,
  sysutils;

//{$DEFINE FORCE_MARSHALLING}

procedure mainproc;
var
  dorb : IORB;
  impl: Tinf1_impl;
  ref: AnsiString;
  obj: IORBObject;
{$IFDEF FORCE_MARSHALLING}
  _ior: IIOR;
{$ENDIF}
  foo : Iinf1;
  i: Integer;
begin
  assign(output,'');
  dorb := ORB_Init(nil);
  dorb.resolve_initial_reference('RootPOA');
  the_root_poa.the_POAManager.activate;
  impl := Tinf1_impl.Create;
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
  foo := Tinf1._narrow(obj);
  i := foo.attr1;
  WriteLn(i);
end;

{ Tinf1_impl }

function Tinf1_impl._get_attr1: long;
begin
  Result := 1;
end;

function Tinf1_impl._get_attr2: long;
begin
  Result := 2;
end;

function Tinf1_impl._get_attr3: long;
begin
  Result := 3;
end;

function Tinf1_impl._get_attr4: long;
begin
  Result := 4;
end;

procedure Tinf1_impl._set_attr2(const val: long);
begin

end;

procedure Tinf1_impl._set_attr4(const val: long);
begin

end;

end.

unit main;

interface

uses
  orb_int,orb,req_int,code_int,imr,imr_int,env_int,except_int,types,
  stdstat,std_seq,poa,poa_int,value_int,classes,
  pseudo_int, pseudo;

type

  Tfoo_impl = class(Tfoo_stub)
    function bar(const a1: IAny; out a2: IAny; var a3: IAny): IAny; override;
    function bar1(const tc1: ITypeCode; out tc2: ITypeCode; var tc3: ITypeCode): ITypeCode; override;
    function bar2(const rtype: IAny): IAny; override;
  end;

  Tv_factory = class(Tv_init)
    function init(ve: TE): Iv; override;
    function create_for_umarshal(): IValueBase; override;
  end;

  procedure mainproc;

implementation

uses
  ior,
  iior_int,
  sysutils,
  boa_int,
  any,
  tcode,
  static;

procedure show_any(a : IAny);
var
  s1 : TS1;
  s2 : TS2;
  e : TE;
  seq: TSeq;
  i : integer;
  v : Iv;
begin
  if any_to_S1(a,s1) then
    writeln('Struct S1: '+inttostr(s1.x)+','+Char(s1.c))
  else if any_to_S2(a,s2) then
    writeln('Struct S2: '+s2.str)
  else if any_to_E(a,e) then
    case e of
      e1:  writeln('Enumeration E: e1');
      e2:  writeln('Enumeration E: e2');
      e3:  writeln('Enumeration E: e3');
      e4:  writeln('Enumeration E: e4');
      e5:  writeln('Enumeration E: e5');
    end
  else if any_to_S2_seq(a,seq) then
    begin
      writeln('Sequence seq:');
      for i := 0 to Pred(Length(seq)) do writeln('  '+seq[i].str);
    end
  else if any_to_v(a,v) then
    begin
      writeln('Valuetype v:');
      case v.ve of
        e1:  writeln('  ve: e1');
        e2:  writeln('  ve: e2');
        e3:  writeln('  ve: e3');
        e4:  writeln('  ve: e4');
        e5:  writeln('  ve: e5');
      end;
      writeln('  vs: '+inttostr(v.vs.x)+','+Char(v.vs.c))
    end;
end;

//*********************************************************************
//  Tv_factory
//*********************************************************************
function Tv_factory.create_for_umarshal: IValueBase;
begin
  result := Tv.Create();
end;

function Tv_factory.init(ve: TE): Iv;
begin
  result := Tv.Create();
  result.ve(ve);
end;

//***********************************************************
// foo_impl
//***********************************************************
function Tfoo_impl.bar(const a1: IAny; out a2: IAny; var a3: IAny): IAny;
var
  s1 : TS1;
begin
  show_any(a1);
  show_any(a3);
  a2 := TAny.Create();
  a2.copy(a1);
  s1.x := 500;
  s1.c := 'S';
  a3 := S1_to_any(s1);
  result := TAny.Create();
  result.copy(a1);
end;

function Tfoo_impl.bar1(const tc1: ITypeCode; out tc2: ITypeCode; var tc3: ITypeCode): ITypeCode;
begin
  writeln('TCKind of tc1:'+IntToStr(Ord(tc1.kind)));
  writeln('TCKind of tc3:'+IntToStr(Ord(tc3.kind)));
  tc2 := TTypeCode.Create(tc1);
  tc3 := _tc_short;
  result := _tc_long;
end;

function Tfoo_impl.bar2(const rtype: IAny): IAny;
var
  result_type : Tresult_type;
  seq: TSeq;
  ret: Iv;
  _vs : TS1;
begin
  result := nil;
  if not any_to_result_type(rtype,result_type) then exit;
  case result_type of
    t_enum : result := E_to_any(e4);
    t_seq : begin
        setLength(seq,3);
        seq[0].str := 'A';
        seq[1].str := 'B';
        seq[2].str := 'C';
        result := S2_seq_to_any(seq);
      end;
    t_val : begin
        ret := Tv.Create();
        ret.ve(e2);
        _vs.x := 2000;
        _vs.c := 'X';
        ret.vs(_vs);
        result := v_to_any(ret);
      end;
  end;
end;

procedure mainproc;
var
  dorb: IORB;
  foo : Ifoo;
  ref: AnsiString;
  obj : IORBObject;
  impl : TFoo_impl;
  a1,a2,a3,a_result : IAny;
  s : TS1;
  s2 : TS2;
  tc2,tc3,tc_result : ITypeCode;
begin
  dorb := ORB_Init(nil);
  impl := Tfoo_impl.Create();
  ref := dorb.object_to_string(impl);
  dorb.register_value_factory('IDL:v:1.0',TV_factory.Create);
{$DEFINE FORCE_MARSHALLING}
{$IFDEF FORCE_MARSHALLING}
  obj := TORBObject.Create(IIOR(TIOR.Create(ref)));
{$ELSE}
  obj := dorb.string_to_object(ref);
{$ENDIF}
  foo := TFoo._narrow(obj);

  s2.str := 'Hello';
  a1 := S2_to_any(s2);
  a3 := S2_to_any(s2);
  a_result := foo.bar(a1,a2,a3);
  show_any(a2);
  show_any(a3);
  show_any(a_result);

  s.x := 333;
  s.c := 'R';
  a1 := S1_to_any(s);
  a3.copy(a3);
  a_result := foo.bar(a1,a2,a3);
  show_any(a2);
  show_any(a3);
  show_any(a_result);

  tc3 := _tc_octet;
  tc_result := foo.bar1(_tc_char,tc2,tc3);
  writeln('TCKind of result:'+IntToStr(Ord(tc_result.kind)));
  writeln('TCKind of tc2:'+IntToStr(Ord(tc2.kind)));
  writeln('TCKind of tc3:'+IntToStr(Ord(tc3.kind)));

  show_any(foo.bar2(result_type_to_any(t_enum)));
  show_any(foo.bar2(result_type_to_any(t_seq)));
  show_any(foo.bar2(result_type_to_any(t_val)));
end;

end.

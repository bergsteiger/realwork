unit main;

interface

uses
  orb_int,orb,req_int,code_int,imr,imr_int,env_int,except_int,types,
  stdstat,std_seq,poa,poa_int,value_int,classes,forward_int, forward;

type

  TB_impl = class(TB_stub)
  private
    count : integer;
  protected
    procedure op(const a: IA); override;
  public
    constructor Create();
  end;

  TA_impl = class(TA_stub)
  private
    count : integer;
  protected
    procedure op(const b: IB); override;
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
// B_impl
//***********************************************************
constructor TB_impl.Create;
begin
  inherited;
  count := 0;
end;

procedure TB_impl.op(const a: IA);
begin
  if count < 3 then
    begin
      writeln('B::op() ['+inttostr(count)+']');
      inc(count);
      a.op(self);
    end;
end;

//***********************************************************
// A_impl
//***********************************************************
constructor TA_impl.Create;
begin
  inherited;
  count := 0;
end;

procedure TA_impl.op(const b: IB);
begin
  if count < 3 then
    begin
      writeln('A::op() ['+inttostr(count)+']');
      inc(count);
      b.op(self);
    end;
end;

procedure mainproc;
var
  dorb : IORB;
  b: TB_impl;
  a: TA_impl;
  a_ref, b_ref: AnsiString;
  a_client : IA;
  b_client: IB;
  obj : IORBObject;
begin
  dorb := ORB_Init(nil);
  a := TA_impl.Create;
  b := TB_impl.Create;
  a_ref := dorb.object_to_string(a);
  b_ref := dorb.object_to_string(b);
{$DEFINE FORCE_MARSHALLING}
{$IFDEF FORCE_MARSHALLING}
  obj := TORBObject.Create(IIOR(TIOR.Create(a_ref)));
{$ELSE}
  obj := dorb.string_to_object(a_ref);
{$ENDIF}
  a_client := TA._narrow(obj);

{$IFDEF FORCE_MARSHALLING}
  obj := TORBObject.Create(IIOR(TIOR.Create(b_ref)));
{$ELSE}
  obj := dorb.string_to_object(b_ref);
{$ENDIF}
  b_client := TB._narrow(obj);

  a.op(b_client);

end;

end.

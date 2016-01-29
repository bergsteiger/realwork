unit common;

interface

uses
  orb_int,orb,req_int,stdstat,code_int,imr,imr_int,env_int,exceptions,
  except_int,types,poa,poa_int;

type

  IBench = interface
    procedure f();
    procedure g();
    procedure sync();
    procedure connect(const b: IBench; level: longint);
  end;

  TBench = class(TORBObject,IBench)
  protected
    procedure f(); virtual; abstract;
    procedure g(); virtual; abstract;
    procedure sync(); virtual; abstract;
    procedure connect(const b: IBench; level: longint); virtual; abstract;
    function narrow_helper(const str: string): Pointer; override;
  public
    class function _narrow(const obj : IORBObject): IBench;
    class function narrow_helper2(const obj: IORBObject): Boolean;
  end;

  TBench_stub = class(TBench,IORBObject,IBench)
  protected
    procedure f(); override;
    procedure g(); override;
    procedure sync(); override;
    procedure connect(const b: IBench; level: longint); override;
  end;

  TBench_skel = class(TStaticMethodDispatcher,IStaticInterfaceDispatcher,IBench)
  protected
    procedure f(); virtual; abstract;
    procedure g(); virtual; abstract;
    procedure sync(); virtual; abstract;
    procedure connect(const b: IBench; level: longint); virtual; abstract;
    function _dispatch(const req: IStaticServerRequest): Boolean;
  public
    constructor Create();
  end;

  TPOA_Bench = class(TPOAStaticImplementation,IPOAStaticImplementation,IServant,IBench)
  protected
    procedure f(); virtual; abstract;
    procedure g(); virtual; abstract;
    procedure sync(); virtual; abstract;
    procedure connect(const b: IBench; level: longint); virtual; abstract;
    procedure invoke(const req: IStaticServerRequest); override;
    function _dispatch(const req: IStaticServerRequest): Boolean;
    function _primary_interface(const objid: string; const poa: IPOA): string; override;
    function _is_a(const repoid: string): Boolean; override;
    function _make_stub(const poa: IPOA; const obj : IORBObject): IORBObject; override;
  end;

  TBench_stub_clp = class(TPOAStub)

  end;


  TBench_marshaller = class(TAbstractStat,IStaticTypeInfo)
  protected
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    function typecode(): ITypeCode;
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

implementation

uses
  req,static,throw;

var
  _marshaller_Bench : IStaticTypeInfo;

//*********************************************************************
//  TBench
//*********************************************************************
function TBench.narrow_helper(const str: string): Pointer;
begin
  if str = 'IDL:Bench:1.0' then
    result := Pointer(IBench(self))
  else
    result := nil;
end;

class function TBench.narrow_helper2(const obj: IORBObject): Boolean;
begin
  result := obj.repoid = 'IDL:Bench:1.0';
end;

class function TBench._narrow(const obj: IORBObject): IBench;
var
  p : Pointer;
  stub : TBench_stub;
begin
  result := nil;
  if obj = nil then exit;
  p := obj.narrow_helper('IDL:Bench:1.0');
  if p <> nil then
    result := IBench(p)
  else
    begin
      if narrow_helper2(obj) or obj._is_a_remote('IDL:Bench:1.0') then
        begin
          stub := TBench_stub.Create();
          stub.assign(obj);
          result := stub;
        end;
    end;
end;

//*********************************************************************
//  TBench_stub
//*********************************************************************
procedure TBench_stub.connect(const b: IBench; level: Integer);
var
  req : IStaticRequest;
  _level : IStaticAny;
  _b : IStaticAny;
begin
  _b := TStaticAny.Create(_marshaller_Bench,@b);
  _level := TStaticAny.Create(stat_ulong,@level);
  req := TStaticRequest.Create(self,'connect');
  req.add_in_arg(_b);
  req.add_in_arg(_level);
  req.invoke;
  dorb_static_throw(req);
end;

procedure TBench_stub.f;
var
  req : IStaticRequest;
begin
  req := TStaticRequest.Create(self,'f');
  req.invoke;
  dorb_static_throw(req);
end;

procedure TBench_stub.g;
var
  req : IStaticRequest;
begin
  req := TStaticRequest.Create(self,'g');
  req.invoke;
  dorb_static_throw(req);
end;

procedure TBench_stub.sync;
var
  req : IStaticRequest;
begin
  req := TStaticRequest.Create(self,'sync');
  req.invoke;
  dorb_static_throw(req);
end;

//*********************************************************************
//  TBench_marshaller
//*********************************************************************
procedure TBench_marshaller._create(var addr: Pointer);
begin
  IBench(addr^) := TBench.Create();
end;

procedure TBench_marshaller._free(var addr: Pointer);
begin
  IBench(addr^) := nil;
end;

function TBench_marshaller.demarshal(dec: IDecoder;
  const addr: Pointer): Boolean;
var
  obj : IORBObject;
begin
  result := false;
  if not stat_Object.demarshal(dec,@obj) then exit;
  IBench(addr^) := TBench._narrow(obj);
  result := (obj = nil) or (Pointer(addr^) <> nil);
end;

procedure TBench_marshaller.marshal(enc: IEncoder; const addr: Pointer);
begin
  stat_Object.marshal(enc,addr);
end;

function TBench_marshaller.typecode: ITypeCode;
begin
  result := nil;
end;

//*********************************************************************
//  TBench_skel
//*********************************************************************
constructor TBench_skel.Create;
var
  impl: IImplementationDef;
begin
  inherited Create();
  impl := find_impl('IDL:Bench:1.0','Bench');
  create_ref('',nil,impl,'IDL:Bench:1.0');
  register_dispatcher(IStaticInterfaceDispatcher(self));
end;

function TBench_skel._dispatch(const req: IStaticServerRequest): Boolean;
var
  b : IBench;
  _b : IStaticAny;
  level: longint;
  _level : IStaticAny;
begin
  result := true;
  if req.op_name = 'sync' then
    begin
      if not req.read_args then exit;
      sync();
      req.write_results();
    end
  else if req.op_name = 'connect' then
    begin
      _b := TStaticAny.Create(_marshaller_Bench,@b);
      _level := TStaticAny.Create(stat_ulong,@level);
      req.add_in_arg(_b);
      req.add_in_arg(_level);
      if not req.read_args then exit;
      connect(b,level);
      req.write_results();
    end
  else if req.op_name = 'f' then
    begin
      if not req.read_args then exit;
      f();
      req.write_results();
    end
  else if req.op_name = 'g' then
    begin
      if not req.read_args then exit;
      g();
      req.write_results();
    end;
end;

//*********************************************************************
//  TPOA_Bench
//*********************************************************************
function TPOA_Bench._dispatch(const req: IStaticServerRequest): Boolean;
var
  b : IBench;
  _b : IStaticAny;
  level: longint;
  _level : IStaticAny;
begin
  result := true;
  if req.op_name = 'sync' then
    begin
      if not req.read_args then exit;
      sync();
      req.write_results();
    end
  else if req.op_name = 'connect' then
    begin
      _b := TStaticAny.Create(_marshaller_Bench,@b);
      _level := TStaticAny.Create(stat_ulong,@level);
      req.add_in_arg(_b);
      req.add_in_arg(_level);
      if not req.read_args then exit;
      connect(b,level);
      req.write_results();
    end
  else if req.op_name = 'f' then
    begin
      if not req.read_args then exit;
      f();
      req.write_results();
    end
  else if req.op_name = 'g' then
    begin
      if not req.read_args then exit;
      g();
      req.write_results();
    end;
end;

procedure TPOA_Bench.invoke(const req: IStaticServerRequest);
begin
  if _dispatch(req) then exit;
  req.set_exception(TSystemException.Create_type(st_BAD_OPERATION,0,COMPLETED_NO));
  req.write_results;
end;

function TPOA_Bench._primary_interface(const objid: string; const poa: IPOA): string;
begin
  result := 'IDL:Bench:1.0';
end;

function TPOA_Bench._is_a(const repoid: string): Boolean;
begin
  result :=  repoid = 'IDL:Bench:1.0'
end;

function TPOA_Bench._make_stub(const poa: IPOA;
  const obj: IORBObject): IORBObject;
begin
  result := TBench_stub_clp.Create(poa,obj)
end;

initialization
  _marshaller_Bench := TBench_marshaller.Create;
end.

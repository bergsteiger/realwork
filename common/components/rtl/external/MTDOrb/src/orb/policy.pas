// **********************************************************************
//
// Copyright (c) 2001 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
unit policy;

interface

uses
  policy_int,orbtypes,orb,orb_int,static,stdstat,code_int,ir_int,
  exceptions,except_int,Classes;

{.$IFNDEF USELIB}

type

  TPolicy = class(TORBObject,IPolicy)
  private
    Fpt : PolicyType;
  protected
    function _get_policy_type(): PolicyType;
    function copy(): IPolicy; virtual;
    procedure _destroy();
    // DORB extention
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
    function _repoid(): RepositoryId; override;
  public
    constructor Create(pt: PolicyType);
    class function _narrow(const obj : IORBObject): IPolicy;
  end;

  {** IDL:omg.org/CORBA/ConstructionPolicy:1.0 }
  TConstructionPolicy = class(TPolicy,IConstructionPolicy)
  private
    FConstr: TStrings;
  protected
    procedure make_domain_manager(const object_type: IInterfaceDef; const constr_policy: boolean);
    function constr_policy(const obj: IORBObject): boolean;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
  public
    constructor Create;
    destructor Destroy; override;
    class function _narrow(const obj : IORBObject): IConstructionPolicy;
  end;

  {** IDL:omg.org/CORBA/DomainManager:1.0 }
  TDomainManager = class(TORBObject,IDomainManager)
  private
  protected
    function get_domain_policy(const policy_type: PolicyType): IPolicy;
    procedure set_domain_policy(const policy: IPolicy);
    function copy: IDomainManager;
    function narrow_helper(const str: RepositoryId): Pointer; override;
  public
    constructor Create();
    class function _narrow(const obj : IORBObject): IDomainManager;
  end;

  TThreadPolicy = class(TPolicy,IThreadPolicy)
  private
    FValue : ThreadPolicyValue;
  protected
    function copy(): IPolicy; override;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
    function _repoid(): RepositoryId; override;
    function value(): ThreadPolicyValue;
  public
    constructor Create(pt: PolicyType; val: ThreadPolicyValue);
    class function _narrow(const obj : IORBObject): IThreadPolicy;
  end;

  TLifespanPolicy = class(TPolicy,ILifespanPolicy)
  private
    FValue : LifespanPolicyValue;
  protected
    function copy(): IPolicy; override;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
    function _repoid(): RepositoryId; override;
    function value(): LifespanPolicyValue;
  public
    constructor Create(pt: PolicyType; val: LifespanPolicyValue);
    class function _narrow(const obj : IORBObject): ILifespanPolicy;
  end;

  TIdUniquenessPolicy = class(TPolicy,IIdUniquenessPolicy)
  private
    FValue : IdUniquenessPolicyValue;
  protected
    function copy(): IPolicy; override;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
    function _repoid(): RepositoryId; override;
    function value(): IdUniquenessPolicyValue;
  public
    constructor Create(pt: PolicyType; val: IdUniquenessPolicyValue);
    class function _narrow(const obj : IORBObject): IIdUniquenessPolicy;
  end;

  TIdAssignmentPolicy = class(TPolicy,IIdAssignmentPolicy)
  private
    FValue : IdAssignmentPolicyValue;
  protected
    function copy(): IPolicy; override;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
    function _repoid(): RepositoryId; override;
    function value(): IdAssignmentPolicyValue;
  public
    constructor Create(pt: PolicyType; val: IdAssignmentPolicyValue);
    class function _narrow(const obj : IORBObject): IIdAssignmentPolicy;
  end;

  TImplicitActivationPolicy = class(TPolicy,IImplicitActivationPolicy)
  private
    FValue : ImplicitActivationPolicyValue;
  protected
    function copy(): IPolicy; override;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
    function _repoid(): RepositoryId; override;
    function value(): ImplicitActivationPolicyValue;
  public
    constructor Create(pt: PolicyType; val: ImplicitActivationPolicyValue);
    class function _narrow(const obj : IORBObject): IImplicitActivationPolicy;
  end;

  TServantRetentionPolicy = class(TPolicy,IServantRetentionPolicy)
  private
    FValue : ServantRetentionPolicyValue;
  protected
    function copy(): IPolicy; override;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
    function _repoid(): RepositoryId; override;
    function value(): ServantRetentionPolicyValue;
  public
    constructor Create(pt: PolicyType; val: ServantRetentionPolicyValue);
    class function _narrow(const obj : IORBObject): IServantRetentionPolicy;
  end;

  TRequestProcessingPolicy = class(TPolicy,IRequestProcessingPolicy)
  private
    FValue : RequestProcessingPolicyValue;
  protected
    function copy(): IPolicy; override;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
    function _repoid(): RepositoryId; override;
    function value(): RequestProcessingPolicyValue;
  public
    constructor Create(pt: PolicyType; val: RequestProcessingPolicyValue);
    class function _narrow(const obj : IORBObject): IRequestProcessingPolicy;
  end;

  TPolicyError_marshaller = class(TAbstractStat,IStaticTypeInfo)
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
  end;

  {** IDL:omg.org/CORBA/PolicyError:1.0 }
  TPolicyError = class(UserException,IPolicyError)
  private
    Freason : TPolicyErrorCode;
  protected
    procedure throw; override;
    function clone(): IORBException; override;
    function repoid(): RepositoryId; override;
    procedure encode(const enc: IEncoder); override;
    procedure reason(const val : TPolicyErrorCode); overload;
  public
    function reason: TPolicyErrorCode; overload;
    constructor Create(ex: TPolicyError); overload;
    constructor Create(_reason: TPolicyErrorCode = 0); overload;
  end;

  {** IDL:omg.org/MICOPolicy/TransportPrefPolicy:1.0 } 
  TTransportPrefPolicy = class(TPolicy,ITransportPrefPolicy)
  private
    FPrefs: TProfileTagSeq;
  protected
    procedure _set_preferences(const val: TProfileTagSeq);
    function _get_preferences: TProfileTagSeq;
    function _get_preferences_nocopy: TProfileTagSeq;
    function narrow_helper(const str: RepositoryId): Pointer; override;
    function copy(): IPolicy; override;
    function _repoid(): RepositoryId; override;
  public
    constructor Create(const prof_tag_seq: TProfileTagSeq);
    class function _narrow(const obj : IORBObject): ITransportPrefPolicy;
  end;

  {** IDL:omg.org/BiDirPolicy/BidirectionalPolicy:1.0 }
  TBidirectionalPolicy = class(TPolicy,IBidirectionalPolicy)
  private
    FValue: TBidirectionalPolicyValue;
  protected
    function _get_value: TBidirectionalPolicyValue;
    function narrow_helper(const str: RepositoryId): Pointer; override;
    function copy(): IPolicy; override;
    function _repoid(): RepositoryId; override;
  public
    constructor Create(const val: TBidirectionalPolicyValue);
    class function _narrow(const obj : IORBObject): IBidirectionalPolicy;
  end;

  TThreadPolicyValue_marshaller = class(TAbstractStat,IStaticTypeInfo)
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
    function typecode: ITypeCode; override;
  end;

  TLifespanPolicyValue_marshaller = class(TAbstractStat,IStaticTypeInfo)
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
    function typecode: ITypeCode; override;
  end;

  TIdUniquenessPolicyValue_marshaller = class(TAbstractStat,IStaticTypeInfo)
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
    function typecode: ITypeCode; override;
  end;

  TIdAssignmentPolicyValue_marshaller = class(TAbstractStat,IStaticTypeInfo)
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
    function typecode: ITypeCode; override;
  end;

  TImplicitActivationPolicyValue_marshaller = class(TAbstractStat,IStaticTypeInfo)
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
    function typecode: ITypeCode; override;
  end;

  TServantRetentionPolicyValue_marshaller = class(TAbstractStat,IStaticTypeInfo)
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
    function typecode: ITypeCode; override;
  end;

  TRequestProcessingPolicyValue_marshaller = class(TAbstractStat,IStaticTypeInfo)
  protected
    procedure _assign(dst,src: Pointer); override;
    function demarshal(dec: IDecoder;const addr : Pointer): Boolean;
    procedure marshal(enc: IEncoder; const addr : Pointer);
    procedure _create(var addr: Pointer); override;
    procedure _free(var addr: Pointer);
    function typecode: ITypeCode; override;
  end;

var
  PolicyError_marshaller : IStaticTypeInfo;
  ThreadPolicyValue_marshaller : IStaticTypeInfo;
  LifespanPolicyValue_marshaller : IStaticTypeInfo;
  IdUniquenessPolicyValue_marshaller : IStaticTypeInfo;
  IdAssignmentPolicyValue_marshaller : IStaticTypeInfo;
  ImplicitActivationPolicyValue_marshaller : IStaticTypeInfo;
  ServantRetentionPolicyValue_marshaller : IStaticTypeInfo;
  RequestProcessingPolicyValue_marshaller : IStaticTypeInfo;

function ProfileTagSeq_to_any(const val: TProfileTagSeq): IAny;
function any_to_ProfileTagSeq(const a: IAny; var val: TProfileTagSeq): Boolean;

function ThreadPolicyValue_to_any(const val: ThreadPolicyValue): IAny;
function any_to_ThreadPolicyValue(const a: IAny; var val: ThreadPolicyValue): Boolean;

function LifespanPolicyValue_to_any(const val: LifespanPolicyValue): IAny;
function any_to_LifespanPolicyValue(const a: IAny; var val: LifespanPolicyValue): Boolean;

function IdUniquenessPolicyValue_to_any(const val: IdUniquenessPolicyValue): IAny;
function any_to_IdUniquenessPolicyValue(const a: IAny; var val: IdUniquenessPolicyValue): Boolean;

function IdAssignmentPolicyValue_to_any(const val: IdAssignmentPolicyValue): IAny;
function any_to_IdAssignmentPolicyValue(const a: IAny; var val: IdAssignmentPolicyValue): Boolean;

function ImplicitActivationPolicyValue_to_any(const val: ImplicitActivationPolicyValue): IAny;
function any_to_ImplicitActivationPolicyValue(const a: IAny; var val: ImplicitActivationPolicyValue): Boolean;

function ServantRetentionPolicyValue_to_any(const val: ServantRetentionPolicyValue): IAny;
function any_to_ServantRetentionPolicyValue(const a: IAny; var val: ServantRetentionPolicyValue): Boolean;

function RequestProcessingPolicyValue_to_any(const val: RequestProcessingPolicyValue): IAny;
function any_to_RequestProcessingPolicyValue(const a: IAny; var val: RequestProcessingPolicyValue): Boolean;

implementation

uses SysUtils, std_seq, any, throw, tcode;

var
  _tc_ThreadPolicyValue : ITypeCodeConst;
  _tc_LifespanPolicyValue : ITypeCodeConst;
  _tc_IdUniquenessPolicyValue : ITypeCodeConst;
  _tc_IdAssignmentPolicyValue : ITypeCodeConst;
  _tc_ImplicitActivationPolicyValue : ITypeCodeConst;
  _tc_ServantRetentionPolicyValue : ITypeCodeConst;
  _tc_RequestProcessingPolicyValue : ITypeCodeConst;

function ProfileTagSeq_to_any(const val: TProfileTagSeq): IAny;
var
  stat: IStaticAny;
begin
  stat := StaticAny(stat_seq_ulong,@val);
  result := CreateAny;
  result.from_static_any(stat);
end;

function any_to_ProfileTagSeq(const a: IAny; var val: TProfileTagSeq): Boolean;
var
  stat: IStaticAny;
begin
  stat := StaticAny(stat_seq_ulong,@val);
  result := a.to_static_any(stat);
end;

//*********************************************************************
//  TPolicy
//*********************************************************************
constructor TPolicy.Create(pt: PolicyType);
begin
  inherited Create();
  FPt := pt;
end;

procedure TPolicy._destroy;
begin

end;

function TPolicy.copy: IPolicy;
begin
  result := TPolicy.Create(Fpt);
end;

function TPolicy._get_policy_type: PolicyType;
begin
  result := Fpt;
end;

class function TPolicy._narrow(const obj: IORBObject): IPolicy;
var
  ptr : pointer;
begin
  result := nil;
  if assigned(obj) then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/Policy:1.0');
      if ptr <> nil then result := IPolicy(ptr);
    end;
end;

function TPolicy.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/CORBA/Policy:1.0' then
    result := Pointer(self as IPolicy);
end;

function TPolicy._repoid: RepositoryId;
begin
  result := 'IDL:omg.org/CORBA/Policy:1.0';
end;

//*********************************************************************
//  TThreadPolicy
//*********************************************************************
constructor TThreadPolicy.Create(pt: PolicyType; val: ThreadPolicyValue);
begin
  inherited Create(pt);
  FValue := val;
end;

class function TThreadPolicy._narrow(const obj: IORBObject): IThreadPolicy;
var
  ptr : pointer;
begin
  result := nil;
  if assigned(obj) then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/ThreadPolicy:1.0');
      if ptr <> nil then result := IThreadPolicy(ptr);
    end;
end;

function TThreadPolicy.copy: IPolicy;
begin
  result := TThreadPolicy.Create(Fpt,FValue);
end;

function TThreadPolicy.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/CORBA/ThreadPolicy:1.0' then result := Pointer(self as IThreadPolicy);
end;

function TThreadPolicy._repoid: RepositoryId;
begin
  result := 'IDL:omg.org/CORBA/ThreadPolicy:1.0';
end;

function TThreadPolicy.value: ThreadPolicyValue;
begin
  result := FValue;
end;

//*********************************************************************
//  TLifespanPolicy
//*********************************************************************
constructor TLifespanPolicy.Create(pt: PolicyType; val: LifespanPolicyValue);
begin
  inherited Create(pt);
  FValue := val;
end;

class function TLifespanPolicy._narrow(const obj: IORBObject): ILifespanPolicy;
var
  ptr : pointer;
begin
  result := nil;
  if assigned(obj) then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/LifespanPolicy:1.0');
      if ptr <> nil then result := ILifespanPolicy(ptr);
    end;
end;

function TLifespanPolicy.copy: IPolicy;
begin
  result := TLifespanPolicy.Create(Fpt,FValue);
end;

function TLifespanPolicy.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/CORBA/LifespanPolicy:1.0' then result := Pointer(self as ILifespanPolicy);
end;

function TLifespanPolicy._repoid: RepositoryId;
begin
  result := 'IDL:omg.org/CORBA/LifespanPolicy:1.0';
end;

function TLifespanPolicy.value: LifespanPolicyValue;
begin
  result := FValue;
end;

//*********************************************************************
//  TIdUniquenessPolicy
//*********************************************************************
constructor TIdUniquenessPolicy.Create(pt: PolicyType;
  val: IdUniquenessPolicyValue);
begin
  inherited Create(pt);
  FValue := val;
end;

class function TIdUniquenessPolicy._narrow(
  const obj: IORBObject): IIdUniquenessPolicy;
var
  ptr : pointer;
begin
  result := nil;
  if assigned(obj) then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/IdUniquenessPolicy:1.0');
      if ptr <> nil then result := IIdUniquenessPolicy(ptr);
    end;
end;

function TIdUniquenessPolicy.copy: IPolicy;
begin
  result := TIdUniquenessPolicy.Create(Fpt,FValue);
end;

function TIdUniquenessPolicy.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/CORBA/IdUniquenessPolicy:1.0' then result := Pointer(self as IIdUniquenessPolicy);
end;

function TIdUniquenessPolicy._repoid: RepositoryId;
begin
  result := 'IDL:omg.org/CORBA/IdUniquenessPolicy:1.0';
end;

function TIdUniquenessPolicy.value: IdUniquenessPolicyValue;
begin
  result := FValue
end;

//*********************************************************************
//  TIdAssignmentPolicy
//*********************************************************************
constructor TIdAssignmentPolicy.Create(pt: PolicyType;
  val: IdAssignmentPolicyValue);
begin
  inherited Create(pt);
  FValue := val;
end;

class function TIdAssignmentPolicy._narrow(
  const obj: IORBObject): IIdAssignmentPolicy;
var
  ptr : pointer;
begin
  result := nil;
  if assigned(obj) then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/IdAssignmentPolicy:1.0');
      if ptr <> nil then result := IIdAssignmentPolicy(ptr);
    end;
end;

function TIdAssignmentPolicy.copy: IPolicy;
begin
  result := TIdAssignmentPolicy.Create(Fpt,FValue);
end;

function TIdAssignmentPolicy.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/CORBA/IdAssignmentPolicy:1.0' then result := Pointer(self as IIdAssignmentPolicy);
end;

function TIdAssignmentPolicy._repoid: RepositoryId;
begin
  result := 'IDL:omg.org/CORBA/IdAssignmentPolicy:1.0';
end;

function TIdAssignmentPolicy.value: IdAssignmentPolicyValue;
begin
  result := FValue
end;

//*********************************************************************
//  TImplicitActivationPolicy
//*********************************************************************
constructor TImplicitActivationPolicy.Create(pt: PolicyType;
  val: ImplicitActivationPolicyValue);
begin
  inherited Create(pt);
  FValue := val;
end;

class function TImplicitActivationPolicy._narrow(
  const obj: IORBObject): IImplicitActivationPolicy;
var
  ptr : pointer;
begin
  result := nil;
  if assigned(obj) then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/ImplicitActivationPolicy:1.0');
      if ptr <> nil then result := IImplicitActivationPolicy(ptr);
    end;
end;

function TImplicitActivationPolicy.copy: IPolicy;
begin
  result := TImplicitActivationPolicy.Create(Fpt,FValue);
end;

function TImplicitActivationPolicy.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/CORBA/ImplicitActivationPolicy:1.0' then result := Pointer(self as IImplicitActivationPolicy);
end;

function TImplicitActivationPolicy._repoid: RepositoryId;
begin
  result := 'IDL:omg.org/CORBA/ImplicitActivationPolicy:1.0';
end;

function TImplicitActivationPolicy.value: ImplicitActivationPolicyValue;
begin
  result := FValue
end;

//*********************************************************************
//  TServantRetentionPolicy
//*********************************************************************
constructor TServantRetentionPolicy.Create(pt: PolicyType;
  val: ServantRetentionPolicyValue);
begin
  inherited Create(pt);
  FValue := val;
end;

class function TServantRetentionPolicy._narrow(
  const obj: IORBObject): IServantRetentionPolicy;
var
  ptr : pointer;
begin
  result := nil;
  if assigned(obj) then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/ServantRetentionPolicy:1.0');
      if ptr <> nil then result := IServantRetentionPolicy(ptr);
    end;
end;

function TServantRetentionPolicy.copy: IPolicy;
begin
  result := TServantRetentionPolicy.Create(Fpt,FValue);
end;

function TServantRetentionPolicy.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/CORBA/ServantRetentionPolicy:1.0' then result := Pointer(self as IServantRetentionPolicy);
end;

function TServantRetentionPolicy._repoid: RepositoryId;
begin
  result := 'IDL:omg.org/CORBA/ServantRetentionPolicy:1.0';
end;

function TServantRetentionPolicy.value: ServantRetentionPolicyValue;
begin
  result := FValue
end;

//*********************************************************************
//  TRequestProcessingPolicy
//*********************************************************************
constructor TRequestProcessingPolicy.Create(pt: PolicyType;
  val: RequestProcessingPolicyValue);
begin
  inherited Create(pt);
  FValue := val;
end;

class function TRequestProcessingPolicy._narrow(
  const obj: IORBObject): IRequestProcessingPolicy;
var
  ptr : pointer;
begin
  result := nil;
  if assigned(obj) then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/RequestProcessingPolicy:1.0');
      if ptr <> nil then result := IRequestProcessingPolicy(ptr);
    end;
end;

function TRequestProcessingPolicy.copy: IPolicy;
begin
  result := TRequestProcessingPolicy.Create(Fpt,FValue);
end;

function TRequestProcessingPolicy.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/CORBA/RequestProcessingPolicy:1.0' then result := Pointer(self as IRequestProcessingPolicy);
end;

function TRequestProcessingPolicy._repoid: RepositoryId;
begin
  result := 'IDL:omg.org/CORBA/RequestProcessingPolicy:1.0';
end;

function TRequestProcessingPolicy.value: RequestProcessingPolicyValue;
begin
  result := FValue
end;

//***********************************************************
// TPolicyError_marshaller
//***********************************************************
function TPolicyError_marshaller.demarshal(dec: IDecoder;const addr : Pointer): Boolean;
var
  repoid: RepositoryId;
  _reason: TPolicyErrorCode;
begin
  result := false;
  if not dec.except_begin(repoid) then exit;
  if not stat_short.demarshal(dec,@_reason) then exit;
  IPolicyError(addr^).reason(_reason);
  if not dec.except_end then exit;
  result := true;
end;

procedure TPolicyError_marshaller.marshal(enc: IEncoder;const addr : Pointer);
var
  _reason: TPolicyErrorCode;
begin
  enc.except_begin('IDL:omg.org/CORBA/PolicyError:1.0');
  _reason:= IPolicyError(addr^).reason;
  stat_short.marshal(enc,@_reason);
  enc.except_end;
end;

procedure TPolicyError_marshaller._free(var addr: Pointer);
begin
  IPolicyError(addr^) := nil;
end;

procedure TPolicyError_marshaller._create(var addr: Pointer);
begin
  IPolicyError(addr^) := TPolicyError.Create();
end;

procedure TPolicyError_marshaller._assign(dst, src: Pointer);
begin
  IPolicyError(dst^) := IPolicyError(src^);
end;

//***********************************************************
// TPolicyError
//***********************************************************
constructor TPolicyError.Create(ex: TPolicyError);
begin
  Freason:= ex.reason;
end;

procedure TPolicyError.throw;
begin
  raise TPolicyError.Create(self);
end;

function TPolicyError.clone(): IORBException;
begin
  result := TPolicyError.Create(self);
end;

procedure TPolicyError.encode(const enc: IEncoder);
var
  int : IPolicyError;
begin
  int := self;
  PolicyError_marshaller.marshal(enc,@int);
end;

constructor TPolicyError.Create(_reason: TPolicyErrorCode);
begin
  Freason := _reason;
end;

function TPolicyError.repoid(): RepositoryId;
begin
  result := 'IDL:omg.org/CORBA/PolicyError:1.0';
end;

procedure TPolicyError.reason(const val: TPolicyErrorCode);
begin
  Freason := val;
end;

function TPolicyError.reason: TPolicyErrorCode;
begin
  result := Freason;
end;

{ TConstructionPolicy }

class function TConstructionPolicy._narrow(
  const obj: IORBObject): IConstructionPolicy;
var
  ptr : pointer;
begin
  result := nil;
  if assigned(obj) then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/ConstructionPolicy:1.0');
      if ptr <> nil then result := IConstructionPolicy(ptr);
    end;
end;

procedure TConstructionPolicy.make_domain_manager(
  const object_type: IInterfaceDef; const constr_policy: boolean);
var
  idx: Integer;
begin
  idx := FConstr.IndexOf(string(object_type._id));
  if idx = -1 then
    idx := FConstr.Add(string(object_type._id));
  FConstr.Objects[idx] := TObject(Ord(constr_policy));
end;

function TConstructionPolicy.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/CORBA/ConstructionPolicy:1.0' then
    result := Pointer(self as IConstructionPolicy);
end;

function TConstructionPolicy.constr_policy(
  const obj: IORBObject): boolean;
var
  idx: Integer;
begin
  result := false;
  idx := FConstr.IndexOf(String(obj._repoid));
  if idx <> -1 then
    result := Boolean(Pointer(FConstr.Objects[idx]));
end;

constructor TConstructionPolicy.Create;
begin
  inherited Create(SecConstruction);
  FConstr := TStringList.Create;
end;

destructor TConstructionPolicy.Destroy;
begin
  FreeAndNil(FConstr);
  inherited;
end;

{ TDomainManager }

class function TDomainManager._narrow(
  const obj: IORBObject): IDomainManager;
var
  ptr : pointer;
begin
  result := nil;
  if assigned(obj) then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/DomainManager:1.0');
      if ptr <> nil then result := IDomainManager(ptr);
    end;
end;

function TDomainManager.copy: IDomainManager;
var
  dl: DomainManagersList;
  pl: PolicyList;
  i: Integer;
begin
  result := TDomainManager.Create;
  dl := result._managers;
  dl := System.Copy(FManagers, 0, Length(FManagers));

  pl := result._policies;
  SetLength(pl, Length(FPolicies));
  for i := 0 to Length(FPolicies) - 1 do
    result._policies[i] := FPolicies[i].copy();
end;

function TDomainManager.get_domain_policy(
  const policy_type: PolicyType): IPolicy;
var
  i: Integer;
begin
  // look only at this domain's policies
  for i := 0 to Length(FPolicies) - 1 do
    if FPolicies[i].policy_type = policy_type then begin
      result := FPolicies[i];
      Exit;
    end;
  dorb_throw(st_INV_POLICY);
end;

function TDomainManager.narrow_helper(const str: RepositoryId): Pointer;
begin
  result := nil;
  if _repoid = 'IDL:omg.org/CORBA/DomainManager:1.0' then
    result := Pointer(self as IDomainManager);
end;

procedure TDomainManager.set_domain_policy(const policy: IPolicy);
var
  policy_type: PolicyType;
  i: Integer;
begin
  policy_type := policy.policy_type;
  for i := 0 to Length(FPolicies) - 1 do
    if FPolicies[i].policy_type = policy_type then begin
      FPolicies[i] := policy;
      Exit;
    end;
  i := Length(FPolicies);
  SetLength(FPolicies, i + 1);
  FPolicies[i] := policy;
end;

constructor TDomainManager.Create;
begin
  inherited;
  SetLength(FPolicies, 1);
  FPolicies[0] := TConstructionPolicy.Create();
end;

{ TTransportPrefPolicy }

function TTransportPrefPolicy._get_preferences: TProfileTagSeq;
begin
  result := System.Copy(FPrefs, 0, Length(FPrefs));
end;

function TTransportPrefPolicy._get_preferences_nocopy: TProfileTagSeq;
begin
  result := FPrefs;
end;

class function TTransportPrefPolicy._narrow(
  const obj: IORBObject): ITransportPrefPolicy;
var
  ptr : pointer;
begin
  result := nil;
  if assigned(obj) then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/MICOPolicy/TransportPrefPolicy:1.0');
      if ptr <> nil then result := ITransportPrefPolicy(ptr);
    end;
end;

procedure TTransportPrefPolicy._set_preferences(const val: TProfileTagSeq);
begin
  FPrefs := val;
end;

function TTransportPrefPolicy.narrow_helper(const str: RepositoryId): Pointer;
begin
  result := nil;
  if _repoid = 'IDL:omg.org/MICOPolicy/TransportPrefPolicy:1.0' then
    result := Pointer(self as ITransportPrefPolicy);
end;

constructor TTransportPrefPolicy.Create(
  const prof_tag_seq: TProfileTagSeq);
begin
  inherited Create(TRANSPORTPREF_POLICY_TYPE);
  FPrefs := prof_tag_seq;
end;

function TTransportPrefPolicy.copy: IPolicy;
begin
  result := TTransportPrefPolicy.Create(FPrefs);
end;

function TTransportPrefPolicy._repoid: RepositoryId;
begin
  result := 'IDL:omg.org/MICOPolicy/TransportPrefPolicy:1.0';
end;

{ TBidirectionalPolicy }

function TBidirectionalPolicy._get_value: TBidirectionalPolicyValue;
begin
  result := FValue;
end;

class function TBidirectionalPolicy._narrow(
  const obj: IORBObject): IBidirectionalPolicy;
var
  ptr : pointer;
begin
  result := nil;
  if assigned(obj) then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/BiDirPolicy/BidirectionalPolicy:1.0');
      if ptr <> nil then result := IBidirectionalPolicy(ptr);
    end;
end;

function TBidirectionalPolicy.narrow_helper(const str: RepositoryId): Pointer;
begin
  result := nil;
  if _repoid = 'IDL:omg.org/BiDirPolicy/BidirectionalPolicy:1.0' then
    result := Pointer(self as IBidirectionalPolicy);
end;

constructor TBidirectionalPolicy.Create(
  const val: TBidirectionalPolicyValue);
begin
  inherited Create(BIDIRECTIONAL_POLICY_TYPE);
  FValue := val;
end;

function TBidirectionalPolicy.copy: IPolicy;
begin
  result := TBidirectionalPolicy.Create(FValue);
end;

function TBidirectionalPolicy._repoid: RepositoryId;
begin
  result := 'IDL:omg.org/BiDirPolicy/BidirectionalPolicy:1.0';
end;

//***********************************************************
// TThreadPolicyValue_marshaller
//***********************************************************
function TThreadPolicyValue_marshaller.demarshal(dec: IDecoder;const addr : Pointer): Boolean;
begin
  result := dec.get_ulong(_ulong(addr^));
end;

procedure TThreadPolicyValue_marshaller.marshal(enc: IEncoder;const addr : Pointer);
begin
  enc.put_ulong(_ulong(addr^));
end;

procedure TThreadPolicyValue_marshaller._free(var addr: Pointer);
begin
  freemem(addr);
end;

procedure TThreadPolicyValue_marshaller._create(var addr: Pointer);
begin
  addr := allocmem(sizeOf(_ulong));
end;

procedure TThreadPolicyValue_marshaller._assign(dst, src: Pointer);
begin
  ThreadPolicyValue(dst^) := ThreadPolicyValue(src^);
end;

function TThreadPolicyValue_marshaller.typecode: ITypeCode;
begin
  result := _tc_ThreadPolicyValue.typecode;
end;

//***********************************************************
// TLifespanPolicyValue_marshaller
//***********************************************************
function TLifespanPolicyValue_marshaller.demarshal(dec: IDecoder;const addr : Pointer): Boolean;
begin
  result := dec.get_ulong(_ulong(addr^));
end;

procedure TLifespanPolicyValue_marshaller.marshal(enc: IEncoder;const addr : Pointer);
begin
  enc.put_ulong(_ulong(addr^));
end;

procedure TLifespanPolicyValue_marshaller._free(var addr: Pointer);
begin
  freemem(addr);
end;

procedure TLifespanPolicyValue_marshaller._create(var addr: Pointer);
begin
  addr := allocmem(sizeOf(_ulong));
end;

procedure TLifespanPolicyValue_marshaller._assign(dst, src: Pointer);
begin
  LifespanPolicyValue(dst^) := LifespanPolicyValue(src^);
end;

function TLifespanPolicyValue_marshaller.typecode: ITypeCode;
begin
  result := _tc_LifespanPolicyValue.typecode;
end;

//***********************************************************
// TIdUniquenessPolicyValue_marshaller
//***********************************************************
function TIdUniquenessPolicyValue_marshaller.demarshal(dec: IDecoder;const addr : Pointer): Boolean;
begin
  result := dec.get_ulong(_ulong(addr^));
end;

procedure TIdUniquenessPolicyValue_marshaller.marshal(enc: IEncoder;const addr : Pointer);
begin
  enc.put_ulong(_ulong(addr^));
end;

procedure TIdUniquenessPolicyValue_marshaller._free(var addr: Pointer);
begin
  freemem(addr);
end;

procedure TIdUniquenessPolicyValue_marshaller._create(var addr: Pointer);
begin
  addr := allocmem(sizeOf(_ulong));
end;

procedure TIdUniquenessPolicyValue_marshaller._assign(dst, src: Pointer);
begin
  IdUniquenessPolicyValue(dst^) := IdUniquenessPolicyValue(src^);
end;

function TIdUniquenessPolicyValue_marshaller.typecode: ITypeCode;
begin
  result := _tc_IdUniquenessPolicyValue.typecode;
end;

//***********************************************************
// TIdAssignmentPolicyValue_marshaller
//***********************************************************
function TIdAssignmentPolicyValue_marshaller.demarshal(dec: IDecoder;const addr : Pointer): Boolean;
begin
  result := dec.get_ulong(_ulong(addr^));
end;

procedure TIdAssignmentPolicyValue_marshaller.marshal(enc: IEncoder;const addr : Pointer);
begin
  enc.put_ulong(_ulong(addr^));
end;

procedure TIdAssignmentPolicyValue_marshaller._free(var addr: Pointer);
begin
  freemem(addr);
end;

procedure TIdAssignmentPolicyValue_marshaller._create(var addr: Pointer);
begin
  addr := allocmem(sizeOf(_ulong));
end;

procedure TIdAssignmentPolicyValue_marshaller._assign(dst, src: Pointer);
begin
  IdAssignmentPolicyValue(dst^) := IdAssignmentPolicyValue(src^);
end;

function TIdAssignmentPolicyValue_marshaller.typecode: ITypeCode;
begin
  result := _tc_IdAssignmentPolicyValue.typecode;
end;

//***********************************************************
// TImplicitActivationPolicyValue_marshaller
//***********************************************************
function TImplicitActivationPolicyValue_marshaller.demarshal(dec: IDecoder;const addr : Pointer): Boolean;
begin
  result := dec.get_ulong(_ulong(addr^));
end;

procedure TImplicitActivationPolicyValue_marshaller.marshal(enc: IEncoder;const addr : Pointer);
begin
  enc.put_ulong(_ulong(addr^));
end;

procedure TImplicitActivationPolicyValue_marshaller._free(var addr: Pointer);
begin
  freemem(addr);
end;

procedure TImplicitActivationPolicyValue_marshaller._create(var addr: Pointer);
begin
  addr := allocmem(sizeOf(_ulong));
end;

procedure TImplicitActivationPolicyValue_marshaller._assign(dst, src: Pointer);
begin
  ImplicitActivationPolicyValue(dst^) := ImplicitActivationPolicyValue(src^);
end;

function TImplicitActivationPolicyValue_marshaller.typecode: ITypeCode;
begin
  result := _tc_ImplicitActivationPolicyValue.typecode;
end;

//***********************************************************
// TServantRetentionPolicyValue_marshaller
//***********************************************************
function TServantRetentionPolicyValue_marshaller.demarshal(dec: IDecoder;const addr : Pointer): Boolean;
begin
  result := dec.get_ulong(_ulong(addr^));
end;

procedure TServantRetentionPolicyValue_marshaller.marshal(enc: IEncoder;const addr : Pointer);
begin
  enc.put_ulong(_ulong(addr^));
end;

procedure TServantRetentionPolicyValue_marshaller._free(var addr: Pointer);
begin
  freemem(addr);
end;

procedure TServantRetentionPolicyValue_marshaller._create(var addr: Pointer);
begin
  addr := allocmem(sizeOf(_ulong));
end;

procedure TServantRetentionPolicyValue_marshaller._assign(dst, src: Pointer);
begin
  ServantRetentionPolicyValue(dst^) := ServantRetentionPolicyValue(src^);
end;

function TServantRetentionPolicyValue_marshaller.typecode: ITypeCode;
begin
  result := _tc_ServantRetentionPolicyValue.typecode;
end;

//***********************************************************
// TRequestProcessingPolicyValue_marshaller
//***********************************************************
function TRequestProcessingPolicyValue_marshaller.demarshal(dec: IDecoder;const addr : Pointer): Boolean;
begin
  result := dec.get_ulong(_ulong(addr^));
end;

procedure TRequestProcessingPolicyValue_marshaller.marshal(enc: IEncoder;const addr : Pointer);
begin
  enc.put_ulong(_ulong(addr^));
end;

procedure TRequestProcessingPolicyValue_marshaller._free(var addr: Pointer);
begin
  freemem(addr);
end;

procedure TRequestProcessingPolicyValue_marshaller._create(var addr: Pointer);
begin
  addr := allocmem(sizeOf(_ulong));
end;

procedure TRequestProcessingPolicyValue_marshaller._assign(dst, src: Pointer);
begin
  RequestProcessingPolicyValue(dst^) := RequestProcessingPolicyValue(src^);
end;

function TRequestProcessingPolicyValue_marshaller.typecode: ITypeCode;
begin
  result := _tc_RequestProcessingPolicyValue.typecode;
end;

function any_to_ThreadPolicyValue(const a: IAny; var val: ThreadPolicyValue): Boolean;
var
  stat: IStaticAny;
begin
  stat := StaticAny(ThreadPolicyValue_marshaller,@val);
  result := a.to_static_any(stat);
end;

function ThreadPolicyValue_to_any(const val: ThreadPolicyValue): IAny;
var
  stat: IStaticAny;
begin
  stat := StaticAny(ThreadPolicyValue_marshaller,@val);
  result := CreateAny;
  result.from_static_any(stat);
end;

function any_to_LifespanPolicyValue(const a: IAny; var val: LifespanPolicyValue): Boolean;
var
  stat: IStaticAny;
begin
  stat := StaticAny(LifespanPolicyValue_marshaller,@val);
  result := a.to_static_any(stat);
end;

function LifespanPolicyValue_to_any(const val: LifespanPolicyValue): IAny;
var
  stat: IStaticAny;
begin
  stat := StaticAny(LifespanPolicyValue_marshaller,@val);
  result := CreateAny;
  result.from_static_any(stat);
end;

function any_to_IdUniquenessPolicyValue(const a: IAny; var val: IdUniquenessPolicyValue): Boolean;
var
  stat: IStaticAny;
begin
  stat := StaticAny(IdUniquenessPolicyValue_marshaller,@val);
  result := a.to_static_any(stat);
end;

function IdUniquenessPolicyValue_to_any(const val: IdUniquenessPolicyValue): IAny;
var
  stat: IStaticAny;
begin
  stat := StaticAny(IdUniquenessPolicyValue_marshaller,@val);
  result := CreateAny;
  result.from_static_any(stat);
end;

function any_to_IdAssignmentPolicyValue(const a: IAny; var val: IdAssignmentPolicyValue): Boolean;
var
  stat: IStaticAny;
begin
  stat := StaticAny(IdAssignmentPolicyValue_marshaller,@val);
  result := a.to_static_any(stat);
end;

function IdAssignmentPolicyValue_to_any(const val: IdAssignmentPolicyValue): IAny;
var
  stat: IStaticAny;
begin
  stat := StaticAny(IdAssignmentPolicyValue_marshaller,@val);
  result := CreateAny;
  result.from_static_any(stat);
end;

function any_to_ImplicitActivationPolicyValue(const a: IAny; var val: ImplicitActivationPolicyValue): Boolean;
var
  stat: IStaticAny;
begin
  stat := StaticAny(ImplicitActivationPolicyValue_marshaller,@val);
  result := a.to_static_any(stat);
end;

function ImplicitActivationPolicyValue_to_any(const val: ImplicitActivationPolicyValue): IAny;
var
  stat: IStaticAny;
begin
  stat := StaticAny(ImplicitActivationPolicyValue_marshaller,@val);
  result := CreateAny;
  result.from_static_any(stat);
end;

function any_to_ServantRetentionPolicyValue(const a: IAny; var val: ServantRetentionPolicyValue): Boolean;
var
  stat: IStaticAny;
begin
  stat := StaticAny(ServantRetentionPolicyValue_marshaller,@val);
  result := a.to_static_any(stat);
end;

function ServantRetentionPolicyValue_to_any(const val: ServantRetentionPolicyValue): IAny;
var
  stat: IStaticAny;
begin
  stat := StaticAny(ServantRetentionPolicyValue_marshaller,@val);
  result := CreateAny;
  result.from_static_any(stat);
end;

function any_to_RequestProcessingPolicyValue(const a: IAny; var val: RequestProcessingPolicyValue): Boolean;
var
  stat: IStaticAny;
begin
  stat := StaticAny(RequestProcessingPolicyValue_marshaller,@val);
  result := a.to_static_any(stat);
end;

function RequestProcessingPolicyValue_to_any(const val: RequestProcessingPolicyValue): IAny;
var
  stat: IStaticAny;
begin
  stat := StaticAny(RequestProcessingPolicyValue_marshaller,@val);
  result := CreateAny;
  result.from_static_any(stat);
end;

initialization
  PolicyError_marshaller := TPolicyError_marshaller.Create();
  ThreadPolicyValue_marshaller := TThreadPolicyValue_marshaller.Create();
  LifespanPolicyValue_marshaller := TLifespanPolicyValue_marshaller.Create();
  IdUniquenessPolicyValue_marshaller := TIdUniquenessPolicyValue_marshaller.Create();
  IdAssignmentPolicyValue_marshaller := TIdAssignmentPolicyValue_marshaller.Create();
  ImplicitActivationPolicyValue_marshaller := TImplicitActivationPolicyValue_marshaller.Create();
  ServantRetentionPolicyValue_marshaller := TServantRetentionPolicyValue_marshaller.Create();
  RequestProcessingPolicyValue_marshaller := TRequestProcessingPolicyValue_marshaller.Create();
  _tc_ThreadPolicyValue := CreateTypeCodeConst('01000000110000006c000000010000001a00000049444c3a546872656164506f6c69637956616c75653a312e3000000012000000546872'+
    '656164506f6c69637956616c7565000000020000000f0000004f52425f4354524c5f4d4f44454c00001400000053494e474c455f544852'+
    '4541445f4d4f44454c00');
  _tc_LifespanPolicyValue := CreateTypeCodeConst('01000000110000005f000000010000001c00000049444c3a4c6966657370616e506f6c69637956616c75653a312e3000140000004c6966'+
    '657370616e506f6c69637956616c756500020000000a0000005452414e5349454e540000000b00000050455253495354454e5400');
  _tc_IdUniquenessPolicyValue := CreateTypeCodeConst('010000001100000068000000010000002000000049444c3a4964556e697175656e657373506f6c69637956616c75653a312e3000180000'+
    '004964556e697175656e657373506f6c69637956616c756500020000000a000000554e495155455f49440000000c0000004d554c544950'+
    '4c455f494400');
  _tc_IdAssignmentPolicyValue := CreateTypeCodeConst('010000001100000062000000010000002000000049444c3a496441737369676e6d656e74506f6c69637956616c75653a312e3000180000'+
    '00496441737369676e6d656e74506f6c69637956616c7565000200000008000000555345525f4944000a00000053595354454d5f494400');
  _tc_ImplicitActivationPolicyValue := CreateTypeCodeConst('01000000110000008b000000010000002600000049444c3a496d706c6963697441637469766174696f6e506f6c69637956616c75653a31'+
    '2e300000001e000000496d706c6963697441637469766174696f6e506f6c69637956616c75650000000200000014000000494d504c4943'+
    '49545f41435449564154494f4e00170000004e4f5f494d504c494349545f41435449564154494f4e00');
  _tc_ServantRetentionPolicyValue := CreateTypeCodeConst('01000000110000006b000000010000002400000049444c3a53657276616e74526574656e74696f6e506f6c69637956616c75653a312e30'+
    '001c00000053657276616e74526574656e74696f6e506f6c69637956616c756500020000000700000052455441494e00000b0000004e4f'+
    '4e5f52455441494e00');
  _tc_RequestProcessingPolicyValue := CreateTypeCodeConst('0100000011000000a8000000010000002500000049444c3a5265717565737450726f63657373696e67506f6c69637956616c75653a312e'+
    '30000000001d0000005265717565737450726f63657373696e67506f6c69637956616c756500000000030000001b0000005553455f4143'+
    '544956455f4f424a4543545f4d41505f4f4e4c590000140000005553455f44454641554c545f53455256414e5400140000005553455f53'+
    '455256414e545f4d414e4147455200');
{.$ELSE}
//implementation
{.$ENDIF}
end.


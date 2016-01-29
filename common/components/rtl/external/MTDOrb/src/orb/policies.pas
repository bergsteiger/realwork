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
unit policies;

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
    function policy_type(): PolicyType;
    function copy(): IPolicy; virtual;
    procedure _destroy();
    // DORB extention
    function narrow_helper(const repoid: string): Pointer; override;
    function repoid(): string; override;
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
    function narrow_helper(const repoid: string): Pointer; override;
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
    function narrow_helper(const str: string): Pointer; override;
  public
    constructor Create();
    class function _narrow(const obj : IORBObject): IDomainManager;
  end;

  TThreadPolicy = class(TPolicy,IThreadPolicy)
  private
    FValue : ThreadPolicyValue;
  protected
    function copy(): IPolicy; override;
    function narrow_helper(const repoid: string): Pointer; override;
    function repoid(): string; override;
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
    function narrow_helper(const repoid: string): Pointer; override;
    function repoid(): string; override;
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
    function narrow_helper(const repoid: string): Pointer; override;
    function repoid(): string; override;
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
    function narrow_helper(const repoid: string): Pointer; override;
    function repoid(): string; override;
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
    function narrow_helper(const repoid: string): Pointer; override;
    function repoid(): string; override;
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
    function narrow_helper(const repoid: string): Pointer; override;
    function repoid(): string; override;
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
    function narrow_helper(const repoid: string): Pointer; override;
    function repoid(): string; override;
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
    function repoid(): PChar; override;
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
    function narrow_helper(const str: string): Pointer; override;
    function copy(): IPolicy; override;
    function repoid(): string; override;
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
    function narrow_helper(const str: string): Pointer; override;
    function copy(): IPolicy; override;
    function repoid(): string; override;
  public
    constructor Create(const val: TBidirectionalPolicyValue);
    class function _narrow(const obj : IORBObject): IBidirectionalPolicy;
  end;

var
  PolicyError_marshaller : IStaticTypeInfo;

function ProfileTagSeq_to_any(const val: TProfileTagSeq): IAny;
function any_to_ProfileTagSeq(const a: IAny; var val: TProfileTagSeq): Boolean;

implementation

uses std_seq, any, throw;

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

function TPolicy.policy_type: PolicyType;
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

function TPolicy.narrow_helper(const repoid: string): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/CORBA/Policy:1.0' then
    result := Pointer(self as IPolicy);
end;

function TPolicy.repoid: string;
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

function TThreadPolicy.narrow_helper(const repoid: string): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/CORBA/ThreadPolicy:1.0' then result := Pointer(self as IThreadPolicy);
end;

function TThreadPolicy.repoid: string;
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

function TLifespanPolicy.narrow_helper(const repoid: string): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/CORBA/LifespanPolicy:1.0' then result := Pointer(self as ILifespanPolicy);
end;

function TLifespanPolicy.repoid: string;
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

function TIdUniquenessPolicy.narrow_helper(const repoid: string): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/CORBA/IdUniquenessPolicy:1.0' then result := Pointer(self as IIdUniquenessPolicy);
end;

function TIdUniquenessPolicy.repoid: string;
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

function TIdAssignmentPolicy.narrow_helper(const repoid: string): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/CORBA/IdAssignmentPolicy:1.0' then result := Pointer(self as IIdAssignmentPolicy);
end;

function TIdAssignmentPolicy.repoid: string;
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

function TImplicitActivationPolicy.narrow_helper(const repoid: string): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/CORBA/ImplicitActivationPolicy:1.0' then result := Pointer(self as IImplicitActivationPolicy);
end;

function TImplicitActivationPolicy.repoid: string;
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

function TServantRetentionPolicy.narrow_helper(const repoid: string): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/CORBA/ServantRetentionPolicy:1.0' then result := Pointer(self as IServantRetentionPolicy);
end;

function TServantRetentionPolicy.repoid: string;
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

function TRequestProcessingPolicy.narrow_helper(const repoid: string): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/CORBA/RequestProcessingPolicy:1.0' then result := Pointer(self as IRequestProcessingPolicy);
end;

function TRequestProcessingPolicy.repoid: string;
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
  repoid: string;
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

function TPolicyError.repoid(): PChar;
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
  idx := FConstr.IndexOf(object_type.id);
  if idx = -1 then
    idx := FConstr.Add(object_type.id);
  FConstr.Objects[idx] := TObject(Ord(constr_policy));
end;

function TConstructionPolicy.narrow_helper(const repoid: string): Pointer;
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
  idx := FConstr.IndexOf(obj.repoid);
  if idx <> -1 then
    result := Boolean(FConstr.Objects[idx]);
end;

constructor TConstructionPolicy.Create;
begin
  inherited Create(SecConstruction);
  FConstr := TStringList.Create;
end;

destructor TConstructionPolicy.Destroy;
begin
  FConstr.Free;
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
    if FPolicies[i].policy_type() = policy_type then begin
      result := FPolicies[i];
      Exit;
    end;
  dorb_throw(st_INV_POLICY);
end;

function TDomainManager.narrow_helper(const str: string): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/CORBA/DomainManager:1.0' then
    result := Pointer(self as IDomainManager);
end;

procedure TDomainManager.set_domain_policy(const policy: IPolicy);
var
  policy_type: PolicyType;
  i: Integer;
begin
  policy_type := policy.policy_type();
  for i := 0 to Length(FPolicies) - 1 do
    if FPolicies[i].policy_type() = policy_type then begin
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

function TTransportPrefPolicy.narrow_helper(const str: string): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/MICOPolicy/TransportPrefPolicy:1.0' then
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

function TTransportPrefPolicy.repoid: string;
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

function TBidirectionalPolicy.narrow_helper(const str: string): Pointer;
begin
  result := nil;
  if repoid = 'IDL:omg.org/BiDirPolicy/BidirectionalPolicy:1.0' then
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

function TBidirectionalPolicy.repoid: string;
begin
  result := 'IDL:omg.org/BiDirPolicy/BidirectionalPolicy:1.0';
end;

initialization
  PolicyError_marshaller := TPolicyError_marshaller.Create();
{.$ELSE}
//implementation
{.$ENDIF}
end.


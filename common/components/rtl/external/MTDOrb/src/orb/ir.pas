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
unit ir;

interface

uses
  SysUtils,ir_int,orb_int,orb,Classes,orbtypes,code_int,exceptions;

type

  TIRObject = class(TORBObject,IIRObject)
  protected
    FDefKind: TDefinitionKind;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
    function def_kind: TDefinitionKind;
  public
    constructor Create();
  end;

  TIDLType = class(TIRObject,IIDLType)
  private
    FType: ITypeCode;
  protected
    function _type(): ITypeCode;
    function recursive_type(): ITypeCode;
  public
    constructor Create(_type: ITypeCode);
    class function _narrow(obj: IORBObject): IIDLType;
  end;

  TPrimitiveDef = class(TIDLType,IPrimitiveDef)
  private
    FKind: TPrimitiveKind;
  protected
    function kind: TPrimitiveKind;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
  public
    constructor Create(kind: TPrimitiveKind);
    class function _narrow(obj: IORBObject): IPrimitiveDef;
  end;

  TContained = class(TIRObject,IContained)
  protected
    FID: RepositoryId;
    FName: Identifier;
    FVersion: Identifier;
    FContainer: IContainer;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
  protected
    function _id: AnsiString; overload;
    procedure _id(const val: AnsiString); overload; virtual;
    function _name: AnsiString;
    function absolute_name: AnsiString; virtual;
    function _absolute_name: AnsiString; virtual;
    function defined_in: IContainer;
    function _version: AnsiString; overload;
    procedure _version(const val: AnsiString); overload;
    procedure move(const new_container: IContainer;
      new_name: Identifier; new_version: Identifier);
    function containing_repository: IRepository;
  public
    class function _narrow(obj: IORBObject): IContained;
  end;

  TContainer = class(TIRObject,IContainer)
  protected
    FContained : IInterfaceList;
    //------------------------
    FID: RepositoryID;
    FName: Identifier;
    FVersion: Identifier;
    FContainer: IContainer;
  protected
    function _id: AnsiString; overload;
    procedure _id(const val: RepositoryID); overload;
    function _name: Identifier;
    function absolute_name: AnsiString; virtual;
    function _absolute_name: AnsiString; virtual;
    function _version: AnsiString; overload;
    procedure _version(const val: AnsiString); overload;
    function defined_in: IContainer;
    procedure move(const new_container: IContainer;
      new_name: Identifier; new_version: Identifier);
    //----------------------------------
    function create_enum(id : RepositoryId; name,version: Identifier; members: PEnumMemberSeq): IEnumDef;
    function create_alias(id : RepositoryId; name,version: Identifier; orig: IIDLType ): IAliasDef;
    function create_union(id : RepositoryId; name,version: Identifier; descr : IIDLType; members: UnionMemberSeq): IUnionDef;
    function create_struct(id : RepositoryId; name,version: Identifier; members: PStructMemberSeq): IStructDef;
    function create_interface(id : RepositoryId; name,version: Identifier; base_interfaces: IInterfaceList;
      is_abstract: Boolean; is_local: Boolean): IInterfaceDef;
    function create_module(id : RepositoryId; name,version: Identifier): IModuleDef;
    function create_constant(id : RepositoryId; name,version: Identifier; t: IIDLType; val: IAny): IConstantDef;
    function create_value(id : RepositoryId; name,version: Identifier; is_custom,is_abstract: Boolean;
      base_value: IValueDef; is_truncatable: Boolean; abstract_base_values,
      supported_interfaces: IInterfaceList; initializers : PInitializerSeq): IValueDef;
    function create_native(const id : RepositoryId; const name,version: Identifier): INativeDef;
    function create_fixed(const digits: _ushort; const scale: short): IFixedDef;
    procedure add_contained(const cont: IContained);
    procedure remove_contained(const cont: IContained);
    function lookup(search_name: Identifier): IContained;
    function find(search_name: Identifier) : IContained;
    function lookup_name(search_name: Identifier; levels_to_search: longint ;
      limit : TDefinitionKind = dk_all; exclude_inherited: Boolean = false): IInterfaceList;
    function locate_id(id: AnsiString): IContained;
    function locate_name(const name: Identifier; include_enclosing_scopes: Boolean; is_first_level: Boolean): IContained;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
    function contents(limit : TDefinitionKind = dk_all; exclude_inherited: Boolean = false): IInterfaceList;
    function containing_repository: IRepository;
    function create_exception(id : RepositoryId; name,version: Identifier; members: PStructMemberSeq): IExceptionDef;
    function create_value_box(id : RepositoryId; name,version: Identifier; orig: IIDLType): IValueBoxDef;
  public
    constructor Create();
    class function _narrow(const obj: IORBObject): IContainer;
  end;

  TSequenceDef = class(TContainer,ISequenceDef,IContained,IIDLType)
  protected
    FBound : _ulong;
    FType : IIDLType;
    FTypeCode: ITypeCode;
  protected
    function bound: _ulong;
    procedure set_bound(val: _ulong);
    function element_type: ITypeCode;
    function element_type_def: IIDLType;
    procedure set_element_type_def(const val: IIDLType);
    function _type: ITypeCode;
    function recursive_type(): ITypeCode;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
  public
    constructor Create(const con: IContainer;bound: _ulong; element_type: IIDLType);
    class function _narrow(const obj: IORBObject): ISequenceDef;
  end;

  TArrayDef = class(TIDLType,IArrayDef,IIDLType)
  protected
    FLength : _ulong;
    FType : IIDLType;
    FTypeCode: ITypeCode;
  protected
    function length: _ulong; overload;
    procedure length(val: _ulong); overload;
    function element_type: ITypeCode;
    function element_type_def: IIDLType; overload;
    procedure element_type_def(val: IIDLType); overload;
    function _type: ITypeCode;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
  public
    constructor Create(const con: IContainer;length: _ulong; element_type: IIDLType);
    class function _narrow(const obj: IORBObject): IArrayDef;
  end;

  TInterfaceDef = class(TContainer,IInterfaceDef,IContained,IIDLType)
  protected
    FTypeCode: ITypeCode;
    FBase : IInterfaceList;
    FIsAbstract : Boolean;
    FIsLocal: Boolean;
  protected
    function get_base_interfaces: IInterfaceList;
    procedure set_base_interfaces(const val: IInterfaceList);
    function get_is_abstract: Boolean;
    procedure set_is_abstract(val: Boolean);
    function get_is_local: Boolean;
    procedure set_is_local(val: Boolean);
    function create_attribute(id : RepositoryId; name, version: Identifier; atype: IIDLType; amode: AttributeMode;
      getExceptions : ExceptionDefSeq = nil; setExceptions : ExceptionDefSeq = nil): IExtAttributeDef;
    function create_operation(id : RepositoryId; name, version: Identifier; oresult: IIDLType; omode: TOperationMode;
      const params: ParDescriptionSeq = nil; exceptions : ExceptionDefSeq = nil): IOperationDef;
    procedure check_overloaded(id,oname: AnsiString);
    // IIDLType methods
    function _type(): ITypeCode;
    function recursive_type(): ITypeCode;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
  public
    constructor Create(const con: IContainer;id : RepositoryId; name, version: Identifier;
          base_interfaces: IInterfaceList; is_abstract: Boolean; is_local: Boolean);
    class function _narrow(const obj: IORBObject): IInterfaceDef;
  end;

  TOperationDef = class(TContained,IOperationDef)
  protected
    FMode: TOperationMode;
    FResult : IIDLType;
    FParams : ParDescriptionSeq;
    FExceptions : ExceptionDefSeq;
  protected
    function _result: ITypeCode;
    function get_result_def: IIDLType;
    procedure set_result_def(const val: IIDLType);
    function get_mode: TOperationMode;
    procedure set_mode(val: TOperationMode);
    function get_params: ParDescriptionSeq;
    procedure set_params(const params: ParDescriptionSeq);
    // DORB extension
    function _describe: OperationDescription;
    function exceptions: PExceptionDefSeq;
  public
    constructor Create(const con: IContainer;id : RepositoryId; name,version: Identifier;
      oresult: IIDLType; omode: TOperationMode; const params: ParDescriptionSeq; exceptions: ExceptionDefSeq);
  end;

  TModuleDef = class(TContainer,IModuleDef,IContained)
  protected
    function _describe: ModuleDescription;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
  public
    constructor Create(const con: IContainer;id : RepositoryId; name,version: Identifier);
    class function _narrow(const obj: IORBObject): IModuleDef;
  end;

  TAttributeDef = class(TContained,IAttributeDef)
  protected
    FMode : AttributeMode;
    FType: IIDLType;
  protected
    function _type: ITypeCode;
    function get_type_def: IIDLType;
    procedure set_type_def(const val: IIDLType);
    function get_mode: AttributeMode;
    procedure set_mode(val: AttributeMode);
    // DORB extension
    function _describe: AttributeDescription;
  public
    constructor Create(const con: IContainer;id : RepositoryId; name,version: Identifier;
      atype: IIDLType; amode: AttributeMode);
  end;

  TExtAttributeDef = class(TAttributeDef, IExtAttributeDef)
  private
    FgetExceptions: ExceptionDefSeq;
    FsetExceptions: ExceptionDefSeq;
  protected
    function get_getExceptions: ExceptionDefSeq;
    procedure set_getExceptions(val: ExceptionDefSeq);
    function get_setExceptions: ExceptionDefSeq;
    procedure set_setExceptions(val: ExceptionDefSeq);
  public
    constructor Create(const con: IContainer; id : RepositoryId; name,version: Identifier;
      atype: IIDLType; amode: AttributeMode; getExceptions : ExceptionDefSeq = nil;
      setExceptions : ExceptionDefSeq = nil);
  end;

  TRepository = class(TContainer,IRepository)
  private
    _pk_void,
    _pk_short,
    _pk_long,
    _pk_ushort,
    _pk_ulong,
    _pk_float,
    _pk_double,
    _pk_boolean,
    _pk_char,
    _pk_octet,
    _pk_any,
    _pk_TypeCode,
    _pk_Principal,
    _pk_string,
    _pk_objref,
    _pk_longlong,
    _pk_ulonglong,
    _pk_longdouble,
    _pk_wchar,
    _pk_wstring,
    _pk_value_base: IPrimitiveDef;
    FAnonymousTypes : array of IIDLType;
  protected
    function absolute_name: AnsiString; override;
    function _absolute_name: AnsiString; override;
    function get_primitive(kind: TPrimitiveKind) : IPrimitiveDef;
    function create_array(length: _ulong; element_type: IIDLType): IArrayDef;
    function create_sequence(bound: _ulong; element_type: IIDLType): ISequenceDef;
    function add_anonymous_type(t: IIDLType): IIDLType;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
  public
    constructor Create();
    class function _narrow(const obj: IORBObject): IRepository;
  end;

  TStructDef = class(TContainer,IStructDef,ITypedefDef,IContained,IIDLType)
  protected
    FMembers: StructMemberSeq;
    FTypeCode: ITypeCode;
  protected
    function members: PStructMemberSeq; overload;
    procedure members(val: StructMemberSeq); overload;
    function _type(): ITypeCode;
    function recursive_type(): ITypeCode;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
  public
    constructor Create(con: IContainer;id : RepositoryId; name,version: Identifier; members: PStructMemberSeq);
    class function _narrow(const obj: IORBObject): IStructDef;
  end;

  TAliasDef = class(TContained,IAliasDef,ITypedefDef,IIDLType,IContained)
  protected
    FOriginal: IIDLType;
    FTypeCode: ITypeCode;
  protected
    function original_type_def: IIDLType;
    procedure set_original_type_def(val : IIDLType);
    function _type(): ITypeCode;
    function recursive_type(): ITypeCode;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
  public
    constructor Create(con: IContainer;id : RepositoryId; name,version: Identifier);
    class function _narrow(const obj: IORBObject): IAliasDef;
  end;

  TConstantDef = class(TContained,IConstantDef,IContained)
  protected
    FType: IIDLType;
    FTypeCode: ITypeCode;
    FValue: IAny;
  protected
    function _type: ITypeCode;
    function type_def: IIDLType; overload;
    procedure type_def(const val : IIDLType); overload;
    function value: IAny; overload;
    procedure value(const val : IAny); overload;
    function _describe: ConstantDescription;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
  public
    constructor Create(con: IContainer;id,name,version: AnsiString;t: IIDLType; val: IAny);
    class function _narrow(const obj: IORBObject): IConstantDef;
  end;


  TEnumDef = class(TContained,IEnumDef,ITypedefDef,IIDLType,IContained)
  protected
    FMembers: EnumMemberSeq;
    FTypeCode: ITypeCode;
  protected
    function members: PEnumMemberSeq; // of IEnumMember
    procedure set_members(val: PEnumMemberSeq);
    function _type(): ITypeCode;
    function recursive_type(): ITypeCode;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
  public
    constructor Create(con: IContainer;id : RepositoryId; name,version: Identifier; members: PEnumMemberSeq);
    class function _narrow(const obj: IORBObject): IEnumDef;
  end;

  TUnionDef = class(TContainer,ITypedefDef,IContained,IIDLType,IUnionDef)
  private
    FMembers: UnionMemberSeq;
    FDiscriminator : IIDLType;
    FTypeCode: ITypeCode;
  protected
    function discriminator_type: ITypeCode;
    function discriminator_type_def: IIDLType; overload;
    procedure discriminator_type_def(val: IIDLType); overload;
    function members: PUnionMemberSeq; overload;
    procedure members(val: UnionMemberSeq); overload;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
    function _type(): ITypeCode;
    function recursive_type(): ITypeCode;
  public
    constructor Create(con: IContainer;id : RepositoryId; name,version: Identifier; discriminator_type: IIDLType; mem: UnionMemberSeq);
    class function _narrow(const obj: IORBObject): IUnionDef;
  end;

  TExceptionDef = class(TContainer,IExceptionDef,IContained,IIDLType)
  private
    FMembers: StructMemberSeq;
    FTypeCode: ITypeCode;
  protected
    function _type: ITypeCode;
    function recursive_type(): ITypeCode;
    function members: PStructMemberSeq; overload;
    procedure members(val: StructMemberSeq); overload;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
  public
    constructor Create(con: IContainer;id : RepositoryId; name,version: Identifier; mem: PStructMemberSeq);
    class function _narrow(const obj: IORBObject): IExceptionDef;
  end;

  TNativeDef = class(TContained, INativeDef, ITypedefDef, IIDLType, IContained)
  private
    FTypeCode: ITypeCode;
  protected
    function _type: ITypeCode;
    function recursive_type(): ITypeCode;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
  public
    constructor Create(con: IContainer; const id : RepositoryId; const name, version: Identifier);
    class function _narrow(const obj: IORBObject): INativeDef;
  end;

  TFixedDef = class(TIDLType, IFixedDef, IIDLType)
  private
    FDigits: _ushort;
    FScale: short;
  protected
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
    { IFixedDef }
    procedure set_digits(value: _ushort);
    function get_digits(): _ushort;
    procedure set_scale(value: short);
    function get_scale(): short;
  public
    class function _narrow(const obj: IORBObject): IFixedDef;
  end;

implementation

uses
  throw,any,tcode,ir_value;

//*********************************************************************
//  TIIRObject
//*********************************************************************
constructor TIRObject.Create();
begin
  inherited Create();
end;

function TIRObject.def_kind: TDefinitionKind;
begin
  result := FDefKind;
end;

function TIRObject.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  if repoid = 'IDL:omg.org/CORBA/IRObject:1.0' then
    result := Pointer(IIRObject(self))
  else
    result := nil;
end;

//*********************************************************************
//  TContained
//*********************************************************************
function TContained.narrow_helper(const repoid: RepositoryID): Pointer;
begin
  if repoid = 'IDL:omg.org/CORBA/Contained:1.0' then
    result := Pointer(IContained(self))
  else
    result := inherited narrow_helper(repoid);
end;

function TContained.containing_repository: IRepository;
var
  con: IContainer;
  rep : IRepository;
begin
  result := nil;
  con := defined_in;
  rep := TRepository._narrow(con as IORBObject);
  if assigned(rep) then
    result := rep
  else
    (con as IContained).containing_repository;
end;

function TContained._absolute_name: AnsiString;
var
  cont: IContainer;
  con : IContained;
begin
  cont := defined_in;
  result := _name;
  case cont.def_kind of
    dk_Value,dk_Interface,dk_Module,dk_Struct,dk_Union,dk_Exception: begin
        con := TContained._narrow(cont as IORBObject);
        assert(con <> nil);
        result := con._absolute_name + '_' + result;
      end;
  end;
end;

function TContained.absolute_name: AnsiString;
var
  cont: IContainer;
  con : IContained;
begin
  cont := defined_in;
  result := _name;
  case cont.def_kind of
    dk_Value,dk_Interface,dk_Module,dk_Struct,dk_Union,dk_Exception: begin
        con := TContained._narrow(cont as IORBObject);
        assert(con <> nil);
        result := con.absolute_name + '::' + result;
      end;
  end;
end;

class function TContained._narrow(obj: IORBObject): IContained;
var
  ptr: Pointer;
begin
  result := nil;
  if obj <> nil then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/Contained:1.0');
      if ptr <> nil then
        result := IContained(ptr)
      //else
        //assert(false,'not imlplemented');
    end;
end;

procedure TContained.move(const new_container: IContainer;
      new_name: Identifier; new_version: Identifier);
begin
  FContainer := new_container;
  FName := new_name;
  FVersion := new_version;
end;

function TContained.defined_in: IContainer;
begin
  result := FContainer
end;

function TContained._version: AnsiString;
begin
  Result := FVersion
end;

procedure TContained._version(const val: AnsiString);
var
  i : integer;
begin
  FVersion := val;
  for i := Length(FID)-1 downto 1 do
    if FID[i] = ':' then break;
  FID := copy(FID,1,i)+FVersion;
end;

function TContained._id: AnsiString;
begin
  result := FID
end;

procedure TContained._id(const val: AnsiString);
begin
  FID := val;
end;

function TContained._name: AnsiString;
begin
  result := FName
end;

//*********************************************************************
//  TContainer
//*********************************************************************
constructor TContainer.Create();
begin
  inherited Create();
  FContained := TInterfaceList.Create;
end;

function TContainer.containing_repository: IRepository;
var
  con: IContainer;
  rep : IRepository;
begin
  result := nil;
  con := defined_in;
  rep := TRepository._narrow(con as IORBObject);
  if assigned(rep) then
    result := rep
  else
    (con as IContained).containing_repository;
end;

function TContainer.contents(limit : TDefinitionKind = dk_all; exclude_inherited: Boolean = false): IInterfaceList;
var
  i : integer;
begin
  result := TInterfaceList.Create;
  for i := 0 to Pred(FContained.Count) do
    with IContained(FContained[i]) do
      begin
        if (limit = dk_all) or (limit = def_kind) then
          result.add(IContained(self.FContained[i]));
      end;
end;

class function TContainer._narrow(const obj: IORBObject): IContainer;
var
  p : Pointer;
begin
  result := nil;
  if obj = nil then exit;
  p := obj.narrow_helper('IDL:omg.org/CORBA/Container:1.0');
  if p <> nil then
    result := IContainer(p)
  else
    // container stub not implemented
end;

function TContainer.narrow_helper(const repoid: RepositoryID): Pointer;
begin
  if repoid = 'IDL:omg.org/CORBA/Container:1.0' then
    result := Pointer(IContainer(self))
  else
    result := inherited narrow_helper(repoid)
end;

procedure TContainer.add_contained(const cont: IContained);
begin
  FContained.Add(cont);
end;

function TContainer.create_constant(id : RepositoryId; name, version: Identifier; t: IIDLType;
  val: IAny): IConstantDef;
begin
  if not (FDefKind in [dk_Module,dk_Repository,dk_Value, dk_Interface]) then
    dorb_throw('Bad container type');
  result := TConstantDef.Create(self,id,name,version,t,val);
  FContained.Add(result as IContained);
end;

function TContainer.create_union(id : RepositoryId; name, version: Identifier;
  descr: IIDLType; members: UnionMemberSeq): IUnionDef;
begin
  result := TUnionDef.Create(self,id,name,version,descr,members);
  FContained.Add(result as IContained);
end;

function TContainer.create_value_box(id : RepositoryId; name, version: Identifier; orig: IIDLType): IValueBoxDef;
var
  contained: IContained;
  i : integer;
  cid : AnsiString;
begin
  if not (FDefKind in [dk_Module,dk_Repository]) then
    dorb_throw('Bad container type');
  contained := locate_id(id);
  if contained <> nil then
    begin
      if IIRObject(contained).def_kind <> dk_ValueBox then
        dorb_throw('Duplicate name');
      cid := contained._id;
      for i := 0 to Pred(FContained.count) do
        if IContained(FContained[i])._id = cid then
          begin
            if i <> Pred(FContained.count) then
              begin
                FContained.Delete(i);
                FContained.Add(contained);
              end;
            break;
          end;
      result := contained as IValueBoxDef;
      assert(false,'not implemented');
      exit;
    end;
  result := TValueBoxDef.Create(self,id,name,version,orig);
  FContained.Add(result as IContained);
end;

function TContainer.create_value(id : RepositoryId; name, version: Identifier; is_custom,is_abstract: Boolean;
      base_value: IValueDef; is_truncatable: Boolean; abstract_base_values,
      supported_interfaces : IInterfaceList; initializers: PInitializerSeq): IValueDef;
var
  contained: IContained;
  i : integer;
  cid : AnsiString;
begin
  if not (FDefKind in [dk_Module,dk_Repository]) then
    dorb_throw('Bad container type');
  contained := locate_id(id);
  if contained <> nil then
    begin
      if IIRObject(contained).def_kind <> dk_Value then
        dorb_throw('Duplicate name');
      cid := contained._id;
      for i := 0 to Pred(FContained.count) do
        if IContained(FContained[i])._id = cid then
          begin
            if i <> Pred(FContained.count) then
              begin
                FContained.Delete(i);
                FContained.Add(contained);
              end;
            break;
          end;
      result := contained as IValueDef;
      //assert(false,'not implemented');
      exit;
    end;
  result := TValueDef.Create(self,id,name,version,is_custom,is_abstract,
    base_value,is_truncatable,abstract_base_values,supported_interfaces,initializers);
  FContained.Add(result as IContained);
end;

function TContainer.create_module(id : RepositoryId; name, version: Identifier): IModuleDef;
begin
  if not (def_kind in [dk_Repository,dk_Module]) then
    dorb_throw(SystemException.Create_type(st_INTF_REPOS));
  // check for duplicates omited
  result := TModuleDef.Create(self,id,name,version);
  FContained.Add(result as IContained);
end;

function TContainer.create_enum(id : RepositoryId; name, version: Identifier; members: PEnumMemberSeq): IEnumDef;
begin
  // check for duplicates omited
  result := TEnumDef.Create(self,id,name,version,members);
  add_contained(result as IContained);
end;

function TContainer.create_alias(id : RepositoryId; name, version: Identifier; orig: IIDLType ): IAliasDef;
begin
  // check for duplicates omited
  result := TAliasDef.Create(self,id,name,version);
  result.set_original_type_def(orig);
  add_contained(result as IContained);
end;

function TContainer.create_exception(id : RepositoryId; name, version: Identifier; members: PStructMemberSeq): IExceptionDef;
begin
  if not (def_kind in [dk_Repository,dk_Module,dk_Value,dk_Interface]) then
    raise Exception.Create('Bad type of exception container');
  // check for duplicates omited
  result := TExceptionDef.Create(self,id,name,version,members);
  add_contained(result as IContained);
end;

function TContainer.create_struct(id : RepositoryId; name, version: Identifier; members: PStructMemberSeq): IStructDef;
begin
  // check for duplicates omited
  result := TStructDef.Create(self,id,name,version,members);
  add_contained(result as IContained);
end;

function TContainer.create_interface(id : RepositoryId; name, version: Identifier;
  base_interfaces: IInterfaceList; is_abstract: Boolean; is_local: Boolean): IInterfaceDef;
var
  contained: IContained;
  i : integer;
  cid : AnsiString;
begin
  if not (FDefKind in [dk_Module,dk_Repository]) then
    dorb_throw('Bad container type');
  contained := locate_id(id);
  if contained <> nil then
    begin
      if IIRObject(contained).def_kind <> dk_Interface then
        dorb_throw('Duplicate name');
      cid := contained._id;
      for i := 0 to Pred(FContained.count) do
        if IContained(FContained[i])._id = cid then
          begin
            if i <> Pred(FContained.count) then
              begin
                FContained.Delete(i);
                FContained.Add(contained);
              end;
            break;
          end;
      result := IInterfaceDef(contained);
      result.set_base_interfaces(base_interfaces);
      result.set_is_abstract(is_abstract);
      result.set_is_local(is_local);
      exit;
    end;
  result := IInterfaceDef(TInterfaceDef.Create(self,id,name,version,base_interfaces,is_abstract,is_local));
  FContained.Add(result as IContained);
end;

function TContainer.create_native(const id : RepositoryId; const name, version: Identifier): INativeDef;
begin
  // check for duplicates omited
  result := TNativeDef.Create(self,id,name,version);
  add_contained(result as IContained);
end;

function TContainer.create_fixed(const digits: _ushort;
  const scale: short): IFixedDef;
begin
  // check for duplicates omited
  result := TFixedDef.Create(nil);
  result.set_digits(digits);
  result.set_scale(scale);
end;

function is_relative_scoped_name(const sname: AnsiString): Boolean;
begin
  result := sname[1] <> ':'
end;

function first_of_scoped_name(const sname: AnsiString): AnsiString;
var
  i,j : integer;
begin
  if is_relative_scoped_name(sname) then
    i := 1
  else
    i := 3;
  for j := i to Length(sname) do
    if sname[j] = ':' then
      break;
  result := copy(sname,i,j-i);
end;

function strip_first_scope(const sname: AnsiString): AnsiString;
var
  i,j : integer;
begin
  if is_relative_scoped_name(sname) then
    i := 1
  else
    i := 3;
  for j := i to Pred(length(sname)) do
    begin
      if sname[j] = ':' then break;
    end;
  if j = length(sname) then
    result := ''
  else
    result := copy(sname,j+2,100);
end;

function TContainer.find(search_name: AnsiString) : IContained;
var
  name : AnsiString;
  first: AnsiString;
  repo : IContainer;
  con : IContained;
begin
  name := search_name;
  result := nil;
  if Pos('::',string(name)) > 0 then
    begin
      first := first_of_scoped_name(name);
      if is_relative_scoped_name(first) then
        con := locate_name(first,true,true)
      else
        begin
          case self.def_kind of
            dk_Repository : repo := self as IContainer;
            dk_Module,dk_Interface,dk_Union,dk_Struct,dk_Value,dk_Exception: begin
                repo := (self as IContained).containing_repository;
              end;
          end;
          con := repo.locate_name(first,true,true);
        end;
      while true do
        begin
          if con = nil then exit;
          name := strip_first_scope(name);
          if name = '' then
            begin
              result := con;
              exit;
            end;
          first := first_of_scoped_name(name);
          repo := TContainer._narrow(con as IORBObject);
          if repo = nil then exit;
          con := repo.locate_name(first,false,true);
        end;
    end
  else
    result := locate_name(search_name,true,true);
end;

function TContainer.locate_name(const name: AnsiString; include_enclosing_scopes: Boolean; is_first_level: Boolean): IContained;
var
  i : integer;
  cont,hit : IContained;
  idef: IInterfaceDef;
  seq: IInterfaceList;
begin
  result := nil;
  for i := 0 to Pred(FContained.count) do
    if IContained(FContained[i])._name = name then
      begin
        result := IContained(FContained[i]);
        exit;
      end;
  idef := TInterfaceDef._narrow(self);
  // search in base interfaces
  if assigned(idef) then
    begin
      seq := idef.get_base_interfaces;
      for i := 0 to Pred(seq.Count) do
        begin
          cont := (seq[i] as IContainer).locate_name(name,include_enclosing_scopes,false);
          if cont <> nil then
            begin
              if hit = nil then
                begin
                  hit := cont;
                  continue;
                end;
              if hit <> cont then
                dorb_throw(SystemException.Create_type(st_INTF_REPOS));
            end;
        end;
      if hit <> nil then
        begin
          result := hit;
          exit;
        end;
    end;
  if not include_enclosing_scopes then
    exit;
  cont := TContained._narrow(self);
  if not assigned(cont) or not is_first_level then exit;
  if cont.defined_in <> nil then
    result := cont.defined_in.locate_name(name,include_enclosing_scopes,true);
end;

function TContainer.lookup(search_name: AnsiString): IContained;
var
  i : integer;
  cont : IContained;
  cr: IContainer;
  name, first: AnsiString;
begin
  result := nil;
  name := search_name;
  if not is_relative_scoped_name(name) then
    begin
      if FDefKind <> dk_Repository then
        begin
          cont := TContained._narrow(self);
          result := cont.containing_repository.lookup(copy(name,3,100));
          exit;
        end;
    end;
  first := first_of_scoped_name(name);
  name := strip_first_scope(name);
  for i := 0 to Pred(FContained.count) do
    if IContained(FContained[i])._name = first then
      begin
        if name = '' then
          begin
            result := IContained(FContained[i]);
            exit;
          end
        else
          begin
            cr := TContainer._narrow(FContained[i] as IORBObject);
            if cr = nil then exit;
            result := cr.lookup(name);
            exit;
          end;
      end;
end;

function TContainer.lookup_name(search_name: AnsiString; levels_to_search: longint ;
      limit : TDefinitionKind = dk_all; exclude_inherited: Boolean = false): IInterfaceList;
var
  i : integer;
begin
  result := TInterfaceList.Create;
  for i := 0 to Pred(FContained.Count) do
    with IContained(FContained[i]) do
      begin
        if ((limit = dk_all) or (limit = def_kind) and (_name() = search_name)) then
          result.add(IContained(self.FContained[i]));
      end;
end;

function TContainer.locate_id(id: AnsiString): IContained;
var
  i : integer;
begin
  result := nil;
  for i := 0 to Pred(FContained.Count) do
    if IContained(FContained[i])._id = id then
      begin
        result := IContained(FContained[i]);
        exit;
      end;
end;

procedure TContainer.remove_contained(const cont: IContained);
begin
  FContained.Remove(cont)
end;

function TContainer.absolute_name: AnsiString;
var
  cont: IContainer;
  con : IContained;
begin
  cont := defined_in;
  result := _name;
  case cont.def_kind of
    dk_Repository : result := '::'+_name;
    dk_Value,dk_Interface,dk_Module,dk_Struct,dk_Union,dk_Exception: begin
        con := TContained._narrow(cont as IORBObject);
        assert(con <> nil);
        result := con.absolute_name + '::' + result;
      end;
  end;
end;

function TContainer._absolute_name: AnsiString;
var
  cont: IContainer;
  con : IContained;
begin
  cont := defined_in;
  result := _name;
  case cont.def_kind of
    dk_Value,dk_Interface,dk_Module,dk_Struct,dk_Union,dk_Exception: begin
        con := TContained._narrow(cont as IORBObject);
        assert(con <> nil);
        result := con._absolute_name + '_' + result;
      end;
  end;
end;


function TContainer.defined_in: IContainer;
begin
  result := FContainer
end;

function TContainer._id: AnsiString;
begin
  Result := FID;
end;

procedure TContainer._id(const val: AnsiString);
begin
  FID := val;
end;

procedure TContainer.move(const new_container: IContainer; new_name,
  new_version: AnsiString);
begin
  FContainer := new_container;
  FName := new_name;
  FVersion := new_version;
end;

function TContainer._name: AnsiString;
begin
  result := FName
end;

function TContainer._version: AnsiString;
begin
  result := FVersion
end;

procedure TContainer._version(const val: AnsiString);
var
  i : integer;
begin
  FVersion := val;
  for i := Length(FID)-1 downto 1 do
    if FID[i] = ':' then break;
  FID := copy(FID,1,i)+FVersion;
end;

//*********************************************************************
//  TInterfaceDef
//*********************************************************************
constructor TInterfaceDef.Create(const con: IContainer;id, name, version: AnsiString;
  base_interfaces: IInterfaceList; is_abstract: Boolean; is_local: Boolean);
begin
  inherited Create();
  FContainer := con;
  FID := id;
  FName := name;
  FVersion := version;
  FBase := base_interfaces;
  FIsAbstract := is_abstract;
  FIsLocal := is_local;
  FDefKind := dk_Interface;
  FTypeCode := FORB.create_interface_tc(id,name);
end;

function TInterfaceDef.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  if repoid = 'IDL:omg.org/CORBA/InterfaceDef:1.0' then
    result := Pointer(IInterfaceDef(self))
  else if repoid = 'IDL:omg.org/CORBA/Contained:1.0' then
    result := Pointer(IContained(self))
  else if repoid = 'IDL:omg.org/CORBA/IDLType:1.0' then
    result := Pointer(IIDLType(self))
  else
    result := inherited narrow_helper(repoid)
end;

class function TInterfaceDef._narrow(const obj: IORBObject): IInterfaceDef;
var
  ptr: Pointer;
begin
  result := nil;
  if obj <> nil then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/InterfaceDef:1.0');
      if ptr <> nil then
        result := IInterfaceDef(ptr)
      else
        //assert(false,'not imlplemented');
    end;
end;

function TInterfaceDef._type: ITypeCode;
begin
  result := FTypeCode;
end;

function TInterfaceDef.recursive_type: ITypeCode;
begin
  result := _type();
end;

procedure TInterfaceDef.check_overloaded(id,oname: AnsiString);
var
  i : integer;
  list: IInterfaceList;

  procedure check_in_list(AList: IInterfaceList);
  var
    i: Integer;
  begin
    for i := 0 to Pred(AList.count) do
      with IContained(AList[i]) do
        if (def_kind in [dk_Operation,dk_Attribute]) and  (_name = oname) then
          dorb_throw(Format('collision in inherited context of "%s"', [oname]));
  end;

begin
  check_in_list(FContained);
  // check in base [3.7.5]
  for i := 0 to FBase.Count - 1 do begin
    list := (FBase[i] as IContainer).contents(dk_Operation);
    check_in_list(list);
    list := (FBase[i] as IContainer).contents(dk_Attribute);
    check_in_list(list);
  end;
end;

function TInterfaceDef.create_attribute(id : RepositoryId; name, version: Identifier; atype: IIDLType; amode: AttributeMode;
  getExceptions : ExceptionDefSeq = nil; setExceptions : ExceptionDefSeq = nil): IExtAttributeDef;
{$IFNDEF USELIB}
(*var
  t: IIDLType;
  prm: ParDescriptionSeq;*)
{$ENDIF}
begin
  check_overloaded(AnsiString(id),AnsiString(name));
  result := TExtAttributeDef.Create(self,AnsiString(id),AnsiString(name),AnsiString(version),atype,amode, getExceptions, setExceptions);
  FContained.add(result as IContained);
  // add read and write operation
//  if amode = ATTR_NORMAL then begin
{$IFNDEF USELIB}
(*    t := TIDLType.Create(TTypeCode.Create(tk_void) as ITypeCode);
    SetLength(prm, 1);
    with prm[0] do begin
      name := 'Value';
      _type := atype._type;
      type_def := atype;
      mode := PARAM_IN;
    end; { with }
    create_operation(id, '_set_' + name, version, t, OP_NORMAL, prm, nil);*)
{$ENDIF}
//  end;
//  create_operation(id, '_get_' + name, version, atype, OP_NORMAL, nil, nil);
end;

function TInterfaceDef.create_operation(id : RepositoryId; name, version: Identifier; oresult: IIDLType; omode: TOperationMode;
      const params: ParDescriptionSeq; exceptions : ExceptionDefSeq): IOperationDef;
begin
  check_overloaded(id, name);
  result := TOperationDef.Create(self, id, name, version,oresult,omode,params,exceptions);
  FContained.Add(result as IContained);
end;

function TInterfaceDef.get_base_interfaces: IInterfaceList;
begin
  Result := FBase
end;

function TInterfaceDef.get_is_abstract: Boolean;
begin
  result := FIsAbstract
end;

procedure TInterfaceDef.set_base_interfaces(const val: IInterfaceList);
begin
  FBase := val;
end;

procedure TInterfaceDef.set_is_abstract(val: Boolean);
begin
  FIsAbstract := val;
end;

function TInterfaceDef.get_is_local: Boolean;
begin
  result := FIsLocal;
end;

procedure TInterfaceDef.set_is_local(val: Boolean);
begin
  FIsLocal := val;
end;

//*********************************************************************
//  TOperationDef
//*********************************************************************
constructor TOperationDef.Create(const con: IContainer; id : RepositoryId; name,version: Identifier; oresult: IIDLType; omode: TOperationMode;
  const params: ParDescriptionSeq; exceptions: ExceptionDefSeq);
begin
  inherited Create();
  FContainer := con;
  FMode := omode;
  FResult := oresult;
  FParams := params;
  FID := id;
  FExceptions := exceptions;
  FName := name;
  FVersion := version;
  FDefKind := dk_Operation;
end;

function TOperationDef._result: ITypeCode;
begin
  Result := FResult._type
end;

function TOperationDef.exceptions: PExceptionDefSeq;
begin
  result := @FExceptions
end;

function TOperationDef._describe: OperationDescription;
var
  cont : IContained;
begin
  with Result do
    begin
      name := FName;
      id := FID;
      cont := TContained._narrow(FContainer as IORBObject);
      if cont <> nil then
        defined_in := cont._id
      else
        defined_in := '';
      version := FVersion;
      _result := self._result;
      mode := FMode;
      // contexts := ... not implemented
      parameters := FParams;
    end;
end;


function TOperationDef.get_mode: TOperationMode;
begin
  Result := FMode
end;

function TOperationDef.get_params: ParDescriptionSeq;
begin
  Result := FParams
end;

function TOperationDef.get_result_def: IIDLType;
begin
  Result := FResult
end;

procedure TOperationDef.set_mode(val: TOperationMode);
begin
  FMode := val
end;

procedure TOperationDef.set_params(const params: ParDescriptionSeq);
begin
  FParams := params;
end;

procedure TOperationDef.set_result_def(const val: IIDLType);
begin
  FResult := val;
end;

//*************************************************
//  TAttributeDef
//*************************************************
constructor TAttributeDef.Create(const con: IContainer; id : RepositoryId; name,version: Identifier; atype: IIDLType; amode: AttributeMode);
begin
  inherited Create();
  FContainer := con;
  FID := id;
  FName := name;
  FVersion := version;
  FType := atype;
  FMode := amode;
  FDefKind := dk_Attribute;
end;

function TAttributeDef._type: ITypeCode;
begin
  result := FType._type
end;

function TAttributeDef._describe: AttributeDescription;
begin
  with result do
    begin
      name := FName;
      id := FID;
      if (FContainer as IORBObject)._ior <> nil then
        defined_in := IORBObject(FContainer)._repoid;
      version := FVersion;
      _type := self._type;
      mode := FMode;
    end;
end;


function TAttributeDef.get_mode: AttributeMode;
begin
  Result := FMode
end;

function TAttributeDef.get_type_def: IIDLType;
begin
  result := FType
end;

procedure TAttributeDef.set_mode(val: AttributeMode);
begin
  FMode := val;
end;

procedure TAttributeDef.set_type_def(const val: IIDLType);
begin
  FType := val;
end;

//*************************************************
// TIDLType
//*************************************************
constructor TIDLType.Create(_type: ITypeCode);
begin
  inherited Create();
  FType := _type;
end;

function TIDLType.recursive_type: ITypeCode;
begin
  result := _type();
end;

class function TIDLType._narrow(obj: IORBObject): IIDLType;
var
  ptr: Pointer;
begin
  result := nil;
  if obj <> nil then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/IDLType:1.0');
      if ptr <> nil then
        result := IIDLType(ptr)
      else
        assert(false,'not imlplemented');
    end;
end;

function TIDLType._type(): ITypeCode;
begin
  result := FType;
end;

//*************************************************
// TRepository
//*************************************************
constructor TRepository.Create;
begin
  inherited Create();
  _pk_void := TPrimitiveDef.Create(pk_void);
  _pk_short := TPrimitiveDef.Create(pk_short);
  _pk_long := TPrimitiveDef.Create(pk_long);
  _pk_ushort := TPrimitiveDef.Create(pk_ushort);
  _pk_ulong := TPrimitiveDef.Create(pk_ulong);
  _pk_float := TPrimitiveDef.Create(pk_float);
  _pk_double := TPrimitiveDef.Create(pk_double);
  _pk_boolean := TPrimitiveDef.Create(pk_boolean);
  _pk_char := TPrimitiveDef.Create(pk_char);
  _pk_octet := TPrimitiveDef.Create(pk_octet);
  _pk_any := TPrimitiveDef.Create(pk_any);
  _pk_TypeCode := TPrimitiveDef.Create(pk_TypeCode);
  _pk_Principal := TPrimitiveDef.Create(pk_Principal);
  _pk_string := TPrimitiveDef.Create(pk_string);
  _pk_objref := TPrimitiveDef.Create(pk_objref);
  _pk_longlong := TPrimitiveDef.Create(pk_longlong);
  _pk_ulonglong := TPrimitiveDef.Create(pk_ulonglong);
  _pk_longdouble := TPrimitiveDef.Create(pk_longdouble);
  _pk_wchar := TPrimitiveDef.Create(pk_wchar);
  _pk_wstring := TPrimitiveDef.Create(pk_wstring);
  _pk_value_base := TPrimitiveDef.Create(pk_value_base);
  FDefKind := dk_Repository;
end;

class function TRepository._narrow(const obj: IORBObject): IRepository;
var
  ptr: Pointer;
begin
  result := nil;
  if obj <> nil then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/Repository:1.0');
      if ptr <> nil then
        result := IRepository(ptr);
      // repository stub not implemented
    end;
end;

function TRepository.add_anonymous_type(t: IIDLType): IIDLType;
var
  tc: ITypeCode;
  i,j : integer;
begin
  i := Length(FAnonymousTypes);
  tc := t._type;
  for j := 0 to Pred(i) do
    if FAnonymousTypes[j]._type = tc then
      begin
        result := FAnonymousTypes[j];
        exit;
      end;
  SetLength(FAnonymousTypes,i+1);
  FAnonymousTypes[i] := t;
  result := t;
end;

function TRepository.create_sequence(bound: _ulong;
  element_type: IIDLType): ISequenceDef;
var
  t : IIDLType;
begin
  result := TSequenceDef.Create(self,bound,element_type);
  t := add_anonymous_type(result);
  result := TSequenceDef._narrow(t as IORBObject);
end;

function TRepository.create_array(length: _ulong;
  element_type: IIDLType): IArrayDef;
var
  t : IIDLType;
begin
  result := TArrayDef.Create(self,length,element_type);
  t := add_anonymous_type(result);
  result := TArrayDef._narrow(t as IORBObject);
end;

function TRepository._absolute_name: AnsiString;
begin
  result := '';
end;

function TRepository.absolute_name: AnsiString;
begin
  result := '::';
end;

function TRepository.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  if repoid = 'IDL:omg.org/CORBA/Repository:1.0' then
    result := Pointer(self as IRepository)
  else
    result := inherited narrow_helper(repoid);
end;

function TRepository.get_primitive(kind: TPrimitiveKind) : IPrimitiveDef;
begin
  case kind of
    pk_void: result := _pk_void;
    pk_short: result := _pk_short;
    pk_long: result := _pk_long;
    pk_ushort: result := _pk_ushort;
    pk_ulong: result := _pk_ulong;
    pk_float: result := _pk_float;
    pk_double: result := _pk_double;
    pk_boolean: result := _pk_boolean;
    pk_char: result := _pk_char;
    pk_octet: result := _pk_octet;
    pk_any: result := _pk_any;
    pk_TypeCode: result := _pk_TypeCode;
    pk_Principal: result := _pk_Principal;
    pk_string: result := _pk_string;
    pk_objref: result := _pk_objref;
    pk_longlong: result := _pk_longlong;
    pk_ulonglong: result := _pk_ulonglong;
    pk_longdouble: result := _pk_longdouble;
    pk_wchar: result := _pk_wchar;
    pk_wstring: result := _pk_wstring;
    pk_value_base: result := _pk_value_base;
  end;
end;

//*************************************************
//  TPrimitiveDef
//*************************************************
constructor TPrimitiveDef.Create(kind: TPrimitiveKind);
begin
  FDefKind := dk_Primitive;
  FKind := kind;
  case FKind of
    pk_void: FType := _tc_void;
    pk_short: FType := _tc_short;
    pk_long: FType := _tc_long;
    pk_ushort: FType := _tc_ushort;
    pk_ulong: FType := _tc_ulong;
    pk_float: FType := _tc_float;
    pk_double: FType := _tc_double;
    pk_boolean: FType := _tc_boolean;
    pk_char: FType := _tc_char;
    pk_octet: FType := _tc_octet;
    pk_any: FType := _tc_any;
    pk_TypeCode: FType := _tc_TypeCode;
    pk_Principal: FType := _tc_Principal;
    pk_string: FType := _tc_string;
    pk_objref: FType := _tc_objref;
    pk_longlong: FType := _tc_longlong;
    pk_ulonglong: FType := _tc_ulonglong;
    pk_longdouble: FType := _tc_longdouble;
    pk_wchar: FType := _tc_wchar;
    pk_wstring: FType := _tc_wstring;
  end;
end;

function TPrimitiveDef.kind: TPrimitiveKind;
begin
  result := FKind;
end;

class function TPrimitiveDef._narrow(obj: IORBObject): IPrimitiveDef;
var
  ptr: Pointer;
begin
  result := nil;
  ptr := obj.narrow_helper('IDL:omg.org/CORBA/PrimitiveDef:1.0');
  if ptr <> nil then result := IPrimitiveDef(ptr);
end;

function TPrimitiveDef.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  if repoid = 'IDL:omg.org/CORBA/PrimitiveDef:1.0' then
    result := Pointer(self as IPrimitiveDef)
  else
    result := inherited narrow_helper(repoid)
end;


//*********************************************************************
//  TStructDef
//*********************************************************************
constructor TStructDef.Create(con: IContainer; id : RepositoryId; name, version: Identifier;
  members: PStructMemberSeq);
begin
  inherited Create();
  FContainer := con;
  FID := id;
  FDefKind := dk_Struct;
  FVersion := version;
  FName := name;
  if members <> nil then
    FMembers := members^;
  FTypeCode := nil;
end;

function TStructDef._type: ITypeCode;
begin
  if FTypeCode = nil then
    FTypeCode := FORB.create_struct_tc(FID,FName,FMembers);
  result := FTypeCode;
end;

function TStructDef.recursive_type: ITypeCode;
begin
//WJ: Getter should return value !!!!
  result := _type();
end;

procedure TStructDef.members(val: StructMemberSeq);
begin
  FMembers := copy(val);
end;

function TStructDef.members: PStructMemberSeq;
begin
  result := @FMembers
end;

function TStructDef.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  if repoid = 'IDL:omg.org/CORBA/StructDef:1.0' then
    result := Pointer(self as IStructDef)
  else if repoid = 'IDL:omg.org/CORBA/IDLType:1.0' then
    result := Pointer(self as IIDLType)
  else if repoid = 'IDL:omg.org/CORBA/TypedefDef:1.0' then
    result := Pointer(self as ITypedefDef)
  else if repoid = 'IDL:omg.org/CORBA/Contained:1.0' then
    result := Pointer(self as IContained)
  else
    result := inherited narrow_helper(repoid)
end;

class function TStructDef._narrow(const obj: IORBObject): IStructDef;
var
  ptr: Pointer;
begin
  result := nil;
  if obj <> nil then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/StructDef:1.0');
      if ptr <> nil then  result := IStructDef(ptr);
    end;
end;

//*********************************************************************
//  TAliasDef
//*********************************************************************
constructor TAliasDef.Create(con: IContainer; id : RepositoryId; name, version: Identifier);
begin
  inherited Create();
  FDefKind := dk_Alias;
  FContainer := con;
  FID := id;
  FName := name;
  FVersion := version;
end;

class function TAliasDef._narrow(const obj: IORBObject): IAliasDef;
var
  ptr: Pointer;
begin
  result := nil;
  if obj <> nil then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/AliasDef:1.0');
      if ptr <> nil then result := IAliasDef(ptr);
    end;
end;

function TAliasDef.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  if repoid = 'IDL:omg.org/CORBA/AliasDef:1.0' then
    result := Pointer(self as IIDLType)
  else if repoid = 'IDL:omg.org/CORBA/IDLType:1.0' then
    result := Pointer(self as IIDLType)
  else if repoid = 'IDL:omg.org/CORBA/TypedefDef:1.0' then
    result := Pointer(self as ITypedefDef)
  else
    result := inherited narrow_helper(repoid)
end;

function TAliasDef.original_type_def: IIDLType;
begin
  result := FOriginal;
end;

procedure TAliasDef.set_original_type_def(val: IIDLType);
begin
  FOriginal := val;
end;

function TAliasDef._type: ITypeCode;
begin
  if FTypeCode = nil then
    FTypeCode := FORB.create_alias_tc(FID,FName,FOriginal._type);
  result := FTypeCode;
end;

function TAliasDef.recursive_type: ITypeCode;
begin
  result := _type();
end;

//*********************************************************************
//  TEnumDef
//*********************************************************************
constructor TEnumDef.Create(con: IContainer; id : RepositoryId; name,version: Identifier;
  members: PEnumMemberSeq);
begin
  inherited Create();
  FDefKind := dk_Enum;
  FContainer := con;
  FID := id;
  FName := name;
  FVersion := version;
  if members <> nil then
    FMembers := members^;
end;

function TEnumDef._type: ITypeCode;
begin
  if FTypeCode = nil then
    FTypeCode := FORB.create_enum_tc(FID,FName,FMembers);
  result := FTypeCode;
end;

function TEnumDef.recursive_type: ITypeCode;
begin
  result := _type();
end;

function TEnumDef.members: PEnumMemberSeq;
begin
  result := @FMembers;
end;

procedure TEnumDef.set_members(val: PEnumMemberSeq);
begin
  if val <> nil then
    FMembers := val^
  else
    setLength(FMembers,0);
end;

function TEnumDef.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  if repoid = 'IDL:omg.org/CORBA/EnumDef:1.0' then
    result := Pointer(self as IEnumDef)
  else if repoid = 'IDL:omg.org/CORBA/IDLType:1.0' then
    result := Pointer(self as IIDLType)
  else if repoid = 'IDL:omg.org/CORBA/TypedefDef:1.0' then
    result := Pointer(self as ITypedefDef)
  else
    result := inherited narrow_helper(repoid)
end;

class function TEnumDef._narrow(const obj: IORBObject): IEnumDef;
var
  ptr: Pointer;
begin
  result := nil;
  ptr := obj.narrow_helper('IDL:omg.org/CORBA/EnumDef:1.0');
  if ptr <> nil then
    result := IEnumDef(ptr);
end;

//*********************************************************************
// TSequenceDef
//*********************************************************************
constructor TSequenceDef.Create(const con: IContainer;bound: _ulong; element_type: IIDLType);
begin
  inherited Create();
  FContainer := con;
  FDefKind := dk_Sequence;
  FBound := bound;
  FType := element_type;
end;

function TSequenceDef.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  if repoid = 'IDL:omg.org/CORBA/SequenceDef:1.0' then
    result := Pointer(self as ISequenceDef)
  else if repoid = 'IDL:omg.org/CORBA/IDLType:1.0' then
    result := Pointer(self as IIDLType)
  else
    result := nil;
end;

class function TSequenceDef._narrow(const obj: IORBObject): ISequenceDef;
var
  ptr: Pointer;
begin
  result := nil;
  if obj <> nil then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/SequenceDef:1.0');
      if ptr <> nil then
        result := ISequenceDef(ptr);
    end;
end;

function TSequenceDef._type: ITypeCode;
begin
  if FTypeCode = nil then
    FTypeCode := FORB.create_sequence_tc(FBound,FType._type);
  result := FTypeCode
end;

function TSequenceDef.recursive_type: ITypeCode;
begin

end;

function TSequenceDef.bound: _ulong;
begin
  result := FBound
end;

function TSequenceDef.element_type: ITypeCode;
begin
  result := FType._type
end;

function TSequenceDef.element_type_def: IIDLType;
begin
  result := FType
end;

procedure TSequenceDef.set_bound(val: _ulong);
begin
  FBound := val;
end;

procedure TSequenceDef.set_element_type_def(const val: IIDLType);
begin
  FType := val;
end;

//*********************************************************************
//  TModuleDef
//*********************************************************************
constructor TModuleDef.Create(const con: IContainer; id : RepositoryId; name,version: Identifier);
begin
  inherited Create();
  FDefKind := dk_Module;
  FContainer := con;
  FName := name;
  FID := id;
  FVersion := version;
end;

function TModuleDef.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  if repoid = 'IDL:omg.org/CORBA/ModuleDef:1.0' then
    result := Pointer(self as IModuleDef)
  else if repoid = 'IDL:omg.org/CORBA/Contained:1.0' then
    result := Pointer(self as IContained)
  else
    result := inherited narrow_helper(repoid);
end;

function TModuleDef._describe: ModuleDescription;
var
  con : IContained;
begin
  result.name := FName;
  result.id := FId;
  con := TContained._narrow(FContainer as IORBObject);
  if assigned(con) then
    result.defined_in := con._id
  else
    result.defined_in := '';
  result.version := FVersion;
end;

class function TModuleDef._narrow(const obj: IORBObject): IModuleDef;
var
  ptr: Pointer;
begin
  result := nil;
  if obj <> nil then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/ModuleDef:1.0');
      if ptr <> nil then
        result := IModuleDef(ptr);
    end;
end;

//*********************************************************************
//  TConstantDef
//*********************************************************************
function TConstantDef._describe: ConstantDescription;
begin
  assert(false,'not implemented');
end;

function TConstantDef._type: ITypeCode;
begin
  result := FType._type;
end;

constructor TConstantDef.Create(con: IContainer; id, name, version: AnsiString;
  t: IIDLType; val: IAny);
begin
  inherited Create();
  FDefKind := dk_Constant;
  FContainer := con;
  FID := id;
  FName := name;
  FVersion := version;
  FValue := val;
  FType := t;
end;

function TConstantDef.type_def: IIDLType;
begin
  result := FType
end;

procedure TConstantDef.type_def(const val: IIDLType);
begin
  FType := val;
end;

function TConstantDef.value: IAny;
begin
  result := FValue;
end;

procedure TConstantDef.value(const val: IAny);
begin
  FValue := val;
end;

class function TConstantDef._narrow(const obj: IORBObject): IConstantDef;
var
  ptr: Pointer;
begin
  result := nil;
  if obj <> nil then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/ConstantDef:1.0');
      if ptr <> nil then
        result := IConstantDef(ptr);
    end;
end;

function TConstantDef.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  if repoid = 'IDL:omg.org/CORBA/ConstantDef:1.0' then
    result := Pointer(self as IConstantDef)
  else
    result := inherited narrow_helper(repoid);
end;

//*********************************************************************
//  TArrayDef
//*********************************************************************
constructor TArrayDef.Create(const con: IContainer; length: _ulong;
  element_type: IIDLType);
begin
  inherited Create(nil);
  FDefKind := dk_Array;
  FLength := length;
  FType := element_type;
end;

class function TArrayDef._narrow(const obj: IORBObject): IArrayDef;
var
  ptr: Pointer;
begin
  result := nil;
  if obj <> nil then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/ArrayDef:1.0');
      if ptr <> nil then
        result := IArrayDef(ptr);
    end;
end;

function TArrayDef._type: ITypeCode;
begin
  if FTypeCode = nil then
    FTypeCode := FORB.create_array_tc(FLength,FType._type);
  result := FTypeCode
end;

function TArrayDef.element_type: ITypeCode;
begin
  result := FType._type;
end;

procedure TArrayDef.element_type_def(val: IIDLType);
begin
  FType := val;
end;

function TArrayDef.element_type_def: IIDLType;
begin
  result := FType
end;

function TArrayDef.length: _ulong;
begin
  Result := FLength
end;

procedure TArrayDef.length(val: _ulong);
begin
  FLength := val;
end;

function TArrayDef.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  if repoid = 'IDL:omg.org/CORBA/ArrayDef:1.0' then
    result := Pointer(self as IArrayDef)
  else if repoid = 'IDL:omg.org/CORBA/IDLType:1.0' then
    result := Pointer(self as IIDLType)
  else
    result := inherited narrow_helper(repoid);
end;

//*********************************************************************
//  TUnionDef
//*********************************************************************
constructor TUnionDef.Create(con: IContainer;id : RepositoryId; name,version: Identifier; discriminator_type: IIDLType; mem: UnionMemberSeq);
begin
  inherited Create();
  FName := name;
  FID := id;
  FVersion := version;
  FContainer := con;
  FMembers := mem;
  FDiscriminator := discriminator_type;
  FDefKind := dk_Union;
end;

class function TUnionDef._narrow(const obj: IORBObject): IUnionDef;
var
  ptr: Pointer;
begin
  result := nil;
  if obj <> nil then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/UnionDef:1.0');
      if ptr <> nil then  result := IUnionDef(ptr);
    end;
end;

function TUnionDef._type: ITypeCode;
begin
  result := nil;
  if not assigned(FDiscriminator) then exit;
  if not assigned(FTypeCode) then
    FTypeCode := FORB.create_union_tc(FId,FName,discriminator_type,FMembers);
  result := FTypeCode;
end;

function TUnionDef.recursive_type: ITypeCode;
begin

end;

function TUnionDef.discriminator_type: ITypeCode;
begin
  result := FDiscriminator._type
end;

procedure TUnionDef.discriminator_type_def(val: IIDLType);
begin
  FDiscriminator := val;
end;

function TUnionDef.discriminator_type_def: IIDLType;
begin
  result := FDiscriminator
end;

procedure TUnionDef.members(val: UnionMemberSeq);
begin
  FMembers := copy(val);
end;

function TUnionDef.members: PUnionMemberSeq;
begin
  result := @FMembers;
end;

function TUnionDef.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  if repoid = 'IDL:omg.org/CORBA/UnionDef:1.0' then
    result := Pointer(self as IUnionDef)
  else if repoid = 'IDL:omg.org/CORBA/TypedefDef:1.0' then
    result := Pointer(self as ITypedefDef)
  else if repoid = 'IDL:omg.org/CORBA/IDLType:1.0' then
    result := Pointer(self as ITypedefDef)
  else if repoid = 'IDL:omg.org/CORBA/Contained:1.0' then
    result := Pointer(self as IContained)
  else
    result := inherited narrow_helper(repoid);
end;

//*********************************************************************
//  TExceptionDef
//*********************************************************************
constructor TExceptionDef.Create(con: IContainer; id : RepositoryId; name,version: Identifier; mem: PStructMemberSeq);
begin
  inherited Create();
  FContainer := con;
  FID := id;
  FDefKind := dk_Exception;
  FVersion := version;
  FName := name;
  if mem <> nil then
    FMembers := mem^;
  FTypeCode := FORB.create_exception_tc(id,name,FMembers);
end;

function TExceptionDef._type: ITypeCode;
begin
  result := FTypeCode;
end;

function TExceptionDef.recursive_type: ITypeCode;
begin
  result := _type();
end;

function TExceptionDef.members: PStructMemberSeq;
begin
  result := @FMembers;
end;

procedure TExceptionDef.members(val: StructMemberSeq);
begin
  FMembers := copy(val);
end;

class function TExceptionDef._narrow(const obj: IORBObject): IExceptionDef;
var
  ptr: Pointer;
begin
  result := nil;
  if obj <> nil then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/ExceptionDef:1.0');
      if ptr <> nil then  result := IExceptionDef(ptr);
    end;
end;


function TExceptionDef.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  if repoid = 'IDL:omg.org/CORBA/ExceptionDef:1.0' then
    result := Pointer(self as IExceptionDef)
  else if repoid = 'IDL:omg.org/CORBA/Contained:1.0' then
    result := Pointer(self as IContained)
  else if repoid = 'IDL:omg.org/CORBA/IDLType:1.0' then
    result := Pointer(self as IIDLType)
  else
    result := inherited narrow_helper(repoid);
end;

{ TNativeDef }

constructor TNativeDef.Create(con: IContainer; const id : RepositoryId; const name,version: Identifier);
begin
  inherited Create();
  FContainer := con;
  FID := id;
  FDefKind := dk_Native;
  FVersion := version;
  FName := name;
  FTypeCode := FORB.create_native_tc(id, name);
end;

function TNativeDef._type: ITypeCode;
begin
  result := FTypeCode;
end;

function TNativeDef.recursive_type: ITypeCode;
begin
  result := _type();
end;

function TNativeDef.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  if repoid = 'IDL:omg.org/CORBA/NativeDef:1.0' then
    result := Pointer(self as INativeDef)
  else if repoid = 'IDL:omg.org/CORBA/IDLType:1.0' then
    result := Pointer(self as IIDLType)
  else if repoid = 'IDL:omg.org/CORBA/TypedefDef:1.0' then
    result := Pointer(self as ITypedefDef)
  else
    result := inherited narrow_helper(repoid)
end;

class function TNativeDef._narrow(const obj: IORBObject): INativeDef;
var
  ptr: Pointer;
begin
  result := nil;
  if obj <> nil then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/NativeDef:1.0');
      if ptr <> nil then  result := INativeDef(ptr);
    end;
end;

{ TFixedDef }

class function TFixedDef._narrow(const obj: IORBObject): IFixedDef;
var
  ptr: Pointer;
begin
  result := nil;
  if obj <> nil then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/FixedDef:1.0');
      if ptr <> nil then  result := IFixedDef(ptr);
    end;
end;

function TFixedDef.get_digits: _ushort;
begin
  result := FDigits;
end;

function TFixedDef.get_scale: short;
begin
  result := FScale;
end;

function TFixedDef.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  if repoid = 'IDL:omg.org/CORBA/FixedDef:1.0' then
    result := Pointer(self as IFixedDef)
  else
    result := inherited narrow_helper(repoid);
end;

procedure TFixedDef.set_digits(value: _ushort);
begin
  FDigits := value;
end;

procedure TFixedDef.set_scale(value: short);
begin
  FScale := value;
end;

{ TExtAttributeDef }

constructor TExtAttributeDef.Create(const con: IContainer; id : RepositoryId; name,version: Identifier; atype: IIDLType; amode: AttributeMode; getExceptions,
  setExceptions: ExceptionDefSeq);
begin
  inherited Create(con, id, name, version, atype, amode);
  FgetExceptions := getExceptions;
  FsetExceptions := setExceptions;
end;

function TExtAttributeDef.get_getExceptions: ExceptionDefSeq;
begin
  Result := FgetExceptions;
end;

function TExtAttributeDef.get_setExceptions: ExceptionDefSeq;
begin
  Result := FsetExceptions;
end;

procedure TExtAttributeDef.set_getExceptions(val: ExceptionDefSeq);
begin
  FgetExceptions := val;
end;

procedure TExtAttributeDef.set_setExceptions(val: ExceptionDefSeq);
begin
  FsetExceptions := val;
end;

end.

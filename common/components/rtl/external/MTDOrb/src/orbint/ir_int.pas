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
unit ir_int;

interface

uses
  orbtypes,Classes,code_int;

type

  IIDLType = interface;
  IStructDef = interface;
  IAliasDef = interface;
  IEnumDef = interface;
  IModuleDef = interface;
  IRepository = interface;
  IConstantDef = interface;
  IArrayDef = interface;
  IUnionDef = interface;
  IExceptionDef = interface;
  IValueBoxDef = interface;
  INativeDef = interface;
  IFixedDef = interface;

  ExceptionDefSeq = array of IExceptionDef;
  PExceptionDefSeq = ^ExceptionDefSeq;

  StructMember = record
    name: Identifier;
    _type: ITypeCode;
    type_def: IIDLType;
  end;

  ValueMember = record
    name: Identifier;
    id: RepositoryId;
    defined_in : RepositoryId;
    version: VersionSpec;
    _type: ITypeCode;
    type_def: IIDLType;
    access: TVisibility;
  end;

  ValueMemberSeq = array of ValueMember;

  UnionMember = record
    name: Identifier;
    _label: IAny;
    _type: ITypeCode;
    type_def: IIDLType;
  end;

  UnionMemberSeq = array of UnionMember;
  PUnionMemberSeq = ^UnionMemberSeq;

  TypeDescription = record
    name: Identifier;
    id: RepositoryId;
    defined_in: RepositoryId;
    version: VersionSpec;
    _type: ITypeCode;
  end;

  ParameterDescription = record
    name: Identifier;
    _type: ITypeCode;
    type_def: IIDLType;
    mode: ParameterMode;
  end;

  ParDescriptionSeq = array of ParameterDescription;

  ConstantDescription = record
    name: Identifier;
    id: RepositoryId;
    defined_in: RepositoryId;
    version: VersionSpec;
    _type: ITypeCode;
    value: IAny;
  end;

  ExceptionDescription = record
    name: Identifier;
    id: RepositoryId;
    defined_in: RepositoryId;
    version: VersionSpec;
    _type: ITypeCode;
  end;

  ExcDescriptionSeq = array of ExceptionDescription;

  OperationDescription = record
    name: Identifier;
    id: RepositoryId;
    defined_in: RepositoryId;
    version: VersionSpec;
    _result: ITypeCode;
    mode: TOperationMode;
    contexts: ContextIdSeq;
    parameters: ParDescriptionSeq;
    exceptions : ExcDescriptionSeq;
  end;

  AttributeDescription = record
    name: Identifier;
    id: RepositoryId;
    defined_in: AnsiString;
    version: AnsiString;
    _type: ITypeCode;
    mode: AttributeMode;
  end;

  OpDescriptionSeq = array of OperationDescription;

  AttrDescriptionSeq = array of AttributeDescription;

  StructMemberSeq = array of StructMember;
  PStructMemberSeq = ^StructMemberSeq;

  Initializer = record
    members: StructMemberSeq;
    name: Identifier;
  end;

  InitializerSeq = array of Initializer;
  PInitializerSeq = ^InitializerSeq;

  FullValueDescription = record
    name: Identifier;
    id: RepositoryId;
    is_abstract: Boolean;
    is_custom : Boolean;
    defined_in: AnsiString;
    Version: AnsiString;
    operations: OpDescriptionSeq;
    attributes : AttrDescriptionSeq;
    members: ValueMemberSeq;
    initializers : InitializerSeq;
    supported_interfaces: RepositoryIDSeq;
    abstract_base_values: RepositoryIDSeq;
    is_truncatable: boolean;
    base_value: RepositoryID;
    _type: ITypeCode;
  end;

  ModuleDescription = record
    name: Identifier;
    id: RepositoryId;
    defined_in: RepositoryId;
    version: VersionSpec;
  end;


  PValueMemberSeq = ^ValueMemberSeq;

  EnumMemberSeq = array of AnsiString;
  PEnumMemberSeq = ^EnumMemberSeq;

  IInterfaceDef = interface;
  IContainer = interface;
  IValueDef = interface;

  IIRObject = interface
  ['{61252F21-4D23-11d4-9D27-204C4F4F5020}']
    function def_kind: TDefinitionKind;
  end;

  IContained = interface(IIRObject)
  ['{61252F22-4D23-11d4-9D27-204C4F4F5020}']
    function _id: RepositoryId; overload;
    procedure _id(const val: RepositoryId); overload;
    function _name: Identifier;
    function absolute_name: AnsiString;
    function _version: AnsiString; overload;
    procedure _version(const val: AnsiString); overload;
    function defined_in: IContainer;
    procedure move(const new_container: IContainer;
      new_name: Identifier; new_version: AnsiString);
    function containing_repository: IRepository;
    // DORB extension
    function _absolute_name: Identifier;
  end;

  IContainer = interface(IIRObject)
  ['{61252F23-4D23-11d4-9D27-204C4F4F5020}']
    function create_interface(id : RepositoryId; name,version: Identifier; base_interfaces: IInterfaceList; is_abstract: Boolean; is_local: Boolean): IInterfaceDef;
    function create_struct(id : RepositoryId; name,version: Identifier; members: PStructMemberSeq): IStructDef;
    function create_value(id : RepositoryId; name,version: Identifier; is_custom,is_abstract: Boolean; base_value: IValueDef; is_truncatable: Boolean; abstract_base_values, supported_interfaces: IInterfaceList; initializers: PInitializerSeq ): IValueDef;
    function create_value_box(id : RepositoryId; name,version: Identifier; orig: IIDLType): IValueBoxDef;
    function create_alias(id : RepositoryId; name,version: Identifier; orig: IIDLType ): IAliasDef;
    function create_exception(id : RepositoryId; name,version: Identifier; members: PStructMemberSeq): IExceptionDef;
    function create_enum(id : RepositoryId; name,version: Identifier; members: PEnumMemberSeq): IEnumDef;
    function create_module(id : RepositoryId; name,version: Identifier): IModuleDef;
    function create_constant(id : RepositoryId; name,version: Identifier; t: IIDLType; val: IAny): IConstantDef;
    function create_union(id : RepositoryId; name,version: Identifier; descr : IIDLType; members: UnionMemberSeq): IUnionDef;
    function create_native(const id : RepositoryId; const name,version: Identifier ): INativeDef;
    function create_fixed(const digits: _ushort; const scale: short): IFixedDef;
    procedure add_contained(const cont: IContained);
    procedure remove_contained(const cont: IContained);
    function lookup(search_name: AnsiString): IContained;
    function find(search_name: AnsiString) : IContained;
    function lookup_name(search_name: Identifier; levels_to_search: longint ;
      limit : TDefinitionKind = dk_all; exclude_inherited: Boolean = false): IInterfaceList;
    function locate_id(id: RepositoryId): IContained;
    function locate_name(const name: Identifier; include_enclosing_scopes: Boolean; is_first_level: Boolean): IContained;
    function contents(limit : TDefinitionKind = dk_all; exclude_inherited: Boolean = false): IInterfaceList;
  end;

  IIDLType = interface(IIRObject)
  ['{61252F24-4D23-11d4-9D27-204C4F4F5020}']
    function _type(): ITypeCode;
    function recursive_type(): ITypeCode;
  end;

  ITypedefDef = interface(IIDLType)
  ['{61252F25-4D23-11d4-9D27-204C4F4F5020}']
  end;

  IStructDef = interface(ITypedefDef)
  ['{61252F26-4D23-11d4-9D27-204C4F4F5020}']
    function members: PStructMemberSeq; overload;
    procedure members(val: StructMemberSeq); overload;
  end;

  IUnionDef = interface(ITypedefDef)
  ['{61252F27-4D23-11d4-9D27-204C4F4F5020}']
    function discriminator_type: ITypeCode;
    function discriminator_type_def: IIDLType; overload;
    procedure discriminator_type_def(val: IIDLType); overload;
    function members: PUnionMemberSeq; overload;
    procedure members(val: UnionMemberSeq); overload;
  end;

  IModuleDef = interface(IContained)
  ['{97C311C1-81A4-11d4-9D69-204C4F4F5020}']
    function _describe: ModuleDescription;
  end;

  IEnumDef = interface(ITypedefDef)
  ['{61252F28-4D23-11d4-9D27-204C4F4F5020}']
    function members: PEnumMemberSeq;
    procedure set_members(val: PEnumMemberSeq);
  end;

  IStringDef = interface(IIDLType)
  ['{61252F29-4D23-11d4-9D27-204C4F4F5020}']
    function get_bound: _ulong;
    procedure set_bound(val: _ulong);
  end;

  IWStringDef = interface(IIDLType)
  ['{61252F30-4D23-11d4-9D27-204C4F4F5020}']
    function get_bound: _ulong;
    procedure set_bound(val: _ulong);
  end;

  ISequenceDef = interface(IIDLType)
  ['{61252F31-4D23-11d4-9D27-204C4F4F5020}']
    function bound: _ulong;
    procedure set_bound(val: _ulong);
    function element_type: ITypeCode;
    function element_type_def: IIDLType;
    procedure set_element_type_def(const val: IIDLType);
  end;

  IOperationDef = interface(IContained)
  ['{61252F32-4D23-11d4-9D27-204C4F4F5020}']
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
  end;

  IAttributeDef = interface(IContained)
  ['{61252F33-4D23-11d4-9D27-204C4F4F5020}']
    function _type: ITypeCode;
    function get_type_def: IIDLType;
    procedure set_type_def(const val: IIDLType);
    function get_mode: AttributeMode;
    procedure set_mode(val: AttributeMode);
    // DORB extension
    function _describe: AttributeDescription;
    property mode: AttributeMode read get_mode write set_mode;
  end;

  IExtAttributeDef = interface(IAttributeDef)
  ['{7E8D7C3A-9669-4A62-BA16-C527C36DBF9B}']
    function get_getExceptions: ExceptionDefSeq;
    procedure set_getExceptions(val: ExceptionDefSeq);
    function get_setExceptions: ExceptionDefSeq;
    procedure set_setExceptions(val: ExceptionDefSeq);
    property getExceptions: ExceptionDefSeq read get_getExceptions write set_getExceptions;
    property setExceptions: ExceptionDefSeq read get_setExceptions write set_setExceptions;
  end;

  IInterfaceDef = interface(IContained)
  ['{61252F35-4D23-11d4-9D27-204C4F4F5020}']
    function create_attribute(id : RepositoryId; name,version: Identifier; atype: IIDLType; amode: AttributeMode;
      getExceptions : ExceptionDefSeq = nil; setExceptions : ExceptionDefSeq = nil): IExtAttributeDef;
    function create_operation(id : RepositoryId; name,version: Identifier; oresult: IIDLType; omode: TOperationMode;
      const params: ParDescriptionSeq = nil; exceptions : ExceptionDefSeq = nil): IOperationDef;
    function get_base_interfaces: IInterfaceList;
    procedure set_base_interfaces(const val: IInterfaceList);
    function get_is_abstract: Boolean;
    procedure set_is_abstract(val: Boolean);
    function get_is_local: Boolean;
    procedure set_is_local(val: Boolean);
  end;

  IValueMemberDef = interface(IContained)
  ['{61252F36-4D23-11d4-9D27-204C4F4F5020}']
    function _type: ITypeCode;
    function get_type_def: IIDLType;
    procedure set_type_def(const val: IIDLType);
    function get_access: TVisibility;
    procedure set_access(val: TVisibility);
  end;

  IValueBoxDef = interface(IContained)
  ['{0E2809F6-BDA4-4bae-90CA-258100788CDF}']
    procedure original_type_def(const val: IIDLType); overload;
    function original_type_def: IIDLType; overload;
  end;

  IValueDef = interface(IIDLType)
  ['{61252F37-4D23-11d4-9D27-204C4F4F5020}']
    function describe_value(): FullValueDescription;
    function get_supported_interfaces: IInterfaceList;
    procedure set_supported_interfaces(const val: IInterfaceList);
    function initializers: InitializerSeq;
    procedure resize_initializers(len: integer);
    function get_base_value: IValueDef;
    procedure set_base_value(const val: IValueDef);
    function get_abstract_base_values: IInterfaceList;
    procedure set_abstract_base_values(const val: IInterfaceList);
    function is_abstract: Boolean;
    procedure set_is_abstract(val: Boolean);
    function is_custom: Boolean;
    procedure set_is_custom(val: Boolean);
    function is_truncatable: Boolean;
    procedure set_is_truncatable(val: Boolean);
    function create_value_member(id : RepositoryId; name,version: Identifier; mtype: IIDLType; acc: TVisibility): IValueMemberDef;
    function create_attribute(id : RepositoryId; name,version: Identifier; atype: IIDLType; amode: AttributeMode;
      getExceptions : ExceptionDefSeq = nil; setExceptions : ExceptionDefSeq = nil): IExtAttributeDef;
    function create_operation(id : RepositoryId; name,version: Identifier; oresult: IIDLType;
      omode: TOperationMode; const params: ParDescriptionSeq = nil; exceptions: ExceptionDefSeq = nil): IOperationDef;
  end;

  IPrimitiveDef = interface(IIDLType)
  ['{61252F38-4D23-11d4-9D27-204C4F4F5020}']
    function kind: TPrimitiveKind;
  end;

  IRepository = interface(IContainer)
  ['{61252F39-4D23-11d4-9D27-204C4F4F5020}']
    function get_primitive(kind: TPrimitiveKind) : IPrimitiveDef;
    function create_sequence(bound: _ulong; element_type: IIDLType): ISequenceDef;
    function create_array(length: _ulong; element_type: IIDLType): IArrayDef;
  end;

  IAliasDef = interface(ITypedefDef)
  ['{334028C1-5709-11d4-9D2E-204C4F4F5020}']
    function original_type_def: IIDLType;
    procedure set_original_type_def(val : IIDLType);
  end;

  IConstantDef = interface(IContained)
  ['{35C19DF5-16B6-411a-AED6-422A22B579AE}']
    function _type: ITypeCode;
    function type_def: IIDLType; overload;
    procedure type_def(const val : IIDLType); overload;
    function value: IAny; overload;
    procedure value(const val : IAny); overload;
    function _describe: ConstantDescription;
  end;

  IArrayDef = interface(IIDLType)
  ['{62E322C1-9C83-11d4-9DB4-204C4F4F5020}']
    function length: _ulong; overload;
    procedure length(val: _ulong); overload;
    function element_type: ITypeCode;
    function element_type_def: IIDLType; overload;
    procedure element_type_def(val: IIDLType); overload;
  end;

  IExceptionDef = interface(IContained)
  ['{62E322C2-9C83-11d4-9DB4-204C4F4F5020}']
    function _type: ITypeCode;
    function members: PStructMemberSeq; overload;
    procedure members(val: StructMemberSeq); overload;
  end;

  INativeDef = interface(ITypedefDef)
  ['{0B9A2CD7-D3F0-4AFF-8961-E12A7D60F120}']
  end;

  IFixedDef = interface(IIDLType)
  ['{53B33468-1B2F-4C16-B82B-B773814241A9}']
    procedure set_digits(value: _ushort);
    function get_digits(): _ushort;
    procedure set_scale(value: short);
    function get_scale(): short;
  end;

implementation

end.

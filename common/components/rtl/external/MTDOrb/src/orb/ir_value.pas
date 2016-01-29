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
unit ir_value;

interface

uses
  ir_int,orb_int,orb,Classes,orbtypes,code_int,ir;

type

  TValueBoxDef = class(TContained,IValueBoxDef,ITypedefDef,IContained,IIDLType)
  private
    FOriginalType : IIDLType;
    FType : ITypeCode;
  protected
    procedure original_type_def(const val: IIDLType); overload;
    function original_type_def: IIDLType; overload;
    procedure _id(const val: AnsiString); override;
    // IIDLType methods
    function _type(): ITypeCode;
    function recursive_type(): ITypeCode;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
  public
    constructor Create(const con: IContainer;id, name, version: AnsiString;
      original: IIDLType);
  end;

  TValueDef = class(TContainer,IValueDef,IContained,IIDLType)
  protected
    FTypeCode: ITypeCode;
    FCustom,FAbstract,FTruncatable : Boolean;
    FBaseValue: IValueDef;
    FAbstractBaseValues: IInterfaceList;
    FSupportedInt : IInterfaceList;
    FInitializers : InitializerSeq;
    FVisited: Boolean;
  protected
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
    function create_value_member(id : RepositoryId; name, version: Identifier; mtype: IIDLType; acc: TVisibility): IValueMemberDef;
    function create_attribute(id : RepositoryId; name, version: Identifier; atype: IIDLType; amode: AttributeMode;
      getExceptions : ExceptionDefSeq = nil; setExceptions : ExceptionDefSeq = nil): IExtAttributeDef;
    function create_operation(id : RepositoryId; name, version: Identifier; oresult: IIDLType;
      omode: TOperationMode; const params: ParDescriptionSeq = nil; exceptions: ExceptionDefSeq = nil): IOperationDef;
    // IIDLType methods
    function _type(): ITypeCode;
    function recursive_type(): ITypeCode;
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
    procedure check_overloaded(id,oname: AnsiString);
    function describe_value(): FullValueDescription;
  public
    constructor Create(const con: IContainer;id : RepositoryId; name, version: Identifier;
      is_custom,is_abstract: Boolean; base_value: IValueDef; is_truncatable: Boolean; abstract_base_values,
      supported_interfaces: IInterfaceList; initializers: PInitializerSeq);
    class function _narrow(const obj: IORBObject): IValueDef;
  end;

  TValueMemberDef = class(TContained,IValueMemberDef)
  protected
    FType : IIDLType;
    FAccess : TVisibility;
  protected
    function _type: ITypeCode;
    function get_type_def: IIDLType;
    procedure set_type_def(const val: IIDLType);
    function get_access: TVisibility;
    procedure set_access(val: TVisibility);
    function narrow_helper(const repoid: RepositoryId): Pointer; override;
  public
    constructor Create(const con: IContainer;id,name,version: AnsiString; mtype: IIDLType; acc: TVisibility);
    class function _narrow(const obj: IORBObject): IValueMemberDef;
  end;


implementation

uses
  throw,any,tcode;


//*********************************************************************
//  TValueDef
//*********************************************************************
function TValueDef._type: ITypeCode;
{var
  modifier : TValueModifier;
  members : ValueMemberSeq;
  i,j: integer;
  mem: IValueMemberDef;
  base_type: ITypeCode;}
begin
  if FVisited then begin
    result := recursive_type();
    Exit;
  end;

  if FTypeCode = nil then
    FTypeCode := recursive_type();

  (*if FTypeCode = nil then
    begin
      modifier := VM_NONE;
      if FAbstract then
        modifier := VM_ABSTRACT;
      if FCustom then
        modifier := VM_CUSTOM;
      if FTruncatable then
        modifier := VM_TRUNCATABLE;
      j := 0;
      for i := 0 to Pred(FContained.Count) do
        begin
          mem := TValueMemberDef._narrow(FContained[i] as IORBObject);
          if mem = nil then continue;
          setlength(members,j+1);
          members[j].name := mem.name;
          members[j].id := mem.id;
          members[j].version := mem.version;
          members[j]._type := mem._type;
          inc(j);
        end;
      if FBaseValue <> nil then
        base_type := FBaseValue._type
      else
        base_type := nil;
      FTypeCode := FORB.create_value_tc(FID,FName,modifier,base_type,members);
    end;*)
  result := FTypeCode;
end;

function TValueDef.recursive_type: ITypeCode;
var
  modifier : TValueModifier;
  members : ValueMemberSeq;
  i,j: integer;
  mem: IValueMemberDef;
  base_type: ITypeCode;
begin
  if FVisited then begin
    result := FORB.create_recursive_tc(FID);
    Exit;
  end;

  FVisited := True;

  if FBaseValue <> nil then
    base_type := FBaseValue._type
  else
    base_type := nil;

  modifier := VM_NONE;
  if FAbstract then
    modifier := VM_ABSTRACT;
  if FCustom then
    modifier := VM_CUSTOM;
  if FTruncatable then
    modifier := VM_TRUNCATABLE;
  j := 0;
  for i := 0 to Pred(FContained.Count) do begin
    if (FContained[i] = nil) or ((FContained[i] as IIRObject).def_kind <> dk_ValueMember) then
      Continue;
    mem := TValueMemberDef._narrow(FContained[i] as IORBObject);
    if mem = nil then
      Continue;
    setlength(members,j+1);
    members[j].name := mem._name;
    members[j].id := mem._id;
    members[j].version := mem._version;
    members[j].access := mem.get_access();
    members[j]._type := mem.get_type_def().recursive_type();
    inc(j);
  end;

  FVisited := False;

  result := FORB.create_value_tc(FID,FName,modifier,base_type,members);
end;

function TValueDef.create_attribute(id : RepositoryId; name, version: Identifier; atype: IIDLType; amode: AttributeMode;
  getExceptions : ExceptionDefSeq = nil; setExceptions : ExceptionDefSeq = nil): IExtAttributeDef;
begin
  check_overloaded(id,name);
  result := TExtAttributeDef.Create(self,AnsiString(id),AnsiString(name),AnsiString(version),atype,amode,getExceptions,setExceptions);
  FContained.Add(result as IContained);
end;

function TValueDef.create_operation(id : RepositoryId; name, version: Identifier; oresult: IIDLType;
      omode: TOperationMode; const params: ParDescriptionSeq; exceptions: ExceptionDefSeq): IOperationDef;
begin
  check_overloaded(id,name);
  result := TOperationDef.Create(self,AnsiString(id),AnsiString(name),AnsiString(version),oresult,omode,params,exceptions);
  FContained.Add(result as IContained);
end;

function TValueDef.create_value_member(id : RepositoryId; name, version: Identifier;
  mtype: IIDLType; acc: TVisibility): IValueMemberDef;
begin
  result := TValueMemberDef.Create(self,AnsiString(id),AnsiString(name),AnsiString(version),mtype,acc);
  FContained.add(result as IContained)
end;

function TValueDef.get_abstract_base_values: IInterfaceList;
begin
  result := FAbstractBaseValues;
end;

function TValueDef.get_base_value: IValueDef;
begin
  result := FBaseValue;
end;

function TValueDef.initializers: InitializerSeq;
begin
  result := FInitializers;
end;

procedure TValueDef.resize_initializers(len: integer);
begin
  setLength(FInitializers,len);
end;

function TValueDef.get_supported_interfaces: IInterfaceList;
begin
  result := FSupportedInt
end;

function TValueDef.is_abstract: Boolean;
begin
  result := FAbstract;
end;

function TValueDef.is_custom: Boolean;
begin
  result := FCustom;
end;

function TValueDef.is_truncatable: Boolean;
begin
  result := FTruncatable
end;

function TValueDef.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  if repoid = 'IDL:omg.org/CORBA/ValueDef:1.0' then
    result := Pointer(IValueDef(self))
  else if repoid = 'IDL:omg.org/CORBA/Contained:1.0' then
    result := Pointer(IContained(self))
  else if repoid = 'IDL:omg.org/CORBA/IDLType:1.0' then
    result := Pointer(IIDLType(self))
  else
    result := inherited narrow_helper(repoid)
end;

procedure TValueDef.set_abstract_base_values(const val: IInterfaceList);
begin
  FAbstractBaseValues := val;
end;

procedure TValueDef.set_base_value(const val: IValueDef);
begin
  FBaseValue := val;
end;

procedure TValueDef.set_is_abstract(val: Boolean);
begin
  FAbstract := val
end;

procedure TValueDef.set_is_custom(val: Boolean);
begin
  FCustom := val;
end;

procedure TValueDef.set_is_truncatable(val: Boolean);
begin
  FTruncatable := val;
end;

procedure TValueDef.set_supported_interfaces(const val: IInterfaceList);
begin
  FSupportedInt := val
end;

constructor TValueDef.Create(const con: IContainer; id : RepositoryId; name, version: Identifier; is_custom, is_abstract: Boolean; base_value: IValueDef;
  is_truncatable: Boolean; abstract_base_values, supported_interfaces: IInterfaceList;
  initializers: PInitializerSeq);
begin
  inherited Create();
  FDefKind := dk_Value;
  FContainer := con;
  FName := name;
  FID := id;
  FVersion := version;
  FCustom := is_custom;
  FAbstract := is_abstract;
  FBaseValue := base_value;
  FTruncatable := is_truncatable;
  FAbstractBaseValues := abstract_base_values;
  FSupportedInt := supported_interfaces;
  if initializers <> nil then
    FInitializers := initializers^;
end;

class function TValueDef._narrow(const obj: IORBObject): IValueDef;
var
  ptr: Pointer;
begin
  result := nil;
  if obj <> nil then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/ValueDef:1.0');
      if ptr <> nil then
        result := IValueDef(ptr)
      else
        ;//assert(false,'not imlplemented');
    end;
end;

function TValueDef.describe_value: FullValueDescription;
var
  i,j : integer;
  list : IInterfaceList;
  cont: IContained;
begin
  with result do
    begin
      name := FName;
      id := FID;
      is_abstract := FAbstract;
      is_custom := FCustom;
      cont := TContained._narrow(FContainer as IORBObject);
      if cont <> nil then
        defined_in := cont._id
      else
        defined_in := '';
      Version := FVersion;
      list := (self as IContainer).contents(dk_Operation);
      setLength(operations,list.count);
      for i := 0 to Pred(list.count) do
        operations[i] := (list[i] as IOperationDef)._describe;
      j := 0;
      setLength(attributes,j);
      assert(false,'not implemented');
    end;
end;


procedure TValueDef.check_overloaded(id,oname: AnsiString);
var
  i : integer;
begin
  for i := 0 to Pred(FContained.count) do
    with IContained(FContained[i]) do
      if (def_kind in [dk_Operation,dk_Attribute]) and  (_name = oname) then
        dorb_throw('Overloading');
end;

//*********************************************************************
//  TValueMemberDef
//*********************************************************************
constructor TValueMemberDef.Create(const con: IContainer; id, name,
  version: AnsiString; mtype: IIDLType; acc: TVisibility);
begin
  inherited Create();
  FDefKind := dk_ValueMember;
  FContainer := con;
  FID := id;
  FName := name;
  FType := mtype;
  FVersion := version;
  FAccess := acc;
end;

function TValueMemberDef._type: ITypeCode;
begin
  result := FType._type
end;

function TValueMemberDef.get_access: TVisibility;
begin
  result := FAccess
end;

function TValueMemberDef.get_type_def: IIDLType;
begin
  result := FType;
end;

procedure TValueMemberDef.set_access(val: TVisibility);
begin
 FAccess := val;
end;

procedure TValueMemberDef.set_type_def(const val: IIDLType);
begin
  FType := val;
end;

function TValueMemberDef.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  if repoid = 'IDL:omg.org/CORBA/ValueMemberDef:1.0' then
    result := Pointer(IValueMemberDef(self))
  else
    result := inherited narrow_helper(repoid);
end;

class function TValueMemberDef._narrow(const obj: IORBObject): IValueMemberDef;
var
  ptr: Pointer;
begin
  result := nil;
  if obj <> nil then
    begin
      ptr := obj.narrow_helper('IDL:omg.org/CORBA/ValueMemberDef:1.0');
      if ptr <> nil then
        result := IValueMemberDef(ptr)
      else
        //'not imlplemented'
    end;
end;

//*********************************************************************
// TValueBoxDef
//*********************************************************************
constructor TValueBoxDef.Create(const con: IContainer; id, name,
  version: AnsiString; original: IIDLType);
begin
  inherited Create();
  FContainer := con;
  FDefKind := dk_ValueBox;
  FID := id;
  FName := name;
  FVersion := version;
  FOriginalType := original;
end;

procedure TValueBoxDef.original_type_def(const val: IIDLType);
begin
  FOriginalType := val;
end;

function TValueBoxDef.original_type_def: IIDLType;
begin
  result := FOriginalType;
end;

function TValueBoxDef._type: ITypeCode;
begin
  if FType = nil then
    FType := FORB.create_value_box_tc(FID,FName,FOriginalType._type);
  result := FType
end;

function TValueBoxDef.recursive_type: ITypeCode;
begin
  result := _type();
end;

function TValueBoxDef.narrow_helper(const repoid: RepositoryId): Pointer;
begin
  if repoid = 'IDL:omg.org/CORBA/ValueBoxDef:1.0' then
    result := Pointer(self as IValueBoxDef)
  else if repoid = 'IDL:omg.org/CORBA/TypedefDef:1.0' then
    result := Pointer(self as ITypedefDef)
  else if repoid = 'IDL:omg.org/CORBA/IDLType:1.0' then
    result := Pointer(IIDLType(self))
  else
    result := inherited narrow_helper(repoid)
end;

procedure TValueBoxDef._id(const val: AnsiString);
begin
  inherited;
  if FType <> nil then
    FType.id(val);
end;

end.

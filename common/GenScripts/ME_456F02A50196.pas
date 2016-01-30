unit BaseTreeSupportUnit;
 {* ��������� ������� ������. }

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\BaseTreeSupportUnit.pas"
// ���������: "Interfaces"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , BaseTypesUnit
 , IOUnit
 , ContextSearchSupportUnit
;

type
 TEntityType = Cardinal;
  {* ������������� ���� �������� ������� � ����. � ������ ���������� ������ ������������ ��� AdapterEnum }

 CopyDisabled = class
  {* ������������ ���� ���� �� ����� ���� �����������. }
 end;//CopyDisabled

 InvalidContainer = class
  {* ���������� ��� ������� ������������ ���� �� ���������� ���������� ��� ���������. }
 end;//InvalidContainer

 MoveDisabled = class
  {* ������������ ���� ���� �� ����� ���� ����������. }
 end;//MoveDisabled

 InvalidEntityType = class
  {* ������������ ��� ������� ��������� ����� �������� �������� ������� ����. }
 end;//InvalidEntityType

 InvalidIndex = class
  {* ������������ ��� ������� �������� ������� ������ �� ��������������� �������. �.�. index<0 ��� index>=count. }
 end;//InvalidIndex

 NotEntityElement = class
  {* ������������ ��� ������� ������� �������� open � �������� ��������, �� ����������� ��������� (� ��������� � �����). }
 end;//NotEntityElement

 INode = interface(IEntityStorage)
  {* ��������� ��� ������ ������ �� �������� ����������� ���������. }
  ['{A050343E-CA33-4D63-8385-2FFBD9B012DA}']
  function Get_level: Integer;
  function Get_child_count: Integer;
  function Get_all_child_count: Integer;
  function Get_flags: Integer;
  function Get_index: Integer;
  function Get_through_index: Integer;
  function Get_parent: INode;
  function Get_previous_node: INode;
  function Get_next_node: INode;
  function Get_caption: IString;
  procedure Set_caption(const aValue: IString); { can raise ConstantModify, AccessDenied }
  function Get_hint: IString;
  procedure Set_hint(const aValue: IString); { can raise ConstantModify, AccessDenied }
  function Get_object_type: TEntityType; { can raise Unsupported }
  function get_child(index: Integer): INode; { can raise InvalidIndex }
   {* �������� ��������� �� ���� �� ��������� ���������.
�������� ������ ��������� �������� �� ���������: 0<=index<=(child_coun-1) }
  function is_same_node(const node: INode): Boolean;
   {* ���������� ������� ������� � ���������, �������� � ��������� node.
���������� true � ������ ����������. }
  function open: IUnknown; { can raise CanNotFindData, NotEntityElement }
   {* ���������� ��������� ��� ������ � ���������� ��������� (���������) �������. }
  procedure delete_node; { can raise ConstantModify, AccessDenied, EmptyResult }
   {* ������� ��������� ���� �� ������/������.
���� ������ �������, ������� ��������� ��������, �� ��� ���� ���������. ���� ������/������ �������� ��� ����������� (������������) �� ��������� ���������� ConstantModify }
  function add_child_node(const entity: IUnknown): INode; { can raise ConstantModify, AccessDenied, Unsupported, DuplicateNode, InvalidEntityType }
   {* ��������� �������� ��� ������� � ��������� ����, ���������� ����� ��������� ����. ���� ������/������ �������� ��� ����������� (������������) �� ��������� ���������� ConstantModify. ���� ���� �� ����� ��������� ����� ������������ ���������� InvalidContainer }
  function add_sibling_node(const entity: IUnknown): INode; { can raise ConstantModify, Unsupported, DuplicateNode }
   {* ��������� �������� ��� "������" ������ � ��������� ����, ���������� ����� ��������� ����. ���� ������/������ �������� ��� ����������� (������������) �� ��������� ���������� ConstantModify }
  procedure move_to_location(var destination: INode); { can raise InvalidContainer, MoveDisabled }
   {* ��������� ������� ���� � ��������� ����, ����� �� ��� ��������. ���� ���� �� ����� �������� ���� (�.�. �������� �� � ����), �� ������������ ���������� InvalidContainer. ���� �������� ����������� ����� �� ��������, ������������ ���������� MoveDisabled }
  procedure copy_to_location(var destination: INode); { can raise CopyDisabled, InvalidContainer }
   {* �������� ������� ���� � ���������� ��� �� ����������, � ��������� ����, ����� �� ��� ��������. ���� ���� �� ����� �������� ���� (�.�. �������� �� � ����), �� ������������ ���������� InvalidContainer. ���� �������� ����������� ����� �� ��������, ������������ ���������� CopyDisabled }
  function can_move: Boolean;
   {* ����� �� ����������� ���� }
  function can_copy: Boolean;
   {* ����� �� ����������� ���� }
  function can_insert(var source: INode): Boolean;
   {* ����� �� �������� ���� }
  function is_last: Boolean;
   {* ���������� �������. }
  function is_first: Boolean;
   {* ������ �������. }
  function has_child: Boolean;
   {* ���� �� �������� ��������. }
  function override_child_node(const entity: IUnknown): INode; { can raise ConstantModify, AccessDenied, Unsupported, DuplicateNode, InvalidEntityType }
   {* ������������ �������� ���� }
  function can_modify: Boolean;
   {* ����� �� �������������� ���� }
  property level: Integer
   read Get_level;
   {* ������� ����������� �������� � ����������� ���������.
� root_node=0. }
  property child_count: Integer
   read Get_child_count;
   {* ���������� ��������� ��������� ��� �������� (���� �������).
� ��������� ��������� =0. }
  property all_child_count: Integer
   read Get_all_child_count;
   {* ���������� ��������� ��������� ��� �������� � ������ ���� ������� �����������.
� ��������� ��������� =0. }
  property flags: Integer
   read Get_flags;
   {* ���� ��� �������� �������������� �������� ���������� � ������� ��������. }
  property index: Integer
   read Get_index;
   {* ������� �������� �������� � ������ (parent). }
  property through_index: Integer
   read Get_through_index;
   {* �������� ������� ��������. }
  property parent: INode
   read Get_parent;
   {* �������� }
  property previous_node: INode
   read Get_previous_node;
   {* ���������� ���� � ������ }
  property next_node: INode
   read Get_next_node;
   {* ��������� ���� � ������ }
  property caption: IString
   read Get_caption
   write Set_caption;
   {* �������� }
  property hint: IString
   read Get_hint
   write Set_hint;
   {* ���������� � ���� }
  property object_type: TEntityType
   read Get_object_type;
   {* ��� ��������, �������������� ����� }
 end;//INode

 IBaseCatalog = interface
  {* ������� ��������� ��� ������ � ������������ �/��� ��������� �������� ��������� ��������� �������. ��������� �� ��������� (������ ��� �������� ������) �������������� ����� ���������� ���������� Node. ��� ���� ������ ��������� Node ����� ���� �������� � ���������� ����������� �������� ����� ����� open ���������� BaseCatalog. ��� ���� ��� �� �������� ����� ���� �������� ����� �������, �� ��������� ������ ������������� ��������� BaseEntity.
� ������ ���� ���������� ������ �� ������������ ��� ��� ���� �������� ������������ �� BaseCatalog, �� ��� �� ������ ������ �������������� ���������� }
  ['{B41C62C4-F733-4465-9B22-3D4C52162F8A}']
  function Get_root: INode;
  function Get_filter: TEntityType;
  procedure Set_filter(aValue: TEntityType);
  function find(const entity: IUnknown {* ������� �������. }): INode;
   {* ����� ���� �� ��� ��������. }
  function find_context(mask: PAnsiChar;
   const mode: TSearchMode;
   const cur_item: INode;
   out result: TContextSearchResult {* ��������� ������. ��� ���� ������������ �������� ������. }): INode;
   {* ����� ��������� ����� ��������� ������. }
  procedure reset_type_filter;
   {* ���������� ��� ������������� ������� �� ����� }
  property root: INode
   read Get_root;
   {* ������ ������ }
  property filter: TEntityType
   read Get_filter
   write Set_filter;
   {* ���������� ������ }
 end;//IBaseCatalog

 TBaseTreeNodeMask = Cardinal;
  {* ����� �� ������ ���� }

class function make: BadFactoryType;
 {* ������� }

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType;
 {* ������� }
var
 l_Inst : INode;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.

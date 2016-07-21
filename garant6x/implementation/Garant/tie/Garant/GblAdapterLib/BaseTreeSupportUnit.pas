unit BaseTreeSupportUnit;
 {* ��������� ������� ������. }

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\BaseTreeSupportUnit.pas"
// ���������: "Interfaces"
// ������� ������: "BaseTreeSupport" MUID: (456F02A50196)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
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
  function GetLevel: Integer; stdcall;
  function GetChildCount: Integer; stdcall;
  function GetAllChildCount: Integer; stdcall;
  function GetFlags: Integer; stdcall;
  function GetIndex: Integer; stdcall;
  function GetThroughIndex: Integer; stdcall;
  procedure GetParent; stdcall;
  procedure GetPreviousNode; stdcall;
  procedure GetNextNode; stdcall;
  procedure GetCaption; stdcall;
  procedure SetCaption(const aValue); stdcall; { can raise ConstantModify, AccessDenied }
  procedure GetHint; stdcall;
  procedure SetHint(const aValue); stdcall; { can raise ConstantModify, AccessDenied }
  function GetObjectType: TEntityType; stdcall; { can raise Unsupported }
  procedure GetChild(index: Integer;
   out aRet
   {* INode }); stdcall; { can raise InvalidIndex }
   {* �������� ��������� �� ���� �� ��������� ���������.
�������� ������ ��������� �������� �� ���������: 0<=index<=(child_coun-1) }
  function IsSameNode(const node: INode): ByteBool; stdcall;
   {* ���������� ������� ������� � ���������, �������� � ��������� node.
���������� true � ������ ����������. }
  procedure Open(out aRet
   {* IUnknown }); stdcall; { can raise CanNotFindData, NotEntityElement }
   {* ���������� ��������� ��� ������ � ���������� ��������� (���������) �������. }
  procedure DeleteNode; stdcall; { can raise ConstantModify, AccessDenied, EmptyResult }
   {* ������� ��������� ���� �� ������/������.
���� ������ �������, ������� ��������� ��������, �� ��� ���� ���������. ���� ������/������ �������� ��� ����������� (������������) �� ��������� ���������� ConstantModify }
  procedure AddChildNode(const entity: IUnknown;
   out aRet
   {* INode }); stdcall; { can raise ConstantModify, AccessDenied, Unsupported, DuplicateNode, InvalidEntityType }
   {* ��������� �������� ��� ������� � ��������� ����, ���������� ����� ��������� ����. ���� ������/������ �������� ��� ����������� (������������) �� ��������� ���������� ConstantModify. ���� ���� �� ����� ��������� ����� ������������ ���������� InvalidContainer }
  procedure AddSiblingNode(const entity: IUnknown;
   out aRet
   {* INode }); stdcall; { can raise ConstantModify, Unsupported, DuplicateNode }
   {* ��������� �������� ��� "������" ������ � ��������� ����, ���������� ����� ��������� ����. ���� ������/������ �������� ��� ����������� (������������) �� ��������� ���������� ConstantModify }
  procedure MoveToLocation(var destination: INode); stdcall; { can raise InvalidContainer, MoveDisabled }
   {* ��������� ������� ���� � ��������� ����, ����� �� ��� ��������. ���� ���� �� ����� �������� ���� (�.�. �������� �� � ����), �� ������������ ���������� InvalidContainer. ���� �������� ����������� ����� �� ��������, ������������ ���������� MoveDisabled }
  procedure CopyToLocation(var destination: INode); stdcall; { can raise CopyDisabled, InvalidContainer }
   {* �������� ������� ���� � ���������� ��� �� ����������, � ��������� ����, ����� �� ��� ��������. ���� ���� �� ����� �������� ���� (�.�. �������� �� � ����), �� ������������ ���������� InvalidContainer. ���� �������� ����������� ����� �� ��������, ������������ ���������� CopyDisabled }
  function CanMove: ByteBool; stdcall;
   {* ����� �� ����������� ���� }
  function CanCopy: ByteBool; stdcall;
   {* ����� �� ����������� ���� }
  function CanInsert(var source: INode): ByteBool; stdcall;
   {* ����� �� �������� ���� }
  function IsLast: ByteBool; stdcall;
   {* ���������� �������. }
  function IsFirst: ByteBool; stdcall;
   {* ������ �������. }
  function HasChild: ByteBool; stdcall;
   {* ���� �� �������� ��������. }
  procedure OverrideChildNode(const entity: IUnknown;
   out aRet
   {* INode }); stdcall; { can raise ConstantModify, AccessDenied, Unsupported, DuplicateNode, InvalidEntityType }
   {* ������������ �������� ���� }
  function CanModify: ByteBool; stdcall;
   {* ����� �� �������������� ���� }
  property Level: Integer
   read GetLevel;
   {* ������� ����������� �������� � ����������� ���������.
� root_node=0. }
  property ChildCount: Integer
   read GetChildCount;
   {* ���������� ��������� ��������� ��� �������� (���� �������).
� ��������� ��������� =0. }
  property AllChildCount: Integer
   read GetAllChildCount;
   {* ���������� ��������� ��������� ��� �������� � ������ ���� ������� �����������.
� ��������� ��������� =0. }
  property Flags: Integer
   read GetFlags;
   {* ���� ��� �������� �������������� �������� ���������� � ������� ��������. }
  property Index: Integer
   read GetIndex;
   {* ������� �������� �������� � ������ (parent). }
  property ThroughIndex: Integer
   read GetThroughIndex;
   {* �������� ������� ��������. }
  property Parent: 
   read GetParent;
   {* �������� }
  property PreviousNode: 
   read GetPreviousNode;
   {* ���������� ���� � ������ }
  property NextNode: 
   read GetNextNode;
   {* ��������� ���� � ������ }
  property Caption: 
   read GetCaption
   write SetCaption;
   {* �������� }
  property Hint: 
   read GetHint
   write SetHint;
   {* ���������� � ���� }
  property ObjectType: TEntityType
   read GetObjectType;
   {* ��� ��������, �������������� ����� }
 end;//INode

 IBaseCatalog = interface
  {* ������� ��������� ��� ������ � ������������ �/��� ��������� �������� ��������� ��������� �������. ��������� �� ��������� (������ ��� �������� ������) �������������� ����� ���������� ���������� Node. ��� ���� ������ ��������� Node ����� ���� �������� � ���������� ����������� �������� ����� ����� open ���������� BaseCatalog. ��� ���� ��� �� �������� ����� ���� �������� ����� �������, �� ��������� ������ ������������� ��������� BaseEntity.
� ������ ���� ���������� ������ �� ������������ ��� ��� ���� �������� ������������ �� BaseCatalog, �� ��� �� ������ ������ �������������� ���������� }
  ['{B41C62C4-F733-4465-9B22-3D4C52162F8A}']
  procedure GetRoot; stdcall;
  function GetFilter: TEntityType; stdcall;
  procedure SetFilter(aValue: TEntityType); stdcall;
  procedure Find(const entity: IUnknown
   {* ������� �������. };
   out aRet
   {* INode }); stdcall;
   {* ����� ���� �� ��� ��������. }
  procedure FindContext(mask: PAnsiChar;
   const mode: TSearchMode;
   const cur_item: INode;
   out result: TContextSearchResult
   {* ��������� ������. ��� ���� ������������ �������� ������. };
   out aRet
   {* INode }); stdcall;
   {* ����� ��������� ����� ��������� ������. }
  procedure ResetTypeFilter; stdcall;
   {* ���������� ��� ������������� ������� �� ����� }
  property Root: 
   read GetRoot;
   {* ������ ������ }
  property Filter: TEntityType
   read GetFilter
   write SetFilter;
   {* ���������� ������ }
 end;//IBaseCatalog

 TBaseTreeNodeMask = Cardinal;
  {* ����� �� ������ ���� }

implementation

uses
 l3ImplUses
;

end.

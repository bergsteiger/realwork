unit BaseTreeSupportUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/BaseTreeSupportUnit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::BaseTreeSupport
//
// ��������� ������� ������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  IOUnit,
  BaseTypesUnit,
  ContextSearchSupportUnit
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
   function GetParent: INode; stdcall;
   function GetPreviousNode: INode; stdcall;
   function GetNextNode: INode; stdcall;
   function GetCaption: IString; stdcall;
   procedure SetCaption(const aValue: IString); stdcall;
   function GetHint: IString; stdcall;
   procedure SetHint(const aValue: IString); stdcall;
   function GetObjectType: TEntityType; stdcall;
   procedure GetChild(aIndex: Integer; out aRet {: INode}); stdcall; // can raise InvalidIndex
     {* �������� ��������� �� ���� �� ��������� ���������.
�������� ������ ��������� �������� �� ���������: 0<=index<=(child_coun-1) }
   function IsSameNode(const aNode: INode): ByteBool; stdcall;
     {* ���������� ������� ������� � ���������, �������� � ��������� node.
���������� true � ������ ����������. }
   procedure Open(out aRet {: IUnknown}); stdcall; // can raise CanNotFindData, NotEntityElement
     {* ���������� ��������� ��� ������ � ���������� ��������� (���������) �������. }
   procedure DeleteNode; stdcall; // can raise ConstantModify, AccessDenied, EmptyResult
     {* ������� ��������� ���� �� ������/������.
���� ������ �������, ������� ��������� ��������, �� ��� ���� ���������. ���� ������/������ �������� ��� ����������� (������������) �� ��������� ���������� ConstantModify }
   procedure AddChildNode(const aEntity: IUnknown; out aRet {: INode}); stdcall; // can raise ConstantModify, AccessDenied, Unsupported, DuplicateNode, InvalidEntityType
     {* ��������� �������� ��� ������� � ��������� ����, ���������� ����� ��������� ����. ���� ������/������ �������� ��� ����������� (������������) �� ��������� ���������� ConstantModify. ���� ���� �� ����� ��������� ����� ������������ ���������� InvalidContainer }
   procedure AddSiblingNode(const aEntity: IUnknown; out aRet {: INode}); stdcall; // can raise ConstantModify, Unsupported, DuplicateNode
     {* ��������� �������� ��� "������" ������ � ��������� ����, ���������� ����� ��������� ����. ���� ������/������ �������� ��� ����������� (������������) �� ��������� ���������� ConstantModify }
   procedure MoveToLocation(var aDestination: INode); stdcall; // can raise InvalidContainer, MoveDisabled
     {* ��������� ������� ���� � ��������� ����, ����� �� ��� ��������. ���� ���� �� ����� �������� ���� (�.�. �������� �� � ����), �� ������������ ���������� InvalidContainer. ���� �������� ����������� ����� �� ��������, ������������ ���������� MoveDisabled }
   procedure CopyToLocation(var aDestination: INode); stdcall; // can raise CopyDisabled, InvalidContainer
     {* �������� ������� ���� � ���������� ��� �� ����������, � ��������� ����, ����� �� ��� ��������. ���� ���� �� ����� �������� ���� (�.�. �������� �� � ����), �� ������������ ���������� InvalidContainer. ���� �������� ����������� ����� �� ��������, ������������ ���������� CopyDisabled }
   function CanMove: ByteBool; stdcall;
     {* ����� �� ����������� ���� }
   function CanCopy: ByteBool; stdcall;
     {* ����� �� ����������� ���� }
   function CanInsert(var aSource: INode): ByteBool; stdcall;
     {* ����� �� �������� ���� }
   function IsLast: ByteBool; stdcall;
     {* ���������� �������. }
   function IsFirst: ByteBool; stdcall;
     {* ������ �������. }
   function HasChild: ByteBool; stdcall;
     {* ���� �� �������� ��������. }
   procedure OverrideChildNode(const aEntity: IUnknown; out aRet {: INode}); stdcall; // can raise ConstantModify, AccessDenied, Unsupported, DuplicateNode, InvalidEntityType
     {* ������������ �������� ���� }
   function CanModify: ByteBool; stdcall;
     {* ����� �� �������������� ���� }
   property level: Integer
     read GetLevel;
     {* ������� ����������� �������� � ����������� ���������.
� root_node=0. }
   property child_count: Integer
     read GetChildCount;
     {* ���������� ��������� ��������� ��� �������� (���� �������).
� ��������� ��������� =0. }
   property all_child_count: Integer
     read GetAllChildCount;
     {* ���������� ��������� ��������� ��� �������� � ������ ���� ������� �����������.
� ��������� ��������� =0. }
   property flags: Integer
     read GetFlags;
     {* ���� ��� �������� �������������� �������� ���������� � ������� ��������. }
   property index: Integer
     read GetIndex;
     {* ������� �������� �������� � ������ (parent). }
   property through_index: Integer
     read GetThroughIndex;
     {* �������� ������� ��������. }
   property parent: INode
     read GetParent;
     {* �������� }
   property previous_node: INode
     read GetPreviousNode;
     {* ���������� ���� � ������ }
   property next_node: INode
     read GetNextNode;
     {* ��������� ���� � ������ }
   property caption: IString
     read GetCaption
     write SetCaption;
     {* �������� }
   property hint: IString
     read GetHint
     write SetHint;
     {* ���������� � ���� }
   property object_type: TEntityType
     read GetObjectType;
     {* ��� ��������, �������������� ����� }
 end;//INode

 IBaseCatalog = interface(IUnknown)
  {* ������� ��������� ��� ������ � ������������ �/��� ��������� �������� ��������� ��������� �������. ��������� �� ��������� (������ ��� �������� ������) �������������� ����� ���������� ���������� Node. ��� ���� ������ ��������� Node ����� ���� �������� � ���������� ����������� �������� ����� ����� open ���������� BaseCatalog. ��� ���� ��� �� �������� ����� ���� �������� ����� �������, �� ��������� ������ ������������� ��������� BaseEntity.
� ������ ���� ���������� ������ �� ������������ ��� ��� ���� �������� ������������ �� BaseCatalog, �� ��� �� ������ ������ �������������� ���������� }
   ['{B41C62C4-F733-4465-9B22-3D4C52162F8A}']
   function GetRoot: INode; stdcall;
   function GetFilter: TEntityType; stdcall;
   procedure SetFilter(aValue: TEntityType); stdcall;
   procedure Find(const aEntity: IUnknown
    {* ������� �������.}; out aRet {: INode}); stdcall;
     {* ����� ���� �� ��� ��������. }
   procedure FindContext(aMask: PAnsiChar;
    const aMode: TSearchMode;
    const aCurItem: INode;
    out aResult: TContextSearchResult
    {* ��������� ������. ��� ���� ������������ �������� ������.}; out aRet {: INode}); stdcall;
     {* ����� ��������� ����� ��������� ������. }
   procedure ResetTypeFilter; stdcall;
     {* ���������� ��� ������������� ������� �� ����� }
   property root: INode
     read GetRoot;
     {* ������ ������ }
   property filter: TEntityType
     read GetFilter
     write SetFilter;
     {* ���������� ������ }
 end;//IBaseCatalog

 TBaseTreeNodeMask = Cardinal;
  {* ����� �� ������ ���� }

implementation

end.
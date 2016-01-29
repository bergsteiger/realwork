unit BaseTreeSupportUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupportUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::BaseTreeSupport
//
// ��������� ������� ������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysUtils
	, IOUnit
	, BaseTypesUnit
	, ContextSearchSupportUnit
	//#UC START# *4423F94903C8_456F02A50196_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_456F02A50196_UNIT_FOR_Stream*
	;

type

INode = interface;
{ - ��������������� �������� INode. }

IBaseCatalog = interface;
{ - ��������������� �������� IBaseCatalog. }


// ������������� ���� �������� ������� � ����. � ������ ���������� ������ ������������ ���
// AdapterEnum
PEntityType = ^TEntityType;
TEntityType = Longword;

// ������������ ���� ���� �� ����� ���� �����������.
ECopyDisabled = class (Exception);

// ���������� ��� ������� ������������ ���� �� ���������� ���������� ��� ���������.
EInvalidContainer = class (Exception);

// ������������ ���� ���� �� ����� ���� ����������.
EMoveDisabled = class (Exception);

// ������������ ��� ������� ��������� ����� �������� �������� ������� ����.
EInvalidEntityType = class (Exception);

// ������������ ��� ������� �������� ������� ������ �� ��������������� �������. �.�. index<0 ���
// index>=count.
EInvalidIndex = class (Exception);

// ������������ ��� ������� ������� �������� open � �������� ��������, �� ����������� ��������� (�
// ��������� � �����).
ENotEntityElement = class (Exception);

// ����� �� ������ ����
PBaseTreeNodeMask = ^TBaseTreeNodeMask;
TBaseTreeNodeMask = Longword;

// ��������� ��� ������ ������ �� �������� ����������� ���������.
INode = interface (IEntityStorage) ['{A050343E-CA33-4D63-8385-2FFBD9B012DA}']
	// ��������� �������� ��� ������� � ��������� ����, ���������� ����� ��������� ����. ����
	// ������/������ �������� ��� ����������� (������������) �� ��������� ���������� ConstantModify.
	// ���� ���� �� ����� ��������� ����� ������������ ���������� InvalidContainer
	procedure AddChildNode (
		const aEntity: IUnknown;
		out aRet {: INode}
	); stdcall; // can raise EConstantModify, EAccessDenied, EUnsupported, EDuplicateNode, EInvalidEntityType

	// ��������� �������� ��� "������" ������ � ��������� ����, ���������� ����� ��������� ����. ����
	// ������/������ �������� ��� ����������� (������������) �� ��������� ���������� ConstantModify
	procedure AddSiblingNode (
		const aEntity: IUnknown;
		out aRet {: INode}
	); stdcall; // can raise EConstantModify, EUnsupported, EDuplicateNode

	// ���������� ��������� ��������� ��� �������� � ������ ���� ������� �����������.
	// � ��������� ��������� =0.
	function GetAllChildCount (): Longint; stdcall;

	// ����� �� ����������� ����
	function CanCopy (): Bytebool; stdcall;

	// ����� �� �������� ����
	function CanInsert (
		const aSource: INode
	): Bytebool; stdcall;

	// ����� �� �������������� ����
	function CanModify (): Bytebool; stdcall;

	// ����� �� ����������� ����
	function CanMove (): Bytebool; stdcall;

	// ��������
	procedure GetCaption (out aRet {: IString}); stdcall;
	procedure SetCaption (const aCaption: IString); stdcall;

	// ���������� ��������� ��������� ��� �������� (���� �������).
	// � ��������� ��������� =0.
	function GetChildCount (): Longint; stdcall;

	// �������� ������� ���� � ���������� ��� �� ����������, � ��������� ����, ����� �� ��� ��������.
	// ���� ���� �� ����� �������� ���� (�.�. �������� �� � ����), �� ������������ ����������
	// InvalidContainer. ���� �������� ����������� ����� �� ��������, ������������ ����������
	// CopyDisabled
	procedure CopyToLocation (
		const aDestination: INode
	); stdcall; // can raise ECopyDisabled, EInvalidContainer

	// ������� ��������� ���� �� ������/������.
	// ���� ������ �������, ������� ��������� ��������, �� ��� ���� ���������. ���� ������/������
	// �������� ��� ����������� (������������) �� ��������� ���������� ConstantModify
	procedure DeleteNode (); stdcall; // can raise EConstantModify, EAccessDenied, EEmptyResult

	// ���� ��� �������� �������������� �������� ���������� � ������� ��������.
	function GetFlags (): Longint; stdcall;

	// �������� ��������� �� ���� �� ��������� ���������.
	// �������� ������ ��������� �������� �� ���������: 0<=index<=(child_coun-1)
	procedure GetChild (
		aIndex: Longint;
		out aRet {: INode}
	); stdcall; // can raise EInvalidIndex

	// ���� �� �������� ��������.
	function HasChild (): Bytebool; stdcall;

	// ���������� � ����
	procedure GetHint (out aRet {: IString}); stdcall;
	procedure SetHint (const aHint: IString); stdcall;

	// ������� �������� �������� � ������ (parent).
	function GetIndex (): Longint; stdcall;

	// ������ �������.
	function IsFirst (): Bytebool; stdcall;

	// ���������� �������.
	function IsLast (): Bytebool; stdcall;

	// ���������� ������� ������� � ���������, �������� � ��������� node.
	// ���������� true � ������ ����������.
	function IsSameNode (
		const aNode: INode
	): Bytebool; stdcall;

	// ������� ����������� �������� � ����������� ���������.
	// � root_node=0.
	function GetLevel (): Longint; stdcall;

	// ��������� ������� ���� � ��������� ����, ����� �� ��� ��������. ���� ���� �� ����� ��������
	// ���� (�.�. �������� �� � ����), �� ������������ ���������� InvalidContainer. ���� ��������
	// ����������� ����� �� ��������, ������������ ���������� MoveDisabled
	procedure MoveToLocation (
		const aDestination: INode
	); stdcall; // can raise EInvalidContainer, EMoveDisabled

	// ��������� ���� � ������
	procedure GetNextNode (out aRet {: INode}); stdcall;

	// ��� ��������, �������������� �����
	function GetObjectType (): TEntityType; stdcall;

	// ���������� ��������� ��� ������ � ���������� ��������� (���������) �������.
	procedure Open (
		out aRet {: IUnknown}
	); stdcall; // can raise ECanNotFindData, ENotEntityElement

	// ������������ �������� ����
	procedure OverrideChildNode (
		const aEntity: IUnknown;
		out aRet {: INode}
	); stdcall; // can raise EConstantModify, EAccessDenied, EUnsupported, EDuplicateNode, EInvalidEntityType

	// ��������
	procedure GetParent (out aRet {: INode}); stdcall;

	// ���������� ���� � ������
	procedure GetPreviousNode (out aRet {: INode}); stdcall;

	// �������� ������� ��������.
	function GetThroughIndex (): Longint; stdcall;
end;

// ������� ��������� ��� ������ � ������������ �/��� ��������� �������� ��������� ���������
// �������. ��������� �� ��������� (������ ��� �������� ������) �������������� ����� ����������
// ���������� Node. ��� ���� ������ ��������� Node ����� ���� �������� � ���������� �����������
// �������� ����� ����� open ���������� BaseCatalog. ��� ���� ��� �� �������� ����� ���� ��������
// ����� �������, �� ��������� ������ ������������� ��������� BaseEntity.
// � ������ ���� ���������� ������ �� ������������ ��� ��� ���� �������� ������������ ��
// BaseCatalog, �� ��� �� ������ ������ �������������� ����������
IBaseCatalog = interface (IInterface) ['{B41C62C4-F733-4465-9B22-3D4C52162F8A}']
	function DontUseMe: Pointer;
	// ���������� ������
	function GetFilter (): TEntityType; stdcall;
	procedure SetFilter (aFilter: TEntityType); stdcall;

	// ����� ���� �� ��� ��������.
	procedure Find (
		const aEntity: IUnknown;
		out aRet {: INode}
	); stdcall;

	// ����� ��������� ����� ��������� ������.
	procedure FindContext (
		const aMask: PAnsiChar;
		const aMode: TSearchMode;
		const aCurItem: INode;
		out aResult: TContextSearchResult;
		out aRet {: INode}
	); stdcall;

	// ���������� ��� ������������� ������� �� �����
	procedure ResetTypeFilter (); stdcall;

	// ������ ������
	procedure GetRoot (out aRet {: INode}); stdcall;
end;

implementation
end.
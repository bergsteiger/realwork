unit DocTreeUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/DocTreeUnit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DocTree
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
  DynamicTreeUnit,
  ExternalObjectUnit
  ;

type
 TTagHandle = Cardinal;
  {* EVD-��� ���� }

 IDocNodeFilter = interface(IFilterForTree)
  {* ������ ��� ������ ���� ��������� }
   ['{8BEEB7B1-6BD1-4BAF-8071-9A7FD1FF2E59}']
   function GetId: TTagHandle; stdcall;
   procedure SetId(aValue: TTagHandle); stdcall;
   function GetInheritable: ByteBool; stdcall;
   procedure SetInheritable(aValue: Boolean); stdcall;
   function GetType: TNodeType; stdcall;
   procedure SetType(aValue: TNodeType); stdcall;
   property id: TTagHandle
     read GetId
     write SetId;
   property inheritable: ByteBool
     read GetInheritable
     write SetInheritable;
   property type: TNodeType
     read GetType
     write SetType;
 end;//IDocNodeFilter

 IContentsNode = interface(INodeBase)
   ['{1D59A8F6-CE4D-4737-B812-85904356F82B}']
 end;//IContentsNode

implementation

end.
unit evContentsNodeFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// ������: "w:/common/components/gui/Garant/Everest/evContentsNodeFactory.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ContentsTree::TevContentsNodeFactory
//
// ������� ��� �������� ���.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3TreeInterfaces,
  l3Tree_TLB,
  evInternalInterfaces,
  l3Variant
  ;

type
 TevContentsNodeFactory = class
  {* ������� ��� �������� ���. }
 public
 // public methods
   class function CreateContentsNode(aTag: Tl3Variant;
     aSub: Tl3Variant;
     const aFilter: InevContentsNodeFilter): Il3Node;
     {* ������� ���� ���� ��� ���������, �����, ����. }
   class function CreateRoot: Il3SimpleRootNode;
     {* ������� ������� ����. }
 end;//TevContentsNodeFactory

implementation

uses
  evDocumentNode,
  evContentsTagNode,
  evContentsSubNode,
  Document_Const,
  evRootContentsNode,
  l3Nodes
  ;

// start class TevContentsNodeFactory

class function TevContentsNodeFactory.CreateContentsNode(aTag: Tl3Variant;
  aSub: Tl3Variant;
  const aFilter: InevContentsNodeFilter): Il3Node;
//#UC START# *4E26CFD1000A_4E26CCF0021F_var*
//#UC END# *4E26CFD1000A_4E26CCF0021F_var*
begin
//#UC START# *4E26CFD1000A_4E26CCF0021F_impl*
 if (aTag = nil) then
  Result := l3Nodes.MakeNode('<������� ������ ����>')
 else
 if aTag.IsKindOf(k2_typDocument) then
  Result := TevDocumentNode.Make(aTag, aFilter)
 else
 if aSub = nil then
  Result := TevContentsTagNode.Make(aTag, aFilter)
 else
  Result := TevContentsSubNode.Make(aTag, aSub, aFilter);
//#UC END# *4E26CFD1000A_4E26CCF0021F_impl*
end;//TevContentsNodeFactory.CreateContentsNode

class function TevContentsNodeFactory.CreateRoot: Il3SimpleRootNode;
//#UC START# *4E26D05D00FA_4E26CCF0021F_var*
//#UC END# *4E26D05D00FA_4E26CCF0021F_var*
begin
//#UC START# *4E26D05D00FA_4E26CCF0021F_impl*
 Result := TevRootContentsNode.Make;
//#UC END# *4E26D05D00FA_4E26CCF0021F_impl*
end;//TevContentsNodeFactory.CreateRoot

end.
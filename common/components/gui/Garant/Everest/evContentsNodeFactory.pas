unit evContentsNodeFactory;
 {* ������� ��� �������� ���. }

// ������: "w:\common\components\gui\Garant\Everest\evContentsNodeFactory.pas"
// ���������: "SimpleClass"
// ������� ������: "TevContentsNodeFactory" MUID: (4E26CCF0021F)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3Tree_TLB
 , l3TreeInterfaces
 , l3Variant
 , evInternalInterfaces
;

type
 TevContentsNodeFactory = class
  {* ������� ��� �������� ���. }
  public
   class function CreateContentsNode(aTag: Tl3Variant;
    aSub: Tl3Variant;
    const aFilter: InevContentsNodeFilter): Il3Node;
    {* ������� ���� ���� ��� ���������, �����, ����. }
   class function CreateRoot: Il3SimpleRootNode;
    {* ������� ������� ����. }
 end;//TevContentsNodeFactory

implementation

uses
 l3ImplUses
 , l3Nodes
 , evDocumentNode
 , evContentsTagNode
 , evContentsSubNode
 , Document_Const
 , evRootContentsNode
;

class function TevContentsNodeFactory.CreateContentsNode(aTag: Tl3Variant;
 aSub: Tl3Variant;
 const aFilter: InevContentsNodeFilter): Il3Node;
 {* ������� ���� ���� ��� ���������, �����, ����. }
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
 {* ������� ������� ����. }
//#UC START# *4E26D05D00FA_4E26CCF0021F_var*
//#UC END# *4E26D05D00FA_4E26CCF0021F_var*
begin
//#UC START# *4E26D05D00FA_4E26CCF0021F_impl*
 Result := TevRootContentsNode.Make;
//#UC END# *4E26D05D00FA_4E26CCF0021F_impl*
end;//TevContentsNodeFactory.CreateRoot

end.

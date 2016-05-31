unit evContentsNodeFactory;
 {* Фабрика для создания нод. }

// Модуль: "w:\common\components\gui\Garant\Everest\evContentsNodeFactory.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevContentsNodeFactory" MUID: (4E26CCF0021F)

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
  {* Фабрика для создания нод. }
  public
   class function CreateContentsNode(aTag: Tl3Variant;
    aSub: Tl3Variant;
    const aFilter: InevContentsNodeFilter): Il3Node;
    {* Создает узел ноды для документа, блока, саба. }
   class function CreateRoot: Il3SimpleRootNode;
    {* Создает рутовый узел. }
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
 {* Создает узел ноды для документа, блока, саба. }
//#UC START# *4E26CFD1000A_4E26CCF0021F_var*
//#UC END# *4E26CFD1000A_4E26CCF0021F_var*
begin
//#UC START# *4E26CFD1000A_4E26CCF0021F_impl*
 if (aTag = nil) then
  Result := l3Nodes.MakeNode('<Приехал пустой узел>')
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
 {* Создает рутовый узел. }
//#UC START# *4E26D05D00FA_4E26CCF0021F_var*
//#UC END# *4E26D05D00FA_4E26CCF0021F_var*
begin
//#UC START# *4E26D05D00FA_4E26CCF0021F_impl*
 Result := TevRootContentsNode.Make;
//#UC END# *4E26D05D00FA_4E26CCF0021F_impl*
end;//TevContentsNodeFactory.CreateRoot

end.

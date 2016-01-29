unit evContentsNodeFactory;

interface

uses
 l3IntfUses
 , l3Tree_TLB
 , l3Variant
 , evInternalInterfaces
 , l3TreeInterfaces
;

type
 TevContentsNodeFactory = class
  {* Фабрика для создания нод. }
  function CreateContentsNode(aTag: Tl3Variant;
   aSub: Tl3Variant;
   const aFilter: InevContentsNodeFilter): Il3Node;
   {* Создает узел ноды для документа, блока, саба. }
  function CreateRoot: Il3SimpleRootNode;
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

end.

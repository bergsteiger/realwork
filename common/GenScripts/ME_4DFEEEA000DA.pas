unit evContentsTree;

interface

uses
 l3IntfUses
 , l3Tree
 , nevTools
 , evInternalInterfaces
 , l3Tree_TLB
 , l3Variant
 , l3IID
 , l3TreeInterfaces
;

type
 TevContentsTree = class(Tl3Tree, InevSubChangeListener)
  {* Дерево оглавления. }
  procedure CreateRootChild(aDocument: Tl3Variant);
  procedure Create(aDocument: Tl3Variant);
  function Make(aDocument: Tl3Variant): Il3Tree;
  procedure SubChanged(aSub: Tl3Variant;
   aChangeType: TevChangeType);
   {* Саб добавлен/удален. }
 end;//TevContentsTree
 
implementation

uses
 l3ImplUses
 , evContentsNodeFilter
 , SysUtils
 , l3Base
 , l3Nodes
 , l3Types
 , evNode
 , Block_Const
 , l3Interfaces
 , evContentsNodeFactory
 , k2Prim
;

end.

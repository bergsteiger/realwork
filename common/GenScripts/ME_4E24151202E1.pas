unit evParaDrawNode;

interface

uses
 l3IntfUses
 , evParaNode
 , k2Interfaces
 , nevTools
 , l3Variant
 , nevBase
 , l3IID
;

type
 TevParaDrawNode = class(TevParaNode, Ik2TagBoxContainer, IevTreeDataObject)
  procedure SetTag(aTag: Tl3Variant);
  procedure Store(const G: InevTagGenerator;
   aLevelTag: Integer;
   aIndent: Integer);
   {* Сохраняет ноду дерева в G }
 end;//TevParaDrawNode
 
implementation

uses
 l3ImplUses
 , evNodePainter
 , l3InternalInterfaces
 , k2Const
;

end.

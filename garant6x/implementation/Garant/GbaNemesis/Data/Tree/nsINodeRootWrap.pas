unit nsINodeRootWrap;
 {* Базовый корневой узел }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsINodeRootWrap.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsINodeRootWrap" MUID: (468275200341)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsINodeWrap
 , l3TreeInterfaces
 , DynamicTreeUnit
;

type
 TnsINodeRootWrap = class(TnsINodeWrap, Il3SimpleRootNode)
  {* Базовый корневой узел }
  protected
   function CanExpandCollapseAll: Boolean;
   procedure ExpandCollapseAll(anExpand: Boolean);
  public
   class function Make(const aNode: INodeBase): Il3SimpleRootNode;
 end;//TnsINodeRootWrap

implementation

uses
 l3ImplUses
;

class function TnsINodeRootWrap.Make(const aNode: INodeBase): Il3SimpleRootNode;
//#UC START# *4909A77F0299_468275200341_var*
//#UC END# *4909A77F0299_468275200341_var*
begin
//#UC START# *4909A77F0299_468275200341_impl*
 Result := inherited Make(aNode) As Il3SimpleRootNode;
//#UC END# *4909A77F0299_468275200341_impl*
end;//TnsINodeRootWrap.Make

function TnsINodeRootWrap.CanExpandCollapseAll: Boolean;
//#UC START# *4772433F0008_468275200341_var*
//#UC END# *4772433F0008_468275200341_var*
begin
//#UC START# *4772433F0008_468275200341_impl*
 Result := True;
//#UC END# *4772433F0008_468275200341_impl*
end;//TnsINodeRootWrap.CanExpandCollapseAll

procedure TnsINodeRootWrap.ExpandCollapseAll(anExpand: Boolean);
//#UC START# *47724349030A_468275200341_var*
//#UC END# *47724349030A_468275200341_var*
begin
//#UC START# *47724349030A_468275200341_impl*
 DoExpandCollapseAll(anExpand);
//#UC END# *47724349030A_468275200341_impl*
end;//TnsINodeRootWrap.ExpandCollapseAll

end.

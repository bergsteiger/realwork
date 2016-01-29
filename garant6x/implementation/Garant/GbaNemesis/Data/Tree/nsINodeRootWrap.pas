unit nsINodeRootWrap;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Tree/nsINodeRootWrap.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Data::Tree::TnsINodeRootWrap
//
// Базовый корневой узел
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  DynamicTreeUnit,
  l3TreeInterfaces,
  nsINodeWrap
  ;

type
 TnsINodeRootWrap = class(TnsINodeWrap, Il3SimpleRootNode)
  {* Базовый корневой узел }
 protected
 // realized methods
   function CanExpandCollapseAll: Boolean;
   procedure ExpandCollapseAll(anExpand: Boolean);
 public
 // public methods
   class function Make(const aNode: INodeBase): Il3SimpleRootNode;
 end;//TnsINodeRootWrap

implementation

// start class TnsINodeRootWrap

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
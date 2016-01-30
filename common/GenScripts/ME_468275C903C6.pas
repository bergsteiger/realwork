unit nsINodeOneLevelRootWrap;
 {* Корень одноуровневого дерева }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsINodeOneLevelRootWrap.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , nsINodeRootWrap
 , nsINodeWrapBase
;

type
 TnsINodeOneLevelRootWrap = class(TnsINodeRootWrap)
  {* Корень одноуровневого дерева }
  protected
   function GetChildNodeClass: RnsINodeWrap; override;
    {* Реализация функции получения класса реализации дочернего узла }
 end;//TnsINodeOneLevelRootWrap

implementation

uses
 l3ImplUses
 , nsINodeOneLevelWrap
;

function TnsINodeOneLevelRootWrap.GetChildNodeClass: RnsINodeWrap;
 {* Реализация функции получения класса реализации дочернего узла }
//#UC START# *490989330020_468275C903C6_var*
//#UC END# *490989330020_468275C903C6_var*
begin
//#UC START# *490989330020_468275C903C6_impl*
 Result := TnsINodeOneLevelWrap;
//#UC END# *490989330020_468275C903C6_impl*
end;//TnsINodeOneLevelRootWrap.GetChildNodeClass

end.

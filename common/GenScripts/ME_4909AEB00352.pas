unit nsINodeWrap;
 {* Реализация узла дерева с поддержкой информации о дочерних узлах }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsINodeWrap.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , nsINodeWrapBase
;

type
 InsNodeImplementationInfo = interface
  ['{93EEF340-A8DC-4727-A03A-E109D044C685}']
  function ChildNodeClass: RnsINodeWrap;
 end;//InsNodeImplementationInfo

 TnsINodeWrap = class(TnsINodeWrapBase, InsNodeImplementationInfo)
  {* Реализация узла дерева с поддержкой информации о дочерних узлах }
  protected
   function ChildNodeClass: RnsINodeWrap;
 end;//TnsINodeWrap

implementation

uses
 l3ImplUses
;

function TnsINodeWrap.ChildNodeClass: RnsINodeWrap;
//#UC START# *48FEE3B402EB_4909AEB00352_var*
//#UC END# *48FEE3B402EB_4909AEB00352_var*
begin
//#UC START# *48FEE3B402EB_4909AEB00352_impl*
 Result := GetChildNodeClass;
//#UC END# *48FEE3B402EB_4909AEB00352_impl*
end;//TnsINodeWrap.ChildNodeClass

end.

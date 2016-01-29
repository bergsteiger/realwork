unit nsINodeWrap;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Tree/nsINodeWrap.pas"
// Начат: 30.10.2008 15:55
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Data::Tree::TnsINodeWrap
//
// Реализация узла дерева с поддержкой информации о дочерних узлах
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  nsINodeWrapBase
  ;

type
 InsNodeImplementationInfo = interface(IUnknown)
   ['{93EEF340-A8DC-4727-A03A-E109D044C685}']
   function ChildNodeClass: RnsINodeWrap;
 end;//InsNodeImplementationInfo

 TnsINodeWrap = class(TnsINodeWrapBase, InsNodeImplementationInfo)
  {* Реализация узла дерева с поддержкой информации о дочерних узлах }
 protected
 // realized methods
   function ChildNodeClass: RnsINodeWrap;
 end;//TnsINodeWrap

implementation

// start class TnsINodeWrap

function TnsINodeWrap.ChildNodeClass: RnsINodeWrap;
//#UC START# *48FEE3B402EB_4909AEB00352_var*
//#UC END# *48FEE3B402EB_4909AEB00352_var*
begin
//#UC START# *48FEE3B402EB_4909AEB00352_impl*
 Result := GetChildNodeClass;
//#UC END# *48FEE3B402EB_4909AEB00352_impl*
end;//TnsINodeWrap.ChildNodeClass

end.
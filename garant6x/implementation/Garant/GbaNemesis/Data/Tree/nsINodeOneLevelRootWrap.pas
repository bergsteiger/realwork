unit nsINodeOneLevelRootWrap;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Tree/nsINodeOneLevelRootWrap.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Data::Tree::TnsINodeOneLevelRootWrap
//
// Корень одноуровневого дерева
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  nsINodeRootWrap,
  nsINodeWrapBase
  ;

type
 TnsINodeOneLevelRootWrap = class(TnsINodeRootWrap)
  {* Корень одноуровневого дерева }
 protected
 // overridden protected methods
   function GetChildNodeClass: RnsINodeWrap; override;
     {* Реализация функции получения класса реализации дочернего узла }
 end;//TnsINodeOneLevelRootWrap

implementation

uses
  nsINodeOneLevelWrap
  ;

// start class TnsINodeOneLevelRootWrap

function TnsINodeOneLevelRootWrap.GetChildNodeClass: RnsINodeWrap;
//#UC START# *490989330020_468275C903C6_var*
//#UC END# *490989330020_468275C903C6_var*
begin
//#UC START# *490989330020_468275C903C6_impl*
 Result := TnsINodeOneLevelWrap;
//#UC END# *490989330020_468275C903C6_impl*
end;//TnsINodeOneLevelRootWrap.GetChildNodeClass

end.
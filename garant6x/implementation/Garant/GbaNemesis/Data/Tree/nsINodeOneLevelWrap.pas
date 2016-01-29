unit nsINodeOneLevelWrap;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Автор: Тучнин Д.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Tree/nsINodeOneLevelWrap.pas"
// Начат: 2004/04/20 11:08:38
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Data::Tree::TnsINodeOneLevelWrap
//
// Элемент одноуровневого дерево
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  nsINodeWrap,
  l3TreeInterfaces
  ;

type
 TnsINodeOneLevelWrap = class(TnsINodeWrap)
  {* Элемент одноуровневого дерево }
 protected
 // overridden protected methods
   function DoGetChild: Il3SimpleNode; override;
     {* Реализация функции получения первого ребёнка }
   function GetHasChild: Boolean; override;
     {* Реализация функции определения того есть ли дочерние узлы }
   function GetMaybeChild: Boolean; override;
     {* Реализация функции определения может ли узел иметь дочерние узлы }
 end;//TnsINodeOneLevelWrap

implementation

// start class TnsINodeOneLevelWrap

function TnsINodeOneLevelWrap.DoGetChild: Il3SimpleNode;
//#UC START# *4909A13402E2_468275E600B1_var*
//#UC END# *4909A13402E2_468275E600B1_var*
begin
//#UC START# *4909A13402E2_468275E600B1_impl*
 Result := nil;
//#UC END# *4909A13402E2_468275E600B1_impl*
end;//TnsINodeOneLevelWrap.DoGetChild

function TnsINodeOneLevelWrap.GetHasChild: Boolean;
//#UC START# *4909A1790056_468275E600B1_var*
//#UC END# *4909A1790056_468275E600B1_var*
begin
//#UC START# *4909A1790056_468275E600B1_impl*
 Result := False;
//#UC END# *4909A1790056_468275E600B1_impl*
end;//TnsINodeOneLevelWrap.GetHasChild

function TnsINodeOneLevelWrap.GetMaybeChild: Boolean;
//#UC START# *4909A1AA0089_468275E600B1_var*
//#UC END# *4909A1AA0089_468275E600B1_var*
begin
//#UC START# *4909A1AA0089_468275E600B1_impl*
 Result := False;
//#UC END# *4909A1AA0089_468275E600B1_impl*
end;//TnsINodeOneLevelWrap.GetMaybeChild

end.
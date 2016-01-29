unit nsComplectInfoRootNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Common$Lib"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Common/nsComplectInfoRootNode.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Common$Lib::ComplectInfo::TnsComplectInfoRootNode
//
// Корневой узел дерева с информацией о комплекте
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsINodeRootWrap,
  nsINodeWrapBase
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsComplectInfoRootNode = class(TnsINodeRootWrap)
  {* Корневой узел дерева с информацией о комплекте }
 protected
 // overridden protected methods
   function GetChildNodeClass: RnsINodeWrap; override;
     {* Реализация функции получения класса реализации дочернего узла }
 end;//TnsComplectInfoRootNode
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsComplectInfoNode
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsComplectInfoRootNode

function TnsComplectInfoRootNode.GetChildNodeClass: RnsINodeWrap;
//#UC START# *490989330020_468276240241_var*
//#UC END# *490989330020_468276240241_var*
begin
//#UC START# *490989330020_468276240241_impl*
 Result := TnsComplectInfoNode;
//#UC END# *490989330020_468276240241_impl*
end;//TnsComplectInfoRootNode.GetChildNodeClass

{$IfEnd} //not Admin AND not Monitorings

end.
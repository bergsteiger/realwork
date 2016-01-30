unit nsINodeOneLevelWrap;
 {* Элемент одноуровневого дерево }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsINodeOneLevelWrap.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , nsINodeWrap
 , l3TreeInterfaces
;

type
 TnsINodeOneLevelWrap = class(TnsINodeWrap)
  {* Элемент одноуровневого дерево }
  protected
   function DoGetChild: Il3SimpleNode; override;
    {* Реализация функции получения первого ребёнка }
   function GetHasChild: Boolean; override;
    {* Реализация функции определения того есть ли дочерние узлы }
   function GetMaybeChild: Boolean; override;
    {* Реализация функции определения может ли узел иметь дочерние узлы }
 end;//TnsINodeOneLevelWrap

implementation

uses
 l3ImplUses
;

function TnsINodeOneLevelWrap.DoGetChild: Il3SimpleNode;
 {* Реализация функции получения первого ребёнка }
//#UC START# *4909A13402E2_468275E600B1_var*
//#UC END# *4909A13402E2_468275E600B1_var*
begin
//#UC START# *4909A13402E2_468275E600B1_impl*
 Result := nil;
//#UC END# *4909A13402E2_468275E600B1_impl*
end;//TnsINodeOneLevelWrap.DoGetChild

function TnsINodeOneLevelWrap.GetHasChild: Boolean;
 {* Реализация функции определения того есть ли дочерние узлы }
//#UC START# *4909A1790056_468275E600B1_var*
//#UC END# *4909A1790056_468275E600B1_var*
begin
//#UC START# *4909A1790056_468275E600B1_impl*
 Result := False;
//#UC END# *4909A1790056_468275E600B1_impl*
end;//TnsINodeOneLevelWrap.GetHasChild

function TnsINodeOneLevelWrap.GetMaybeChild: Boolean;
 {* Реализация функции определения может ли узел иметь дочерние узлы }
//#UC START# *4909A1AA0089_468275E600B1_var*
//#UC END# *4909A1AA0089_468275E600B1_var*
begin
//#UC START# *4909A1AA0089_468275E600B1_impl*
 Result := False;
//#UC END# *4909A1AA0089_468275E600B1_impl*
end;//TnsINodeOneLevelWrap.GetMaybeChild

end.

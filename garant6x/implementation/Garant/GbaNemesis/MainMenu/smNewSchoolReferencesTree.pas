unit smNewSchoolReferencesTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "MainMenu"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/MainMenu/smNewSchoolReferencesTree.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Интерфейсные элементы::MainMenu::MainMenu::MainMenuTrees::TsmNewSchoolReferencesTree
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
  smTree,
  l3Tree_TLB
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TsmNewSchoolReferencesTree = class(TsmTree)
 protected
 // overridden protected methods
   function MakeRoot: Il3RootNode; override;
     {* Создаёт корень дерева }
 end;//TsmNewSchoolReferencesTree
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsNodes,
  l3Base,
  DynamicTreeUnit,
  nsINodeWrap,
  nsNewCachableNode,
  BaseTypesUnit,
  nsTypes,
  MainMenuUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TsmNewSchoolReferencesTree

function TsmNewSchoolReferencesTree.MakeRoot: Il3RootNode;
//#UC START# *4909EF6E0361_4AFBF77E0200_var*
(*var
 l_P : TnsNavigatorItemParams;*)
//#UC END# *4909EF6E0361_4AFBF77E0200_var*
begin
//#UC START# *4909EF6E0361_4AFBF77E0200_impl*
 Result := inherited MakeRoot;
 AddItems2011(Result, ST_BUSINESS_REFERENCES);
(* l_P.rId := NM_BUSINESS_REFERENCES_FOLDER;
 l_P.rLevel := 4;
 nsMakeTreeLevel(Result, nsFindNavigatorItem(l_P));*)
//#UC END# *4909EF6E0361_4AFBF77E0200_impl*
end;//TsmNewSchoolReferencesTree.MakeRoot

{$IfEnd} //not Admin AND not Monitorings

end.
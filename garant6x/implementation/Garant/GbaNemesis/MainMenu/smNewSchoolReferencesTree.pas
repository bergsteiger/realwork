unit smNewSchoolReferencesTree;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\MainMenu\smNewSchoolReferencesTree.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TsmNewSchoolReferencesTree" MUID: (4AFBF77E0200)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , smTree
 , l3Tree_TLB
;

type
 TsmNewSchoolReferencesTree = class(TsmTree)
  protected
   function MakeRoot: Il3RootNode; override;
    {* Создаёт корень дерева }
 end;//TsmNewSchoolReferencesTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsNodes
 , l3Base
 , DynamicTreeUnit
 , nsINodeWrap
 , nsNewCachableNode
 , BaseTypesUnit
 , nsTypes
 , MainMenuUnit
;

function TsmNewSchoolReferencesTree.MakeRoot: Il3RootNode;
 {* Создаёт корень дерева }
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

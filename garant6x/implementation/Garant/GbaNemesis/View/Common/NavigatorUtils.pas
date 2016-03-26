unit NavigatorUtils;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\NavigatorUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "NavigatorUtils" MUID: (52400BCF03D1)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3TreeInterfaces
 , eeTreeView
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

procedure ExecuteNavigatorItem(const aNode: Il3SimpleNode;
 aTree: TeeTreeView;
 const aMainForm: IvcmContainer);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DynamicTreeUnit
 , SysUtils
 , BaseTypesUnit
 , nsOpenUtils
;

procedure ExecuteNavigatorItem(const aNode: Il3SimpleNode;
 aTree: TeeTreeView;
 const aMainForm: IvcmContainer);
//#UC START# *52400BE90253_52400BCF03D1_var*
var
 l_ItemType: TNavigatorMenuItemType;
 l_Node: INodeBase;
//#UC END# *52400BE90253_52400BCF03D1_var*
begin
//#UC START# *52400BE90253_52400BCF03D1_impl*
 if Supports(aNode, INodeBase, l_Node) then
 begin
  l_ItemType := TNavigatorMenuItemType(l_Node.GetType);
  case l_ItemType of
   NM_INPHARM, {http://mdp.garant.ru/pages/viewpage.action?pageId=332568675}
   NM_LAW_NAVIGATOR_FOLDER,
   NM_BUSINESS_INFO_FOLDER,
   NM_SEARCH_FOLDER,
   NM_UPDATE_FOLDER,
   NM_RECENTLY_DOCUMENTS_FOLDER,
   NM_PRIME_FOLDER:
   begin
    if (aTree<> nil) and aNode.HasChild then
     aTree.ExpandNode(aNode, not aTree.TreeStruct.IsExpanded(aNode));
   end;
   else
    nsOpenNavigatorItem(aNode, aMainForm);
  end;//case l_ItemType of
 end;//if Supports(aNode, INodeBase, l_Node) then
//#UC END# *52400BE90253_52400BCF03D1_impl*
end;//ExecuteNavigatorItem
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

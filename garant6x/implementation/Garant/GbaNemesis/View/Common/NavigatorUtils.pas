unit NavigatorUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/NavigatorUtils.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Core::Common::View::Common::NavigatorUtils
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
  l3TreeInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  eeTreeView
  ;

procedure ExecuteNavigatorItem(const aNode: Il3SimpleNode;
  aTree: TeeTreeView;
  const aMainForm: IvcmContainer);
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DynamicTreeUnit,
  SysUtils,
  BaseTypesUnit,
  nsOpenUtils
  ;

// unit methods

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
{$IfEnd} //not Admin AND not Monitorings

end.
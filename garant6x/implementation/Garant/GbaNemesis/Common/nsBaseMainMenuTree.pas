unit nsBaseMainMenuTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Common$Lib"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Common/nsBaseMainMenuTree.pas"
// Начат: 2004/12/06 10:34:07 
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Common$Lib::MainMenu::TnsBaseMainMenuTree
//
// Базовое дерево меню
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
  DynamicTreeUnit,
  l3Interfaces,
  l3Tree_TLB,
  nsDataResetTree,
  nsTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsBaseMainMenuTree = class(TnsDataResetTree)
  {* Базовое дерево меню }
 protected
 // overridden protected methods
   procedure InitFields; override;
   procedure AfterReget; override;
   function RegetRootNode: Il3RootNode; override;
 protected
 // protected methods
   function MakeRoot: Il3RootNode; virtual;
     {* Создаёт корень дерева }
   class procedure NsAddMainMenuItem(const aRoot: Il3RootNode;
    aMenuItem: Integer;
    const aNavigatorItem: TnsNavigatorItemParams;
    const aParent: INodeBase = nil); overload; 
   class procedure NsAddMainMenuItem(const aRoot: Il3RootNode;
    aMenuItem: Integer;
    const aCaption: Il3CString); overload; 
 public
 // public methods
   class function NsFindNavigatorItem(const aParams: TnsNavigatorItemParams;
    const aParent: INodeBase = nil): INodeBase;
     {* найти элемент в дереве навигатора. Если родитель не указан, то используется корень дерева. }
 end;//TnsBaseMainMenuTree
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsNodes,
  SysUtils,
  nsRubricatorCache,
  BaseTypesUnit,
  nsNewCachableNode,
  nsMainMenuNode
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsBaseMainMenuTree

function TnsBaseMainMenuTree.MakeRoot: Il3RootNode;
//#UC START# *4909EF6E0361_4909EF3B02B1_var*
//#UC END# *4909EF6E0361_4909EF3B02B1_var*
begin
//#UC START# *4909EF6E0361_4909EF3B02B1_impl*
 Supports(TnsNewCachableNode.Make(nil), Il3RootNode, Result);
//#UC END# *4909EF6E0361_4909EF3B02B1_impl*
end;//TnsBaseMainMenuTree.MakeRoot

class function TnsBaseMainMenuTree.NsFindNavigatorItem(const aParams: TnsNavigatorItemParams;
  const aParent: INodeBase = nil): INodeBase;
//#UC START# *490B08670285_4909EF3B02B1_var*
var
 l_Item   : INodeBase;
 l_Temp   : INodeBase;
 l_Parent : INodeBase;
 l_Params : TnsNavigatorItemParams;
//#UC END# *490B08670285_4909EF3B02B1_var*
begin
//#UC START# *490B08670285_4909EF3B02B1_impl*
 Result := nil;
 if aParent = nil then
  l_Parent := TnsRubricatorCache.Instance.RubricatorRoot
 else
  l_Parent := aParent;
 l_Parent.GetFirstChild(l_Item);
 while Assigned(l_Item) do
 begin
  if TNavigatorMenuItemType(l_Item.GetType) = aParams.rId then
  begin
   Result := l_Item;
   Break;
  end;//if TNavigatorMenuItemType(l_Item.GetType) = aParams.rId then
  if aParams.rLevel > 0 then
  begin
   l_Params := aParams;
   Dec(l_Params.rLevel);
   Result := nsFindNavigatorItem(l_Params, l_Item);
  end;//if aParams.rLevel > 0 then
  if Assigned(Result) then
   Break;
  l_Item.GetNext(l_Temp);
  try
   l_Item := l_Temp;
  finally
   l_Temp := nil;
  end;//try..finally
 end;//while Assigned(l_Item) do
//#UC END# *490B08670285_4909EF3B02B1_impl*
end;//TnsBaseMainMenuTree.NsFindNavigatorItem

class procedure TnsBaseMainMenuTree.NsAddMainMenuItem(const aRoot: Il3RootNode;
  aMenuItem: Integer;
  const aNavigatorItem: TnsNavigatorItemParams;
  const aParent: INodeBase = nil);
//#UC START# *490B12C6035E_4909EF3B02B1_var*
var
 l_Node: INodeBase;
//#UC END# *490B12C6035E_4909EF3B02B1_var*
begin
//#UC START# *490B12C6035E_4909EF3B02B1_impl*
 l_Node := nsFindNavigatorItem(aNavigatorItem, aParent);
 if l_Node <> nil then
 try
  aRoot.InsertChild(TnsMainMenuNode.Make(aMenuItem, nil, l_Node));
 finally
  l_Node := nil;
 end;{try..finally}
//#UC END# *490B12C6035E_4909EF3B02B1_impl*
end;//TnsBaseMainMenuTree.NsAddMainMenuItem

class procedure TnsBaseMainMenuTree.NsAddMainMenuItem(const aRoot: Il3RootNode;
  aMenuItem: Integer;
  const aCaption: Il3CString);
//#UC START# *53A988E703D5_4909EF3B02B1_var*
//#UC END# *53A988E703D5_4909EF3B02B1_var*
begin
//#UC START# *53A988E703D5_4909EF3B02B1_impl*
 aRoot.InsertChild(TnsMainMenuNode.Make(aMenuItem, aCaption, nil));
//#UC END# *53A988E703D5_4909EF3B02B1_impl*
end;//TnsBaseMainMenuTree.NsAddMainMenuItem

procedure TnsBaseMainMenuTree.InitFields;
//#UC START# *47A042E100E2_4909EF3B02B1_var*
//#UC END# *47A042E100E2_4909EF3B02B1_var*
begin
//#UC START# *47A042E100E2_4909EF3B02B1_impl*
 inherited;
 RootNode := MakeRoot;
 if RootNode <> nil then
  ExpandSubDir(RootNode, True);
//#UC END# *47A042E100E2_4909EF3B02B1_impl*
end;//TnsBaseMainMenuTree.InitFields

procedure TnsBaseMainMenuTree.AfterReget;
//#UC START# *4908AAF6015C_4909EF3B02B1_var*
//#UC END# *4908AAF6015C_4909EF3B02B1_var*
begin
//#UC START# *4908AAF6015C_4909EF3B02B1_impl*
 inherited;
 if RootNode <> nil then
  ExpandSubDir(RootNode, True);
//#UC END# *4908AAF6015C_4909EF3B02B1_impl*
end;//TnsBaseMainMenuTree.AfterReget

function TnsBaseMainMenuTree.RegetRootNode: Il3RootNode;
//#UC START# *4908AB070319_4909EF3B02B1_var*
//#UC END# *4908AB070319_4909EF3B02B1_var*
begin
//#UC START# *4908AB070319_4909EF3B02B1_impl*
 case BeenReseted of
  rtsRoot:
   begin
    Result := MakeRoot;
    RootNode := Result;
   end;
  else
   Result := inherited RegetRootNode;
 end;//case BeenReseted of
//#UC END# *4908AB070319_4909EF3B02B1_impl*
end;//TnsBaseMainMenuTree.RegetRootNode

{$IfEnd} //not Admin AND not Monitorings

end.
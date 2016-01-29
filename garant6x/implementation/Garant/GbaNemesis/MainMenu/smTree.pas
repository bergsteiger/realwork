unit smTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "MainMenu"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/MainMenu/smTree.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Интерфейсные элементы::MainMenu::MainMenu::MainMenuTrees::TsmTree
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
  l3Tree_TLB,
  nsBaseMainMenuTree,
  MainMenuUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TsmTree = class(TnsBaseMainMenuTree)
 private
 // private fields
   f_Section : ISection;
   f_SectionType : TSectionType;
 protected
 // overridden protected methods
   procedure BeforeReset; override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected methods
   procedure AddItems2011(const aRoot: Il3RootNode;
     aSectionType: TSectionType);
 end;//TsmTree
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsMainMenu2011Node,
  DataAdapter,
  nsMainMenuNode
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TsmTree

procedure TsmTree.AddItems2011(const aRoot: Il3RootNode;
  aSectionType: TSectionType);
//#UC START# *4E73127A01C7_490B0E9A02A2_var*
var
 l_Sect : ISection;
 l_List : ISectionItemList;
 l_Index : Integer;
 l_Item : ISectionItem;
//#UC END# *4E73127A01C7_490B0E9A02A2_var*
begin
//#UC START# *4E73127A01C7_490B0E9A02A2_impl*
 Assert(f_Section = nil, 'Дерево уже держит одну секцию ОМ');
 f_SectionType := aSectionType;
 DefDataAdapter.NativeAdapter.MakeMainMenu.GetSection(aSectionType, l_Sect);
 Assert(l_Sect <> nil);
 try
  f_Section := l_Sect;
  l_Sect.GetItems(l_List);
  Assert(l_List <> nil);
  try
   for l_Index := 0 to Pred(l_List.Count) do
   begin
    l_List.pm_GetItem(l_Index, l_Item);
    Assert(l_Item <> nil);
    aRoot.InsertChild(TnsMainMenu2011Node.Make(l_Item));
   end;//for l_Index
  finally
   l_List := nil;
  end;//try..finally
 finally
  l_Sect := nil;
 end;//try..finally
//#UC END# *4E73127A01C7_490B0E9A02A2_impl*
end;//TsmTree.AddItems2011

procedure TsmTree.BeforeReset;
//#UC START# *4908AAED02BD_490B0E9A02A2_var*
//#UC END# *4908AAED02BD_490B0E9A02A2_var*
begin
//#UC START# *4908AAED02BD_490B0E9A02A2_impl*
 inherited;
 f_Section := nil;
//#UC END# *4908AAED02BD_490B0E9A02A2_impl*
end;//TsmTree.BeforeReset

procedure TsmTree.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Section := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TsmTree.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.
unit smTree;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\MainMenu\smTree.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TsmTree" MUID: (490B0E9A02A2)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsBaseMainMenuTree
 , MainMenuUnit
 , l3Tree_TLB
;

type
 TsmTree = class(TnsBaseMainMenuTree)
  private
   f_Section: ISection;
   f_SectionType: TSectionType;
  protected
   procedure AddItems2011(const aRoot: Il3RootNode;
    aSectionType: TSectionType);
   procedure BeforeReset; override;
   procedure ClearFields; override;
 end;//TsmTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsMainMenuNode
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsMainMenu2011Node
 , DataAdapter
 //#UC START# *490B0E9A02A2impl_uses*
 //#UC END# *490B0E9A02A2impl_uses*
;

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
begin
 f_Section := nil;
 inherited;
end;//TsmTree.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

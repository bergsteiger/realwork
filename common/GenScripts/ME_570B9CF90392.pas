unit smMainMenuTree2016;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\MainMenu\smMainMenuTree2016.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TsmMainMenuTree2016" MUID: (570B9CF90392)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsBaseMainMenuTree
 , MainMenuUnit
 , l3TreeInterfaces
 , l3Tree_TLB
;

type
 TsmMainMenuTree2016 = class(TnsBaseMainMenuTree)
  private
   f_Section: IMainMenuSection;
  protected
   procedure AddItems;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure BeforeReset; override;
   function MakeRoot: Il3RootNode; override;
    {* Создаёт корень дерева }
  public
   constructor Create(const aSection: IMainMenuSection); reintroduce;
   class function Make(const aSection: IMainMenuSection): Il3SimpleTree; reintroduce;
 end;//TsmMainMenuTree2016
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsMainMenu2011Node
 , nsNewCachableNode
 , SysUtils
;

constructor TsmMainMenuTree2016.Create(const aSection: IMainMenuSection);
//#UC START# *570B9E6A035D_570B9CF90392_var*
//#UC END# *570B9E6A035D_570B9CF90392_var*
begin
//#UC START# *570B9E6A035D_570B9CF90392_impl*
 inherited Create;
 f_Section := aSection;
//#UC END# *570B9E6A035D_570B9CF90392_impl*
end;//TsmMainMenuTree2016.Create

class function TsmMainMenuTree2016.Make(const aSection: IMainMenuSection): Il3SimpleTree;
var
 l_Inst : TsmMainMenuTree2016;
begin
 l_Inst := Create(aSection);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TsmMainMenuTree2016.Make

procedure TsmMainMenuTree2016.AddItems;
//#UC START# *570B9EFA0118_570B9CF90392_var*
var
 I: Integer;
 l_Item: ISectionItem;
 l_Sections: ISectionItemList;
//#UC END# *570B9EFA0118_570B9CF90392_var*
begin
//#UC START# *570B9EFA0118_570B9CF90392_impl*
 f_Section.GetItems(l_Sections);
 for I := 0 to l_Sections.Count - 1 do
 begin
  l_Sections.pm_GetItem(I, l_Item);
  RootNode.InsertChild(TnsMainMenu2011Node.Make(l_Item));
 end;
//#UC END# *570B9EFA0118_570B9CF90392_impl*
end;//TsmMainMenuTree2016.AddItems

procedure TsmMainMenuTree2016.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_570B9CF90392_var*
//#UC END# *479731C50290_570B9CF90392_var*
begin
//#UC START# *479731C50290_570B9CF90392_impl*
 f_Section := nil;
 inherited;
//#UC END# *479731C50290_570B9CF90392_impl*
end;//TsmMainMenuTree2016.Cleanup

procedure TsmMainMenuTree2016.InitFields;
//#UC START# *47A042E100E2_570B9CF90392_var*
//#UC END# *47A042E100E2_570B9CF90392_var*
begin
//#UC START# *47A042E100E2_570B9CF90392_impl*
 inherited;
 RootNode := MakeRoot;
 AddItems;
 if (RootNode <> nil) then
  ExpandSubDir(RootNode, True);
//#UC END# *47A042E100E2_570B9CF90392_impl*
end;//TsmMainMenuTree2016.InitFields

procedure TsmMainMenuTree2016.BeforeReset;
//#UC START# *4908AAED02BD_570B9CF90392_var*
//#UC END# *4908AAED02BD_570B9CF90392_var*
begin
//#UC START# *4908AAED02BD_570B9CF90392_impl*
 inherited;
 f_Section := nil;
//#UC END# *4908AAED02BD_570B9CF90392_impl*
end;//TsmMainMenuTree2016.BeforeReset

function TsmMainMenuTree2016.MakeRoot: Il3RootNode;
 {* Создаёт корень дерева }
//#UC START# *4909EF6E0361_570B9CF90392_var*
//#UC END# *4909EF6E0361_570B9CF90392_var*
begin
//#UC START# *4909EF6E0361_570B9CF90392_impl*
 Supports(TnsNewCachableNode.Make(nil), Il3RootNode, Result);
//#UC END# *4909EF6E0361_570B9CF90392_impl*
end;//TsmMainMenuTree2016.MakeRoot
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

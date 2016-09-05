unit smSectionTree;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\MainMenu\smSectionTree.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TsmSectionTree" MUID: (570B6AB10204)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsDataResetTree
 , MainMenuUnit
 , l3Tree_TLB
 , l3TreeInterfaces
;

type
 TsmSectionTree = class(TnsDataResetTree)
  private
   f_Sections: IMainMenuSectionList;
  private
   procedure AddNodes;
  protected
   function MakeRoot: Il3RootNode;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure BeforeReset; override;
   procedure AfterReget; override;
   function RegetRootNode: Il3RootNode; override;
  public
   constructor Create(const aSections: IMainMenuSectionList); reintroduce;
   class function Make(const aSections: IMainMenuSectionList): Il3SimpleTree; reintroduce;
 end;//TsmSectionTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsMainMenuSectionNode
 , nsTypes
 , nsNewCachableNode
 , SysUtils
 //#UC START# *570B6AB10204impl_uses*
 //#UC END# *570B6AB10204impl_uses*
;

function TsmSectionTree.MakeRoot: Il3RootNode;
//#UC START# *570B6C6701A9_570B6AB10204_var*
//#UC END# *570B6C6701A9_570B6AB10204_var*
begin
//#UC START# *570B6C6701A9_570B6AB10204_impl*
 Supports(TnsNewCachableNode.Make(nil), Il3RootNode, Result);
//#UC END# *570B6C6701A9_570B6AB10204_impl*
end;//TsmSectionTree.MakeRoot

constructor TsmSectionTree.Create(const aSections: IMainMenuSectionList);
//#UC START# *570B7D6D0066_570B6AB10204_var*
//#UC END# *570B7D6D0066_570B6AB10204_var*
begin
//#UC START# *570B7D6D0066_570B6AB10204_impl*
 inherited Create;
 f_Sections := aSections;
//#UC END# *570B7D6D0066_570B6AB10204_impl*
end;//TsmSectionTree.Create

class function TsmSectionTree.Make(const aSections: IMainMenuSectionList): Il3SimpleTree;
var
 l_Inst : TsmSectionTree;
begin
 l_Inst := Create(aSections);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TsmSectionTree.Make

procedure TsmSectionTree.AddNodes;
//#UC START# *570B7DA901A5_570B6AB10204_var*
var
 I: Integer;
 l_Section: IMainMenuSection;
//#UC END# *570B7DA901A5_570B6AB10204_var*
begin
//#UC START# *570B7DA901A5_570B6AB10204_impl*
 for I := 0 to f_Sections.Count - 1 do
 begin
  f_Sections.pm_GetItem(I, l_Section);
  RootNode.InsertChild(TnsMainMenuSectionNode.Make(l_Section));
 end;
//#UC END# *570B7DA901A5_570B6AB10204_impl*
end;//TsmSectionTree.AddNodes

procedure TsmSectionTree.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_570B6AB10204_var*
//#UC END# *479731C50290_570B6AB10204_var*
begin
//#UC START# *479731C50290_570B6AB10204_impl*
 f_Sections := nil;
 inherited;
//#UC END# *479731C50290_570B6AB10204_impl*
end;//TsmSectionTree.Cleanup

procedure TsmSectionTree.InitFields;
//#UC START# *47A042E100E2_570B6AB10204_var*
//#UC END# *47A042E100E2_570B6AB10204_var*
begin
//#UC START# *47A042E100E2_570B6AB10204_impl*
 inherited;
 RootNode := MakeRoot;
 AddNodes;
 if (RootNode <> nil) then
  ExpandSubDir(RootNode, True);
//#UC END# *47A042E100E2_570B6AB10204_impl*
end;//TsmSectionTree.InitFields

procedure TsmSectionTree.BeforeReset;
//#UC START# *4908AAED02BD_570B6AB10204_var*
//#UC END# *4908AAED02BD_570B6AB10204_var*
begin
//#UC START# *4908AAED02BD_570B6AB10204_impl*
 inherited;
 f_Sections := nil;
//#UC END# *4908AAED02BD_570B6AB10204_impl*
end;//TsmSectionTree.BeforeReset

procedure TsmSectionTree.AfterReget;
//#UC START# *4908AAF6015C_570B6AB10204_var*
//#UC END# *4908AAF6015C_570B6AB10204_var*
begin
//#UC START# *4908AAF6015C_570B6AB10204_impl*
 inherited;
 if (RootNode <> nil) then
  ExpandSubDir(RootNode, True);
//#UC END# *4908AAF6015C_570B6AB10204_impl*
end;//TsmSectionTree.AfterReget

function TsmSectionTree.RegetRootNode: Il3RootNode;
//#UC START# *4908AB070319_570B6AB10204_var*
//#UC END# *4908AB070319_570B6AB10204_var*
begin
//#UC START# *4908AB070319_570B6AB10204_impl*
 case BeenReseted of
  rtsRoot:
   begin
    Result := MakeRoot;
    RootNode := Result;
   end;
 else
  Result := inherited RegetRootNode;
 end;//case BeenReseted of
//#UC END# *4908AB070319_570B6AB10204_impl*
end;//TsmSectionTree.RegetRootNode
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

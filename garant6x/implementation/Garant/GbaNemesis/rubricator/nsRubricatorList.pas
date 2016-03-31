unit nsRubricatorList;
 {* Структура "одноуровневое дерево" для узла рубрикатора }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Rubricator\nsRubricatorList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsRubricatorList" MUID: (46836A280235)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsOneLevelTreeStruct
 , RubricatorInterfaces
 , DynamicTreeUnit
 , MainMenuUnit
;

type
 TnsRubricatorList = class(TnsOneLevelTreeStruct, InsRubricatorTree)
  {* Структура "одноуровневое дерево" для узла рубрикатора }
  private
   f_FrozenRoot: INodeBase;
   f_RootToKeep: INodeBase;
   f_MenuSectionItemToKeep: ISectionItem;
  protected
   function ReAqurieUnfilteredRoot: INodeBase; override;
   function Get_RootToKeep: INodeBase;
   function Get_MenuSectionItemToKeep: ISectionItem;
   procedure ClearFields; override;
  public
   constructor CreateKeeped(const aRoot: INodeBase;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem); reintroduce;
   class function Make(const aRoot: INodeBase;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem): InsRubricatorTree; reintroduce;
   constructor Create(const aRoot: INodeBase;
    aShowRoot: Boolean;
    aOneLevel: Boolean = False); override;
 end;//TnsRubricatorList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsRubricatorCache
 , nsNodes
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Tree_TLB
 , l3TreeInterfaces
 , nsTypes
 , SysUtils
;

constructor TnsRubricatorList.CreateKeeped(const aRoot: INodeBase;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem);
//#UC START# *4E7387AE0021_46836A280235_var*
//#UC END# *4E7387AE0021_46836A280235_var*
begin
//#UC START# *4E7387AE0021_46836A280235_impl*
 Create(aRoot, false);
 f_RootToKeep := aRootToKeep;
//#UC END# *4E7387AE0021_46836A280235_impl*
end;//TnsRubricatorList.CreateKeeped

class function TnsRubricatorList.Make(const aRoot: INodeBase;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem): InsRubricatorTree;
var
 l_Inst : TnsRubricatorList;
begin
 l_Inst := CreateKeeped(aRoot, aRootToKeep, aMenuSectionItemToKeep);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsRubricatorList.Make

function TnsRubricatorList.ReAqurieUnfilteredRoot: INodeBase;
//#UC START# *48FF64F60078_46836A280235_var*
var
 l_RubricatorRoot,
 l_Child1, l_Child2: INodeBase;
 l_l3Root, l_l3Node: Il3Node;
 l_SimpleRootNode: Il3SimpleRootNode;
//#UC END# *48FF64F60078_46836A280235_var*
begin
//#UC START# *48FF64F60078_46836A280235_impl*
 case BeenReseted of
  rtsRoot :
   begin
    Result := nil;
    l_RubricatorRoot := TnsRubricatorCache.Instance.RubricatorRoot;
    if (l_RubricatorRoot <> nil) then
     if (f_FrozenRoot <> nil) then
      l_RubricatorRoot.FindNode(f_FrozenRoot, Result)
     else
     begin
      // откроем первую ветку рубрикатора
      l_RubricatorRoot.GetFirstChild(l_Child1);
      if (l_Child1 <> nil) then
      begin
       l_Child1.GetFirstChild(l_Child2);
       if (l_Child2 <> nil) then
        Result := l_Child2;
      end;//l_Child1 <> nil
     end;//f_FrozenRoot <> nil
    if (Result = nil) then
    begin
     l_l3Root := TnsCacheableNode.Make(nil);
     l_l3Node := TnsCacheableNode.Make(nil);
     l_l3Node.Text := vcmCStr(str_InformationUnavailable).AsWStr;
     l_l3Root.InsertChild(l_l3Node);
     if Supports(l_l3Root, Il3SimpleRootNode, l_SimpleRootNode) then
      Root := l_SimpleRootNode;
    end;//Result = nil
   end;//rtsRoot
  else
   Result := inherited ReAqurieUnfilteredRoot;
 end;//case BeenReseted

 if (Result <> nil) then
  Result.GetFrozenNode(f_FrozenRoot)
 else
  f_FrozenRoot := nil;
//#UC END# *48FF64F60078_46836A280235_impl*
end;//TnsRubricatorList.ReAqurieUnfilteredRoot

function TnsRubricatorList.Get_RootToKeep: INodeBase;
//#UC START# *4E7AFF540238_46836A280235get_var*
//#UC END# *4E7AFF540238_46836A280235get_var*
begin
//#UC START# *4E7AFF540238_46836A280235get_impl*
 Result := f_RootToKeep;
//#UC END# *4E7AFF540238_46836A280235get_impl*
end;//TnsRubricatorList.Get_RootToKeep

function TnsRubricatorList.Get_MenuSectionItemToKeep: ISectionItem;
//#UC START# *4E7AFFA700A6_46836A280235get_var*
//#UC END# *4E7AFFA700A6_46836A280235get_var*
begin
//#UC START# *4E7AFFA700A6_46836A280235get_impl*
 Result := f_MenuSectionItemToKeep;
//#UC END# *4E7AFFA700A6_46836A280235get_impl*
end;//TnsRubricatorList.Get_MenuSectionItemToKeep

constructor TnsRubricatorList.Create(const aRoot: INodeBase;
 aShowRoot: Boolean;
 aOneLevel: Boolean = False);
//#UC START# *48FDD9270194_46836A280235_var*
//#UC END# *48FDD9270194_46836A280235_var*
begin
//#UC START# *48FDD9270194_46836A280235_impl*
 inherited;
 if aRoot <> nil then
  aRoot.GetFrozenNode(f_FrozenRoot);
//#UC END# *48FDD9270194_46836A280235_impl*
end;//TnsRubricatorList.Create

procedure TnsRubricatorList.ClearFields;
begin
 f_FrozenRoot := nil;
 f_RootToKeep := nil;
 f_MenuSectionItemToKeep := nil;
 inherited;
end;//TnsRubricatorList.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

unit nsRubricatorList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Rubricator"
// Автор: Никитин А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Rubricator/nsRubricatorList.pas"
// Начат: 2003/06/10 12:57:53
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Основные прецеденты::Rubricator::Rubricator::Rubricator::TnsRubricatorList
//
// Структура "одноуровневое дерево" для узла рубрикатора
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
  nsOneLevelTreeStruct,
  MainMenuUnit,
  RubricatorInterfaces,
  l3TreeInterfaces,
  l3Interfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsRubricatorList = class(TnsOneLevelTreeStruct, InsRubricatorTree)
  {* Структура "одноуровневое дерево" для узла рубрикатора }
 private
 // private fields
   f_FrozenRoot : INodeBase;
   f_RootToKeep : INodeBase;
   f_MenuSectionItemToKeep : ISectionItem;
 protected
 // realized methods
   function ReAqurieUnfilteredRoot: INodeBase; override;
   function Get_RootToKeep: INodeBase;
   function Get_MenuSectionItemToKeep: ISectionItem;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // overridden public methods
   constructor Create(const aRoot: INodeBase;
    aShowRoot: Boolean;
    aOneLevel: Boolean = False); override;
 public
 // public methods
   constructor CreateKeeped(const aRoot: INodeBase;
     const aRootToKeep: INodeBase;
     const aMenuSectionItemToKeep: ISectionItem);
   class function Make(const aRoot: INodeBase;
     const aRootToKeep: INodeBase;
     const aMenuSectionItemToKeep: ISectionItem): InsRubricatorTree; reintroduce;
     {* Сигнатура фабрики TnsRubricatorList.Make }
 end;//TnsRubricatorList
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsRubricatorCache,
  nsNodes
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  l3Tree_TLB,
  nsTypes,
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsRubricatorList

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
end;

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
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_FrozenRoot := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_RootToKeep := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_MenuSectionItemToKeep := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TnsRubricatorList.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.
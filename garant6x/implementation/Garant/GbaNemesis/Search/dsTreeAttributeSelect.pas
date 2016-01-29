unit dsTreeAttributeSelect;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/dsTreeAttributeSelect.pas"
// Начат: 2005/07/29 15:27:38
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Базовые определения предметной области::SearchLite::Search::Search::TdsTreeAttributeSelect
//
// бизнес объект формы выбранные атрибуты дерева
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  SearchInterfaces,
  L10nInterfaces,
  SearchDomainInterfaces,
  l3InternalInterfaces,
  l3TreeInterfaces,
  bsInterfaces
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  TreeInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList,
  vcmControllers {a}
  ;

type
 _FormDataSourceType_ = IdsTreeAttributeSelect;
 {$Include ..\Search\dsSituation.imp.pas}
 TdsTreeAttributeSelect = {vac} class(_dsSituation_, IdsTreeAttributeSelect)
  {* бизнес объект формы выбранные атрибуты дерева }
 private
 // private fields
   SelectedAttributes : IbsSelectedAttributes;
   f_CaptionMap : InsStringValueMap;
 protected

  procedure InitRefs(const aDS: IvcmUseCaseController); override;
  procedure ClearRefs; override;
 protected
 // realized methods
   function MakeSimpleTree: Il3SimpleTree; override;
     {* Создать данные дерева }
   function pm_GetRefreshValues: InsSelectedAttributesIterators;
 public
 // realized methods
   procedure UpdateSelectedAttributes;
     {* обновить данные в форме выбранных атрибутов }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCM)}
   function MakeDisplayName: IvcmCString; override;
   {$IfEnd} //not NoVCM
 end;//TdsTreeAttributeSelect

implementation

uses
  SysUtils,
  l3String
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  DynamicTreeUnit
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  nsLogicOperationToFlags,
  nsConst,
  nsAttributeTreeStruct,
  nsValueMaps,
  nsValueMapsIDs,
  nsSelectedAttributesIterators,
  bsUtils,
  l3Base,
  vtUtils,
  vtStdRes,
  nsNewCachableNode,
  Windows,
  l3InterfacesMisc
  ;

type _Instance_R_ = TdsTreeAttributeSelect;

{$Include ..\Search\dsSituation.imp.pas}

// start class TdsTreeAttributeSelect

function TdsTreeAttributeSelect.MakeSimpleTree: Il3SimpleTree;
//#UC START# *47F4C2B9014A_492437620004_var*
var
 lRoot : INodeBase;
//#UC END# *47F4C2B9014A_492437620004_var*
begin
//#UC START# *47F4C2B9014A_492437620004_impl*
 Result := TnsAttributeTreeStruct.Make(PartData.Tag,
                                       False);
 // View от дерева возвращается с установленными флагами, что не должно быть.
 // Это ошибка, поэтому пока очищаем флаги после получения SimpleTree.
 if Assigned(Result) and Supports(Result.RootNode, INodeBase, lRoot) then
 try
  DropAllOperations(lRoot);
 finally
  lRoot := nil;
 end;
//#UC END# *47F4C2B9014A_492437620004_impl*
end;//TdsTreeAttributeSelect.MakeSimpleTree

function TdsTreeAttributeSelect.pm_GetRefreshValues: InsSelectedAttributesIterators;
//#UC START# *4924354D01CC_492437620004get_var*
var
 l_Root : INodeBase;
//#UC END# *4924354D01CC_492437620004get_var*
begin
//#UC START# *4924354D01CC_492437620004get_impl*
 Result := nil;
 Supports(pm_GetSimpleTree.RootNode, INodeBase, l_Root);

 if Assigned(l_Root) then
  Result := TnsSelectedAttributesIterators.Make(GetOperationIterator(l_Root, loOr),
              GetOperationIterator(l_Root, loAnd), GetOperationIterator(l_Root, loNot));
//#UC END# *4924354D01CC_492437620004get_impl*
end;//TdsTreeAttributeSelect.pm_GetRefreshValues

procedure TdsTreeAttributeSelect.UpdateSelectedAttributes;
//#UC START# *4959149300F9_492437620004_var*
//#UC END# *4959149300F9_492437620004_var*
begin
//#UC START# *4959149300F9_492437620004_impl*
 if (SelectedAttributes <> nil) then
  SelectedAttributes.UpdateSelectedAttributes;
//#UC END# *4959149300F9_492437620004_impl*
end;//TdsTreeAttributeSelect.UpdateSelectedAttributes

procedure TdsTreeAttributeSelect.Cleanup;
//#UC START# *479731C50290_492437620004_var*
//#UC END# *479731C50290_492437620004_var*
begin
//#UC START# *479731C50290_492437620004_impl*
 f_CaptionMap := nil;
 inherited;
//#UC END# *479731C50290_492437620004_impl*
end;//TdsTreeAttributeSelect.Cleanup

{$If not defined(NoVCM)}
function TdsTreeAttributeSelect.MakeDisplayName: IvcmCString;
//#UC START# *491476B001D3_492437620004_var*
//#UC END# *491476B001D3_492437620004_var*
begin
//#UC START# *491476B001D3_492437620004_impl*
 if (l3Same(PartData.Tag, AT_KW)) or
    (l3Same(PartData.Tag, AT_PUBLISH_SOURCE)) then
 begin
  if (f_CaptionMap = nil) then
   f_CaptionMap := nsStringMapManager.Map[smap_ContextParamsCaptions];
  Result := f_CaptionMap.ValueToDisplayName(PartData.Tag);
 end//l3Same(PartData.Tag, AT_KW)..
 else
  Result := inherited MakeDisplayName;
//#UC END# *491476B001D3_492437620004_impl*
end;//TdsTreeAttributeSelect.MakeDisplayName
{$IfEnd} //not NoVCM

procedure TdsTreeAttributeSelect.InitRefs(const aDS: IvcmUseCaseController);
begin
 inherited;
 Supports(aDS, IbsSelectedAttributes, SelectedAttributes);
end;

procedure TdsTreeAttributeSelect.ClearRefs;
begin
 inherited;
 SelectedAttributes := nil;
end;

end.
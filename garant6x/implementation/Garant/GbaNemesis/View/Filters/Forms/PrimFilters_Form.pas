unit PrimFilters_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Filters/Forms/PrimFilters_Form.pas"
// Начат: 26.01.2009 17:49
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Основные прецеденты::Filters::View::Filters::PrimFilters
//
// Фильтры
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
  FiltersUnit,
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3TreeInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  ActiveX,
  l3Tree_TLB,
  l3ControlsTypes,
  eeInterfaces,
  SimpleListInterfaces,
  eeTreeViewExport,
  l3ProtoObject,
  Base_Operations_Strange_Controls,
  Base_Operations_Editions_Controls
  {$If not defined(NoVCL)}
  ,
  ImgList
  {$IfEnd} //not NoVCL
  ,
  Search_Strange_Controls,
  l3StringIDEx,
  vtOutlinerWithDragDrop,
  Filters_Strange_Controls,
  vtLister,
  nsIFilterFromQueryList,
  vtOutliner,
  nscTreeViewWithAdapterDragDrop
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  FiltersUserTypes_utFilters_UserType,
  vcmEntityForm {a}
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  nsTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 InsSelectedFiltersState = interface(IUnknown)
   ['{71A14889-6D58-434C-BE3C-0D014150A6E2}']
   function pm_GetCount: Integer;
   function Get_Filter(anIndex: Integer): IFilterFromQuery;
   property Count: Integer
     read pm_GetCount;
   property Filter[anIndex: Integer]: IFilterFromQuery
     read Get_Filter;
 end;//InsSelectedFiltersState

 TnsSelectedFiltersState = class(Tl3ProtoObject {$If not defined(NoVCM)}, IvcmBase{$IfEnd} //not NoVCM
 , InsSelectedFiltersState)
 private
 // private fields
   f_List : TnsIFilterFromQueryList;
 protected
 // realized methods
   function pm_GetCount: Integer;
   function Get_Filter(anIndex: Integer): IFilterFromQuery;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aTree: IeeTree); reintroduce;
   class function Make(const aTree: IeeTree): IvcmBase;
 end;//TnsSelectedFiltersState

 _FiltersUserTypes_Parent_ = TvcmEntityForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\FiltersUserTypes.imp.pas}
 TPrimFiltersForm = {form} class(_FiltersUserTypes_)
  {* Фильтры }
 private
 // private fields
   f_LockSelectionChangedEvent : Boolean;
   f_FiltersLoaded : Boolean;
   f_FiltersList : TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства FiltersList}
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
  procedure InitEntities; override;
  procedure MakeControls; override;
 protected
 // realized methods
   function Loadable_Load_Execute(const aNode: IeeNode;
    const aData: IUnknown;
    anOp: TListLogicOperation = LLO_NONE): Boolean;
     {* Коллеги, кто может описать этот метод? }
   procedure Loadable_Load(const aParams: IvcmExecuteParams);
     {* Коллеги, кто может описать этот метод? }
   procedure Filter_ActivateNode_Execute(const aNode: Il3Node);
   procedure Filter_ActivateNode(const aParams: IvcmExecuteParams);
   function Filters_GetSelected_Execute: IFiltersFromQuery;
   procedure Filters_GetSelected(const aParams: IvcmExecuteParams);
   procedure List_SetNewContent_Execute;
   procedure List_SetNewContent(const aParams: IvcmExecuteParams);
   procedure Filters_DeselectAll_Execute;
   procedure Filters_DeselectAll(const aParams: IvcmExecuteParams);
   procedure Filter_Activate_Test(const aParams: IvcmTestParamsPrim);
     {* Применить фильтр }
   procedure Filter_Activate_GetState(var State: TvcmOperationStateIndex);
     {* Применить фильтр }
   procedure Filter_Activate_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Применить фильтр }
   procedure Filter_CreateFilter_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Добавить фильтр из сохраненных запросов }
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
     {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function DoSaveState(out theState: IvcmBase;
    aStateType: TvcmStateType;
    aForClone: Boolean): Boolean; override;
     {* Сохраняет состояние формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function DoLoadState(const aState: IvcmBase;
    aStateType: TvcmStateType): Boolean; override;
     {* Загружает состояние формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 protected
 // protected fields
   Filters : IdsFilters;
    {* Фильтры}
 protected
 // protected methods
   procedure FiltersListSelectChange(Sender: TObject;
     Index: LongInt;
     var SelectedState: Integer);
     {* event to notify of a selection change }
   procedure FiltersListGetItemPickImage(Sender: TObject;
     Index: LongInt;
     var aImages: TCustomImageList;
     var aImageIndex: Integer);
     {* event to get Index of Bitmap in ImageIndex }
   function FiltersListGetItemImage(Sender: TObject;
     Index: Integer;
     var aImages: TCustomImageList): Integer;
     {* Event to get Index of Bitmap in ImageIndex. }
   procedure FiltersListActionElement(Sender: TObject;
     Index: LongInt);
   procedure FiltersListRootChanged(aSender: TObject;
     const anOldRoot: IeeNode;
     const aNewRoot: IeeNode);
   procedure FiltersListGetItemFont(Sender: TObject;
     Index: LongInt;
     const aFont: Il3Font);
     {* event to get Font of the item cell
событие для получения шрифта элемента. }
   procedure FiltersListCanBeginDrag(const aNode: Il3SimpleNode;
     var aOkEffect: LongInt);
   function FiltersListCanAcceptData(const aData: IDataObject): Boolean;
   function FiltersListDoDrop(const aData: Il3SimpleNode;
     aWantMenu: Boolean;
     var dwEffect: LongInt): Boolean;
   procedure StartDeselectAll;
     {* Сигнатура метода StartDeselectAll }
   procedure FinishDeselectAll;
     {* Сигнатура метода FinishDeselectAll }
   procedure ChangeActiveStatus(aTreeView: TvtCustomOutliner;
     var aNode: Il3Node;
     aNewStatus: Boolean);
   function GetItemImage(const aNode: IeeNode): Integer;
   procedure SetActiveFilter(const aNode: IeeNode);
   procedure SetActiveFilters;
     {* Сигнатура метода SetActiveFilters }
   procedure ClearFilters;
     {* Сигнатура метода ClearFilters }
   procedure DeselectAll;
     {* Сигнатура метода DeselectAll }
 public
 // public properties
   property FiltersList: TnscTreeViewWithAdapterDragDrop
     read f_FiltersList;
 end;//TPrimFiltersForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SearchUnit,
  BaseTreeSupportUnit,
  FoldersDomainInterfaces,
  BaseTypesUnit,
  DataAdapter,
  nsFolderFilterInfo
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  SysUtils,
  Classes
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  nsFiltersInterfaces,
  SearchRes,
  Graphics,
  FoldersRes,
  DocumentAndListInterfaces,
  nsFiltersTree,
  nsTreeUtils,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\FiltersUserTypes.imp.pas}

var
   { Локализуемые строки Local }
  str_CreateFilter : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CreateFilter'; rValue : 'Создать фильтр...');
   { 'Создать фильтр...' }

// start class TPrimFiltersForm

procedure TPrimFiltersForm.FiltersListSelectChange(Sender: TObject;
  Index: LongInt;
  var SelectedState: Integer);
//#UC START# *51BB121B037C_497DCC17001C_var*
var
 l_CurNode: IeeNode;
 l_FiltersNode: InsFilterNode;
//#UC END# *51BB121B037C_497DCC17001C_var*
begin
//#UC START# *51BB121B037C_497DCC17001C_impl*
 if not (f_FiltersLoaded) then
  SelectedState := -1
 else
 begin
  l_CurNode := FiltersList.TreeView.GetNode(Index);
  if Supports(l_CurNode, InsFilterNode, l_FiltersNode) then
   try
    if not f_LockSelectionChangedEvent then
     if SelectedState = 1 then
     begin
      if not (not l_FiltersNode.DeletedStatus and
         op_Filterable_Add.Call(Aggregate, l_CurNode As IFilterFromQuery)) then
       SelectedState := -1; // не надо менять состояние, т.к. фильтр не применился
     end
     else
     begin
      if not op_Filterable_Delete.Call(Aggregate,  l_CurNode As IFilterFromQuery) then
      begin
       if Ask(qr_EmptyListFiltersChanged) then
        ClearFilters
       else
        SelectedState := -1; // не надо менять состояние, т.к. фильтр не снялся
      end;  
     end;
  finally
   l_FiltersNode := nil;
  end;
 end;
//#UC END# *51BB121B037C_497DCC17001C_impl*
end;//TPrimFiltersForm.FiltersListSelectChange

procedure TPrimFiltersForm.FiltersListGetItemPickImage(Sender: TObject;
  Index: LongInt;
  var aImages: TCustomImageList;
  var aImageIndex: Integer);
//#UC START# *51BB122A0185_497DCC17001C_var*
//#UC END# *51BB122A0185_497DCC17001C_var*
begin
//#UC START# *51BB122A0185_497DCC17001C_impl*
 if (Index < 0) then
  Exit;
 aImages := nsSearchRes.SearchItemsImageList;
 if FiltersList.Selected[Index] then
  aImageIndex := siilSelected
 else
  aImageIndex := siilDeselected;
//#UC END# *51BB122A0185_497DCC17001C_impl*
end;//TPrimFiltersForm.FiltersListGetItemPickImage

function TPrimFiltersForm.FiltersListGetItemImage(Sender: TObject;
  Index: Integer;
  var aImages: TCustomImageList): Integer;
//#UC START# *51BB123402EB_497DCC17001C_var*
var
 l_CurNode: IeeNode;
//#UC END# *51BB123402EB_497DCC17001C_var*
begin
//#UC START# *51BB123402EB_497DCC17001C_impl*
 l_CurNode := FiltersList.TreeView.GetNode(Index);
 try
  Result := GetItemImage(l_CurNode);
 finally
  l_CurNode := nil;
 end;
//#UC END# *51BB123402EB_497DCC17001C_impl*
end;//TPrimFiltersForm.FiltersListGetItemImage

procedure TPrimFiltersForm.FiltersListActionElement(Sender: TObject;
  Index: LongInt);
//#UC START# *51BB123D03D4_497DCC17001C_var*
//#UC END# *51BB123D03D4_497DCC17001C_var*
begin
//#UC START# *51BB123D03D4_497DCC17001C_impl*
 FiltersList.SelectState[FiltersList.Current] := -1;
//#UC END# *51BB123D03D4_497DCC17001C_impl*
end;//TPrimFiltersForm.FiltersListActionElement

procedure TPrimFiltersForm.FiltersListRootChanged(aSender: TObject;
  const anOldRoot: IeeNode;
  const aNewRoot: IeeNode);
//#UC START# *51BB1245036A_497DCC17001C_var*
//#UC END# *51BB1245036A_497DCC17001C_var*
begin
//#UC START# *51BB1245036A_497DCC17001C_impl*
 // Отключаем залечку для дальнейших разборок с K-122653398
 if (aNewRoot = nil) {or VCMClosing} then
  Exit;
 if (not FiltersList.PickedList) then
 begin
  FiltersList.PickedList := True;
  f_FiltersLoaded := True;
 end;//if (not FiltersList.PickedList) then
// if not Dispatcher.History.InBF then
//  SetActiveFilters;
//#UC END# *51BB1245036A_497DCC17001C_impl*
end;//TPrimFiltersForm.FiltersListRootChanged

procedure TPrimFiltersForm.FiltersListGetItemFont(Sender: TObject;
  Index: LongInt;
  const aFont: Il3Font);
//#UC START# *51BB124D036F_497DCC17001C_var*
var
 l_Filter: InsFilterNode;
//#UC END# *51BB124D036F_497DCC17001C_var*
begin
//#UC START# *51BB124D036F_497DCC17001C_impl*
 if Supports(FiltersList.GetNode(Index), InsFilterNode, l_Filter) then
 begin
  if l_Filter.AutoApplied then
   with aFont do
    Style := Style + [fsBold]
 end
 else
  Assert(False);
//#UC END# *51BB124D036F_497DCC17001C_impl*
end;//TPrimFiltersForm.FiltersListGetItemFont

procedure TPrimFiltersForm.FiltersListCanBeginDrag(const aNode: Il3SimpleNode;
  var aOkEffect: LongInt);
//#UC START# *51BB12570242_497DCC17001C_var*
//#UC END# *51BB12570242_497DCC17001C_var*
begin
//#UC START# *51BB12570242_497DCC17001C_impl*
 aOkEffect := DROPEFFECT_NONE;
//#UC END# *51BB12570242_497DCC17001C_impl*
end;//TPrimFiltersForm.FiltersListCanBeginDrag

function TPrimFiltersForm.FiltersListCanAcceptData(const aData: IDataObject): Boolean;
//#UC START# *51BB126703C9_497DCC17001C_var*
//#UC END# *51BB126703C9_497DCC17001C_var*
begin
//#UC START# *51BB126703C9_497DCC17001C_impl*
 Result := False;
//#UC END# *51BB126703C9_497DCC17001C_impl*
end;//TPrimFiltersForm.FiltersListCanAcceptData

function TPrimFiltersForm.FiltersListDoDrop(const aData: Il3SimpleNode;
  aWantMenu: Boolean;
  var dwEffect: LongInt): Boolean;
//#UC START# *51BB1270027A_497DCC17001C_var*
//#UC END# *51BB1270027A_497DCC17001C_var*
begin
//#UC START# *51BB1270027A_497DCC17001C_impl*
 Result := False;
//#UC END# *51BB1270027A_497DCC17001C_impl*
end;//TPrimFiltersForm.FiltersListDoDrop

procedure TPrimFiltersForm.StartDeselectAll;
//#UC START# *51BB29800136_497DCC17001C_var*
//#UC END# *51BB29800136_497DCC17001C_var*
begin
//#UC START# *51BB29800136_497DCC17001C_impl*
 f_LockSelectionChangedEvent := True;
//#UC END# *51BB29800136_497DCC17001C_impl*
end;//TPrimFiltersForm.StartDeselectAll

procedure TPrimFiltersForm.FinishDeselectAll;
//#UC START# *51BB2993020C_497DCC17001C_var*
//#UC END# *51BB2993020C_497DCC17001C_var*
begin
//#UC START# *51BB2993020C_497DCC17001C_impl*
 f_LockSelectionChangedEvent := False;
//#UC END# *51BB2993020C_497DCC17001C_impl*
end;//TPrimFiltersForm.FinishDeselectAll

procedure TPrimFiltersForm.ChangeActiveStatus(aTreeView: TvtCustomOutliner;
  var aNode: Il3Node;
  aNewStatus: Boolean);
//#UC START# *51BB2A2E0234_497DCC17001C_var*
var
 l_FiltersNode: InsFilterNode;
//#UC END# *51BB2A2E0234_497DCC17001C_var*
begin
//#UC START# *51BB2A2E0234_497DCC17001C_impl*
 with aTreeView do
  if (aNewStatus <> (CTree.NodeFlags[aNode] and nfSelected > 0)) and
     Supports(aNode, InsFilterNode, l_FiltersNode) then
   try
    if aNewStatus then
    begin
     if not l_FiltersNode.DeletedStatus and
        op_Filterable_Add.Call(Aggregate, aNode As IFilterFromQuery) then
     begin
      CTree.SetFlagMask(aNode, nfSelected, sbSelect);
     end;
    end
    else
    begin
     if op_Filterable_Delete.Call(Aggregate, aNode As IFilterFromQuery) then
     begin
      if l_FiltersNode.DeletedStatus and
         not l_FiltersNode.UsedStatus then
       aNode := nil
      else
       if CTree.GetAbsIndex(aNode) >= 0 then // нода уже может быть удалена http://mdp.garant.ru/x/4hYQGw
        CTree.SetFlagMask(aNode, nfSelected, sbDeselect);
     end
     else
      if Ask(qr_EmptyListFiltersChanged) then
       ClearFilters;
    end;
  finally
   l_FiltersNode := nil;
  end;
//#UC END# *51BB2A2E0234_497DCC17001C_impl*
end;//TPrimFiltersForm.ChangeActiveStatus

function TPrimFiltersForm.GetItemImage(const aNode: IeeNode): Integer;
//#UC START# *51BB2A5A028D_497DCC17001C_var*
var
 l_FiltersNode: InsFilterNode;
//#UC END# *51BB2A5A028D_497DCC17001C_var*
begin
//#UC START# *51BB2A5A028D_497DCC17001C_impl*
 Result := -1;
 if Supports(aNode, InsFilterNode, l_FiltersNode) then
  try
   if l_FiltersNode.DeletedStatus then
    Result := DeletedFilterIcon
   else
    if l_FiltersNode.AutoApplied then
     Result := PermanentFilter
    else
     Result := FilterIcon;
  finally
   l_FiltersNode := nil;
  end
 else
  Result := FilterIcon;
//#UC END# *51BB2A5A028D_497DCC17001C_impl*
end;//TPrimFiltersForm.GetItemImage

procedure TPrimFiltersForm.SetActiveFilter(const aNode: IeeNode);
//#UC START# *51BB2A9003A0_497DCC17001C_var*
var
 l_FiltersNode: InsFilterNode;
//#UC END# *51BB2A9003A0_497DCC17001C_var*
begin
//#UC START# *51BB2A9003A0_497DCC17001C_impl*
 with FiltersList.TreeView do
  if (NodeFlags[aNode] and nfSelected = 0) and
     Supports(aNode, InsFilterNode, l_FiltersNode) then
   try
    //if not l_FiltersNode.DeletedStatus then k454039266
    begin
     Tree.SetFlagMask(aNode, nfSelected, ee_sbSelect);
    end;
  finally
   l_FiltersNode := nil;
  end;
//#UC END# *51BB2A9003A0_497DCC17001C_impl*
end;//TPrimFiltersForm.SetActiveFilter

procedure TPrimFiltersForm.SetActiveFilters;
//#UC START# *51BB2B0C00F5_497DCC17001C_var*
var
 l_List: IdsList;
//#UC END# *51BB2B0C00F5_497DCC17001C_var*
begin
//#UC START# *51BB2B0C00F5_497DCC17001C_impl*
 if (Aggregate <> nil) and not VCMClosing then
 begin
  l_List := op_List_GetDsList.Call(Aggregate);
  FiltersList.TreeStruct := TnsFiltersTree.Make(Op_Filterable_GetListType.Call(Aggregate), l_List);
 end;
//#UC END# *51BB2B0C00F5_497DCC17001C_impl*
end;//TPrimFiltersForm.SetActiveFilters

procedure TPrimFiltersForm.ClearFilters;
//#UC START# *51BB2B1801BE_497DCC17001C_var*
//#UC END# *51BB2B1801BE_497DCC17001C_var*
begin
//#UC START# *51BB2B1801BE_497DCC17001C_impl*
 if (FiltersList.TreeView.Tree.SelectedCount <= 0) then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=259892768
 // - иначе падали при отмене фильтров из баллона
  Exit;
 Assert((FiltersList.TreeView.Tree.SelectedCount > 0));
 DeselectAll;
 op_Filterable_ClearAll.Call(Aggregate);
//#UC END# *51BB2B1801BE_497DCC17001C_impl*
end;//TPrimFiltersForm.ClearFilters

procedure TPrimFiltersForm.DeselectAll;
//#UC START# *51BB3A14022C_497DCC17001C_var*
//#UC END# *51BB3A14022C_497DCC17001C_var*
begin
//#UC START# *51BB3A14022C_497DCC17001C_impl*
 StartDeselectAll;
 try
  DeselectAllNodesInTree(FiltersList.TreeView.Tree);
 finally
  FinishDeselectAll;
 end;
//#UC END# *51BB3A14022C_497DCC17001C_impl*
end;//TPrimFiltersForm.DeselectAll
// start class TnsSelectedFiltersState

constructor TnsSelectedFiltersState.Create(const aTree: IeeTree);
//#UC START# *51BB44F901EC_4D0B4E06037B_var*
var
 l_Node: IeeNode;
 l_SelectedCount: Integer;
 l_Filter: IFilterFromQuery;
 I: Integer;
//#UC END# *51BB44F901EC_4D0B4E06037B_var*
begin
//#UC START# *51BB44F901EC_4D0B4E06037B_impl*
 inherited Create;
 f_List := TnsIFilterFromQueryList.Make;
 with aTree do
 begin
  l_SelectedCount := SelectedCount;
  if (l_SelectedCount > 0) then
  begin
   l_Node := GetNextSelected(Root);
   I := 0;
   repeat
    if Supports(l_Node, IFilterFromQuery, l_Filter) then
     try
      f_List.Add(l_Filter);
     finally
      l_Filter := nil;
     end;//try..finally
    Inc(I);
    if I < l_SelectedCount then
     l_Node := GetNextSelected(l_Node)
    else
     l_Node := nil;
   until (I = l_SelectedCount);
  end;//l_SelectedCount > 0
 end;//with aTree
//#UC END# *51BB44F901EC_4D0B4E06037B_impl*
end;//TnsSelectedFiltersState.Create

class function TnsSelectedFiltersState.Make(const aTree: IeeTree): IvcmBase;
//#UC START# *51BB4B2502A9_4D0B4E06037B_var*
var
 l_State: TnsSelectedFiltersState;
//#UC END# *51BB4B2502A9_4D0B4E06037B_var*
begin
//#UC START# *51BB4B2502A9_4D0B4E06037B_impl*
 l_State := Create(aTree);
 try
  Result := l_State;
 finally
  FreeAndNil(l_State);
 end;
//#UC END# *51BB4B2502A9_4D0B4E06037B_impl*
end;//TnsSelectedFiltersState.Make

function TnsSelectedFiltersState.pm_GetCount: Integer;
//#UC START# *51BB45A5037C_4D0B4E06037Bget_var*
//#UC END# *51BB45A5037C_4D0B4E06037Bget_var*
begin
//#UC START# *51BB45A5037C_4D0B4E06037Bget_impl*
 Result := f_List.Count
//#UC END# *51BB45A5037C_4D0B4E06037Bget_impl*
end;//TnsSelectedFiltersState.pm_GetCount

function TnsSelectedFiltersState.Get_Filter(anIndex: Integer): IFilterFromQuery;
//#UC START# *51BB45D703AF_4D0B4E06037Bget_var*
//#UC END# *51BB45D703AF_4D0B4E06037Bget_var*
begin
//#UC START# *51BB45D703AF_4D0B4E06037Bget_impl*
 Result := f_List.Items[anIndex];
//#UC END# *51BB45D703AF_4D0B4E06037Bget_impl*
end;//TnsSelectedFiltersState.Get_Filter

procedure TnsSelectedFiltersState.Cleanup;
//#UC START# *479731C50290_4D0B4E06037B_var*
//#UC END# *479731C50290_4D0B4E06037B_var*
begin
//#UC START# *479731C50290_4D0B4E06037B_impl*
 FreeAndNil(f_List);
 inherited;
//#UC END# *479731C50290_4D0B4E06037B_impl*
end;//TnsSelectedFiltersState.Cleanup

function TPrimFiltersForm.Loadable_Load_Execute(const aNode: IeeNode;
  const aData: IUnknown;
  anOp: TListLogicOperation = LLO_NONE): Boolean;
//#UC START# *49895A2102E8_497DCC17001Cexec_var*
var
 l_Node: INode;

 l_BaseEntity: IUnknown;
 l_Query: IQuery;

 //l_FoldersNode: InsFoldersNode;
//#UC END# *49895A2102E8_497DCC17001Cexec_var*
begin
//#UC START# *49895A2102E8_497DCC17001Cexec_impl*
 //Assert(False);
 Result := true;
 if Supports(aNode, INode, l_Node) then
  try
   l_Node.Open(l_BaseEntity);
   try
    if Supports(l_BaseEntity, IQuery, l_Query) then
     try
      Result := (TdmStdRes.CreateFilter(l_Query) = mrOk);
(*      if (l_Query.GetFilterType <> FT_NO_FILTER) then
      begin
       Say(msg_QueryIsAlreadyFilterError);
       Result := false;
      end//l_Query.GetFilterType <> FT_NO_FILTER
      else
      begin
       if Supports(aNode, InsFoldersNode, l_FoldersNode) then
        try
         try
          l_FoldersNode.SetFilterStatus(FT_REGULAR);
         except
          on EAccessDenied do
          begin
           Say(err_CanNotEditQuery);
           Result := false;
          end;//on EAccessDenied
         end;//try..except
        finally
         l_FoldersNode := nil;
        end;//try..finally
      end;*)
     finally
      l_Query := nil;
     end;//try..finally
   finally
    l_BaseEntity := nil;
   end;//try..finally
  finally
   l_Node := nil;
  end;//try..finally
//#UC END# *49895A2102E8_497DCC17001Cexec_impl*
end;//TPrimFiltersForm.Loadable_Load_Execute

procedure TPrimFiltersForm.Loadable_Load(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As ILoadable_Load_Params) do
  ResultValue := Loadable_Load_Execute(Node, Data, nOp);
end;

procedure TPrimFiltersForm.Filter_ActivateNode_Execute(const aNode: Il3Node);
//#UC START# *4AEECBA3030B_497DCC17001Cexec_var*
var
 l_Node: Il3Node;
//#UC END# *4AEECBA3030B_497DCC17001Cexec_var*
begin
//#UC START# *4AEECBA3030B_497DCC17001Cexec_impl*
 l_Node := aNode;
 ChangeActiveStatus(FiltersList, l_Node,
                    (FiltersList.CTree.NodeFlags[l_Node] and nfSelected = 0));
//#UC END# *4AEECBA3030B_497DCC17001Cexec_impl*
end;//TPrimFiltersForm.Filter_ActivateNode_Execute

procedure TPrimFiltersForm.Filter_ActivateNode(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IFilter_ActivateNode_Params) do
  Filter_ActivateNode_Execute(Node);
end;

function TPrimFiltersForm.Filters_GetSelected_Execute: IFiltersFromQuery;
//#UC START# *4AF2B1AC02F8_497DCC17001Cexec_var*
var
 l_Tree: IeeTree;
 l_Node: IeeNode;
 l_Filter: IFilterFromQuery;
 l_FiltersIntf: IFiltersFromQuery;
//#UC END# *4AF2B1AC02F8_497DCC17001Cexec_var*
begin
//#UC START# *4AF2B1AC02F8_497DCC17001Cexec_impl*
 l_Tree := FiltersList.TreeView.Tree;
 l_FiltersIntf := defDataAdapter.NativeAdapter.MakeFiltersFromQuery;
 Result := l_FiltersIntf;
 l_Node := l_Tree.GetNextSelected(l_Tree.Root);
 while Assigned(l_Node) do
  if Supports(l_Node, IFilterFromQuery, l_Filter) then
  try
   l_FiltersIntf.Add(l_Filter);
   l_Node := l_Tree.GetNextSelected(l_Node);
  finally
   l_Filter := nil;
  end;
//#UC END# *4AF2B1AC02F8_497DCC17001Cexec_impl*
end;//TPrimFiltersForm.Filters_GetSelected_Execute

procedure TPrimFiltersForm.Filters_GetSelected(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IFilters_GetSelected_Params) do
  ResultValue := Filters_GetSelected_Execute;
end;

procedure TPrimFiltersForm.List_SetNewContent_Execute;
//#UC START# *4AF81DE902B6_497DCC17001Cexec_var*
//#UC END# *4AF81DE902B6_497DCC17001Cexec_var*
begin
//#UC START# *4AF81DE902B6_497DCC17001Cexec_impl*
 SetActiveFilters;
//#UC END# *4AF81DE902B6_497DCC17001Cexec_impl*
end;//TPrimFiltersForm.List_SetNewContent_Execute

procedure TPrimFiltersForm.List_SetNewContent(const aParams: IvcmExecuteParams);
begin
 List_SetNewContent_Execute;
end;

procedure TPrimFiltersForm.Filters_DeselectAll_Execute;
//#UC START# *4AF8598C0277_497DCC17001Cexec_var*
//#UC END# *4AF8598C0277_497DCC17001Cexec_var*
begin
//#UC START# *4AF8598C0277_497DCC17001Cexec_impl*
 DeselectAll;
//#UC END# *4AF8598C0277_497DCC17001Cexec_impl*
end;//TPrimFiltersForm.Filters_DeselectAll_Execute

procedure TPrimFiltersForm.Filters_DeselectAll(const aParams: IvcmExecuteParams);
begin
 Filters_DeselectAll_Execute;
end;

procedure TPrimFiltersForm.Filter_Activate_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7D3A81021B_497DCC17001Ctest_var*
//#UC END# *4C7D3A81021B_497DCC17001Ctest_var*
begin
//#UC START# *4C7D3A81021B_497DCC17001Ctest_impl*
 with FiltersList.TreeView do
  aParams.Op.Flag[vcm_ofEnabled] := Tree.Root.HasChild and (CurrentNode <> nil);
//#UC END# *4C7D3A81021B_497DCC17001Ctest_impl*
end;//TPrimFiltersForm.Filter_Activate_Test

procedure TPrimFiltersForm.Filter_Activate_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4C7D3A81021B_497DCC17001Cgetstate_var*
var
 l_CurNode: IeeNode;
//#UC END# *4C7D3A81021B_497DCC17001Cgetstate_var*
begin
//#UC START# *4C7D3A81021B_497DCC17001Cgetstate_impl*
 State := vcm_DefaultOperationState;
 with FiltersList.TreeView do
  if Tree.Root.HasChild then
  begin
   l_CurNode := CurrentNode;
   try
    if l_CurNode <> nil then
     if NodeFlags[l_CurNode] and nfSelected <> 0 then
      State := st_user_Filter_Activate_Deactivate;
   finally
    l_CurNode := nil;
   end;
  end;
//#UC END# *4C7D3A81021B_497DCC17001Cgetstate_impl*
end;//TPrimFiltersForm.Filter_Activate_GetState

procedure TPrimFiltersForm.Filter_Activate_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7D3A81021B_497DCC17001Cexec_var*
var
 l_CurNode: Il3Node;
//#UC END# *4C7D3A81021B_497DCC17001Cexec_var*
begin
//#UC START# *4C7D3A81021B_497DCC17001Cexec_impl*
 l_CurNode := FiltersList.CurrentCNode;
 ChangeActiveStatus(FiltersList,
                    l_CurNode,
                    (FiltersList.CTree.NodeFlags[l_CurNode] and nfSelected = 0));
//#UC END# *4C7D3A81021B_497DCC17001Cexec_impl*
end;//TPrimFiltersForm.Filter_Activate_Execute

procedure TPrimFiltersForm.Filter_CreateFilter_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4D0B5FBF0310_497DCC17001Cexec_var*
//#UC END# *4D0B5FBF0310_497DCC17001Cexec_var*
begin
//#UC START# *4D0B5FBF0310_497DCC17001Cexec_impl*
 TdmStdRes.SelectOpen(Self.As_IvcmEntityForm,
                      TnsFolderFilterInfo.Make(ffQuery, ns_ffNone),
                      str_CreateFilter);
//#UC END# *4D0B5FBF0310_497DCC17001Cexec_impl*
end;//TPrimFiltersForm.Filter_CreateFilter_Execute

{$If not defined(NoVCM)}
procedure TPrimFiltersForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
  const aNew: IvcmViewAreaController);
//#UC START# *497469C90140_497DCC17001C_var*
//#UC END# *497469C90140_497DCC17001C_var*
begin
//#UC START# *497469C90140_497DCC17001C_impl*
 if {not aFromHistory and }Assigned(aNew) then
  SetActiveFilters;
//#UC END# *497469C90140_497DCC17001C_impl*
end;//TPrimFiltersForm.NotifyDataSourceChanged
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimFiltersForm.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_497DCC17001C_var*
//#UC END# *49803F5503AA_497DCC17001C_var*
begin
//#UC START# *49803F5503AA_497DCC17001C_impl*
 FiltersList.Images := nsFoldersRes.FoldersItemImages;
//#UC END# *49803F5503AA_497DCC17001C_impl*
end;//TPrimFiltersForm.DoInit
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimFiltersForm.DoSaveState(out theState: IvcmBase;
  aStateType: TvcmStateType;
  aForClone: Boolean): Boolean;
//#UC START# *49806ED503D5_497DCC17001C_var*
//#UC END# *49806ED503D5_497DCC17001C_var*
begin
//#UC START# *49806ED503D5_497DCC17001C_impl*
 Result := False;
 theState := nil;
 if aStateType = vcm_stContent then
 begin
  theState := TnsSelectedFiltersState.Make(FiltersList.TreeView.Tree);
  // http://mdp.garant.ru/pages/viewpage.action?pageId=286623428
  Result := True;
 end;
//#UC END# *49806ED503D5_497DCC17001C_impl*
end;//TPrimFiltersForm.DoSaveState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimFiltersForm.DoLoadState(const aState: IvcmBase;
  aStateType: TvcmStateType): Boolean;
//#UC START# *49807428008C_497DCC17001C_var*
var
 l_State: InsSelectedFiltersState;
 l_Node: IeeNode;
 l_Idx: Integer;
//#UC END# *49807428008C_497DCC17001C_var*
begin
//#UC START# *49807428008C_497DCC17001C_impl*
 if (aStateType = vcm_stContent) then
  if Supports(aState, InsSelectedFiltersState, l_State) then
  begin
   //http://mdp.garant.ru/pages/viewpage.action?pageId=286623428
   SetActiveFilters;
   DeselectAll;
   for l_Idx := 0 to l_State.Count - 1 do
   begin
    l_Node := FindOnFilter(FiltersList.TreeView.Tree.Root,
                           l_State.Filter[l_Idx]);
    if (l_Node <> nil) then
     try
      SetActiveFilter(l_Node);
     finally
      l_Node := nil;
     end;//try..finally
   end;//for l_Idx := 0 to l_State.Count - 1 do
  end//if Supports(aState, InsSelectedFiltersState, l_State) then
  else
   Assert(False);
//#UC END# *49807428008C_497DCC17001C_impl*
end;//TPrimFiltersForm.DoLoadState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimFiltersForm.InitControls;
//#UC START# *4A8E8F2E0195_497DCC17001C_var*
//#UC END# *4A8E8F2E0195_497DCC17001C_var*
begin
//#UC START# *4A8E8F2E0195_497DCC17001C_impl*
 inherited;
 FiltersList.DragAndDropSupported := False;

 Width := 267;
 ActiveControl := FiltersList;
 Scaled := False;

 with FiltersList do
 begin
  Align := alClient;
  BorderStyle := bsNone;
  TabOrder := 0;
  MultiSelect := True;
  OnSelectChange := FiltersListSelectChange;
  OnGetItemPickImage := FiltersListGetItemPickImage;
  OnGetItemImage := FiltersListGetItemImage;
  OnActionElement := FiltersListActionElement;
  OnRootChanged := FiltersListRootChanged;
  OnGetItemFont := FiltersListGetItemFont;
  OnCanBeginDrag := FiltersListCanBeginDrag;
  OnCanAcceptData := FiltersListCanAcceptData;
  OnDoDrop := FiltersListDoDrop;
  DragAndDropSupported := True;
  SettingId := 'stidFiltersList';
 end;
//#UC END# *4A8E8F2E0195_497DCC17001C_impl*
end;//TPrimFiltersForm.InitControls
{$IfEnd} //not NoVCM

procedure TPrimFiltersForm.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  Filters := nil;
 end//aDsNew = nil
 else
 begin
  Supports(aDsNew, IdsFilters, Filters);
 end;//aDsNew = nil
end;

procedure TPrimFiltersForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Loadable, nil);
  PublishFormEntity(en_Filters, nil);
  PublishFormEntity(en_Filter, nil);
  PublishFormEntity(en_List, nil);
  PublishOpWithResult(en_Loadable, op_Load, Loadable_Load, nil, nil);
  PublishOpWithResult(en_Filter, op_ActivateNode, Filter_ActivateNode, nil, nil);
  PublishOpWithResult(en_Filters, op_GetSelected, Filters_GetSelected, nil, nil);
  PublishOpWithResult(en_List, op_SetNewContent, List_SetNewContent, nil, nil);
  PublishOpWithResult(en_Filters, op_DeselectAll, Filters_DeselectAll, nil, nil);
  PublishOp(en_Filter, op_Activate, Filter_Activate_Execute, Filter_Activate_Test, Filter_Activate_GetState);
  PublishOp(en_Filter, op_CreateFilter, Filter_CreateFilter_Execute, nil, nil);
  ShowInContextMenu(en_Filter, op_CreateFilter, true);
  ShowInToolbar(en_Filter, op_CreateFilter, false);
 end;//with Entities.Entities
end;

procedure TPrimFiltersForm.MakeControls;
begin
 inherited;
 f_FiltersList := TnscTreeViewWithAdapterDragDrop.Create(Self);
 f_FiltersList.Name := 'FiltersList';
 f_FiltersList.Parent := Self;
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\FiltersUserTypes.imp.pas}
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_CreateFilter
 str_CreateFilter.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimFilters
 TtfwClassRef.Register(TPrimFiltersForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.
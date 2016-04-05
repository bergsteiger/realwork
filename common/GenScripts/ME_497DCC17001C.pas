unit PrimFilters_Form;
 {* Фильтры }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Forms\PrimFilters_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimFilters" MUID: (497DCC17001C)
// Имя типа: "TPrimFiltersForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Search_Strange_Controls
 , Base_Operations_Strange_Controls
 , Filters_Strange_Controls
 , SimpleListInterfaces
 , nscTreeViewWithAdapterDragDrop
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , eeInterfaces
 , l3Interfaces
 , l3TreeInterfaces
 , ActiveX
 , vtOutliner
 , l3Tree_TLB
 , FiltersUnit
 , nsTypes
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
 , l3ProtoObject
 , nsIFilterFromQueryList
;

type
 TnsSelectedFiltersState = class;

 InsSelectedFiltersState = interface
  ['{71A14889-6D58-434C-BE3C-0D014150A6E2}']
  function pm_GetCount: Integer;
  function Get_Filter(anIndex: Integer): IFilterFromQuery;
  property Count: Integer
   read pm_GetCount;
  property Filter[anIndex: Integer]: IFilterFromQuery
   read Get_Filter;
 end;//InsSelectedFiltersState

 TnsSelectedFiltersState = class(Tl3ProtoObject{$If NOT Defined(NoVCM)}
 , IvcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , InsSelectedFiltersState)
  private
   f_List: TnsIFilterFromQueryList;
  protected
   function pm_GetCount: Integer;
   function Get_Filter(anIndex: Integer): IFilterFromQuery;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aTree: IeeTree); reintroduce;
   class function Make(const aTree: IeeTree): IvcmBase;
 end;//TnsSelectedFiltersState

 _FiltersUserTypes_Parent_ = TvcmEntityForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\FiltersUserTypes.imp.pas}
 TPrimFiltersForm = class(_FiltersUserTypes_)
  {* Фильтры }
  private
   f_LockSelectionChangedEvent: Boolean;
   f_FiltersLoaded: Boolean;
   f_FiltersList: TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства FiltersList }
  protected
   Filters: IdsFilters;
    {* Фильтры }
  protected
   procedure FiltersListSelectChange(Sender: TObject;
    Index: LongInt;
    var SelectedState: Integer);
   procedure FiltersListGetItemPickImage(Sender: TObject;
    Index: LongInt;
    var aImages: TCustomImageList;
    var aImageIndex: Integer);
   function FiltersListGetItemImage(Sender: TObject;
    Index: Integer;
    var aImages: TCustomImageList): Integer;
   procedure FiltersListActionElement(Sender: TObject;
    Index: LongInt);
   procedure FiltersListRootChanged(aSender: TObject;
    const anOldRoot: IeeNode;
    const aNewRoot: IeeNode);
   procedure FiltersListGetItemFont(Sender: TObject;
    Index: LongInt;
    const aFont: Il3Font);
   procedure FiltersListCanBeginDrag(const aNode: Il3SimpleNode;
    var aOkEffect: LongInt);
   function FiltersListCanAcceptData(const aData: IDataObject): Boolean;
   function FiltersListDoDrop(const aData: Il3SimpleNode;
    aWantMenu: Boolean;
    var dwEffect: LongInt): Boolean;
   procedure StartDeselectAll;
   procedure FinishDeselectAll;
   procedure ChangeActiveStatus(aTreeView: TvtCustomOutliner;
    var aNode: Il3Node;
    aNewStatus: Boolean);
   function GetItemImage(const aNode: IeeNode): Integer;
   procedure SetActiveFilter(const aNode: IeeNode);
   procedure SetActiveFilters;
   procedure ClearFilters;
   procedure DeselectAll;
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoSaveState(out theState: IvcmBase;
    aStateType: TvcmStateType;
    aForClone: Boolean): Boolean; override;
    {* Сохраняет состояние формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoLoadState(const aState: IvcmBase;
    aStateType: TvcmStateType): Boolean; override;
    {* Загружает состояние формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function Loadable_Load_Execute(const aNode: IeeNode;
    const aData: IUnknown;
    anOp: TListLogicOperation = nsTypes.LLO_NONE): Boolean;
    {* Коллеги, кто может описать этот метод? }
   procedure Loadable_Load(const aParams: IvcmExecuteParamsPrim);
    {* Коллеги, кто может описать этот метод? }
   procedure Filter_ActivateNode_Execute(const aNode: Il3Node);
   procedure Filter_ActivateNode(const aParams: IvcmExecuteParamsPrim);
   function Filters_GetSelected_Execute: IFiltersFromQuery;
   procedure Filters_GetSelected(const aParams: IvcmExecuteParamsPrim);
   procedure List_SetNewContent_Execute;
   procedure List_SetNewContent(const aParams: IvcmExecuteParamsPrim);
   procedure Filters_DeselectAll_Execute;
   procedure Filters_DeselectAll(const aParams: IvcmExecuteParamsPrim);
   procedure Filter_Activate_Test(const aParams: IvcmTestParamsPrim);
    {* Применить фильтр }
   procedure Filter_Activate_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Применить фильтр }
   procedure Filter_Activate_GetState(var State: TvcmOperationStateIndex);
    {* Применить фильтр }
   procedure Filter_CreateFilter_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Добавить фильтр из сохраненных запросов }
  public
   property FiltersList: TnscTreeViewWithAdapterDragDrop
    read f_FiltersList;
 end;//TPrimFiltersForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SearchUnit
 , BaseTreeSupportUnit
 , FoldersDomainInterfaces
 , BaseTypesUnit
 , DataAdapter
 , nsFolderFilterInfo
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , SysUtils
 , Classes
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , nsFiltersInterfaces
 , SearchRes
 , Graphics
 , FoldersRes
 , DocumentAndListInterfaces
 , nsFiltersTree
 , nsTreeUtils
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
const
 {* Локализуемые строки Local }
 str_CreateFilter: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CreateFilter'; rValue : 'Создать фильтр...');
  {* 'Создать фильтр...' }

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
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4D0B4E06037B_var*
//#UC END# *479731C50290_4D0B4E06037B_var*
begin
//#UC START# *479731C50290_4D0B4E06037B_impl*
 FreeAndNil(f_List);
 inherited;
//#UC END# *479731C50290_4D0B4E06037B_impl*
end;//TnsSelectedFiltersState.Cleanup

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\FiltersUserTypes.imp.pas}

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

function TPrimFiltersForm.Loadable_Load_Execute(const aNode: IeeNode;
 const aData: IUnknown;
 anOp: TListLogicOperation = nsTypes.LLO_NONE): Boolean;
 {* Коллеги, кто может описать этот метод? }
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

procedure TPrimFiltersForm.Loadable_Load(const aParams: IvcmExecuteParamsPrim);
 {* Коллеги, кто может описать этот метод? }
begin
 with (aParams.Data As ILoadable_Load_Params) do
  ResultValue := Self.Loadable_Load_Execute(Node, Data, nOp);
end;//TPrimFiltersForm.Loadable_Load

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

procedure TPrimFiltersForm.Filter_ActivateNode(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As IFilter_ActivateNode_Params) do
  Self.Filter_ActivateNode_Execute(Node);
end;//TPrimFiltersForm.Filter_ActivateNode

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

procedure TPrimFiltersForm.Filters_GetSelected(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As IFilters_GetSelected_Params) do
  ResultValue := Self.Filters_GetSelected_Execute;
end;//TPrimFiltersForm.Filters_GetSelected

procedure TPrimFiltersForm.List_SetNewContent_Execute;
//#UC START# *4AF81DE902B6_497DCC17001Cexec_var*
//#UC END# *4AF81DE902B6_497DCC17001Cexec_var*
begin
//#UC START# *4AF81DE902B6_497DCC17001Cexec_impl*
 SetActiveFilters;
//#UC END# *4AF81DE902B6_497DCC17001Cexec_impl*
end;//TPrimFiltersForm.List_SetNewContent_Execute

procedure TPrimFiltersForm.List_SetNewContent(const aParams: IvcmExecuteParamsPrim);
begin
 Self.List_SetNewContent_Execute;
end;//TPrimFiltersForm.List_SetNewContent

procedure TPrimFiltersForm.Filters_DeselectAll_Execute;
//#UC START# *4AF8598C0277_497DCC17001Cexec_var*
//#UC END# *4AF8598C0277_497DCC17001Cexec_var*
begin
//#UC START# *4AF8598C0277_497DCC17001Cexec_impl*
 DeselectAll;
//#UC END# *4AF8598C0277_497DCC17001Cexec_impl*
end;//TPrimFiltersForm.Filters_DeselectAll_Execute

procedure TPrimFiltersForm.Filters_DeselectAll(const aParams: IvcmExecuteParamsPrim);
begin
 Self.Filters_DeselectAll_Execute;
end;//TPrimFiltersForm.Filters_DeselectAll

procedure TPrimFiltersForm.Filter_Activate_Test(const aParams: IvcmTestParamsPrim);
 {* Применить фильтр }
//#UC START# *4C7D3A81021B_497DCC17001Ctest_var*
//#UC END# *4C7D3A81021B_497DCC17001Ctest_var*
begin
//#UC START# *4C7D3A81021B_497DCC17001Ctest_impl*
 with FiltersList.TreeView do
  aParams.Op.Flag[vcm_ofEnabled] := Tree.Root.HasChild and (CurrentNode <> nil);
//#UC END# *4C7D3A81021B_497DCC17001Ctest_impl*
end;//TPrimFiltersForm.Filter_Activate_Test

procedure TPrimFiltersForm.Filter_Activate_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Применить фильтр }
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

procedure TPrimFiltersForm.Filter_Activate_GetState(var State: TvcmOperationStateIndex);
 {* Применить фильтр }
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

procedure TPrimFiltersForm.Filter_CreateFilter_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Добавить фильтр из сохраненных запросов }
//#UC START# *4D0B5FBF0310_497DCC17001Cexec_var*
//#UC END# *4D0B5FBF0310_497DCC17001Cexec_var*
begin
//#UC START# *4D0B5FBF0310_497DCC17001Cexec_impl*
 TdmStdRes.SelectOpen(Self.As_IvcmEntityForm,
                      TnsFolderFilterInfo.Make(ffQuery, ns_ffNone),
                      str_CreateFilter);
//#UC END# *4D0B5FBF0310_497DCC17001Cexec_impl*
end;//TPrimFiltersForm.Filter_CreateFilter_Execute

procedure TPrimFiltersForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
//#UC START# *497469C90140_497DCC17001C_var*
//#UC END# *497469C90140_497DCC17001C_var*
begin
//#UC START# *497469C90140_497DCC17001C_impl*
 if {not aFromHistory and }Assigned(aNew) then
  SetActiveFilters;
//#UC END# *497469C90140_497DCC17001C_impl*
end;//TPrimFiltersForm.NotifyDataSourceChanged

procedure TPrimFiltersForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_497DCC17001C_var*
//#UC END# *49803F5503AA_497DCC17001C_var*
begin
//#UC START# *49803F5503AA_497DCC17001C_impl*
 FiltersList.Images := nsFoldersRes.FoldersItemImages;
//#UC END# *49803F5503AA_497DCC17001C_impl*
end;//TPrimFiltersForm.DoInit

function TPrimFiltersForm.DoSaveState(out theState: IvcmBase;
 aStateType: TvcmStateType;
 aForClone: Boolean): Boolean;
 {* Сохраняет состояние формы. Для перекрытия в потомках }
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

function TPrimFiltersForm.DoLoadState(const aState: IvcmBase;
 aStateType: TvcmStateType): Boolean;
 {* Загружает состояние формы. Для перекрытия в потомках }
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

procedure TPrimFiltersForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
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

initialization
 str_CreateFilter.Init;
 {* Инициализация str_CreateFilter }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimFiltersForm);
 {* Регистрация PrimFilters }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.

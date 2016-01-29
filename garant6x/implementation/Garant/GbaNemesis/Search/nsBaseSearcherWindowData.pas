unit nsBaseSearcherWindowData;

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3ProtoObject,
  BaseSearchInterfaces,
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
  nsBaseSearchWindowDataListenerList
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsBaseSearcherWindowData = class(Tl3ProtoObject, InsBaseSearcherWindowData)
 private
   f_AssignedState: InsBaseSearcherWindowDataState;
   f_FirstClass: InsBaseSearchClass;
   f_ActiveClass: InsBaseSearchClass;
   f_SavedClass: InsBaseSearchClass;
   f_ClassSaved: Boolean;
   f_ClassSetFromState: Boolean;
   f_InitialContext: Il3CString;
   f_Context: Il3CString;
   f_WindowState: TnsBaseSearchWindowState;
   f_Presentation: Pointer; {InsBaseSearchPresentation}
   f_Container: Pointer;
   f_ExampleText: Il3CString;
   f_ErrorWords: IvcmStrings;
   f_Listeners: TnsBaseSearchWindowDataListenerList;
   f_ChangedElements: TnsBaseSearcherChangeElements;
   f_UpdateCount: Integer;
   f_InUpdate: Boolean;
   procedure CheckValidClasses;
   function pm_GetContextSearcher: InsContextSearcher;
   function pm_GetContainer: IvcmContainer;
   procedure BeginUpdate;
   procedure EndUpdate;
   procedure Changed(aElements: TnsBaseSearcherChangeElements);
   procedure NotifyChanged(aElements: TnsBaseSearcherChangeElements);
 protected
   procedure CleanUp; override;
 protected
   function MakeState: InsBaseSearcherWindowDataState;
   procedure AssignState(const aState: InsBaseSearcherWindowDataState);
   procedure Subscribe(const aListener: InsBaseSearchWindowDataListener);
   procedure Unsubscribe(const aListener: InsBaseSearchWindowDataListener);
   function pm_GetContextKind: TnsBaseSearchKind;
   function pm_GetAvailableClasses: InsBaseSearchClasses;
   function pm_GetClassesAnywayDisabled: Boolean;
   function pm_GetAllowSearchInTitles: Boolean;
   function pm_GetFindEnabled: Boolean;
   function pm_GetContext: Il3CString;
   procedure pm_SetContext(const aValue: Il3CString);
   function pm_GetActiveClass: InsBaseSearchClass;
   procedure pm_SetActiveClass(const aValue: InsBaseSearchClass);
   function pm_GetArea: TnsSearchArea;
   procedure pm_SetArea(aValue: TnsSearchArea);
   function pm_GetExampleText: Il3CString;
   function pm_GetErrorWords: IvcmStrings;
   procedure pm_SetErrorWords(const aValue: IvcmStrings);
   function pm_GetFindBackSupported: Boolean;
   function pm_GetFindBackEnabled: Boolean;
   function pm_GetFragmentsCountSuffix: Il3CString;
   function pm_GetPromptTree: Il3SimpleTree;
   function pm_GetPresentation: InsBaseSearchPresentation;
   procedure pm_SetPresentation(const aPresentation: InsBaseSearchPresentation);
   procedure StoreActiveClass;
   function pm_GetActiveClassForSaveState: InsBaseSearchClass;
   property ContextSearcher: InsContextSearcher
    read pm_GetContextSearcher;
   property Container: IvcmContainer
    read pm_GetContainer;
 public
   procedure RemovePresentation(const aPresentation: InsBaseSearchPresentation);
   function ValidateBaseSearchForm(const aForm: IvcmEntityForm): Boolean;
   constructor Create(const aState: InsBaseSearcherWindowDataState; const aContainer: IvcmContainer);
   class function Make(const aState: InsBaseSearcherWindowDataState; const aContainer: IvcmContainer): InsBaseSearcherWindowData; overload;
   class function Make(const aContainer: IvcmContainer): InsBaseSearcherWindowData; overload;
 end;//TnsBaseSearcherWindowData
{$IfEnd} //not Admin AND not Monitorings

implementation
uses
  SysUtils,

  l3Base,
  l3InterfacesMisc,
  l3String,

  vcmHistoryService,

  nsBaseSearchClasses,
  nsBaseSearchPromptTree,
  nsPromptForDocFilter;

{$If not defined(Admin) AND not defined(Monitorings)}

type
 TnsBaseSearcherWindowDataState = class(Tl3ProtoObject, InsBaseSearcherWindowDataState)
 private
   f_ActiveClass: InsBaseSearchClass;
   f_Context: Il3CString;
   f_WindowState: TnsBaseSearchWindowState;
   constructor Create(const aActiveClass: InsBaseSearchClass;
    const aContext: Il3CString; aWindowState: TnsBaseSearchWindowState);
 protected
   function pm_GetActiveClass: InsBaseSearchClass;
   function pm_GetContext: Il3CString;
   function pm_GetWindowState: TnsBaseSearchWindowState;
 protected
   procedure Cleanup; override;
 public
   class function Make(const aActiveClass: InsBaseSearchClass;
     const aContext: Il3CString; aWindowState: TnsBaseSearchWindowState): InsBaseSearcherWindowDataState;
 end;

{ TnsBaseSearcherWindowDataState }

constructor TnsBaseSearcherWindowDataState.Create(const aActiveClass: InsBaseSearchClass;
 const aContext: Il3CString; aWindowState: TnsBaseSearchWindowState);
begin
 inherited Create;
 f_ActiveClass := aActiveClass;
 f_Context := aContext;
 f_WindowState := aWindowState;
end;

class function TnsBaseSearcherWindowDataState.Make(const aActiveClass: InsBaseSearchClass;
 const aContext: Il3CString; aWindowState: TnsBaseSearchWindowState): InsBaseSearcherWindowDataState;
var
 Inst: TnsBaseSearcherWindowDataState;
begin
 Inst := Create(aActiveClass, aContext, aWindowState);
 try
  Result := Inst;
 finally
  FreeAndNil(Inst);
 end;
end;

function TnsBaseSearcherWindowDataState.pm_GetActiveClass: InsBaseSearchClass;
begin
 Result := f_ActiveClass;
end;

function TnsBaseSearcherWindowDataState.pm_GetContext: Il3CString;
begin
 Result := f_Context;
end;

function TnsBaseSearcherWindowDataState.pm_GetWindowState: TnsBaseSearchWindowState;
begin
 Result := f_WindowState;
end;

procedure TnsBaseSearcherWindowDataState.Cleanup;
begin
 f_ActiveClass := nil;
 f_Context := nil;
 inherited;
end;

{ TnsBaseSearcherWindowData }

procedure TnsBaseSearcherWindowData.CheckValidClasses;
var
 l_Enumerator: InsBaseSearchClassesEnumerator;
begin
 l_Enumerator := TnsBaseSearchClasses.Instance.GetEnumerator;
 if l_Enumerator.MoveNext then
  f_FirstClass := l_Enumerator.Current;
end;

function TnsBaseSearcherWindowData.pm_GetContextSearcher: InsContextSearcher;
begin
 if (f_Presentation = nil) then
  Result := nil
 else
  Result := InsBaseSearchPresentation(f_Presentation).ContextSearcher;
end;

function TnsBaseSearcherWindowData.pm_GetContainer: IvcmContainer;
begin
 Result := IvcmContainer(f_Container);
end;

procedure TnsBaseSearcherWindowData.BeginUpdate;
begin
 Assert(not f_InUpdate);
 f_UpdateCount := 0;
 f_InUpdate := True;
end;

procedure TnsBaseSearcherWindowData.EndUpdate;
begin
 Assert(f_InUpdate);
 if (f_UpdateCount > 0) then
 begin
  NotifyChanged(f_ChangedElements);
  f_ChangedElements := [];
  f_UpdateCount := 0;
  f_InUpdate := False;
 end
end;

procedure TnsBaseSearcherWindowData.NotifyChanged(aElements: TnsBaseSearcherChangeElements);
var
 l_Index: Integer;
begin
 for l_Index := 0 to Pred(f_Listeners.Count) do
  f_Listeners[l_Index].NotifyBaseSearcherDataChanged(aElements); 
end;

procedure TnsBaseSearcherWindowData.Changed(aElements: TnsBaseSearcherChangeElements);
begin
 if f_InUpdate then
 begin
   Inc(f_UpdateCount);
   f_ChangedElements := f_ChangedElements + aElements;
 end
 else
  NotifyChanged(aElements);
end;

procedure TnsBaseSearcherWindowData.CleanUp;
begin
 f_AssignedState := nil;
 f_ActiveClass := nil;
 f_FirstClass := nil;
 f_Context := nil;
 f_Presentation := nil;
 FreeAndNil(f_Listeners); 
 inherited;
end;

function TnsBaseSearcherWindowData.MakeState: InsBaseSearcherWindowDataState;
begin
 Result := TnsBaseSearcherWindowDataState.Make(f_ActiveClass, f_Context,
  f_WindowState);
end;

procedure TnsBaseSearcherWindowData.AssignState(const aState: InsBaseSearcherWindowDataState);
begin
 Assert(aState <> nil);
 BeginUpdate;
 f_AssignedState := aState;
 f_ActiveClass := aState.ActiveClass;
 f_Context := aState.Context;
 f_WindowState := aState.WindowState;
 Changed([ns_ceContext, ns_ceActiveClass, ns_ceSearchArea]);
 EndUpdate;
end;

procedure TnsBaseSearcherWindowData.Subscribe(const aListener: InsBaseSearchWindowDataListener);
begin
 f_Listeners.Add(aListener);
end;

procedure TnsBaseSearcherWindowData.Unsubscribe(const aListener: InsBaseSearchWindowDataListener);
begin
 f_Listeners.Remove(aListener);
end;

function TnsBaseSearcherWindowData.pm_GetContextKind: TnsBaseSearchKind;
begin
 if Assigned(ContextSearcher) then
  Result := ContextSearcher.Kind
 else
  if Assigned(f_Presentation) and InsBaseSearchPresentation(f_Presentation).IsQueryCard then
   Result := ns_bskQuery
  else
   Result := ns_bskMenu;
end;

function TnsBaseSearcherWindowData.pm_GetAvailableClasses: InsBaseSearchClasses;
begin
 CheckValidClasses;
 Result := TnsBaseSearchClasses.Instance;
end;

function TnsBaseSearcherWindowData.pm_GetClassesAnywayDisabled: Boolean;
begin
 Result := Assigned(ContextSearcher) and ContextSearcher.IsLocalSearchArea;
end;

function TnsBaseSearcherWindowData.pm_GetAllowSearchInTitles: Boolean;
begin
 if Assigned(ContextSearcher) then
  Result := ContextSearcher.AllowSearchInTitles
 else
  Result := True;
end;

function TnsBaseSearcherWindowData.pm_GetFindEnabled: Boolean;
begin
 if Assigned(ContextSearcher) then
  Result := not ContextSearcher.IsSearchLocked and (
              not ContextSearcher.IsLocalSearchArea or
              ContextSearcher.IsLocalDataReady)
 else
  Result := True;
end;

function TnsBaseSearcherWindowData.pm_GetContext: Il3CString;
begin
 Result := f_Context;
end;

procedure TnsBaseSearcherWindowData.pm_SetContext(const aValue: Il3CString);
begin
 if not l3Same(f_Context, aValue) then
 begin
  f_InitialContext := nil;
  f_Context := aValue;
  NotifyChanged([ns_ceContext]);
 end;
end;

function TnsBaseSearcherWindowData.pm_GetActiveClass: InsBaseSearchClass;
begin
 if Assigned(ContextSearcher) and ContextSearcher.IsLocalSearchArea then
  f_ActiveClass := f_FirstClass;
 if (f_ActiveClass = nil) then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=294600483&focusedCommentId=320742073&#comment-320742073
  f_ActiveClass := f_FirstClass;
 Result := f_ActiveClass;
end;

procedure TnsBaseSearcherWindowData.pm_SetActiveClass(const aValue: InsBaseSearchClass);
begin
 if (f_ActiveClass = nil) or
    (not f_ActiveClass.IsSame(aValue)) then
 begin
  f_ActiveClass := aValue;
  f_ClassSetFromState := False;
  NotifyChanged([ns_ceActiveClass]); 
 end;//f_ActiveClass <> l_Value
end;

function TnsBaseSearcherWindowData.pm_GetArea: TnsSearchArea;
begin
 if Assigned(ContextSearcher) then
  Result := ContextSearcher.Area
 else
  Result := ns_saEverywere;
end;

procedure TnsBaseSearcherWindowData.pm_SetArea(aValue: TnsSearchArea);
begin
 if pm_GetArea <> aValue then
 begin
  if Assigned(ContextSearcher) then
   ContextSearcher.Area := aValue;
  NotifyChanged([ns_ceSearchArea]);
 end;
end;

function TnsBaseSearcherWindowData.pm_GetExampleText: Il3CString;
begin
 Result := f_ExampleText;
end;

function TnsBaseSearcherWindowData.pm_GetErrorWords: IvcmStrings;
begin
 Result := f_ErrorWords;
end;

procedure TnsBaseSearcherWindowData.pm_SetErrorWords(const aValue: IvcmStrings);
begin
 if (not l3IEQ(aValue, f_ErrorWords)) then
 begin
  f_ErrorWords := aValue;
 end;
end;

function TnsBaseSearcherWindowData.pm_GetFindBackSupported: Boolean;
begin
 if Assigned(ContextSearcher) then
  Result := ContextSearcher.FindBackSupported
 else
  Result := False;
end;

function TnsBaseSearcherWindowData.pm_GetFindBackEnabled: Boolean;
begin
 if Assigned(ContextSearcher) then
  Result := not ContextSearcher.IsSearchLocked and ContextSearcher.FindBackEnabled
 else
  Result := False;
end;

function TnsBaseSearcherWindowData.pm_GetFragmentsCountSuffix: Il3CString;
begin
 if Assigned(ContextSearcher) then
  Result := ContextSearcher.FragmentsCountSuffix
 else
  Result := nil;
end;

function TnsBaseSearcherWindowData.pm_GetPromptTree: Il3SimpleTree;
var
 l_FilterableTree: Il3FilterableTree;
 l_Filters: InsBaseSearchPromptFilters;
 l_Data: LongWord;
 l_Current: Integer;
begin
 if Assigned(ContextSearcher) and not ContextSearcher.AllowPrompts then
  Result := nil
 else
 begin
  Result := TnsBaseSearchPromptTree.Make;
  if Supports(Result, Il3FilterableTree, l_FilterableTree) and
   Supports(l_FilterableTree.CloneFilters, InsBaseSearchPromptFilters, l_Filters) then
  begin
   if Assigned(ContextSearcher) then
    l_Data := ContextSearcher.PromptsInfo
   else
    l_Data := 0;
   Result := l_FilterableTree.MakeFiltered(l_Filters.SetPromptForDoc(
                                            TnsPromptForDocFilter.Make(l_Data)),
                                           nil,
                                           l_Current,
                                           True);
  end;//Supports(Result, Il3FilterableTree, l_FilterableTree)..
 end;//Assigned(ContextSearcher)..
end;

procedure TnsBaseSearcherWindowData.RemovePresentation(const aPresentation: InsBaseSearchPresentation);
begin
 Assert(aPresentation <> nil);
 if l3IEQ(InsBaseSearchPresentation(f_Presentation), aPresentation) then
  pm_SetPresentation(nil);
end;

function TnsBaseSearcherWindowData.pm_GetPresentation: InsBaseSearchPresentation;
begin
 Result := InsBaseSearchPresentation(f_Presentation);
end;

procedure TnsBaseSearcherWindowData.pm_SetPresentation(const aPresentation: InsBaseSearchPresentation);
begin
 f_Presentation := Pointer(aPresentation);
end;

procedure TnsBaseSearcherWindowData.StoreActiveClass;
begin
 f_SavedClass := f_ActiveClass;
 f_ClassSaved := True;
end;

function TnsBaseSearcherWindowData.pm_GetActiveClassForSaveState: InsBaseSearchClass;
begin
 if (TvcmHistoryService.Instance.GetContainerHistory(Container)).InBF then
  Result := pm_GetActiveClass
  // - сохраняем то, что у нас во вкладке
 else
 if f_ClassSaved AND (f_SavedClass <> nil) then
  Result := f_SavedClass
  // - сохраняем то, что у нас БЫЛО во вкладке ДО ПОИСКА
  // http://mdp.garant.ru/pages/viewpage.action?pageId=300026165
 else
  Result := pm_GetActiveClass;
end;

function TnsBaseSearcherWindowData.ValidateBaseSearchForm(const aForm: IvcmEntityForm): Boolean;
begin
 Result := false;
 if (aForm <> nil) then
  Result := (aForm.NativeMainForm.AsForm.VCLWinControl = Container.AsForm.VCLWinControl);
 Assert(Result);
end;

constructor TnsBaseSearcherWindowData.Create(const aState: InsBaseSearcherWindowDataState;
 const aContainer: IvcmContainer);
begin
 inherited Create;
 f_Listeners := TnsBaseSearchWindowDataListenerList.Create;
 f_Container := Pointer(aContainer);
 if (aState <> nil) then
  AssignState(aState);
end;

class function TnsBaseSearcherWindowData.Make(const aState: InsBaseSearcherWindowDataState;
 const aContainer: IvcmContainer): InsBaseSearcherWindowData;
var
 Inst: TnsBaseSearcherWindowData;
begin
 Inst := Create(aState, aContainer);
 try
  Result := Inst;
 finally
  FreeAndNil(Inst);
 end;
end;

class function TnsBaseSearcherWindowData.Make(const aContainer: IvcmContainer): InsBaseSearcherWindowData;
begin
 Result := Make(nil, aContainer);
end;

{$IfEnd} //not Admin AND not Monitorings

end.
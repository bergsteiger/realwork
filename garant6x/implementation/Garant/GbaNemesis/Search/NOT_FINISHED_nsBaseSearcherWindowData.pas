unit NOT_FINISHED_nsBaseSearcherWindowData;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search$Lib"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/NOT_FINISHED_nsBaseSearcherWindowData.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Оболочка Без Прецедентов::F1 Without Usecases::Search$Lib::BaseSearch::TnsBaseSearcherWindowData
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3ProtoObject,
  BaseSearchInterfaces,
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3TreeInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsBaseSearcherWindowData = class(Tl3ProtoObject, InsBaseSearcherWindowData)
 protected
 // realized methods
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
   function pm_GetFindBackSupported: Boolean;
   function pm_GetFindBackEnabled: Boolean;
   function pm_GetFragmentsCountSuffix: Il3CString;
   function pm_GetPresentation: InsBaseSearchPresentation;
   procedure pm_SetPresentation(const aValue: InsBaseSearchPresentation);
   procedure StoreActiveClass;
   function pm_GetActiveClassForSaveState: InsBaseSearchClass;
   function pm_GetPromptTree: Il3SimpleTree;
   function MakeState: InsBaseSearcherWindowDataState;
   procedure AssignState(const aState: InsBaseSearcherWindowDataState);
   function pm_GetErrorWords: IvcmStrings;
   procedure pm_SetErrorWords(const aValue: IvcmStrings);
   procedure Subscribe(const aListener: InsBaseSearchWindowDataListener);
   procedure Unsubscribe(const aListener: InsBaseSearchWindowDataListener);
 public
 // realized methods
   procedure RemovePresentation(const aPresentation: InsBaseSearchPresentation);
   function ValidateBaseSearchForm(const aForm: IvcmEntityForm): Boolean;
     {* Проверяет, что форма БП "той системы", т.е. встроена в то же главное окно, что и сам Searcher }
 end;//TnsBaseSearcherWindowData
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsBaseSearchWindowDataListenerList
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsBaseSearcherWindowData

function TnsBaseSearcherWindowData.pm_GetContextKind: TnsBaseSearchKind;
//#UC START# *496B62BF00A7_5628BBF40355get_var*
//#UC END# *496B62BF00A7_5628BBF40355get_var*
begin
//#UC START# *496B62BF00A7_5628BBF40355get_impl*
 if Assigned(ContextSearcher) then
  Result := ContextSearcher.Kind
 else
  if Assigned(f_Presentation) and InsBaseSearchPresentation(f_Presentation).IsQueryCard then
   Result := ns_bskQuery
  else
   Result := ns_bskMenu;
//#UC END# *496B62BF00A7_5628BBF40355get_impl*
end;//TnsBaseSearcherWindowData.pm_GetContextKind

function TnsBaseSearcherWindowData.pm_GetAvailableClasses: InsBaseSearchClasses;
//#UC START# *496B62E80050_5628BBF40355get_var*
//#UC END# *496B62E80050_5628BBF40355get_var*
begin
//#UC START# *496B62E80050_5628BBF40355get_impl*
 CheckValidClasses;
 Result := TnsBaseSearchClasses.Instance;
//#UC END# *496B62E80050_5628BBF40355get_impl*
end;//TnsBaseSearcherWindowData.pm_GetAvailableClasses

function TnsBaseSearcherWindowData.pm_GetClassesAnywayDisabled: Boolean;
//#UC START# *496B630301B5_5628BBF40355get_var*
//#UC END# *496B630301B5_5628BBF40355get_var*
begin
//#UC START# *496B630301B5_5628BBF40355get_impl*
 Result := Assigned(ContextSearcher) and ContextSearcher.IsLocalSearchArea;
//#UC END# *496B630301B5_5628BBF40355get_impl*
end;//TnsBaseSearcherWindowData.pm_GetClassesAnywayDisabled

function TnsBaseSearcherWindowData.pm_GetAllowSearchInTitles: Boolean;
//#UC START# *496B631F01AD_5628BBF40355get_var*
//#UC END# *496B631F01AD_5628BBF40355get_var*
begin
//#UC START# *496B631F01AD_5628BBF40355get_impl*
 if Assigned(ContextSearcher) then
  Result := ContextSearcher.AllowSearchInTitles
 else
  Result := True;
//#UC END# *496B631F01AD_5628BBF40355get_impl*
end;//TnsBaseSearcherWindowData.pm_GetAllowSearchInTitles

function TnsBaseSearcherWindowData.pm_GetFindEnabled: Boolean;
//#UC START# *496B633D033B_5628BBF40355get_var*
//#UC END# *496B633D033B_5628BBF40355get_var*
begin
//#UC START# *496B633D033B_5628BBF40355get_impl*
 if Assigned(ContextSearcher) then
  Result := not ContextSearcher.IsSearchLocked and (
              not ContextSearcher.IsLocalSearchArea or
              ContextSearcher.IsLocalDataReady)
 else
  Result := True;
//#UC END# *496B633D033B_5628BBF40355get_impl*
end;//TnsBaseSearcherWindowData.pm_GetFindEnabled

function TnsBaseSearcherWindowData.pm_GetContext: Il3CString;
//#UC START# *496B636102E7_5628BBF40355get_var*
//#UC END# *496B636102E7_5628BBF40355get_var*
begin
//#UC START# *496B636102E7_5628BBF40355get_impl*
 Result := f_Context;
//#UC END# *496B636102E7_5628BBF40355get_impl*
end;//TnsBaseSearcherWindowData.pm_GetContext

procedure TnsBaseSearcherWindowData.pm_SetContext(const aValue: Il3CString);
//#UC START# *496B636102E7_5628BBF40355set_var*
//#UC END# *496B636102E7_5628BBF40355set_var*
begin
//#UC START# *496B636102E7_5628BBF40355set_impl*
 if not l3Same(f_Context, aValue) then
 begin
  f_InitialContext := nil;
  f_Context := aValue;
  f_ErrorWords := nil;
  NotifyContextSearcher;
  NotifyWindow;
 end;
//#UC END# *496B636102E7_5628BBF40355set_impl*
end;//TnsBaseSearcherWindowData.pm_SetContext

function TnsBaseSearcherWindowData.pm_GetActiveClass: InsBaseSearchClass;
//#UC START# *496B637C00B7_5628BBF40355get_var*
//#UC END# *496B637C00B7_5628BBF40355get_var*
begin
//#UC START# *496B637C00B7_5628BBF40355get_impl*
 if Assigned(ContextSearcher) and ContextSearcher.IsLocalSearchArea then
  f_ActiveClass := f_FirstClass;
 if (f_ActiveClass = nil) then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=294600483&focusedCommentId=320742073&#comment-320742073
  f_ActiveClass := f_FirstClass;
 Result := f_ActiveClass;
//#UC END# *496B637C00B7_5628BBF40355get_impl*
end;//TnsBaseSearcherWindowData.pm_GetActiveClass

procedure TnsBaseSearcherWindowData.pm_SetActiveClass(const aValue: InsBaseSearchClass);
//#UC START# *496B637C00B7_5628BBF40355set_var*
//#UC END# *496B637C00B7_5628BBF40355set_var*
begin
//#UC START# *496B637C00B7_5628BBF40355set_impl*
 if (f_ActiveClass = nil) or
    (not f_ActiveClass.IsSame(aValue)) then
 begin
  f_ActiveClass := aValue;
  f_ClassSetFromState := False;  
  NotifyWindow;
 end;//f_ActiveClass <> l_Value
//#UC END# *496B637C00B7_5628BBF40355set_impl*
end;//TnsBaseSearcherWindowData.pm_SetActiveClass

function TnsBaseSearcherWindowData.pm_GetArea: TnsSearchArea;
//#UC START# *496B63BE0309_5628BBF40355get_var*
//#UC END# *496B63BE0309_5628BBF40355get_var*
begin
//#UC START# *496B63BE0309_5628BBF40355get_impl*
 if Assigned(ContextSearcher) then
  Result := ContextSearcher.Area
 else
  Result := ns_saEverywere;
//#UC END# *496B63BE0309_5628BBF40355get_impl*
end;//TnsBaseSearcherWindowData.pm_GetArea

procedure TnsBaseSearcherWindowData.pm_SetArea(aValue: TnsSearchArea);
//#UC START# *496B63BE0309_5628BBF40355set_var*
//#UC END# *496B63BE0309_5628BBF40355set_var*
begin
//#UC START# *496B63BE0309_5628BBF40355set_impl*
 if Area <> aValue then
 begin
  if Assigned(ContextSearcher) then
   ContextSearcher.Area := aValue;
  NotifyVisibleWatcher;
  NotifyWindow;
 end;
//#UC END# *496B63BE0309_5628BBF40355set_impl*
end;//TnsBaseSearcherWindowData.pm_SetArea

function TnsBaseSearcherWindowData.pm_GetExampleText: Il3CString;
//#UC START# *496B63D40168_5628BBF40355get_var*
//#UC END# *496B63D40168_5628BBF40355get_var*
begin
//#UC START# *496B63D40168_5628BBF40355get_impl*
 Result := f_ExampleText;
//#UC END# *496B63D40168_5628BBF40355get_impl*
end;//TnsBaseSearcherWindowData.pm_GetExampleText

function TnsBaseSearcherWindowData.pm_GetFindBackSupported: Boolean;
//#UC START# *49FEA2840322_5628BBF40355get_var*
//#UC END# *49FEA2840322_5628BBF40355get_var*
begin
//#UC START# *49FEA2840322_5628BBF40355get_impl*
 if Assigned(ContextSearcher) then
  Result := ContextSearcher.FindBackSupported
 else
  Result := False;
//#UC END# *49FEA2840322_5628BBF40355get_impl*
end;//TnsBaseSearcherWindowData.pm_GetFindBackSupported

function TnsBaseSearcherWindowData.pm_GetFindBackEnabled: Boolean;
//#UC START# *49FEA2AE013A_5628BBF40355get_var*
//#UC END# *49FEA2AE013A_5628BBF40355get_var*
begin
//#UC START# *49FEA2AE013A_5628BBF40355get_impl*
 if Assigned(ContextSearcher) then
  Result := not ContextSearcher.IsSearchLocked and ContextSearcher.FindBackEnabled
 else
  Result := False;
//#UC END# *49FEA2AE013A_5628BBF40355get_impl*
end;//TnsBaseSearcherWindowData.pm_GetFindBackEnabled

function TnsBaseSearcherWindowData.pm_GetFragmentsCountSuffix: Il3CString;
//#UC START# *49FFD84603C6_5628BBF40355get_var*
//#UC END# *49FFD84603C6_5628BBF40355get_var*
begin
//#UC START# *49FFD84603C6_5628BBF40355get_impl*
 if Assigned(ContextSearcher) then
  Result := ContextSearcher.FragmentsCountSuffix
 else
  Result := nil;
//#UC END# *49FFD84603C6_5628BBF40355get_impl*
end;//TnsBaseSearcherWindowData.pm_GetFragmentsCountSuffix

procedure TnsBaseSearcherWindowData.RemovePresentation(const aPresentation: InsBaseSearchPresentation);
//#UC START# *4AD5EBB302EA_5628BBF40355_var*
//#UC END# *4AD5EBB302EA_5628BBF40355_var*
begin
//#UC START# *4AD5EBB302EA_5628BBF40355_impl*
 Assert(aPresentation <> nil);
 if l3IEQ(InsBaseSearchPresentation(f_Presentation), aPresentation) then
  pm_SetPresentation(nil);
//#UC END# *4AD5EBB302EA_5628BBF40355_impl*
end;//TnsBaseSearcherWindowData.RemovePresentation

function TnsBaseSearcherWindowData.pm_GetPresentation: InsBaseSearchPresentation;
//#UC START# *4AD5EDC703BE_5628BBF40355get_var*
//#UC END# *4AD5EDC703BE_5628BBF40355get_var*
begin
//#UC START# *4AD5EDC703BE_5628BBF40355get_impl*
 Result := InsBaseSearchPresentation(f_Presentation);
//#UC END# *4AD5EDC703BE_5628BBF40355get_impl*
end;//TnsBaseSearcherWindowData.pm_GetPresentation

procedure TnsBaseSearcherWindowData.pm_SetPresentation(const aValue: InsBaseSearchPresentation);
//#UC START# *4AD5EDC703BE_5628BBF40355set_var*
//#UC END# *4AD5EDC703BE_5628BBF40355set_var*
begin
//#UC START# *4AD5EDC703BE_5628BBF40355set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AD5EDC703BE_5628BBF40355set_impl*
end;//TnsBaseSearcherWindowData.pm_SetPresentation

procedure TnsBaseSearcherWindowData.StoreActiveClass;
//#UC START# *4C04A80C018D_5628BBF40355_var*
//#UC END# *4C04A80C018D_5628BBF40355_var*
begin
//#UC START# *4C04A80C018D_5628BBF40355_impl*
 f_SavedClass := f_ActiveClass;
 f_ClassSaved := True;
//#UC END# *4C04A80C018D_5628BBF40355_impl*
end;//TnsBaseSearcherWindowData.StoreActiveClass

function TnsBaseSearcherWindowData.pm_GetActiveClassForSaveState: InsBaseSearchClass;
//#UC START# *4EE5F8200085_5628BBF40355get_var*
//#UC END# *4EE5F8200085_5628BBF40355get_var*
begin
//#UC START# *4EE5F8200085_5628BBF40355get_impl*
 if (g_Dispatcher <> nil) AND (g_Dispatcher.History <> nil) AND
    g_Dispatcher.History.InBF then
  Result := pm_GetActiveClass
  // - сохраняем то, что у нас во вкладке
 else 
 if f_ClassSaved AND (f_SavedClass <> nil) then
  Result := f_SavedClass
  // - сохраняем то, что у нас БЫЛО во вкладке ДО ПОИСКА
  // http://mdp.garant.ru/pages/viewpage.action?pageId=300026165
 else
  Result := pm_GetActiveClass;
//#UC END# *4EE5F8200085_5628BBF40355get_impl*
end;//TnsBaseSearcherWindowData.pm_GetActiveClassForSaveState

function TnsBaseSearcherWindowData.ValidateBaseSearchForm(const aForm: IvcmEntityForm): Boolean;
//#UC START# *4F1EA8A202D8_5628BBF40355_var*
//#UC END# *4F1EA8A202D8_5628BBF40355_var*
begin
//#UC START# *4F1EA8A202D8_5628BBF40355_impl*
 Result := false;
 if (aForm <> nil) then
  Result := (aForm.NativeMainForm.AsForm.VCLWinControl = Self.Container.AsForm.VCLWinControl);
 Assert(Result);
//#UC END# *4F1EA8A202D8_5628BBF40355_impl*
end;//TnsBaseSearcherWindowData.ValidateBaseSearchForm

function TnsBaseSearcherWindowData.pm_GetPromptTree: Il3SimpleTree;
//#UC START# *562DB68E022A_5628BBF40355get_var*
//#UC END# *562DB68E022A_5628BBF40355get_var*
begin
//#UC START# *562DB68E022A_5628BBF40355get_impl*
 !!! Needs to be implemented !!!
//#UC END# *562DB68E022A_5628BBF40355get_impl*
end;//TnsBaseSearcherWindowData.pm_GetPromptTree

function TnsBaseSearcherWindowData.MakeState: InsBaseSearcherWindowDataState;
//#UC START# *562E027100BA_5628BBF40355_var*
//#UC END# *562E027100BA_5628BBF40355_var*
begin
//#UC START# *562E027100BA_5628BBF40355_impl*
 !!! Needs to be implemented !!!
//#UC END# *562E027100BA_5628BBF40355_impl*
end;//TnsBaseSearcherWindowData.MakeState

procedure TnsBaseSearcherWindowData.AssignState(const aState: InsBaseSearcherWindowDataState);
//#UC START# *562E02880261_5628BBF40355_var*
//#UC END# *562E02880261_5628BBF40355_var*
begin
//#UC START# *562E02880261_5628BBF40355_impl*
 !!! Needs to be implemented !!!
//#UC END# *562E02880261_5628BBF40355_impl*
end;//TnsBaseSearcherWindowData.AssignState

function TnsBaseSearcherWindowData.pm_GetErrorWords: IvcmStrings;
//#UC START# *562F3AFA00EF_5628BBF40355get_var*
//#UC END# *562F3AFA00EF_5628BBF40355get_var*
begin
//#UC START# *562F3AFA00EF_5628BBF40355get_impl*
 !!! Needs to be implemented !!!
//#UC END# *562F3AFA00EF_5628BBF40355get_impl*
end;//TnsBaseSearcherWindowData.pm_GetErrorWords

procedure TnsBaseSearcherWindowData.pm_SetErrorWords(const aValue: IvcmStrings);
//#UC START# *562F3AFA00EF_5628BBF40355set_var*
//#UC END# *562F3AFA00EF_5628BBF40355set_var*
begin
//#UC START# *562F3AFA00EF_5628BBF40355set_impl*
 !!! Needs to be implemented !!!
//#UC END# *562F3AFA00EF_5628BBF40355set_impl*
end;//TnsBaseSearcherWindowData.pm_SetErrorWords

procedure TnsBaseSearcherWindowData.Subscribe(const aListener: InsBaseSearchWindowDataListener);
//#UC START# *562F5D4E0001_5628BBF40355_var*
//#UC END# *562F5D4E0001_5628BBF40355_var*
begin
//#UC START# *562F5D4E0001_5628BBF40355_impl*
 !!! Needs to be implemented !!!
//#UC END# *562F5D4E0001_5628BBF40355_impl*
end;//TnsBaseSearcherWindowData.Subscribe

procedure TnsBaseSearcherWindowData.Unsubscribe(const aListener: InsBaseSearchWindowDataListener);
//#UC START# *562F5D6503B6_5628BBF40355_var*
//#UC END# *562F5D6503B6_5628BBF40355_var*
begin
//#UC START# *562F5D6503B6_5628BBF40355_impl*
 !!! Needs to be implemented !!!
//#UC END# *562F5D6503B6_5628BBF40355_impl*
end;//TnsBaseSearcherWindowData.Unsubscribe

{$IfEnd} //not Admin AND not Monitorings

end.
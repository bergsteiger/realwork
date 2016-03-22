unit NOT_FINISHED_nsBaseSearcher;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\NOT_FINISHED_nsBaseSearcher.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsBaseSearcher" MUID: (4AC226030181)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseSearchInterfaces
 , PrimBaseSearchInterfaces
 , ContextHistoryInterfaces
 , DataAdapterInterfaces
 , l3Interfaces
 , l3TreeInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TnsBaseSearcher = class(InsBaseSearchContextProvider, InsBaseSearchResultProcessor, InsBaseSearchDataReadyChecker, InsMistakesCorrector, InsBaseSearchQueryDataProcessor, InsContextSearchHistoryNotifier, InsBaseSearcher, InsBaseSearcherWindowData, InsDataAdapterListener)
  protected
   procedure RepairMistakes;
   function pm_GetContext: Il3CString;
   procedure CheckLocalDataReady;
   procedure SearchResultEmpty(TryFullList: Boolean);
   procedure SearchResultExists;
   procedure AnotherSearchSuccessed;
   procedure Correct(const aCorrectedContext: Il3StringsEx;
    const aMistakesList: Il3StringsEx);
   procedure SetDataFromQuery(const aQuery: IUnknown);
   procedure RequestFind;
   procedure HistoryChanged(const aNewHistory: IvcmStrings);
   procedure ContextSearched;
   procedure ShowWindowByUser(OpenKind: TnsBaseSearchOpenKind);
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
   procedure Updated;
    {* данные адаптера были обновлен }
   function pm_GetFindBackSupported: Boolean;
   function pm_GetFindBackEnabled: Boolean;
   function pm_GetFragmentsCountSuffix: Il3CString;
   procedure RequestCheckFragmentsCount;
   procedure RequestCheckFindBack;
   function pm_GetPresentation: InsBaseSearchPresentation;
   procedure pm_SetPresentation(const aValue: InsBaseSearchPresentation);
   procedure StoreActiveClass;
   procedure AnotherSearchCancelled;
   procedure DropActiveClass;
    {* http://mdp.garant.ru/pages/viewpage.action?pageId=269069309&focusedCommentId=296624258#comment-296624258 }
   function pm_GetActiveClassForSaveState: InsBaseSearchClass;
   function MakeState: InsBaseSearcherInitialState; overload;
   procedure AssignState(const aState: InsBaseSearcherInitialState); overload;
   procedure ForceUpdateClassForHistory;
   function MakeStateParams(aStateElements: TnsBaseSearchStateElements;
    aForClone: Boolean): InsBaseSearcherInitialState;
   procedure ContainerIsClosing;
   procedure Find;
   procedure FindBack;
   procedure ApplyCurrentExample;
   function pm_GetWindowData: InsBaseSearcherWindowData;
   function pm_GetSearchWindow: InsSearchWindow;
   procedure pm_SetSearchWindow(const aValue: InsSearchWindow);
   function pm_GetPromptTree: Il3SimpleTree;
   function MakeState: InsBaseSearcherWindowDataState; overload;
   procedure AssignState(const aState: InsBaseSearcherWindowDataState); overload;
   function pm_GetErrorWords: IvcmStrings;
   procedure pm_SetErrorWords(const aValue: IvcmStrings);
   procedure Subscribe(const aListener: InsBaseSearchWindowDataListener);
   procedure Unsubscribe(const aListener: InsBaseSearchWindowDataListener);
  public
   procedure RemovePresentation(const aPresentation: InsBaseSearchPresentation);
   function ValidateBaseSearchForm(const aForm: IvcmEntityForm): Boolean;
    {* Проверяет, что форма БП "той системы", т.е. встроена в то же главное окно, что и сам Searcher }
 end;//TnsBaseSearcher
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsFiltersContainer
 , Common_FormDefinitions_Controls
 , nsBaseSearchClasses
 , nsBaseSearchServiceImpl
 , nsBaseSearcherWindowData
;

procedure TnsBaseSearcher.RepairMistakes;
//#UC START# *49513746034D_4AC226030181_var*
//#UC END# *49513746034D_4AC226030181_var*
begin
//#UC START# *49513746034D_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *49513746034D_4AC226030181_impl*
end;//TnsBaseSearcher.RepairMistakes

function TnsBaseSearcher.pm_GetContext: Il3CString;
//#UC START# *4951375B0052_4AC226030181get_var*
//#UC END# *4951375B0052_4AC226030181get_var*
begin
//#UC START# *4951375B0052_4AC226030181get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4951375B0052_4AC226030181get_impl*
end;//TnsBaseSearcher.pm_GetContext

procedure TnsBaseSearcher.CheckLocalDataReady;
//#UC START# *496B4F6D02B5_4AC226030181_var*
//#UC END# *496B4F6D02B5_4AC226030181_var*
begin
//#UC START# *496B4F6D02B5_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B4F6D02B5_4AC226030181_impl*
end;//TnsBaseSearcher.CheckLocalDataReady

procedure TnsBaseSearcher.SearchResultEmpty(TryFullList: Boolean);
//#UC START# *496B4FAA02FA_4AC226030181_var*
//#UC END# *496B4FAA02FA_4AC226030181_var*
begin
//#UC START# *496B4FAA02FA_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B4FAA02FA_4AC226030181_impl*
end;//TnsBaseSearcher.SearchResultEmpty

procedure TnsBaseSearcher.SearchResultExists;
//#UC START# *496B4FC70065_4AC226030181_var*
//#UC END# *496B4FC70065_4AC226030181_var*
begin
//#UC START# *496B4FC70065_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B4FC70065_4AC226030181_impl*
end;//TnsBaseSearcher.SearchResultExists

procedure TnsBaseSearcher.AnotherSearchSuccessed;
//#UC START# *496B4FD20320_4AC226030181_var*
//#UC END# *496B4FD20320_4AC226030181_var*
begin
//#UC START# *496B4FD20320_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B4FD20320_4AC226030181_impl*
end;//TnsBaseSearcher.AnotherSearchSuccessed

procedure TnsBaseSearcher.Correct(const aCorrectedContext: Il3StringsEx;
 const aMistakesList: Il3StringsEx);
//#UC START# *496B513C0168_4AC226030181_var*
//#UC END# *496B513C0168_4AC226030181_var*
begin
//#UC START# *496B513C0168_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B513C0168_4AC226030181_impl*
end;//TnsBaseSearcher.Correct

procedure TnsBaseSearcher.SetDataFromQuery(const aQuery: IUnknown);
//#UC START# *496B534B0098_4AC226030181_var*
//#UC END# *496B534B0098_4AC226030181_var*
begin
//#UC START# *496B534B0098_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B534B0098_4AC226030181_impl*
end;//TnsBaseSearcher.SetDataFromQuery

procedure TnsBaseSearcher.RequestFind;
//#UC START# *496B5356008C_4AC226030181_var*
//#UC END# *496B5356008C_4AC226030181_var*
begin
//#UC START# *496B5356008C_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B5356008C_4AC226030181_impl*
end;//TnsBaseSearcher.RequestFind

procedure TnsBaseSearcher.HistoryChanged(const aNewHistory: IvcmStrings);
//#UC START# *496B53B70380_4AC226030181_var*
//#UC END# *496B53B70380_4AC226030181_var*
begin
//#UC START# *496B53B70380_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B53B70380_4AC226030181_impl*
end;//TnsBaseSearcher.HistoryChanged

procedure TnsBaseSearcher.ContextSearched;
//#UC START# *496B53C30337_4AC226030181_var*
//#UC END# *496B53C30337_4AC226030181_var*
begin
//#UC START# *496B53C30337_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B53C30337_4AC226030181_impl*
end;//TnsBaseSearcher.ContextSearched

procedure TnsBaseSearcher.ShowWindowByUser(OpenKind: TnsBaseSearchOpenKind);
//#UC START# *496B5FE00107_4AC226030181_var*
//#UC END# *496B5FE00107_4AC226030181_var*
begin
//#UC START# *496B5FE00107_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B5FE00107_4AC226030181_impl*
end;//TnsBaseSearcher.ShowWindowByUser

function TnsBaseSearcher.pm_GetContextKind: TnsBaseSearchKind;
//#UC START# *496B62BF00A7_4AC226030181get_var*
//#UC END# *496B62BF00A7_4AC226030181get_var*
begin
//#UC START# *496B62BF00A7_4AC226030181get_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B62BF00A7_4AC226030181get_impl*
end;//TnsBaseSearcher.pm_GetContextKind

function TnsBaseSearcher.pm_GetAvailableClasses: InsBaseSearchClasses;
//#UC START# *496B62E80050_4AC226030181get_var*
//#UC END# *496B62E80050_4AC226030181get_var*
begin
//#UC START# *496B62E80050_4AC226030181get_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B62E80050_4AC226030181get_impl*
end;//TnsBaseSearcher.pm_GetAvailableClasses

function TnsBaseSearcher.pm_GetClassesAnywayDisabled: Boolean;
//#UC START# *496B630301B5_4AC226030181get_var*
//#UC END# *496B630301B5_4AC226030181get_var*
begin
//#UC START# *496B630301B5_4AC226030181get_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B630301B5_4AC226030181get_impl*
end;//TnsBaseSearcher.pm_GetClassesAnywayDisabled

function TnsBaseSearcher.pm_GetAllowSearchInTitles: Boolean;
//#UC START# *496B631F01AD_4AC226030181get_var*
//#UC END# *496B631F01AD_4AC226030181get_var*
begin
//#UC START# *496B631F01AD_4AC226030181get_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B631F01AD_4AC226030181get_impl*
end;//TnsBaseSearcher.pm_GetAllowSearchInTitles

function TnsBaseSearcher.pm_GetFindEnabled: Boolean;
//#UC START# *496B633D033B_4AC226030181get_var*
//#UC END# *496B633D033B_4AC226030181get_var*
begin
//#UC START# *496B633D033B_4AC226030181get_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B633D033B_4AC226030181get_impl*
end;//TnsBaseSearcher.pm_GetFindEnabled

function TnsBaseSearcher.pm_GetContext: Il3CString;
//#UC START# *496B636102E7_4AC226030181get_var*
//#UC END# *496B636102E7_4AC226030181get_var*
begin
//#UC START# *496B636102E7_4AC226030181get_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B636102E7_4AC226030181get_impl*
end;//TnsBaseSearcher.pm_GetContext

procedure TnsBaseSearcher.pm_SetContext(const aValue: Il3CString);
//#UC START# *496B636102E7_4AC226030181set_var*
//#UC END# *496B636102E7_4AC226030181set_var*
begin
//#UC START# *496B636102E7_4AC226030181set_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B636102E7_4AC226030181set_impl*
end;//TnsBaseSearcher.pm_SetContext

function TnsBaseSearcher.pm_GetActiveClass: InsBaseSearchClass;
//#UC START# *496B637C00B7_4AC226030181get_var*
//#UC END# *496B637C00B7_4AC226030181get_var*
begin
//#UC START# *496B637C00B7_4AC226030181get_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B637C00B7_4AC226030181get_impl*
end;//TnsBaseSearcher.pm_GetActiveClass

procedure TnsBaseSearcher.pm_SetActiveClass(const aValue: InsBaseSearchClass);
//#UC START# *496B637C00B7_4AC226030181set_var*
//#UC END# *496B637C00B7_4AC226030181set_var*
begin
//#UC START# *496B637C00B7_4AC226030181set_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B637C00B7_4AC226030181set_impl*
end;//TnsBaseSearcher.pm_SetActiveClass

function TnsBaseSearcher.pm_GetArea: TnsSearchArea;
//#UC START# *496B63BE0309_4AC226030181get_var*
//#UC END# *496B63BE0309_4AC226030181get_var*
begin
//#UC START# *496B63BE0309_4AC226030181get_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B63BE0309_4AC226030181get_impl*
end;//TnsBaseSearcher.pm_GetArea

procedure TnsBaseSearcher.pm_SetArea(aValue: TnsSearchArea);
//#UC START# *496B63BE0309_4AC226030181set_var*
//#UC END# *496B63BE0309_4AC226030181set_var*
begin
//#UC START# *496B63BE0309_4AC226030181set_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B63BE0309_4AC226030181set_impl*
end;//TnsBaseSearcher.pm_SetArea

function TnsBaseSearcher.pm_GetExampleText: Il3CString;
//#UC START# *496B63D40168_4AC226030181get_var*
//#UC END# *496B63D40168_4AC226030181get_var*
begin
//#UC START# *496B63D40168_4AC226030181get_impl*
 !!! Needs to be implemented !!!
//#UC END# *496B63D40168_4AC226030181get_impl*
end;//TnsBaseSearcher.pm_GetExampleText

procedure TnsBaseSearcher.Updated;
 {* данные адаптера были обновлен }
//#UC START# *4991C3CD0077_4AC226030181_var*
//#UC END# *4991C3CD0077_4AC226030181_var*
begin
//#UC START# *4991C3CD0077_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *4991C3CD0077_4AC226030181_impl*
end;//TnsBaseSearcher.Updated

function TnsBaseSearcher.pm_GetFindBackSupported: Boolean;
//#UC START# *49FEA2840322_4AC226030181get_var*
//#UC END# *49FEA2840322_4AC226030181get_var*
begin
//#UC START# *49FEA2840322_4AC226030181get_impl*
 !!! Needs to be implemented !!!
//#UC END# *49FEA2840322_4AC226030181get_impl*
end;//TnsBaseSearcher.pm_GetFindBackSupported

function TnsBaseSearcher.pm_GetFindBackEnabled: Boolean;
//#UC START# *49FEA2AE013A_4AC226030181get_var*
//#UC END# *49FEA2AE013A_4AC226030181get_var*
begin
//#UC START# *49FEA2AE013A_4AC226030181get_impl*
 !!! Needs to be implemented !!!
//#UC END# *49FEA2AE013A_4AC226030181get_impl*
end;//TnsBaseSearcher.pm_GetFindBackEnabled

function TnsBaseSearcher.pm_GetFragmentsCountSuffix: Il3CString;
//#UC START# *49FFD84603C6_4AC226030181get_var*
//#UC END# *49FFD84603C6_4AC226030181get_var*
begin
//#UC START# *49FFD84603C6_4AC226030181get_impl*
 !!! Needs to be implemented !!!
//#UC END# *49FFD84603C6_4AC226030181get_impl*
end;//TnsBaseSearcher.pm_GetFragmentsCountSuffix

procedure TnsBaseSearcher.RequestCheckFragmentsCount;
//#UC START# *49FFFE5B033A_4AC226030181_var*
//#UC END# *49FFFE5B033A_4AC226030181_var*
begin
//#UC START# *49FFFE5B033A_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *49FFFE5B033A_4AC226030181_impl*
end;//TnsBaseSearcher.RequestCheckFragmentsCount

procedure TnsBaseSearcher.RequestCheckFindBack;
//#UC START# *4A13A97F0211_4AC226030181_var*
//#UC END# *4A13A97F0211_4AC226030181_var*
begin
//#UC START# *4A13A97F0211_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A13A97F0211_4AC226030181_impl*
end;//TnsBaseSearcher.RequestCheckFindBack

procedure TnsBaseSearcher.RemovePresentation(const aPresentation: InsBaseSearchPresentation);
//#UC START# *4AD5EBB302EA_4AC226030181_var*
//#UC END# *4AD5EBB302EA_4AC226030181_var*
begin
//#UC START# *4AD5EBB302EA_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AD5EBB302EA_4AC226030181_impl*
end;//TnsBaseSearcher.RemovePresentation

function TnsBaseSearcher.pm_GetPresentation: InsBaseSearchPresentation;
//#UC START# *4AD5EDC703BE_4AC226030181get_var*
//#UC END# *4AD5EDC703BE_4AC226030181get_var*
begin
//#UC START# *4AD5EDC703BE_4AC226030181get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AD5EDC703BE_4AC226030181get_impl*
end;//TnsBaseSearcher.pm_GetPresentation

procedure TnsBaseSearcher.pm_SetPresentation(const aValue: InsBaseSearchPresentation);
//#UC START# *4AD5EDC703BE_4AC226030181set_var*
//#UC END# *4AD5EDC703BE_4AC226030181set_var*
begin
//#UC START# *4AD5EDC703BE_4AC226030181set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AD5EDC703BE_4AC226030181set_impl*
end;//TnsBaseSearcher.pm_SetPresentation

procedure TnsBaseSearcher.StoreActiveClass;
//#UC START# *4C04A80C018D_4AC226030181_var*
//#UC END# *4C04A80C018D_4AC226030181_var*
begin
//#UC START# *4C04A80C018D_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C04A80C018D_4AC226030181_impl*
end;//TnsBaseSearcher.StoreActiveClass

procedure TnsBaseSearcher.AnotherSearchCancelled;
//#UC START# *4C04AFC8015D_4AC226030181_var*
//#UC END# *4C04AFC8015D_4AC226030181_var*
begin
//#UC START# *4C04AFC8015D_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C04AFC8015D_4AC226030181_impl*
end;//TnsBaseSearcher.AnotherSearchCancelled

procedure TnsBaseSearcher.DropActiveClass;
 {* http://mdp.garant.ru/pages/viewpage.action?pageId=269069309&focusedCommentId=296624258#comment-296624258 }
//#UC START# *4EB7BE980010_4AC226030181_var*
//#UC END# *4EB7BE980010_4AC226030181_var*
begin
//#UC START# *4EB7BE980010_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *4EB7BE980010_4AC226030181_impl*
end;//TnsBaseSearcher.DropActiveClass

function TnsBaseSearcher.pm_GetActiveClassForSaveState: InsBaseSearchClass;
//#UC START# *4EE5F8200085_4AC226030181get_var*
//#UC END# *4EE5F8200085_4AC226030181get_var*
begin
//#UC START# *4EE5F8200085_4AC226030181get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4EE5F8200085_4AC226030181get_impl*
end;//TnsBaseSearcher.pm_GetActiveClassForSaveState

function TnsBaseSearcher.ValidateBaseSearchForm(const aForm: IvcmEntityForm): Boolean;
 {* Проверяет, что форма БП "той системы", т.е. встроена в то же главное окно, что и сам Searcher }
//#UC START# *4F1EA8A202D8_4AC226030181_var*
//#UC END# *4F1EA8A202D8_4AC226030181_var*
begin
//#UC START# *4F1EA8A202D8_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F1EA8A202D8_4AC226030181_impl*
end;//TnsBaseSearcher.ValidateBaseSearchForm

function TnsBaseSearcher.MakeState: InsBaseSearcherInitialState;
//#UC START# *543392190118_4AC226030181_var*
//#UC END# *543392190118_4AC226030181_var*
begin
//#UC START# *543392190118_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *543392190118_4AC226030181_impl*
end;//TnsBaseSearcher.MakeState

procedure TnsBaseSearcher.AssignState(const aState: InsBaseSearcherInitialState);
//#UC START# *5433923F0280_4AC226030181_var*
//#UC END# *5433923F0280_4AC226030181_var*
begin
//#UC START# *5433923F0280_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *5433923F0280_4AC226030181_impl*
end;//TnsBaseSearcher.AssignState

procedure TnsBaseSearcher.ForceUpdateClassForHistory;
//#UC START# *5437B478018C_4AC226030181_var*
//#UC END# *5437B478018C_4AC226030181_var*
begin
//#UC START# *5437B478018C_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *5437B478018C_4AC226030181_impl*
end;//TnsBaseSearcher.ForceUpdateClassForHistory

function TnsBaseSearcher.MakeStateParams(aStateElements: TnsBaseSearchStateElements;
 aForClone: Boolean): InsBaseSearcherInitialState;
//#UC START# *54EC1B5C00E4_4AC226030181_var*
//#UC END# *54EC1B5C00E4_4AC226030181_var*
begin
//#UC START# *54EC1B5C00E4_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *54EC1B5C00E4_4AC226030181_impl*
end;//TnsBaseSearcher.MakeStateParams

procedure TnsBaseSearcher.ContainerIsClosing;
//#UC START# *55AF44F501B9_4AC226030181_var*
//#UC END# *55AF44F501B9_4AC226030181_var*
begin
//#UC START# *55AF44F501B9_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *55AF44F501B9_4AC226030181_impl*
end;//TnsBaseSearcher.ContainerIsClosing

procedure TnsBaseSearcher.Find;
//#UC START# *5629B2030130_4AC226030181_var*
//#UC END# *5629B2030130_4AC226030181_var*
begin
//#UC START# *5629B2030130_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *5629B2030130_4AC226030181_impl*
end;//TnsBaseSearcher.Find

procedure TnsBaseSearcher.FindBack;
//#UC START# *5629B2380023_4AC226030181_var*
//#UC END# *5629B2380023_4AC226030181_var*
begin
//#UC START# *5629B2380023_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *5629B2380023_4AC226030181_impl*
end;//TnsBaseSearcher.FindBack

procedure TnsBaseSearcher.ApplyCurrentExample;
//#UC START# *5629B24C0274_4AC226030181_var*
//#UC END# *5629B24C0274_4AC226030181_var*
begin
//#UC START# *5629B24C0274_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *5629B24C0274_4AC226030181_impl*
end;//TnsBaseSearcher.ApplyCurrentExample

function TnsBaseSearcher.pm_GetWindowData: InsBaseSearcherWindowData;
//#UC START# *5629BE0F005C_4AC226030181get_var*
//#UC END# *5629BE0F005C_4AC226030181get_var*
begin
//#UC START# *5629BE0F005C_4AC226030181get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5629BE0F005C_4AC226030181get_impl*
end;//TnsBaseSearcher.pm_GetWindowData

function TnsBaseSearcher.pm_GetSearchWindow: InsSearchWindow;
//#UC START# *5629CB87033C_4AC226030181get_var*
//#UC END# *5629CB87033C_4AC226030181get_var*
begin
//#UC START# *5629CB87033C_4AC226030181get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5629CB87033C_4AC226030181get_impl*
end;//TnsBaseSearcher.pm_GetSearchWindow

procedure TnsBaseSearcher.pm_SetSearchWindow(const aValue: InsSearchWindow);
//#UC START# *5629CB87033C_4AC226030181set_var*
//#UC END# *5629CB87033C_4AC226030181set_var*
begin
//#UC START# *5629CB87033C_4AC226030181set_impl*
 !!! Needs to be implemented !!!
//#UC END# *5629CB87033C_4AC226030181set_impl*
end;//TnsBaseSearcher.pm_SetSearchWindow

function TnsBaseSearcher.pm_GetPromptTree: Il3SimpleTree;
//#UC START# *562DB68E022A_4AC226030181get_var*
//#UC END# *562DB68E022A_4AC226030181get_var*
begin
//#UC START# *562DB68E022A_4AC226030181get_impl*
 !!! Needs to be implemented !!!
//#UC END# *562DB68E022A_4AC226030181get_impl*
end;//TnsBaseSearcher.pm_GetPromptTree

function TnsBaseSearcher.MakeState: InsBaseSearcherWindowDataState;
//#UC START# *562E027100BA_4AC226030181_var*
//#UC END# *562E027100BA_4AC226030181_var*
begin
//#UC START# *562E027100BA_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *562E027100BA_4AC226030181_impl*
end;//TnsBaseSearcher.MakeState

procedure TnsBaseSearcher.AssignState(const aState: InsBaseSearcherWindowDataState);
//#UC START# *562E02880261_4AC226030181_var*
//#UC END# *562E02880261_4AC226030181_var*
begin
//#UC START# *562E02880261_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *562E02880261_4AC226030181_impl*
end;//TnsBaseSearcher.AssignState

function TnsBaseSearcher.pm_GetErrorWords: IvcmStrings;
//#UC START# *562F3AFA00EF_4AC226030181get_var*
//#UC END# *562F3AFA00EF_4AC226030181get_var*
begin
//#UC START# *562F3AFA00EF_4AC226030181get_impl*
 !!! Needs to be implemented !!!
//#UC END# *562F3AFA00EF_4AC226030181get_impl*
end;//TnsBaseSearcher.pm_GetErrorWords

procedure TnsBaseSearcher.pm_SetErrorWords(const aValue: IvcmStrings);
//#UC START# *562F3AFA00EF_4AC226030181set_var*
//#UC END# *562F3AFA00EF_4AC226030181set_var*
begin
//#UC START# *562F3AFA00EF_4AC226030181set_impl*
 !!! Needs to be implemented !!!
//#UC END# *562F3AFA00EF_4AC226030181set_impl*
end;//TnsBaseSearcher.pm_SetErrorWords

procedure TnsBaseSearcher.Subscribe(const aListener: InsBaseSearchWindowDataListener);
//#UC START# *562F5D4E0001_4AC226030181_var*
//#UC END# *562F5D4E0001_4AC226030181_var*
begin
//#UC START# *562F5D4E0001_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *562F5D4E0001_4AC226030181_impl*
end;//TnsBaseSearcher.Subscribe

procedure TnsBaseSearcher.Unsubscribe(const aListener: InsBaseSearchWindowDataListener);
//#UC START# *562F5D6503B6_4AC226030181_var*
//#UC END# *562F5D6503B6_4AC226030181_var*
begin
//#UC START# *562F5D6503B6_4AC226030181_impl*
 !!! Needs to be implemented !!!
//#UC END# *562F5D6503B6_4AC226030181_impl*
end;//TnsBaseSearcher.Unsubscribe
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

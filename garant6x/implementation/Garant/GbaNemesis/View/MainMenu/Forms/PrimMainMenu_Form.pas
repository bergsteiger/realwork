unit PrimMainMenu_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/MainMenu/Forms/PrimMainMenu_Form.pas"
// Начат: 29.12.2008 17:23
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::MainMenu::PrimMainMenu
//
// Основное меню
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
  Classes
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
  Messages
  {$If not defined(NoVCM)}
  ,
  vcmContainerForm
  {$IfEnd} //not NoVCM
  ,
  MainMenuDomainInterfaces,
  l3ProtoObject,
  vtPanel,
  nsMainMenuNew
  {$If defined(Nemesis)}
  ,
  nscInterfaces
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscHideField
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTreeViewHotTruck
  {$IfEnd} //Nemesis
  ,
  PrimWorkJournalInterfaces,
  afwInterfaces,
  bsInterfaces,
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _evStyleTableListener_Parent_ = TvcmContainerForm;
 {$Include w:\common\components\gui\Garant\Everest\evStyleTableListener.imp.pas}
 _nsUserSettingsListener_Parent_ = _evStyleTableListener_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUserSettingsListener.imp.pas}
 TPrimMainMenuForm = {abstract form} class(_nsUserSettingsListener_, InsWorkJournalListener)
  {* Основное меню }
 private
 // private fields
   f_LastOpenDocsManager : TnsLastOpenDocsManager;
   f_TabTable : InscTabTable;
   f_ArrangeCount : Integer;
   f_pnlMain : TvtPanel;
    {* Поле для свойства pnlMain}
   f_hfLastOpenDocs : TnscHideField;
    {* Поле для свойства hfLastOpenDocs}
   f_tvLastOpenDocs : TnscTreeViewHotTruck;
    {* Поле для свойства tvLastOpenDocs}
   f_Grid : InscArrangeGrid;
    {* Поле для свойства Grid}
   f_TreeStyle : TnsTreeStyleManager;
    {* Поле для свойства TreeStyle}
 protected
  procedure MakeControls; override;
 private
 // private methods
   procedure GridSizeChanged(aSender: TObject);
     {* изменился размер таблицы, возможно нужно будет изменить размер скроллеров }
   procedure InitKeyboardNavigation;
   procedure ActionElement(Sender: TObject;
     Index: Integer);
   procedure PnlMainResize(aSender: TObject);
   procedure WMMouseWheel(var Message: TWMMouseWheel); message WM_MOUSEWHEEL;
 protected
 // property methods
   function pm_GetTreeStyle: TnsTreeStyleManager;
   function pm_GetContainerForBaseSearch: IvcmContainer; virtual;
 protected
 // realized methods
   {$If not defined(DesignTimeLibrary)}
   procedure DoStyleTableChanged; override;
   {$IfEnd} //not DesignTimeLibrary
   procedure JournalShrinked;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure FinishDataUpdate; override;
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
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
   {$If not defined(NoVCM)}
   function SaveOwnFormState(out theState: IvcmBase;
    aStateType: TvcmStateType;
    aForClone: Boolean): Boolean; override;
   {$IfEnd} //not NoVCM
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected methods
   procedure ArrangeGrid;
     {* установить размеры таблицы }
   procedure RecalcGrid;
   procedure BuildGrid;
   function DoBuildGrid: InscArrangeGrid; virtual; abstract;
   procedure DoInitKeyboardNavigation(const aTable: InscTabTable); virtual;
   procedure LoadLastOpenDocs; virtual;
   procedure DoActionElement(const aNode: InsMainMenuNode); virtual;
   procedure LoadTrees; virtual;
   function NewSchool: Boolean; virtual;
     {* Определяет, что основное меню вида 2009 - [$164601183] }
   procedure DoRecalcGrid(const aGrid: InscArrangeGrid); virtual;
 private
 // private properties
   property Grid: InscArrangeGrid
     read f_Grid;
 protected
 // protected properties
   property TreeStyle: TnsTreeStyleManager
     read pm_GetTreeStyle;
   property ContainerForBaseSearch: IvcmContainer
     read pm_GetContainerForBaseSearch;
 public
 // public properties
   property pnlMain: TvtPanel
     read f_pnlMain;
   property hfLastOpenDocs: TnscHideField
     read f_hfLastOpenDocs;
     {* Последние открытые документы }
   property tvLastOpenDocs: TnscTreeViewHotTruck
     read f_tvLastOpenDocs;
 end;//TPrimMainMenuForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If defined(Nemesis)}
  ,
  nscArrangeGrid
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTabTable
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTreeView
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  nsOpenUtils,
  nsConst
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  nsQueryInterfaces
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(DesignTimeLibrary)}
  ,
  evStyleTableSpy
  {$IfEnd} //not DesignTimeLibrary
  ,
  afwFacade
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include w:\common\components\gui\Garant\Everest\evStyleTableListener.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUserSettingsListener.imp.pas}

type
  TPrimMainMenuState = class(Tl3ProtoObject {$If not defined(NoVCM)}, IvcmBase{$IfEnd} //not NoVCM
  )
  public
  // public methods
   class function Make: IvcmBase; reintroduce;
  end;//TPrimMainMenuState

// start class TPrimMainMenuState

class function TPrimMainMenuState.Make: IvcmBase;
var
 l_Inst : TPrimMainMenuState;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TPrimMainMenuForm.GridSizeChanged(aSender: TObject);
//#UC START# *4AC9B71F032F_4958DD7002B6_var*
//#UC END# *4AC9B71F032F_4958DD7002B6_var*
begin
//#UC START# *4AC9B71F032F_4958DD7002B6_impl*
 ArrangeGrid;
//#UC END# *4AC9B71F032F_4958DD7002B6_impl*
end;//TPrimMainMenuForm.GridSizeChanged

procedure TPrimMainMenuForm.InitKeyboardNavigation;
//#UC START# *4AC9CB6100E4_4958DD7002B6_var*
//#UC END# *4AC9CB6100E4_4958DD7002B6_var*
begin
//#UC START# *4AC9CB6100E4_4958DD7002B6_impl*
 f_TabTable := TnscTabTable.Make;
 DoInitKeyboardNavigation(f_TabTable);
//#UC END# *4AC9CB6100E4_4958DD7002B6_impl*
end;//TPrimMainMenuForm.InitKeyboardNavigation

procedure TPrimMainMenuForm.ActionElement(Sender: TObject;
  Index: Integer);
//#UC START# *4AC9E13902F9_4958DD7002B6_var*
//#UC END# *4AC9E13902F9_4958DD7002B6_var*
var
 l_Node : Il3SimpleNode;
 l_MenuNode : InsMainMenuNode;
begin
//#UC START# *4AC9E13902F9_4958DD7002B6_impl*
 l_Node := TnscTreeView(Sender).GetNode(Index);
 if Supports(l_Node, InsMainMenuNode, l_MenuNode) then
  try
   DoActionElement(l_MenuNode);
  finally
   l_Node := nil;
  end//try..finally
 else
  nsOpenNavigatorItem(l_Node, NativeMainForm);
//#UC END# *4AC9E13902F9_4958DD7002B6_impl*
end;//TPrimMainMenuForm.ActionElement

procedure TPrimMainMenuForm.PnlMainResize(aSender: TObject);
//#UC START# *4ACC82D6017B_4958DD7002B6_var*
//#UC END# *4ACC82D6017B_4958DD7002B6_var*
begin
//#UC START# *4ACC82D6017B_4958DD7002B6_impl*
 if (f_Grid <> nil) then
  //if not Dispatcher.FormDispatcher.Locked then
   ArrangeGrid;
//#UC END# *4ACC82D6017B_4958DD7002B6_impl*
end;//TPrimMainMenuForm.PnlMainResize

procedure TPrimMainMenuForm.ArrangeGrid;
//#UC START# *4AC9B1BB022A_4958DD7002B6_var*
//#UC END# *4AC9B1BB022A_4958DD7002B6_var*
begin
//#UC START# *4AC9B1BB022A_4958DD7002B6_impl*
 Inc(f_ArrangeCount);
 try
  if (f_ArrangeCount = 1) then
   agArrangeGrid(f_Grid, Self, pnlMain, 0);
 finally
  Dec(f_ArrangeCount);
 end;//try..finally
//#UC END# *4AC9B1BB022A_4958DD7002B6_impl*
end;//TPrimMainMenuForm.ArrangeGrid

procedure TPrimMainMenuForm.RecalcGrid;
//#UC START# *4AC9B367032D_4958DD7002B6_var*
//#UC END# *4AC9B367032D_4958DD7002B6_var*
begin
//#UC START# *4AC9B367032D_4958DD7002B6_impl*
 if (f_Grid <> nil) then
 begin
  DoRecalcGrid(f_Grid);
  ArrangeGrid;
 end;//f_Grid <> nil
//#UC END# *4AC9B367032D_4958DD7002B6_impl*
end;//TPrimMainMenuForm.RecalcGrid

procedure TPrimMainMenuForm.BuildGrid;
//#UC START# *4AC9B6A80163_4958DD7002B6_var*
//#UC END# *4AC9B6A80163_4958DD7002B6_var*
begin
//#UC START# *4AC9B6A80163_4958DD7002B6_impl*
 f_Grid := nil;
 f_Grid := DoBuildGrid;
 Assert(f_Grid <> nil);
 f_Grid.OnSizeChanged := GridSizeChanged;
 RecalcGrid;
 if f_Grid.TwoStageBuild then
  RecalcGrid;
 // - это специально иначе старое ОМ и ОМ Инфарма неправильно считает высоты деревьев
 //   т.к. неправильно трактуются ширины. И процесс сходится только после второго раза.
 //   Как раньше собственно и было. 
//#UC END# *4AC9B6A80163_4958DD7002B6_impl*
end;//TPrimMainMenuForm.BuildGrid

function TPrimMainMenuForm.pm_GetTreeStyle: TnsTreeStyleManager;
//#UC START# *4AC9C93202F7_4958DD7002B6get_var*
var
 l_Index: Integer;
//#UC END# *4AC9C93202F7_4958DD7002B6get_var*
begin
//#UC START# *4AC9C93202F7_4958DD7002B6get_impl*
 if (f_TreeStyle = nil) then
 begin
  f_TreeStyle := TnsTreeStyleManager.Create(c_MainMenuColor, Self.NewSchool);
  for l_Index := 0 to Pred(ComponentCount) do
   if (Components[l_Index] <> tvLastOpenDocs) and
     (Components[l_Index] is TnscTreeView) then
   begin
    f_TreeStyle.Init(TnscTreeView(Components[l_Index]));
    TnscTreeView(Components[l_Index]).OnActionElement := ActionElement;
   end;//Components[l_Index] <> tvLastOpenDocs
 end;//f_TreeStyle = nil
 Result := f_TreeStyle;
//#UC END# *4AC9C93202F7_4958DD7002B6get_impl*
end;//TPrimMainMenuForm.pm_GetTreeStyle

function TPrimMainMenuForm.pm_GetContainerForBaseSearch: IvcmContainer;
//#UC START# *4ACA197F0147_4958DD7002B6get_var*
//#UC END# *4ACA197F0147_4958DD7002B6get_var*
begin
//#UC START# *4ACA197F0147_4958DD7002B6get_impl*
 Result := nil;
//#UC END# *4ACA197F0147_4958DD7002B6get_impl*
end;//TPrimMainMenuForm.pm_GetContainerForBaseSearch

procedure TPrimMainMenuForm.WMMouseWheel(var Message: TWMMouseWheel);
//#UC START# *4AC9A3AD01DE_4958DD7002B6_var*
//#UC END# *4AC9A3AD01DE_4958DD7002B6_var*
begin
//#UC START# *4AC9A3AD01DE_4958DD7002B6_impl*
 if nsScrollMainMenu(Self, Message) then
  inherited;
//#UC END# *4AC9A3AD01DE_4958DD7002B6_impl*
end;//TPrimMainMenuForm.WMMouseWheel

procedure TPrimMainMenuForm.DoInitKeyboardNavigation(const aTable: InscTabTable);
//#UC START# *4AC9CB8B01D3_4958DD7002B6_var*
//#UC END# *4AC9CB8B01D3_4958DD7002B6_var*
begin
//#UC START# *4AC9CB8B01D3_4958DD7002B6_impl*
 // - ничего не делаем
//#UC END# *4AC9CB8B01D3_4958DD7002B6_impl*
end;//TPrimMainMenuForm.DoInitKeyboardNavigation

procedure TPrimMainMenuForm.LoadLastOpenDocs;
//#UC START# *4AC9D12600E0_4958DD7002B6_var*
//#UC END# *4AC9D12600E0_4958DD7002B6_var*
begin
//#UC START# *4AC9D12600E0_4958DD7002B6_impl*
 Assert(false, 'Метод TPrimMainMenuForm.LoadLastOpenDocs должен быть переопределён в потомках');
//#UC END# *4AC9D12600E0_4958DD7002B6_impl*
end;//TPrimMainMenuForm.LoadLastOpenDocs

procedure TPrimMainMenuForm.DoActionElement(const aNode: InsMainMenuNode);
//#UC START# *4AC9E19E022B_4958DD7002B6_var*
//#UC END# *4AC9E19E022B_4958DD7002B6_var*
begin
//#UC START# *4AC9E19E022B_4958DD7002B6_impl*
(* case TnsSimpleMainMenuItem(aNode.NodeType) of
  // Задать вопрос (Правовая поддержка):
  ns_siMakeConsultation:
   Dispatcher.ModuleOperation(TdmStdRes.mod_opcode_Search_OpenConsult);
  // Посмотреть ответы (Правовая поддержка)
  ns_siShowAnswers:
   Dispatcher.ModuleOperation(TdmStdRes.mod_opcode_Folders_MyConsultations);
  ns_siLawSupportHelp:
   Application.HelpSystem.ShowTopicHelp(cHelpConsultingRules, '');
  ns_siTaxesPublishSearch:
   TdmStdRes.OpenTaxesPublishSearch(nil);
   // - здесь вообще-то надо звать усечённую карточку
  else*)
   nsOpenNavigatorItem(aNode, NativeMainForm);
 //end;//case l_MenuItem.ItemType of
//#UC END# *4AC9E19E022B_4958DD7002B6_impl*
end;//TPrimMainMenuForm.DoActionElement

procedure TPrimMainMenuForm.LoadTrees;
//#UC START# *4AC9E9EC0064_4958DD7002B6_var*
//#UC END# *4AC9E9EC0064_4958DD7002B6_var*
begin
//#UC START# *4AC9E9EC0064_4958DD7002B6_impl*
 LoadLastOpenDocs;
//#UC END# *4AC9E9EC0064_4958DD7002B6_impl*
end;//TPrimMainMenuForm.LoadTrees

function TPrimMainMenuForm.NewSchool: Boolean;
//#UC START# *4ACB2F98002B_4958DD7002B6_var*
//#UC END# *4ACB2F98002B_4958DD7002B6_var*
begin
//#UC START# *4ACB2F98002B_4958DD7002B6_impl*
 Result := false;
//#UC END# *4ACB2F98002B_4958DD7002B6_impl*
end;//TPrimMainMenuForm.NewSchool

procedure TPrimMainMenuForm.DoRecalcGrid(const aGrid: InscArrangeGrid);
//#UC START# *4AD3468102DB_4958DD7002B6_var*
//#UC END# *4AD3468102DB_4958DD7002B6_var*
begin
//#UC START# *4AD3468102DB_4958DD7002B6_impl*
 aGrid.Recalc;
//#UC END# *4AD3468102DB_4958DD7002B6_impl*
end;//TPrimMainMenuForm.DoRecalcGrid

{$If not defined(DesignTimeLibrary)}
procedure TPrimMainMenuForm.DoStyleTableChanged;
//#UC START# *4A485B710126_4958DD7002B6_var*
//#UC END# *4A485B710126_4958DD7002B6_var*
begin
//#UC START# *4A485B710126_4958DD7002B6_impl*
 RecalcGrid;
//#UC END# *4A485B710126_4958DD7002B6_impl*
end;//TPrimMainMenuForm.DoStyleTableChanged
{$IfEnd} //not DesignTimeLibrary

procedure TPrimMainMenuForm.JournalShrinked;
//#UC START# *4A83AA610299_4958DD7002B6_var*
//#UC END# *4A83AA610299_4958DD7002B6_var*
begin
//#UC START# *4A83AA610299_4958DD7002B6_impl*
 with tvLastOpenDocs do
 begin
  Changing;
  try
   LoadLastOpenDocs;
  finally
   Changed;
  end;//try..finally
 end;//with tvLastOpenDocs
 Invalidate;
//#UC END# *4A83AA610299_4958DD7002B6_impl*
end;//TPrimMainMenuForm.JournalShrinked

procedure TPrimMainMenuForm.Cleanup;
//#UC START# *479731C50290_4958DD7002B6_var*
//#UC END# *479731C50290_4958DD7002B6_var*
begin
//#UC START# *479731C50290_4958DD7002B6_impl*
 f_Grid := nil;
 f_TabTable := nil;
 FreeAndNil(f_LastOpenDocsManager);
 FreeAndNil(f_TreeStyle);
 TdmStdRes.MakeWorkJournal.UnRegisterListener(Self);
 inherited;
//#UC END# *479731C50290_4958DD7002B6_impl*
end;//TPrimMainMenuForm.Cleanup

procedure TPrimMainMenuForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4958DD7002B6_var*
//#UC END# *47EA4E9002C6_4958DD7002B6_var*
begin
//#UC START# *47EA4E9002C6_4958DD7002B6_impl*
 LoadTrees;
 inherited;
 BuildGrid;
//#UC END# *47EA4E9002C6_4958DD7002B6_impl*
end;//TPrimMainMenuForm.FinishDataUpdate

{$If not defined(NoVCM)}
procedure TPrimMainMenuForm.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_4958DD7002B6_var*
//#UC END# *49803F5503AA_4958DD7002B6_var*
begin
//#UC START# *49803F5503AA_4958DD7002B6_impl*
 inherited;
 if not aFromHistory then
  LoadTrees;
 BuildGrid;
 InitKeyboardNavigation;
//#UC END# *49803F5503AA_4958DD7002B6_impl*
end;//TPrimMainMenuForm.DoInit
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimMainMenuForm.DoLoadState(const aState: IvcmBase;
  aStateType: TvcmStateType): Boolean;
//#UC START# *49807428008C_4958DD7002B6_var*
//#UC END# *49807428008C_4958DD7002B6_var*
begin
//#UC START# *49807428008C_4958DD7002B6_impl*
 Result := inherited DoLoadState(aState, aStateType);
 if (aStateType = vcm_stContent) then
  LoadLastOpenDocs;
//#UC END# *49807428008C_4958DD7002B6_impl*
end;//TPrimMainMenuForm.DoLoadState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimMainMenuForm.InitControls;
//#UC START# *4A8E8F2E0195_4958DD7002B6_var*
//#UC END# *4A8E8F2E0195_4958DD7002B6_var*
begin
//#UC START# *4A8E8F2E0195_4958DD7002B6_impl*
 inherited;
 pnlMain.OnResize := pnlMainResize;
 TdmStdRes.MakeWorkJournal.RegisterListener(Self);
 TreeStyle;
 f_LastOpenDocsManager := TnsLastOpenDocsManager.Create(c_MainMenuColor,
                                                        tvLastOpenDocs,
                                                        Self.NewSchool);
//#UC END# *4A8E8F2E0195_4958DD7002B6_impl*
end;//TPrimMainMenuForm.InitControls
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimMainMenuForm.SaveOwnFormState(out theState: IvcmBase;
  aStateType: TvcmStateType;
  aForClone: Boolean): Boolean;
//#UC START# *4B4F49900003_4958DD7002B6_var*
//#UC END# *4B4F49900003_4958DD7002B6_var*
begin
//#UC START# *4B4F49900003_4958DD7002B6_impl*
 if (aStateType = vcm_stContent) then
 begin
  Result := true;
  theState := TPrimMainMenuState.Make;
  // - это специально, чтобы DoLoadState дёрнулось
 end
 else
  Result := inherited SaveOwnFormState(theState, aStateType, aForClone);
//#UC END# *4B4F49900003_4958DD7002B6_impl*
end;//TPrimMainMenuForm.SaveOwnFormState
{$IfEnd} //not NoVCM

procedure TPrimMainMenuForm.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Grid := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TPrimMainMenuForm.ClearFields

procedure TPrimMainMenuForm.MakeControls;
begin
 inherited;
 f_pnlMain := TvtPanel.Create(Self);
 f_pnlMain.Name := 'pnlMain';
 f_pnlMain.Parent := Self;
 f_hfLastOpenDocs := TnscHideField.Create(Self);
 f_hfLastOpenDocs.Name := 'hfLastOpenDocs';
 f_hfLastOpenDocs.Parent := pnlMain;
 f_hfLastOpenDocs.Caption := 'Последние открытые документы';
 f_tvLastOpenDocs := TnscTreeViewHotTruck.Create(Self);
 f_tvLastOpenDocs.Name := 'tvLastOpenDocs';
 f_tvLastOpenDocs.Parent := hfLastOpenDocs;
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimMainMenu
 TtfwClassRef.Register(TPrimMainMenuForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.
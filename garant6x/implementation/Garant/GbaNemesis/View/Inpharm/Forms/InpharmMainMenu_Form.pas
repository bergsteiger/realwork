unit InpharmMainMenu_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Inpharm/Forms/InpharmMainMenu_Form.pas"
// Начат: 29.12.2008 18:10
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Встроенные продукты::Inpharm::View::Inpharm::InpharmMainMenu
//
// Основное меню Инфарм
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
  PrimMainMenu_Form
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If defined(Nemesis)}
  ,
  nscHideField
  {$IfEnd} //Nemesis
  ,
  l3StringIDEx
  {$If defined(Nemesis)}
  ,
  nscTreeViewHotTruck
  {$IfEnd} //Nemesis
  ,
  InpharmMainMenu_ut_mmmMain_UserType
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Tree_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  nscTreeViewWithAdapterDragDrop
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3TreeInterfaces
  {$If defined(Nemesis)}
  ,
  nscInterfaces
  {$IfEnd} //Nemesis
  ,
  MainMenuDomainInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _vcmChromeLikeTabIconUpdater_Parent_ = TPrimMainMenuForm;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}
 TInpharmMainMenuForm = {abstract form} class(_vcmChromeLikeTabIconUpdater_)
  {* Основное меню Инфарм }
 private
 // private fields
   f_hfReferencesAndDictionaries : TnscHideField;
    {* Поле для свойства hfReferencesAndDictionaries}
   f_tvReferencesAndDictionaries : TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства tvReferencesAndDictionaries}
   f_hfReferencePharmaceuticalInformation : TnscHideField;
    {* Поле для свойства hfReferencePharmaceuticalInformation}
   f_tvReferencePharmaceuticalInformation : TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства tvReferencePharmaceuticalInformation}
   f_hfMainFeatures : TnscHideField;
    {* Поле для свойства hfMainFeatures}
   f_tvMainFeatures : TnscTreeViewHotTruck;
    {* Поле для свойства tvMainFeatures}
   f_hfRegulatoryInformation : TnscHideField;
    {* Поле для свойства hfRegulatoryInformation}
   f_tvRegulatoryInformation : TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства tvRegulatoryInformation}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 protected
 // realized methods
   function DoBuildGrid: InscArrangeGrid; override;
 protected
 // overridden protected methods
   procedure FinishDataUpdate; override;
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   procedure DoInitKeyboardNavigation(const aTable: InscTabTable); override;
   procedure LoadLastOpenDocs; override;
   procedure DoActionElement(const aNode: InsMainMenuNode); override;
   procedure LoadTrees; override;
    {$If not defined(NoVCM)}
   function DoGetTabCaption: IvcmCString; override;
    {$IfEnd} //not NoVCM
    {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
   function DoGetTabImageIndex: Integer; override;
    {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
 public
 // public properties

   property hfReferencesAndDictionaries: TnscHideField
     read f_hfReferencesAndDictionaries;
     {* Справочники и словари }
   property tvReferencesAndDictionaries: TnscTreeViewWithAdapterDragDrop
     read f_tvReferencesAndDictionaries;
   property hfReferencePharmaceuticalInformation: TnscHideField
     read f_hfReferencePharmaceuticalInformation;
     {* Справочная фармацевтическая информация }
   property tvReferencePharmaceuticalInformation: TnscTreeViewWithAdapterDragDrop
     read f_tvReferencePharmaceuticalInformation;
   property hfMainFeatures: TnscHideField
     read f_hfMainFeatures;
     {* Основные возможности }
   property tvMainFeatures: TnscTreeViewHotTruck
     read f_tvMainFeatures;
   property hfRegulatoryInformation: TnscHideField
     read f_hfRegulatoryInformation;
     {* Нормативная информация }
   property tvRegulatoryInformation: TnscTreeViewWithAdapterDragDrop
     read f_tvRegulatoryInformation;
 end;//TInpharmMainMenuForm

 TvcmEntityFormRef = TInpharmMainMenuForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If defined(Nemesis)}
  ,
  nscArrangeGrid
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  afwFacade
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If defined(Nemesis)}
  ,
  nscArrangeGridCell
  {$IfEnd} //Nemesis
  ,
  nsConst,
  Graphics
  {$If defined(Nemesis)}
  ,
  nscTabTableCell
  {$IfEnd} //Nemesis
  ,
  deDocInfo,
  SysUtils,
  MedicMainMenuRes,
  bsDataContainer,
  MainMenuNewRes,
  l3ControlsTypes,
  nsTypes,
  nsLastOpenDocTree,
  vtOutliner,
  mmmMainFeatures,
  mmmReferencePharmaceuticalInformation,
  nsOpenUtils,
  mmmRegulatoryInformation,
  mmmReferencesAndDictionaries,
  nsTabbedInterfaceTypes
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  DataAdapter,
  Common_FormDefinitions_Controls,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmTabbedContainerFormDispatcher
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(DesignTimeLibrary)}
  ,
  evStyleTableSpy
  {$IfEnd} //not DesignTimeLibrary
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TInpharmMainMenuForm;

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}

var
   { Локализуемые строки ut_mmmMainLocalConstants }
  str_ut_mmmMainCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_mmmMainCaption'; rValue : 'ГАРАНТ-ИнФарм');
   { Заголовок пользовательского типа "ГАРАНТ-ИнФарм" }

var
   { Локализуемые строки InpharmMainMenu Local Const }
  str_hfLasOpenDocsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'hfLasOpenDocsCaption'; rValue : 'Последние открытые препараты');
   { 'Последние открытые препараты' }

// start class TInpharmMainMenuForm

function TInpharmMainMenuForm.DoBuildGrid: InscArrangeGrid;
//#UC START# *4AC9B6D00250_4958E868009C_var*
//#UC END# *4AC9B6D00250_4958E868009C_var*
begin
//#UC START# *4AC9B6D00250_4958E868009C_impl*
 Result := TnscArrangeGrid.Make(False);
 with Result do
 begin
  AddColumn;
  AddColumn;
  AddRow;
  AddRow;
  Cell[0, 0] := TnscHideFieldCell.Make(hfReferencesAndDictionaries, True);
  Cell[0, 1] := TnscHideFieldCell.Make(hfMainFeatures, True);
  Cell[1, 0] := TnscHideFieldCell.Make(hfRegulatoryInformation, True);
  Cell[1, 1] := TnscHideFieldCell.Make(hfReferencePharmaceuticalInformation, True);
  MergeCells(2, 0, 1, TnscHideFieldCell.Make(hfLastOpenDocs));
 end;//with Result do
//#UC END# *4AC9B6D00250_4958E868009C_impl*
end;//TInpharmMainMenuForm.DoBuildGrid

procedure TInpharmMainMenuForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4958E868009C_var*
//#UC END# *47EA4E9002C6_4958E868009C_var*
begin
//#UC START# *47EA4E9002C6_4958E868009C_impl*
 inherited;
 // Пытаемся вернуться по истории, пока не дойдем до другой формы,
 // при этом отрезая тот кусок истории, в котором были словарные статьи
 if (not defDataAdapter.IsInpharmExists) then
 begin
  while (((vcmDispatcher.FormDispatcher.CurrentMainForm.AsContainer).HasForm(fm_en_MedicMainMenu.rFormID)) and
   (vcmDispatcher.History.CanBack)) do
    vcmDispatcher.History.Back(True);
 end;
//#UC END# *47EA4E9002C6_4958E868009C_impl*
end;//TInpharmMainMenuForm.FinishDataUpdate

{$If not defined(NoVCM)}
procedure TInpharmMainMenuForm.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_4958E868009C_var*
//#UC END# *49803F5503AA_4958E868009C_var*
begin
//#UC START# *49803F5503AA_4958E868009C_impl*
 inherited;
 CCaption := nil;
 CCaption := str_ut_mmmMainCaption.AsCStr;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=564734118
//#UC END# *49803F5503AA_4958E868009C_impl*
end;//TInpharmMainMenuForm.DoInit
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TInpharmMainMenuForm.InitControls;
//#UC START# *4A8E8F2E0195_4958E868009C_var*
//#UC END# *4A8E8F2E0195_4958E868009C_var*
begin
//#UC START# *4A8E8F2E0195_4958E868009C_impl*
 inherited;
 with pnlMain do
 begin                       
  Align := alClient;
  BevelOuter := bvNone;
  Color := clWhite;
  TabOrder := 0;
 end;
  with hfReferencesAndDictionaries do
  begin
   Left := 16;
   Top := 8;
   Width := 200;
   ClientControl := tvReferencesAndDictionaries;
   ClientIndent := 20;
   Images := dmMedicMainMenuRes.ilMedicMainMenu;
   HeaderImage := 2;
   LeftHeaderIndent := 20;
   LeftImageIndent := 10;
   Options := [];
   TopHeaderIndent := 15;
   TabOrder := 0;
   StyleId := -33;
  end;
   with tvReferencesAndDictionaries do
   begin
    Align := alClient;
    BorderStyle := bsNone;
    TabOrder := 0;
    MultiStrokeItem := True;
    ActionElementMode := l3_amSingleClick;
    ViewOptions := [voShowIcons, voShowExpandable, voWithoutImages];
    ClearTreeStructOnSaveState := False;
    StyleId := -31;
   end;
  with hfReferencePharmaceuticalInformation do
  begin
   Left := 464;
   Top := 112;
   Width := 200;
   ClientControl := tvReferencePharmaceuticalInformation;
   ClientIndent := 20;
   HeaderImage := 1;
   Images := dmMedicMainMenuRes.ilMedicMainMenu;
   LeftHeaderIndent := 20;
   LeftImageIndent := 10;
   Options := [];
   TopHeaderIndent := 15;
   TabOrder := 3;
   StyleId := -33;
  end;
   with tvReferencePharmaceuticalInformation do
   begin
    Left := 20;
    Top := 37;
    Width := 180;
    Height := 63;
    Align := alClient;
    BorderStyle := bsNone;
    TabOrder := 0;
    MultiStrokeItem := True;
    ActionElementMode := l3_amSingleClick;
    ViewOptions := [voShowIcons, voShowExpandable, voWithoutImages];
    ClearTreeStructOnSaveState := False;
    StyleId := -31;
   end;
  with hfMainFeatures do
  begin
   Left := 464;
   Top := 8;
   Width := 200;
   Height := 97;
   ClientControl := tvMainFeatures;
   ClientIndent := 20;
   HeaderImage := 0;
   Images := dmMedicMainMenuRes.ilMedicMainMenu;
   LeftHeaderIndent := 20;
   LeftImageIndent := 10;
   Options := [];
   TopHeaderIndent := 15;
   TabOrder := 1;
   StyleId := -33;
  end;
   with tvMainFeatures do
   begin
    Align := alClient;
    BorderStyle := bsNone;
    TabOrder := 0;
    MultiStrokeItem := True;
    ActionElementMode := l3_amSingleClick;
    ViewOptions := [voShowIcons, voShowExpandable, voWithoutImages];
    ClearTreeStructOnSaveState := False;
    StyleId := -31;
   end;
  with hfRegulatoryInformation do
  begin
   Left := 16;
   Top := 112;
   Width := 200;
   Height := 89;
   ClientControl := tvRegulatoryInformation;
   ClientIndent := 20;
   HeaderImage := 1;
   Images := dmMainMenuNew.ilMainMenuNew;
   LeftHeaderIndent := 20;
   LeftImageIndent := 10;
   Options := [];
   TopHeaderIndent := 15;
   TabOrder := 2;
   StyleId := -33;
  end;
   with tvRegulatoryInformation do
   begin
    Align := alClient;
    BorderStyle := bsNone;
    TabOrder := 0;
    MultiStrokeItem := True;
    ActionElementMode := l3_amSingleClick;
    ViewOptions := [voShowIcons, voShowExpandable, voWithoutImages];
    ClearTreeStructOnSaveState := False;
    StyleId := -31;
   end;
  with hfLastOpenDocs do
  begin
   Left := 16;
   Top := 216;
   Width := 649;
   ButtonCloseImage := 1;
   ButtonImageList := dmMainMenuNew.ilSmallIcons;
   ButtonOpenImage := 0;
   ClientControl := tvLastOpenDocs;
   ClientIndent := 20;
   Caption := str_hfLasOpenDocsCaption.AsStr;
   HeaderImage := 2;
   Images := dmMainMenuNew.ilMainMenuNew;
   LeftHeaderIndent := 20;
   LeftImageIndent := 10;
   Options := [];
   TopHeaderIndent := 15;
   TabOrder := 4;
   StyleId := -33;
  end;
   with tvLastOpenDocs do
   begin
    Align := alClient;
    BorderStyle := bsNone;
    TabOrder := 0;
    MultiStrokeItem := True;
    ActionElementMode := l3_amSingleClick;
    ViewOptions := [voShowInterRowSpace, voShowExpandable, voVariableItemHeight, voWithoutImages];
    ClearTreeStructOnSaveState := False;
    StyleId := -32;
   end;
//#UC END# *4A8E8F2E0195_4958E868009C_impl*
end;//TInpharmMainMenuForm.InitControls
{$IfEnd} //not NoVCM

procedure TInpharmMainMenuForm.DoInitKeyboardNavigation(const aTable: InscTabTable);
//#UC START# *4AC9CB8B01D3_4958E868009C_var*
//#UC END# *4AC9CB8B01D3_4958E868009C_var*
begin
//#UC START# *4AC9CB8B01D3_4958E868009C_impl*
 with aTable.AddColumn do
 begin
  AddItem(TnscTreeViewTabCell.Make(tvReferencesAndDictionaries));
  AddItem(TnscTreeViewTabCell.Make(tvRegulatoryInformation));
  AddItem(TnscHideFieldTabCell.Make(hfLastOpenDocs));
  AddItem(TnscTreeViewTabCell.Make(tvLastOpenDocs));
 end;//with aTable.AddItem do
 with aTable.AddColumn do
 begin
  AddItem(TnscTreeViewTabCell.Make(tvMainFeatures));
  AddItem(TnscTreeViewTabCell.Make(tvReferencePharmaceuticalInformation));
 end;//with aTable.AddItem do
//#UC END# *4AC9CB8B01D3_4958E868009C_impl*
end;//TInpharmMainMenuForm.DoInitKeyboardNavigation

procedure TInpharmMainMenuForm.LoadLastOpenDocs;
//#UC START# *4AC9D12600E0_4958E868009C_var*
//#UC END# *4AC9D12600E0_4958E868009C_var*
begin
//#UC START# *4AC9D12600E0_4958E868009C_impl*
 tvLastOpenDocs.TreeStruct := TnsLastOpenDocTree.Make(afw.Settings.LoadInteger(pi_RecentlyOpenDocumentsCount, dv_RecentlyOpenDocumentsCount), True);
//#UC END# *4AC9D12600E0_4958E868009C_impl*
end;//TInpharmMainMenuForm.LoadLastOpenDocs

procedure TInpharmMainMenuForm.DoActionElement(const aNode: InsMainMenuNode);
//#UC START# *4AC9E19E022B_4958E868009C_var*
  procedure lp_OpenDocument;
  var
   l_DocumentNode: InsDocumentNode;
  begin
   if Supports(aNode,
               InsDocumentNode,
               l_DocumentNode) then
    TdmStdRes.OpenDocument(TdeDocInfo.Make(
                            TbsDocumentContainer.Make(l_DocumentNode.Data)),
                           nil);
  end;
//#UC END# *4AC9E19E022B_4958E868009C_var*
begin
//#UC START# *4AC9E19E022B_4958E868009C_impl*
 case TnsMedicMainMenuNodeType(aNode.NodeType) of
  // Поиск лекарственного средства
  ns_mntSearchDrug:
   TdmStdRes.InpharmSearch(nil, nil, nil);
  // Лекарственные средства
  ns_mntAllDrugList:
   Dispatcher.ModuleOperation(TdmStdRes.mod_opcode_Inpharm_DrugList);
  // Фирмы производители
  ns_mntFirms:
   Dispatcher.ModuleOperation(TdmStdRes.mod_opcode_Inpharm_MedicFirms);
  // Словарь медицинских терминов
  ns_mntDiction:
   Dispatcher.ModuleOperation(TdmStdRes.mod_opcode_Inpharm_MedicDiction);
  // Открыть список
  ns_mntDrugList:
   nsOpenNavigatorItem(aNode, NativeMainForm);
  // Открыть документ по номеру
  ns_mntDocument:
   lp_OpenDocument;
  // Руководство пользователя
  {ns_mntHelp:
   Application.HelpSystem.ShowTopicHelp(cHelpInpharm, '');}
  ns_mntPublishSource:
   TdmStdRes.OpenPharmPublishSearch;
  ns_mntLegislationReview:
   TdmStdRes.OpenPharmLegislationReview;
 else
  Assert(False);
 end;//case TnsMedicMainMenuNodeType(aNode.NodeType)
//#UC END# *4AC9E19E022B_4958E868009C_impl*
end;//TInpharmMainMenuForm.DoActionElement

procedure TInpharmMainMenuForm.LoadTrees;
//#UC START# *4AC9E9EC0064_4958E868009C_var*
//#UC END# *4AC9E9EC0064_4958E868009C_var*
begin
//#UC START# *4AC9E9EC0064_4958E868009C_impl*
 inherited;
 tvReferencesAndDictionaries.TreeStruct := TmmmReferencesAndDictionaries.Make;
 tvReferencePharmaceuticalInformation.TreeStruct := TmmmReferencePharmaceuticalInformation.Make;
 tvMainFeatures.TreeStruct := TmmmMainFeatures.Make;
 tvRegulatoryInformation.TreeStruct := TmmmRegulatoryInformation.Make;
//#UC END# *4AC9E9EC0064_4958E868009C_impl*
end;//TInpharmMainMenuForm.LoadTrees

{$If not defined(NoVCM)}
function TInpharmMainMenuForm.DoGetTabCaption: IvcmCString;
//#UC START# *53F1C6EF02C9_4958E868009C_var*
//#UC END# *53F1C6EF02C9_4958E868009C_var*
begin
//#UC START# *53F1C6EF02C9_4958E868009C_impl*
 CCaption := str_ut_mmmMainCaption.AsCStr;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=564734118
//#UC END# *53F1C6EF02C9_4958E868009C_impl*
end;//TInpharmMainMenuForm.DoGetTabCaption
{$IfEnd} //not NoVCM

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
function TInpharmMainMenuForm.DoGetTabImageIndex: Integer;
//#UC START# *543E3AA801D0_4958E868009C_var*
//#UC END# *543E3AA801D0_4958E868009C_var*
begin
//#UC START# *543E3AA801D0_4958E868009C_impl*
 Result := nsTabIconIndex(titInpharmMainMenu);
//#UC END# *543E3AA801D0_4958E868009C_impl*
end;//TInpharmMainMenuForm.DoGetTabImageIndex
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

procedure TInpharmMainMenuForm.InitEntities;
begin
 inherited;
 {$If not defined(NoVCM)}
 AddUserTypeExclude(ut_mmmMainName, en_Tree, op_ExpandAll, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(ut_mmmMainName, en_Tree, op_CollapseAll, false);
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 AddUserTypeExclude(ut_mmmMainName, en_Tree, op_Wrap, false);
 {$IfEnd} //not NoVCM
end;

procedure TInpharmMainMenuForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_mmmMainName,
  str_ut_mmmMainCaption,
  str_ut_mmmMainCaption,
  true,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_mmmMainName
 pnlMain.Parent := Self;
 hfLastOpenDocs.Parent := pnlMain;
 tvLastOpenDocs.Parent := hfLastOpenDocs;
 f_hfReferencesAndDictionaries := TnscHideField.Create(Self);
 f_hfReferencesAndDictionaries.Name := 'hfReferencesAndDictionaries';
 f_hfReferencesAndDictionaries.Parent := pnlMain;
 f_hfReferencesAndDictionaries.Caption := 'Справочники и словари';
 f_tvReferencesAndDictionaries := TnscTreeViewWithAdapterDragDrop.Create(Self);
 f_tvReferencesAndDictionaries.Name := 'tvReferencesAndDictionaries';
 f_tvReferencesAndDictionaries.Parent := hfReferencesAndDictionaries;
 f_hfReferencePharmaceuticalInformation := TnscHideField.Create(Self);
 f_hfReferencePharmaceuticalInformation.Name := 'hfReferencePharmaceuticalInformation';
 f_hfReferencePharmaceuticalInformation.Parent := pnlMain;
 f_hfReferencePharmaceuticalInformation.Caption := 'Справочная фармацевтическая информация';
 f_tvReferencePharmaceuticalInformation := TnscTreeViewWithAdapterDragDrop.Create(Self);
 f_tvReferencePharmaceuticalInformation.Name := 'tvReferencePharmaceuticalInformation';
 f_tvReferencePharmaceuticalInformation.Parent := hfReferencePharmaceuticalInformation;
 f_hfMainFeatures := TnscHideField.Create(Self);
 f_hfMainFeatures.Name := 'hfMainFeatures';
 f_hfMainFeatures.Parent := pnlMain;
 f_hfMainFeatures.Caption := 'Основные возможности';
 f_tvMainFeatures := TnscTreeViewHotTruck.Create(Self);
 f_tvMainFeatures.Name := 'tvMainFeatures';
 f_tvMainFeatures.Parent := hfMainFeatures;
 f_hfRegulatoryInformation := TnscHideField.Create(Self);
 f_hfRegulatoryInformation.Name := 'hfRegulatoryInformation';
 f_hfRegulatoryInformation.Parent := pnlMain;
 f_hfRegulatoryInformation.Caption := 'Нормативная информация';
 f_tvRegulatoryInformation := TnscTreeViewWithAdapterDragDrop.Create(Self);
 f_tvRegulatoryInformation.Name := 'tvRegulatoryInformation';
 f_tvRegulatoryInformation.Parent := hfRegulatoryInformation;
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_ut_mmmMainCaption
 str_ut_mmmMainCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_hfLasOpenDocsCaption
 str_hfLasOpenDocsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация InpharmMainMenu
 TtfwClassRef.Register(TInpharmMainMenuForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.
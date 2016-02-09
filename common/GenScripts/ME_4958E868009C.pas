unit InpharmMainMenu_Form;
 {* Основное меню Инфарм }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\InpharmMainMenu_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimMainMenu_Form
 {$If Defined(Nemesis)}
 , nscHideField
 {$IfEnd} // Defined(Nemesis)
 , nscTreeViewWithAdapterDragDrop
 {$If Defined(Nemesis)}
 , nscTreeViewHotTruck
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscInterfaces
 {$IfEnd} // Defined(Nemesis)
 , MainMenuDomainInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
 , InpharmMainMenu_ut_mmmMain_UserType
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _vcmChromeLikeTabIconUpdater_Parent_ = TPrimMainMenuForm;
 {$Include vcmChromeLikeTabIconUpdater.imp.pas}
 TInpharmMainMenuForm = {abstract} class(_vcmChromeLikeTabIconUpdater_)
  {* Основное меню Инфарм }
  private
   f_hfReferencesAndDictionaries: TnscHideField;
    {* Поле для свойства hfReferencesAndDictionaries }
   f_tvReferencesAndDictionaries: TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства tvReferencesAndDictionaries }
   f_hfReferencePharmaceuticalInformation: TnscHideField;
    {* Поле для свойства hfReferencePharmaceuticalInformation }
   f_tvReferencePharmaceuticalInformation: TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства tvReferencePharmaceuticalInformation }
   f_hfMainFeatures: TnscHideField;
    {* Поле для свойства hfMainFeatures }
   f_tvMainFeatures: TnscTreeViewHotTruck;
    {* Поле для свойства tvMainFeatures }
   f_hfRegulatoryInformation: TnscHideField;
    {* Поле для свойства hfRegulatoryInformation }
   f_tvRegulatoryInformation: TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства tvRegulatoryInformation }
  protected
   function DoBuildGrid: InscArrangeGrid; override;
   procedure FinishDataUpdate; override;
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure DoInitKeyboardNavigation(const aTable: InscTabTable); override;
   procedure LoadLastOpenDocs; override;
   procedure DoActionElement(const aNode: InsMainMenuNode); override;
   procedure LoadTrees; override;
   {$If NOT Defined(NoVCM)}
   function DoGetTabCaption: IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   function DoGetTabImageIndex: Integer; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 end;//TInpharmMainMenuForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If Defined(Nemesis)}
 , nscArrangeGrid
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , afwFacade
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If Defined(Nemesis)}
 , nscArrangeGridCell
 {$IfEnd} // Defined(Nemesis)
 , nsConst
 , Graphics
 {$If Defined(Nemesis)}
 , nscTabTableCell
 {$IfEnd} // Defined(Nemesis)
 , deDocInfo
 , SysUtils
 , MedicMainMenuRes
 , bsDataContainer
 , MainMenuNewRes
 , l3ControlsTypes
 , nsTypes
 , nsLastOpenDocTree
 , vtOutliner
 , mmmMainFeatures
 , mmmReferencePharmaceuticalInformation
 , nsOpenUtils
 , mmmRegulatoryInformation
 , mmmReferencesAndDictionaries
 , nsTabbedInterfaceTypes
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , DataAdapter
 , Common_FormDefinitions_Controls
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
;

type
 // InpharmMainMenu

const
 {* Локализуемые строки ut_mmmMainLocalConstants }
 str_ut_mmmMainCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_mmmMainCaption'; rValue : 'ГАРАНТ-ИнФарм');
  {* Заголовок пользовательского типа "ГАРАНТ-ИнФарм" }
 {* Локализуемые строки InpharmMainMenu Local Const }
 str_hfLasOpenDocsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'hfLasOpenDocsCaption'; rValue : 'Последние открытые препараты');
  {* 'Последние открытые препараты' }

type _Instance_R_ = TInpharmMainMenuForm;

{$Include vcmChromeLikeTabIconUpdater.imp.pas}

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

{$If NOT Defined(NoVCM)}
procedure TInpharmMainMenuForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TInpharmMainMenuForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
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
{$IfEnd} // NOT Defined(NoVCM)

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

{$If NOT Defined(NoVCM)}
function TInpharmMainMenuForm.DoGetTabCaption: IvcmCString;
//#UC START# *53F1C6EF02C9_4958E868009C_var*
//#UC END# *53F1C6EF02C9_4958E868009C_var*
begin
//#UC START# *53F1C6EF02C9_4958E868009C_impl*
 CCaption := str_ut_mmmMainCaption.AsCStr;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=564734118
//#UC END# *53F1C6EF02C9_4958E868009C_impl*
end;//TInpharmMainMenuForm.DoGetTabCaption
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
function TInpharmMainMenuForm.DoGetTabImageIndex: Integer;
//#UC START# *543E3AA801D0_4958E868009C_var*
//#UC END# *543E3AA801D0_4958E868009C_var*
begin
//#UC START# *543E3AA801D0_4958E868009C_impl*
 Result := nsTabIconIndex(titInpharmMainMenu);
//#UC END# *543E3AA801D0_4958E868009C_impl*
end;//TInpharmMainMenuForm.DoGetTabImageIndex
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

initialization
 str_ut_mmmMainCaption.Init;
 {* Инициализация str_ut_mmmMainCaption }
 str_hfLasOpenDocsCaption.Init;
 {* Инициализация str_hfLasOpenDocsCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TInpharmMainMenuForm);
 {* Регистрация InpharmMainMenu }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

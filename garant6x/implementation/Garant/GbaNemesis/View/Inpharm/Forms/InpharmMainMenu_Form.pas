unit InpharmMainMenu_Form;
 {* �������� ���� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\InpharmMainMenu_Form.pas"
// ���������: "VCMForm"
// ������� ������: "InpharmMainMenu" MUID: (4958E868009C)
// ��� ����: "TInpharmMainMenuForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimMainMenu_Form
 , vtPanel
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
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , MainMenuDomainInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _vcmChromeLikeTabIconUpdater_Parent_ = TPrimMainMenuForm;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}
 TInpharmMainMenuForm = {abstract} class(_vcmChromeLikeTabIconUpdater_)
  {* �������� ���� ������ }
  private
   f_hfReferencesAndDictionaries: TnscHideField;
    {* ����������� � ������� }
   f_tvReferencesAndDictionaries: TnscTreeViewWithAdapterDragDrop;
   f_hfReferencePharmaceuticalInformation: TnscHideField;
    {* ���������� ���������������� ���������� }
   f_tvReferencePharmaceuticalInformation: TnscTreeViewWithAdapterDragDrop;
   f_hfMainFeatures: TnscHideField;
    {* �������� ����������� }
   f_tvMainFeatures: TnscTreeViewHotTruck;
   f_hfRegulatoryInformation: TnscHideField;
    {* ����������� ���������� }
   f_tvRegulatoryInformation: TnscTreeViewWithAdapterDragDrop;
  protected
   function DoBuildGrid: InscArrangeGrid; override;
   procedure FinishDataUpdate; override;
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* ������������� �����. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
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
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property hfReferencesAndDictionaries: TnscHideField
    read f_hfReferencesAndDictionaries;
    {* ����������� � ������� }
   property tvReferencesAndDictionaries: TnscTreeViewWithAdapterDragDrop
    read f_tvReferencesAndDictionaries;
   property hfReferencePharmaceuticalInformation: TnscHideField
    read f_hfReferencePharmaceuticalInformation;
    {* ���������� ���������������� ���������� }
   property tvReferencePharmaceuticalInformation: TnscTreeViewWithAdapterDragDrop
    read f_tvReferencePharmaceuticalInformation;
   property hfMainFeatures: TnscHideField
    read f_hfMainFeatures;
    {* �������� ����������� }
   property tvMainFeatures: TnscTreeViewHotTruck
    read f_tvMainFeatures;
   property hfRegulatoryInformation: TnscHideField
    read f_hfRegulatoryInformation;
    {* ����������� ���������� }
   property tvRegulatoryInformation: TnscTreeViewWithAdapterDragDrop
    read f_tvRegulatoryInformation;
 end;//TInpharmMainMenuForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , InpharmMainMenu_ut_mmmMain_UserType
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
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
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 //#UC START# *4958E868009Cimpl_uses*
 //#UC END# *4958E868009Cimpl_uses*
;

const
 {* ������������ ������ InpharmMainMenu Local Const }
 str_hfLasOpenDocsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'hfLasOpenDocsCaption'; rValue : '��������� �������� ���������');
  {* '��������� �������� ���������' }

type _Instance_R_ = TInpharmMainMenuForm;

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}

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
 // �������� ��������� �� �������, ���� �� ������ �� ������ �����,
 // ��� ���� ������� ��� ����� �������, � ������� ���� ��������� ������
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
 {* ������������� �����. ��� ���������� � �������� }
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
 {* ��������� ������������� ���������. ��� ���������� � �������� }
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
  // ����� �������������� ��������
  ns_mntSearchDrug:
   TdmStdRes.InpharmSearch(nil, nil, nil);
  // ������������� ��������
  ns_mntAllDrugList:
   Dispatcher.ModuleOperation(TdmStdRes.mod_opcode_Inpharm_DrugList);
  // ����� �������������
  ns_mntFirms:
   Dispatcher.ModuleOperation(TdmStdRes.mod_opcode_Inpharm_MedicFirms);
  // ������� ����������� ��������
  ns_mntDiction:
   Dispatcher.ModuleOperation(TdmStdRes.mod_opcode_Inpharm_MedicDiction);
  // ������� ������
  ns_mntDrugList:
   nsOpenNavigatorItem(aNode, NativeMainForm);
  // ������� �������� �� ������
  ns_mntDocument:
   lp_OpenDocument;
  // ����������� ������������
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

{$If NOT Defined(NoVCM)}
procedure TInpharmMainMenuForm.InitEntities;
 {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
begin
 inherited;
 AddUserTypeExclude(ut_mmmMainName, en_Tree, op_ExpandAll, False);
 AddUserTypeExclude(ut_mmmMainName, en_Tree, op_CollapseAll, False);
 AddUserTypeExclude(ut_mmmMainName, en_Tree, op_Wrap, False);
end;//TInpharmMainMenuForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TInpharmMainMenuForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_mmmMainName,
  str_ut_mmmMainCaption,
  str_ut_mmmMainCaption,
  True,
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
 f_hfReferencesAndDictionaries.Caption := '����������� � �������';
 f_tvReferencesAndDictionaries := TnscTreeViewWithAdapterDragDrop.Create(Self);
 f_tvReferencesAndDictionaries.Name := 'tvReferencesAndDictionaries';
 f_tvReferencesAndDictionaries.Parent := hfReferencesAndDictionaries;
 f_hfReferencePharmaceuticalInformation := TnscHideField.Create(Self);
 f_hfReferencePharmaceuticalInformation.Name := 'hfReferencePharmaceuticalInformation';
 f_hfReferencePharmaceuticalInformation.Parent := pnlMain;
 f_hfReferencePharmaceuticalInformation.Caption := '���������� ���������������� ����������';
 f_tvReferencePharmaceuticalInformation := TnscTreeViewWithAdapterDragDrop.Create(Self);
 f_tvReferencePharmaceuticalInformation.Name := 'tvReferencePharmaceuticalInformation';
 f_tvReferencePharmaceuticalInformation.Parent := hfReferencePharmaceuticalInformation;
 f_hfMainFeatures := TnscHideField.Create(Self);
 f_hfMainFeatures.Name := 'hfMainFeatures';
 f_hfMainFeatures.Parent := pnlMain;
 f_hfMainFeatures.Caption := '�������� �����������';
 f_tvMainFeatures := TnscTreeViewHotTruck.Create(Self);
 f_tvMainFeatures.Name := 'tvMainFeatures';
 f_tvMainFeatures.Parent := hfMainFeatures;
 f_hfRegulatoryInformation := TnscHideField.Create(Self);
 f_hfRegulatoryInformation.Name := 'hfRegulatoryInformation';
 f_hfRegulatoryInformation.Parent := pnlMain;
 f_hfRegulatoryInformation.Caption := '����������� ����������';
 f_tvRegulatoryInformation := TnscTreeViewWithAdapterDragDrop.Create(Self);
 f_tvRegulatoryInformation.Name := 'tvRegulatoryInformation';
 f_tvRegulatoryInformation.Parent := hfRegulatoryInformation;
end;//TInpharmMainMenuForm.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_hfLasOpenDocsCaption.Init;
 {* ������������� str_hfLasOpenDocsCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TInpharmMainMenuForm);
 {* ����������� InpharmMainMenu }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

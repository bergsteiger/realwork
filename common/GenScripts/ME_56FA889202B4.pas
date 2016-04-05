unit PrimMainMenuWithProfNews_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\PrimMainMenuWithProfNews_Form.pas"
// Стереотип: "VCMContainer"
// Элемент модели: "PrimMainMenuWithProfNews" MUID: (56FA889202B4)
// Имя типа: "TPrimMainMenuWithProfNewsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimLegalMainMenu_Form
 , MainMenuUnit
 , vtPanel
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoImageEn)}
 , imageenview
 {$IfEnd} // NOT Defined(NoImageEn)
 {$If Defined(Nemesis)}
 , nscHideField
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTreeViewHotTruck
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscFocusLabel
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoImageEn)}
 , imageenio
 {$IfEnd} // NOT Defined(NoImageEn)
 , vtHideField
 {$If Defined(Nemesis)}
 , nscInterfaces
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 // BaseSearchZone

 _vcmChromeLikeTabCaptionProvider_Parent_ = TPrimLegalMainMenuForm;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabCaptionProvider.imp.pas}
 _vcmChromeLikeTabIconUpdater_Parent_ = _vcmChromeLikeTabCaptionProvider_;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}
 TPrimMainMenuWithProfNewsForm = class(_vcmChromeLikeTabIconUpdater_)
  private
   f_CurrentSection: TSectionType;
   f_pnlLeft: TvtPanel;
    {* Поле для свойства pnlLeft }
   f_bvlLeftTop: TBevel;
    {* Поле для свойства bvlLeftTop }
   f_pbLogo: TPaintBox;
    {* Поле для свойства pbLogo }
   f_ieBanner: TImageEnView;
    {* Поле для свойства ieBanner }
   f_pbCourtsOnline: TPaintBox;
    {* Поле для свойства pbCourtsOnline }
   f_pbIntranet: TPaintBox;
    {* Поле для свойства pbIntranet }
   f_pbOnline: TPaintBox;
    {* Поле для свойства pbOnline }
   f_pnlClient: TvtPanel;
    {* Поле для свойства pnlClient }
   f_pnlNews: TvtPanel;
    {* Поле для свойства pnlNews }
   f_hfProfNews: TnscHideField;
    {* Поле для свойства hfProfNews }
   f_tvProfNews: TnscTreeViewHotTruck;
    {* Поле для свойства tvProfNews }
   f_pnlBaseSearch: TvtPanel;
    {* Поле для свойства pnlBaseSearch }
   f_pnlBaseSearchZone: TvtPanel;
    {* Поле для свойства pnlBaseSearchZone }
   f_pnlSearches: TvtPanel;
    {* Поле для свойства pnlSearches }
   f_flAttributeSearch: TnscFocusLabel;
    {* Поле для свойства flAttributeSearch }
   f_flDictionSearch: TnscFocusLabel;
    {* Поле для свойства flDictionSearch }
   f_flPublishedSourceSearch: TnscFocusLabel;
    {* Поле для свойства flPublishedSourceSearch }
   f_flSituationSearch: TnscFocusLabel;
    {* Поле для свойства flSituationSearch }
   f_pnlTrees: TvtPanel;
    {* Поле для свойства pnlTrees }
   f_hfTaxes: TnscHideField;
    {* Поле для свойства hfTaxes }
   f_tvTaxes: TnscTreeViewHotTruck;
    {* Поле для свойства tvTaxes }
   f_bvlLeft: TBevel;
    {* Поле для свойства bvlLeft }
   f_bvlRight: TBevel;
    {* Поле для свойства bvlRight }
   f_ieIO: TImageEnIO;
    {* Поле для свойства ieIO }
  private
   procedure TaxesStateChanged(aSender: TObject;
    var theState: ThfState);
   procedure UpdateTaxesTree;
   procedure UpdateTaxesTreeCaption;
   procedure UpdateReferencesAndLawNewsCaptions;
   procedure ReferencesResize(Sender: TObject);
   procedure TaxesNextTree(Sender: TObject);
   procedure UpdateSearchLabels;
   procedure SearchClick(Sender: TObject);
  protected
   function DoBuildGrid: InscArrangeGrid; override;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure LoadLastOpenDocs; override;
   procedure LoadTrees; override;
   function pm_GetContainerForBaseSearch: IvcmContainer; override;
   function NewSchool: Boolean; override;
    {* Определяет, что основное меню вида 2009 - [$164601183] }
   {$If NOT Defined(NoVCM)}
   procedure SetControlsResources; override;
    {* Установить контролам ресурсы для интернационализации }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   function DoGetTabCaption: IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   function DoGetFormSetTabCaption: IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   function DoGetTabImageIndex: Integer; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
  public
   property bvlLeft: TBevel
    read f_bvlLeft;
   property bvlRight: TBevel
    read f_bvlRight;
   property ieIO: TImageEnIO
    read f_ieIO;
 end;//TPrimMainMenuWithProfNewsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , PrimMainMenuWithProfNews_utMainMenuWithProfNews_UserType
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Graphics
 , smChangeableTree
 , nsLastOpenDocTree
 , nsTypes
 , l3String
 , IOUnit
 , Classes
 {$If NOT Defined(NoImageEn)}
 , hyiedefs
 {$IfEnd} // NOT Defined(NoImageEn)
 , SysUtils
 , nsExternalObjectPrim
 , ExternalObjectUnit
 , BaseTypesUnit
 , DataAdapter
 {$If NOT Defined(NoImageEn)}
 , iemview
 {$IfEnd} // NOT Defined(NoImageEn)
 , nsConst
 , nsTabbedInterfaceTypes
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , afwInterfaces
 , DocumentRes
 , MainMenuNewRes
 {$If Defined(Nemesis)}
 , f1TextStyle_Const
 {$IfEnd} // Defined(Nemesis)
 , l3ControlsTypes
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
 , afwFacade
;

type
 // ExcludeTree

const
 {* Локализуемые строки utMainMenuWithProfNewsLocalConstants }
 str_utMainMenuWithProfNewsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utMainMenuWithProfNewsCaption'; rValue : 'Основное меню с профессиональными новостями');
  {* Заголовок пользовательского типа "Основное меню с профессиональными новостями" }

type _Instance_R_ = TPrimMainMenuWithProfNewsForm;

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabCaptionProvider.imp.pas}

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}

procedure TPrimMainMenuWithProfNewsForm.TaxesStateChanged(aSender: TObject;
 var theState: ThfState);
//#UC START# *56FBC3F90034_56FA889202B4_var*
//#UC END# *56FBC3F90034_56FA889202B4_var*
begin
//#UC START# *56FBC3F90034_56FA889202B4_impl*
 theState := hfsShow;
 //TaxesNextTree(Sender);
//#UC END# *56FBC3F90034_56FA889202B4_impl*
end;//TPrimMainMenuWithProfNewsForm.TaxesStateChanged

procedure TPrimMainMenuWithProfNewsForm.UpdateTaxesTree;
//#UC START# *56FBC41602A9_56FA889202B4_var*
//#UC END# *56FBC41602A9_56FA889202B4_var*
begin
//#UC START# *56FBC41602A9_56FA889202B4_impl*
 UpdateTaxesTreeCaption;
 tvTaxes.TreeStruct := TsmChangeableTree.Make(ST_BUDGET_ORGS);
//#UC END# *56FBC41602A9_56FA889202B4_impl*
end;//TPrimMainMenuWithProfNewsForm.UpdateTaxesTree

procedure TPrimMainMenuWithProfNewsForm.UpdateTaxesTreeCaption;
//#UC START# *56FBC4240324_56FA889202B4_var*
var
 l_Sect: ISection;
 l_S: IString;
//#UC END# *56FBC4240324_56FA889202B4_var*
begin
//#UC START# *56FBC4240324_56FA889202B4_impl*
 DefDataAdapter.NativeAdapter.MakeMainMenu.GetSection(ST_BUDGET_ORGS, l_Sect);
 Assert(l_Sect <> nil);
 l_Sect.GetCaption(l_S);
 Assert(l_S <> nil);
 hfTaxes.Caption := l3Str(nsCStr(l_S));
//#UC END# *56FBC4240324_56FA889202B4_impl*
end;//TPrimMainMenuWithProfNewsForm.UpdateTaxesTreeCaption

procedure TPrimMainMenuWithProfNewsForm.UpdateReferencesAndLawNewsCaptions;
//#UC START# *56FBC4350226_56FA889202B4_var*
var
 l_Sect: ISection;
 l_S: IString;
//#UC END# *56FBC4350226_56FA889202B4_var*
begin
//#UC START# *56FBC4350226_56FA889202B4_impl*
 DefDataAdapter.NativeAdapter.MakeMainMenu.GetSection(ST_BUSINESS_REFERENCES, l_Sect);
 Assert(l_Sect <> nil);
 try
  l_Sect.GetCaption(l_S);
 finally
  l_Sect := nil
 end;//try..finally
 Assert(l_S <> nil);
 try
  hfReferences.Caption := l3Str(nsCStr(l_S));
 finally
  l_S := nil;
 end;//try..finally
//#UC END# *56FBC4350226_56FA889202B4_impl*
end;//TPrimMainMenuWithProfNewsForm.UpdateReferencesAndLawNewsCaptions

procedure TPrimMainMenuWithProfNewsForm.ReferencesResize(Sender: TObject);
//#UC START# *56FBD187013A_56FA889202B4_var*
//#UC END# *56FBD187013A_56FA889202B4_var*
begin
//#UC START# *56FBD187013A_56FA889202B4_impl*
 //
//#UC END# *56FBD187013A_56FA889202B4_impl*
end;//TPrimMainMenuWithProfNewsForm.ReferencesResize

procedure TPrimMainMenuWithProfNewsForm.TaxesNextTree(Sender: TObject);
//#UC START# *56FBD27503D1_56FA889202B4_var*
//#UC END# *56FBD27503D1_56FA889202B4_var*
begin
//#UC START# *56FBD27503D1_56FA889202B4_impl*
 //
//#UC END# *56FBD27503D1_56FA889202B4_impl*
end;//TPrimMainMenuWithProfNewsForm.TaxesNextTree

procedure TPrimMainMenuWithProfNewsForm.UpdateSearchLabels;
//#UC START# *56FCF6290256_56FA889202B4_var*
const
  c_SearchLabelDistance = 18;
//#UC END# *56FCF6290256_56FA889202B4_var*
begin
//#UC START# *56FCF6290256_56FA889202B4_impl*
 flSituationSearch.Visible := Assigned(DefDataAdapter) and DefDataAdapter.IsExists_KeyWordTag;
 with flPublishedSourceSearch do
 begin
  if flSituationSearch.Visible then
   Left := c_SearchLabelDistance + flSituationSearch.Left + flSituationSearch.Width
  else
   Left := c_SearchLabelDistance + flAttributeSearch.Left + flAttributeSearch.Width;
  Visible := Assigned(DefDataAdapter) and DefDataAdapter.IsExists_PublishSourceTag;
 end;//flPublishedSourceSearch
 with flDictionSearch do
 begin
  if flPublishedSourceSearch.Visible then
   Left := c_SearchLabelDistance + flPublishedSourceSearch.Left + flPublishedSourceSearch.Width
  else
   if flSituationSearch.Visible then
    Left := c_SearchLabelDistance + flSituationSearch.Left + flSituationSearch.Width
   else
    Left := c_SearchLabelDistance + flAttributeSearch.Left + flAttributeSearch.Width;
  Visible := Assigned(DefDataAdapter) and DefDataAdapter.IsExplanatoryExists;
 end;//flDictionSearch
//#UC END# *56FCF6290256_56FA889202B4_impl*
end;//TPrimMainMenuWithProfNewsForm.UpdateSearchLabels

procedure TPrimMainMenuWithProfNewsForm.SearchClick(Sender: TObject);
//#UC START# *56FD0A30011C_56FA889202B4_var*
//#UC END# *56FD0A30011C_56FA889202B4_var*
begin
//#UC START# *56FD0A30011C_56FA889202B4_impl*
 if (Sender = flAttributeSearch) then
  //TdmStdRes.OpenQuery(lg_qtAttribute, nil, nil)
 else
 if (Sender = flSituationSearch) then
  //TdmStdRes.OpenQuery(lg_qtKeyWord, nil, nil)
 else
 if (Sender = flPublishedSourceSearch) then
  //TdmStdRes.OpenQuery(lg_qtPublishedSource, nil, nil)
 else
 if (Sender = flDictionSearch) then
  //TdmStdRes.OpenDictionary(nil, NativeMainForm)
 else
  Assert(False);
//#UC END# *56FD0A30011C_56FA889202B4_impl*
end;//TPrimMainMenuWithProfNewsForm.SearchClick

function TPrimMainMenuWithProfNewsForm.DoBuildGrid: InscArrangeGrid;
//#UC START# *4AC9B6D00250_56FA889202B4_var*
//#UC END# *4AC9B6D00250_56FA889202B4_var*
begin
//#UC START# *4AC9B6D00250_56FA889202B4_impl*
 Result := nil;
//#UC END# *4AC9B6D00250_56FA889202B4_impl*
end;//TPrimMainMenuWithProfNewsForm.DoBuildGrid

{$If NOT Defined(NoVCM)}
procedure TPrimMainMenuWithProfNewsForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_56FA889202B4_var*
 procedure lp_SetupButtons(const aControls: array of TControl);
 var
  I: Integer;
 begin
  for I := Low(aControls) to High(aControls) do
  begin
   if aControls[I] is TvtPanel then
    with aControls[I] as TvtPanel do
    begin
     BevelOuter := bvNone;
     Align := alTop;
     Color := clWhite;
     Height := dmMainMenuNew.ilButtonsNew.Height + 30;
    end
   else
   if aControls[I] is TPaintBox then
    with aControls[I] as TPaintBox do
    begin
     Top := 0;
     Left := 0;
     Height := dmMainMenuNew.ilButtonsNew.Height + 1;
     Width := dmMainMenuNew.ilButtonsNew.Width + 1;
     OnPaint := Self.PaintButton;
     OnClick := PaintBoxClick;
     Cursor := crHandPoint;
    end
   else
    Assert(False);
  end;

  pnlWebVersion.Visible := afw.Application.LocaleInfo.Language = afw_lngRussian;
 end; // lp_SetupButtons

 procedure lp_SetupTrees;
 var
  I: Integer;
 begin
  for I := 0 to Pred(ComponentCount) do
   if (Components[I] is TnscHideField) then
   begin
    TnscHideField(Components[I]).StyleId := f1_saNewSchoolMainMenuHeader;
    TnscHideField(Components[I]).HeaderImage := -1;
    TnscHideField(Components[I]).TabStop := false;
   end//Components[l_Index] is TnscHideField
   else
   if (Components[I] is TnscTreeViewHotTruck) then
   begin
    TnscTreeViewHotTruck(Components[I]).TreatDefaultColorAsWindowColor := False;
    TnscTreeViewHotTruck(Components[I]).StyleID := f1_saNewSchoolMainMenuConstPath;
    TnscTreeViewHotTruck(Components[I]).Color := clWhite;
   end;
 end; // lp_SetupTrees

const
 c_SearchLabelDistance = 18;
//#UC END# *4A8E8F2E0195_56FA889202B4_var*
begin
//#UC START# *4A8E8F2E0195_56FA889202B4_impl*
 inherited;
 Self.Color := clWhite;
 bvlLeft.Align := alLeft;
 bvlLeft.Width := 25;
 bvlLeft.Shape := bsSpacer;
 bvlRight.Align := alRight;
 bvlRight.Width := 25;
 bvlRight.Shape := bsSpacer;
 with pnlMain do
 begin
  BevelOuter := bvNone;
  Color := clWhite;
  TabOrder := 0;
 end;
 with pnlLeft do
 begin
  Align := alLeft;
  BevelOuter := bvNone;
  Color := clWhite;
  Width := 235;
 end;
 with pnlClient do
 begin
  Align := alNone;
  BevelOuter := bvNone;
  Color := clWhite;
 end;
 with pnlNews do
 begin
  Align := alTop;
  BevelOuter := bvNone;
  Color := clWhite;
  Height := 200;
 end;
 with pnlBaseSearch do
 begin
  BevelOuter := bvNone;
  Color := clWhite;
  Align := alTop;
  Height := 145;
  Top := 201;
  with pnlBaseSearchZone do
  begin
   Align := alTop;
   BevelOuter := bvNone;
   Color := clWhite;
  end;
  with pnlSearches do
  begin
   Align := alBottom;
   BevelOuter := bvNone;
   Color := clWhite;
   Height := 20;
   with flAttributeSearch do
   begin
    Left := 15;
    AutoWidth := True;
    AllowTrucking := True;
    HighlightColor := c_MainMenuColor;
    TextColor := c_MainMenuColor;
    Cursor := crHandPoint;
    OnClick := SearchClick;
   end;//flAttributeSearch
   with flSituationSearch do
   begin
    Left := c_SearchLabelDistance + flAttributeSearch.Left + flAttributeSearch.Width;
    AutoWidth := True;
    AllowTrucking := True;
    HighlightColor := c_MainMenuColor;
    TextColor := c_MainMenuColor;
    Cursor := crHandPoint;
    OnClick := SearchClick;
   end;//flSituationSearch
   with flPublishedSourceSearch do
   begin
    Left := c_SearchLabelDistance + flSituationSearch.Left + flSituationSearch.Width;
    AutoWidth := True;
    AllowTrucking := True;
    HighlightColor := c_MainMenuColor;
    TextColor := c_MainMenuColor;
    Cursor := crHandPoint;
    OnClick := SearchClick;
   end;//flPublishedSourceSearch
   with flDictionSearch do
   begin
    Left := c_SearchLabelDistance + flPublishedSourceSearch.Left + flPublishedSourceSearch.Width;
    AutoWidth := True;
    AllowTrucking := True;
    HighlightColor := c_MainMenuColor;
    TextColor := c_MainMenuColor;
    Cursor := crHandPoint;
    OnClick := SearchClick;
   end;//flDictionSearch
   UpdateSearchLabels;
  end;
 end;
 with pnlTrees do
 begin
  Align := alTop;
  BevelOuter := bvNone;
  Color := clWhite;
  Height := 200;
  Top := 401;
 end;

 bvlLeftTop.Align := alTop;
 bvlLeftTop.Height := 200;
 bvlLeftTop.Shape := bsSpacer;

 ieBanner.Height := 200;
 ieBanner.Width := pnlBanner.ClientWidth;

 with hfProfNews do
 begin
  TopHeaderIndent := 30;

  Align := alClient;
  Left := 16;
  //Top := 62;
  Width := 377;
  Height := 107;
  ButtonCloseImage := 1;
  ButtonImageList := dmMainMenuNew.ilSmallIcons;
  ButtonOpenImage := 0;
  ClientControl := tvProfNews;
  ClientIndent := 20;
  HeaderImage := 2;
  Images := dmMainMenuNew.ilMainMenuNew;
  LeftHeaderIndent := 20;
  LeftImageIndent := 10;
  Options := [];
  TabOrder := 0;
  SettingId := 'sthfLastOpenDocs';
 end;
  with tvProfNews do
  begin
   AllowTrucking := True;

   Align := alClient;
   BorderStyle := bsNone;
   TabOrder := 0;
   MultiStrokeItem := True;
   ActionElementMode := l3_amSingleClick;
   ViewOptions := [voShowInterRowSpace, voShowExpandable, voVariableItemHeight, voWithoutImages];
   ClearTreeStructOnSaveState := False;
  end;

 with hfLastOpenDocs do
 begin
  TopHeaderIndent := 30;

  Align := alTop;
  Left := 16;
  //Top := 62;
  Width := 377;
  Height := 107;
  ButtonCloseImage := 1;
  ButtonImageList := dmMainMenuNew.ilSmallIcons;
  ButtonOpenImage := 0;
  ClientControl := tvLastOpenDocs;
  ClientIndent := 20;
  HeaderImage := 2;
  Images := dmMainMenuNew.ilMainMenuNew;
  LeftHeaderIndent := 20;
  LeftImageIndent := 10;
  Options := [];
  TabOrder := 0;
  SettingId := 'sthfLastOpenDocs';
 end;
  with tvLastOpenDocs do
  begin
   AllowTrucking := True;

   Align := alTop;
   BorderStyle := bsNone;
   TabOrder := 0;
   MultiStrokeItem := True;
   ActionElementMode := l3_amSingleClick;
   ViewOptions := [voShowInterRowSpace, voShowExpandable, voVariableItemHeight, voWithoutImages];
   ClearTreeStructOnSaveState := False;
  end;

 with hfReferences do
 begin
  Align := alClient;
  Left := 24;
  Top := 168;
  Height := 150;
  Width := 390;
  TopHeaderIndent := 20;
  ClientControl := tvReferences;
  ClientIndent := 20;
  HeaderImage := 1;
  Images := dmMainMenuNew.ilMainMenuNew;
  LeftHeaderIndent := 20;
  LeftImageIndent := 10;
  Options := [];
  TabOrder := 1;
 end;
  with tvReferences do
  begin
   AllowTrucking := True;

   Align := alClient;
   BorderStyle := bsNone;
   TabOrder := 0;
   MultiStrokeItem := True;
   ActionElementMode := l3_amSingleClick;
   ViewOptions := [voShowIcons, voShowExpandable, voWithoutImages];
   ClearTreeStructOnSaveState := False;
   OnResize := ReferencesResize;
  end;

 with hfLawNews do
 begin
  Align := alRight;
  Width := 390;
  ClientControl := tvLawNews;
  ClientIndent := 20;
  HeaderImage := 0;
  Images := dmMainMenuNew.ilMainMenuNew;
  LeftHeaderIndent := 20;
  LeftImageIndent := 10;
  Options := [];
  TopHeaderIndent := 20;
  TabOrder := 2;
 end;
  with tvLawNews do
  begin
   AllowTrucking := True;
   Align := alClient;
   BorderStyle := bsNone;
   TabOrder := 0;
   MultiStrokeItem := False;//True;
   ActionElementMode := l3_amSingleClick;
   ViewOptions := [voShowIcons, voShowExpandable, voWithoutImages];
   ClearTreeStructOnSaveState := False;
  end;

 with hfTaxes do
 begin
  Align := alRight;
  Height := hfReferences.Height;
  Width := 380;
  ClientIndent := 15;
  LeftHeaderIndent := 15;
  TopHeaderIndent := 20;
  ClientControl := tvTaxes;
  Options := [hfoCanHide, hfoHyperlink];
  ButtonImageList := nsDocumentRes.MainMenuImageList;
  if afw.Application.LocaleInfo.Language = afw_lngEnglish then
  begin
   ButtonOpenImage := 1;
   ButtonCloseImage := 1;
  end else
  begin
   ButtonOpenImage := 0;
   ButtonCloseImage := 0;
  end;
  OnValidateStateChanged := TaxesStateChanged;
  OnHyperlinkClick := nil;//TaxesNextTree;
 end;//with hfTaxes
  with tvTaxes do
  begin
   Width := 380;
   Align := alClient;
   BorderStyle := bsNone;
   MultiStrokeItem := True;
   ActionElementMode := l3_amSingleClick;
   ViewOptions := [voShowIcons, voShowExpandable, voWithoutImages];
   ClearTreeStructOnSaveState := False;
   AllowTrucking := True;
  end;//with tvTaxes

 with pnlLogo do
 begin
  BevelOuter := bvNone;
  Align := alTop;
  Color := clWhite;
 end;
 with pbLogo do
 begin
  Top := 0;
  Left := 0;
  Height := 59;
  Width := 200;
  OnPaint := Self.PaintLogo;
 end;

 with pnlBanner do
 begin
  Align := alTop;
  BevelOuter := bvNone;
  Color := clWhite;
 end;
  with ieBanner do
  begin
   Top := 20;
   Left := 10;
   Width := 310;
   Height := 90;
   Cursor := crHandPoint;
   BorderStyle := bsNone;
   LegacyBitmap := False;
   ZoomFilter := rfLanczos3;
   MouseInteract := [miScroll];
   DelayZoomFilter := True;
   AutoFit := false;
   OnClick := BannerClick;
   MouseWheelParams.Action := iemwNone;
  end;//ieBanner

 lp_SetupButtons([pnlFeedback,
                  pbFeedback,
                  pnlWebVersion,
                  pbWebVersion,
                  pnlOnlineResources,
                  pbOnLineResources]);

 lp_SetupTrees;
 ArrangeControls;
//#UC END# *4A8E8F2E0195_56FA889202B4_impl*
end;//TPrimMainMenuWithProfNewsForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimMainMenuWithProfNewsForm.LoadLastOpenDocs;
//#UC START# *4AC9D12600E0_56FA889202B4_var*
var
 l_DocCount: Integer;
//#UC END# *4AC9D12600E0_56FA889202B4_var*
begin
//#UC START# *4AC9D12600E0_56FA889202B4_impl*
 l_DocCount := afw.Settings.LoadInteger(pi_RecentlyOpenDocumentsCount, dv_RecentlyOpenDocumentsCount);
 tvLastOpenDocs.TreeStruct := TnsLastOpenDocTree.Make(l_DocCount, False, True);
//#UC END# *4AC9D12600E0_56FA889202B4_impl*
end;//TPrimMainMenuWithProfNewsForm.LoadLastOpenDocs

procedure TPrimMainMenuWithProfNewsForm.LoadTrees;
//#UC START# *4AC9E9EC0064_56FA889202B4_var*
//#UC END# *4AC9E9EC0064_56FA889202B4_var*
begin
//#UC START# *4AC9E9EC0064_56FA889202B4_impl*
 inherited;
 UpdateTaxesTree;
 UpdateReferencesAndLawNewsCaptions;
//#UC END# *4AC9E9EC0064_56FA889202B4_impl*
end;//TPrimMainMenuWithProfNewsForm.LoadTrees

function TPrimMainMenuWithProfNewsForm.pm_GetContainerForBaseSearch: IvcmContainer;
//#UC START# *4ACA197F0147_56FA889202B4get_var*
//#UC END# *4ACA197F0147_56FA889202B4get_var*
begin
//#UC START# *4ACA197F0147_56FA889202B4get_impl*
 Result := Self;
//#UC END# *4ACA197F0147_56FA889202B4get_impl*
end;//TPrimMainMenuWithProfNewsForm.pm_GetContainerForBaseSearch

function TPrimMainMenuWithProfNewsForm.NewSchool: Boolean;
 {* Определяет, что основное меню вида 2009 - [$164601183] }
//#UC START# *4ACB2F98002B_56FA889202B4_var*
//#UC END# *4ACB2F98002B_56FA889202B4_var*
begin
//#UC START# *4ACB2F98002B_56FA889202B4_impl*
 Result := True;
//#UC END# *4ACB2F98002B_56FA889202B4_impl*
end;//TPrimMainMenuWithProfNewsForm.NewSchool

{$If NOT Defined(NoVCM)}
procedure TPrimMainMenuWithProfNewsForm.SetControlsResources;
 {* Установить контролам ресурсы для интернационализации }
//#UC START# *4B62D10B031B_56FA889202B4_var*
//#UC END# *4B62D10B031B_56FA889202B4_var*
begin
//#UC START# *4B62D10B031B_56FA889202B4_impl*
 inherited;
 flAttributeSearch.Hint := 'Открыть карточку поиска по реквизитам';
 flSituationSearch.Hint := 'Открыть энциклопедию ситуаций';
 flPublishedSourceSearch.Hint := 'Открыть поиск по источнику опубликования';
 flDictionSearch.Hint := 'Открыть Толковый словарь правовых и финансовых терминов';

 flAttributeSearch.ShowHint := True;
 flSituationSearch.ShowHint := True;
 flPublishedSourceSearch.ShowHint := True;
 flDictionSearch.ShowHint := True;
//#UC END# *4B62D10B031B_56FA889202B4_impl*
end;//TPrimMainMenuWithProfNewsForm.SetControlsResources
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimMainMenuWithProfNewsForm.ClearFields;
//#UC START# *5000565C019C_56FA889202B4_var*
//#UC END# *5000565C019C_56FA889202B4_var*
begin
//#UC START# *5000565C019C_56FA889202B4_impl*
 f_Banner := nil;
 inherited;
//#UC END# *5000565C019C_56FA889202B4_impl*
end;//TPrimMainMenuWithProfNewsForm.ClearFields

{$If NOT Defined(NoVCM)}
function TPrimMainMenuWithProfNewsForm.DoGetTabCaption: IvcmCString;
//#UC START# *53F1C6EF02C9_56FA889202B4_var*
//#UC END# *53F1C6EF02C9_56FA889202B4_var*
begin
//#UC START# *53F1C6EF02C9_56FA889202B4_impl*
 Result := vcmCStr(str_utMainMenuWithProfNewsCaption);
//#UC END# *53F1C6EF02C9_56FA889202B4_impl*
end;//TPrimMainMenuWithProfNewsForm.DoGetTabCaption
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
function TPrimMainMenuWithProfNewsForm.DoGetFormSetTabCaption: IvcmCString;
//#UC START# *54058CBC0182_56FA889202B4_var*
//#UC END# *54058CBC0182_56FA889202B4_var*
begin
//#UC START# *54058CBC0182_56FA889202B4_impl*
 Result := DoGetTabCaption;
//#UC END# *54058CBC0182_56FA889202B4_impl*
end;//TPrimMainMenuWithProfNewsForm.DoGetFormSetTabCaption
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
function TPrimMainMenuWithProfNewsForm.DoGetTabImageIndex: Integer;
//#UC START# *543E3AA801D0_56FA889202B4_var*
//#UC END# *543E3AA801D0_56FA889202B4_var*
begin
//#UC START# *543E3AA801D0_56FA889202B4_impl*
 Result := nsTabIconIndex(titMain);
//#UC END# *543E3AA801D0_56FA889202B4_impl*
end;//TPrimMainMenuWithProfNewsForm.DoGetTabImageIndex
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

initialization
 str_utMainMenuWithProfNewsCaption.Init;
 {* Инициализация str_utMainMenuWithProfNewsCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimMainMenuWithProfNewsForm);
 {* Регистрация PrimMainMenuWithProfNews }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

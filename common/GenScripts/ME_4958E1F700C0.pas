unit PrimMainMenuNew_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\PrimMainMenuNew_Form.pas"
// Стереотип: "VCMContainer"
// Элемент модели: "PrimMainMenuNew" MUID: (4958E1F700C0)
// Имя типа: "TPrimMainMenuNewForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimLegalMainMenu_Form
 , BannerUnit
 , MainMenuUnit
 , vtPanel
 {$If NOT Defined(NoImageEn)}
 , imageenio
 {$IfEnd} // NOT Defined(NoImageEn)
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If Defined(Nemesis)}
 , nscFocusLabel
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscHideField
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTreeViewHotTruck
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoImageEn)}
 , imageenview
 {$IfEnd} // NOT Defined(NoImageEn)
 , ExternalObjectUnit
 , Classes
 , IOUnit
 , BaseTypesUnit
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
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
 _vcmChromeLikeTabCaptionProvider_Parent_ = TPrimLegalMainMenuForm;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabCaptionProvider.imp.pas}
 _vcmChromeLikeTabIconUpdater_Parent_ = _vcmChromeLikeTabCaptionProvider_;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}
 TPrimMainMenuNewForm = {abstract} class(_vcmChromeLikeTabIconUpdater_)
  private
   f_Banner: IBanner;
   f_CurrentSection: TSectionType;
   f_ieIO: TImageEnIO;
   f_pnlBaseSearch: TvtPanel;
   f_pnlBaseSearchZone: TvtPanel;
   f_pnlLogo: TvtPanel;
   f_pbLogo: TPaintBox;
   f_pnlSearches: TvtPanel;
   f_flAttributeSearch: TnscFocusLabel;
    {* • По реквизитам }
   f_flSituationSearch: TnscFocusLabel;
    {* • По ситуации }
   f_flPublishedSourceSearch: TnscFocusLabel;
    {* • По источнику опубликования }
   f_flDictionSearch: TnscFocusLabel;
    {* • По Толковому словарю }
   f_pnlExpert: TvtPanel;
   f_pbExpert: TPaintBox;
   f_pnlOnLine: TvtPanel;
   f_pbOnLine: TPaintBox;
   f_pbIntranet: TPaintBox;
   f_pbCourtsOnline: TPaintBox;
    {* Онлайн-архив }
   f_hfTaxes: TnscHideField;
    {* Налоги, финансы }
   f_tvTaxes: TnscTreeViewHotTruck;
   f_pnlBanner: TvtPanel;
   f_ieBanner: TImageEnView;
   f_hfLastOpenDocsRightEdge: TvtPanel;
  private
   procedure BaseSearchPanelResize(aSender: TObject);
   procedure PaintLogo(aSender: TObject);
   procedure PaintButton(aSender: TObject);
   procedure ExpertClick(aSender: TObject);
   procedure OnLineClick(aSender: TObject);
   procedure SearchClick(aSender: TObject);
   procedure LoadBanner;
   procedure BannerClick(aSender: TObject);
   procedure UpdateBaseSearchFormHeight(aForm: TForm);
   procedure BaseSearchFormResize(aSender: TObject);
   procedure ReferencesResize(aSender: TObject);
   procedure UpdateSearchLabels;
   procedure IntranetClick(aSender: TObject);
   procedure TaxesStateChanged(aSender: TObject;
    var theState: ThfState);
   procedure UpdateTaxesTree;
   procedure TaxesNextTree(aSender: TObject);
   procedure UpdateTaxesTreeCaption;
   procedure UpdateReferencesAndLawNewsCaptions;
   procedure CourtsOnlineClick(aSender: TObject);
   function GetSearchLabelsLineFullWidth: Integer;
   procedure UpdatePbExpertPosition;
  protected
   function DoBuildGrid: InscArrangeGrid; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure FinishDataUpdate; override;
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
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
   procedure DoInitKeyboardNavigation(const aTable: InscTabTable); override;
   procedure LoadLastOpenDocs; override;
   procedure LoadTrees; override;
   function pm_GetContainerForBaseSearch: IvcmContainer; override;
   function NewSchool: Boolean; override;
    {* Определяет, что основное меню вида 2009 - [$164601183] }
   procedure DoRecalcGrid(const aGrid: InscArrangeGrid); override;
   {$If NOT Defined(NoVCM)}
   function InsertForm(const aForm: IvcmEntityForm): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SetControlsResources; override;
    {* Установить контролам ресурсы для интернационализации }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure RestoreControlSize; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoGetTabCaption: IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   function DoGetFormSetTabCaption: IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   function DoGetTabImageIndex: Integer; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property ieIO: TImageEnIO
    read f_ieIO;
   property pnlBaseSearch: TvtPanel
    read f_pnlBaseSearch;
   property pnlBaseSearchZone: TvtPanel
    read f_pnlBaseSearchZone;
   property pnlLogo: TvtPanel
    read f_pnlLogo;
   property pbLogo: TPaintBox
    read f_pbLogo;
   property pnlSearches: TvtPanel
    read f_pnlSearches;
   property flAttributeSearch: TnscFocusLabel
    read f_flAttributeSearch;
    {* • По реквизитам }
   property flSituationSearch: TnscFocusLabel
    read f_flSituationSearch;
    {* • По ситуации }
   property flPublishedSourceSearch: TnscFocusLabel
    read f_flPublishedSourceSearch;
    {* • По источнику опубликования }
   property flDictionSearch: TnscFocusLabel
    read f_flDictionSearch;
    {* • По Толковому словарю }
   property pnlExpert: TvtPanel
    read f_pnlExpert;
   property pbExpert: TPaintBox
    read f_pbExpert;
   property pnlOnLine: TvtPanel
    read f_pnlOnLine;
   property pbOnLine: TPaintBox
    read f_pbOnLine;
   property pbIntranet: TPaintBox
    read f_pbIntranet;
   property pbCourtsOnline: TPaintBox
    read f_pbCourtsOnline;
    {* Онлайн-архив }
   property hfTaxes: TnscHideField
    read f_hfTaxes;
    {* Налоги, финансы }
   property tvTaxes: TnscTreeViewHotTruck
    read f_tvTaxes;
   property pnlBanner: TvtPanel
    read f_pnlBanner;
   property ieBanner: TImageEnView
    read f_ieBanner;
   property hfLastOpenDocsRightEdge: TvtPanel
    read f_hfLastOpenDocsRightEdge;
 end;//TPrimMainMenuNewForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , PrimMainMenuNew_utMainMenuNew_UserType
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If Defined(Nemesis)}
 , nscArrangeGrid
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscArrangeGridCell
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If Defined(Nemesis)}
 , nscFixedHeightControlCell
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscFixedWidthControlCell
 {$IfEnd} // Defined(Nemesis)
 , nsTypes
 , nsConst
 , Graphics
 {$If Defined(Nemesis)}
 , f1TextStyle_Const
 {$IfEnd} // Defined(Nemesis)
 , nsLastOpenDocTree
 , l3ControlsTypes
 , l3MinMax
 {$If Defined(Nemesis)}
 , nscTabTableCell
 {$IfEnd} // Defined(Nemesis)
 , afwFacade
 {$If NOT Defined(NoImageEn)}
 , hyieutils
 {$IfEnd} // NOT Defined(NoImageEn)
 , afwInterfaces
 {$If Defined(Nemesis)}
 , nscTreeView
 {$IfEnd} // Defined(Nemesis)
 , smChangeableTree
 , DocumentRes
 , vtPngImgList
 , StartUnit
 , MainMenuNewRes
 , nsTabbedInterfaceTypes
 , bsTypesNew
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 , nsUtils
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsQueryInterfaces
 , DataAdapter
 {$If NOT Defined(NoImageEn)}
 , hyiedefs
 {$IfEnd} // NOT Defined(NoImageEn)
 {$If NOT Defined(NoImageEn)}
 , iemview
 {$IfEnd} // NOT Defined(NoImageEn)
 , nsExternalObjectPrim
 , SysUtils
 , l3String
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , vcmHistoryService
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 //#UC START# *4958E1F700C0impl_uses*
 //#UC END# *4958E1F700C0impl_uses*
;

const
 c_SearchLabelDistance = 18;

type _Instance_R_ = TPrimMainMenuNewForm;

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabCaptionProvider.imp.pas}

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}

procedure TPrimMainMenuNewForm.BaseSearchPanelResize(aSender: TObject);
//#UC START# *4ACB20380272_4958E1F700C0_var*
//#UC END# *4ACB20380272_4958E1F700C0_var*
begin
//#UC START# *4ACB20380272_4958E1F700C0_impl*
 pnlBaseSearchZone.Height := pnlBaseSearch.Height {- 7{20};
 pnlBaseSearchZone.Width := pnlBaseSearch.Width - 30;
//#UC END# *4ACB20380272_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.BaseSearchPanelResize

procedure TPrimMainMenuNewForm.PaintLogo(aSender: TObject);
//#UC START# *4ACB3E8A0021_4958E1F700C0_var*
//#UC END# *4ACB3E8A0021_4958E1F700C0_var*
begin
//#UC START# *4ACB3E8A0021_4958E1F700C0_impl*
 nsPaintImage(dmStdRes.ilLogo, pbLogo);
//#UC END# *4ACB3E8A0021_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.PaintLogo

procedure TPrimMainMenuNewForm.PaintButton(aSender: TObject);
//#UC START# *4ACB4FA400D0_4958E1F700C0_var*
//#UC END# *4ACB4FA400D0_4958E1F700C0_var*
begin
//#UC START# *4ACB4FA400D0_4958E1F700C0_impl*
 if (aSender = pbExpert) then
 begin
  if (afw.Application.LocaleInfo.Language = afw_lngEnglish) then
   nsPaintImage(dmMainMenuNew.ilButtons, pbExpert, 2, True)
  else
   nsPaintImage(dmMainMenuNew.ilButtons, pbExpert, 0, True);
 end//aSender = pbExpert
 else
 if (aSender = pbOnLine) then
 begin
  if (afw.Application.LocaleInfo.Language = afw_lngEnglish) then
  begin
   if defDataAdapter.IsInternetAgentEnabled then
    nsPaintImage(dmMainMenuNew.ilButtons, pbOnLine, 3, True)
   else
    nsPaintImage(dmMainMenuNew.ilButtons, pbOnLine, 6, True);
  end//afw.Application.LocaleInfo.Language = afw_lngEnglish
  else
  begin
   if defDataAdapter.IsInternetAgentEnabled then
    nsPaintImage(dmMainMenuNew.ilButtons, pbOnLine, 1, True)
   else
    nsPaintImage(dmMainMenuNew.ilButtons, pbOnLine, 5, True);
  end;//afw.Application.LocaleInfo.Language = afw_lngEnglish
 end//aSender = pbOnLine
 else
 if (aSender = pbCourtsOnline) then
 begin
  if pbCourtsOnline.Visible then
  begin
   if (afw.Application.LocaleInfo.Language = afw_lngEnglish) then
   begin
    if defDataAdapter.IsInternetAgentEnabled then
     nsPaintImage(dmMainMenuNew.ilButtons, pbCourtsOnline, 8, True)
    else
     nsPaintImage(dmMainMenuNew.ilButtons, pbCourtsOnline, 10, True);
   end//afw.Application.LocaleInfo.Language = afw_lngEnglish
   else
   begin
    if defDataAdapter.IsInternetAgentEnabled then
     nsPaintImage(dmMainMenuNew.ilButtons, pbCourtsOnline, 7, True)
    else
     nsPaintImage(dmMainMenuNew.ilButtons, pbCourtsOnline, 9, True);
   end;//afw.Application.LocaleInfo.Language = afw_lngEnglish
  end;//pbCourtsOnline.Visible
 end//aSender = pbCourtsOnline
 else
 if (aSender = pbIntranet) then
 begin
  if pbIntranet.Visible then
   nsPaintImage(dmMainMenuNew.ilButtons, pbIntranet, 4, True);
 end;//aSender = pbIntranet
//#UC END# *4ACB4FA400D0_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.PaintButton

procedure TPrimMainMenuNewForm.ExpertClick(aSender: TObject);
//#UC START# *4ACB540E01CC_4958E1F700C0_var*
//#UC END# *4ACB540E01CC_4958E1F700C0_var*
begin
//#UC START# *4ACB540E01CC_4958E1F700C0_impl*
 TdmStdRes.OpenSendConsultation(nil);
//#UC END# *4ACB540E01CC_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.ExpertClick

procedure TPrimMainMenuNewForm.OnLineClick(aSender: TObject);
//#UC START# *4ACB542C0039_4958E1F700C0_var*
//#UC END# *4ACB542C0039_4958E1F700C0_var*
begin
//#UC START# *4ACB542C0039_4958E1F700C0_impl*
 vcmDispatcher.ModuleOperation(TdmStdRes.mod_opcode_InternetAgent_InternetAgent);
//#UC END# *4ACB542C0039_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.OnLineClick

procedure TPrimMainMenuNewForm.SearchClick(aSender: TObject);
//#UC START# *4ACB8B7B0192_4958E1F700C0_var*
//#UC END# *4ACB8B7B0192_4958E1F700C0_var*
begin
//#UC START# *4ACB8B7B0192_4958E1F700C0_impl*
 if (aSender = flAttributeSearch) then
  TdmStdRes.OpenQuery(lg_qtAttribute, nil, nil)
 else
 if (aSender = flSituationSearch) then
  TdmStdRes.OpenQuery(lg_qtKeyWord, nil, nil)
 else
 if (aSender = flPublishedSourceSearch) then
  TdmStdRes.OpenQuery(lg_qtPublishedSource, nil, nil)
 else
 if (aSender = flDictionSearch) then
  TdmStdRes.OpenDictionary(nil, NativeMainForm)
 else
  Assert(false);
//#UC END# *4ACB8B7B0192_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.SearchClick

procedure TPrimMainMenuNewForm.LoadBanner;
var l_EO: IExternalObject;
var l_Stream: TStream;
var l_Name: IString;
//#UC START# *4ACDC1AE00C1_4958E1F700C0_var*
//#UC END# *4ACDC1AE00C1_4958E1F700C0_var*
begin
//#UC START# *4ACDC1AE00C1_4958E1F700C0_impl*
 with ieIO do
 begin
  Background := clWhite;
  AttachedImageEn := ieBanner;
 end;//ieIO
 try
  DefDataAdapter.CommonInterfaces.GetBanner(f_Banner);
 except
  on ECannotFindData do
  begin
   ieBanner.Cursor := crArrow;
   Exit;
  end;//on ECannotFindData
 end;//try..except
 if (f_Banner <> nil) then
 begin
  f_Banner.GetPicture(l_EO);
  if (l_EO <> nil) then
  begin
   l_Stream := TnsExternalObjectStream.Create(l_EO);
   try
    ieIO.LoadFromStream(l_Stream);
    ieBanner.AutoFit := (ieIO.Params.Width <> ieBanner.Width) or
                        (ieIO.Params.Height <> ieBanner.Height);
   finally
    FreeAndNil(l_Stream);
   end;//try..finally
   l_EO.GetName(l_Name);
   if (l_Name <> nil) then
   begin
    ieBanner.Hint := l3Str(nsCStr(l_Name));
    ieBanner.ShowHint := true;
   end//l_Name <> nil
   else
    ieBanner.Hint := '';
  end;//l_EO <> nil
 end;//f_Banner <> nil
//#UC END# *4ACDC1AE00C1_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.LoadBanner

procedure TPrimMainMenuNewForm.BannerClick(aSender: TObject);
var l_Link: IExternalLink;
var l_Entity: IEntityBase;
var l_Ref: IUnknown;
//#UC START# *4ACF0DEC02DE_4958E1F700C0_var*
//#UC END# *4ACF0DEC02DE_4958E1F700C0_var*
begin
//#UC START# *4ACF0DEC02DE_4958E1F700C0_impl*
 if (f_Banner <> nil) then
 begin
  f_Banner.OpenLink(l_Ref);
  if (l_Ref <> nil) then
  begin
   if Supports(l_Ref, IExternalLink, l_Link) then
    try
     nsExecuteExternalLink(l_Link);
    finally
     l_Link := nil;
    end//try..finally
   else
   if Supports(l_Ref, IEntityBase, l_Entity) then
    try
     TdmStdRes.OpenEntityAsDocument(l_Entity, NativeMainForm);
    finally
     l_Entity := nil;
    end//try..finally
  end;//l_Ref <> nil
 end;//f_Banner <> nil
//#UC END# *4ACF0DEC02DE_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.BannerClick

procedure TPrimMainMenuNewForm.UpdateBaseSearchFormHeight(aForm: TForm);
//#UC START# *4AD59B1E0158_4958E1F700C0_var*
//#UC END# *4AD59B1E0158_4958E1F700C0_var*
begin
//#UC START# *4AD59B1E0158_4958E1F700C0_impl*
 if (Max(80 + 13, aForm.Height) <> pnlBaseSearchZone.Height) then
 begin
  pnlBaseSearchZone.Height := Max(80 + 13, aForm.Height);
  pnlBaseSearch.Height := pnlBaseSearchZone.Height {+ 7{20};
  RecalcGrid;
 end;//aForm.Height <> pnlBaseSearchZone.Height
//#UC END# *4AD59B1E0158_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.UpdateBaseSearchFormHeight

procedure TPrimMainMenuNewForm.BaseSearchFormResize(aSender: TObject);
//#UC START# *4AD59B4B0223_4958E1F700C0_var*
//#UC END# *4AD59B4B0223_4958E1F700C0_var*
begin
//#UC START# *4AD59B4B0223_4958E1F700C0_impl*
 UpdateBaseSearchFormHeight(aSender As TForm);
//#UC END# *4AD59B4B0223_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.BaseSearchFormResize

procedure TPrimMainMenuNewForm.ReferencesResize(aSender: TObject);
//#UC START# *4AF972C9034E_4958E1F700C0_var*
//#UC END# *4AF972C9034E_4958E1F700C0_var*
begin
//#UC START# *4AF972C9034E_4958E1F700C0_impl*
 UpdatePbExpertPosition;
//#UC END# *4AF972C9034E_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.ReferencesResize

procedure TPrimMainMenuNewForm.UpdateSearchLabels;
//#UC START# *4B716B8502F1_4958E1F700C0_var*
//#UC END# *4B716B8502F1_4958E1F700C0_var*
begin
//#UC START# *4B716B8502F1_4958E1F700C0_impl*
 flSituationSearch.Visible := Assigned(defDataAdapter) and defDataAdapter.IsExists_KeyWordTag;
 with flPublishedSourceSearch do
 begin
  if flSituationSearch.Visible then
   Left := c_SearchLabelDistance + flSituationSearch.Left + flSituationSearch.Width
  else
   Left := c_SearchLabelDistance + flAttributeSearch.Left + flAttributeSearch.Width;
  Visible := Assigned(defDataAdapter) and defDataAdapter.IsExists_PublishSourceTag;
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
  Visible := Assigned(defDataAdapter) and DefDataAdapter.IsExplanatoryExists;
 end;//flDictionSearch
//#UC END# *4B716B8502F1_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.UpdateSearchLabels

procedure TPrimMainMenuNewForm.IntranetClick(aSender: TObject);
//#UC START# *4BF242E40213_4958E1F700C0_var*
//#UC END# *4BF242E40213_4958E1F700C0_var*
begin
//#UC START# *4BF242E40213_4958E1F700C0_impl*
 vcmDispatcher.ModuleOperation(TdmStdRes.mod_opcode_Common_OpenIntranet);
//#UC END# *4BF242E40213_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.IntranetClick

procedure TPrimMainMenuNewForm.TaxesStateChanged(aSender: TObject;
 var theState: ThfState);
//#UC START# *4E733318014A_4958E1F700C0_var*
//#UC END# *4E733318014A_4958E1F700C0_var*
begin
//#UC START# *4E733318014A_4958E1F700C0_impl*
 theState := hfsShow;
 TaxesNextTree(aSender);
//#UC END# *4E733318014A_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.TaxesStateChanged

procedure TPrimMainMenuNewForm.UpdateTaxesTree;
//#UC START# *4E73342B0318_4958E1F700C0_var*
//#UC END# *4E73342B0318_4958E1F700C0_var*
begin
//#UC START# *4E73342B0318_4958E1F700C0_impl*
 UpdateTaxesTreeCaption;
 tvTaxes.TreeStruct := TsmChangeableTree.Make(f_CurrentSection);
//#UC END# *4E73342B0318_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.UpdateTaxesTree

procedure TPrimMainMenuNewForm.TaxesNextTree(aSender: TObject);
//#UC START# *4E73346C032A_4958E1F700C0_var*
//#UC END# *4E73346C032A_4958E1F700C0_var*
begin
//#UC START# *4E73346C032A_4958E1F700C0_impl*
 Inc(f_CurrentSection);
 if (f_CurrentSection = Pred(High(f_CurrentSection))) then
  f_CurrentSection := Low(f_CurrentSection);
 TdmStdRes.WriteMainMenuChangeableMainMenuTypeSetting(Ord(f_CurrentSection));
 UpdateTaxesTree;
//#UC END# *4E73346C032A_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.TaxesNextTree

procedure TPrimMainMenuNewForm.UpdateTaxesTreeCaption;
//#UC START# *4E73634801A2_4958E1F700C0_var*
var
 l_Sect : ISection;
 l_S : IString;
//#UC END# *4E73634801A2_4958E1F700C0_var*
begin
//#UC START# *4E73634801A2_4958E1F700C0_impl*
 DefDataAdapter.NativeAdapter.MakeMainMenu.GetSection(f_CurrentSection, l_Sect);
 Assert(l_Sect <> nil);
 l_Sect.GetCaption(l_S);
 Assert(l_S <> nil);
 hfTaxes.Caption := l3Str(nsCStr(l_S));
//#UC END# *4E73634801A2_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.UpdateTaxesTreeCaption

procedure TPrimMainMenuNewForm.UpdateReferencesAndLawNewsCaptions;
//#UC START# *4EA008B300DF_4958E1F700C0_var*
var
 l_Sect : ISection;
 l_S : IString;
//#UC END# *4EA008B300DF_4958E1F700C0_var*
begin
//#UC START# *4EA008B300DF_4958E1F700C0_impl*
 // begin http://mdp.garant.ru/pages/viewpage.action?pageId=294590319&focusedCommentId=294596544#comment-294596544
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

 (*DefDataAdapter.NativeAdapter.MakeMainMenu.GetSection(ST_CHANGES_IN_LEGISLATION, l_Sect);
 Assert(l_Sect <> nil);
 try
  l_Sect.GetCaption(l_S);
 finally
  l_Sect := nil
 end;//try..finally
 Assert(l_S <> nil);
 try
  hfLawNews.Caption := l3Str(nsCStr(l_S));
 finally
  l_S := nil;
 end;//try..finally    *)
 // end http://mdp.garant.ru/pages/viewpage.action?pageId=294590319&focusedCommentId=294596544#comment-294596544
//#UC END# *4EA008B300DF_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.UpdateReferencesAndLawNewsCaptions

procedure TPrimMainMenuNewForm.CourtsOnlineClick(aSender: TObject);
//#UC START# *4F7451F501DB_4958E1F700C0_var*
{var
 l_IS : IString;}
const
 c_OnlineResDocId = 57869919;
//#UC END# *4F7451F501DB_4958E1F700C0_var*
begin
//#UC START# *4F7451F501DB_4958E1F700C0_impl*
 if defDataAdapter.IsInternetAgentEnabled then
 begin
  //http://mdp.garant.ru/pages/viewpage.action?pageId=431371899
  afw.BeginOp;
  try
   {DefDataAdapter.NativeAdapter.MakeDecisionsArchiveSupport.GetArchiveUrl(l_IS);
   nsDoShellExecute(nsCStr(l_IS),
                    false, nil, true
                    // http://mdp.garant.ru/pages/viewpage.action?pageId=360023614
                   );}
   nsOpenDocumentByNumber(c_OnlineResDocId + c_InternalDocShift, 0, dptSub, True);
  finally
   afw.EndOp;
  end;//try..finally
 end;
//#UC END# *4F7451F501DB_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.CourtsOnlineClick

function TPrimMainMenuNewForm.GetSearchLabelsLineFullWidth: Integer;
//#UC START# *526F53D3025F_4958E1F700C0_var*
//#UC END# *526F53D3025F_4958E1F700C0_var*
begin
//#UC START# *526F53D3025F_4958E1F700C0_impl*
 Result := flAttributeSearch.Left + c_SearchLabelDistance + flAttributeSearch.Width +
  c_SearchLabelDistance + flPublishedSourceSearch.Width + c_SearchLabelDistance + flDictionSearch.Width;
//#UC END# *526F53D3025F_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.GetSearchLabelsLineFullWidth

procedure TPrimMainMenuNewForm.UpdatePbExpertPosition;
//#UC START# *55CDC6110290_4958E1F700C0_var*
//#UC END# *55CDC6110290_4958E1F700C0_var*
begin
//#UC START# *55CDC6110290_4958E1F700C0_impl*
 pbExpert.Top := tvReferences.Top + Max(tvReferences.CalcFullHeight - pbExpert.Height, 0);
//#UC END# *55CDC6110290_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.UpdatePbExpertPosition

function TPrimMainMenuNewForm.DoBuildGrid: InscArrangeGrid;
//#UC START# *4AC9B6D00250_4958E1F700C0_var*
//#UC END# *4AC9B6D00250_4958E1F700C0_var*
begin
//#UC START# *4AC9B6D00250_4958E1F700C0_impl*
 Result := TnscArrangeGrid.Make(false{true}, true);
 with Result do
 begin
  AddColumn.FixedWidth := pnlLogo.Width;
  AddColumn;
  AddColumn;
  AddRow;
  AddRow;
  AddRow;
  AddRow;
  Cell[0, 1] := TnscHideFieldCell.Make(hfLawNews, true);
  Cell[0, 2] := TnscFixedHeightControlCell.Make(pnlBanner);
  Cell[1, 0] := TnscFixedWidthControlCell.Make(pnlLogo);
  Cell[3, 0] := TnscFixedWidthControlCell.Make(pnlExpert);
  Cell[3, 1] := TnscHideFieldCell.Make(hfReferences, true);
  Cell[3, 2] := TnscHideFieldCell.Make(hfTaxes, true);
  Cell[4, 0] := TnscFixedWidthControlCell.Make(pnlOnLine);
  MergeCells(1, 1, 2, TnscFixedHeightControlCell.Make(pnlBaseSearch));
  MergeCells(2, 1, 2, TnscFixedHeightControlCell.Make(pnlSearches));
  MergeCells(4, 1, 2, TnscHideFieldCell.Make(hfLastOpenDocs, true));
 end;//with Result do
//#UC END# *4AC9B6D00250_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.DoBuildGrid

procedure TPrimMainMenuNewForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4958E1F700C0_var*
//#UC END# *479731C50290_4958E1F700C0_var*
begin
//#UC START# *479731C50290_4958E1F700C0_impl*
 f_Banner := nil;
 inherited;
//#UC END# *479731C50290_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.Cleanup

procedure TPrimMainMenuNewForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4958E1F700C0_var*
//#UC END# *47EA4E9002C6_4958E1F700C0_var*
begin
//#UC START# *47EA4E9002C6_4958E1F700C0_impl*
 inherited;
 UpdateSearchLabels;
 UpdateReferencesAndLawNewsCaptions;
 UpdateTaxesTreeCaption;
//#UC END# *47EA4E9002C6_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.FinishDataUpdate

{$If NOT Defined(NoVCM)}
procedure TPrimMainMenuNewForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4958E1F700C0_var*
//#UC END# *49803F5503AA_4958E1F700C0_var*
begin
//#UC START# *49803F5503AA_4958E1F700C0_impl*
 f_CurrentSection := TSectionType(TdmStdRes.MainMenuChangeableMainMenuTypeSetting);
 UpdateTaxesTreeCaption;
 inherited;
 LoadBanner;
 UpdateCaption;
 UpdateTabCaption(DoGetTabCaption);
//#UC END# *49803F5503AA_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TPrimMainMenuNewForm.DoLoadState(const aState: IvcmBase;
 aStateType: TvcmStateType): Boolean;
 {* Загружает состояние формы. Для перекрытия в потомках }
//#UC START# *49807428008C_4958E1F700C0_var*
//#UC END# *49807428008C_4958E1F700C0_var*
begin
//#UC START# *49807428008C_4958E1F700C0_impl*
 inherited DoLoadState(aState, aStateType);
 UpdatePbExpertPosition;
//#UC END# *49807428008C_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.DoLoadState
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimMainMenuNewForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4958E1F700C0_var*
var
 l_Index : Integer;
//#UC END# *4A8E8F2E0195_4958E1F700C0_var*
begin
//#UC START# *4A8E8F2E0195_4958E1F700C0_impl*
 inherited;
 with pnlMain do
 begin
  Align := alClient;
  BevelOuter := bvNone;
  Color := clWhite;
  TabOrder := 0;
 end;
  with hfLastOpenDocs do
  begin
   TopHeaderIndent := 30;

   Left := 16;
   Top := 62;
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
    AllowTrucking := true;

    Align := alClient;
    BorderStyle := bsNone;
    TabOrder := 0;
    MultiStrokeItem := True;
    ActionElementMode := l3_amSingleClick;
    ViewOptions := [voShowInterRowSpace, voShowExpandable, voVariableItemHeight, voWithoutImages];
    ClearTreeStructOnSaveState := False;
   end;
  with hfReferences do
  begin
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
   Height := 140;
   Width := 390;
   Left := 40;
   Top := 288;
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
    MultiStrokeItem := True;
    ActionElementMode := l3_amSingleClick;
    ViewOptions := [voShowIcons, voShowExpandable, voWithoutImages];
    ClearTreeStructOnSaveState := False;
   end;
 with pnlBaseSearch do
 begin
  Height := 100;
  BevelInner := bvNone;
  BevelOuter := bvNone;
  OnResize := BaseSearchPanelResize;
  Color := clWhite;
 end;//with pnlBaseSearch
 with pnlBaseSearchZone do
 begin
  Top := 10;
  Left := 15;
  BevelInner := bvNone;
  BevelOuter := bvNone;
  Color := clWhite;
 end;//with pnlBaseSearchZone
 with pnlSearches do
 begin
  Height := 20;
  BevelInner := bvNone;
  BevelOuter := bvNone;
  Color := clWhite;
 end;//with pnlSearches
 with pnlLogo do
 begin
  Height := 100;
  Width := 235;
  BevelInner := bvNone;
  BevelOuter := bvNone;
  Color := clWhite;
 end;//with pnlLogo
 with pbLogo do
 begin
  Top := 0;
  Left := 15;
  Width := pnlLogo.Width - 30;
  Height := pnlLogo.Height;
  OnPaint := Self.PaintLogo;
 end;//with pbLogo
 with hfTaxes do
 begin
  Height := hfReferences.Height;
  Width := 380;
  ClientIndent := 15;
  LeftHeaderIndent := 15;
  TopHeaderIndent := 20;
  ClientControl := tvTaxes;
  //Options := [];
  Options := [hfoCanHide, hfoHyperlink];
  ButtonImageList := nsDocumentRes.MainMenuImageList{CommentsImageList};
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
  OnHyperlinkClick := TaxesNextTree;
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
 with pnlExpert do
 begin
  Height := hfReferences.Height;
  Width := pnlLogo.Width;
  BevelInner := bvNone;
  BevelOuter := bvNone;
  Color := clWhite;
 end;//pnlExpert
 with pnlOnLine do
 begin
  Height := hfLastOpenDocs.Height;
  Width := pnlLogo.Width;
  BevelInner := bvNone;
  BevelOuter := bvNone;
  Color := clWhite;
 end;//pnlOnLine
 with pbExpert do
 begin
  Left := 20;
  Top := 70;
  Height := dmMainMenuNew.ilButtons.Height + 1;
  Width := Parent.Width - 40;
  OnPaint := Self.PaintButton;
  OnClick := ExpertClick;
  Cursor := crHandPoint;
 end;//with pbExpert
 with pbOnLine do
 begin
  Left := 20;
  Top := 35;
  Height := dmMainMenuNew.ilButtons.Height + 1;
  Width := Parent.Width - 40;
  OnPaint := Self.PaintButton;
  OnClick := OnLineClick;
  Cursor := crHandPoint;
 end;//with pbOnLine
 with pbCourtsOnline do
  if (afw.Application.LocaleInfo.Language = afw_lngRussian) then
  begin
   Left := 20;
   Top := 35 + pbOnLine.Top + pbOnLine.Height;
   Height := dmMainMenuNew.ilButtons.Height + 1;
   pnlOnLine.Height := Max(pnlOnLine.Height, Top + Height);
   Width := Parent.Width - 40;                                           
   OnPaint := Self.PaintButton;
   OnClick := CourtsOnlineClick;
   Cursor := crHandPoint;
  end//Assigned(defDataAdapter) and defDataAdapter.RevisionCheckEnabled
  else
  begin
   Left := 0;
   Top := 0;
   Height := 0;
   Width := 0;
   Visible := False;
  end;//with pbCourtsOnline
 with pbIntranet do
  if Assigned(defDataAdapter) and
     defDataAdapter.RevisionCheckEnabled and
     (DefDataAdapter.CommonInterfaces.GetProductType = PT_SUPERMOBILE) then
  begin
   Left := 20;
   if pbCourtsOnline.Visible then
    Top := 35 + pbCourtsOnline.Top + pbCourtsOnline.Height
   else
    Top := 35 + pbOnline.Top + pbOnline.Height;
   Height := dmMainMenuNew.ilButtons.Height + 1;
   pnlOnLine.Height := Max(pnlOnLine.Height, Top + Height);
   Width := Parent.Width - 40;
   OnPaint := Self.PaintButton;
   OnClick := IntranetClick;
   Cursor := crHandPoint;
  end//Assigned(defDataAdapter) and defDataAdapter.RevisionCheckEnabled
  else
  begin
   Left := 0;
   Top := 0;
   Height := 0;
   Width := 0;
   Visible := False;
  end;//Assigned(defDataAdapter) and defDataAdapter.RevisionCheckEnabled
 with flAttributeSearch do
 begin
  Left := 15;
  AutoWidth := true;
  AllowTrucking := true;
  HighlightColor := c_MainMenuColor;
  TextColor := c_MainMenuColor;
  Cursor := crHandPoint;
  OnClick := SearchClick;
 end;//flAttributeSearch
 with flSituationSearch do
 begin
  Left := c_SearchLabelDistance + flAttributeSearch.Left + flAttributeSearch.Width;
  AutoWidth := true;
  AllowTrucking := true;
  HighlightColor := c_MainMenuColor;
  TextColor := c_MainMenuColor;
  Cursor := crHandPoint;
  OnClick := SearchClick;
 end;//flSituationSearch
 with flPublishedSourceSearch do
 begin
  Left := c_SearchLabelDistance + flSituationSearch.Left + flSituationSearch.Width;
  AutoWidth := true;
  AllowTrucking := true;
  HighlightColor := c_MainMenuColor;
  TextColor := c_MainMenuColor;
  Cursor := crHandPoint;
  OnClick := SearchClick;
 end;//flPublishedSourceSearch
 with flDictionSearch do
 begin
  Left := c_SearchLabelDistance + flPublishedSourceSearch.Left + flPublishedSourceSearch.Width;
  AutoWidth := true;
  AllowTrucking := true;
  HighlightColor := c_MainMenuColor;
  TextColor := c_MainMenuColor;
  Cursor := crHandPoint;
  OnClick := SearchClick;
 end;//flDictionSearch
 UpdateSearchLabels;
 with pnlBanner do
 begin
  Height := hfLawNews.Height;
  BevelInner := bvNone;
  BevelOuter := bvNone;
  Color := clWhite;
 end;//pnlBanner
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
 with hfLastOpenDocsRightEdge do
 begin
  BevelInner := bvNone;
  BevelOuter := bvNone;
  Color := clWhite;
  Align := alRight;
  Width := 80;
 end;//with hfLastOpenDocsRightEdge
 for l_Index := 0 to Pred(ComponentCount) do
  if (Components[l_Index] is TnscHideField) then
  begin
   TnscHideField(Components[l_Index]).StyleId := f1_saNewSchoolMainMenuHeader;
   TnscHideField(Components[l_Index]).HeaderImage := -1;
   TnscHideField(Components[l_Index]).TabStop := false;
  end//Components[l_Index] is TnscHideField
  else
  if (Components[l_Index] is TnscTreeView) then
  begin
   TnscTreeView(Components[l_Index]).TreatDefaultColorAsWindowColor := False;
   TnscTreeView(Components[l_Index]).StyleID := f1_saNewSchoolMainMenuConstPath;
   TnscTreeView(Components[l_Index]).Color := clWhite;
  end;
//#UC END# *4A8E8F2E0195_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimMainMenuNewForm.DoInitKeyboardNavigation(const aTable: InscTabTable);
//#UC START# *4AC9CB8B01D3_4958E1F700C0_var*
//#UC END# *4AC9CB8B01D3_4958E1F700C0_var*
begin
//#UC START# *4AC9CB8B01D3_4958E1F700C0_impl*
 hfLawNews.TabOrder := 0;
 pnlBaseSearch.TabOrder := 1;
 pnlSearches.TabOrder := 2;
 hfReferences.TabOrder := 3;
 hfTaxes.TabOrder := 4;
 hfLastOpenDocs.TabOrder := 5;
 with aTable.AddColumn do
 begin
  AddItem(TnscTreeViewTabCell.Make(tvLawNews));
  AddItem(TnscTreeViewTabCell.Make(tvReferences));
  AddItem(TnscTreeViewTabCell.Make(tvLastOpenDocs));
 end;//with aTable.AddItem do
 with aTable.AddColumn do
 begin
  AddItem(TnscTreeViewTabCell.Make(tvTaxes));
 end;//with aTable.AddItem do
//#UC END# *4AC9CB8B01D3_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.DoInitKeyboardNavigation

procedure TPrimMainMenuNewForm.LoadLastOpenDocs;
//#UC START# *4AC9D12600E0_4958E1F700C0_var*
//#UC END# *4AC9D12600E0_4958E1F700C0_var*
begin
//#UC START# *4AC9D12600E0_4958E1F700C0_impl*
 tvLastOpenDocs.TreeStruct := TnsLastOpenDocTree.Make(
  afw.Settings.LoadInteger(pi_RecentlyOpenDocumentsCount, dv_RecentlyOpenDocumentsCount),
  False, true);
//#UC END# *4AC9D12600E0_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.LoadLastOpenDocs

procedure TPrimMainMenuNewForm.LoadTrees;
//#UC START# *4AC9E9EC0064_4958E1F700C0_var*
//#UC END# *4AC9E9EC0064_4958E1F700C0_var*
begin
//#UC START# *4AC9E9EC0064_4958E1F700C0_impl*
 inherited;
 //tvTaxes.TreeStruct := TsmTaxes.Make;
 UpdateTaxesTree;
 UpdateReferencesAndLawNewsCaptions;
//#UC END# *4AC9E9EC0064_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.LoadTrees

function TPrimMainMenuNewForm.pm_GetContainerForBaseSearch: IvcmContainer;
//#UC START# *4ACA197F0147_4958E1F700C0get_var*
//#UC END# *4ACA197F0147_4958E1F700C0get_var*
begin
//#UC START# *4ACA197F0147_4958E1F700C0get_impl*
 Result := Self;
//#UC END# *4ACA197F0147_4958E1F700C0get_impl*
end;//TPrimMainMenuNewForm.pm_GetContainerForBaseSearch

function TPrimMainMenuNewForm.NewSchool: Boolean;
 {* Определяет, что основное меню вида 2009 - [$164601183] }
//#UC START# *4ACB2F98002B_4958E1F700C0_var*
//#UC END# *4ACB2F98002B_4958E1F700C0_var*
begin
//#UC START# *4ACB2F98002B_4958E1F700C0_impl*
 Result := true;
//#UC END# *4ACB2F98002B_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.NewSchool

procedure TPrimMainMenuNewForm.DoRecalcGrid(const aGrid: InscArrangeGrid);
//#UC START# *4AD3468102DB_4958E1F700C0_var*
//#UC END# *4AD3468102DB_4958E1F700C0_var*
begin
//#UC START# *4AD3468102DB_4958E1F700C0_impl*
 inherited;
 with aGrid do
 begin
  Cell[0, 2].MinHeight := Max(150, ieBanner.Top * 2 + ieBanner.Height);
  Row[1].FixedHeight := pnlBaseSearch.Height;
  Row[2].FixedHeight := pnlSearches.Height;
  Cell[2, 0].MinHeight := 100;
  //http://mdp.garant.ru/pages/viewpage.action?pageId=383588108
  if flDictionSearch.Visible then
   Cell[2, 1].MinWidth := (flDictionSearch.Left + flDictionSearch.Width) - {150}47
  else
   Cell[2, 1].MinWidth := GetSearchLabelsLineFullWidth;
  Cell[3, 0].MinHeight := 220;
  Cell[4, 0].MinHeight := pnlOnLine.Height + 10;
(*  if Assigned(defDataAdapter) and defDataAdapter.RevisionCheckEnabled then
   Cell[4, 0].MinHeight := 200
  else
   Cell[4, 0].MinHeight := 175;*)
 end;//with aGrid
//#UC END# *4AD3468102DB_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.DoRecalcGrid

{$If NOT Defined(NoVCM)}
function TPrimMainMenuNewForm.InsertForm(const aForm: IvcmEntityForm): Boolean;
//#UC START# *4AD44CA20001_4958E1F700C0_var*
//#UC END# *4AD44CA20001_4958E1F700C0_var*
begin
//#UC START# *4AD44CA20001_4958E1F700C0_impl*
 Result := inherited InsertForm(aForm);
 if Result AND (aForm.ZoneType = vcm_ztMain) then
 begin
  (aForm.VCLWinControl As TForm).OnResize := BaseSearchFormResize;
  UpdateBaseSearchFormHeight(aForm.VCLWinControl As TForm);
 end;//Result..
//#UC END# *4AD44CA20001_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.InsertForm
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimMainMenuNewForm.SetControlsResources;
 {* Установить контролам ресурсы для интернационализации }
//#UC START# *4B62D10B031B_4958E1F700C0_var*
//#UC END# *4B62D10B031B_4958E1F700C0_var*
begin
//#UC START# *4B62D10B031B_4958E1F700C0_impl*
 inherited;
 flAttributeSearch.Hint := 'Открыть карточку поиска по реквизитам';
 flSituationSearch.Hint := 'Открыть энциклопедию ситуаций';
 flPublishedSourceSearch.Hint := 'Открыть поиск по источнику опубликования';
 flDictionSearch.Hint := 'Открыть Толковый словарь правовых и финансовых терминов';

 flAttributeSearch.ShowHint := true;
 flSituationSearch.ShowHint := true;
 flPublishedSourceSearch.ShowHint := true;
 flDictionSearch.ShowHint := true;
//#UC END# *4B62D10B031B_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.SetControlsResources
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimMainMenuNewForm.RestoreControlSize;
//#UC START# *4C934E5F0035_4958E1F700C0_var*
//#UC END# *4C934E5F0035_4958E1F700C0_var*
begin
//#UC START# *4C934E5F0035_4958E1F700C0_impl*
 inherited;
 BaseSearchPanelResize(pnlBaseSearch);
//#UC END# *4C934E5F0035_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.RestoreControlSize
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TPrimMainMenuNewForm.DoGetTabCaption: IvcmCString;
//#UC START# *53F1C6EF02C9_4958E1F700C0_var*
//#UC END# *53F1C6EF02C9_4958E1F700C0_var*
begin
//#UC START# *53F1C6EF02C9_4958E1F700C0_impl*
 Result := vcmCStr(str_utMainMenuNewCaption);
//#UC END# *53F1C6EF02C9_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.DoGetTabCaption
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
function TPrimMainMenuNewForm.DoGetFormSetTabCaption: IvcmCString;
//#UC START# *54058CBC0182_4958E1F700C0_var*
//#UC END# *54058CBC0182_4958E1F700C0_var*
begin
//#UC START# *54058CBC0182_4958E1F700C0_impl*
 Result := DoGetTabCaption;
//#UC END# *54058CBC0182_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.DoGetFormSetTabCaption
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
function TPrimMainMenuNewForm.DoGetTabImageIndex: Integer;
//#UC START# *543E3AA801D0_4958E1F700C0_var*
//#UC END# *543E3AA801D0_4958E1F700C0_var*
begin
//#UC START# *543E3AA801D0_4958E1F700C0_impl*
 Result := nsTabIconIndex(titMain);
//#UC END# *543E3AA801D0_4958E1F700C0_impl*
end;//TPrimMainMenuNewForm.DoGetTabImageIndex
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

{$If NOT Defined(NoVCM)}
procedure TPrimMainMenuNewForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 AddUserTypeExclude(utMainMenuNewName, en_Tree, op_ExpandAll, False);
 AddUserTypeExclude(utMainMenuNewName, en_Tree, op_CollapseAll, False);
 AddUserTypeExclude(utMainMenuNewName, en_Tree, op_Wrap, False);
end;//TPrimMainMenuNewForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimMainMenuNewForm.MakeControls;
begin
 inherited;
 with AddUsertype(utMainMenuNewName,
  str_utMainMenuNewCaption,
  str_utMainMenuNewCaption,
  False,
  44,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utMainMenuNewName
 pnlMain.Parent := Self;
 f_pnlBaseSearch := TvtPanel.Create(Self);
 f_pnlBaseSearch.Name := 'pnlBaseSearch';
 f_pnlBaseSearch.Parent := pnlMain;
 f_pnlBaseSearchZone := TvtPanel.Create(Self);
 f_pnlBaseSearchZone.Name := 'pnlBaseSearchZone';
 f_pnlBaseSearchZone.Parent := pnlBaseSearch;
 with DefineZone(vcm_ztMain, pnlBaseSearchZone) do
 begin
 end;//with DefineZone(vcm_ztMain
 f_pnlLogo := TvtPanel.Create(Self);
 f_pnlLogo.Name := 'pnlLogo';
 f_pnlLogo.Parent := pnlMain;
 f_pbLogo := TPaintBox.Create(Self);
 f_pbLogo.Name := 'pbLogo';
 f_pbLogo.Parent := pnlLogo;
 f_pnlSearches := TvtPanel.Create(Self);
 f_pnlSearches.Name := 'pnlSearches';
 f_pnlSearches.Parent := pnlMain;
 f_flAttributeSearch := TnscFocusLabel.Create(Self);
 f_flAttributeSearch.Name := 'flAttributeSearch';
 f_flAttributeSearch.Parent := pnlSearches;
 f_flAttributeSearch.Caption := '• По реквизитам';
 f_flSituationSearch := TnscFocusLabel.Create(Self);
 f_flSituationSearch.Name := 'flSituationSearch';
 f_flSituationSearch.Parent := pnlSearches;
 f_flSituationSearch.Caption := '• По ситуации';
 f_flPublishedSourceSearch := TnscFocusLabel.Create(Self);
 f_flPublishedSourceSearch.Name := 'flPublishedSourceSearch';
 f_flPublishedSourceSearch.Parent := pnlSearches;
 f_flPublishedSourceSearch.Caption := '• По источнику опубликования';
 f_flDictionSearch := TnscFocusLabel.Create(Self);
 f_flDictionSearch.Name := 'flDictionSearch';
 f_flDictionSearch.Parent := pnlSearches;
 f_flDictionSearch.Caption := '• По Толковому словарю';
 f_pnlExpert := TvtPanel.Create(Self);
 f_pnlExpert.Name := 'pnlExpert';
 f_pnlExpert.Parent := pnlMain;
 f_pbExpert := TPaintBox.Create(Self);
 f_pbExpert.Name := 'pbExpert';
 f_pbExpert.Parent := pnlExpert;
 f_pnlOnLine := TvtPanel.Create(Self);
 f_pnlOnLine.Name := 'pnlOnLine';
 f_pnlOnLine.Parent := pnlMain;
 f_pbOnLine := TPaintBox.Create(Self);
 f_pbOnLine.Name := 'pbOnLine';
 f_pbOnLine.Parent := pnlOnLine;
 f_pbIntranet := TPaintBox.Create(Self);
 f_pbIntranet.Name := 'pbIntranet';
 f_pbIntranet.Parent := pnlOnLine;
 f_pbCourtsOnline := TPaintBox.Create(Self);
 f_pbCourtsOnline.Name := 'pbCourtsOnline';
 f_pbCourtsOnline.Parent := pnlOnLine;
 f_hfTaxes := TnscHideField.Create(Self);
 f_hfTaxes.Name := 'hfTaxes';
 f_hfTaxes.Parent := pnlMain;
 f_hfTaxes.Caption := 'Налоги, финансы';
 f_tvTaxes := TnscTreeViewHotTruck.Create(Self);
 f_tvTaxes.Name := 'tvTaxes';
 f_tvTaxes.Parent := hfTaxes;
 f_pnlBanner := TvtPanel.Create(Self);
 f_pnlBanner.Name := 'pnlBanner';
 f_pnlBanner.Parent := pnlMain;
 f_ieBanner := TImageEnView.Create(Self);
 f_ieBanner.Name := 'ieBanner';
 f_ieBanner.Parent := pnlBanner;
 hfLastOpenDocs.Parent := pnlMain;
 f_hfLastOpenDocsRightEdge := TvtPanel.Create(Self);
 f_hfLastOpenDocsRightEdge.Name := 'hfLastOpenDocsRightEdge';
 f_hfLastOpenDocsRightEdge.Parent := hfLastOpenDocs;
 f_ieIO := TImageEnIO.Create(Self);
 f_ieIO.Name := 'ieIO';
end;//TPrimMainMenuNewForm.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimMainMenuNewForm);
 {* Регистрация PrimMainMenuNew }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

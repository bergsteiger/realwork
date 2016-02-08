unit CommonSearch_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\CommonSearch_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , afwInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , ConfigInterfaces
 , l3Interfaces
 , Classes
 , PrimSaveLoadOptionsWithUserTypes_Form
 , Search_FormDefinitions_Controls
 , PrimQueryCardOptions_Form
 , PrimPreview_Form
 , PrimPageSetupOptions_Form
 , PrimPrintDialogOptions_Form
 , l3StringIDEx
;

type
 TcfSaveLoad = {final} class(TPrimSaveLoadOptionsWithUserTypesForm, SaveLoadFormDef)
 end;//TcfSaveLoad

 TenQueryCard = {final} class(TPrimQueryCardOptionsForm, QueryCardFormDef)
  {* Карточка запросов }
 end;//TenQueryCard

 TefPreviewForm = {final} class(TPrimPreviewForm, PreviewFormDef)
  {* Предварительный просмотр }
 end;//TefPreviewForm

 Ten_PageSetup = {final} class(TPrimPageSetupOptionsForm)
  {* Настройка страницы }
  protected
   procedure ReadPageFormats; override;
   procedure SetColontitulComboBoxItemIndex(aIndex: Integer); override;
   procedure ToGUIMargins; override;
   procedure Save(SaveAsDefault: Boolean = False); override;
   procedure SetPageFormat(aOrientation: Integer); override;
   procedure MacroAdd(const aString: AnsiString); override;
   procedure ToGUIColontituls; override;
  public
   {$If NOT Defined(NoVCM)}
   procedure Save; override;
    {* Сохранить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//Ten_PageSetup

 Ten_PrintDialog = {final} class(TPrimPrintDialogOptionsForm)
  protected
   procedure UpdateState; override;
   function UpdatePrintersList: Boolean; override;
 end;//Ten_PrintDialog

 TCommonSearchModule = class(IafwPageSetup, IafwPrintManager)
  protected
   function pm_GetMargins: TafwRect;
   function pm_GetOrientation: Tl3PageOrientation;
   function CanPrint: Boolean;
   procedure PrintDialog(const aPreview: IafwDocumentPreview);
    {* выводит диалог печати. }
   procedure ShowPreview(const aPreview: IafwDocumentPreview);
    {* показывает предварительный просмотр печати. }
   function pm_GetPageSetup: IafwPageSetup;
  public
   procedure MakeSaveLoadForm(const aParams: IvcmMakeParams;
    aZoneType: TvcmZoneType;
    aRecursive: Boolean;
    aUserType: TvcmUserType);
   procedure MakeQueryCardForm(aFilter: Boolean;
    const aParams: IvcmMakeParams;
    aZoneType: TvcmZoneType;
    aRecursive: Boolean;
    aUserType: TvcmUserType);
   procedure MakePreview(const aPreview: IafwDocumentPreview);
   function MakePageSetup(const aData: InsPageSettingsInfo): Integer;
   procedure MakePrintDialog(const aPreview: IafwDocumentPreview);
   constructor Create(AOwner: TComponent); override;
 end;//TCommonSearchModule
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , nsUtils
 , evConst
 , DataAdapter
 , nsConst
 , Windows
 , afwFacade
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , SaveLoadKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , QueryCardKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , PreviewFormKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , PageSetupKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , l3RangeManager
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , PrintDialogKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки ut_PrintDialogLocalConstants }
 str_ut_PrintDialogCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_PrintDialogCaption'; rValue : 'PrintDialog');
  {* Заголовок пользовательского типа "PrintDialog" }

{$If NOT Defined(NoVCM)}
procedure Ten_PageSetup.Save;
 {* Сохранить }
//#UC START# *495235F401C0_4AAF86650309_var*
//#UC END# *495235F401C0_4AAF86650309_var*
begin
//#UC START# *495235F401C0_4AAF86650309_impl*
 !!! Needs to be implemented !!!
//#UC END# *495235F401C0_4AAF86650309_impl*
end;//Ten_PageSetup.Save
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure Ten_PageSetup.Ok;
 {* OK }
//#UC START# *4A97EBE702F8_4AAF86650309_var*
//#UC END# *4A97EBE702F8_4AAF86650309_var*
begin
//#UC START# *4A97EBE702F8_4AAF86650309_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A97EBE702F8_4AAF86650309_impl*
end;//Ten_PageSetup.Ok
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure Ten_PageSetup.Cancel;
 {* Отмена }
//#UC START# *4AC5D61E0284_4AAF86650309_var*
//#UC END# *4AC5D61E0284_4AAF86650309_var*
begin
//#UC START# *4AC5D61E0284_4AAF86650309_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC5D61E0284_4AAF86650309_impl*
end;//Ten_PageSetup.Cancel
{$IfEnd} // NOT Defined(NoVCM)

procedure Ten_PageSetup.ReadPageFormats;
//#UC START# *4AC608780164_4AAF86650309_var*
//#UC END# *4AC608780164_4AAF86650309_var*
begin
//#UC START# *4AC608780164_4AAF86650309_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC608780164_4AAF86650309_impl*
end;//Ten_PageSetup.ReadPageFormats

procedure Ten_PageSetup.SetColontitulComboBoxItemIndex(aIndex: Integer);
//#UC START# *4AC6089603D4_4AAF86650309_var*
//#UC END# *4AC6089603D4_4AAF86650309_var*
begin
//#UC START# *4AC6089603D4_4AAF86650309_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC6089603D4_4AAF86650309_impl*
end;//Ten_PageSetup.SetColontitulComboBoxItemIndex

procedure Ten_PageSetup.ToGUIMargins;
//#UC START# *4AC608AC03C7_4AAF86650309_var*
//#UC END# *4AC608AC03C7_4AAF86650309_var*
begin
//#UC START# *4AC608AC03C7_4AAF86650309_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC608AC03C7_4AAF86650309_impl*
end;//Ten_PageSetup.ToGUIMargins

procedure Ten_PageSetup.Save(SaveAsDefault: Boolean = False);
//#UC START# *4C88D996000B_4AAF86650309_var*
//#UC END# *4C88D996000B_4AAF86650309_var*
begin
//#UC START# *4C88D996000B_4AAF86650309_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C88D996000B_4AAF86650309_impl*
end;//Ten_PageSetup.Save

procedure Ten_PageSetup.SetPageFormat(aOrientation: Integer);
//#UC START# *4C88D9B60023_4AAF86650309_var*
//#UC END# *4C88D9B60023_4AAF86650309_var*
begin
//#UC START# *4C88D9B60023_4AAF86650309_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C88D9B60023_4AAF86650309_impl*
end;//Ten_PageSetup.SetPageFormat

procedure Ten_PageSetup.MacroAdd(const aString: AnsiString);
//#UC START# *4C88D9D30306_4AAF86650309_var*
//#UC END# *4C88D9D30306_4AAF86650309_var*
begin
//#UC START# *4C88D9D30306_4AAF86650309_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C88D9D30306_4AAF86650309_impl*
end;//Ten_PageSetup.MacroAdd

procedure Ten_PageSetup.ToGUIColontituls;
//#UC START# *4C88DCA000DD_4AAF86650309_var*
//#UC END# *4C88DCA000DD_4AAF86650309_var*
begin
//#UC START# *4C88DCA000DD_4AAF86650309_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C88DCA000DD_4AAF86650309_impl*
end;//Ten_PageSetup.ToGUIColontituls

procedure Ten_PrintDialog.UpdateState;
//#UC START# *4AC6228101B1_4AAF8EAC01FC_var*
//#UC END# *4AC6228101B1_4AAF8EAC01FC_var*
begin
//#UC START# *4AC6228101B1_4AAF8EAC01FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC6228101B1_4AAF8EAC01FC_impl*
end;//Ten_PrintDialog.UpdateState

function Ten_PrintDialog.UpdatePrintersList: Boolean;
//#UC START# *4AF8271C0033_4AAF8EAC01FC_var*
//#UC END# *4AF8271C0033_4AAF8EAC01FC_var*
begin
//#UC START# *4AF8271C0033_4AAF8EAC01FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF8271C0033_4AAF8EAC01FC_impl*
end;//Ten_PrintDialog.UpdatePrintersList

procedure TCommonSearchModule.MakeSaveLoadForm(const aParams: IvcmMakeParams;
 aZoneType: TvcmZoneType;
 aRecursive: Boolean;
 aUserType: TvcmUserType);
//#UC START# *4AA93293002B_4AA931390118_var*
//#UC END# *4AA93293002B_4AA931390118_var*
begin
//#UC START# *4AA93293002B_4AA931390118_impl*
 Assert(aRecursive);
 Result := TcfSaveLoad.MakeSingleChild(aParams.Container,
                                             aParams,
                                             aZoneType,
                                             aUserType);
//#UC END# *4AA93293002B_4AA931390118_impl*
end;//TCommonSearchModule.MakeSaveLoadForm

procedure TCommonSearchModule.MakeQueryCardForm(aFilter: Boolean;
 const aParams: IvcmMakeParams;
 aZoneType: TvcmZoneType;
 aRecursive: Boolean;
 aUserType: TvcmUserType);
//#UC START# *4AA9396E02B8_4AA931390118_var*
//#UC END# *4AA9396E02B8_4AA931390118_var*
begin
//#UC START# *4AA9396E02B8_4AA931390118_impl*
 Assert(aRecursive);
 Result := TenQueryCard.MakeSingleChild(aFilter,
                                        aParams.Container,
                                        aParams.Aggregate,
                                        aZoneType,
                                        aUserType);
//#UC END# *4AA9396E02B8_4AA931390118_impl*
end;//TCommonSearchModule.MakeQueryCardForm

procedure TCommonSearchModule.MakePreview(const aPreview: IafwDocumentPreview);
//#UC START# *4AAF73E6039E_4AA931390118_var*
 l_Params: IvcmMakeParams;
//#UC END# *4AAF73E6039E_4AA931390118_var*
begin
//#UC START# *4AAF73E6039E_4AA931390118_impl*
 l_Params := vcmCheckAggregate(vcmMakeParams(nil, CheckContainer(nil)));
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=606808801
 Result := TPreviewForm.Make(aPreview, l_Params);
//#UC END# *4AAF73E6039E_4AA931390118_impl*
end;//TCommonSearchModule.MakePreview

function TCommonSearchModule.MakePageSetup(const aData: InsPageSettingsInfo): Integer;
var l_Form: IvcmEntityForm;
//#UC START# *4AAF85DA01D1_4AA931390118_var*
//#UC END# *4AAF85DA01D1_4AA931390118_var*
begin
//#UC START# *4AAF85DA01D1_4AA931390118_impl*
 l_Form := Ten_PageSetup.Make(aData);
 try
  Assert((l_Form <> nil));
  Result := l_Form.ShowModal;
 finally
  l_Form := nil;
 end;//try..finally
//#UC END# *4AAF85DA01D1_4AA931390118_impl*
end;//TCommonSearchModule.MakePageSetup

procedure TCommonSearchModule.MakePrintDialog(const aPreview: IafwDocumentPreview);
//#UC START# *4AAF8EE1019C_4AA931390118_var*
//#UC END# *4AAF8EE1019C_4AA931390118_var*
begin
//#UC START# *4AAF8EE1019C_4AA931390118_impl*
 Result := Ten_PrintDialog.Make(aPreview);
 if (Result <> nil) AND (Result.ZoneType <> vcm_ztModal) then
 begin
  Result.ShowModal;
  Result := nil;
 end;//Result <> nil
//#UC END# *4AAF8EE1019C_4AA931390118_impl*
end;//TCommonSearchModule.MakePrintDialog

function TCommonSearchModule.pm_GetMargins: TafwRect;
//#UC START# *473D8F8602AE_4AA931390118get_var*
//#UC END# *473D8F8602AE_4AA931390118get_var*
begin
//#UC START# *473D8F8602AE_4AA931390118get_impl*
 with Result.R do
 begin
  Left := Round(afw.Settings.LoadDouble(pi_Print_Metrics_Margins_Left,
                                       StrToFloat(dv_Print_Metrics_Margins_Left)) * evInchMul / (ev_mmInInch / 10));
  Right := Round(afw.Settings.LoadDouble(pi_Print_Metrics_Margins_Right,
                                        StrToFloat(dv_Print_Metrics_Margins_Right)) * evInchMul / (ev_mmInInch / 10));
  Top := Round(afw.Settings.LoadDouble(pi_Print_Metrics_Margins_Top,
                                     StrToFloat(dv_Print_Metrics_Margins_Top)) * evInchMul / (ev_mmInInch / 10));
  Bottom := Round(afw.Settings.LoadDouble(pi_Print_Metrics_Margins_Bottom,
                                       StrToFloat(dv_Print_Metrics_Margins_Bottom)) * evInchMul / (ev_mmInInch / 10));
 end;//with Result.R
//#UC END# *473D8F8602AE_4AA931390118get_impl*
end;//TCommonSearchModule.pm_GetMargins

function TCommonSearchModule.pm_GetOrientation: Tl3PageOrientation;
//#UC START# *473D8F9202F2_4AA931390118get_var*
//#UC END# *473D8F9202F2_4AA931390118get_var*
begin
//#UC START# *473D8F9202F2_4AA931390118get_impl*
 if StringToOrientation(afw.Settings.LoadString(pi_Print_Metrics_Orientation,
                                  dv_Print_Metrics_Orientation)) = DMORIENT_LANDSCAPE then
  Result := l3_poLandscape
 else
  Result := l3_poPortrait;                                            
//#UC END# *473D8F9202F2_4AA931390118get_impl*
end;//TCommonSearchModule.pm_GetOrientation

function TCommonSearchModule.CanPrint: Boolean;
//#UC START# *473D8FB70042_4AA931390118_var*
//#UC END# *473D8FB70042_4AA931390118_var*
begin
//#UC START# *473D8FB70042_4AA931390118_impl*
 Result := not DefDataAdapter.IsTrialMode;
//#UC END# *473D8FB70042_4AA931390118_impl*
end;//TCommonSearchModule.CanPrint

procedure TCommonSearchModule.PrintDialog(const aPreview: IafwDocumentPreview);
 {* выводит диалог печати. }
//#UC START# *473D8FC5038B_4AA931390118_var*
//#UC END# *473D8FC5038B_4AA931390118_var*
begin
//#UC START# *473D8FC5038B_4AA931390118_impl*
 MakePrintDialog(aPreview);
//#UC END# *473D8FC5038B_4AA931390118_impl*
end;//TCommonSearchModule.PrintDialog

procedure TCommonSearchModule.ShowPreview(const aPreview: IafwDocumentPreview);
 {* показывает предварительный просмотр печати. }
//#UC START# *473D8FDC01EA_4AA931390118_var*
//#UC END# *473D8FDC01EA_4AA931390118_var*
begin
//#UC START# *473D8FDC01EA_4AA931390118_impl*
 MakePreview(aPreview);
//#UC END# *473D8FDC01EA_4AA931390118_impl*
end;//TCommonSearchModule.ShowPreview

function TCommonSearchModule.pm_GetPageSetup: IafwPageSetup;
//#UC START# *473D8FEE0222_4AA931390118get_var*
//#UC END# *473D8FEE0222_4AA931390118get_var*
begin
//#UC START# *473D8FEE0222_4AA931390118get_impl*
 Result := Self;
//#UC END# *473D8FEE0222_4AA931390118get_impl*
end;//TCommonSearchModule.pm_GetPageSetup

constructor TCommonSearchModule.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4AA931390118_var*
//#UC END# *47D1602000C6_4AA931390118_var*
begin
//#UC START# *47D1602000C6_4AA931390118_impl*
 inherited;
 if (afw.Application <> nil) then
  afw.Application.PrintManager := Self;
//#UC END# *47D1602000C6_4AA931390118_impl*
end;//TCommonSearchModule.Create

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TcfSaveLoad);
 {* Регистрация SaveLoad }
{$IfEnd} // NOT Defined(NoScripts)
 fm_cfSaveLoad.SetFactory(TcfSaveLoad.Make);
 {* Регистрация фабрики формы SaveLoad }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TenQueryCard);
 {* Регистрация QueryCard }
{$IfEnd} // NOT Defined(NoScripts)
 fm_enQueryCard.SetFactory(TenQueryCard.Make);
 {* Регистрация фабрики формы QueryCard }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefPreviewForm);
 {* Регистрация PreviewForm }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_PageSetup);
 {* Регистрация PageSetup }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_PrintDialog);
 {* Регистрация PrintDialog }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_PrintDialogCaption.Init;
 {* Инициализация str_ut_PrintDialogCaption }
{$IfEnd} // NOT Defined(Admin)

end.

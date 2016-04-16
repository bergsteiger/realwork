unit CommonSearch_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\CommonSearch_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "CommonSearch" MUID: (4AA931390118)
// Имя типа: "TCommonSearchModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
;

type
 TCommonSearchModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 , IafwPageSetup, IafwPrintManager)
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
;

{$If NOT Defined(NoVCM)}
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
 Result := True{not DefDataAdapter.IsTrialMode};
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
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin)
end.

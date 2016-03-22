unit CommonSearch_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/CommonSearch_Module.pas"
// Начат: 10.09.2009 21:03
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormsPack::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::CommonSearch
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  afwInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  evTextSource
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  evQueryCardEditor,
  ConfigInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  vtPanel,
  vtComboBoxQS,
  SaveLoad_Form,
  QueryCard_Form,
  PrimPreview_Form,
  Preview_Form,
  PageSetup_Form,
  PrintDialog_Form,
  vtGroupBox
  {$If defined(Nemesis)}
  ,
  nscPageControl
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscPreviewPanel
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtLabel,
  l3StringIDEx,
  Search_FormDefinitions_Controls,
  PrimPrintDialogOptions_Form,
  vtSpinEdit,
  PrimQueryCardOptions_Form,
  PrimPageSetupOptions_Form
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  PrimSaveLoadOptionsWithUserTypes_Form
  {$If not defined(NoScripts)}
  ,
  tfwControlString
  {$IfEnd} //not NoScripts
  ,
  vtCheckBox,
  vtRadioButton
  {$If not defined(NoScripts)}
  ,
  tfwPropertyLike
  {$IfEnd} //not NoScripts
  
  {$If not defined(Admin) AND not defined(NoScripts)}
  ,
  SaveLoadKeywordsPack
  {$IfEnd} //not Admin AND not NoScripts
  
  {$If not defined(Admin) AND not defined(NoScripts)}
  ,
  QueryCardKeywordsPack
  {$IfEnd} //not Admin AND not NoScripts
  
  {$If not defined(Admin) AND not defined(NoScripts)}
  ,
  PreviewFormKeywordsPack
  {$IfEnd} //not Admin AND not NoScripts
  
  {$If not defined(Admin) AND not defined(NoScripts)}
  ,
  PageSetupKeywordsPack
  {$IfEnd} //not Admin AND not NoScripts
  
  {$If not defined(Admin) AND not defined(NoScripts)}
  ,
  PrintDialogKeywordsPack
  {$IfEnd} //not Admin AND not NoScripts
  ,
  Classes,
  l3Interfaces,
  vcmExternalInterfaces {a},
  vcmModule {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TCommonSearchModule = {formspack} class(TvcmModule, IafwPageSetup, IafwPrintManager)
 protected
  class procedure GetEntityForms(aList : TvcmClassList); override;
 protected
 // realized methods
   function pm_GetMargins: TafwRect;
   function pm_GetOrientation: Tl3PageOrientation;
   function CanPrint: Boolean;
   procedure PrintDialog(const aPreview: IafwDocumentPreview);
     {* выводит диалог печати. }
   procedure ShowPreview(const aPreview: IafwDocumentPreview);
     {* показывает предварительный просмотр печати. }
   function pm_GetPageSetup: IafwPageSetup;
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
 public
 // public methods
   class function MakeSaveLoadForm(const aParams: IvcmMakeParams;
     aZoneType: TvcmZoneType;
     aRecursive: Boolean;
     aUserType: TvcmUserType): IvcmEntityForm;
   class function MakeQueryCardForm(aFilter: Boolean;
     const aParams: IvcmMakeParams;
     aZoneType: TvcmZoneType;
     aRecursive: Boolean;
     aUserType: TvcmUserType): IvcmEntityForm;
   class function MakePreview(const aPreview: IafwDocumentPreview): IvcmEntityForm;
   class function MakePageSetup(const aData: InsPageSettingsInfo): Integer;
   class function MakePrintDialog(const aPreview: IafwDocumentPreview): IvcmEntityForm;
 end;//TCommonSearchModule
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmTabbedContainerFormDispatcher
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  ,
  l3RangeManager,
  l3MessageID,
  nsUtils,
  evConst,
  DataAdapter,
  nsConst,
  Windows,
  afwFacade
  {$If not defined(NoScripts)}
  ,
  tfwScriptingTypes
  {$IfEnd} //not NoScripts
  ,
  TypInfo
  {$If not defined(NoScripts)}
  ,
  tfwTypeRegistrator
  {$IfEnd} //not NoScripts
  ,
  vcmFormSetFactory {a},
  StdRes {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

// start class TCommonSearchModule

class function TCommonSearchModule.MakeSaveLoadForm(const aParams: IvcmMakeParams;
  aZoneType: TvcmZoneType;
  aRecursive: Boolean;
  aUserType: TvcmUserType): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4AA93293002B_4AA931390118_var*
//#UC END# *4AA93293002B_4AA931390118_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AA93293002B_4AA931390118_impl*
 Assert(aRecursive);
 Result := TcfSaveLoad.MakeSingleChild(aParams.Container,
                                             aParams,
                                             aZoneType,
                                             aUserType);
//#UC END# *4AA93293002B_4AA931390118_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TCommonSearchModule.MakeSaveLoadForm

class function TCommonSearchModule.MakeQueryCardForm(aFilter: Boolean;
  const aParams: IvcmMakeParams;
  aZoneType: TvcmZoneType;
  aRecursive: Boolean;
  aUserType: TvcmUserType): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4AA9396E02B8_4AA931390118_var*
//#UC END# *4AA9396E02B8_4AA931390118_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AA9396E02B8_4AA931390118_impl*
 Assert(aRecursive);
 Result := TenQueryCard.MakeSingleChild(aFilter,
                                        aParams.Container,
                                        aParams.Aggregate,
                                        aZoneType,
                                        aUserType);
//#UC END# *4AA9396E02B8_4AA931390118_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TCommonSearchModule.MakeQueryCardForm

class function TCommonSearchModule.MakePreview(const aPreview: IafwDocumentPreview): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4AAF73E6039E_4AA931390118_var*
 l_Params: IvcmMakeParams;
//#UC END# *4AAF73E6039E_4AA931390118_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AAF73E6039E_4AA931390118_impl*
 l_Params := vcmCheckAggregate(vcmMakeParams(nil, CheckContainer(nil)));
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=606808801
 Result := TPreviewForm.Make(aPreview, l_Params);
//#UC END# *4AAF73E6039E_4AA931390118_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TCommonSearchModule.MakePreview

class function TCommonSearchModule.MakePageSetup(const aData: InsPageSettingsInfo): Integer;
var
 __WasEnter : Boolean;
//#UC START# *4AAF85DA01D1_4AA931390118_var*
//#UC END# *4AAF85DA01D1_4AA931390118_var*
var
 l_Form : IvcmEntityForm;
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AAF85DA01D1_4AA931390118_impl*
 l_Form := Ten_PageSetup.Make(aData);
 try
  Assert((l_Form <> nil));
  Result := l_Form.ShowModal;
 finally
  l_Form := nil;
 end;//try..finally
//#UC END# *4AAF85DA01D1_4AA931390118_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TCommonSearchModule.MakePageSetup

class function TCommonSearchModule.MakePrintDialog(const aPreview: IafwDocumentPreview): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4AAF8EE1019C_4AA931390118_var*
//#UC END# *4AAF8EE1019C_4AA931390118_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AAF8EE1019C_4AA931390118_impl*
 Result := Ten_PrintDialog.Make(aPreview);
 if (Result <> nil) AND (Result.ZoneType <> vcm_ztModal) then
 begin
  Result.ShowModal;
  Result := nil;
 end;//Result <> nil
//#UC END# *4AAF8EE1019C_4AA931390118_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
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
//#UC START# *473D8FC5038B_4AA931390118_var*
//#UC END# *473D8FC5038B_4AA931390118_var*
begin
//#UC START# *473D8FC5038B_4AA931390118_impl*
 MakePrintDialog(aPreview);
//#UC END# *473D8FC5038B_4AA931390118_impl*
end;//TCommonSearchModule.PrintDialog

procedure TCommonSearchModule.ShowPreview(const aPreview: IafwDocumentPreview);
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

class procedure TCommonSearchModule.GetEntityForms(aList : TvcmClassList);
begin
 inherited;
 aList.Add(TcfSaveLoad);
 aList.Add(TenQueryCard);
 aList.Add(TefPreviewForm);
 aList.Add(Ten_PageSetup);
 aList.Add(Ten_PrintDialog);
end;

{$IfEnd} //not Admin

end.
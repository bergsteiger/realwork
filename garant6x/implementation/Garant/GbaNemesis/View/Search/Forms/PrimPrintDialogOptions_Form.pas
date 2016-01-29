unit PrimPrintDialogOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimPrintDialogOptions_Form.pas"
// Начат: 30.07.2010 15:46
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimPrintDialogOptions
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
  vtComboBoxQS
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  PrimPrintDialog_Form
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtSpinEdit,
  vtCheckBox,
  vtRadioButton,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TPrimPrintDialogOptionsForm = {form} class(TPrimPrintDialogForm)
 private
 // private fields
   f_poDocumentNames : TvtRadioButton;
    {* Поле для свойства poDocumentNames}
   f_rbPrintSelected : TvtRadioButton;
    {* Поле для свойства rbPrintSelected}
   f_rbPrintCurrent : TvtRadioButton;
    {* Поле для свойства rbPrintCurrent}
   f_edPrintInterval : TnscEditWithoutPlusMinusShortcut;
    {* Поле для свойства edPrintInterval}
   f_edCopyCount : TvtSpinEdit;
    {* Поле для свойства edCopyCount}
   f_CollateCheckBox : TvtCheckBox;
    {* Поле для свойства CollateCheckBox}
   f_cbOddEven : TvtComboBoxQS;
    {* Поле для свойства cbOddEven}
   f_poDocumentTexts : TvtRadioButton;
    {* Поле для свойства poDocumentTexts}
   f_rbPrintAll : TvtRadioButton;
    {* Поле для свойства rbPrintAll}
   f_rbPrintInterval : TvtRadioButton;
    {* Поле для свойства rbPrintInterval}
   f_cbPrinter : TvtComboBoxQS;
    {* Поле для свойства cbPrinter}
   f_cbPrintInfo : TvtCheckBox;
    {* Поле для свойства cbPrintInfo}
 protected
  procedure InitEntities; override;
 protected
 // property methods
   function pm_GetPoDocumentNames: TvtRadioButton;
   function pm_GetRbPrintSelected: TvtRadioButton;
   function pm_GetRbPrintCurrent: TvtRadioButton;
   function pm_GetEdPrintInterval: TnscEditWithoutPlusMinusShortcut;
   function pm_GetEdCopyCount: TvtSpinEdit;
   function pm_GetCollateCheckBox: TvtCheckBox;
   function pm_GetCbOddEven: TvtComboBoxQS;
   function pm_GetPoDocumentTexts: TvtRadioButton;
   function pm_GetRbPrintAll: TvtRadioButton;
   function pm_GetRbPrintInterval: TvtRadioButton;
   function pm_GetCbPrinter: TvtComboBoxQS;
   function pm_GetCbPrintInfo: TvtCheckBox;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_Test(const aParams: IvcmTestParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_GetState(var State: TvcmOperationStateIndex);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
 public
 // public properties
   property poDocumentNames: TvtRadioButton
     read pm_GetPoDocumentNames;
   property rbPrintSelected: TvtRadioButton
     read pm_GetRbPrintSelected;
   property rbPrintCurrent: TvtRadioButton
     read pm_GetRbPrintCurrent;
   property edPrintInterval: TnscEditWithoutPlusMinusShortcut
     read pm_GetEdPrintInterval;
   property edCopyCount: TvtSpinEdit
     read pm_GetEdCopyCount;
   property CollateCheckBox: TvtCheckBox
     read pm_GetCollateCheckBox;
   property cbOddEven: TvtComboBoxQS
     read pm_GetCbOddEven;
   property poDocumentTexts: TvtRadioButton
     read pm_GetPoDocumentTexts;
   property rbPrintAll: TvtRadioButton
     read pm_GetRbPrintAll;
   property rbPrintInterval: TvtRadioButton
     read pm_GetRbPrintInterval;
   property cbPrinter: TvtComboBoxQS
     read pm_GetCbPrinter;
   property cbPrintInfo: TvtCheckBox
     read pm_GetCbPrintInfo;
 end;//TPrimPrintDialogOptionsForm

 TvcmEntityFormRef = TPrimPrintDialogOptionsForm;
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  nsTrialSupport,
  PreviewInterfaces,
  evExcept,
  afwInterfaces,
  l3Interfaces,
  l3RangeManager,
  SysUtils,
  nsConst,
  afwFacade,
  afwTypes,
  l3Base,
  l3String
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

// start class TPrimPrintDialogOptionsForm

function TPrimPrintDialogOptionsForm.pm_GetPoDocumentNames: TvtRadioButton;
begin
 if (f_poDocumentNames = nil) then
  f_poDocumentNames := FindComponent('poDocumentNames') As TvtRadioButton;
 Result := f_poDocumentNames;
end;

function TPrimPrintDialogOptionsForm.pm_GetRbPrintSelected: TvtRadioButton;
begin
 if (f_rbPrintSelected = nil) then
  f_rbPrintSelected := FindComponent('rbPrintSelected') As TvtRadioButton;
 Result := f_rbPrintSelected;
end;

function TPrimPrintDialogOptionsForm.pm_GetRbPrintCurrent: TvtRadioButton;
begin
 if (f_rbPrintCurrent = nil) then
  f_rbPrintCurrent := FindComponent('rbPrintCurrent') As TvtRadioButton;
 Result := f_rbPrintCurrent;
end;

function TPrimPrintDialogOptionsForm.pm_GetEdPrintInterval: TnscEditWithoutPlusMinusShortcut;
begin
 if (f_edPrintInterval = nil) then
  f_edPrintInterval := FindComponent('edPrintInterval') As TnscEditWithoutPlusMinusShortcut;
 Result := f_edPrintInterval;
end;

function TPrimPrintDialogOptionsForm.pm_GetEdCopyCount: TvtSpinEdit;
begin
 if (f_edCopyCount = nil) then
  f_edCopyCount := FindComponent('edCopyCount') As TvtSpinEdit;
 Result := f_edCopyCount;
end;

function TPrimPrintDialogOptionsForm.pm_GetCollateCheckBox: TvtCheckBox;
begin
 if (f_CollateCheckBox = nil) then
  f_CollateCheckBox := FindComponent('CollateCheckBox') As TvtCheckBox;
 Result := f_CollateCheckBox;
end;

function TPrimPrintDialogOptionsForm.pm_GetCbOddEven: TvtComboBoxQS;
begin
 if (f_cbOddEven = nil) then
  f_cbOddEven := FindComponent('cbOddEven') As TvtComboBoxQS;
 Result := f_cbOddEven;
end;

function TPrimPrintDialogOptionsForm.pm_GetPoDocumentTexts: TvtRadioButton;
begin
 if (f_poDocumentTexts = nil) then
  f_poDocumentTexts := FindComponent('poDocumentTexts') As TvtRadioButton;
 Result := f_poDocumentTexts;
end;

function TPrimPrintDialogOptionsForm.pm_GetRbPrintAll: TvtRadioButton;
begin
 if (f_rbPrintAll = nil) then
  f_rbPrintAll := FindComponent('rbPrintAll') As TvtRadioButton;
 Result := f_rbPrintAll;
end;

function TPrimPrintDialogOptionsForm.pm_GetRbPrintInterval: TvtRadioButton;
begin
 if (f_rbPrintInterval = nil) then
  f_rbPrintInterval := FindComponent('rbPrintInterval') As TvtRadioButton;
 Result := f_rbPrintInterval;
end;

function TPrimPrintDialogOptionsForm.pm_GetCbPrinter: TvtComboBoxQS;
begin
 if (f_cbPrinter = nil) then
  f_cbPrinter := FindComponent('cbPrinter') As TvtComboBoxQS;
 Result := f_cbPrinter;
end;

function TPrimPrintDialogOptionsForm.pm_GetCbPrintInfo: TvtCheckBox;
begin
 if (f_cbPrintInfo = nil) then
  f_cbPrintInfo := FindComponent('cbPrintInfo') As TvtCheckBox;
 Result := f_cbPrintInfo;
end;

{$If not defined(NoVCM)}
procedure TPrimPrintDialogOptionsForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A8AD46D0226_4C52BA5D01A8exec_var*
//#UC END# *4A8AD46D0226_4C52BA5D01A8exec_var*
begin
//#UC START# *4A8AD46D0226_4C52BA5D01A8exec_impl*
 ModalResult := mrCancel;
//#UC END# *4A8AD46D0226_4C52BA5D01A8exec_impl*
end;//TPrimPrintDialogOptionsForm.Result_Cancel_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimPrintDialogOptionsForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A97EBE702F8_4C52BA5D01A8test_var*
//#UC END# *4A97EBE702F8_4C52BA5D01A8test_var*
begin
//#UC START# *4A97EBE702F8_4C52BA5D01A8test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (f_Preview <> nil) and
                                  f_Preview.HasText and
                                  f_Preview.Printer.HasPrinter and
                                  not (f_Preview.PreviewResetting or
                                       f_Preview.InProcess);
 {$If not defined(Admin) AND not defined(Monitorings)}
 nsDisableOperationInTrialMode(aParams);
 {$IfEnd} //not Admin AND not Monitorings
//#UC END# *4A97EBE702F8_4C52BA5D01A8test_impl*
end;//TPrimPrintDialogOptionsForm.Result_Ok_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimPrintDialogOptionsForm.Result_Ok_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4A97EBE702F8_4C52BA5D01A8getstate_var*
//#UC END# *4A97EBE702F8_4C52BA5D01A8getstate_var*
begin
//#UC START# *4A97EBE702F8_4C52BA5D01A8getstate_impl*
 State := st_user_Result_Ok_Print;
//#UC END# *4A97EBE702F8_4C52BA5D01A8getstate_impl*
end;//TPrimPrintDialogOptionsForm.Result_Ok_GetState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimPrintDialogOptionsForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A97EBE702F8_4C52BA5D01A8exec_var*
var
 l_Preview  : IafwComplexDocumentPreview;
 l_Interval : String;
 l_RangeMgr : Il3RangeManager;
 l_SuperPreview: InsSuperComplexDocumentPreview;
 l_MultiDocumentPreviewContainer: InsTreeMultiDocumentPreviewContainer;
//#UC END# *4A97EBE702F8_4C52BA5D01A8exec_var*
begin
//#UC START# *4A97EBE702F8_4C52BA5D01A8exec_impl*
 if (f_Preview <> nil) then
 begin
  if Supports(f_Preview, InsSuperComplexDocumentPreview, l_SuperPreview) then
  try
   if poDocumentNames.Checked then
    l_SuperPreview.SuperContentKind := ns_spkDocumentTitles;
   if poDocumentTexts.Checked then
   begin
    l_SuperPreview.SuperContentKind := ns_spkDocumentTexts;
    if rbPrintSelected.Checked then
     Supports(l_SuperPreview.SuperCurrent.Selection, InsTreeMultiDocumentPreviewContainer, l_MultiDocumentPreviewContainer)
    else
     Supports(l_SuperPreview.SuperCurrent.Document, InsTreeMultiDocumentPreviewContainer, l_MultiDocumentPreviewContainer);
    if not afw.Application.IsInternal and (l_MultiDocumentPreviewContainer.ApproxDocCount > c_MaxDocumentInListLimit) then
    begin
     Say(war_TryToPrintTooManyDocs,[c_MaxDocumentInListLimit]);
     Exit;
    end;
    l_MultiDocumentPreviewContainer.Prepare;
   end
   else
    if Assigned(l_SuperPreview.DocumentTexts) then
    begin
     if rbPrintSelected.Checked then
      Supports(l_SuperPreview.DocumentTexts.Selection, InsTreeMultiDocumentPreviewContainer, l_MultiDocumentPreviewContainer)
     else
      Supports(l_SuperPreview.DocumentTexts.Document, InsTreeMultiDocumentPreviewContainer, l_MultiDocumentPreviewContainer);
     if (l_MultiDocumentPreviewContainer.ApproxDocCount > c_MaxTotalDocumentInListLimit) then
     begin
      Say(war_TryToPrintTooManyTotalDocs,[c_MaxTotalDocumentInListLimit]);
      Exit;
     end;
    end;
  finally
   l_SuperPreview := nil;
  end;
  if Supports(f_Preview, IafwComplexDocumentPreview, l_Preview) then
   try
    if rbPrintCurrent.Checked then
     l_Preview.ContentKind := afw_pckDocument
    else
    if rbPrintAll.Checked then
     l_Preview.ContentKind := afw_pckDocument
    else
    if rbPrintSelected.Checked then
     l_Preview.ContentKind := afw_pckSelection
    else
    if rbPrintInterval.Checked then
     l_Preview.ContentKind := afw_pckDocument;
   finally
    l_Preview := nil;
   end;//try..finally
  f_Preview.Printer.PrinterIndex := cbPrinter.ItemIndex;
  if rbPrintCurrent.Checked then
   l_Interval := IntToStr(Succ(f_Preview.CurrentPage))
  else
  if rbPrintInterval.Checked then
   l_Interval := l3Str(edPrintInterval.Text)
  else
   l_Interval := '';
  try
   l_RangeMgr := Tl3RangeManager.Make(l_Interval);
  except
   on ERangeManagerParseError do
   begin
    Say(err_PageRangeParse);
    FocusControl(edPrintInterval);
    Exit;
   end;
   on EConvertError do
   begin
    Say(err_PageRangeParse);
    FocusControl(edPrintInterval);
    Exit;
   end;
   on EIntOverflow do
   begin
    Say(err_PageRangeParse);
    FocusControl(edPrintInterval);
    Exit;
   end;
  end;//try..except

  try
   f_Preview.Print(TafwPagesInterval(cbOddEven.ItemIndex),
                   l_RangeMgr,
                   edCopyCount.AsInteger,
                   '',
                   CollateCheckBox.CHecked);
  except
   on EevNothingToPrint do
   begin
    Say(err_PageRangeParse);
    FocusControl(edPrintInterval);
    Exit;
   end;
   on EevInvalidPrintMargins do
   begin
    ModalResult := mrCancel;
    raise;
   end;
  end;
  if cbPrintInfo.Checked AND
     Supports(f_Preview, IafwComplexDocumentPreview, l_Preview) then
   try
    if (l_Preview.Info <> nil) then
    begin
     // - печатаем справку
     l_Preview.Info.Print(afw_piAll, nil,
                          edCopyCount.AsInteger,
                          '',
                          CollateCheckBox.CHecked);
    end;
   finally
    l_Preview := nil;
   end;//try..finally
  ModalResult := mrOk;
 end;//f_Preview <> nil
//#UC END# *4A97EBE702F8_4C52BA5D01A8exec_impl*
end;//TPrimPrintDialogOptionsForm.Result_Ok_Execute
{$IfEnd} //not NoVCM

procedure TPrimPrintDialogOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, nil, nil);
  ShowInContextMenu(en_Result, op_Cancel, false);
  ShowInToolbar(en_Result, op_Cancel, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, Result_Ok_Test, Result_Ok_GetState);
  ShowInContextMenu(en_Result, op_Ok, false);
  ShowInToolbar(en_Result, op_Ok, true);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
end;

{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация PrimPrintDialogOptions
 TtfwClassRef.Register(TPrimPrintDialogOptionsForm);
{$IfEnd} //not Admin AND not NoScripts

end.
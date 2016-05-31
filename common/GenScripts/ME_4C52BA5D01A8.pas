unit PrimPrintDialogOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimPrintDialogOptions_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimPrintDialogOptions" MUID: (4C52BA5D01A8)
// Имя типа: "TPrimPrintDialogOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimPrintDialog_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , vtRadioButton
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 , vtSpinEdit
 , vtCheckBox
 , vtComboBoxQS
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimPrintDialogOptionsForm = class(TPrimPrintDialogForm)
  private
   f_poDocumentNames: TvtRadioButton;
   f_rbPrintSelected: TvtRadioButton;
   f_rbPrintCurrent: TvtRadioButton;
   f_edPrintInterval: TnscEditWithoutPlusMinusShortcut;
   f_edCopyCount: TvtSpinEdit;
   f_CollateCheckBox: TvtCheckBox;
   f_cbOddEven: TvtComboBoxQS;
   f_poDocumentTexts: TvtRadioButton;
   f_rbPrintAll: TvtRadioButton;
   f_rbPrintInterval: TvtRadioButton;
   f_cbPrinter: TvtComboBoxQS;
   f_cbPrintInfo: TvtCheckBox;
  protected
   function pm_GetpoDocumentNames: TvtRadioButton;
   function pm_GetrbPrintSelected: TvtRadioButton;
   function pm_GetrbPrintCurrent: TvtRadioButton;
   function pm_GetedPrintInterval: TnscEditWithoutPlusMinusShortcut;
   function pm_GetedCopyCount: TvtSpinEdit;
   function pm_GetCollateCheckBox: TvtCheckBox;
   function pm_GetcbOddEven: TvtComboBoxQS;
   function pm_GetpoDocumentTexts: TvtRadioButton;
   function pm_GetrbPrintAll: TvtRadioButton;
   function pm_GetrbPrintInterval: TvtRadioButton;
   function pm_GetcbPrinter: TvtComboBoxQS;
   function pm_GetcbPrintInfo: TvtCheckBox;
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_Test(const aParams: IvcmTestParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_GetState(var State: TvcmOperationStateIndex);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property poDocumentNames: TvtRadioButton
    read pm_GetpoDocumentNames;
   property rbPrintSelected: TvtRadioButton
    read pm_GetrbPrintSelected;
   property rbPrintCurrent: TvtRadioButton
    read pm_GetrbPrintCurrent;
   property edPrintInterval: TnscEditWithoutPlusMinusShortcut
    read pm_GetedPrintInterval;
   property edCopyCount: TvtSpinEdit
    read pm_GetedCopyCount;
   property CollateCheckBox: TvtCheckBox
    read pm_GetCollateCheckBox;
   property cbOddEven: TvtComboBoxQS
    read pm_GetcbOddEven;
   property poDocumentTexts: TvtRadioButton
    read pm_GetpoDocumentTexts;
   property rbPrintAll: TvtRadioButton
    read pm_GetrbPrintAll;
   property rbPrintInterval: TvtRadioButton
    read pm_GetrbPrintInterval;
   property cbPrinter: TvtComboBoxQS
    read pm_GetcbPrinter;
   property cbPrintInfo: TvtCheckBox
    read pm_GetcbPrintInfo;
 end;//TPrimPrintDialogOptionsForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , nsTrialSupport
 , PreviewInterfaces
 , evExcept
 , afwInterfaces
 , l3Interfaces
 , l3RangeManager
 , SysUtils
 , nsConst
 , afwFacade
 , afwTypes
 , l3Base
 , l3String
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4C52BA5D01A8impl_uses*
 //#UC END# *4C52BA5D01A8impl_uses*
;

function TPrimPrintDialogOptionsForm.pm_GetpoDocumentNames: TvtRadioButton;
begin
 if (f_poDocumentNames = nil) then
  f_poDocumentNames := FindComponent('poDocumentNames') As TvtRadioButton;
 Result := f_poDocumentNames;
end;//TPrimPrintDialogOptionsForm.pm_GetpoDocumentNames

function TPrimPrintDialogOptionsForm.pm_GetrbPrintSelected: TvtRadioButton;
begin
 if (f_rbPrintSelected = nil) then
  f_rbPrintSelected := FindComponent('rbPrintSelected') As TvtRadioButton;
 Result := f_rbPrintSelected;
end;//TPrimPrintDialogOptionsForm.pm_GetrbPrintSelected

function TPrimPrintDialogOptionsForm.pm_GetrbPrintCurrent: TvtRadioButton;
begin
 if (f_rbPrintCurrent = nil) then
  f_rbPrintCurrent := FindComponent('rbPrintCurrent') As TvtRadioButton;
 Result := f_rbPrintCurrent;
end;//TPrimPrintDialogOptionsForm.pm_GetrbPrintCurrent

function TPrimPrintDialogOptionsForm.pm_GetedPrintInterval: TnscEditWithoutPlusMinusShortcut;
begin
 if (f_edPrintInterval = nil) then
  f_edPrintInterval := FindComponent('edPrintInterval') As TnscEditWithoutPlusMinusShortcut;
 Result := f_edPrintInterval;
end;//TPrimPrintDialogOptionsForm.pm_GetedPrintInterval

function TPrimPrintDialogOptionsForm.pm_GetedCopyCount: TvtSpinEdit;
begin
 if (f_edCopyCount = nil) then
  f_edCopyCount := FindComponent('edCopyCount') As TvtSpinEdit;
 Result := f_edCopyCount;
end;//TPrimPrintDialogOptionsForm.pm_GetedCopyCount

function TPrimPrintDialogOptionsForm.pm_GetCollateCheckBox: TvtCheckBox;
begin
 if (f_CollateCheckBox = nil) then
  f_CollateCheckBox := FindComponent('CollateCheckBox') As TvtCheckBox;
 Result := f_CollateCheckBox;
end;//TPrimPrintDialogOptionsForm.pm_GetCollateCheckBox

function TPrimPrintDialogOptionsForm.pm_GetcbOddEven: TvtComboBoxQS;
begin
 if (f_cbOddEven = nil) then
  f_cbOddEven := FindComponent('cbOddEven') As TvtComboBoxQS;
 Result := f_cbOddEven;
end;//TPrimPrintDialogOptionsForm.pm_GetcbOddEven

function TPrimPrintDialogOptionsForm.pm_GetpoDocumentTexts: TvtRadioButton;
begin
 if (f_poDocumentTexts = nil) then
  f_poDocumentTexts := FindComponent('poDocumentTexts') As TvtRadioButton;
 Result := f_poDocumentTexts;
end;//TPrimPrintDialogOptionsForm.pm_GetpoDocumentTexts

function TPrimPrintDialogOptionsForm.pm_GetrbPrintAll: TvtRadioButton;
begin
 if (f_rbPrintAll = nil) then
  f_rbPrintAll := FindComponent('rbPrintAll') As TvtRadioButton;
 Result := f_rbPrintAll;
end;//TPrimPrintDialogOptionsForm.pm_GetrbPrintAll

function TPrimPrintDialogOptionsForm.pm_GetrbPrintInterval: TvtRadioButton;
begin
 if (f_rbPrintInterval = nil) then
  f_rbPrintInterval := FindComponent('rbPrintInterval') As TvtRadioButton;
 Result := f_rbPrintInterval;
end;//TPrimPrintDialogOptionsForm.pm_GetrbPrintInterval

function TPrimPrintDialogOptionsForm.pm_GetcbPrinter: TvtComboBoxQS;
begin
 if (f_cbPrinter = nil) then
  f_cbPrinter := FindComponent('cbPrinter') As TvtComboBoxQS;
 Result := f_cbPrinter;
end;//TPrimPrintDialogOptionsForm.pm_GetcbPrinter

function TPrimPrintDialogOptionsForm.pm_GetcbPrintInfo: TvtCheckBox;
begin
 if (f_cbPrintInfo = nil) then
  f_cbPrintInfo := FindComponent('cbPrintInfo') As TvtCheckBox;
 Result := f_cbPrintInfo;
end;//TPrimPrintDialogOptionsForm.pm_GetcbPrintInfo

{$If NOT Defined(NoVCM)}
procedure TPrimPrintDialogOptionsForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Отмена }
//#UC START# *4A8AD46D0226_4C52BA5D01A8exec_var*
//#UC END# *4A8AD46D0226_4C52BA5D01A8exec_var*
begin
//#UC START# *4A8AD46D0226_4C52BA5D01A8exec_impl*
 ModalResult := mrCancel;
//#UC END# *4A8AD46D0226_4C52BA5D01A8exec_impl*
end;//TPrimPrintDialogOptionsForm.Result_Cancel_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPrintDialogOptionsForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
 {* OK }
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
 //nsDisableOperationInTrialMode(aParams);
 {$IfEnd} //not Admin AND not Monitorings
//#UC END# *4A97EBE702F8_4C52BA5D01A8test_impl*
end;//TPrimPrintDialogOptionsForm.Result_Ok_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPrintDialogOptionsForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPrintDialogOptionsForm.Result_Ok_GetState(var State: TvcmOperationStateIndex);
 {* OK }
//#UC START# *4A97EBE702F8_4C52BA5D01A8getstate_var*
//#UC END# *4A97EBE702F8_4C52BA5D01A8getstate_var*
begin
//#UC START# *4A97EBE702F8_4C52BA5D01A8getstate_impl*
 State := st_user_Result_Ok_Print;
//#UC END# *4A97EBE702F8_4C52BA5D01A8getstate_impl*
end;//TPrimPrintDialogOptionsForm.Result_Ok_GetState
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPrintDialogOptionsForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, nil, nil);
  ShowInContextMenu(en_Result, op_Cancel, False);
  ShowInToolbar(en_Result, op_Cancel, True);
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, Result_Ok_Test, Result_Ok_GetState);
  ShowInContextMenu(en_Result, op_Ok, False);
  ShowInToolbar(en_Result, op_Ok, True);
 end;//with Entities.Entities
end;//TPrimPrintDialogOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPrintDialogOptionsForm.MakeControls;
begin
 inherited;
end;//TPrimPrintDialogOptionsForm.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimPrintDialogOptionsForm);
 {* Регистрация PrimPrintDialogOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.

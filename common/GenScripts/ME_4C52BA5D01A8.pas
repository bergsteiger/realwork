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
;

type
 TPrimPrintDialogOptionsForm = class(TPrimPrintDialogForm)
  private
   f_poDocumentNames: TvtRadioButton;
    {* Поле для свойства poDocumentNames }
   f_rbPrintSelected: TvtRadioButton;
    {* Поле для свойства rbPrintSelected }
   f_rbPrintCurrent: TvtRadioButton;
    {* Поле для свойства rbPrintCurrent }
   f_edPrintInterval: TnscEditWithoutPlusMinusShortcut;
    {* Поле для свойства edPrintInterval }
   f_edCopyCount: TvtSpinEdit;
    {* Поле для свойства edCopyCount }
   f_CollateCheckBox: TvtCheckBox;
    {* Поле для свойства CollateCheckBox }
   f_cbOddEven: TvtComboBoxQS;
    {* Поле для свойства cbOddEven }
   f_poDocumentTexts: TvtRadioButton;
    {* Поле для свойства poDocumentTexts }
   f_rbPrintAll: TvtRadioButton;
    {* Поле для свойства rbPrintAll }
   f_rbPrintInterval: TvtRadioButton;
    {* Поле для свойства rbPrintInterval }
   f_cbPrinter: TvtComboBoxQS;
    {* Поле для свойства cbPrinter }
   f_cbPrintInfo: TvtCheckBox;
    {* Поле для свойства cbPrintInfo }
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
;

function TPrimPrintDialogOptionsForm.pm_GetpoDocumentNames: TvtRadioButton;
//#UC START# *4C52BEA0000B_4C52BA5D01A8get_var*
//#UC END# *4C52BEA0000B_4C52BA5D01A8get_var*
begin
//#UC START# *4C52BEA0000B_4C52BA5D01A8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52BEA0000B_4C52BA5D01A8get_impl*
end;//TPrimPrintDialogOptionsForm.pm_GetpoDocumentNames

function TPrimPrintDialogOptionsForm.pm_GetrbPrintSelected: TvtRadioButton;
//#UC START# *4C52BEBC03B4_4C52BA5D01A8get_var*
//#UC END# *4C52BEBC03B4_4C52BA5D01A8get_var*
begin
//#UC START# *4C52BEBC03B4_4C52BA5D01A8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52BEBC03B4_4C52BA5D01A8get_impl*
end;//TPrimPrintDialogOptionsForm.pm_GetrbPrintSelected

function TPrimPrintDialogOptionsForm.pm_GetrbPrintCurrent: TvtRadioButton;
//#UC START# *4C52BEE5007D_4C52BA5D01A8get_var*
//#UC END# *4C52BEE5007D_4C52BA5D01A8get_var*
begin
//#UC START# *4C52BEE5007D_4C52BA5D01A8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52BEE5007D_4C52BA5D01A8get_impl*
end;//TPrimPrintDialogOptionsForm.pm_GetrbPrintCurrent

function TPrimPrintDialogOptionsForm.pm_GetedPrintInterval: TnscEditWithoutPlusMinusShortcut;
//#UC START# *4C52BF3302F2_4C52BA5D01A8get_var*
//#UC END# *4C52BF3302F2_4C52BA5D01A8get_var*
begin
//#UC START# *4C52BF3302F2_4C52BA5D01A8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52BF3302F2_4C52BA5D01A8get_impl*
end;//TPrimPrintDialogOptionsForm.pm_GetedPrintInterval

function TPrimPrintDialogOptionsForm.pm_GetedCopyCount: TvtSpinEdit;
//#UC START# *4C52C07C0169_4C52BA5D01A8get_var*
//#UC END# *4C52C07C0169_4C52BA5D01A8get_var*
begin
//#UC START# *4C52C07C0169_4C52BA5D01A8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52C07C0169_4C52BA5D01A8get_impl*
end;//TPrimPrintDialogOptionsForm.pm_GetedCopyCount

function TPrimPrintDialogOptionsForm.pm_GetCollateCheckBox: TvtCheckBox;
//#UC START# *4C52C0A900DB_4C52BA5D01A8get_var*
//#UC END# *4C52C0A900DB_4C52BA5D01A8get_var*
begin
//#UC START# *4C52C0A900DB_4C52BA5D01A8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52C0A900DB_4C52BA5D01A8get_impl*
end;//TPrimPrintDialogOptionsForm.pm_GetCollateCheckBox

function TPrimPrintDialogOptionsForm.pm_GetcbOddEven: TvtComboBoxQS;
//#UC START# *4C52C0E1003A_4C52BA5D01A8get_var*
//#UC END# *4C52C0E1003A_4C52BA5D01A8get_var*
begin
//#UC START# *4C52C0E1003A_4C52BA5D01A8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52C0E1003A_4C52BA5D01A8get_impl*
end;//TPrimPrintDialogOptionsForm.pm_GetcbOddEven

function TPrimPrintDialogOptionsForm.pm_GetpoDocumentTexts: TvtRadioButton;
//#UC START# *4C52C8B30325_4C52BA5D01A8get_var*
//#UC END# *4C52C8B30325_4C52BA5D01A8get_var*
begin
//#UC START# *4C52C8B30325_4C52BA5D01A8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52C8B30325_4C52BA5D01A8get_impl*
end;//TPrimPrintDialogOptionsForm.pm_GetpoDocumentTexts

function TPrimPrintDialogOptionsForm.pm_GetrbPrintAll: TvtRadioButton;
//#UC START# *4C52C8ED034E_4C52BA5D01A8get_var*
//#UC END# *4C52C8ED034E_4C52BA5D01A8get_var*
begin
//#UC START# *4C52C8ED034E_4C52BA5D01A8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52C8ED034E_4C52BA5D01A8get_impl*
end;//TPrimPrintDialogOptionsForm.pm_GetrbPrintAll

function TPrimPrintDialogOptionsForm.pm_GetrbPrintInterval: TvtRadioButton;
//#UC START# *4C52C90A0262_4C52BA5D01A8get_var*
//#UC END# *4C52C90A0262_4C52BA5D01A8get_var*
begin
//#UC START# *4C52C90A0262_4C52BA5D01A8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52C90A0262_4C52BA5D01A8get_impl*
end;//TPrimPrintDialogOptionsForm.pm_GetrbPrintInterval

function TPrimPrintDialogOptionsForm.pm_GetcbPrinter: TvtComboBoxQS;
//#UC START# *4C52CC9300E7_4C52BA5D01A8get_var*
//#UC END# *4C52CC9300E7_4C52BA5D01A8get_var*
begin
//#UC START# *4C52CC9300E7_4C52BA5D01A8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52CC9300E7_4C52BA5D01A8get_impl*
end;//TPrimPrintDialogOptionsForm.pm_GetcbPrinter

function TPrimPrintDialogOptionsForm.pm_GetcbPrintInfo: TvtCheckBox;
//#UC START# *4C52CCC003AB_4C52BA5D01A8get_var*
//#UC END# *4C52CCC003AB_4C52BA5D01A8get_var*
begin
//#UC START# *4C52CCC003AB_4C52BA5D01A8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52CCC003AB_4C52BA5D01A8get_impl*
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
 nsDisableOperationInTrialMode(aParams);
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

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimPrintDialogOptionsForm);
 {* Регистрация PrimPrintDialogOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.

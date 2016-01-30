unit PrimPrintDialogOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimPrintDialogOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

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
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
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
procedure TPrimPrintDialogOptionsForm.Cancel;
 {* Отмена }
//#UC START# *4A8AD46D0226_4C52BA5D01A8_var*
//#UC END# *4A8AD46D0226_4C52BA5D01A8_var*
begin
//#UC START# *4A8AD46D0226_4C52BA5D01A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8AD46D0226_4C52BA5D01A8_impl*
end;//TPrimPrintDialogOptionsForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPrintDialogOptionsForm.Ok;
 {* OK }
//#UC START# *4A97EBE702F8_4C52BA5D01A8_var*
//#UC END# *4A97EBE702F8_4C52BA5D01A8_var*
begin
//#UC START# *4A97EBE702F8_4C52BA5D01A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A97EBE702F8_4C52BA5D01A8_impl*
end;//TPrimPrintDialogOptionsForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPrintDialogOptionsForm.Ok;
 {* OK }
//#UC START# *4C762A1501FC_4C52BA5D01A8_var*
//#UC END# *4C762A1501FC_4C52BA5D01A8_var*
begin
//#UC START# *4C762A1501FC_4C52BA5D01A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762A1501FC_4C52BA5D01A8_impl*
end;//TPrimPrintDialogOptionsForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPrintDialogOptionsForm.Cancel;
 {* Отмена }
//#UC START# *4C762AB601E1_4C52BA5D01A8_var*
//#UC END# *4C762AB601E1_4C52BA5D01A8_var*
begin
//#UC START# *4C762AB601E1_4C52BA5D01A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762AB601E1_4C52BA5D01A8_impl*
end;//TPrimPrintDialogOptionsForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimPrintDialogOptionsForm);
 {* Регистрация PrimPrintDialogOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.

unit NOT_FINISHED_PrintDialog_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\NOT_FINISHED_PrintDialog_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "PrintDialog" MUID: (4AAF8EAC01FC)
// Имя типа: "Ten_PrintDialog"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimPrintDialogOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmEntities
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
 Ten_PrintDialog = {final} class(TPrimPrintDialogOptionsForm)
   Entities : TvcmEntities;
   poDocumentNames : TvtRadioButton;
   rbPrintSelected : TvtRadioButton;
   rbPrintCurrent : TvtRadioButton;
   edPrintInterval : TnscEditWithoutPlusMinusShortcut;
   edCopyCount : TvtSpinEdit;
   CollateCheckBox : TvtCheckBox;
   cbOddEven : TvtComboBoxQS;
   poDocumentTexts : TvtRadioButton;
   rbPrintAll : TvtRadioButton;
   rbPrintInterval : TvtRadioButton;
   cbPrinter : TvtComboBoxQS;
   cbPrintInfo : TvtCheckBox;
  protected
   procedure UpdateState; override;
   function UpdatePrintersList: Boolean; override;
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//Ten_PrintDialog
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3RangeManager
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , PrintDialog_ut_PrintDialog_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , PrintDialogKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

const
 {* Локализуемые строки ut_PrintDialogLocalConstants }
 str_ut_PrintDialogCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_PrintDialogCaption'; rValue : 'PrintDialog');
  {* Заголовок пользовательского типа "PrintDialog" }

{$R *.DFM}

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

{$If NOT Defined(NoVCM)}
procedure Ten_PrintDialog.MakeControls;
begin
 inherited;
 with AddUsertype(ut_PrintDialogName,
  str_ut_PrintDialogCaption,
  str_ut_PrintDialogCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_PrintDialogName
end;//Ten_PrintDialog.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_ut_PrintDialogCaption.Init;
 {* Инициализация str_ut_PrintDialogCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_PrintDialog);
 {* Регистрация PrintDialog }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.

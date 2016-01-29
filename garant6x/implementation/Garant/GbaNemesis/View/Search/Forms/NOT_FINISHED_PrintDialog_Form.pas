unit NOT_FINISHED_PrintDialog_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/NOT_FINISHED_PrintDialog_Form.pas"
// Начат: 15.09.2009 16:55
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::CommonSearch::PrintDialog
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx,
  PrimPrintDialogOptions_Form
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  PrintDialog_ut_PrintDialog_UserType,
  vtRadioButton
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtSpinEdit,
  vtCheckBox,
  vtComboBoxQS,
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
  Ten_PrintDialog = {final form} class(TPrimPrintDialogOptionsForm)
  Entities : TvcmEntities;
  poDocumentNames: TvtRadioButton;
  rbPrintSelected: TvtRadioButton;
  rbPrintCurrent: TvtRadioButton;
  edPrintInterval: TnscEditWithoutPlusMinusShortcut;
  edCopyCount: TvtSpinEdit;
  CollateCheckBox: TvtCheckBox;
  cbOddEven: TvtComboBoxQS;
  poDocumentTexts: TvtRadioButton;
  rbPrintAll: TvtRadioButton;
  rbPrintInterval: TvtRadioButton;
  cbPrinter: TvtComboBoxQS;
  cbPrintInfo: TvtCheckBox;
  protected
   procedure MakeControls; override;
  protected
  // realized methods
   procedure UpdateState; override;
   function UpdatePrintersList: Boolean; override;
  end;//Ten_PrintDialog

  TPrintDialogForm = Ten_PrintDialog;
{$IfEnd} //not Admin

implementation

{$R *.DFM}

{$If not defined(Admin)}
uses
  l3RangeManager
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID
  {$If not defined(Admin) AND not defined(NoScripts)}
  ,
  PrintDialogKeywordsPack
  {$IfEnd} //not Admin AND not NoScripts
  
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

var
    { Локализуемые строки ut_PrintDialogLocalConstants }
   str_ut_PrintDialogCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_PrintDialogCaption'; rValue : 'PrintDialog');
    { Заголовок пользовательского типа "PrintDialog" }

// start class Ten_PrintDialog

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

procedure Ten_PrintDialog.MakeControls;
begin
 inherited;
 with AddUsertype(ut_PrintDialogName,
  str_ut_PrintDialogCaption,
  str_ut_PrintDialogCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_PrintDialogName
end;

{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация PrintDialog
 TtfwClassRef.Register(Ten_PrintDialog);
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin)}
// Инициализация str_ut_PrintDialogCaption
 str_ut_PrintDialogCaption.Init;
{$IfEnd} //not Admin

end.
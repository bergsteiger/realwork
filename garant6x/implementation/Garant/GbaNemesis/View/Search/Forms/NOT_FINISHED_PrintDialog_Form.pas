unit NOT_FINISHED_PrintDialog_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\NOT_FINISHED_PrintDialog_Form.pas"
// Стереотип: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimPrintDialogOptions_Form
;

type
 Ten_PrintDialog = {final} class(TPrimPrintDialogOptionsForm)
  protected
   procedure UpdateState; override;
   function UpdatePrintersList: Boolean; override;
 end;//Ten_PrintDialog
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3RangeManager
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , PrintDialogKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки ut_PrintDialogLocalConstants }
 str_ut_PrintDialogCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_PrintDialogCaption'; rValue : 'PrintDialog');
  {* Заголовок пользовательского типа "PrintDialog" }

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

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_PrintDialog);
 {* Регистрация PrintDialog }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_PrintDialogCaption.Init;
 {* Инициализация str_ut_PrintDialogCaption }
{$IfEnd} // NOT Defined(Admin)

end.

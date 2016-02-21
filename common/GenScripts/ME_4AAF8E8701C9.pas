unit PrimPrintDialog_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimPrintDialog_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , Search_Strange_Controls
 , afwInterfaces
;

type
 TPrimPrintDialogForm = class(TvcmEntityForm)
  protected
   f_Preview: IafwDocumentPreview;
  protected
   procedure UpdateState; virtual; abstract;
   function UpdatePrintersList: Boolean; virtual; abstract;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   class function Make(const aData: IafwDocumentPreview): PrintParams; reintroduce;
   procedure UpdatePrinter; override;
 end;//TPrimPrintDialogForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

class function TPrimPrintDialogForm.Make(const aData: IafwDocumentPreview): PrintParams;
var
 l_Inst : TPrimPrintDialogForm;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrimPrintDialogForm.Make

procedure TPrimPrintDialogForm.UpdatePrinter;
//#UC START# *4AF82660008B_4AAF8E8701C9_var*
//#UC END# *4AF82660008B_4AAF8E8701C9_var*
begin
//#UC START# *4AF82660008B_4AAF8E8701C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF82660008B_4AAF8E8701C9_impl*
end;//TPrimPrintDialogForm.UpdatePrinter

procedure TPrimPrintDialogForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4AAF8E8701C9_var*
//#UC END# *479731C50290_4AAF8E8701C9_var*
begin
//#UC START# *479731C50290_4AAF8E8701C9_impl*
 f_Preview := nil;
 inherited;
//#UC END# *479731C50290_4AAF8E8701C9_impl*
end;//TPrimPrintDialogForm.Cleanup

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimPrintDialogForm);
 {* Регистрация PrimPrintDialog }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.

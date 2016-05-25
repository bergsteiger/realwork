unit PrimPrintDialog_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimPrintDialog_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimPrintDialog" MUID: (4AAF8E8701C9)
// Имя типа: "TPrimPrintDialogForm"

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
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimPrintDialogForm = class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   f_Preview: IafwDocumentPreview;
  protected
   procedure UpdateState; virtual; abstract;
   function UpdatePrintersList: Boolean; virtual; abstract;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function Make(const aData: IafwDocumentPreview): BadFactoryType; reintroduce;
   procedure PrintParams_UpdatePrinter_Execute;
   procedure PrintParams_UpdatePrinter(const aParams: IvcmExecuteParams);
 end;//TPrimPrintDialogForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

{$If NOT Defined(NoVCM)}
class function TPrimPrintDialogForm.Make(const aData: IafwDocumentPreview): BadFactoryType;
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

procedure TPrimPrintDialogForm.PrintParams_UpdatePrinter_Execute;
//#UC START# *4AF82660008B_4AAF8E8701C9exec_var*
//#UC END# *4AF82660008B_4AAF8E8701C9exec_var*
begin
//#UC START# *4AF82660008B_4AAF8E8701C9exec_impl*
 UpdatePrintersList;
//#UC END# *4AF82660008B_4AAF8E8701C9exec_impl*
end;//TPrimPrintDialogForm.PrintParams_UpdatePrinter_Execute

procedure TPrimPrintDialogForm.PrintParams_UpdatePrinter(const aParams: IvcmExecuteParams);
begin
 Self.PrintParams_UpdatePrinter_Execute;
end;//TPrimPrintDialogForm.PrintParams_UpdatePrinter

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

procedure TPrimPrintDialogForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_PrintParams, nil);
  PublishOpWithResult(en_PrintParams, op_UpdatePrinter, PrintParams_UpdatePrinter, nil, nil);
 end;//with Entities.Entities
end;//TPrimPrintDialogForm.InitEntities

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimPrintDialogForm);
 {* Регистрация PrimPrintDialog }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin)
end.

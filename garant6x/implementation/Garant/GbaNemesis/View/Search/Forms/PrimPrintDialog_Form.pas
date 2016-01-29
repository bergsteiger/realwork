unit PrimPrintDialog_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimPrintDialog_Form.pas"
// Начат: 15.09.2009 16:54
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimPrintDialog
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
  vcmEntityForm
  {$IfEnd} //not NoVCM
  ,
  Search_Strange_Controls,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TPrimPrintDialogForm = {form} class(TvcmEntityForm)
 protected
  procedure InitEntities; override;
 protected
 // realized methods
   procedure PrintParams_UpdatePrinter_Execute;
   procedure PrintParams_UpdatePrinter(const aParams: IvcmExecuteParams);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 protected
 // protected fields
   f_Preview : IafwDocumentPreview;
 protected
 // protected methods
   procedure UpdateState; virtual; abstract;
   function UpdatePrintersList: Boolean; virtual; abstract;
 public
 // public methods
   class function Make(const aData: IafwDocumentPreview;
    const aParams : IvcmMakeParams = nil;
    aZoneType     : TvcmZoneType = vcm_ztAny;
    aUserType     : TvcmEffectiveUserType = 0;
    aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm; reintroduce;
 end;//TPrimPrintDialogForm
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3Base {a},
  StdRes {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

// start class TPrimPrintDialogForm

class function TPrimPrintDialogForm.Make(const aData: IafwDocumentPreview;
  const aParams : IvcmMakeParams = nil;
  aZoneType     : TvcmZoneType = vcm_ztAny;
  aUserType     : TvcmEffectiveUserType = 0;
  aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm;

 procedure AfterCreate(aForm : TPrimPrintDialogForm);
 begin
  with aForm do
  begin
//#UC START# *4AC6228E018B_4AAF8E8701C9_impl*
   f_Preview := aData;
   UpdateState;
//#UC END# *4AC6228E018B_4AAF8E8701C9_impl*
  end;//with aForm
 end;

var
 l_AC : TvcmInitProc;
 l_ACHack : Pointer absolute l_AC;
begin
 l_AC := l3LocalStub(@AfterCreate);
 try
  Result := inherited Make(aParams, aZoneType, aUserType, nil, aDataSource, vcm_utAny, l_AC);
 finally
  l3FreeLocalStub(l_ACHack);
 end;//try..finally
end;

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
 PrintParams_UpdatePrinter_Execute;
end;

procedure TPrimPrintDialogForm.Cleanup;
//#UC START# *479731C50290_4AAF8E8701C9_var*
//#UC END# *479731C50290_4AAF8E8701C9_var*
begin
//#UC START# *479731C50290_4AAF8E8701C9_impl*
 f_Preview := nil;
 inherited;
//#UC END# *479731C50290_4AAF8E8701C9_impl*
end;//TPrimPrintDialogForm.Cleanup

procedure TPrimPrintDialogForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_PrintParams, nil);
  PublishOpWithResult(en_PrintParams, op_UpdatePrinter, PrintParams_UpdatePrinter, nil, nil);
 end;//with Entities.Entities
end;

{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация PrimPrintDialog
 TtfwClassRef.Register(TPrimPrintDialogForm);
{$IfEnd} //not Admin AND not NoScripts

end.
unit PrimWarningOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimWarningOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimWarning_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Document_Strange_Controls
 , afwInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimWarningOptionsForm = class(TPrimWarningForm)
  protected
   function MakePreview: IafwComplexDocumentPreview;
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure Print; override;
    {* Печать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PrintDialog; override;
    {* Печать... }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PrintPreview; override;
    {* Предварительный просмотр }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure TimeMachineOffAndReset; override;
   procedure ActualRedaction; override;
   procedure TimeMachineOff; override;
 end;//TPrimWarningOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , afwFacade
 , nsTypes
 , Base_Operations_Strange_Controls
 , nsDocInfoHAFMacroReplacer
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , evFormatHAFMacroReplacer
 , Common_Strange_Controls
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TPrimWarningOptionsForm.MakePreview: IafwComplexDocumentPreview;
//#UC START# *4C7F77A50276_4C7F738D033E_var*
var
 l_HAF: IafwHAFMacroReplacer;
//#UC END# *4C7F77A50276_4C7F738D033E_var*
begin
//#UC START# *4C7F77A50276_4C7F738D033E_impl*
 if (ViewArea <> nil) then
  l_HAF := TnsDocInfoHAFMacroReplacer.Make(nil, ViewArea.DocInfo)
 else
  l_HAF := nil;
 Result := Viewer.Preview(TevFormatHAFMacroReplacer.Make(l_HAF, vcmCStr(str_WarningTitle)));
//#UC END# *4C7F77A50276_4C7F738D033E_impl*
end;//TPrimWarningOptionsForm.MakePreview

{$If NOT Defined(NoVCM)}
procedure TPrimWarningOptionsForm.Print;
 {* Печать }
//#UC START# *49521D8E0295_4C7F738D033E_var*
//#UC END# *49521D8E0295_4C7F738D033E_var*
begin
//#UC START# *49521D8E0295_4C7F738D033E_impl*
 !!! Needs to be implemented !!!
//#UC END# *49521D8E0295_4C7F738D033E_impl*
end;//TPrimWarningOptionsForm.Print
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimWarningOptionsForm.PrintDialog;
 {* Печать... }
//#UC START# *495220DE0298_4C7F738D033E_var*
//#UC END# *495220DE0298_4C7F738D033E_var*
begin
//#UC START# *495220DE0298_4C7F738D033E_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220DE0298_4C7F738D033E_impl*
end;//TPrimWarningOptionsForm.PrintDialog
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimWarningOptionsForm.PrintPreview;
 {* Предварительный просмотр }
//#UC START# *495220F2033A_4C7F738D033E_var*
//#UC END# *495220F2033A_4C7F738D033E_var*
begin
//#UC START# *495220F2033A_4C7F738D033E_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220F2033A_4C7F738D033E_impl*
end;//TPrimWarningOptionsForm.PrintPreview
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimWarningOptionsForm.TimeMachineOffAndReset;
//#UC START# *4C7F753E02BC_4C7F738D033E_var*
//#UC END# *4C7F753E02BC_4C7F738D033E_var*
begin
//#UC START# *4C7F753E02BC_4C7F738D033E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7F753E02BC_4C7F738D033E_impl*
end;//TPrimWarningOptionsForm.TimeMachineOffAndReset

procedure TPrimWarningOptionsForm.ActualRedaction;
//#UC START# *4C7F7552010A_4C7F738D033E_var*
//#UC END# *4C7F7552010A_4C7F738D033E_var*
begin
//#UC START# *4C7F7552010A_4C7F738D033E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7F7552010A_4C7F738D033E_impl*
end;//TPrimWarningOptionsForm.ActualRedaction

procedure TPrimWarningOptionsForm.TimeMachineOff;
//#UC START# *4C7F75660342_4C7F738D033E_var*
//#UC END# *4C7F75660342_4C7F738D033E_var*
begin
//#UC START# *4C7F75660342_4C7F738D033E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7F75660342_4C7F738D033E_impl*
end;//TPrimWarningOptionsForm.TimeMachineOff

{$If NOT Defined(NoVCM)}
procedure TPrimWarningOptionsForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
//#UC START# *497469C90140_4C7F738D033E_var*
//#UC END# *497469C90140_4C7F738D033E_var*
begin
//#UC START# *497469C90140_4C7F738D033E_impl*
 inherited;
//#UC END# *497469C90140_4C7F738D033E_impl*
end;//TPrimWarningOptionsForm.NotifyDataSourceChanged
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimWarningOptionsForm);
 {* Регистрация PrimWarningOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

unit PrimPageSetupOptions_Form;
 {* Настройка страницы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimPageSetupOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimPageSetup_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Search_Strange_Controls
;

type
 TPrimPageSetupOptionsForm = class(TPrimPageSetupForm)
  {* Настройка страницы }
  protected
   procedure Save(SaveAsDefault: Boolean = False); virtual; abstract;
   procedure SetPageFormat(aOrientation: Integer); virtual; abstract;
   procedure MacroAdd(const aString: AnsiString); virtual; abstract;
   procedure ToGUIColontituls; virtual; abstract;
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
   procedure Restore; override;
   procedure SaveAsDefault; override;
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure AppTitle; override;
   procedure DocName; override;
   procedure DocFullName; override;
   procedure DocRedactionDate; override;
   procedure DocCurrentPage; override;
   procedure DocPagesCount; override;
   procedure CurrentDate; override;
   procedure CurrentTime; override;
   procedure InternalDocNumber; override;
   procedure DocumentSIze; override;
   procedure FilePosition; override;
 end;//TPrimPageSetupOptionsForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , afwFacade
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , evHAFPainterMacros
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimPageSetupOptionsForm.Print;
 {* Печать }
//#UC START# *49521D8E0295_4C88D233003E_var*
//#UC END# *49521D8E0295_4C88D233003E_var*
begin
//#UC START# *49521D8E0295_4C88D233003E_impl*
 !!! Needs to be implemented !!!
//#UC END# *49521D8E0295_4C88D233003E_impl*
end;//TPrimPageSetupOptionsForm.Print
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPageSetupOptionsForm.PrintDialog;
 {* Печать... }
//#UC START# *495220DE0298_4C88D233003E_var*
//#UC END# *495220DE0298_4C88D233003E_var*
begin
//#UC START# *495220DE0298_4C88D233003E_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220DE0298_4C88D233003E_impl*
end;//TPrimPageSetupOptionsForm.PrintDialog
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPageSetupOptionsForm.PrintPreview;
 {* Предварительный просмотр }
//#UC START# *495220F2033A_4C88D233003E_var*
//#UC END# *495220F2033A_4C88D233003E_var*
begin
//#UC START# *495220F2033A_4C88D233003E_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220F2033A_4C88D233003E_impl*
end;//TPrimPageSetupOptionsForm.PrintPreview
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimPageSetupOptionsForm.Restore;
//#UC START# *4C52B34E0125_4C88D233003E_var*
//#UC END# *4C52B34E0125_4C88D233003E_var*
begin
//#UC START# *4C52B34E0125_4C88D233003E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52B34E0125_4C88D233003E_impl*
end;//TPrimPageSetupOptionsForm.Restore

procedure TPrimPageSetupOptionsForm.SaveAsDefault;
//#UC START# *4C52B36B01B3_4C88D233003E_var*
//#UC END# *4C52B36B01B3_4C88D233003E_var*
begin
//#UC START# *4C52B36B01B3_4C88D233003E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52B36B01B3_4C88D233003E_impl*
end;//TPrimPageSetupOptionsForm.SaveAsDefault

{$If NOT Defined(NoVCM)}
procedure TPrimPageSetupOptionsForm.Ok;
 {* OK }
//#UC START# *4C762A1501FC_4C88D233003E_var*
//#UC END# *4C762A1501FC_4C88D233003E_var*
begin
//#UC START# *4C762A1501FC_4C88D233003E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762A1501FC_4C88D233003E_impl*
end;//TPrimPageSetupOptionsForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPageSetupOptionsForm.Cancel;
 {* Отмена }
//#UC START# *4C762C910358_4C88D233003E_var*
//#UC END# *4C762C910358_4C88D233003E_var*
begin
//#UC START# *4C762C910358_4C88D233003E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762C910358_4C88D233003E_impl*
end;//TPrimPageSetupOptionsForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimPageSetupOptionsForm.AppTitle;
//#UC START# *4C88D40C0029_4C88D233003E_var*
//#UC END# *4C88D40C0029_4C88D233003E_var*
begin
//#UC START# *4C88D40C0029_4C88D233003E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C88D40C0029_4C88D233003E_impl*
end;//TPrimPageSetupOptionsForm.AppTitle

procedure TPrimPageSetupOptionsForm.DocName;
//#UC START# *4C88D42001C2_4C88D233003E_var*
//#UC END# *4C88D42001C2_4C88D233003E_var*
begin
//#UC START# *4C88D42001C2_4C88D233003E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C88D42001C2_4C88D233003E_impl*
end;//TPrimPageSetupOptionsForm.DocName

procedure TPrimPageSetupOptionsForm.DocFullName;
//#UC START# *4C88D43300C7_4C88D233003E_var*
//#UC END# *4C88D43300C7_4C88D233003E_var*
begin
//#UC START# *4C88D43300C7_4C88D233003E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C88D43300C7_4C88D233003E_impl*
end;//TPrimPageSetupOptionsForm.DocFullName

procedure TPrimPageSetupOptionsForm.DocRedactionDate;
//#UC START# *4C88D44401B5_4C88D233003E_var*
//#UC END# *4C88D44401B5_4C88D233003E_var*
begin
//#UC START# *4C88D44401B5_4C88D233003E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C88D44401B5_4C88D233003E_impl*
end;//TPrimPageSetupOptionsForm.DocRedactionDate

procedure TPrimPageSetupOptionsForm.DocCurrentPage;
//#UC START# *4C88D46203BD_4C88D233003E_var*
//#UC END# *4C88D46203BD_4C88D233003E_var*
begin
//#UC START# *4C88D46203BD_4C88D233003E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C88D46203BD_4C88D233003E_impl*
end;//TPrimPageSetupOptionsForm.DocCurrentPage

procedure TPrimPageSetupOptionsForm.DocPagesCount;
//#UC START# *4C88D4770266_4C88D233003E_var*
//#UC END# *4C88D4770266_4C88D233003E_var*
begin
//#UC START# *4C88D4770266_4C88D233003E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C88D4770266_4C88D233003E_impl*
end;//TPrimPageSetupOptionsForm.DocPagesCount

procedure TPrimPageSetupOptionsForm.CurrentDate;
//#UC START# *4C88D48B0325_4C88D233003E_var*
//#UC END# *4C88D48B0325_4C88D233003E_var*
begin
//#UC START# *4C88D48B0325_4C88D233003E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C88D48B0325_4C88D233003E_impl*
end;//TPrimPageSetupOptionsForm.CurrentDate

procedure TPrimPageSetupOptionsForm.CurrentTime;
//#UC START# *4C88D4A6032C_4C88D233003E_var*
//#UC END# *4C88D4A6032C_4C88D233003E_var*
begin
//#UC START# *4C88D4A6032C_4C88D233003E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C88D4A6032C_4C88D233003E_impl*
end;//TPrimPageSetupOptionsForm.CurrentTime

procedure TPrimPageSetupOptionsForm.InternalDocNumber;
//#UC START# *4C88D4BF0213_4C88D233003E_var*
//#UC END# *4C88D4BF0213_4C88D233003E_var*
begin
//#UC START# *4C88D4BF0213_4C88D233003E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C88D4BF0213_4C88D233003E_impl*
end;//TPrimPageSetupOptionsForm.InternalDocNumber

procedure TPrimPageSetupOptionsForm.DocumentSIze;
//#UC START# *4C88D4D202BA_4C88D233003E_var*
//#UC END# *4C88D4D202BA_4C88D233003E_var*
begin
//#UC START# *4C88D4D202BA_4C88D233003E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C88D4D202BA_4C88D233003E_impl*
end;//TPrimPageSetupOptionsForm.DocumentSIze

procedure TPrimPageSetupOptionsForm.FilePosition;
//#UC START# *4C88D4E8007C_4C88D233003E_var*
//#UC END# *4C88D4E8007C_4C88D233003E_var*
begin
//#UC START# *4C88D4E8007C_4C88D233003E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C88D4E8007C_4C88D233003E_impl*
end;//TPrimPageSetupOptionsForm.FilePosition

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimPageSetupOptionsForm);
 {* Регистрация PrimPageSetupOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.

unit PrimNewsLineOptions_Form;
 {* ПРАЙМ. Моя новостная лента }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimNewsLineOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimNewsLine_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Autoreferat_InternalOperations_Controls
 , PrimNewsLine_nltMain_UserType
;

type
 TPrimNewsLineOptionsForm = class(TPrimNewsLineForm)
  {* ПРАЙМ. Моя новостная лента }
  public
   {$If NOT Defined(NoVCM)}
   procedure ExpandAll; override;
    {* Развернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure CollapseAll; override;
    {* Свернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure SelectCurrent; override;
   procedure Open; override;
 end;//TPrimNewsLineOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3String
 , nsNewsLine
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 // ExcludeTree

{$If NOT Defined(NoVCM)}
procedure TPrimNewsLineOptionsForm.ExpandAll;
 {* Развернуть все }
//#UC START# *4BDAF7880236_4C87BB9C0143_var*
//#UC END# *4BDAF7880236_4C87BB9C0143_var*
begin
//#UC START# *4BDAF7880236_4C87BB9C0143_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7880236_4C87BB9C0143_impl*
end;//TPrimNewsLineOptionsForm.ExpandAll
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimNewsLineOptionsForm.CollapseAll;
 {* Свернуть все }
//#UC START# *4BDAF7A2005C_4C87BB9C0143_var*
//#UC END# *4BDAF7A2005C_4C87BB9C0143_var*
begin
//#UC START# *4BDAF7A2005C_4C87BB9C0143_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BDAF7A2005C_4C87BB9C0143_impl*
end;//TPrimNewsLineOptionsForm.CollapseAll
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimNewsLineOptionsForm.SelectCurrent;
//#UC START# *4C87BBFF0313_4C87BB9C0143_var*
//#UC END# *4C87BBFF0313_4C87BB9C0143_var*
begin
//#UC START# *4C87BBFF0313_4C87BB9C0143_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C87BBFF0313_4C87BB9C0143_impl*
end;//TPrimNewsLineOptionsForm.SelectCurrent

procedure TPrimNewsLineOptionsForm.Open;
//#UC START# *4C87BC6502B9_4C87BB9C0143_var*
//#UC END# *4C87BC6502B9_4C87BB9C0143_var*
begin
//#UC START# *4C87BC6502B9_4C87BB9C0143_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C87BC6502B9_4C87BB9C0143_impl*
end;//TPrimNewsLineOptionsForm.Open

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimNewsLineOptionsForm);
 {* Регистрация PrimNewsLineOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

unit PrimWarningBaloonOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimWarningBaloonOptions_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimWarningOptions_Form
 , BaloonWarningUserTypes_Fake_UserType
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _BaloonWarningUserTypes_Parent_ = TPrimWarningOptionsForm;
 {$Include BaloonWarningUserTypes.imp.pas}
 TPrimWarningBaloonOptionsForm = class(_BaloonWarningUserTypes_)
  public
   procedure TimeMachineOffAndReset; override;
   {$If NOT Defined(NoVCM)}
   function IsBaloon: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimWarningBaloonOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3StringIDEx
 , l3MessageID
;

type
 // IncludePrint

{$Include BaloonWarningUserTypes.imp.pas}

procedure TPrimWarningBaloonOptionsForm.TimeMachineOffAndReset;
//#UC START# *4C7F753E02BC_4EA599F501CF_var*
//#UC END# *4C7F753E02BC_4EA599F501CF_var*
begin
//#UC START# *4C7F753E02BC_4EA599F501CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7F753E02BC_4EA599F501CF_impl*
end;//TPrimWarningBaloonOptionsForm.TimeMachineOffAndReset

{$If NOT Defined(NoVCM)}
function TPrimWarningBaloonOptionsForm.IsBaloon: Boolean;
//#UC START# *4F748C5A00CB_4EA599F501CF_var*
//#UC END# *4F748C5A00CB_4EA599F501CF_var*
begin
//#UC START# *4F748C5A00CB_4EA599F501CF_impl*
 Result := true;
//#UC END# *4F748C5A00CB_4EA599F501CF_impl*
end;//TPrimWarningBaloonOptionsForm.IsBaloon
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimWarningBaloonOptionsForm);
 {* Регистрация PrimWarningBaloonOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

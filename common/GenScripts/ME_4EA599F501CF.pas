unit PrimWarningBaloonOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimWarningBaloonOptions_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimWarningBaloonOptions" MUID: (4EA599F501CF)
// Имя типа: "TPrimWarningBaloonOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimWarningOptions_Form
;

type
 _BaloonWarningUserTypes_Parent_ = TPrimWarningOptionsForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes.imp.pas}
 TPrimWarningBaloonOptionsForm = class(_BaloonWarningUserTypes_)
  public
   {$If NOT Defined(NoVCM)}
   function IsBaloon: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimWarningBaloonOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , BaloonWarningUserTypes_Fake_UserType
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3StringIDEx
 , l3MessageID
;

type
 // IncludePrint

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes.imp.pas}

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

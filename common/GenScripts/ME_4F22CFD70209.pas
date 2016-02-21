unit vcmEntityFormImplementationModelPart;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmEntityFormImplementationModelPart.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmForm
 , vcmInterfaces
;

type
 TvcmEntityFormImplementationModelPart = class(TvcmFormImplementation)
  protected
   function Get_VCMClosing: Boolean;
  public
   function IsBaloon: Boolean;
 end;//TvcmEntityFormImplementationModelPart
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmEntityFormModelPart
;

function TvcmEntityFormImplementationModelPart.Get_VCMClosing: Boolean;
//#UC START# *4F22CB9701DC_4F22CFD70209get_var*
//#UC END# *4F22CB9701DC_4F22CFD70209get_var*
begin
//#UC START# *4F22CB9701DC_4F22CFD70209get_impl*
 Result := TvcmForm(Self.Control).VCMClosing;
//#UC END# *4F22CB9701DC_4F22CFD70209get_impl*
end;//TvcmEntityFormImplementationModelPart.Get_VCMClosing

function TvcmEntityFormImplementationModelPart.IsBaloon: Boolean;
//#UC START# *4F748C140133_4F22CFD70209_var*
//#UC END# *4F748C140133_4F22CFD70209_var*
begin
//#UC START# *4F748C140133_4F22CFD70209_impl*
 Result := TvcmEntityFormModelPart(Self.Control).IsBaloon;
//#UC END# *4F748C140133_4F22CFD70209_impl*
end;//TvcmEntityFormImplementationModelPart.IsBaloon
{$IfEnd} // NOT Defined(NoVCM)

end.

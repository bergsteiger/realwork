unit vcmEntityFormImplementationModelPart;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmEntityFormImplementationModelPart.pas"
// Начат: 27.01.2012 20:37
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::Visual::TvcmEntityFormImplementationModelPart
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmInterfaces,
  vcmForm
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmEntityFormImplementationModelPart = class(TvcmFormImplementation)
 protected
 // realized methods
   function Get_VCMClosing: Boolean;
 public
 // realized methods
   function IsBaloon: Boolean;
 end;//TvcmEntityFormImplementationModelPart
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  vcmEntityFormModelPart
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

// start class TvcmEntityFormImplementationModelPart

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

{$IfEnd} //not NoVCM

end.
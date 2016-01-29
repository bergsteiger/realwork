unit nevFormulaPara;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevFormulaPara.pas"
// Начат: 15.02.2011 18:33
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParagraphsImplementation::TnevFormulaPara
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If defined(k2ForEditor)}
uses
  nevTextPara
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 TnevFormulaPara = class(TnevTextPara)
 protected
 // overridden protected methods
   function TreatCollapsedAsHidden: Boolean; override;
 end;//TnevFormulaPara
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}

// start class TnevFormulaPara

function TnevFormulaPara.TreatCollapsedAsHidden: Boolean;
//#UC START# *4D596369028C_4D5A9CA80141_var*
//#UC END# *4D596369028C_4D5A9CA80141_var*
begin
//#UC START# *4D596369028C_4D5A9CA80141_impl*
 Result := false;
//#UC END# *4D596369028C_4D5A9CA80141_impl*
end;//TnevFormulaPara.TreatCollapsedAsHidden

{$IfEnd} //k2ForEditor

end.
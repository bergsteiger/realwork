unit nevFormulaPara;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevFormulaPara.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevFormulaPara" MUID: (4D5A9CA80141)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevTextPara
;

type
 TnevFormulaPara = class(TnevTextPara)
  protected
   function TreatCollapsedAsHidden: Boolean; override;
 end;//TnevFormulaPara
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
;

function TnevFormulaPara.TreatCollapsedAsHidden: Boolean;
//#UC START# *4D596369028C_4D5A9CA80141_var*
//#UC END# *4D596369028C_4D5A9CA80141_var*
begin
//#UC START# *4D596369028C_4D5A9CA80141_impl*
 Result := false;
//#UC END# *4D596369028C_4D5A9CA80141_impl*
end;//TnevFormulaPara.TreatCollapsedAsHidden
{$IfEnd} // Defined(k2ForEditor)

end.

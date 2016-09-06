unit msmShowInNavigator;

// Модуль: "w:\common\components\gui\Garant\msm\msmShowInNavigator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmShowInNavigator" MUID: (57CEBC210073)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmListToTreeOperation
;

type
 TmsmShowInNavigator = class(TmsmListToTreeOperation)
  protected
   procedure DoDoIt; override;
 end;//TmsmShowInNavigator

implementation

uses
 l3ImplUses
 //#UC START# *57CEBC210073impl_uses*
 //#UC END# *57CEBC210073impl_uses*
;

procedure TmsmShowInNavigator.DoDoIt;
//#UC START# *57CEB1F602D1_57CEBC210073_var*
//#UC END# *57CEB1F602D1_57CEBC210073_var*
begin
//#UC START# *57CEB1F602D1_57CEBC210073_impl*
 ModelToFire.CurrentElement := ModelToListen.CurrentElement;
//#UC END# *57CEB1F602D1_57CEBC210073_impl*
end;//TmsmShowInNavigator.DoDoIt

end.

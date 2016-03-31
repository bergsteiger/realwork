unit NOT_COMPLETED_nevControlsBlock;

// Модуль: "w:\common\components\gui\Garant\Everest\new\NOT_COMPLETED_nevControlsBlock.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevControlsBlock" MUID: (4D5963D4032D)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevParaList
;

type
 TnevControlsBlock = class(TnevParaList)
  protected
   function TreatCollapsedAsHidden: Boolean; override;
 end;//TnevControlsBlock
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
;

function TnevControlsBlock.TreatCollapsedAsHidden: Boolean;
//#UC START# *4D596369028C_4D5963D4032D_var*
//#UC END# *4D596369028C_4D5963D4032D_var*
begin
//#UC START# *4D596369028C_4D5963D4032D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D596369028C_4D5963D4032D_impl*
end;//TnevControlsBlock.TreatCollapsedAsHidden
{$IfEnd} // Defined(k2ForEditor)

end.

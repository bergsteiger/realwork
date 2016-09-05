unit evFormula_Wrap;

// Модуль: "w:\common\components\gui\Garant\Everest\evFormula_Wrap.pas"
// Стереотип: "Wrapper"
// Элемент модели: "WevFormula" MUID: (485792EE01CB)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evPara_Wrap
;

type
 WevFormula = class(WevPara)
 end;//WevFormula

implementation

uses
 l3ImplUses
 , ExprDraw
 , ExprMake
 , k2Tags
 , l3GraphicContainer
 , l3Base
 , l3InternalInterfaces
 , SysUtils
 , Formula_Const
 //#UC START# *485792EE01CBimpl_uses*
 //#UC END# *485792EE01CBimpl_uses*
;

end.

unit NOT_FINISHED_eeProcessor;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\NOT_FINISHED_eeProcessor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TeeProcessor" MUID: (4B13C45500E8)

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , evEditorWindowProcessor
;

type
 TeeProcessor = class(TevEditorWindowProcessor)
 end;//TeeProcessor
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *4B13C45500E8impl_uses*
 //#UC END# *4B13C45500E8impl_uses*
;
{$IfEnd} // Defined(Nemesis)

end.

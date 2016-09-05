unit nscTextSource;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscTextSource.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnscTextSource" MUID: (49512B040003)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , eeTextSource
;

type
 TnscTextSource = class(TeeTextSource)
 end;//TnscTextSource
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *49512B040003impl_uses*
 //#UC END# *49512B040003impl_uses*
;
{$IfEnd} // Defined(Nemesis)

end.

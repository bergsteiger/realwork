unit eeSubExport;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeSubExport.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TeeSubExport" MUID: (46834DC80065)

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , evSubImplementation
;

type
 TeeSubExport = class(TevSubImplementation)
 end;//TeeSubExport
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *46834DC80065impl_uses*
 //#UC END# *46834DC80065impl_uses*
;
{$IfEnd} // Defined(Nemesis)

end.

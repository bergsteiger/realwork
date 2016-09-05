unit csTaskedAction;
 {* Действие на сервере с возможностью помещения в очередь }

// Модуль: "w:\common\components\rtl\Garant\cs\csTaskedAction.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsTaskedAction" MUID: (5395CD170333)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csAction
;

type
 TcsTaskedAction = {abstract} class(TcsAction)
  {* Действие на сервере с возможностью помещения в очередь }
 end;//TcsTaskedAction
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *5395CD170333impl_uses*
 //#UC END# *5395CD170333impl_uses*
;
{$IfEnd} // NOT Defined(Nemesis)

end.

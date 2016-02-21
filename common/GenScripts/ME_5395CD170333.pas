unit csTaskedAction;
 {* Действие на сервере с возможностью помещения в очередь }

// Модуль: "w:\common\components\rtl\Garant\cs\csTaskedAction.pas"
// Стереотип: "SimpleClass"

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
;
{$IfEnd} // NOT Defined(Nemesis)

end.

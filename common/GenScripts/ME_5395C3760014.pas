unit csAction;
 {* Действие инициируемое клиентом и выполняемое на сервере }

// Модуль: "w:\common\components\rtl\Garant\cs\csAction.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , CsObject
;

type
 TcsAction = {abstract} class(TCsObject)
  {* Действие инициируемое клиентом и выполняемое на сервере }
 end;//TcsAction
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.

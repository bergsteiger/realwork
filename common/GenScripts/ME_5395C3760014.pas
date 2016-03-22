unit csAction;
 {* ƒействие инициируемое клиентом и выполн€емое на сервере }

// ћодуль: "w:\common\components\rtl\Garant\cs\csAction.pas"
// —тереотип: "SimpleClass"
// Ёлемент модели: "TcsAction" MUID: (5395C3760014)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , CsObject
;

type
 TcsAction = {abstract} class(TCsObject)
  {* ƒействие инициируемое клиентом и выполн€емое на сервере }
 end;//TcsAction
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.

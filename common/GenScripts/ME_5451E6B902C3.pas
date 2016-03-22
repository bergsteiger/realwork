unit ncsClientConnection;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsClientConnection.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsClientConnection" MUID: (5451E6B902C3)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsConnection
;

type
 TncsClientConnection = class(TncsConnection)
 end;//TncsClientConnection
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.

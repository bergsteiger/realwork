unit ncsServerConnection;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsServerConnection.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsServerConnection" MUID: (5451E6E20117)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsConnection
;

type
 TncsServerConnection = class(TncsConnection)
 end;//TncsServerConnection
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *5451E6E20117impl_uses*
 //#UC END# *5451E6E20117impl_uses*
;
{$IfEnd} // NOT Defined(Nemesis)

end.

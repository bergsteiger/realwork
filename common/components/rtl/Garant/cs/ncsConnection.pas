unit ncsConnection;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsConnection.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsConnection" MUID: (5451E68E0399)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
;

type
 TncsConnection = class(Tl3ProtoObject)
 end;//TncsConnection
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *5451E68E0399impl_uses*
 //#UC END# *5451E68E0399impl_uses*
;
{$IfEnd} // NOT Defined(Nemesis)

end.

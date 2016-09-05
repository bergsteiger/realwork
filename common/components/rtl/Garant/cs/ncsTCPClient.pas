unit ncsTCPClient;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsTCPClient.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ncsTCPClient" MUID: (545229E7037D)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , idTCPClient
;

type
 TncsTCPClient = TidTCPClient;
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *545229E7037Dimpl_uses*
 //#UC END# *545229E7037Dimpl_uses*
;
{$IfEnd} // NOT Defined(Nemesis)

end.

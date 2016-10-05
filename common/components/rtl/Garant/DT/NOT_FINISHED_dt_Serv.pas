unit NOT_FINISHED_dt_Serv;

// Модуль: "w:\common\components\rtl\Garant\DT\NOT_FINISHED_dt_Serv.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "dt_Serv" MUID: (5406A83E013E)

{$Include w:\common\components\rtl\Garant\DT\DtDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , dt_LinkServerService
 //#UC START# *5406A83E013Eimpl_uses*
 //#UC END# *5406A83E013Eimpl_uses*
;
{$IfEnd} // NOT Defined(Nemesis)

end.

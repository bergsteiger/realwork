unit NOT_FINISHED_csMessageManager;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_csMessageManager.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "csMessageManager" MUID: (52FB9F99018D)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3IntfUses
;

type
 TcsMessageManager = class
 end;//TcsMessageManager
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

implementation

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csMessageRecepientListPrim
 , csMessageRecepientList
;
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

end.

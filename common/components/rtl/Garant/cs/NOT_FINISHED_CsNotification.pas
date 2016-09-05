unit NOT_FINISHED_CsNotification;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_CsNotification.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "CsNotification" MUID: (52FB98CB008D)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , evdTaskTypes
;

type
 TCsNotificationType = evdTaskTypes.TCsNotificationType;
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *52FB98CB008Dimpl_uses*
 //#UC END# *52FB98CB008Dimpl_uses*
;
{$IfEnd} // NOT Defined(Nemesis)

end.

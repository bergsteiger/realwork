unit NOT_FINISHED_MailWin;

// Модуль: "w:\archi\source\projects\Archi\Dlg\NOT_FINISHED_MailWin.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "MailWin" MUID: (4F8FEB5201C5)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
;

type
 TSendMailWin = class
 end;//TSendMailWin
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 //#UC START# *4F8FEB5201C5impl_uses*
 //#UC END# *4F8FEB5201C5impl_uses*
;
{$IfEnd} // Defined(AppClientSide)

end.

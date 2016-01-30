unit NOT_FINISHED_MailWin;

// Модуль: "w:\archi\source\projects\Archi\Dlg\NOT_FINISHED_MailWin.pas"
// Стереотип: "UtilityPack"

{$Include arDefine.inc}

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
;
{$IfEnd} // Defined(AppClientSide)

end.

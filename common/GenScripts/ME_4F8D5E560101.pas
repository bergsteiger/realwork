unit NOT_FINISHED_SrchWin;

// Модуль: "w:\archi\source\projects\Archi\Dlg\NOT_FINISHED_SrchWin.pas"
// Стереотип: "UtilityPack"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
;

type
 TSearchWin = class
 end;//TSearchWin
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 , F_DocList
;
{$IfEnd} // Defined(AppClientSide)

end.

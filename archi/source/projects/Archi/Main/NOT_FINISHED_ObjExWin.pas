unit NOT_FINISHED_ObjExWin;

// Модуль: "w:\archi\source\projects\Archi\Main\NOT_FINISHED_ObjExWin.pas"
// Стереотип: "UtilityPack"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
;

type
 TObjectExplorerWin = class
 end;//TObjectExplorerWin
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(AppClientSide)

end.

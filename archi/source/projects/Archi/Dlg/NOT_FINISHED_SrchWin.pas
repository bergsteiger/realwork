unit NOT_FINISHED_SrchWin;

// Модуль: "w:\archi\source\projects\Archi\Dlg\NOT_FINISHED_SrchWin.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "SrchWin" MUID: (4F8D5E560101)

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
 //#UC START# *4F8D5E560101impl_uses*
 //#UC END# *4F8D5E560101impl_uses*
;
{$IfEnd} // Defined(AppClientSide)

end.

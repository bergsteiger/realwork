unit NOT_FINISHED_tb97vt;

// Модуль: "w:\common\components\rtl\external\tb97\NOT_FINISHED_tb97vt.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "tb97vt" MUID: (52AB1AC403E7)

{$Include w:\common\components\rtl\external\tb97\TB97VER.INC}

interface

{$If NOT Defined(NoTB97)}
uses
 l3IntfUses
;

const
 CM_TBMOUSEQUERY = WM_USER + 12345;
 CM_TBCHECKCONTROL = CB_TBMOUSEQUERY + 1;
{$IfEnd} // NOT Defined(NoTB97)

implementation

{$If NOT Defined(NoTB97)}
uses
 l3ImplUses
 //#UC START# *52AB1AC403E7impl_uses*
 //#UC END# *52AB1AC403E7impl_uses*
;
{$IfEnd} // NOT Defined(NoTB97)

end.

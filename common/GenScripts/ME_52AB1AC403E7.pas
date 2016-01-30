unit NOT_FINISHED_tb97vt;

// Модуль: "w:\common\components\rtl\external\tb97\NOT_FINISHED_tb97vt.pas"
// Стереотип: "UtilityPack"

{$Include TB97VER.INC}

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
;
{$IfEnd} // NOT Defined(NoTB97)

end.

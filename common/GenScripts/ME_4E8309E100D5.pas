unit NOT_FINISHED_IniShop;

// ������: "w:\archi\source\projects\Archi\Main\NOT_FINISHED_IniShop.pas"
// ���������: "UtilityPack"

{$Include arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
;

type
 TIniRecord = object
 end;//TIniRecord
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(AppClientSide)

end.

unit NOT_FINISHED_HT_Const;

// ������: "w:\common\components\rtl\Garant\DT\NOT_FINISHED_HT_Const.pas"
// ���������: "UtilityPack"
// ������� ������: "HT_Const" MUID: (5553320F016B)

{$Include w:\common\components\rtl\Garant\DT\DtDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
;

type
 LPOPEL = ^OPEL;

 SAB = record
 end;//SAB

 ThtTblHandle = ;

 OPEL = record
 end;//OPEL
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *5553320F016Bimpl_uses*
 //#UC END# *5553320F016Bimpl_uses*
;
{$IfEnd} // NOT Defined(Nemesis)

end.

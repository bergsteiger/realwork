unit NOT_FINISHED_RubricatorRes;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Rubricator\NOT_FINISHED_RubricatorRes.pas"
// ���������: "UtilityPack"
// ������� ������: "RubricatorRes" MUID: (4AA790E300D4)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Classes
;

type
 TnsRubricatorRes = class(TDataModule)
 end;//TnsRubricatorRes
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

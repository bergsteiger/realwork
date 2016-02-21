unit NOT_FINISHED_ListRes;
 {* Ресурсы списка. }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\List\NOT_FINISHED_ListRes.pas"
// Стереотип: "UtilityPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Classes
;

type
 TnsListRes = class(TDataModule)
  {* Ресурсы списка. }
 end;//TnsListRes
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

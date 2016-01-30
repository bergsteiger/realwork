unit NOT_FINISHED_DictionRes;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\NOT_FINISHED_DictionRes.pas"
// Стереотип: "UtilityPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Classes
;

type
 TnsDictRes = class(TDataModule)
 end;//TnsDictRes
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

unit moDiction;
 {* Толковый словарь }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moDiction.pas"
// Стереотип: "VCMUseCaseRealization"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Diction_Module
;

type
 Tmo_Diction = {final} class(TDictionModule)
  {* Толковый словарь }
 end;//Tmo_Diction
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

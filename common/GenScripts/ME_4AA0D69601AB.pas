unit moInpharm;
 {* Инфарм }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moInpharm.pas"
// Стереотип: "VCMUseCaseRealization"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Inpharm_Module
;

type
 Tmo_Inpharm = {final} class(TInpharmModule)
  {* Инфарм }
 end;//Tmo_Inpharm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

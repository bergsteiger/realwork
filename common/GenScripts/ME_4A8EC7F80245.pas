unit moCommon;
 {* Окна }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moCommon.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "Common" MUID: (4A8EC7F80245)
// Имя типа: "Tmo_Common"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimF1Common_Module
;

type
 Tmo_Common = {final} class(TPrimF1CommonModule)
  {* Окна }
 end;//Tmo_Common
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsDataExchangeRealization
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.

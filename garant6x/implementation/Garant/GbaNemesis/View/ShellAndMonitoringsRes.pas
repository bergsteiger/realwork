unit ShellAndMonitoringsRes;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ShellAndMonitoringsRes.pas"
// Стереотип: "VCMApplication"
// Элемент модели: "ShellAndMonitorings" MUID: (4AAA42BF0267)
// Имя типа: "TShellAndMonitoringsRes"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimF1Res
;

type
 TShellAndMonitoringsRes = {abstract} class(TPrimF1Res)
 end;//TShellAndMonitoringsRes
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , moCommonSearch
 , tasSaveLoadRealization
 , ShellAndMonitoringsMain_Form
;
{$IfEnd} // NOT Defined(Admin)

end.

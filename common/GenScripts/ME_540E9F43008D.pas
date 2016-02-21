unit nsHAFPainterWithoutSettings;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\nsHAFPainterWithoutSettings.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , nsHAFPainterPrim
;

type
 TnsHAFPainterWithoutSettings = class(TnsHAFPainterPrim)
 end;//TnsHAFPainterWithoutSettings
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin)

end.

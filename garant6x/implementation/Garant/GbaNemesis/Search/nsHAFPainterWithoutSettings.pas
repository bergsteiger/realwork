unit nsHAFPainterWithoutSettings;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Search\nsHAFPainterWithoutSettings.pas"
// ���������: "SimpleClass"
// ������� ������: "TnsHAFPainterWithoutSettings" MUID: (540E9F43008D)

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

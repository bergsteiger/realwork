unit ncsServerConnection;

// ������: "w:\common\components\rtl\Garant\cs\ncsServerConnection.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsConnection
;

type
 TncsServerConnection = class(TncsConnection)
 end;//TncsServerConnection
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.

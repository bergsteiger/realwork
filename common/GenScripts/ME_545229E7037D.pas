unit ncsTCPClient;

// ������: "w:\common\components\rtl\Garant\cs\ncsTCPClient.pas"
// ���������: "UtilityPack"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , idTCPClient
;

type
 TncsTCPClient = TidTCPClient;
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.

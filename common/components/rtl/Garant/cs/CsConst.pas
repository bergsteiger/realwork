unit CsConst;

// ������: "w:\common\components\rtl\Garant\cs\CsConst.pas"
// ���������: "UtilityPack"
// ������� ������: "CsConst" MUID: (538DA49902A4)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , daInterfaces
 //#UC START# *538DA49902A4intf_uses*
 //#UC END# *538DA49902A4intf_uses*
;

const
 c_CsVersion = 26;
 c_AllStations = '*';
  {* ����� ��� ������������� }
 c_WrongClientId = daInterfaces.usWrongClient;
  {* ������� �� ������ � ����������� }
 c_DuplicateClient = daInterfaces.usDuplicateClient;
  {* ������� ����� �������� }
 c_DeadClient = daInterfaces.usDeadClient;
  {* �� �������� �� ������� }
 {* ���� ������ ��������� �������� }
 cs_errOk = 0;
 cs_errError = 1;
 cs_errConnClosedGracefully = 2;
 cs_errConnectTimeout = 3;
 cs_errSocketError = 4;
 cs_errConnAborted = 5;
 cs_errConnRefused = 6;
 cs_errWrongServerVersion = 7;
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *538DA49902A4impl_uses*
 //#UC END# *538DA49902A4impl_uses*
;
{$IfEnd} // NOT Defined(Nemesis)

end.

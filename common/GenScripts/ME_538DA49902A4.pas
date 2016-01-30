unit CsConst;

// ������: "w:\common\components\rtl\Garant\cs\CsConst.pas"
// ���������: "UtilityPack"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , daInterfaces
;

const
 c_CsVersion = 25;
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
;
{$IfEnd} // NOT Defined(Nemesis)

end.

unit CsConst;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/CsConst.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::cs::Core::CsConst
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  daInterfaces
  ;

const
  { cProtocolVersion }
 c_CsVersion = 25;

const
  { cPredefinedClients }
 c_AllStations = '*';
  { ����� ��� ������������� }
 c_WrongClientId = daInterfaces.usWrongClient;
  { ������� �� ������ � ����������� }
 c_DuplicateClient = daInterfaces.usDuplicateClient;
  { ������� ����� �������� }
 c_DeadClient = daInterfaces.usDeadClient;
  { �� �������� �� ������� }

const
  { ���� ������ ��������� �������� }
 cs_errOk = 0;
 cs_errError = 1;
 cs_errConnClosedGracefully = 2;
 cs_errConnectTimeout = 3;
 cs_errSocketError = 4;
 cs_errConnAborted = 5;
 cs_errConnRefused = 6;
 cs_errWrongServerVersion = 7;
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
{$IfEnd} //not Nemesis
end.
unit NOT_FINISHED_csNonEditableDictsRequest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/NOT_FINISHED_csNonEditableDictsRequest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::cs::Tasks::csNonEditableDictsRequest
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  csRequestTask
  ;

{$If defined(RemoteDict) AND not defined(Nemesis)}
type
 TddNonEditableDictsRequest = class(TddRequestTask)
 end;//TddNonEditableDictsRequest
{$IfEnd} //RemoteDict AND not Nemesis
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
{$IfEnd} //not Nemesis
end.
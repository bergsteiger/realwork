unit NOT_FINISHED_csTaskRequest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/NOT_FINISHED_csTaskRequest.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::cs::Tasks::csTaskRequest
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
  ddTaskResultRequestPrim,
  ddGetTaskRequestPrim
  ;

type
 TddGetTaskRequest = class(TddGetTaskRequestPrim)
 end;//TddGetTaskRequest

 TddTaskResultRequest = class(TddTaskResultRequestPrim)
 end;//TddTaskResultRequest
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
{$IfEnd} //not Nemesis
end.
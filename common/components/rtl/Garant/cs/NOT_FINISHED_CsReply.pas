unit NOT_FINISHED_CsReply;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/NOT_FINISHED_CsReply.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ServerSide::TCsReply
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\cs\CsDefine.inc}

interface

{$If defined(AppServerSide) AND not defined(Nemesis)}
type
 TCsReply = class
 end;//TCsReply
{$IfEnd} //AppServerSide AND not Nemesis

implementation

{$If defined(AppServerSide) AND not defined(Nemesis)}
uses
  CsReplyTool
  ;
{$IfEnd} //AppServerSide AND not Nemesis

{$If defined(AppServerSide) AND not defined(Nemesis)}


{$IfEnd} //AppServerSide AND not Nemesis
end.